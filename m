Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357562;
	b=MqaWTt4EZV3bBm4VJjHe5jVtdDmX0Gjoof8hcpCp2QIVT/SbKdsS9BtHqUSSQwIDyWLZ
	 V1SWWdVsjpYhFbKWDagiBHedT4bnOiB+AP0i7JWSIF5TGngprOQo8+mfxdcYAIG26RZ/k
	 8b5p6JEuXss5ir4S2xsJeN1ajmj/TwbJLnOsB2kGe3Ps3uZDhUJaDCdLzHVGsSqMlSZi2
	 biTc2JhAgSyiZiFbctU4Q5g52W1/3XcYOx34MZYCi6MH2hCp7bbye82PMPx+i8QArmeUv
	 M6+zjQwZE8s2/h2yEfUIrKpPcHtdWXyjYf1CHlJcf/YIhTNn+iIGSu3It4RJkosSyrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=ENCpY+q96QKy968xYsN8LP/ZjQE1WO+qrun3mhMQiSU=;
	b=ISfiwoPCuf61aT/45aQEA0Aeseue+yXZFk8GuD/4QRgEYpkEYJSlcu4ot67KufBF2Qhl
	 gluMOAdfV/KbiVlSgVEC+Ax+5OkxqGuqA/z1VkN/vxq2B+0BEH397Tv54YqTrnugXnq5B
	 wNRF2RechNCVUL683bkODB560ClM0u9BwNZXCs28xSwi9Ghgfv1qsjSlIYKTEWxSLHXsT
	 CPpkDUJVjtphgxQwilQJiH1egIHgTQcLEOplmJ1VcY8aM9R4X/6GHJFAYM9ePyXPYM0+t
	 DHN7q3QoH+B7f68F1sehpNaaSBDC9uOERzJ9pbajhnQU5Pv8vIMRqTxIkVSbgra+Quw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIv3KN7P;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D85606ED81
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D85606ED81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIv3KN7P
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-704597ef1d8so197025eaf.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357560; x=1793962360; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ENCpY+q96QKy968xYsN8LP/ZjQE1WO+qrun3mhMQiSU=;
        b=iIv3KN7P64c3HvxMNuI8TaY4eDL+cvBNwugnqPTmkBZWN5Iyxpobc+ZSwPgnrEqj1w
         R0NVRMvWFCMmpISUrhKG5wYlT7pJnRbq+WbgpEMq+24aj5drcuuXhSvv1lIb338E2gl9
         NBVNz31ME34UWD6KhAGyxYPI6kXpI2AS19RTEBuQ39HcABAI0Lss5ar6xjic5pGc8U0N
         zxXKMFCNjCRXVsjTqh8O8+1I+itNH/5Yn52fhP7VJB/ZAaSHzNxs78SIi0bcEDolbmyT
         s8u2vumORIK89XN0ATE/6FapYYFeS0W5wPmCuLRMNc/j7gf6NrVcTEtB1mD6HnAc+SNq
         SiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357560; x=1793962360;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENCpY+q96QKy968xYsN8LP/ZjQE1WO+qrun3mhMQiSU=;
        b=2c7iOxCXpWFJTinkQW9WQ4F6/TtrU0HKGSTjokV3rd6IxJyhAho3jugJoM9D4zpOia
         D3kilhGrkEBIEgZF1X05ySXQry8HubOC7Ie0k9CZf1t+1XVelxGb/mcd1yaPiUxufnFW
         Ow3OVkQ9no2GxalVh4AOIE67Nnnwf0UpDpTmuoa84HSo90N625Z8TaaRRkdp7zSwwIoP
         JJb0uMVaW/iqSpVjrg18EScsp5G7rkKzboo3Y9zMcyG57QMxtGppbKBRKoICgaiIeT8k
         YBBZgGDYupEeVSthKv91jCs/3lAIkfhUTEzc8S66nH1kRJ8W6CQzjQJEtquBJtslx/Z1
         fLwg==
X-Gm-Message-State: AFq9FYLKJo0NSghuzY3diDHmLEVn6xLgMDVs7GhGf0vwcQxN8FtefbSR
	Jl+nGg86lqrhfQ6ZqRav8+3LBVN2SiT8RjVsbiFlQ+BUDY30ev/rPcjyxiC1pb4+mjo=
X-Gm-Gg: AYBFou1VQq2oZpHQoMyuf02CXb13FP6Xgz5V1FceXvFozNBdk/wqweMF9qFl00+VcCt
	1YqZ/Io59213XZ3o9u1USe3oqy4lDCt+xI2DsHOKIwcrSib2/K1V0Erx6mrEl/joSTGUTOB1DVG
	8Z7rAYbfztDGnFPq59w1d1aPx4ySdC/Tj3g3wwnIkkBymgWG6d7Nxd0qB+fJHEWZZ7xqxtnNUxZ
	vq8wjWSOfGIm2AsBJJKF63B+LDHyVa+E5OIfWRYmx93GgV9VAttYVY5hcP0x/XYP6KWsV1b4lPE
	1u5mAEudzKlUI7+8AQOdDM3m6yFj69mBMEI8fvBrPTKd0RKbVCXRWv9t4rN+t07sZlm2QHaoFvY
	G4RvojsIBXR1tBH0dRsW1t9CXfezgn66UV5mb9/sGltTIzNJI2mtHebTBA4rlNJLeKctm1gaBY8
	YfCoRGQX0yNYqD1FYiOchBy3HGF+UTO8SfUr0Ej4U1jl2Y62RXJatdaKL1l0bGB5SE0e9dorMLl
	y/nQ2Z7mCtJM+Dhsy+Qwz2Z70BN8wNN6CqxA/23/fwoB9rIrhKWL40SRBxmQnqKM40tqJNum0Va
	E8Bhn5s031LfWR0mfHRCGqYljU6eaA==
X-Received: by 2002:a05:6820:162a:b0:70c:8247:fc90 with SMTP id 006d021491bc7-714f299beb1mr1083906eaf.32.1793357560273;
        Fri, 30 Oct 2026 03:52:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.38.98])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce7c9csm1526156eaf.5.2026.10.30.03.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:52:38 -0700 (PDT)
Message-Id: <07081828d1d65373bee4b2ef5e1916e65a217db6.1793357550.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v13.git.git.1793357550.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:52:25 +0000
Subject: [PATCH v13 1/6] fetch: add remote.<name>.fetchRefmap
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

Add a per-remote config variable, remote.<name>.fetchRefmap, that
provides the default value for --refmap the same way
remote.<name>.fetch already provides the default refspecs to fetch.

Unlike passing --refmap on the command line, which requires an
explicit refspec to go with it, configuring remote.<name>.fetchRefmap
on its own does not change what a refspec-less fetch does: it falls
back to the same defaults as a remote with no fetchRefmap at all.

When remote.<name>.fetch is also configured, it still decides what to
fetch, and the refmap maps what it fetches. This lets a remote name
only a few branches and store them all through one refmap:

    [remote "cabal"]
        fetch = master
        fetch = next
        fetch = seen
        fetchRefmap = +refs/heads/*:refs/remotes/cabal/*

Looking up the remote-tracking branch for a remote branch, as
@{upstream} and "git branch --track" do, falls back to the refmap when
remote.<name>.fetch has no match, so that these work for such
branches too. A branch excluded by a negative refspec in
remote.<name>.fetch stays excluded.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |   7 ++
 Documentation/fetch-options.adoc |   3 +
 builtin/fetch.c                  |  16 +++-
 remote.c                         |  20 +++-
 remote.h                         |   6 ++
 t/t5510-fetch.sh                 | 151 +++++++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..236ccca93e 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,13 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.fetchRefmap::
+	The default value of the `--refmap` option, used to map refs being
+	fetched to remote-tracking refs to store, the same way
+	`remote.<name>.fetch` does for an explicit refspec.
+	`remote.<name>.fetch`, if also configured, still decides what is
+	fetched. See the `--refmap` entry in linkgit:git-fetch[1].
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
index 1f76ae6242..305934f5f4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -518,6 +518,12 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	/*
+	 * The --refmap command line option, if given, takes precedence
+	 * over remote.<name>.fetchRefmap.
+	 */
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -528,6 +534,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	filter_prefetch_refspec(rs);
 	if (remote)
 		filter_prefetch_refspec(&remote->fetch);
+	if (effective_refmap)
+		filter_prefetch_refspec(effective_refmap);
 
 	if (rs->nr) {
 		struct refspec *fetch_refspec;
@@ -561,8 +569,8 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
@@ -597,6 +605,10 @@ static struct ref *get_ref_map(struct remote *remote,
 			if (has_merge &&
 			    !strcmp(branch->remote_name, remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
+
+			for (i = 0; i < remote->refmap.nr; i++)
+				get_fetch_map(ref_map, &remote->refmap.items[i],
+					      &oref_tail, 1);
 		} else if (!prefetch) {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
diff --git a/remote.c b/remote.c
index 49ee2ea318..9acab2e01a 100644
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
+	} else if (!strcmp(subkey, "fetchrefmap")) {
+		char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		refspec_append(&remote->refmap, v);
+		free(v);
 	} else if (!strcmp(subkey, "receivepack")) {
 		char *v;
 		if (git_config_string(&v, key, value))
@@ -995,7 +1003,17 @@ void ref_push_report_free(struct ref_push_report *report)
 
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
-	return refspec_find_match(&remote->fetch, refspec);
+	char **result = refspec->src ? &refspec->dst : &refspec->src;
+
+	if (remote->fetch.nr && !refspec_find_match(&remote->fetch, refspec))
+		return 0;
+	if (refspec_find_match(&remote->refmap, refspec))
+		return -1;
+	if (refname_matches_negative_refspec_item(refspec->src, &remote->fetch)) {
+		FREE_AND_NULL(*result);
+		return -1;
+	}
+	return 0;
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
index 17c0be499c..b5eba020ad 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,157 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
 	)
 '
 
+test_expect_success 'remote.*.fetchRefmap acts like --refmap on the command line' '
+	test_when_finished "git -C three config --unset remote.origin.fetchRefmap" &&
+	git branch -f side &&
+	git -C three config remote.origin.fetchRefmap \
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
+test_expect_success 'remote.<name>.fetchRefmap without tracking (baseline)' '
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
+		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
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
+		# remote.<name>.fetchRefmap plays no part in deciding what to
+		# fetch, only in mapping what is fetched.
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
+test_expect_success 'remote.<name>.fetchRefmap stores branches named in remote.<name>.fetch' '
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b master fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch next &&
+	git -C fetch-refmap-upstream branch seen &&
+	git -C fetch-refmap-upstream branch other &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add cabal ../fetch-refmap-upstream &&
+		git config --unset-all remote.cabal.fetch &&
+		git config --add remote.cabal.fetch master &&
+		git config --add remote.cabal.fetch next &&
+		git config --add remote.cabal.fetch seen &&
+		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
+		git fetch cabal &&
+		check_fetched_refs <<-\EOF &&
+		refs/remotes/cabal/HEAD
+		refs/remotes/cabal/master
+		refs/remotes/cabal/next
+		refs/remotes/cabal/seen
+		EOF
+		git branch --track topic cabal/next &&
+		echo refs/remotes/cabal/next >expect &&
+		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap stores an explicit-dst remote.<name>.fetch entry in both places' '
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b master fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add cabal ../fetch-refmap-upstream &&
+		git config --unset-all remote.cabal.fetch &&
+		git config --add remote.cabal.fetch \
+			"+refs/heads/master:refs/remotes/custom/master" &&
+		git config remote.cabal.fetchRefmap "+refs/heads/*:refs/remotes/cabal/*" &&
+		git fetch cabal &&
+		check_fetched_refs <<-\EOF
+		refs/remotes/cabal/HEAD
+		refs/remotes/cabal/master
+		refs/remotes/custom/master
+		EOF
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap tracks a branch outside remote.<name>.fetch' '
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch other &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add -t main origin ../fetch-refmap-upstream &&
+		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin other &&
+		git branch --track topic origin/other &&
+		test_cmp_config origin branch.topic.remote &&
+		test_cmp_config refs/heads/other branch.topic.merge &&
+		echo refs/remotes/origin/other >expect &&
+		git rev-parse --symbolic-full-name topic@{upstream} >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'remote.<name>.fetchRefmap does not track a branch excluded by remote.<name>.fetch' '
+	test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+	git init -b main fetch-refmap-upstream &&
+	test_commit -C fetch-refmap-upstream base &&
+	git -C fetch-refmap-upstream branch secret &&
+	git init downstream &&
+	(
+		cd downstream &&
+		git remote add origin ../fetch-refmap-upstream &&
+		git config --add remote.origin.fetch "^refs/heads/secret" &&
+		git config remote.origin.fetchRefmap "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin secret &&
+		git rev-parse --verify refs/remotes/origin/secret &&
+		test_must_fail git branch --track topic origin/secret 2>err &&
+		test_grep "not a branch" err
+	)
+'
+
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

