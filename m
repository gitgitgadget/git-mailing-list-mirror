Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357570;
	b=P1lXfaVpMqO/ONVnwuhsFeWX/CUzaEytWs2B4WuimrRiv6CT2IksLs1PYSQCizRUTBJD
	 WbLkaXrLLJBST+7j5Qrxp7ln3KF//ct+t0PK0Fwu9lHhGEKPk06WDqc8Em7VLd3v/6fHu
	 M0xLQDN2HcYnFlTGv+quWcorcAu3Ao+EfI/9MKrvn0htSkjbQGDnUB/bRwRCM7+arD7Fg
	 gp+c1OM10RE9We0LeUguUvgglN+TUVRTTE86p8TZYWTYkKDUue+pXp7QfY+jdIxjBJ2e8
	 Y7tdz/P9UnUpBuJWXyxv9D7LQimZ2zjtP0eSZ0qIKjjWYlS04ZNFtdfd0jwklj+6rSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
	b=Eab5T4PwNAJN626l/m+q4x4ZxCzoP2t+b4oWHF1Qsd4bENaI6ebz1EY53xMMD7vicigg
	 nKQJQsWTjT4QdYaxFinGz0SDBXn925u9F8xAw4kCy9zhmdEr0hYjULv2rGQm232+S+ipo
	 /fId8MolWwdXhpia3Gco4PBBanxLjp11aaP4WF2qKVhBRWK4vsze3H9eMdRfZuaYC6ZbW
	 b/dCL+rajE6Q31mjZ3nAVQoHv0WNosJlhDVdL25kmoEceAEgMjyaTh+pzmLApC3jjZiXv
	 j4HXZwFl6TTxMqW7dC92wDrd3k0n1Bxl+XJdzr5CDuG8fvhucVVUDEfc6EWhFt2dF6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBnjvfdJ;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB9606B944
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DFB9606B944
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBnjvfdJ
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6f8a519e215so536878eaf.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357569; x=1793962369; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
        b=xBnjvfdJuF6YbyqEkPAVa1OwENxUKXbeBehcEYL02k2GvkERPwLwn9CdAUGAcLioIt
         /++E8i793hGskuccvwY+yJdAzwjCeCbb+RoiVqWtzycWmgyUk0hLfuADgFYqkrnyZtMr
         I96LyHF3xPhcFcbhVjK7ZD4JuSnm8Zwh1FD/IAIMW9xGTfbnlxUvZsoopfFL/UDjw8P6
         yTL16pX8M7WAVx9yvzgDho1X4Vc/ULf7FB1usftnMLEpyXL9zJUHprx/tXWV6gTPRUbz
         HnLr7qnoJToqF4gMJnLXYap44MPqcTpwSl4WrwvaB82VrtQi2ey1SfP7WyF8HnrjjJaH
         eJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357569; x=1793962369;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qb6kEjTAX9LgnmorcutDk5fX1OCgdO5K4pGR7JdvRII=;
        b=dzEfB/+Bk161kUnfz/LSmuZyo6Kjfl6TD+pa1ixlmb9YWhhAgVJvI5lC7qX17Y12KC
         0u5N9eilgDgyEsssh0deUc+rX/obMj6VzyLLuZYTe9wbD51szBpENFdb6HC9ik0GZAGF
         0vdq2V90hY8r6TG3ZfTmIbg5QJqwh4UsOFb1w6VIsvp5cji38yZ+RiAx20gSeqP1dC7T
         VZqUuZmJRHggiXxlUGMuepeofd6Ac/Lub0K/C9LcnFUeez6hBqpGY1FfRX/YEyYe+ldv
         yk2P3qEOh0dFgVliXG75ly/3LcKU70ndp3l0vP0Bt6xNe765S8W6hC8xW8opMD5/jxAD
         /4ng==
X-Gm-Message-State: AFq9FYIM7kK0xzvd/7ws/lJ+l1xqBxNqBdbhRjJv1YEWwYZNVxk6q2gb
	akxv8hfa46TXLCcKfp5+VcnnOC+eBkFWD5LA5y2BwI/E9N0DZieSDfMBTn08nD+M+k8=
X-Gm-Gg: AYBFou00Lf8jR/+8oOmabhsllHP6z83DUSjHowYmZEYtYvPpGbnXJFkv2MjVzTqSD2i
	KXYyhZF4QdHlOxCRnifX4tIvespNLe6tucuVXNnO2pUX8nzP2EN5C0YD7rLa5n6r0gEb9SZ27G9
	SMvvb9JNE+/TfwtJ3ylEPlMVux43RlxDx+nzhMzQH4afGUUpnytaIgPZtbCPmC/cMohnyNdMy6l
	ByvSP0u1WV2xXx2pJ49hA9AtKrqsauEImrKfbRF/Qp5AzLDgqJKREgi6/uCei5hUcKKB1ow7not
	ch1xgkIWAXp+ddyDRAv/o2wTWccNIMQuGUzvQzen4EshtiDLrElb57n9JJL3vDMXENQIKMOfkrX
	aamzJVH6pdkw4MhQmHqkhNlzhnO/00T9QojAFh1yyR4p+IEkzwxcc5cgz48WlwWdV7sUwGJXlkD
	CTy0mAg/VwAvcZJ9KIPGL3QdLwNW8f+j6KBigjVbXLTpnQ5nPb/ZifAYYlUJ8Mg1Rx95mYYQPwf
	70WMxsjQMaQhD6SLP+aS/JmjKUkc0Mdh617ZC7AE2acS9WC9juvngYElkxa3EilFp2lTJZLFgfx
	uwg5cnoqOsz6HEjybIf0nc8BzXIdlD7g8NRwByobprpOeWAmjPw=
X-Received: by 2002:a05:6820:f03:b0:6f7:7a4a:9d70 with SMTP id 006d021491bc7-714ddf1bd5dmr2684255eaf.29.1793357569121;
        Fri, 30 Oct 2026 03:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cd9bbsm1664096a34.16.2026.10.30.03.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:47 -0700 (PDT)
Message-Id: <3ee427de87a0de19774fb9385f4f7496cc45ea11.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:28 +0000
Subject: [PATCH v13 4/6] remote: add "git remote add --limited-fetch"
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

