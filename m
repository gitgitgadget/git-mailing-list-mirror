Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE3C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 08:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiG0ICO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 04:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiG0ICN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 04:02:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4E422E8
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 01:02:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i8so120262wro.11
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=06dYeA+AUK5IvG/ssfR6lHyScZ9Qh2v+kcfN2bqd8DQ=;
        b=pTOizEy4mn5YpIONtD9qrUs4lVjq7xYX8ut8HGIOkQWebnUkJv2l+IQXVpVoAyNQ36
         NFXPxeJ3oqMUZwucsmEtc8J0+Dsh5d9lVdc+p4P9Gtfi3G32mt+7W/jTJK//N21D05dJ
         iImT9UncAAlFhQuVHTm/LQyI0+Dk369RtL6kfbCGVZS1ZF6G7VlwmRzPkEajZlxMCtXN
         sfH1CK8JaGgUq09OGDAck2gJXhMBoQ7I9VBE/e+aXAutwFAV6LMjR9rEJF/KhQcrt4YB
         qG1WNpBv6dIblo9DVQWPU9Xy8e/8+M+mu7Y9Mscnnohva3I8+IpIL29QFie2FzckLhY9
         uoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=06dYeA+AUK5IvG/ssfR6lHyScZ9Qh2v+kcfN2bqd8DQ=;
        b=ZTdDKZnpGzRM1bAQw24+K6B5hOBVKnIbjPYGQcg8kPwgeCQQ0p4qGHU/K6ePjPczsB
         8j2sW74Vz5yzm1OVIS/PicyOIJT9ikEmmh+MedTGg7bMtU1OkKkr+mqxkUEM5J/1JrCl
         55lqJTrTcmdnb9pwB3JkhoqaG4/gv0d4WvbBNSeWp2vvjwb5CcvVTcbQh6LQkmLBSny5
         QRXVcrePokILhTybCOUu3mgxeEACVxuSMD0OhZoV3QF5I77hSDCAVuqvFUnCEd+m5aTh
         fYOYd2uoT8wfvnEQsC6UlmOgtYCMOyVs6ysvKLt6bGXOTeqNJES9Tst0E+TExTXLL7Ns
         Hk4w==
X-Gm-Message-State: AJIora9FFutVhntpYTcJPLdYRWooM22IObPgI2dduZ3/OVbUWCTRDRqE
        0GMGM6LL871psk5iznhDaIxtEN1+QsQ=
X-Google-Smtp-Source: AGRyM1ssqlTMew8cC9/vocvPhFU2h3umMsgtwaAQK62vH4FVO+WD/SD2OGkuRtYgWPIh8lp1JQghHQ==
X-Received: by 2002:adf:d1eb:0:b0:21e:5545:9ac9 with SMTP id g11-20020adfd1eb000000b0021e55459ac9mr13357941wrd.458.1658908928869;
        Wed, 27 Jul 2022 01:02:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003a2d6f26babsm1592974wms.3.2022.07.27.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 01:02:08 -0700 (PDT)
Message-Id: <pull.1298.git.1658908927714.gitgitgadget@gmail.com>
From:   "Jay Berry via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jul 2022 08:02:07 +0000
Subject: [PATCH] Use 'Everything up to date.' instead of 'Everything
 up-to-date'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jay Berry <jb2170@selfadjointoperator.com>,
        Jay Berry <jb2170@selfadjointoperator.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jay Berry <jb2170@selfadjointoperator.com>

There are two hard-coded
`fprintf(stderr, "Everything up-to-date\n")`
which I have changed to
`fprintf(stderr, "Everything up to date.\n")`
since most other strings used localised versions of `up to date.`

Before (stupidly inconsistent):
```
$ git pull
Already up to date.
$ git push
Everything up-to-date
```
After (consistent):
```
$ git pull
Already up to date.
$ git push
Everything up to date.
```
Signed-off-by: Jay Berry <jb2170@selfadjointoperator.com>
---
    Use 'Everything up to date.' instead of 'Everything up-to-date'
    
    There are two hard-coded fprintf(stderr, "Everything up-to-date\n")
    which I have changed to fprintf(stderr, "Everything up to date.\n")
    since most other strings used localised versions of up to date.
    
    Before (stupidly inconsistent):
    
    $ git pull
    Already up to date.
    $ git push
    Everything up-to-date
    
    
    After (consistent):
    
    $ git pull
    Already up to date.
    $ git push
    Everything up to date.
    
    
    Signed-off-by: Jay Berry jb2170@selfadjointoperator.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1298%2FSelfAdjointOperator%2Fup-to-date-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1298/SelfAdjointOperator/up-to-date-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1298

 builtin/send-pack.c | 2 +-
 transport.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 64962be0168..cb3c6ff8300 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -338,7 +338,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!ret && !transport_refs_pushed(remote_refs))
-		fprintf(stderr, "Everything up-to-date\n");
+		fprintf(stderr, "Everything up to date.\n");
 
 	return ret;
 }
diff --git a/transport.c b/transport.c
index 52db7a3cb09..c40d15647ff 100644
--- a/transport.c
+++ b/transport.c
@@ -1416,7 +1416,7 @@ int transport_push(struct repository *r,
 	if (porcelain && !push_ret)
 		puts("Done");
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
-		fprintf(stderr, "Everything up-to-date\n");
+		fprintf(stderr, "Everything up to date.\n");
 
 done:
 	free_refs(local_refs);

base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
-- 
gitgitgadget
