From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/20] worktree: move repo, convert main worktree
Date: Wed,  3 Feb 2016 16:35:50 +0700
Message-ID: <1454492150-10628-21-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:37:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtso-0006rZ-1s
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526AbcBCJhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:37:48 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33763 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbcBCJhp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:37:45 -0500
Received: by mail-pa0-f42.google.com with SMTP id cy9so10870473pac.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zgi5U6VbBgxer7ccpqJwdtAsjb3tFKHP8DB3tAAtNYo=;
        b=oiYab/JxrtNMf/vXDYUjWv3qe6Duh8hxNgVjl+8trtce0KS5ZPfHa89mrWvsLkkBU1
         af6hykA5mk6NZjWMdL5bY4L2uSRbmSyliTMKReNJ7dtuqhDYBaIIC+sL3M2dOQ7/7WEu
         sm+Kv4a8J9NwRTVGB1gpuUsY7Rn359mKO9dRYk1jXFv1p1g4XENgrHBrrsBo9+bqmWYz
         F8nedtvXXyBvQ7m68CIoWwJdbMZGQJQHvjPAy3xD3G93ZqWFjZGktPHC+h+39UXYbmo0
         WRqGGrNv/4ZzBcW5VGIhgfkz/BLuezlSAQRpHfy3bLCa5Qltk2cbV5qfSAHbpENmRYE3
         LsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=zgi5U6VbBgxer7ccpqJwdtAsjb3tFKHP8DB3tAAtNYo=;
        b=VlvfybOVLkVuWunE7WLfSGwv8tnTfzgf5XLlVWcdBMlyBxwUrx5hg7xASIbXTZEtae
         4OB9OlyLPjqeAaDGjQZuQssoYZV2QvPsVq+akQYiueOjLLwFd4aXv4IaVQjteNZw3IDc
         YHu1jT/9vGjRGCc/voDOqos+0S4m1clPZy5G63DzDc+mFc1t27UPI1ziz+HDR0DNtRv0
         6m7+rvfhton2sHPqtYhCyvm5fB2+aG+M8ocadQDyswLVOoWh5p9b2xW3nFSw8cdPXpd8
         xNu8swX7FZHmrSJojQXERDtOmEumaX5FekbMcmJoOB+yWJb36CdhJbXp8jXwOwkC7N9J
         ZfUw==
X-Gm-Message-State: AG10YOTQ6tkYD2q4m9aUdEboIgXzarYJuDtn47TYlh0OtzyTAdMxTTtv4L56qblKIZQVcw==
X-Received: by 10.66.132.81 with SMTP id os17mr720747pab.98.1454492265013;
        Wed, 03 Feb 2016 01:37:45 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id m5sm8334794pfi.84.2016.02.03.01.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:37:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:37:56 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285364>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c       | 87 ++++++++++++++++++++++++++++++++++++++++=
++------
 t/t2028-worktree-move.sh | 36 ++++++++++++++++++++
 2 files changed, 112 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 80a8b80..3f69369 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -479,10 +479,11 @@ static int list(int ac, const char **av, const ch=
ar *prefix)
=20
 static int move_gitdir(int ac, const char **av, const char *prefix)
 {
-	struct string_list paths =3D STRING_LIST_INIT_NODUP;
+	struct string_list per_worktree =3D STRING_LIST_INIT_DUP;
 	struct strbuf dst =3D STRBUF_INIT;
 	struct strbuf src =3D STRBUF_INIT;
 	struct worktree **worktrees, *mwt =3D NULL;
+	struct worktree tmp;
 	int i, ret =3D 0;
=20
 	if (ac !=3D 1)
@@ -492,29 +493,93 @@ static int move_gitdir(int ac, const char **av, c=
onst char *prefix)
 	strbuf_addstr(&dst, real_path(prefix_filename(prefix, strlen(prefix),=
 av[0])));
=20
 	worktrees =3D get_worktrees();
-	for (i =3D 0; worktrees[i]; i++) {
-		if (is_main_worktree(worktrees[i]))
+	for (i =3D 0; worktrees[i]; i++)
+		if (is_main_worktree(worktrees[i])) {
 			mwt =3D worktrees[i];
-		string_list_append(&paths,
-				   get_worktree_git_dir(worktrees[i]));
-	}
+			break;
+		}
+
+	if (mwt) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		strbuf_addstr(&sb, real_path(get_git_common_dir()));
+		if (ends_with(sb.buf, "/.git"))
+			sb.len -=3D strlen("/.git");
+		else
+			die(_("unrecognized repository directory layout: %s"),
+			    sb.buf);
+		sb.buf[sb.len] =3D '\0';
+		prepare_new_worktree(sb.buf, &tmp, 0);
+		strbuf_release(&sb);
+
+		if (collect_per_worktree_git_paths(&per_worktree))
+			die(_("failed to collect per-worktree paths"));
+
+		for (i =3D 0; !ret && i < per_worktree.nr; i++) {
+			const char *path =3D per_worktree.items[i].string;
+
+			if (safe_create_leading_directories_const(
+				git_common_path("worktrees/%s/%s", tmp.id, path)) ||
+			    copy_file(git_common_path("worktrees/%s/%s", tmp.id, path),
+				      git_common_path("%s", path),
+				      0777))
+				die_errno(_("failed to copy '%s' to '%s'"),
+					  git_common_path("%s", path),
+					  git_common_path("worktrees/%s/%s", tmp.id, path));
+		}
=20
-	if (mwt)
-		die(_("converting main worktree is not supported"));
+		mwt->id =3D xstrdup(tmp.id);
+		cleanup_new_worktree(&tmp);
+	}
=20
 	ret =3D copy_dir_recursively(src.buf, dst.buf);
 	if (ret)
 		die(_("failed to copy '%s' to '%s'"), src.buf, dst.buf);
=20
-	for (i =3D 0; paths.nr; i++)
-		if (update_worktree_gitfile(paths.items[i].string, dst.buf,
+	if (mwt) {
+		struct strbuf sb =3D STRBUF_INIT;
+		int len;
+
+		new_worktree_complete();
+
+		strbuf_addbuf(&sb, &dst);
+		if (sb.buf[sb.len - 1] !=3D '/')
+			strbuf_addch(&sb, '/');
+		len =3D sb.len;
+		for (i =3D 0; !ret && i < per_worktree.nr; i++) {
+			const char *path =3D per_worktree.items[i].string;
+
+			strbuf_addstr(&sb, path);
+			unlink_or_warn(sb.buf);
+			strbuf_setlen(&sb, len);
+		}
+		string_list_clear(&per_worktree, 0);
+
+		strbuf_addstr(&sb, "HEAD");
+		write_file(sb.buf, sha1_to_hex(null_sha1));
+
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s.old", src.buf);
+		if (rename(src.buf, sb.buf))
+			die_errno(_("failed to move '%s' to '%s'"), src.buf, sb.buf);
+		/* XXX: rename back on die() */
+		strbuf_swap(&sb, &src);
+		strbuf_release(&sb);
+	}
+
+	for (i =3D 0; worktrees[i]; i++) {
+		struct strbuf sb =3D STRBUF_INIT;
+
+		strbuf_addf(&sb, "%s/.git", worktrees[i]->path);
+		if (update_worktree_gitfile(sb.buf, dst.buf,
 					    worktrees[i]->id))
 			ret =3D -1;
+		strbuf_release(&sb);
+	}
=20
 	if (!ret)
 		ret =3D remove_dir_recursively(&src, 0);
=20
-	string_list_clear(&paths, 0);
 	return ret;
 }
=20
diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
index e8f6f0c..5e9e1d4 100755
--- a/t/t2028-worktree-move.sh
+++ b/t/t2028-worktree-move.sh
@@ -38,4 +38,40 @@ test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
=20
+test_expect_success 'move repository and convert main worktree' '
+	git worktree move --repository repo &&
+	test_path_is_file .git &&
+	test_path_is_dir repo &&
+	git fsck &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $TRASH_DIRECTORY
+	worktree $TRASH_DIRECTORY/destination
+	EOF
+	test_cmp expected actual &&
+	git -C destination log --format=3D%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2 &&
+	git log --format=3D%s >actual3 &&
+	test_cmp expected2 actual3
+'
+
+test_expect_success 'move repository alone' '
+	git worktree move --repository repo2 &&
+	test_path_is_file .git &&
+	test_path_is_dir repo2 &&
+	git fsck &&
+	git worktree list --porcelain | grep "^worktree" >actual &&
+	cat <<-EOF >expected &&
+	worktree $TRASH_DIRECTORY
+	worktree $TRASH_DIRECTORY/destination
+	EOF
+	test_cmp expected actual &&
+	git -C destination log --format=3D%s >actual2 &&
+	echo init >expected2 &&
+	test_cmp expected2 actual2 &&
+	git log --format=3D%s >actual3 &&
+	test_cmp expected2 actual3
+'
+
 test_done
--=20
2.7.0.377.g4cd97dd
