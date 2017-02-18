Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6836A201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbdBRNeF (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:05 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33396 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdBRNeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so6190106pfg.0
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69GX/JeAFSZpwYEjOuQ8xvnon0bRPtY4gw0k1xnxnwA=;
        b=ZlJByxG3BVc8mn/Os7orrUGLSVhq7qq0CbMqBJ9+K3KuD7/aaT0utIfSRd94hVDJSE
         FqPjImNaD/WlrOfeQfb5u9sz+WTvcstOSdVj0ofqvlm6J5NCzYqCG/vRpB4MOdO7KWIJ
         afXjB74PbJxUFnW+N57wJjgyae6Q2Ew4Dzy2jV/o3SXikbGcwKBNISy96oEoC3eAIsiH
         DqmPsgxZxdENUHA4n7Yt4MojKdbplmwGZwIO9p04G84tOVeGf7p/1XL0S3+OZMZyPxfR
         zHyR8Qx55L2xBFvIaKnRaMKBLTDvGrEnP1e7JDCfF+HZEsP9Sn2SMQMrHyY8oBeCaOSk
         MwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69GX/JeAFSZpwYEjOuQ8xvnon0bRPtY4gw0k1xnxnwA=;
        b=AM31B6N0dGd+D83aEXp4hx5694Z/qua2mDn8tcXreA/tV7mVofDBshykBKP35V0A9m
         g20b2OXuPs+rzGr09hpoVtlT3hOWOdOwIISgy5yI4+ab7nnbfQ1NiK3NJ0mQi8hZ7x4M
         Qp1I8zaBbR9diTV+N/4zl4b9rCknJVorSmwsq2ryQWusdj2LqIHOckjZaSsP3ZOLgB8R
         3mylxpaimerhZMicv4RomajhldAXK4ffMOZk7mcmIoc9DcebhVHM93AFlcu9C7DPMgLE
         zb87YqhLxpclbIHGGcKJiAhoxOhiQ0mThUDcsPuygkPAhqYKXfgayC5EM3jxnAdHJEHw
         aFXA==
X-Gm-Message-State: AMke39lkm74TnnBSX+C/TWnlEeUQ/Ox/anOQBavidGZ7ScvQUwc2wch7yt4tuDLIupuKdw==
X-Received: by 10.98.11.198 with SMTP id 67mr2798518pfl.145.1487424843367;
        Sat, 18 Feb 2017 05:34:03 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id d29sm25470374pfk.83.2017.02.18.05.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:33:56 +0700
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
Subject: [PATCH v4 06/15] files-backend: remove the use of git_path()
Date:   Sat, 18 Feb 2017 20:32:54 +0700
Message-Id: <20170218133303.3682-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given $GIT_DIR and $GIT_COMMON_DIR, files-backend is now in charge of
deciding what goes where. The end goal is to pass $GIT_DIR only. A
refs "view" of a linked worktree is a logical ref store that combines
two files backends together.

(*) Not entirely true since strbuf_git_path_submodule() still does path
translation underneath. But that's for another patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b599ddf92..dbcaf9bda 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -924,6 +924,9 @@ struct files_ref_store {
 	 */
 	const char *submodule;
 
+	struct strbuf gitdir;
+	struct strbuf gitcommondir;
+
 	struct ref_entry *loose;
 	struct packed_ref_cache *packed;
 };
@@ -937,15 +940,33 @@ static void files_path(struct files_ref_store *refs, struct strbuf *sb,
 {
 	struct strbuf tmp = STRBUF_INIT;
 	va_list vap;
+	const char *ref;
 
 	va_start(vap, fmt);
 	strbuf_vaddf(&tmp, fmt, vap);
 	va_end(vap);
-	if (refs->submodule)
+	if (refs->submodule) {
 		strbuf_git_path_submodule(sb, refs->submodule,
 					  "%s", tmp.buf);
-	else
-		strbuf_git_path(sb, "%s", tmp.buf);
+	} else if (!strcmp(tmp.buf, "packed-refs") ||
+		   !strcmp(tmp.buf, "logs")) { /* non refname path */
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
+	} else if (skip_prefix(tmp.buf, "logs/", &ref)) { /* reflog */
+		if (is_per_worktree_ref(ref))
+			strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
+		else
+			strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
+	} else {		/* refname */
+		switch (ref_type(tmp.buf)) {
+		case REF_TYPE_PER_WORKTREE:
+		case REF_TYPE_PSEUDOREF:
+			strbuf_addf(sb, "%s/%s", refs->gitdir.buf, tmp.buf);
+			break;
+		case REF_TYPE_NORMAL:
+			strbuf_addf(sb, "%s/%s", refs->gitcommondir.buf, tmp.buf);
+			break;
+		}
+	}
 	strbuf_release(&tmp);
 }
 
@@ -1004,7 +1025,15 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	refs->submodule = xstrdup_or_null(submodule);
+	strbuf_init(&refs->gitdir, 0);
+	strbuf_init(&refs->gitcommondir, 0);
+
+	if (submodule) {
+		refs->submodule = xstrdup(submodule);
+	} else {
+		strbuf_addstr(&refs->gitdir, get_git_dir());
+		strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
+	}
 
 	return ref_store;
 }
-- 
2.11.0.157.gd943d85

