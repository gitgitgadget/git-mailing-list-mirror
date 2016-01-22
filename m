From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/2] worktree: stop supporting moving worktrees manually
Date: Fri, 22 Jan 2016 15:35:49 +0700
Message-ID: <1453451749-10660-3-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
 <1453451749-10660-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 09:36:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMXCX-0004sv-8R
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 09:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065AbcAVIgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2016 03:36:10 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34676 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbcAVIgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 03:36:07 -0500
Received: by mail-pf0-f196.google.com with SMTP id 65so2969032pfd.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 00:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jfZUG0glPhd9r8nMKrdyQufhJIS2NOgc7dJID3d2uQY=;
        b=Iuo+DZFq4pATUTd+bp9mrDPbRlgL3DKLdfoTCtqzODrxCnYFIqj/QkjXGqtFRLUwo+
         KtSmODUXjepgd+RO0Fce6oDaEEEvFvHLCqh6AVucK3tFVXii9pEGxii9SJJzv/1LpeWT
         HrNXGAsHR3YsXHDpX851bzVBLaUuCT0+17oyRCRGZvqRxLJuGlTxkSrG1bao/+jt1HLu
         bIajnnarSEJb+98S+Basv9Rp6L3fduzCqnAzdvxm8LJzrxqNOmM2X8rH0A9jaWDyx/uL
         SLQlyxSP1phKnOq8BCURrFeIHts9HDg047uTtauXsnuSOo3xy2ZNpcmNYJe3aO1bJ+r5
         x/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=jfZUG0glPhd9r8nMKrdyQufhJIS2NOgc7dJID3d2uQY=;
        b=hRyvquNabFqQRaZ1LKvr4ALx+sYluuk67G4NOSHErPVBEPDr3mZNH5NrHEiU9fiKFa
         jqAub5ZW0mij1dP/YzjnR70NoncPvK5lbIuYr4Sx8r92QqDE80hq+3PVo4R4WydwdTpK
         2UfGD5EXmY+QHPq5SQIJvKCAArp2lImydcSR20l+Uw87jtfRDbwBQmIYkgh2Gh1fssdm
         W25RJfpPr4iONj15kVU/rOCd2rfEY1c7vv3/qNrmu9SZNoapNlFrB94ONJz164ygC2kL
         4+lpU+5/zM/+05kWTapNmDo/aLQj8wpg/btY1fgt8UEr1NKd2mC1mVOtdzTWK/jEjsvQ
         PSQw==
X-Gm-Message-State: AG10YOSPz+a+XGWpEG0f1UOJlcog5X9nMwyRJSfUivxOU68y+NpkhaRo/nDliWkWPwxrPw==
X-Received: by 10.98.10.203 with SMTP id 72mr2579562pfk.87.1453451767345;
        Fri, 22 Jan 2016 00:36:07 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id u21sm7848996pfi.15.2016.01.22.00.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 00:36:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Jan 2016 15:36:05 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453451749-10660-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284551>

The current update_linked_gitdir() has a bug that can create "gitdir"
file in non-multi-worktree setup. Worse, sometimes it can write relativ=
e
path to "gitdir" file, which will not work (e.g. "git worktree list"
will display the worktree's location incorrectly)

Instead of fixing this, we step back a bit. The original design was
probably not well thought out. For now, if the user manually moves a
worktree, they have to fix up "gitdir" file manually or the worktree
will get pruned.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt | 15 ++++++++++-----
 setup.c                        | 12 ------------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 5b9ad04..62c76c1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -32,11 +32,9 @@ The working tree's administrative files in the repos=
itory (see
 `git worktree prune` in the main or any linked working tree to
 clean up any stale administrative files.
=20
-If you move a linked working tree to another file system, or
-within a file system that does not support hard links, you need to run
-at least one git command inside the linked working tree
-(e.g. `git status`) in order to update its administrative files in the
-repository so that they do not get automatically pruned.
+If you move a linked working tree, you need to manually update the
+administrative files so that they do not get pruned automatically. See
+section "DETAILS" for more information.
=20
 If a linked working tree is stored on a portable device or network sha=
re
 which is not always mounted, you can prevent its administrative files =
from
@@ -137,6 +135,13 @@ thumb is do not make any assumption about whether =
a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
+If you move a linked working tree, you need to update the 'gitdir' fil=
e
+in the entry's directory. For example, if a linked working tree is mov=
ed
+to `/newpath/test-next` and its `.git` file points to
+`/path/main/.git/worktrees/test-next`, then update
+`/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/te=
st-next`
+instead.
+
 To prevent a $GIT_DIR/worktrees entry from being pruned (which
 can be useful in some situations, such as when the
 entry's working tree is stored on a portable device), add a file named
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
2.7.0.125.g9eec362
