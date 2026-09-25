Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAD2405EB
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790333409; cv=none; b=bdU+8gV4RJIeyWq3mrRhLIvcESPMWX9QK8LJxpoI0Wmt8+ARTONN5lVi0eZwMkWFSotoUpRc79ljWRWhLMeomY7N0eqcFaYogfPeRs41aTcUtPe0YVOKeYMM+29rnTgZ+AdNnGV7ZTTpcqr9MWt44rpz3mVTOHfjGm4/Dorq0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790333409; c=relaxed/simple;
	bh=K9nqtBx5Fc5dLQqEqx7WRiNAwv/GiWn5tS42oT1sUE8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=updKmpybciH7Xf3TUdoVMf6ag1km2gaWKVCCT2R0NrqKn0ntNX/Tq7V7dZHafL3K37iSTgbqIZrNWf5UqryLFdl8gMeZj1yaBoPd5+yGpppJ6DoF+uIo1fv2/asUkicldydL0zm8I9m+T+5pnlMLJRbwlVuO7GE/yVaj2DQF5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU3obNwU; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU3obNwU"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso808920eec.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790333407; x=1790938207; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cr4WBMB5UQl45CupBqNzbb++5VBdse22sWsFOYJowAc=;
        b=TU3obNwUH4EaQp1uKEQbwZplThvomLERoVpfgZ/t+2/l9NFY6Dkps+8QrlZx2Gc/12
         UPk/JL5zmp7dtZqkeYHx0oSXbodPTBRTvFU9FUfK8n4I4AcmwcZkrURn41wwxozvZiGz
         O+fdHPG2Ib9K268crqf24bP+gsTeggMr4E9/pdTnWUrweNkYO/xpf1TOaaR/W/dIzIlo
         Zkk/qCDwoFiKBiQAQgL2T1cBy61ro1Zfp5Wshw8EWCAToTHglwFHRt+UAaxP5l5VPoPt
         aTs4BJc/E/70Il0m+jsJZpQm9x+/ynS+DUdXyzHlvwg6frZb7tiS5pVZ3F9Yl3rG9Gqk
         WNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790333407; x=1790938207;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cr4WBMB5UQl45CupBqNzbb++5VBdse22sWsFOYJowAc=;
        b=hc7m6uK4Su3bgf+TzFjRPGY3nSMeOMprIIIXCldfQXdXfQfBv7XXjQ7r5PlTF0sFaM
         TDNuZ0Zdw8jtYO9BMif9BNXO9TWEjDHmeTNJme7gm/forGwP4jo7io3yaUX8a1eeNyJu
         t5HPmIadjNPH3r/qSrz2trSt7mMTT9MkyLsLsFSzCCqloUNXfZa5XFUAz02a0FvXzFwk
         pvOkdkyD1483n2b6zK28G/tZkzcj9rHeTVyw0XYQXgAoIAKBS0lFoYgdWKMoWTkwukhp
         6OC4kF1ZCDy6qkNGwzWrAFINkz+hfiOqPDTxmbhS1f6NfCXNI6DnxzSjUpAO0YiGfZU+
         DIkA==
X-Gm-Message-State: AFuF++lBTRfHzgEVLjdIDbrbLgdRjn2BiwsHUtWjTW3LiKN2i3MsXiDn
	fSnNrvHYCjyYDZsGzCu2+EVlA799wZ2RA4DKkc/wnju3zqZRqI+kVPxAJlYUe1wy
X-Gm-Gg: AYBFou2g/vOTAiEP+w2ngkavFj04Af+0Ie5HF03thusbpw44gKOT4SulRkaRZ/eZaMa
	J+Qp0J4QG3JodDHk1sheSjy+YQ+kijl5rDyUrWu/Zgewkcxv+pIsdD+JZ9OV0dUFqIy167MJS7A
	nGzrjQFWqqghVg8CEpdmoLJrL78E2c1eyz0F8EjysjciUiye7cRtNeCZTJOkNYvyDXYHwtsyUb4
	mz5fQnDaXshXXKe1H7jQaC+5947aojfyhePV5PDBd95vjxV50RkMT2vBY0spWuMRgMO18zprXyp
	bTAfumnlJEMZsvR9TFiIokx8r/DGvpVJ9mjCH3ilu3Un0TLBu8rGufiE/oTXStsoMwhLtfvhFqi
	mkffp39+fer1G7j1KozSRniAf1aA09OMW3oqZOgdQ0f9eVTZaVUiyKe20R7wI2mn9nMIDyok16T
	C11FPrHUsBlboCHQ5kbe8mNMw/OW5IkC6pEIX+wvO++H8XfGi3jVXuhHcC4nxCGz1vjNdgkuQ=
X-Received: by 2002:a05:693c:8941:10b0:33e:84c3:a05b with SMTP id 5a478bee46e88-3400687d1d8mr4226583eec.30.1790333406256;
        Fri, 25 Sep 2026 03:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.7.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm5985649eec.6.2026.09.25.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:50:05 -0700 (PDT)
Message-Id: <b04c00b974ce488ea1eb82556040fb54c05dad5a.1790333402.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 10:49:59 +0000
Subject: [PATCH v3 1/4] fetch: add remote.<name>.refmap
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

Add a per-remote config variable, remote.<name>.refmap, that provides
the default value for --refmap the same way remote.<name>.fetch
already provides the default refspecs to fetch. It only takes effect
when there is something explicit to fetch, on the command line or via
remote.<name>.fetch, matching how --refmap itself already behaves.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/remote.adoc |  6 ++++++
 Documentation/fetch-options.adoc |  3 +++
 builtin/fetch.c                  |  8 +++++---
 remote.c                         | 12 +++++++++++-
 remote.h                         |  6 ++++++
 t/t5510-fetch.sh                 | 17 +++++++++++++++++
 6 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..00f9ed8d3d 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -33,6 +33,12 @@ remote.<name>.fetch::
 	The default set of "refspec" for linkgit:git-fetch[1]. See
 	linkgit:git-fetch[1].
 
+remote.<name>.refmap::
+	The default value of the `--refmap` option for linkgit:git-fetch[1].
+	Only takes effect when the fetch names what to fetch explicitly,
+	either on the command line or via `remote.<name>.fetch`. See the
+	`--refmap` entry in linkgit:git-fetch[1].
+
 remote.<name>.push::
 	The default set of "refspec" for linkgit:git-push[1]. See
 	linkgit:git-push[1].
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 035f780e58..538914bc6e 100644
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
index 533fdfe7d8..7651b41139 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -509,6 +509,8 @@ static struct ref *get_ref_map(struct remote *remote,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct refspec *effective_refmap =
+		refmap.nr ? &refmap : remote ? &remote->refmap : NULL;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
@@ -552,14 +554,14 @@ static struct ref *get_ref_map(struct remote *remote,
 		 * by ref_remove_duplicates() in favor of one of these
 		 * opportunistic entries with FETCH_HEAD_IGNORE.
 		 */
-		if (refmap.nr)
-			fetch_refspec = &refmap;
+		if (effective_refmap && effective_refmap->nr)
+			fetch_refspec = effective_refmap;
 		else
 			fetch_refspec = &remote->fetch;
 
 		for (i = 0; i < fetch_refspec->nr; i++)
 			get_fetch_map(ref_map, &fetch_refspec->items[i], &oref_tail, 1);
-	} else if (refmap.nr) {
+	} else if (effective_refmap && effective_refmap->nr) {
 		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
diff --git a/remote.c b/remote.c
index fe62068463..017cd9d13e 100644
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
@@ -988,7 +996,9 @@ void ref_push_report_free(struct ref_push_report *report)
 
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
index a8d38d9176..bd853d0a84 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -927,6 +927,23 @@ test_expect_success 'explicit --refmap option overrides remote.*.fetch' '
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
 test_expect_success 'explicitly empty --refmap option disables remote.*.fetch' '
 	git branch -f side &&
 	(
-- 
gitgitgadget

