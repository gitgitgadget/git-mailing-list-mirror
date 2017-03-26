Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B7420966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdCZCnq (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:43:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34901 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdCZCnp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:43:45 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so4666465pge.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtvdnHcwXndLhqQBVBeRDdcpPLePhbrO8zYjd7yD2eg=;
        b=Ra5AfpQrHUS06MJq0BcvSgu82IdMo+TF5BPnX+KArPFyeUf9r3WJ2YFYu7cJwjhYA/
         ZvyPNbbEWYuq1Mw0RElUAnoEHjyqLBIuL2D9noll6o9muFFzoncSpPS1fRmoh3sFnomA
         IkP+nBK34Mu+fkxvjdXhCFe97Yym8X79w4Mz7D1Kxs6RikWjDXIOMms335mxvxE/47Vf
         hSFgRnIMjXDYgdO7zZs9Ccvv/4mmScuGNhn/MIQYFBxaLlCveHKgv8mwXiymjyjAV5c2
         AtvRg1MLlgwQ60mUYDBBgcynS1lauXc5HZX3Qo6ygxvYgmMaDBfSwFQDyWCofpAuPY9b
         B1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtvdnHcwXndLhqQBVBeRDdcpPLePhbrO8zYjd7yD2eg=;
        b=FWSq97ynYEfC6LNO7QhhNtoKgEZ9d3p2cCjaJKNiHoC/d+/nXX/YHgVIegSIW3iqxl
         IZH7zJdtuoTTbt02rjbnzSwPhwgWHcR4WbhNlm+9BYUv6pnyIWkVCwidoSrwSZBKHbeR
         qiiE1kwbpRdz95Py82RsXmr2rYWQLqYUpeulNzeZHUqcbvkRNh7wqorWLDTMZTZm/B+K
         NptIejp0s0QqV09VsL7o5/kNnklre3xPUcOA5ZGuO3UjLkycYxNhW61E+CUp5nb5iPDD
         zxWbxxN+xklIU73oihMzMF6u0L3yDyxjEqdD1i3TvjpQbY2m9fW/ccZA3hlJQEZOU8Ie
         bfMw==
X-Gm-Message-State: AFeK/H2N2oF4x39RG8hcRdEU9ehOpEIRS4HPFeMnyupeTYREz9Ed3HKYp34NTcN3Oul20w==
X-Received: by 10.98.131.75 with SMTP id h72mr18240091pfe.4.1490496208803;
        Sat, 25 Mar 2017 19:43:28 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id w14sm12774064pgo.37.2017.03.25.19.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:43:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:43:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 06/28] files-backend: make sure files_rename_ref() always reach the end
Date:   Sun, 26 Mar 2017 09:42:19 +0700
Message-Id: <20170326024241.31984-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a no-op patch. It prepares the function so that we can release
resources (to be added later in this function) before we return.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f17daddffa..6d0fcc88f9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2585,23 +2585,34 @@ static int files_rename_ref(struct ref_store *ref_store,
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	struct strbuf err = STRBUF_INIT;
+	int ret;
 
-	if (log && S_ISLNK(loginfo.st_mode))
-		return error("reflog for %s is a symlink", oldrefname);
+	if (log && S_ISLNK(loginfo.st_mode)) {
+		ret = error("reflog for %s is a symlink", oldrefname);
+		goto out;
+	}
 
 	if (!resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				orig_sha1, &flag))
-		return error("refname %s not found", oldrefname);
+				orig_sha1, &flag)) {
+		ret = error("refname %s not found", oldrefname);
+		goto out;
+	}
 
-	if (flag & REF_ISSYMREF)
-		return error("refname %s is a symbolic ref, renaming it is not supported",
-			oldrefname);
-	if (!rename_ref_available(oldrefname, newrefname))
-		return 1;
+	if (flag & REF_ISSYMREF) {
+		ret = error("refname %s is a symbolic ref, renaming it is not supported",
+			    oldrefname);
+		goto out;
+	}
+	if (!rename_ref_available(oldrefname, newrefname)) {
+		ret = 1;
+		goto out;
+	}
 
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
-		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
-			oldrefname, strerror(errno));
+	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG))) {
+		ret = error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
+			    oldrefname, strerror(errno));
+		goto out;
+	}
 
 	if (delete_ref(logmsg, oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
@@ -2657,7 +2668,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto rollback;
 	}
 
-	return 0;
+	ret = 0;
+	goto out;
 
  rollback:
 	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
@@ -2686,7 +2698,9 @@ static int files_rename_ref(struct ref_store *ref_store,
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
-	return 1;
+	ret = 1;
+ out:
+	return ret;
 }
 
 static int close_ref(struct ref_lock *lock)
-- 
2.11.0.157.gd943d85

