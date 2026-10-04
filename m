Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC02737FC
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 08:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102696; cv=none; b=TQoUl6bdoxKA3ctIYy53rZDP6Uw+mcROXS0ozMY2rNCnDsvXmbCH3r54+V4NJoZEp7sW1NDbHDTX/66yRq7rlCvooPeZq2dtBMMZbf2EAG+Py86BCv+i9aeOwYD37nO4XyoqF8DaTUHjitNnVU8N700UwLSOK+pHrQte2GG5vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102696; c=relaxed/simple;
	bh=nOI/bylgDt7ow3Dvcym8KOQ3qu18gKP7Q8o5LYOkzJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hQBC79L/uiuosCWxfO/6tR+tvtTnvHmYvpfC3Cwwjp8H2jzCQDhMx/g0TOpTufmDCU8aQtNQd/1SYNBiE5AbQeznxVvHGHB72kDvTcbv/nn5bfu2wR2wfaqVDWt8m6Eak+DxaF/TKH5VJg1EsubxatiU3fFOOrpmeL7ZsoQJ07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8Ci40D/; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Ci40D/"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-35122ae71e9so181326eec.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102691; x=1791707491; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=I8Ci40D/BcbWFLGcjdCUsYfmvnpeKcnCYdglCHvMWtzTpy+UehPkJk/pYyV2An+In7
         CmfsFkZY5nCL8xSCveEalcXqvKird8+AEVpvPuArszxrnnGe9LvcpgWvFb1tw7bSlCwh
         XAzl4gzMgAyOlc3YVPRRFiCci8JVwXmGW3C5fued0yBajtNQcquPMnSus7g7lJy2HEmo
         SBtd4TPMUkeGnAX00tCLgkHuv7RNfhWgKLfR1Lypog39sXa/giKQI7BWEAX10Yydq6rR
         xXbwv0yLAoCyDTFofNy17KAmAwyeTDaASEfq1PiC1i8+T+bHks22AwH4Wxn2GGybGsdN
         I6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102691; x=1791707491;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=XJVJvoPZ0MOai8Z8uuvoNzMJjubcYEpk83rNxYbMH2XoEBV2AzJFr1bAgTKFBbfW7K
         iNBJasKelNbvSow76QLkW09TFjglROQLwnOWzqns8RRdwymYCut0DUWqNSVw3RatwddD
         rtKw5H6SlZFmRLZSPSKcpxdl3+dwpUnozmF4Zh5LV9HlmKx2yusR+J2mBYoofnlLFbAA
         sqYKsah6dTN4bk0wt5TfGcAG9PgOIx9DhVu6o+eSLTwlhPpNuDIG8ZXKA1jDdnEBeUN0
         sgajeQ3nzy4ZlDWCbLTOtnngefu35mj0mLK1lnZ+O51q421+tWXWKW7id7DB9uj7V19N
         Lghg==
X-Gm-Message-State: AFq9FYL5R9RPZE5zxIS4nNC12qGBwmdUHw80VokQVgrmYXcGf4/a6+MT
	qBJzvMqDBcd6ddbQYR28Wz6u9w5lLIIhzXHrNJ4cibZLZ83maKG1vn7qjxQnrw==
X-Gm-Gg: AYBFou1uFBt0o+mjopaa8ZRb/ZfNwrgNftA8bHZeq/ztukkzJhfcXNkXrpqrsBq0Rrb
	2ZJdz8kqoG19jv6oDAbr3+F0c+e+9AZz9agqy9ZbV9CifdlEuugOBYCByWvh/sflcEWay6tS/t2
	21O+5+4JNqZxskby4QejGOES4FAsjwNe07IiOL7kNlxQc6keYRekkYFDtPjicbSvGJSHtJYHbbm
	j8trL0sSwztxioGM6JCzsiUecH7s0wPgwNItvdlF8ltmj86RJAdhobL0pbpsw67/Wgvd9SDiNvM
	lCIk+HnNHFsS9Tv+xf1EC/y/pb//CDgju97jh7LG3Wvug5JGxewE+agAk9PZeh398UpB07kXBfA
	o59R25JlaAjHN0sb3NdWN5AlU/mBVyoM4NC2mNKgcfegONQ6sftkq1/8LWc1vZef/hFHwkEgMzc
	k5YtU0Nua2tXr3Bdi/G7TgkqaRb5Yc3DiEqU86vtNMxm57J+pL+9CZunZjwMnYQUjffr+bIqyAR
	w==
X-Received: by 2002:a05:693c:821b:b0:351:25b6:c867 with SMTP id 5a478bee46e88-35125b6c996mr1633471eec.2.1791102690473;
        Sun, 04 Oct 2026 01:31:30 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm3659356eec.17.2026.10.04.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 01:31:29 -0700 (PDT)
Message-Id: <3abcc8915b4aa199d95a4eeb39a57de2fc491d3d.1791102684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 08:31:23 +0000
Subject: [PATCH v6 3/4] remote: add "git remote add --limited-fetch"
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
"git fetch <name>" only fetches the branches already tracked, as
described in the previous commit. It is rejected together with
-t/--track or --mirror, since those already say explicitly what to
fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 +++++++-
 builtin/remote.c              | 28 ++++++++++++++++++++++------
 t/t5505-remote.sh             | 16 ++++++++++++++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..4255f8b3e6 100644
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
+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
+details.
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

