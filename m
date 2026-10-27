Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103891;
	b=Q/5NtI/SzGlx6uH80e83hiTln7DduIumOKkRVExE3+DrC68imb0oaHHFISCxODA+F/xb
	 fNEyDkRK2FTtGNOfWv6Vk5nWXOmBFMp+6wOgeyDA474uOkNosEewV+f7zmC5O/0vwCpWc
	 vm7pjMa66VXW4Fcu3s0tC96uDxbj1voOZLk5KmB6MxVUQQPlC9lPbWhE8BlmCKMOYm4xy
	 oeOljrznmtlKqsz+nSz6QqhRkxWng8DpfPBzaPlj6zIM61ss5D08fH8JG8fpI1cDQJ1V9
	 7iTbvHe6R+JD8Kpd2nhDc0TSKPXJCdaD4sgPKeoxgZj2Cf8VCCIZYCl++/u4a2Drq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
	b=vrKLvDJfpnxk2GNUqOIHvqZZGhcqFlbiYANVMcEstiYDvCW8KFPRLckpelYhou7XQJ3Y
	 omRfwCp911vbhDukwbzwzMsUmuM2HbMPGJYJor4HUo4BifwAvKw3kVhKF+jpQJCYIXxKs
	 tY9TzGAQjp6wO4IFH8eqf9AhNwn7jgpW4J9IszMx4+PZMyT77EQRkeKU0tdqJ0vxTUxiP
	 67gumL83JLQa9+FtR+9Qdyw3xszjpUG+I6Ako6cD0Uxjf2u4SbgqEXJ6RS6q7xH8Z/C57
	 xGY4PXJQ/X5qmatXv8WDvihg8yuiruxm5OfU1tZ4LbUY/9UO9HjEkqHqq5R+fn7Awdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g97yMEln;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEC60A261E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59EEC60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g97yMEln
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8726acc5eadso31631907b3.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103890; x=1793708690; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
        b=g97yMElnxFJgBTT+X8v26XDHLZU8m7rnoDrqjMVFSlzWhLlPOCspyqsCHjsrOJNhVH
         nfEZR/wthQp33Rfsy+SM1ioHPYNOsM0hLY0xtJYJvujDsPj4FOjiZ5CmxJPzoZPkDNi6
         4YCYnXmjBjSWKIsATMCXLkYdMPo4zWBEHBhXj2wmAIqbc1TS+Tf2YPRmtC1br9ArF9ci
         3iBqOLH5bY5xWUAuEi8qTDKQdHD22Lj8coxmSS0ZM0pTzqZZPc7PLyfQfQs9tV33mQ99
         qw/68jmkR7jy2T20SKJCCDNxpKCR6KdEU6pz1eKAR+A2Za6OSFcMfuKMXf9vqAEfV9wE
         05RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103890; x=1793708690;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
        b=LpEHWquoqW1ltD0eaX/hlVTeIuA2Vf5h2ZuKdimfiHQX2I4wUcOZAg1cc0upDpOzfv
         a3JHYGfvdGjwOyHsRP297nlwaFB2RtfxS7Xe2704yibdBx4wI7EvjyPm1yGNHl9R8ts+
         Gcl9tEJE5AT37QBQcnGjcbI37QkbBa7fltaL3n7QvpHMFBxCWMYfMKkgVwcNyl1c97UK
         47ex+sf5fUwxkP0bMockFGpDxnBqpQw69XOipFn3tFc4rWKngipzY6R6xEDfm+LPau5B
         BIgam7pjfE42LV0WHJ4vQm3H+I2NwCeIgrAfEAqOc4N8PnCNrIlN5gUACmo8VjX/KfGd
         n0MA==
X-Gm-Message-State: AFq9FYJmtTmMGslnUlC6O2v2dMMfFVZOsUK6gCy8pjrhhNMPDJwyvPf3
	3h1rFZ8TzlK7v0nDzlDwfnk9TpawUAtMPKueJtAmfqPrTExFGONgG3xw2naV++Bb
X-Gm-Gg: AYBFou3NTX/fXv2ZAao+belUcM9bAY10m08iHfZcO6Fzhz99y0506JWwIgSiJrcYiS8
	ntbpiGbkn3Yd60WrQHVfcyzxJb+qeh36lIq7tVmq1rIncnzPniova+YJRtKrSCTlO7HjwseqUCy
	Nx7ODF1ZWdqmN9Ga65VX0OtKKOfP4mmhADgVv8DTuGEb6tBgE1Ia926DVBfGPuepvt3rdGrvERS
	E8xGUDsaahvdqP/TY0m3eMRmmwc338DDP6wI+y7+zovffrisMaBGMFxnjQztyXwkB5Bb9nIGwAC
	aWn8VOHmbNxFN86O3SHAc0CPKiSfQ9OuA1GdA+QTBT98gX8UcuOb0HIR/aWXiCDjZ+/iWFctaFq
	ee4rEkNtDkPJzk74qOJOX/qVvNbSdMTZynZOvfC7KibMj0it09CVywe0g5sVVa1YEfBeh43GRp1
	5LVCZKnZ3l1q2ckgElnd6TtI1iGqTe06I72JO2n+QFiF7KOKgUwAws6W5THHXdAVyEb3pbwYwpv
	3Gyb2Mb2pLgAPhG19MjkrJdVP1i6TQO5ErS7V7yD56jjHVqAt/Cs/aIog/6sQ==
X-Received: by 2002:a05:690c:ec5:b0:8b0:e13c:2853 with SMTP id 00721157ae682-8b166b9a46fmr80164157b3.15.1793103890134;
        Tue, 27 Oct 2026 05:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.147.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e64c780sm10012897b3.43.2026.10.27.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:24:49 -0700 (PDT)
Message-Id: <97650da87045958a769c3ac66ca5afd1d3ec390a.1793103884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v12.git.git.1793103884.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 12:24:43 +0000
Subject: [PATCH v12 4/5] remote: add "git remote add --limited-fetch"
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A remote added the ordinary way tracks every branch it has, via a
wildcard remote.<name>.fetch refspec. That is wasteful for a remote
whose history is only worth following for the branches actually in
use locally, and it can make "git fetch" negotiate history for
branches nobody asked for.

Give "git remote add" a --limited-fetch option that sets up
remote.<name>.fetchRefmap instead of remote.<name>.fetch, so that
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
index 315100409d..1f490819ba 100644
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
+that tracks all branches, `remote.<name>.fetchRefmap` is set up so that a
+refspec-less `git fetch <name>` only fetches branches our local branches
+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
+details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..5f8a8a2f71 100644
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
index 5fbfcb0848..90cba75f93 100755
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
+			remote.upstream.fetchRefmap &&
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

