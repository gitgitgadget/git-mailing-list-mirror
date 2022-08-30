Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC72ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiH3Jb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH3Jbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:31:51 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439AA1A57
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:48 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11eab59db71so11495346fac.11
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Q1vuPeCXqBCRUSIrTfPdNtLcw7RAAJ2ArRVWRD/b/9g=;
        b=gJjj/5X19DkBkNnhsxxflKT8veFTMms4Qv+b5sIDxp0GnU7R+rHkTPvmrP22ML5iLm
         uYDA35cd1yeQzNF3q3EEP50K4oGeSrzH0+cMiFFuhUikxF1R+SH+ttR2iY7TRJ0h+fj9
         NnnTRU6duo6JL9K93K0A+iquPYVT2uEhB6608CgNg7KFtkbFdzWhERjLpZjl0ezOeu7z
         oD+iGaKeVcNOHUXtqH4tGDigEVN592M2zSPLnZMB/+6NV7FZ/Nnsmzqrnc7Ewl6CgtUJ
         9PvhvyxcQwXB9uuiYFNqg6BAdJxNKZmX45KJBbdxo/IZ7XV7Q8RUoiKb+Icipne/9Pui
         Vryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Q1vuPeCXqBCRUSIrTfPdNtLcw7RAAJ2ArRVWRD/b/9g=;
        b=s9ihmssGP+uB7KNK7vRr0R/rEDPp95Qy38k8J6Sb8Z/wLxXiABMvEMeq+cThIYTFoJ
         NrMThQ8k+VCvf4siRzwDPmI4aMu6w5HOgzG88iX2rZvAa/MuF9ECUMuF09D+eAIg5Ivd
         OcuptVU4oPoj4tuDJPj59MsrA+ndlFwXyK+QW0ab1Ulcp1CVR/hX5tASy05ehnqfObEI
         KeDSKviAwbWKXhO+/Vsea1eWTZcgUeCXaiGxHhDj7tERT66UX9/pMDCmz4sjQ8YI2ww7
         zcX0A9Nh38riI0REdxrNF1vJ0nKzniBN3iLQq8MUM7VXUIPRzcCKgXLVI/fA4Xw8BSFv
         YBvA==
X-Gm-Message-State: ACgBeo2tM54gHtes1fs8Px/hPaxsS58YygglprOLpgQgpRqGJB0jTtlW
        IMnJKp+GJX4pP0a4gMObmiR50jmPJys=
X-Google-Smtp-Source: AA6agR5lFQX/T3/mFuIdavVUeu0TCTj45FO3v+xWNPJi0IvgodZ9cadndhASrvydKkOzOsXWwiCbVg==
X-Received: by 2002:a05:6870:e245:b0:11d:74a4:4fc6 with SMTP id d5-20020a056870e24500b0011d74a44fc6mr9779427oac.156.1661851907115;
        Tue, 30 Aug 2022 02:31:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 2-20020aca2802000000b0034378294973sm5783745oix.30.2022.08.30.02.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/51] completion: bash: trivial cleanup
Date:   Tue, 30 Aug 2022 04:30:51 -0500
Message-Id: <20220830093138.1581538-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ba5c395d2d..2df51ed946 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3545,8 +3545,7 @@ fi
 
 __git_func_wrap ()
 {
-	local cur words cword prev
-	local __git_cmd_idx=0
+	local cur words cword prev __git_cmd_idx=0
 	_get_comp_words_by_ref -n =: cur words cword prev
 	$1
 }
-- 
2.37.2.351.g9bf691b78c.dirty

