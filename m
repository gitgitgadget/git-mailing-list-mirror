Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964023645D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961467; cv=none; b=iwXq9rYGnyCWgDG5R4TPCT9ANIaMujqnwnDTPNXtm4jUgnyFUQXBOxEgzuNFzkIwwMKxguVBgrSKrQeBkpl7hUW/ClF3BLkuYiEQyeGyO0mjj66YRljKNVajyeXhUnr0r5Nj118lFa7LEV8ZJug4bJdaEmAr9Ez09EEREn3MOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961467; c=relaxed/simple;
	bh=nOI/bylgDt7ow3Dvcym8KOQ3qu18gKP7Q8o5LYOkzJ0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=leBrvYQok9mbEetn3qXkLdTTGakP7FORkoxRXcz1G/crQC+BQswaoPnHXzPFJo7/MDsFBEoDvshz4mdpE8tSjHLfX560QUKd9euyeCsnev3WvPIl9sA+unCEhkfvSIurnMHKmHqsCnjiMfV0DSNQxbWNRYocdCKVBt2Rcu+kw20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpBVrNW1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpBVrNW1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8d2574fd9so22877195ad.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961465; x=1792566265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=CpBVrNW1ZCzvmHuQZFMcmM2UqFDfQ5o1ykE1E60h0gYkP6REBy90kdTjShmCXEJkg7
         PnJ3iUj3W/HAQLCo88MQjWSuD5FRD67LJ77QMc2mSB7g4cyUeC1wj8raTdaCIsrAAUUr
         VXLYDMXzQbkd/cCTKOZsYC7AjPKYvojf1gdhXhZoaFHSntxrFcMmRFlqZ/8ieVp8hENp
         xoTwZWFZIvXOdWk8k0GT6/3zk/Ve4pvXgBE6jJ1BJVdUnenB/+hquG6axmyQQhLqGYmh
         tbqV02qMrb/VYBiZIxPW5NVOCjS0dXZ1zGgKNVKfgqrpnOoQq99GMmbQnObu79IXw7R8
         Ncww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961465; x=1792566265;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWhbVinzEes10GXoSlAHYkAXLv2YhYEFRcaWEcIBX78=;
        b=Xs1WicntOHjI0ILtL01o3E9wwjxtFaGheMp1+VBQKb/W7lL36AfNByStwK7yW4plSg
         2B2DvEZ6Z5fh8hgps651MvvUhTPvQRYYrslU48Ts98KSjCVxVa9m56VxEGF8E9MzdQi+
         6rtP6IsY33lU5bFbexRoAXI2/8VDWvJaBbKRb9RWd0EgfWzxU3PxNlPIHn70EvqToQjJ
         61GRE0DsDf8RdY8qjfm5+wL7ms9Q2frIVergAYO8U544Zcy37QPNmOhDqOIqaeQ2vXCn
         Ruk3BkQUmqf3ra3WbDnlwpLpyF2sLMyK0mD+QdcA/PoPEG3uUDmxp2nYa8RT2vybfIjF
         dxaQ==
X-Gm-Message-State: AFq9FYLnreEYG1CJ7lYser3nnaI33yvCnhm6ieJgnKCeuiUfQF4jyIdW
	m+KrFDkGelhE4gf/lsWhy1avIusx26fMbgcoEXTZA/5n2SNvuyn716lLYkahtw==
X-Gm-Gg: AYBFou3mEteLTG6k2d3dxXR+B5a2t5KtHfhZKLv5IEeAcbjMgHxHU9+uhbYJSxNwVrV
	9LT1S9wThmjLzC6s7TdBe7qBYZjgme7z4b5Jffmtfd+Uj3h5/sjguRK5yzDCsN96ocBXPyGagJd
	uvLlLjM0zM4VNJtED9Djmfl0L8CqAKIJjLynrDa4yHNkprypWnsyzFse5+VzBjQqwDPCnMh03Vq
	9N4c6veaGLwLoD7HKVLTw3ScjcguxSEnlzQ05nB2X2LGUn/a8gJ7/JxbxiWMnKXNLtvmqX2ThcD
	7+N3xVSoqHtA8x+6XZ0OsF3Myi16M+8WVNgcP81+3jNGwF195qzZG8gACt5pEhMAX33uUTFvXS6
	zxBSLu2q/RZ2egpyLNjrkzBvJMpp/zFoAZEWmmUegNWPWZ/Nu0LneplPCgOHq04d7F9mGZRRhOX
	Qk8ruBx4EDhmT3ZQZ9BgJl+2vJWxDMmrxcOtIEyDWXD2tDFilcq8sqx37i5CbSZs2dpi5H/9rJV
	g==
X-Received: by 2002:a17:90b:5486:b0:39e:6a7f:1dcd with SMTP id 98e67ed59e1d1-3ab3ab1d56cmr13442104a91.41.1791961465154;
        Wed, 14 Oct 2026 00:04:25 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm3467211a91.7.2026.10.14.00.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:04:24 -0700 (PDT)
Message-Id: <75169f668e4e528c337f4f5a8e476f4076199afd.1791961452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:04:11 +0000
Subject: [PATCH v9 4/5] remote: add "git remote add --limited-fetch"
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

