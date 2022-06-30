Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B3C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiF3VTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiF3VTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC144578A
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s1so363315wra.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IxXdnnILFC293cKAlC+v8xsq2xhaWnv83MwgPd/7bsI=;
        b=Mj7+lt/njNNiM0eA9FsITiCf+W3uzbOR/hs9+R51DJem2PcFrhYFTkfGzIySQ798DK
         cm4kQmmSjhsh97AEaKqvyGC1mekXjdhLT0Bu5o24Lm1Jwumcsxf5Iy3+XzdLPBsmmQwS
         A0uQNK6OxLrUn5B8HOiiLZ/LxaghstM2xpGO+heQuCHmuLaXuW3ppxmc7KX/gwIcsTk9
         HOJuSDLUQXVB8XzfEeZojEbYe9UtFpuqI/KcvPhbJZnG8+eQqZ469DHFQ4IWx9Rpd5O0
         NW+tdWwgHwAIZ4U/6Bd59jxcW8Fy0q0Ho89eOczDa9+CfLdR91qxOL1GbESAKa+84F03
         FXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IxXdnnILFC293cKAlC+v8xsq2xhaWnv83MwgPd/7bsI=;
        b=fesrakUoa4t2XCa0nmqcO6qZVJtFt1X0vNzpSj102kPPwwLBx67QaxzTdaVof3kH57
         ZbvOzcUQp1fN5Dj/kKrxkxLqKHN/G5F5xFGax+9Pj9dtca7d2P1BBdeAAiD6AenXx+0b
         v+QkGw5r+u7j3cGUH1aYRV5eTresKuAcQaMun4Oy7arnu3yfC8r+OJXfOb34LZalXf9R
         RlitmapdfY08XTx3oa8x6SNby1CMoeGFHCcX3+Wt+K/AxyI3IICWZjivMuBPgTcTIXTo
         xCQOrvDRz7eDylXoz2h0hvESDmniYQWuqIMppZFHkKOsYdv9i545MdzbSC8MHO6yuvET
         B3QQ==
X-Gm-Message-State: AJIora+CNt6RtJaH/znGSPd2OP3wAEeqCVKdIXuNQ9cVMLxSdt5J6Exd
        mZeMRmEwI/Usk9QH/80NOs7U8N6/gCU=
X-Google-Smtp-Source: AGRyM1uzNizanAX35vrLvYAmHIIZQkHgBULH+cSv7VidSubq5psXg8uqJuE0AlFe84iQjPlxt4jtaA==
X-Received: by 2002:a5d:69d2:0:b0:21b:8e3f:8557 with SMTP id s18-20020a5d69d2000000b0021b8e3f8557mr10339597wrw.422.1656623984856;
        Thu, 30 Jun 2022 14:19:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020adfcf06000000b0021a34023ca3sm20001029wrj.62.2022.06.30.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:44 -0700 (PDT)
Message-Id: <da3aae9e8476af3b23363d39dba86b679c14a498.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:24 +0000
Subject: [PATCH v2 04/18] git-submodule.sh: remove unused top-level "--branch"
 argument
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

In 5c08dbbdf1a (git-submodule: fix subcommand parser, 2008-01-15) the
"--branch" option was supported as an option to "git submodule"
itself, i.e. "git submodule --branch" as a side-effect of its
implementation.

Then in b57e8119e6e (submodule: teach set-branch subcommand,
2019-02-08) when the "set-branch" subcommand was added the assertion
that we shouldn't have "--branch" anywhere except as an argument to
"add" and "set-branch" was copy/pasted from the adjacent check for
"--cache" added (or rather modified) in 496eeeb19b9 (git-submodule.sh:
avoid "test <cond> -a/-o <cond>", 2014-06-10).

But there's been a logic error in that check, which at a glance looked
like it should be supporting:

    git submodule --branch <branch> (add | set-branch) [<options>]

But due to "||" in the condition (as opposed to "&&" for "--cache") if
we have "--branch" here already we'll emit usage, even for "add" and
"set-branch".

So in addition to never having documented this form, it hasn't worked
since b57e8119e6e was released with v2.22.0.

So it's safe to remove this code. I.e. we don't want to support the
form noted above, but only:

    git submodule (add | set-branch) --branch <branch> [<options>]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b99a00d9f84..20fc1b620fa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -574,14 +574,6 @@ do
 	-q|--quiet)
 		GIT_QUIET=1
 		;;
-	-b|--branch)
-		case "$2" in
-		'')
-			usage
-			;;
-		esac
-		branch="$2"; shift
-		;;
 	--cached)
 		cached=1
 		;;
@@ -609,12 +601,6 @@ then
     fi
 fi
 
-# "-b branch" is accepted only by "add" and "set-branch"
-if test -n "$branch" && (test "$command" != add || test "$command" != set-branch)
-then
-	usage
-fi
-
 # "--cached" is accepted only by "status" and "summary"
 if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
-- 
gitgitgadget

