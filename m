From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/6] worktree: stop supporting moving worktrees manually
Date: Mon, 18 Jan 2016 18:21:30 +0700
Message-ID: <1453116094-4987-3-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:04:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7bS-00044a-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbcARLD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:03:56 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33570 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbcARLDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:03:49 -0500
Received: by mail-pa0-f67.google.com with SMTP id pv5so33503730pac.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qbinMLUGB5Hdc4DsloROdshlOlVEc8irCVV//mfgYQA=;
        b=Yem10sAxbqyT9oJN0oZ8XaSjPy/vGNTdWi1rRfQTnar4MBn9shb7kt+5DsD349vF0Y
         TK693Tx+Xh0u1lef/3U6hH9QBp00fFoFnN3MqyvylBXWgnvKDyyGBt7ANXhJZzTsQXfc
         3AnPRJ4lK//OKnSas4pG2QoZ3OeacbjSBlhdSGXT3hDzencCyOeczY2VU/vTKoFL8wZ/
         QZRWJmK8DOMWDVqLHzCUbPNkXqbyqmLeeEUjw/qV8RI6QFH22PvV0Dv5wwc4dhesYT14
         b1yqw+2CnNe4Ae+V58q1bY+s69RjzrhcpjITnmh14w++KhIE9oVNeB2rcRoekfsxLteo
         nPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=qbinMLUGB5Hdc4DsloROdshlOlVEc8irCVV//mfgYQA=;
        b=eMgW7QbqFfBMeCM20jX2IHw6e6Thh6Q7KhN1K2iq6xy6EyZ0x+SAQmt1QqYHMaDI81
         51cU5HQcHNp/diGdLK4xEt+kgGd94U1gwj+NTWQwMWqt22X+v1RFs5A4WVrJD34VJcOd
         ybJ4lFnPUHLMTA51yl/soCxBbBpyKcnQ56L2bepXG1Ak25aTxpUXH6NHNhhXSJvG02Be
         gEMM5Rk1q7buWxqAAcANCCjYD002JIQbZXoxES9ExiDr7PJQEV4bIvUwJUugSWGYyp4U
         +cRRTipQXwKVzo/L5aldRk0AIJlZP/UrAR2OWDcCDZge5c8HZL0q3dwn3F1wiVEwZYSg
         QpJQ==
X-Gm-Message-State: ALoCoQk9JVWe7S121LtLTJqVjebxe3zCy2W4yckSry+YzeLWOQK62yE1+/9TyXh1HdQB2dZfESfCcenf20SRDIpVT2fHdMsJxw==
X-Received: by 10.66.230.201 with SMTP id ta9mr35810875pac.52.1453115027910;
        Mon, 18 Jan 2016 03:03:47 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id h87sm33182922pfd.33.2016.01.18.03.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:03:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:21:49 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284286>

The current update_linked_gitdir() has a bug that can create "gitdir"
file in non-multi-worktree setup. Worse, sometimes it can write relativ=
e
path to "gitdir" file, which will not work (e.g. "git worktree list"
will display the worktree's location incorrectly)

Instead of fixing this, we step back a bit. The original design was
probably not well thought out. For now, if the user manually moves a
worktree, they have to fix up "gitdir" file manually or the worktree
will get pruned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt |  6 ++----
 setup.c                        | 12 ------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 5b9ad04..4814f48 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -33,10 +33,8 @@ The working tree's administrative files in the repos=
itory (see
 clean up any stale administrative files.
=20
 If you move a linked working tree to another file system, or
-within a file system that does not support hard links, you need to run
-at least one git command inside the linked working tree
-(e.g. `git status`) in order to update its administrative files in the
-repository so that they do not get automatically pruned.
+within a file system that does not support hard links, you need to upd=
ate
+$GIT_DIR/worktrees/<id>/gitdir so that they do not get automatically p=
runed.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
diff --git a/setup.c b/setup.c
index d343725..6ee2b23 100644
--- a/setup.c
+++ b/setup.c
@@ -434,17 +434,6 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 	return ret;
 }
=20
-static void update_linked_gitdir(const char *gitfile, const char *gitd=
ir)
-{
-	struct strbuf path =3D STRBUF_INIT;
-	struct stat st;
-
-	strbuf_addf(&path, "%s/gitdir", gitdir);
-	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
-		write_file(path.buf, "%s", gitfile);
-	strbuf_release(&path);
-}
-
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
@@ -514,7 +503,6 @@ const char *read_gitfile_gently(const char *path, i=
nt *return_error_code)
 		error_code =3D READ_GITFILE_ERR_NOT_A_REPO;
 		goto cleanup_return;
 	}
-	update_linked_gitdir(path, dir);
 	path =3D real_path(dir);
=20
 cleanup_return:
--=20
2.7.0.96.g5373197
