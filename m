Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE3C2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdCRCFk (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32771 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdCRCFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so3350096pgf.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRXlczEJ4qVIolK7Resi61NABf8uAWkgAhHBkZE9uOo=;
        b=eBWIPfbWKc7Yib/KGcYwjwvoT9ld0P9b3vu/vs2qgHbfgD8uJXEXVQBziLob5GhpU0
         dmtUBsXRWp452RvN1ImeqdzYJvSZkg+9j2TJ7RTSiNflZ1r+xK5PiFOUzj3lV7Y11G8/
         TpaUxYYd+olBTrIMcooxc1fFU0z+JNSE3yVsjSftKMkt8Ml4JkFll9peZLKjY/Ngh1i3
         faj+G+uj9oI0+LBae685aN2zbCTTuH8zoKSS5jimSPXddrZsAwVxRpNt2WbLhiRVRgz3
         FxRTS6jC+iLlemMiSp4AXzM1GSXIXrdIjaT768XKCTmyrWGcJfaQpZm7Dpapiz1lbPJL
         LG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRXlczEJ4qVIolK7Resi61NABf8uAWkgAhHBkZE9uOo=;
        b=DcxmFIZvDJG5uT9BrGgF5gQVNXKLJxDKDV7eHEL8+vamq45edfchtzdeZLqOuQBHDu
         /SgZogW1ASX7sdMU+xIF9PnCYMI9Bna9OuXqEcIDQtLmql5smSl3Ndxlo0PVQ+EW/JhY
         zcrYUT65KSC1jSWPqF1krP8vI5Otd3/P65yp0DgBILhoxi1uVFthD4gl/w8FAEyoeoDJ
         UTp2Bbh2x1xeFF/55pOf8MjFHAD6wZUav2zppkjrQzo+vIveErMPlhtmGovK9wS+qrhj
         6uWWzuRD6MstoZiJMRbjUCUY9K1OgJOHt37+JVdluewYPrjEMoV3vVs1oy4VTfxcPv4u
         mOGQ==
X-Gm-Message-State: AFeK/H0ePdaRfo4/mK7gdrwWeCcXmqcaKSNsHu1/vHQ3dp7fGJYfk93T/8K4DRaCC1MRlQ==
X-Received: by 10.98.202.80 with SMTP id n77mr19818376pfg.167.1489802704472;
        Fri, 17 Mar 2017 19:05:04 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id d10sm19143228pfl.59.2017.03.17.19.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 10/27] files-backend: remove the use of git_path()
Date:   Sat, 18 Mar 2017 09:03:20 +0700
Message-Id: <20170318020337.22767-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given $GIT_DIR and $GIT_COMMON_DIR, files-backend is now in charge of
deciding what goes where (*). The end goal is to pass $GIT_DIR only. A
refs "view" of a linked worktree is a logical ref store that combines
two files backends together.

(*) Not entirely true since strbuf_git_path_submodule() still does path
translation underneath. But that's for another patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1a13fb5e2b..43d8ddac93 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -923,7 +923,8 @@ struct files_ref_store {
 	 * store:
 	 */
 	const char *submodule;
-
+	char *gitdir;
+	char *gitcommondir;
 	char *packed_refs_path;
 
 	struct ref_entry *loose;
@@ -985,6 +986,8 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct strbuf sb = STRBUF_INIT;
+	const char *gitdir = get_git_dir();
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
@@ -995,7 +998,11 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 		return ref_store;
 	}
 
-	refs->packed_refs_path = git_pathdup("packed-refs");
+	refs->gitdir = xstrdup(gitdir);
+	get_common_dir_noenv(&sb, gitdir);
+	refs->gitcommondir = strbuf_detach(&sb, NULL);
+	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
+	refs->packed_refs_path = strbuf_detach(&sb, NULL);
 
 	return ref_store;
 }
@@ -1173,11 +1180,26 @@ static void files_reflog_path(struct files_ref_store *refs,
 			      const char *refname)
 {
 	if (!refname) {
-		strbuf_git_path(sb, "logs");
+		/*
+		 * FIXME: of course this is wrong in multi worktree
+		 * setting. To be fixed real soon.
+		 */
+		strbuf_addf(sb, "%s/logs", refs->gitcommondir);
 		return;
 	}
 
-	strbuf_git_path(sb, "logs/%s", refname);
+	switch (ref_type(refname)) {
+	case REF_TYPE_PER_WORKTREE:
+	case REF_TYPE_PSEUDOREF:
+		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
+		break;
+	case REF_TYPE_NORMAL:
+		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
+		break;
+	default:
+		die("BUG: unknown ref type %d of ref %s",
+		    ref_type(refname), refname);
+	}
 }
 
 static void files_refname_path(struct files_ref_store *refs,
@@ -1189,7 +1211,18 @@ static void files_refname_path(struct files_ref_store *refs,
 		return;
 	}
 
-	strbuf_git_path(sb, "%s", refname);
+	switch (ref_type(refname)) {
+	case REF_TYPE_PER_WORKTREE:
+	case REF_TYPE_PSEUDOREF:
+		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
+		break;
+	case REF_TYPE_NORMAL:
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
+		break;
+	default:
+		die("BUG: unknown ref type %d of ref %s",
+		    ref_type(refname), refname);
+	}
 }
 
 /*
-- 
2.11.0.157.gd943d85

