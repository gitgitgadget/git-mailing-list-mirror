Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792503796;
	b=dgsYLIQ/S0rk/yyyauHxw6hhSyCZcIWm/e9M55knUM27DVUJNB7SMbTf7dstMW7QL/qx
	 2ha8NLHfcaL4mV7LLJFCRNx9uDDp58tvLvl2fh9sw8fgJvD7yTORS/m2Zgor+IqWceKV7
	 WiPGYSrSB89ylWdpgTJf4SrlRe1Xjaa4DtP4IH5F8EThH38+T4JofDOed0U75628e97iw
	 344OPT986Mov4/S57tYxBlPY5jwrwxPfNwC6djyLCQORET7VGiXYUnYpjo+hEdyNH/ufa
	 nkxs/9Y4sPCYc410NpnFe3mbrlhOu/ftaKb9mx35gw/LMNqrAce6ShwrKWdnJN7ETng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=PWbEET05LuJCMIkhE/6SwYUbAmbvY74D/LuMihsbBR8=;
	b=wihvcLVxOj1H201DsQKNlfZ87HygMwfEzZZxw89cT5kszXZ/0UH1hFkNsyw/G9SfXqAQ
	 xYWZcz11kNDPgLPf+MJ3n6aiSEhBHRjmkpUYUxk3XrUrj0YKFZLos0lIrwJD1w+SmqMlv
	 f9gPAszBv0tpF/yYiXBcnQh0tPt3BLHAxF6GlnB9U5d2dEzsh3GBuy1ReJULRx7ERFhCk
	 YQXaZmiObMgi4yqxJzE19eXU0vLcM0geLYUajfpuqNfKi0hqv9x6UCMAPAIVJgEFgR+fG
	 TGjz+JdNIOpnElio6A7cyuSEWCh+BbzT2vKy013EX07N29W9y/wemzWBKbTLBbtGUgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIXKtRIS;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC76606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC76606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qIXKtRIS
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so5868886eec.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792503795; x=1793108595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PWbEET05LuJCMIkhE/6SwYUbAmbvY74D/LuMihsbBR8=;
        b=qIXKtRISLLKOwCnP5Av/Nbc+lpIB+7hcbrouDuS4lYYL1OnYhpddF+UppfkdAxSBOH
         gfBNNkF0qNH1lRM104SSJJQPMrbe+ChqarFPIo0wLlGs5iQY608Z0/hbDt4Fwi/8x6R/
         4rKEllqsOaSLmpPkUQJRsJnSuuV2Q2v6HEfDMJ2bKFZrMBOYIBnPoNPmtoB2TYW0mXk8
         AnjKVJBl1oOjZIvsRq9djXLPDNtG+MH6TbtA4/6BbOmgAiJG+JBVrdAyOeVwSKG3VRU9
         xVldixhDksuUboL8egWq9AZrj3VxhfKed00DDxyC3RAnQPPPXlYSZ+thmC/j/yOuvEE1
         /sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792503795; x=1793108595;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWbEET05LuJCMIkhE/6SwYUbAmbvY74D/LuMihsbBR8=;
        b=aV3RtbK8Hbc9ixuiGWzV2DBmXNBsM8gnquDA6/YNGYA1gAo22EdxvlHEJ6o8WGuVrD
         MCsZVXs2I8Nk2oXkc/sMgtmI4NBBrCeUqW6M1iVC5h4y3HPKHR5w9b08Blpq6dMQJxCh
         5HAxxTNXIjPu8dZJVq0v0xRQsAfmoEHndXyeWwslei/vb7izkfvvsvWc3hagDsgSijoo
         MVekH2k4QvgIw9vXkSzyh6nXxu9OoUYjWzvqRwhY3MvQMn7dahnYC2yCnzkF/eA3os9a
         /iFf8Hl4gkocE+UF89wyr+2eDVi7yrNjaZMmtlFmQLg/C0Udqme5Pk70lKdS+hHcgp/I
         sQXA==
X-Gm-Message-State: AFq9FYKRz54fvTOkz8kSzCbR8c7O9l/nKhhp8Yt5/T0xi2nB5jGpb2+I
	NuNntltd/cwcoUM/Qy1Ft5mcv8PAC5H66npa/gM7x+pzg2sOab6LLxy1NDY7BtZZ
X-Gm-Gg: AYBFou00n0ndvB30QOBfZAfZeydtJFNt6RhZ4T1Mb99jOeeeLMfjiJOk/bvtD1tV/u0
	e1gcaPcrsenKZXEhqXQ/h6ch/dPZPMJWPoHF6UFR4lVvZ9JnWo5iEwm0g7abLXOLnfq4Vc19ejY
	4I8ayicEyb2QboIP/UO2JJYlidiNg8xRCa8twqwJUm1rIJOKJsjfQVbz5u+N1pNdtxNarr3Lxpo
	t19m5jBq9zEKwZRqJrecDfmN1FBIPeOw3Vu+JLhg5MYLnxBE/xoqmEX702LNhKBtDg8Q6Ut5OCB
	u8Z7Th44lqLZj+jmzA/Q9Kaoo26b5qI8rygVNLHUlUzpO/47DvMAzUq1XRP/17SiTNn/axwO0eL
	S3eCxEAZYZz84s5j66s0BrwWL95HCa8jgV9odCOoIduYuAwARvUFba5jE+OVEuTFE7WgHBFmYUD
	5o3eva1yxVpGkzuiO18CW4WvyF70LCvUsKFgcOmEavr2z/V4RUWpFFUNx16p9vReblb3F/6YM=
X-Received: by 2002:a05:7301:6447:b0:358:eccb:af7c with SMTP id 5a478bee46e88-361a312cb5emr20950084eec.33.1792503782120;
        Tue, 20 Oct 2026 06:43:02 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.77.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm38973865eec.22.2026.10.20.06.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:43:01 -0700 (PDT)
Message-Id: <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 13:42:54 +0000
Subject: [PATCH v10 1/5] fetch: add remote.<name>.refmap
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

Add a per-remote config variable, remote.<name>.refmap, that provides
the default value for --refmap the same way remote.<name>.fetch
already provides the default refspecs to fetch. Like --refmap itself,
it only maps refs that are actually being fetched, so it has nothing
to do when there is nothing explicit to fetch, on the command line or
via remote.<name>.fetch.

A refspec-less fetch with a refmap configured but nothing else to say
what to fetch falls back to the same defaults as a remote with no
refspec or refmap at all. Only an explicit --refmap given on the
command line with no command-line refspec to go with it is still
rejected, since that combination is a plain mistake to type, unlike a
remote.<name>.refmap configured on its own. A remote.<name>.fetch
that is also configured is used as before.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |  5 +++
 Documentation/fetch-options.adoc |  3 ++
 builtin/fetch.c                  | 10 ++++-
 remote.c                         | 12 +++++-
 remote.h                         |  6 +++
 t/t5510-fetch.sh                 | 63 ++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..103eada406 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,11 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.refmap::
+	The default value of the `--refmap` option for linkgit:git-fetch[1].
+	Used to map remote refs being fetched to remote-tracking refs to
+	store. See the `--refmap` entry in linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 47dea1de8e..c2101a7b39 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -244,6 +244,9 @@ endif::git-pull[]
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
 	Branches" for details.
++
+`remote.<name>.refmap` provides the default value for this option, the
+same way `remote.<name>.fetch` provides the default refspecs to fetch.
 
 `-t`::
 `--tags`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1f76ae6242..ffcb5ba29a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -518,6 +518,12 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	/*
+	 * The --refmap command line option, if given, takes precedence
+	 * over remote.<name>.refmap.
+	 */
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -561,8 +567,8 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
diff --git a/remote.c b/remote.c
index 49ee2ea318..c9252a90f4 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push, the_hash_algo);
 	refspec_init_fetch(&ret->fetch, the_hash_algo);
+	refspec_init_fetch(&ret->refmap, the_hash_algo);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
 	string_list_init_dup(&ret->negotiation_include);
@@ -176,6 +177,7 @@ static void remote_clear(struct remote *remote)
 
 	refspec_clear(&remote->push);
 	refspec_clear(&remote->fetch);
+	refspec_clear(&remote->refmap);
 
 	free((char *)remote->receivepack);
 	free((char *)remote->uploadpack);
@@ -539,6 +541,12 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		refspec_append(&remote->fetch, v);
 		free(v);
+	} else if (!strcmp(subkey, "refmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -995,7 +1003,9 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return refspec_find_match(&remote->fetch, refspec);
+	if (remote->fetch.nr)
+		return refspec_find_match(&remote->fetch, refspec);
+	return refspec_find_match(&remote->refmap, refspec);
 }
 
 static struct ref *alloc_ref_with_prefix(const char *prefix, size_t prefixlen,
diff --git a/remote.h b/remote.h
index cca02033b9..ac485a584d 100644
--- a/remote.h
+++ b/remote.h
@@ -90,6 +90,12 @@ struct remote {
 
 	struct refspec fetch;
 
+	/*
+	 * How to map refs fetched without an explicit destination into our
+	 * own namespace, the same as the --refmap command line option.
+	 */
+	struct refspec refmap;
+
 	/*
 	 * The setting for whether to fetch tags (as a separate rule from the
 	 * configured refspecs);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 17c0be499c..ec5cd9dca6 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,69 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success 'remote.*.refmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.refmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.refmap \
+		"refs/heads/*:refs/remotes/other/*" &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch origin main &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/side &&
+		git rev-parse --verify refs/remotes/other/main
+	)
+'
+
+check_fetched_refs () {
+	git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
+	test_when_finished "rm -fr fetch-refmap-baseline fetch-refmap-upstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch other &&
+	git init fetch-refmap-baseline &&
+	(
+		cd fetch-refmap-baseline &&
+		git remote add origin ../fetch-refmap-upstream &&
+
+		# Without fetch refspec, but with fetch refmap.
+		git config --unset-all remote.origin.fetch &&
+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
+
+		# Nothing tracked, nothing fetched, no error.
+		git fetch origin &&
+		check_fetched_refs <<-\EOF &&
+		EOF
+
+		# Nothing tracked, explicit ref on the command line.
+		git fetch origin main &&
+		check_fetched_refs <<-\EOF &&
+		refs/remotes/origin/main
+		EOF
+
+		# With both refmap and fetch configured, remote.<name>.fetch
+		# wins: a refspec-less fetch follows it as usual, and
+		# remote.<name>.refmap plays no part in deciding what to
+		# fetch, only in remapping something that is already being
+		# fetched by name.
+		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/origin/HEAD
+		refs/remotes/origin/main
+		refs/remotes/origin/other
+		EOF
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

