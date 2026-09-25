Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A73CF20C
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333412; cv=none; b=qvh34Q/+ZI+w+94zS1dRQ+RccwBGhKQ4nLhBBR8uHgNzia9nUOlrTXHVXDie1QumCmMLEw2yvx860Ryu+L/cTinnHX6ePmEnpQQh4QDAxpNFekZEkH01/Sa5b/LVkh5BMX2trpjJ5wyUUFiuY4gOseuDn0oioshE1zu5/fl6M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333412; c=relaxed/simple;
	bh=zzBVrCwSB6aJcluuIazLSaKgKKXZr5VWm1na4PnZ4XQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jlWhYhGBTlF36r90kb9Bcl43+EGcYM3w/4ubGsYKTJ6xKpK1BJXw0AuZ3l99meYA0s1PY0vwERC0oAydGVYZkJNeg7QGrd3Ojog9pYEcchLFaVpARanQIsIzge2dxrjqKHKjWVhWOrD/uuH12SdevbxicT6WeTaa7qyQuLYQ4bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/5/aqbf; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/5/aqbf"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so640271c88.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790333410; x=1790938210; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=51RneUqAQlRbK8Gq4UONQTpv8++hPZUGeRQEoF4FJpM=;
        b=R/5/aqbfbX8oP7lVk80p1c4IOHK9fEb+9GMX4wpy/2KLdQL06O/IiDlOCxvv09jr5A
         s6jFmzden6BhVpFJQVcpHc6Mm9gPYI8YUpJj0wNseL4dPZvB75hfJaKNBIqvKHYjKRIL
         VvHbTmkbHtuWtbdcpthJ3GX1c+2r914KuuzQpRjQ/EIVgiS3/srxrDK1/HLcOFJWtfGt
         oVJbzMoX4qsi4UJTAAadSawcqZGXUXSikIQvqp8FD7Xf94DPPstx/Fb3he0jEnLhyOVp
         NOw5wQXEND/LrTKTRFdcQqrdAj4k6/swyjAvLPNogRSBY2m8vNCJRb6TDvHoioPTG+jr
         VK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790333410; x=1790938210;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=51RneUqAQlRbK8Gq4UONQTpv8++hPZUGeRQEoF4FJpM=;
        b=Ti7brim6IMuWZcxHo4dhIQP3LiiQUiILYyzpDu+sOxk045WgB6cfstmwgY9gj94qQJ
         oOxpPHqi987v1ejvSjZ1YkZ0mtA9ty5M9+0CEVe9eQm80Ak/I5ubsYfwPGrZrgyqANb2
         rXPjyyUBrR3PEaXalApzti5nyCALAkV8V3IQ+JJoGZcJN2V/z5adPqxrKNDzFUrvLvBn
         3AWGdKT0Ik4RmdrqZGz/88np5KQw3Wa+GSh/o2ss6Ycq+0Ype1yfHeaF5xKar5q7V84v
         VW+IS0Swwt2Xu78e0kZuo4Woty8rR7fMreuUA1aF9WaxWqGWn1lib2JwDahmoP3avZ4z
         a7YQ==
X-Gm-Message-State: AFuF++nfCNI0MdlQ8qIWc2dDqiNQpsgueim1Yzu7rhvNnp4stIWMHKio
	2XMM9zaDcnO/doKBhAZyqkHwTysN4vq25XkldpGnp4cbBqCSt5NW2+0t+6s69Rev
X-Gm-Gg: AYBFou30NeSfUyZHze/cw/pQB16olKQum0I3prRywAJkinjI/OSVpjLi5Y6QO1FD5rZ
	zOBPsQYOVbStjSLVNBsUwRhBXFYSRUWsHwjefoxpjfEl4c2u1o/2oCnJm2pR+CQDRkCAXgNCyQl
	eR/htBNBLHxwIUeZM48I3J15+vfC/wkvXzpsSbLNQh8gK+Nxxyn+9oTgayqmGU1UfHNzEUYSEXA
	dniOT7SEzE18M7hxHjScGQcvfWgf+o7/Md83wtFqoyuojscQkf4bSKfOkC/eNFf7i3oM7WqW+MZ
	kz2nltUVz7m0bWZAeLo0Lv6uGdskjzyRxBKyuN5a9YnPUS9zfjrksqEzjWM7f6uzVfe5EMO+1Tb
	G0NBxaaUEsV4VS+sxao4snjV/HmfTts7geDM6Iukot6vTRbSugnfQ1jTrHw8PVEPer8dOgHB4Ny
	hIEukGo3LYVb10KC0jcGGIYuexLDAYIZ0CvXjjnkr78uQIaK4zT3OdNlVDB2uvXeznzCJOYDk=
X-Received: by 2002:a05:7022:3c86:b0:143:31ea:ebc2 with SMTP id a92af1059eb24-14503fc189bmr3974783c88.6.1790333409776;
        Fri, 25 Sep 2026 03:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.7.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757747sm6936271eec.13.2026.09.25.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:50:09 -0700 (PDT)
Message-Id: <604e5849565f9a1d1697cd0983809f80f0e1319b.1790333402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:50:01 +0000
Subject: [PATCH v3 3/4] remote: add "git remote add --limited-fetch"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A remote added the ordinary way tracks every branch it has, via a
wildcard remote.<name>.fetch refspec. That is wasteful for a remote
whose history is only worth following for the branches actually in
use locally, and it can make "git fetch" negotiate history for
branches nobody asked for.

Give "git remote add" a --limited-fetch option that sets up
remote.<name>.refmap instead of remote.<name>.fetch, so that
"git fetch <name>" only fetches the branches already tracked, plus
the remote's default branch, as described in the previous commit.
It is rejected together with -t/--track or --mirror, since those
already say explicitly what to fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 +++++++-
 builtin/remote.c              | 28 ++++++++++++++++++++++------
 t/t5505-remote.sh             | 16 ++++++++++++++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..74fbce6e0e 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git remote [-v | --verbose]
-git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <URL>
+git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] [--[no-]limited-fetch] <name> <URL>
 git remote rename [--[no-]progress] <old> <new>
 git remote remove <name>
 git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
@@ -70,6 +70,12 @@ the `refs/remotes/<name>/` namespace, a refspec to track only _<branch>_
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
+With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
+that tracks all branches, `remote.<name>.refmap` is set up so that a
+refspec-less `git fetch <name>` only fetches branches our local branches
+are built on, plus the remote's default branch. See the `--refmap` entry
+in linkgit:git-fetch[1] for details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..f036dd5d6f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -179,6 +179,7 @@ static int add(int argc, const char **argv, const char *prefix,
 {
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
+	int limited_fetch = -1; /* unspecified */
 	struct string_list track = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
 	struct remote *remote;
@@ -198,6 +199,8 @@ static int add(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
 			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt),
+		OPT_BOOL(0, "limited-fetch", &limited_fetch,
+			N_("fetch only the branches we build on, instead of every branch")),
 		OPT_END()
 	};
 
@@ -211,6 +214,10 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	if (limited_fetch == 1 && track.nr)
+		die(_("--limited-fetch does not make sense with -t/--track"));
+	if (limited_fetch == 1 && mirror)
+		die(_("--limited-fetch does not make sense with --mirror"));
 
 	name = argv[0];
 	url = argv[1];
@@ -230,13 +237,22 @@ static int add(int argc, const char **argv, const char *prefix,
 	repo_config_set(the_repository, buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
+		int use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
+			limited_fetch == 1;
+
 		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.fetch", name);
-		if (track.nr == 0)
-			string_list_append(&track, "*");
-		for (size_t i = 0; i < track.nr; i++) {
-			add_branch(buf.buf, track.items[i].string,
-				   name, mirror, &buf2);
+		if (use_limited_fetch) {
+			strbuf_addf(&buf, "remote.%s.refmap", name);
+			strbuf_reset(&buf2);
+			strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s/*", name);
+			repo_config_set(the_repository, buf.buf, buf2.buf);
+		} else {
+			strbuf_addf(&buf, "remote.%s.fetch", name);
+			if (track.nr == 0)
+				string_list_append(&track, "*");
+			for (size_t i = 0; i < track.nr; i++)
+				add_branch(buf.buf, track.items[i].string,
+					   name, mirror, &buf2);
 		}
 	}
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..0168d5abfe 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,22 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success '--limited-fetch works in a full repository too' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add --limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.refmap &&
+		test_must_fail git config get remote.upstream.fetch
+	)
+'
+
+test_expect_success '--limited-fetch conflicts with -t' '
+	test_must_fail git remote add --limited-fetch -t main upstream ../two
+'
+
 test_expect_success 'check remote-tracking' '
 	(
 		cd test &&
-- 
gitgitgadget

