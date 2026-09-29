Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D14E0210
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673621; cv=none; b=TL47NUJ4ukK28lmvGbNxUdlkAfrEy0Kz/XWR6VVcr4LB7D4RmBXGcoThIzZCBffQc33KY1Oga7V4H/VghJcbH3bKJS5ZdEyJjYTeOSPZu5FqnYqQQtD5r4UFsQ4mGsKjq4kpHYZ1lSzt7vhyPT4FTUkum0zLrva+8A20G8fGcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673621; c=relaxed/simple;
	bh=ueyd4/mNBo2YjOZSNImN9F7DjYz5U0FIR5X3g8bc/vQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XBSn2UKMm7yeZtd/u/B7MMErgl9Yfvt7sW7AegujyVq5wF3b0Eo8zlx7CIRiQ+799eulStI1Y78k8Ze6wX0JxBNyETOR3WcIdrSjOI9NLlS7d1UgWpvRfjR7it6UnPfIJqojt7lR4sHGJ6at5K43e8jGWCdNS29wTQNOXZrUH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RksOoRfe; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RksOoRfe"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-53325e1d289so13861931cf.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673603; x=1791278403; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UnNTok+xSCjoALwMPgCwAp98VQGEuUENBNZ1tMLOBzY=;
        b=RksOoRfeswsQA3TYAUO46y7pRWOf99bWeHOzo+L0yzbBUxU7E46IlzeIH3tNHR/qCl
         lnioDCvYmJiiSH7b2Kl0gHe+2goqapdpvi2sEtlGCRBil8p0lECA5+KXQPgnoRQJiCxw
         dfG6t7XWwF7bakq1Cx2zsXREdne4pwof5/eiumYYjiyfGltTudYmNpAbXYQCkv8Ah531
         ZWGC4KJzcnaxLY84lCcRrPci6VqyoYGPVOBRB6uEozc9Z+0kuyAxUW9AGXUfA9v/6UKk
         jEUQNmH8QJIaLTMwqAWztclV6mQP1S0qojmxtM18YH/xzJi2E9ef7bZkCnBMNz23Rdsu
         XjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673603; x=1791278403;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UnNTok+xSCjoALwMPgCwAp98VQGEuUENBNZ1tMLOBzY=;
        b=uHOab7VCCndXgdL4ZUR1yAvkmMDg9iwOYUjCYoDcvdXLcRDmdBiZ+sHOYcvVBB5DJp
         XP8Yr9HMIrcETanLhv/9WOqxQtTUXSqqtIq4o2pL0gJKwBrHUc3grPwQ1a5KPDEMfnKR
         dEjnYn2oFOedjYhlY6npQdaVXqMGt8QQOfpk3pqiErxmYMHqxhj/aaABeQG5kHu9TG52
         jqe0ZzeRX7WFzWEXTXyvvXQgL0H5/TskxNn3d47GRddGTXBRttDsFR5czcsatdGTelE4
         MicnDORE0bZO0m1tGuKBlUK7Jhw3GFewTghALvulgIrS8TB96VY010J+qYphQkYP9AvI
         kvhQ==
X-Gm-Message-State: AFuF++macC16Qsu//eGFqFaaloEILhzXKD/G2+5ryvphC5vpds5xR7h/
	heddcxfOW5zmY/EZ+8bluimfCjjaog6la/GiiflIeEULQ/DGKtEfU2nMLFLUO26f
X-Gm-Gg: AYBFou1f+A/kbl0muAjJGkT6JJYHXbTqfcgHjsW8OgVS7yA6nb2XzHg/zx4cCYYCtXZ
	Z2GCv2sjOPuSpw64IjWGoPQ5H1yudzYRz7Fj8/NXNTkuxvXYOPhJBjm7jcR0rMB2zcL+o+OP2Xt
	Lq26keQ8fzt6nFeIb944n79hXUIHiSo7HdD877jHPH3b0jIMJNZFP0ewJNKpVyla8c1ex95wYzu
	Z5iz2apn9psuhkyllgNXghwHLjO8uyvi13m+5nA4JYLwFoyPF/pE0jhI2C8o6Hk25gyEvQxxyfd
	QzReLDWrN37WDBkG63wrubj4RnM6QAojIapa2ibwZKt1vfPODlOQsZe+QpcoTNYut4tljoSgIlU
	alfXmGPpnZDVNBgEM7Lz/Ys9BGfb6dr30KYnWc2J7iFnFcfcc8NsuX2c5DsOebUdEJzqaTYI5Ye
	4aqDgsbvXBFwskCimWhkpjp+Qz7XcU4HVkJF8tlb8vbVd5l/+z4++V3qr1zQ3ScedPFfJcw9mx2
	o8=
X-Received: by 2002:a05:622a:1b86:b0:531:26d5:ac3 with SMTP id d75a77b69052e-53357f411aemr35752491cf.5.1790673603331;
        Tue, 29 Sep 2026 02:20:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5335c872abasm8244691cf.10.2026.09.29.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:20:02 -0700 (PDT)
Message-Id: <e2f072c254d00473c11c1ac83cc0631acffbaecb.1790673598.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v4.git.git.1790673598.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Sep 2026 09:19:57 +0000
Subject: [PATCH v4 3/4] remote: add "git remote add --limited-fetch"
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

