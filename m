Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D313049E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728190787; cv=none; b=mGspl9zKfLYFDm/CyY18s62Ui8A3Ii4frHguxkvS7o8Dj6qcG0m6QryG/bX80eXGYZi2qbZk++wtqo4ySmJnPeS7oAoLsHVsrkckKvSC0NYtv+vsEtQksXCnS4P0r3XABbVSRMnXUKP7Esj2iMAR78e056cDt1YCghATKFlSWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728190787; c=relaxed/simple;
	bh=PkIpyu5OfHsSTVpXbRUzTj1IEhOL7UqVbOK5SNenNY4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2tCxE/pnNs1fx5h6k9GXa9RKXgLuWu8ZYvEy+1ijyv2o/W/+9kMbqIHjUVDQ36CXXxr+PBd5je+zKyRzfEc5HrlLFdTNsVDaKeTu6b7GhqbrYWM6rg85eKj+xkcQ2NjI9P8PazbVhnm8RSczuV/MVMWpo+ksyj6wk5/cVJfSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TNKn9vII; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TNKn9vII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728190784; x=1728449984;
	bh=/Z0MZufX9ckUTcI9vhNPUR5tALcN5hjWb+XFLCuue08=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TNKn9vIIdNsrqtSzVPdIkOvDuLmERktTcquR0GTCfxDldSom1IU1GcCwLTzzQOQY1
	 o+7RrVsDLmeOBsfIa4NhmKguXn+kOIxEeD0SZAOGWYe5uLwMcqgTVO6YXn0/fhd4hl
	 6kd8G43r4QXMZZv+ChyOuUUc6nhkzxkcSBqhwkGbavcvhCweiaG5z5qzKZAdIXZqT4
	 cRhBRg13+1KCmYBQixTSZxO5sW4wID5S7nXnED0ZRUW2g6lIlLete7Embd51UQ7FZt
	 ul/n5EhcNSa3ZgRJiFMTxAZlAXVMufOLtiZV766Cbo3f280pxIVjb41leQ20Bk9tXD
	 bJSj+Mxui5XAQ==
Date: Sun, 06 Oct 2024 04:59:38 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 3/4] worktree: sync worktree paths after gitdir move
Message-ID: <20241006045847.159937-4-cdwhite3@pm.me>
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
References: <20241006045847.159937-1-cdwhite3@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 4794adc9659d995d2dd7807bcebd7c576e010ebb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------7e861a9d038310504765e66ad4e9b1d24d6eb13f4711113970e69d298073537a"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------7e861a9d038310504765e66ad4e9b1d24d6eb13f4711113970e69d298073537a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Caleb White <cdwhite3@pm.me>
To: git@vger.kernel.org
Cc: Caleb White <cdwhite3@pm.me>
Subject: [PATCH 3/4] worktree: sync worktree paths after gitdir move
Date: Sat,  5 Oct 2024 23:58:41 -0500
Message-ID: <20241006045847.159937-4-cdwhite3@pm.me>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006045847.159937-1-cdwhite3@pm.me>
References: <20241006045847.159937-1-cdwhite3@pm.me>
MIME-Version: 1.0

When re-initializing a repository with a separate gitdir (the original
gitdir is moved to a new location), any linked worktrees become broken
and must be repaired to reflect the new gitdir location. For absolute
paths, this breakage is one-way, but is both ways for relative paths
(the `<worktree>/.git` and the `<repo>/worktrees/<id>/gitdir`).

Previously, `repair_worktrees` was being called which loops through all
the worktrees in the repository and updates the `<worktree>/.git` files
to point to the new gitdir. However, when both sides of the worktrees
are broken, the previous gitdir location is required to reestablish the
link.

To fix this, the function `repair_worktrees_after_gitdir_move` is
introduced. It takes the old gitdir path as an argument and repairs both
sides of the worktree.

This change fixes the following test cases in t0001-init.sh:
- re-init to move gitdir with linked worktrees
- re-init to move gitdir within linked worktree

Signed-off-by: Caleb 
White <cdwhite3@pm.me>
---
 setup.c    |  2 +-
 worktree.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h | 10 ++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 94e79b2..7b648de 100644
--- a/setup.c
+++ b/setup.c
@@ -2420,7 +2420,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 		if (rename(src, git_dir))
 			die_errno(_("unable to move %s to %s"), src, git_dir);
-		repair_worktrees(NULL, NULL);
+		repair_worktrees_after_gitdir_move(src);
 	}
 
 	write_file(git_link, "gitdir: %s", git_dir);
diff --git a/worktree.c b/worktree.c
index fc14e9a..b08ecce 100644
--- a/worktree.c
+++ b/worktree.c
@@ -650,6 +650,60 @@ void repair_worktrees(worktree_repair_fn fn, void *cb_data)
 	free_worktrees(worktrees);
 }
 
+void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf repo = STRBUF_
INIT;
+	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf dotgit = STRBUF_INIT;
+	struct strbuf olddotgit = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+
+	if (is_main_worktree(wt))
+		goto done;
+
+	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
+	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
+
+	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
+		goto done;
+
+	strbuf_rtrim(&olddotgit);
+	if (is_absolute_path(olddotgit.buf)) {
+		strbuf_addbuf(&dotgit, &olddotgit);
+	} else {
+		strbuf_addf(&dotgit, "%s/worktrees/%s/%s", old_path, wt->id, olddotgit.buf);
+		strbuf_realpath_forgiving(&dotgit, dotgit.buf, 0);
+	}
+
+	if (!file_exists(dotgit.buf))
+		goto done;
+
+	strbuf_addbuf(&path, &dotgit);
+	strbuf_strip_suffix(&path, "/.git");
+
+	write_file(dotgit.buf, "gitdir: %s", relative_path(repo.buf, path.buf, &tmp));
+	strbuf_reset(&tmp);
+	write_file(gitdir.buf, "%s", relative_path(dotgit.buf, repo.buf, &tmp));
+done:
+	strbu
f_release(&path);
+	strbuf_release(&repo);
+	strbuf_release(&gitdir);
+	strbuf_release(&dotgit);
+	strbuf_release(&olddotgit);
+	strbuf_release(&tmp);
+}
+
+void repair_worktrees_after_gitdir_move(const char *old_path)
+{
+	struct worktree **worktrees = get_worktrees_internal(1);
+	struct worktree **wt = worktrees + 1; /* +1 skips main worktree */
+
+	for (; *wt; wt++)
+		repair_worktree_after_gitdir_move(*wt, old_path);
+	free_worktrees(worktrees);
+}
+
 static int is_main_worktree_path(const char *path)
 {
 	struct strbuf target = STRBUF_INIT;
diff --git a/worktree.h b/worktree.h
index 11279d0..e961186 100644
--- a/worktree.h
+++ b/worktree.h
@@ -131,6 +131,16 @@ typedef void (* worktree_repair_fn)(int iserr, const char *path,
  */
 void repair_worktrees(worktree_repair_fn, void *cb_data);
 
+/*
+ * Repair the linked worktrees after the gitdir has been moved.
+ */
+void repair_worktrees_after_gitdir_move(const char *old_path);
+
+/*
+ * Repair the l
inked worktree after the gitdir has been moved.
+ */
+void repair_worktree_after_gitdir_move(struct worktree *wt, const char *old_path);
+
 /*
  * Repair administrative files corresponding to the worktree at the given path.
  * The worktree's .git file pointing at the repository must be intact for the
-- 
2.46.2


--------7e861a9d038310504765e66ad4e9b1d24d6eb13f4711113970e69d298073537a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBQJnAhk4CRAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAB3eAgAiVfc6Z1LYhBHbK5FOSbxHiKnHYcP+QjczijhhNu9BNfRNlvE
5dZrDawKrVil+UYqaF0i6iSXmfKGyss7i8RTAPn1XwARn0+hQkcZVfihcfPR
5bosdNYyHtBQ/3wfsYq7HgxghdtipROG6M0OH/z3Lh42WZU5B0WfebdN/Woj
xvgAGpLTplptF5+pXEuGqa3NjJH7b2m3bjKRk34An/vOBBO6PRDlr7j/JH4Q
H5A85mRTjkmgB4ih54hV/bim1ej5LVIhQfeyZ1jjd1zJ6F6dxsCUorc2wXwA
IH7Lipo8X80i/OXaLERMnQmN9qIx7naIG8N3FZuJ+cudkje+YzWcSA==
=9de1
-----END PGP SIGNATURE-----


--------7e861a9d038310504765e66ad4e9b1d24d6eb13f4711113970e69d298073537a--

