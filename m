Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF95C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiGTS4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiGTSze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:55:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940D4CE36
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:55:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d16so27386192wrv.10
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cxQPXHaum4OPdBghPvl/rb3JP60IX17OgerHq5TVHHg=;
        b=EW1BJbmHzKNJaVVo2pab0kvT9HzE8MSypZK2qXymzmzmv0pjT0fChmhcHxSasKzB1T
         d1Yru5qmEuKJnYKTWo0Cbab9FBy2fFshU9DI+UdoNRyOeBTZNB+ma+t47drvtAmQT2S6
         3CxnxsbLAQJ7UGpSR9au3WW69Rkt0zIbXlHdBJeeVwIoX813OhVBsn+tBKJSmlX0SQwk
         /lTiaSw4g3T60MXqGuwsNK5QjwxFgNeiDdK1X5TSkhws5ghPt1dX9BTz1Zygrch76kf0
         UIwu1QgBVqkNQFzWOiXXR41owd4tEA1rGx4cBWKhHCPlHZnzMzlDF1Di0HK38LyGzR2U
         AoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cxQPXHaum4OPdBghPvl/rb3JP60IX17OgerHq5TVHHg=;
        b=xlqg49eQxhKOI8zHJXgj/2MvGT0eHmBEnNR4bAy4/8k+OryACoNVN81muQ9F61SW0s
         izVBikvd2u29mjP/9Dp75p7n4RMSKgaU5+3Eu2jprzMnqVgK/eUiXtwY0S5zEt/pzYjr
         VjnUDWNmOu2DStwy5z4BK1/0ocO20GXy96IDJrIX5XE4QUDgE0QtIPgXKFDUIEnWqcRC
         YeLu6eZnZk4sI8SbDUYBXxH3QTLws5wrkdPoDPmqFnGyYHlSY0Dza07KCtSw/eiZk1sE
         KuSjt/9C3Pi/bam1KEOE+t56AQBdQzl+MvkOomy72FvhiS2rR19mojnUungDQ9HhaQvj
         lpMA==
X-Gm-Message-State: AJIora++HPUAKyj3Yt/jrP2cbXUYRM2WwYvismvurKN226Tky0t4QbBi
        M9tG/dSH3aqia8+2f6Kt2yDCVpf5L7I=
X-Google-Smtp-Source: AGRyM1vvUX4HGl++EI9vG2d7Gt8rpacHJikVq5rlsz6DxS6AIAxqRr3cDrsEtKYJADSyOAoJgbJ9FA==
X-Received: by 2002:a5d:4750:0:b0:21e:375:2825 with SMTP id o16-20020a5d4750000000b0021e03752825mr16543147wrs.42.1658343331863;
        Wed, 20 Jul 2022 11:55:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003a310fe1d75sm4012231wmq.38.2022.07.20.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:55:31 -0700 (PDT)
Message-Id: <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com>
In-Reply-To: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:55:28 +0000
Subject: [PATCH v2 0/2] git-p4: fix two undefined variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Moritz Baumann (2):
  git-p4: fix typo in P4Submit.applyCommit()
  git-p4: fix error handling in P4Unshelve.renameBranch()

 git-p4.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)


base-commit: bbea4dcf42b28eb7ce64a6306cdde875ae5d09ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1297%2Fmbs-c%2Ffix-undefined-variables-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1297/mbs-c/fix-undefined-variables-v2
Pull-Request: https://github.com/git/git/pull/1297

Range-diff vs v1:

 1:  1484eee8961 = 1:  1484eee8961 git-p4: fix typo in P4Submit.applyCommit()
 2:  69c9fd5fbec ! 2:  f7566dd5fc3 git-p4: fix error handling in P4Unshelve.renameBranch()
     @@ Metadata
       ## Commit message ##
          git-p4: fix error handling in P4Unshelve.renameBranch()
      
     -    The error handling code referenced a variable that does not exist.
     -    Also, the condition could never evaluate to True.
     +    The error handling code path is meant to be triggered when the loop does
     +    not exit early via "break". This fails, as the boolean variable "found",
     +    which is used to track whether the loop was exited early, is initialized
     +    incorrectly.
     +
     +    It would be possible to fix this issue by correcting the initialization,
     +    but Python supports a for:-else: control flow construct for this exact
     +    use case (executing code if a loop does not exit early), so it is more
     +    idiomatic to remove the tracking variable entirely.
     +
     +    In addition, the error message no longer refers to a variable that does
     +    not exist.
      
          Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
      

-- 
gitgitgadget
