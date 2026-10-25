Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959928;
	b=V0Hfh/nuh/7yfDTY/wVeFppuxlt7Mu4A66LgE+KGVjrgdVZaSWwSLoG6jI1i/0GT9reP
	 qcVJ/GJnjtrJdCSnFn4qtspJtp18lbB3PGkCVHM40wW/u77Bdd+USbh/ZEH+woLovrmGD
	 dtBcWtl+MgAaKZVGI7dABYNG1afO/CoCpRAIZk63yzQqjyVBgBTFEuYSjKKqv5tA9LcnL
	 nPxfevrltyKGia+J0ezwaiRVOglPx8jmW+Ou3dWnZZKMaYO+WSoluDnrx4qep8PU0tIqG
	 Y3W9hJpvrPAEldJOMYXkck8/15LGvgV8uU3qIeb1sHy4n+KNQq34g4qQHOBJZamj/tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=M46PqHfTeOWHHTBsk6DbcOKddagGvaGtkBLqAr/hGV8=;
	b=Lk4nxq2k6LN6xTq4cTPE4XZGc2DdYxQvreDU7FPetZKk1Sc6GGC1T957icorGyRY1Zhj
	 4aOXNgEDYnmK0vwDXAUzptEga+jIUIjR45lfa4/lunnqZ1yNs2ZbdlN1cmn9FEoJhrR/D
	 oYqKl0QR2lTlAORbTf+EIdKs9do4qNNMTXju1SjtUf3VMjj3QbFZEE3M8NReC1048sgMK
	 LGAzoMkvROn0619MXxTtF3LZ8Whmv6bRu/RDZLrxT+Aph/fGMO9PsqhYGBL75F8MInA2z
	 g7mNJB39ojtHZAVHqrYoCD+3boNKgJAEFTtgHPKhaSSr31mCI5JxCq9Y+f/XG1nbBTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M4oj1vHO;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49165606A31D
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 20:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49165606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M4oj1vHO
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso4605474eec.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792959927; x=1793564727; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M46PqHfTeOWHHTBsk6DbcOKddagGvaGtkBLqAr/hGV8=;
        b=M4oj1vHOnNr+vz+WjzpaaPOJxAcWvvT2zqq5Qfd4fAqZTnqaG8cZFPLfgXp4yAiFnH
         GSbMNeTDcJ/f94NYN+r8dZuZV1BoK2D17WUkW1oq5h9WHjkRg0fapXPhOHCs4foKV9zF
         HYZNE2Lv6fnjxkabTixh02i9PQOW2omatbYZSE7QqSycUHRBPDtCubhKG3FIUtCfBTVO
         DKPosp7nt9UXoNwRewKVuyqqfKvqyIhuc+ZWqOviJXeFPvQjF/YWfnETVqXVq3Gjj44+
         BUbo7VbXF1J2e6PvsbPH1QrMFvB4STo2rypFcZ2YbQglwh0RBi4iJR8qcV0BGbaa4oXI
         KLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792959927; x=1793564727;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M46PqHfTeOWHHTBsk6DbcOKddagGvaGtkBLqAr/hGV8=;
        b=pK87qygIKgNosjLLcmyX+JpmiP5tGMMto5D5nQEPpuolqfxp0Q2eWB3buHs14SNAwA
         iRa8ZaaJxnh2CDaqhQeggQaTMFYCo+JL2BtJ5+O3l9ELoNLLfYsl2QVchCShuntvvJrk
         CGt25x7aGYBws5ohuZHlw9/cfX7wqh/zkikRBm+H//KFXy2e2J3OZbQpEgxPxis37abi
         YdgJM2LW2gvZq//AlwXf4s1qLBLDYvAtHtVyuf3tBxAVjUifqIEhnj3DuaxGwklBjlC6
         8CGzA/vDE4fGVJkmLOs7Osn4K6bWf3+liOHUUWR/+SJgfL5FC3oqiCDUP1DxTNt1g7Ju
         fLFQ==
X-Gm-Message-State: AFq9FYJDnvf5MLo+UHm1WSt12jumQj9S/pq6CO0DOjuL/IyxJntxJGtX
	EatzyeDaIPZAWegmkr9OwaJwdeNeAV9j9bdyp37afnEHC0e4EppUzCFQoU6ZXQM4DH0=
X-Gm-Gg: AYBFou0cuDlMu5A3e1hi7UWv+m6gCVKomTEuFt4GhjnVbpUHGPWKGS7LKJmBmNYmEAI
	nsJHMudHEeuhAetuBPGfAwKlu3wXF3mPe51fbBIi5Nw18njhmlJovGsWdj9pea3cVB0IxwfN+LR
	hB8ttP30l8uaE9l/SFXkWNgchAiirch6cVCjsQSJwcZ4ZPYpCUz/3cNdbWb4xS7taJ9UXpyh5rd
	cLx/m+g0+4jdUv9sDxNBGsmJr6MarDI9YartaPuxfzYaJ/oRFukxWEpnhK0Uu7d/You4x4UNpuV
	AUTIDTMN7sGrTxz9m1DYk/3ZA6Gj07TgPo6EsqTZYTIo6323rWx1XXUvVPiHnHhWEu54ygpuW/y
	yNqBbWh5WLJkro0CZmXzp41VKaCgQwFQG++m3meZ1BzBfH7hJRLLtbsni5yZevudl531jkA7t4T
	4jku0+QEbjmPuoD0a5+NT1oPzR3C+VRbYouThVirX+tuEtx36/XinkUsHqGi+w6l+ZnCJgg+L2X
	1AxiomBaZrSNjPpwWUiRl0NcNYuB6xOCaDm4gJJq1RebZtWDx/jKqyQ
X-Received: by 2002:a05:693c:2807:b0:369:eec1:1d7e with SMTP id 5a478bee46e88-369eec12196mr6178212eec.11.1792959927176;
        Sun, 25 Oct 2026 13:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.195.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daa3a8sm23545371eec.16.2026.10.25.13.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:25:26 -0700 (PDT)
Message-Id: <417f14d70891957aa9fac296b63c461e9fda8e95.1792959921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v11.git.git.1792959921.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 20:25:20 +0000
Subject: [PATCH v11 4/5] remote: add "git remote add --limited-fetch"
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
index 315100409d..f8764394e7 100644
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
+that tracks all branches, `remote.<name>.refmap` is set up so that a
+refspec-less `git fetch <name>` only fetches branches our local branches
+are built on. See the `--refmap` entry in linkgit:git-fetch[1] for
+details.
++
 With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD` is set
 up to point at remote's _<master>_ branch. See also the set-head command.
 +
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..7e81a91aef 100644
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

