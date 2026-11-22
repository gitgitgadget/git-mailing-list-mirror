Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348656;
	b=b0u5UOu1iqNaY0niZzqTHLD3DBXfwADWCakO+2H7aHnIb+5if6Hu97zpQsrolLsDw8FK
	 orA2m4IG4gg+LHElIjmIgEBDl8bMpK4iDsJKFpjOiue84mUGK0adTSVStkoRTjnwiiI4F
	 B8WxiAkquga8EAFAASqfwkF7B93sY0Ufa9iqd+SEAYtL8z4ijC8GxUacHkofK8hT9/1bj
	 XIqAiCX0NFJWKh5YkyLUu5ZNokmKE3eA73NZoIS0thYRM03BdFp+GuJ9QzZMme8ZPuIJW
	 JGHReP2lZsBr6LkX9ZezzKgQTkdkZ7ArcwXkfEuLWDvzgeX78lL6G9Llc6voyYTTX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LUzyIIg0B3dCbQnUIPjYd7H86SDm59+PA9QM50b/sh0=;
	b=ejWksk8Z2EAJjJek9ZSK5fKBl2OFHX94wMsEuyeAAE3cRRyk5yrJrF7OLrC823J8G2K+
	 txC/j5apvW6mzTgTknP2i7cAw3/2T9/2+ET5zGhzCIgmTy5q4pkB9I23BqInVZx8kF8AZ
	 klkZz/n1OJXGA4p9pBHKH3s9zUuPSHo7iPDdXhg6rsiQEqsLEaKBz8J47d3OKYCNxfYua
	 TcA/NIx171Jizrmn4LmwcugHQgDwAeBVAxH4h87erI41y+iAZ/kAvlCbXlgPB2bEuqjhy
	 DBlSffGB1+D9MSF4T4mOIoV5hc6anBLecUiezdVsmIgW8W7t3wIKPYFC9GeuDiKl9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hq+urmPa;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C358606A336
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C358606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hq+urmPa
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38699cf08dfso1810171eec.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 03:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348655; x=1795953455; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LUzyIIg0B3dCbQnUIPjYd7H86SDm59+PA9QM50b/sh0=;
        b=hq+urmPaRpmw3Bt1Ka5Gk4Xb4+TGEYwQiTNz6QH6X0VD8tghFp9+aqYIdlbIZz4aEe
         GvoSpgqkw2IIqYC4D+kHgH8RgS2pwT2FYrnrcV3ZW9Moltzu6vSdnaXMFIsxzmAovZ9+
         aV8YGd/lEGmQhrIkvOjDYCiXm/RtU1wae0OA/DDjPncqrRUqzZ/1yWLucwWHR/pW+pD8
         GOr5CXWtnkg1iBJX0nI0+UhuJU1rtFfQ4LgxYrqg/1dPvyVX/0GqSIR3h0JGmtQc2Wy2
         CJh0XwKBNcWLJhXq+pVmhcpDtQbm65XgVWCtm9LNkbP3at8q6+Ldv5zo0SEydWUeY/sv
         TqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348655; x=1795953455;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUzyIIg0B3dCbQnUIPjYd7H86SDm59+PA9QM50b/sh0=;
        b=jmq+4u8y4J6kvh+sQvKZXIc/hvDTO1plnwRZRVJdWm+i0/Cy0Y9iMnHvIiP/p3n0uK
         di7bxMtcNthRCSChW4UKjCQHrkvNyJpa2rwIKZNtPj51YGvh1FsytSSELmE840IZ6TEQ
         KoPsGlhEAZ8qOkTbKY4v+OqO351weW/YcOkduHTgpcWpKgre5EhDYFlUWvB9Tc7ZedOm
         5Ecb808uPeBS6PExubXysLQgeE6DCrFRBB/QwatqjqMOH2X4tpnmyZvuhFq4nilUqCNn
         aWNSXiWSOGWCoUghrYnql3IXojH9ShihshwTd89sSsyrdajEgcjbWuDXOEEjoe5zdxoS
         WQbg==
X-Gm-Message-State: APuU4Z/Jn+wSS3TcVYoe1bcY2VnVwM9wJHUeLCjFOkIT9XYor22pPvOa
	85Fmqc2yS9+h4TAxyceKjbqCCFuYaSxMb8nG7wTZ1KbwL9oqVihywBidOGEbcw==
X-Gm-Gg: AZFdTZedOrZ3cy94Eublz6sY/H6C/V/TjcVUH3tJwt3+C2A+K5ovuTqmsW9DcPfoSHR
	VGtHcT2xAwpeQz/l9dtkctQDPbJijleoLIu/UpN4NdCnvVJ+373x4C1mJXe6qpjA7yQRs467RbC
	xfw8FccJpZbxkEEGqeE5+obR24UV2lJMZCdWwt8D037ZOYwtqTj3HmztnaFtazNmraosxPp7RQ7
	lHPHUxi282p+Un9m2GZjWzVr4JhUczezLrvItv6qZwIj+XkQC2Bm4hBXnz58iQyqOZtbvHIImcx
	IgEr492WamMnMIsxMhJvm5+1YomGoGA0ahgK5K4WQs03RPoJzoA7LmWx8vqP5gWqFBam4rSMCo3
	bu17Zk4yVhZXDQug3Hh7U1EQZrVYgLqugq1H1+OnHSd4WYoT2uPPDS+ytzIJh7kWYZoz7kWOp+u
	zRSxIqOuPp55rYczoPd8bWZOy7v3HSGPtK782fKYbcVXy0sHQy9GTIpU2N3a6z1IVgwvxezHSfR
	N1a75pl0kpL8E0u0Qrs90ZWH5+6lXroK7hXIY8Ywo7hU3IwCgZCR10CBp75+8gzmcjtw7/4nRun
	FL43tAIZjlyGvEaiL+4arBYVVfzhqwKw9/SGg9rNFIa1GD9F3aiP83y0
X-Received: by 2002:a05:693c:88db:20b0:386:1920:ea0c with SMTP id 5a478bee46e88-3861920f023mr6805482eec.37.1795348655097;
        Sun, 22 Nov 2026 03:57:35 -0800 (PST)
Received: from [127.0.0.1] ([20.184.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm31190193eec.11.2026.11.22.03.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:57:34 -0800 (PST)
Message-Id: <e60b61e1177cc8a3f837a9020409592b06aefe29.1795348644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v15.git.git.1795348644.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Nov 2026 11:57:23 +0000
Subject: [PATCH v15 6/7] remote: add "git remote add --limited-fetch"
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
index 5fbfcb0848..73f0125907 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -137,6 +137,23 @@ test_expect_success 'filters are listed by git remote -v only' '
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

