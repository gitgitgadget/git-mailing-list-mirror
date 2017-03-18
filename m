Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D06F82095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbdCRCFd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:05:33 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34774 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdCRCFc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:05:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so10327405pfb.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYG51uETUNsX1Uzom6upSNbVr3V7AXOXrnOF9Ly1bgw=;
        b=hZo/+KNxixHHLF6d7uwcbEDnlbWoJCb9tf3+Q0GQlFw/YtXjMqLo8G+yVe1D7RcNOM
         aRRRhKdRw2SQ1FJUL/jALT5y5KpaUeQ/mSEnwJ72bs9d80ece7QCpEyHA6oiWFkUttC0
         GzFGxsx57Ce/xYicEoEOZuMUcx/yMIMMvRrCGgSENXX8UlvhIRQk3we6qzljd478j5ym
         o20KtcrRd1Sy6vxYCpf8PwCZymnR46Niah7o9dq3PQhR/rVLEhaYwNA3ameyCd/wA4uP
         +YNU6ya3yhckr2GBhUcjws0iJAY7cp0twv0NFx5jT5jhwA+WukWe69O9WVscjvza+aXC
         hm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYG51uETUNsX1Uzom6upSNbVr3V7AXOXrnOF9Ly1bgw=;
        b=nK2y2OOfUmUkw+5fx27Q6OBHsavGhB22/6ExpVqiIk7sySq9uJNNZUW2apjn61kk/i
         ZhhC40rPw3JWg0M/94zL7lnMxRuUWXOQNRLBP+rOZvjsj20NVRI20gWPZyX2w2vvq7WI
         iEiXL1RuWu5Nee7ZjPhzDcu5fyYWrDzDqYZZjA9Xx3bIqa4Hb4brV3ZGuxdYece9nSZv
         jrMfIdo7mQ0/aHeTnYl4JVAyBFv1cla4Vw5VTdSfTLdDNRmoaNE156+ftl636w1yfmFs
         iIsss1/36Ny//HSfXgcN7pkkem01gdFrwcL9MsPiL4BST3Pu32XCGQWlKzeVF7D8MIcS
         vIrQ==
X-Gm-Message-State: AFeK/H2WQ7uQC1iXV+wmFOQTBNmPb3kjkUZMiAZao1hz3g9PEA+NvZqmxRcpVYzaHZ43uw==
X-Received: by 10.99.216.85 with SMTP id k21mr18917115pgj.10.1489802673256;
        Fri, 17 Mar 2017 19:04:33 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id t133sm19271796pgc.24.2017.03.17.19.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:04:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:04:26 +0700
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
Subject: [PATCH v6 05/27] files-backend: make sure files_rename_ref() always reach the end
Date:   Sat, 18 Mar 2017 09:03:15 +0700
Message-Id: <20170318020337.22767-6-pclouds@gmail.com>
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

This is a no-op patch. It prepares the function so that we can release
resources (to be added later in this function) before we return.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6e6962151a..6282e5868f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2588,23 +2588,34 @@ static int files_rename_ref(struct ref_store *ref_store,
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
@@ -2660,7 +2671,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto rollback;
 	}
 
-	return 0;
+	ret = 0;
+	goto out;
 
  rollback:
 	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
@@ -2689,7 +2701,9 @@ static int files_rename_ref(struct ref_store *ref_store,
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

