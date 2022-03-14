Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E5EC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiCNG6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiCNG6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:58:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECD3FBCB
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:57:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bc27so12939122pgb.4
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVLm6K4z1zBMiBf4e2dqQxxRAWwaetncPOZjD9iSX3k=;
        b=S9lBfsDrfmNwUrpyNXUPT8QP7Ua/l1+umt9vnzbaZLFjvazmZJta0AIaC87BDqHv/Z
         pAkQ8OG7kgR7vOZii1OvJpkl2ptU08+TerIXKQ6SuSK3NFY241YFe7zuvxwgNGrnJwXt
         85lLRLtUGhIdE3kKaYTCv65cewv9RHCliKjN6BK6J+mxkFkgujR3yafqRgqvthi5F0rd
         DS1VXFkhYZ4FcQTO5D4YuQnTYLwvo/btuUlttdKoD4TCAJAM++m4tCigMGVCmQlOY3hH
         0MLRsnq5Ix3Lk7WgoGclPzp2b7g4X7VQvZ/J4YfMrOEEvAju+Yr0M/RalUSsHN1pLubS
         uu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVLm6K4z1zBMiBf4e2dqQxxRAWwaetncPOZjD9iSX3k=;
        b=EJWgTOFQhTr+Vh+b7O6JcH+AUALeOIFtsA1/3dGtOxxOHN38/0nUC8RYn6nDGBLVzt
         cVt+9q88xzqJgAyqdk8DnmglciQJveuLyZjNkdRETbbp2pThgIZShUJuy9y8Akz48a1M
         8gdAfz44PvxFLZjap/ibRzGhM5awLaSV4uaMuMAY+UBE8aULuNNicH76t6Mhr7ie0GU1
         XqTR9xa78WaSKm1B2+k/ma/kKHDN7DFbuWXzZksob+9TQMRKlkkrRbdqd638U7l3lNAA
         AL17gRA2xMNx5n1jVvKozsMlWhTPkBj5W1VRgUOT0w8+NhCopW7vcNCzt+9VP+5PZc4H
         8r/g==
X-Gm-Message-State: AOAM532i+f23iGA8N+Mw+shxtzQYfPa3dbf8+BIgFeYaxRW9CySpBJ+3
        GSg9CfXE4wie22fcilueJUckXfeRs4zg4Q==
X-Google-Smtp-Source: ABdhPJyred4qWHl7xTazE53b1PZV9lxBAzHRr2mhJaewXss1ENgjt19/Z/B/7xZULciP/dP657F8gw==
X-Received: by 2002:a62:1a43:0:b0:4f6:ce73:d572 with SMTP id a64-20020a621a43000000b004f6ce73d572mr22540357pfa.69.1647241029838;
        Sun, 13 Mar 2022 23:57:09 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.242])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm16761332pjb.27.2022.03.13.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:57:09 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     derrickstolee@github.com
Cc:     bagasdotme@gmail.com, git@vger.kernel.org, newren@gmail.com,
        vdye@github.com, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v3 0/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Mon, 14 Mar 2022 14:56:58 +0800
Message-Id: <20220314065659.82029-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Updates Log ==

Changes since v2:

 * correct Derrick's name in the single-patch (I really missed it XD)
 * rebase on Elijah's v2 [1]
 * move OPTIONS to after COMMANDS
 * add two sub-sections under option '--[no-]cone', one for command 'set' and
one for command 'reapply'
 * change the command indicators from this style:

  Use with ['set'|'reapply'].

  to this style:

  Use with the `set` and `reapply` commands.

== Overview ==

Add an OPTIONS section to the manual and move the descriptions/explanations for 
these options from below COMMANDS to OPTIONS. 

[1] https://lore.kernel.org/git/pull.1148.v2.git.1647054681.gitgitgadget@gmail.com/#r

Shaoxuan Yuan (1):
  Documentation/git-sparse-checkout.txt: add an OPTIONS section

 Documentation/git-sparse-checkout.txt | 106 +++++++++++++++-----------
 1 file changed, 63 insertions(+), 43 deletions(-)


base-commit: 4b89a3392b04acccf28f09f90e26715140461373
-- 
2.35.1

