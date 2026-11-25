Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633597;
	b=j8TBJnQMLELVNxaWSISArmF0vtRq1qIIbKJ26CwxQZBqPcenfJPIvwM3PwKgQQCK7mwa
	 v12Vx07rER3C3+glIzFFnkQ/ewVV7Fpre0p1kwRXfF4I/0p7DaFurzdiALRzCf5Xa0ayA
	 MmrUjdD+Bz6obYDonSk+pMyoGMKpS4s2LW2LnYaJRfV+Ha2KtxlJQ8iRSuOdQmr8/t6k0
	 WvUIF6VIWNNJJZeLdlGdGoLANd5SLfW42ZMsnjP3sMxXXL3ZnTFOIoACq8/HKa47+T2PP
	 E+osBSFC1tfIrAK8Pab3iR65+eLjecXAd2X8cJyF7xtH7s42mnn91dnZ/X4BR2r5e/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=vbRNLKO3gfTSOvrqwgbMcGUgGCsHsjFQg4+4l8TI+QM=;
	b=2I5bvvboRaZvCkTqFVlCXnU0nLWkonlCeBpDkLo8f0sYC9aBRyqoINEMTwUat5EFR29A
	 l8BzOWDn6WLjgAPk4QPTalumXRtav/RW4hX6mEGEWJqIxvE+b0i0fK/McCyjLZn7NW/sW
	 zR+cf4XKVBnK0+3tUSdJRPPQYnSjJ6EX+mJe2HYgzX073GxlBOMIrhsvXlYzU5kTlDjEf
	 3y/gM5NhXU/B7+KMDBM3pCdl8wc4AXngXyQFad9xtUpiQHlROzIRch3ox7eeqnTimyGpH
	 9wCTgSX+V9TPHWiD5gNNjwHz854lwBbbYQk2tv36yYt4dZZAD9WllaCWBlxIVKpjRMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KR5uF07M;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9AC606A336
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C9AC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KR5uF07M
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4ad881b6517so4171697fac.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633596; x=1796238396; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vbRNLKO3gfTSOvrqwgbMcGUgGCsHsjFQg4+4l8TI+QM=;
        b=KR5uF07MXjzIt2RA3dQDi51/2c4tp+dtuWqGdirX1owyVd/TYsqbleJq1IDjyKgJ/y
         +8pyeGO1YYMRg1cZnKgI0ri+wYVvmbwO4AuFe23HRKnmrs/qLy7kSI6zm5r1kz4CAmde
         +oPk2PbnEI/XP4LE5gnJdzot2BbczNOgSyc+cxH2ubiW6o7Ob71Uk4OLNnpIttUVKWWB
         nQyj7RabDWLaSDj2b3ki1JhEg3iGRhfE2apN5AD8CapAlC6jmfpGeOix4vY5tSngDP6v
         p59If1j/PCRLXaf+uVhs71IojDbIhAMFNpIAPASQe7HNltpdlGrFQXQw4o6H4772qrnA
         seNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633596; x=1796238396;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbRNLKO3gfTSOvrqwgbMcGUgGCsHsjFQg4+4l8TI+QM=;
        b=LgDQeYHqL32Ufg8oxWMfmgtDicX0/aOsywBSY9jjRryNNMzUJu8EUuuspUwH8+Nclf
         O1Y85l1kQNpFV00L6udoRxNjx6+DCJzzyvQUY6GFFkCFiuDvJdm86wjsIPfyURwCfTpb
         zvYGjsAtzL/2fb7fmOEDGHsyfPLn2CctiCqDYIBMcSuZMgeC4xwxbRsC1PX4X2ylEuN+
         lxewT1xZYFyLQb4wNInmYR2tW7ohJbWgv517KGcUcJhkFYUx7ldaAzwjijmDIkYTUGRH
         k5kHS+W9eX7DWR6DXmX1wegZPtR7ojNf5S3ZowArilSm5XDCYWHvbpRcghWEpghoi5Gf
         PHQQ==
X-Gm-Message-State: APuU4Z/O/gPfWrYx+52EMuFRKN0bNvDwU6i7HY9CtlYIRezmTOmRtGps
	nlJYs8Pqi888Krlg5vUIg1kw6rrajgzd4DmKsboFm7ewwLJf+3W93aoJpjlw6yvz
X-Gm-Gg: AZFdTZcRxW2OMWar+8bwHmfcLr04MM6FE7FLokTPXswhtpHEUx/lWq3PfGKCshDzffg
	/Ozl3LCTk62yvBJw3rwpSENwaVwKGYWOU3sxMhdpj/wEv3L0PQfbFIYdF42r/3GUhoyQIE49mh7
	MtNyaYFmPMgp9WSSxZa393soZnrUUs/TextrSts88RbmGLMI9zLPvpwCVcm3+xlbP3s8Sti8nM2
	umvV2ItN54jvPFiUDKdFdAnKVxwLcxSTiRTbCgp3JXmZt7z9fqAx/1E1mZUIxrqXcEprZEaRRwD
	u5aYzG8Ch5EAFmVrKkRG4PW/JNCxVs/E+bTGjTPgp5zirKVqc7tJJiQh56QHAI/xS2PEx1wuOYi
	JdfqZdTcBABla6xG57rtR0LktF+LbR2c7422LiXfm0EBnkM7Lkt7wlG2rADxO40bvUITIgjwtmq
	9roINb6nQtm+zUZddSxJMauVgvY5pIEB9tLWmrwmRDbs+cXzRfEIfSrnoQ0nbra07v8rX/ZZXwH
	mrONCDdKEPLoI2JEESRYGUat4QaRaStabI0fiTiD/07PXNAFh+5ZcEBtg1LOM24nMJArccR7qZU
	7F5M7UJzFsEcQ4wrL6cQd1folkqMFEmS
X-Received: by 2002:a05:6871:7584:b0:494:a2cf:8dce with SMTP id 586e51a60fabf-4c9f63d0e5dmr4349612fac.4.1795633596046;
        Wed, 25 Nov 2026 11:06:36 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm18904162fac.3.2026.11.25.11.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:35 -0800 (PST)
Message-Id: <1f7845b39a38b5bfd64c1daf618fd5dffbc22e23.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:23 +0000
Subject: [PATCH v16 6/7] remote: add "git remote add --limited-fetch"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A remote added the ordinary way tracks every branch it has, via a
wildcard remote.<name>.fetch refspec. That is wasteful for a remote
whose history is only worth following for the branches actually in
use locally, and it can make "git fetch" negotiate history for
branches nobody asked for.

Give "git remote add" a --limited-fetch option that sets up
remote.<name>.fetchRefmap and remote.<name>.fetchUpstreams instead
of remote.<name>.fetch, so that "git fetch <name>" only fetches the
branches already tracked, as described in the previous commit. It
is rejected together with -t/--track or --mirror, since those
already say explicitly what to fetch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-remote.adoc |  8 +++++++-
 builtin/remote.c              | 31 +++++++++++++++++++++++++------
 t/t5505-remote.sh             | 17 +++++++++++++++++
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index 315100409d..39b9281293 100644
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
@@ -75,6 +75,12 @@ the `refs/remotes/<name>/` namespace, a refspec to track only _<branch>_
 is created.  You can give more than one `-t <branch>` to track
 multiple branches without grabbing all branches.
 +
+With `--limited-fetch` option, instead of a `remote.<name>.fetch` refspec
+that tracks all branches, `remote.<name>.fetchRefmap` and
+`remote.<name>.fetchUpstreams` are set up so that a refspec-less
+`git fetch <name>` only fetches branches our local branches are built
+on. See linkgit:git-config[1] for details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..18fe6f697c 100644
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
@@ -230,13 +237,25 @@ static int add(int argc, const char **argv, const char *prefix,
 	repo_config_set(the_repository, buf.buf, url);
 
 	if (!mirror || mirror & MIRROR_FETCH) {
+		bool use_limited_fetch = mirror == MIRROR_NONE && track.nr == 0 &&
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
+			strbuf_addf(&buf, "remote.%s.fetchRefmap", name);
+			strbuf_reset(&buf2);
+			strbuf_addf(&buf2, "+refs/heads/*:refs/remotes/%s/*", name);
+			repo_config_set(the_repository, buf.buf, buf2.buf);
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "remote.%s.fetchUpstreams", name);
+			repo_config_set(the_repository, buf.buf, "true");
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
index 8b4c7006ec..679d22fcec 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -144,6 +144,23 @@ test_expect_success 'filters are listed by git remote -v only' '
 	test_grep ! "\[blob:none\]" out
 '
 
+test_expect_success '--limited-fetch works in a full repository too' '
+	test_when_finished "rm -rf full-add" &&
+	git clone --no-local one full-add &&
+	(
+		cd full-add &&
+		git remote add --limited-fetch upstream ../two &&
+		test_cmp_config "+refs/heads/*:refs/remotes/upstream/*" \
+			remote.upstream.fetchRefmap &&
+		test_cmp_config true remote.upstream.fetchUpstreams &&
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

