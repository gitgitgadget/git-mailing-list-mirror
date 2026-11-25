Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633589;
	b=iszF3lgrmP0HxGvefUPw7PtJsjziK0nmrYZISjYCIYLZ/Qgsce7JJhS/0FGKHqR0CCtE
	 4PTTpYT/Y8qmogvE0RCtrmr8LOH0sbyj5k37dizklSfmeJ4/AYAuSoeFXd9/4zevGjXvV
	 isasOpRB1ZuNx+H1jNdNVzoGh6bqL21l2agB1tfzLV7XGdx/WMNmHxBxSo9bgTQup4QnH
	 i964Byvifl4vyIw5dQZFA0OrDBAX6Id811X0mmd7DrURHkh7jtxzbY9pKAsT8/dRMzgmc
	 lqgDJh5p4WL4N2IYqcmncQz7WjQopnZE2hx7hqXWAWnCb9RyjlH9Xfg/H0vHezNC2wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=uP1zS6cDlME32qLv2t3NTyTkAhHYA8LbOyAd1m5jsa8=;
	b=iYcggwQENt6fB2xHgJQN6oMqsi2kLc+kA2KzNdyrBBPs8gYSxAkr9YpYvpNiYKGlCljr
	 q9Og26mG58Yo9xOmuFhnx2c6V+k2J9GiFmuXP9TDBjtLJcsnJD8w2P43tVEy7ygFHvLq1
	 1eBBq3s62naEpwZTRU8T8Db93rkSTzV0a6/rYmbsvmYWDlkuanQ3VN8oI2Cw3HDHVhBm8
	 pi/QQL5InR9+p59LwCdieyqY+AHpQEhvo7rKiU71+6h+DCfAjmJcC0Cde+u4dQTVdHTh0
	 B0oi5OFWTPwup76qxZVzGZJj3Qdu+Mh+550x/5C7NknfJwagxAnGhoh66tNjzYhdiRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCcEOxgr;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795AA606A334
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795AA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCcEOxgr
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-702fd86d674so4016134eaf.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795633588; x=1796238388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uP1zS6cDlME32qLv2t3NTyTkAhHYA8LbOyAd1m5jsa8=;
        b=aCcEOxgryPY41HLhSZK+SAqcswc9jS7okHQ6WuH/SNncthyHY8YJ3Ihy9HNV9ULmBk
         /JeYrX1vIg9NNCSkVUBjpkjCgxNsS3k2UUdbvHTrqj5K17LvsVJsmoUkDuIIgZOhahxA
         nef1MrBpQar25JpBdgz7w3Z/GI6Ht86JI3LQWWQnpWlAdyqNfYQC3u/IMggcw07duRt4
         OwEcbQFg5HTAUK9xmYTREPegBrrU1eUMjUna/yFrIsETADAlrnyADrJb5CJbsiAwTG0D
         LSQ1kBEARGvczpiMqUL1LNi+KnCHb4DXuvkZtG0yLVLcZRkSTA3n/khbeA7pkfxUmQxM
         tR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633588; x=1796238388;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uP1zS6cDlME32qLv2t3NTyTkAhHYA8LbOyAd1m5jsa8=;
        b=F9mU3IXYvuC2hqVg9pHAxPpxFdMe/IfprYfAKgltfwfy4yUOZc8eQlc8h4MZjTnY8/
         beJw6YmB9w4pfIb0k+NQjiuwyZkGEBnCUavlCFef1xrivG8QvbhS48gZZ44v6m7bgN1b
         TStwqMqzI6XSqqz/bHeqyuSCdUDFqUX98pvYVLJ7wq3c8/LZwB0DhwuG83ev0rgI70yh
         MPt3Y/45O1aV2YOdaVR1CmB+B2FHXvf0cVRnW+r6MaEPPTnvucijMUIjS9ayPIezQlPt
         lSf7IM7EZSpyxQKOGza404M/q0g1Qh7Tub+ea5UHBCF0XSKm7bmhEtkfWleE0bFfJ6NP
         ma0Q==
X-Gm-Message-State: APuU4Z+QO0hfp0VsYfRTrPGGpY1I0bmSqaj9SndnBT3qUxhciDSCWl0P
	mpEF9/2A/3TowD2tRQlNxWabHaRurELTv6z7T1pd3RkpKzzHBdNzMNi4ylIYeah8
X-Gm-Gg: AZFdTZfEnlyP2QkEFH+0iKXp7xvbrJPReUBejg3L4UPoeFtXlFqKrEW8r3kd5VOjJpn
	7PZuTgLgQdNAjE7s5p9uuNxZS0gr0l2F7QK3DHGL+RMPFaApNYnD95W1iv/qRDJsTIKeHXc//pA
	hjjFh+uh0/th584y+KRMdeC2C41t2oasfJxkPELNy9dbgkPjwfpp/a5mCVx5HsXBP40OffHKnRU
	hI4KIOJSoVrkDATemhmoCCliMk7ANwcPcd8wFJfguKCIysnm7+L89cV8DZvqXuL0+dgN8ilcF/7
	8VxrXlc8Yy/Il9+Uxd5kHweRx2apaNecimxCMpSQ+SPwUWxTnCHabMvlFgz2qONX+TkVwtIDrKJ
	PHuI9QCWohPP4LjdUU8z7C4L+KSUH49c0+F/aBQI6tRmLyfo8y3NOHb7m0U9QMJ+9vQ5HM1OdRZ
	hws/KQkZeeMg9YBskD2zBX5w8YT67+vpe7rLET6U0BGqh6Pc69+/LgfTTjQthliIdpMjgRdVaqq
	lAVts3jIQW8PLCpzP+HIgdxVU6zoMtdiFa+26igQKzybxphUFLDDfiR0vPlEGJYH7kh6FoUIdY1
	i3cJtEwcP4iLNDBhBfbBXbbZBVEi2+gI
X-Received: by 2002:a05:6820:a711:20b0:70b:9b1f:e896 with SMTP id 006d021491bc7-71b39623ec3mr10401623eaf.77.1795633588272;
        Wed, 25 Nov 2026 11:06:28 -0800 (PST)
Received: from [127.0.0.1] ([40.124.78.245])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b865900ccsm574169eaf.6.2026.11.25.11.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:06:27 -0800 (PST)
Message-Id: <72c288a81ece231434d3e4fa870cce714c9942da.1795633584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v16.git.git.1795633584.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:06:19 +0000
Subject: [PATCH v16 2/7] fetch: let --refmap apply to configured refspecs
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

"git fetch --refmap=<map> <remote>" without refspecs on the command
line dies with "--refmap option is only meaningful with command-line
refspec(s)". So there is no way to fetch what remote.<name>.fetch
normally fetches and store it somewhere else for one invocation.

Let the option apply there as well. The configured refspecs still
decide what is fetched, and the refs are stored through <map> instead
of at the destinations configured in remote.<name>.fetch. The command
line overrides the configuration, the same way refspecs given on the
command line override remote.<name>.fetch.

Tags are followed when the fetched refs end up stored somewhere, so
--refmap="" follows none. --prune leaves the configured destinations
alone, since this fetch does not store there. Destinations that come
from the refmap are not pruned either, the same as with refspecs on
the command line.

The option is still rejected when it has nothing to map, as in "git
fetch --refmap=<map> <url>" for a URL with no refspecs configured.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/fetch-options.adoc |  9 ++++--
 builtin/fetch.c                  | 27 +++++++++++++---
 t/t5510-fetch.sh                 | 53 ++++++++++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 54c5c8f671..e4b9e47806 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -239,8 +239,13 @@ endif::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.<name>.fetch` configuration variables for the remote
-	repository.  A ref fetched with a refspec `<src>:<dst>` with
-	non-empty `<dst>` is stored only there and is not mapped.
+	repository.  A ref fetched with a refspec `<src>:<dst>` on the
+	command line with non-empty `<dst>` is stored only there and is
+	not mapped.  Without refspecs on the command line, the
+	`remote.<name>.fetch` values still decide what is fetched, and
+	the refs are stored through the specified refspec instead of
+	at the destinations configured there.  `--prune` then leaves
+	the refs at those configured destinations alone.
 	Providing an empty _<refspec>_ to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0ee252e353..00f427800e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -291,6 +291,14 @@ static void map_refs_without_dst(const struct ref *ref_map,
 	free_refs(unmapped);
 }
 
+static void drop_destinations(struct ref *ref_map)
+{
+	for (struct ref *rm = ref_map; rm; rm = rm->next) {
+		free_one_ref(rm->peer_ref);
+		rm->peer_ref = NULL;
+	}
+}
+
 static void create_fetch_oidset(struct ref **head, struct oidset *out)
 {
 	struct ref *rm = *head;
@@ -585,8 +593,6 @@ static struct ref *get_ref_map(struct remote *remote,
 			for (i = 0; i < remote->fetch.nr; i++)
 				get_fetch_map(ref_map, &remote->fetch.items[i],
 					      &oref_tail, 1);
-	} else if (refmap.nr) {
-		die("--refmap option is only meaningful with command-line refspec(s)");
 	} else {
 		/* Use the defaults */
 		struct branch *branch = branch_get(NULL);
@@ -597,7 +603,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		     (has_merge && !strcmp(branch->remote_name, remote->name)))) {
 			for (i = 0; i < remote->fetch.nr; i++) {
 				get_fetch_map(remote_refs, &remote->fetch.items[i], &tail, 0);
-				if (remote->fetch.items[i].dst &&
+				if (!refmap.nr && remote->fetch.items[i].dst &&
 				    remote->fetch.items[i].dst[0])
 					*autotags = 1;
 				if (!i && !has_merge && ref_map &&
@@ -614,6 +620,8 @@ static struct ref *get_ref_map(struct remote *remote,
 			if (has_merge &&
 			    !strcmp(branch->remote_name, remote->name))
 				add_merge_config(&ref_map, remote_refs, branch, &tail);
+		} else if (refmap.nr) {
+			die("--refmap option is only meaningful with refspec(s) to fetch");
 		} else if (!prefetch) {
 			ref_map = get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
@@ -621,6 +629,13 @@ static struct ref *get_ref_map(struct remote *remote,
 			ref_map->fetch_head_status = FETCH_HEAD_MERGE;
 			tail = &ref_map->next;
 		}
+
+		if (refmap.nr) {
+			drop_destinations(ref_map);
+			map_refs_without_dst(ref_map, &refmap, &oref_tail);
+			if (orefs)
+				*autotags = 1;
+		}
 	}
 
 	if (tags == TAGS_SET) {
@@ -2091,10 +2106,14 @@ static int do_fetch(struct transport *transport,
 		 * We only prune based on refspecs specified
 		 * explicitly (via command line or configuration); we
 		 * don't care whether --tags was specified.
+		 *
+		 * With --refmap and no command-line refspecs, the
+		 * configured destinations are not where we store, so
+		 * they are left alone.
 		 */
 		if (rs->nr) {
 			retcode = prune_refs(&display_state, rs, transaction, ref_map);
-		} else {
+		} else if (!refmap.nr) {
 			retcode = prune_refs(&display_state, &transport->remote->fetch,
 					     transaction, ref_map);
 		}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 38185e192d..f9a5a1361f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -906,10 +906,59 @@ test_expect_success 'explicit pull should update tracking' '
 	)
 '
 
-test_expect_success 'explicit --refmap is allowed only with command-line refspec' '
+test_expect_success '--refmap without command-line refspec replaces where remote.*.fetch stores' '
 	(
 		cd three &&
-		test_must_fail git fetch --refmap="*:refs/remotes/none/*"
+		git update-ref refs/remotes/origin/main base-origin-main &&
+		o=$(git rev-parse --verify refs/remotes/origin/main) &&
+		git fetch --refmap="refs/heads/*:refs/remotes/none/*" origin &&
+		n=$(git rev-parse --verify refs/remotes/origin/main) &&
+		test "$o" = "$n" &&
+		git rev-parse --verify refs/remotes/none/main
+	)
+'
+
+test_expect_success '--refmap stores remote.*.fetch entries without a destination and follows tags' '
+	test_when_finished "git tag -d refmap-followed" &&
+	test_when_finished "git -C three tag -d refmap-followed" &&
+	test_when_finished "git -C three remote remove names" &&
+	git tag refmap-followed &&
+	(
+		cd three &&
+		git remote add names .. &&
+		git config --unset-all remote.names.fetch &&
+		git config remote.names.fetch main &&
+		git fetch --refmap="refs/heads/*:refs/remotes/names/*" names &&
+		git rev-parse --verify refs/remotes/names/main &&
+		git rev-parse --verify refs/tags/refmap-followed
+	)
+'
+
+test_expect_success '--refmap="" without command-line refspec does not follow tags' '
+	test_when_finished "git tag -d refmap-unfollowed" &&
+	git tag refmap-unfollowed &&
+	(
+		cd three &&
+		git fetch --refmap= origin &&
+		test_must_fail git rev-parse --verify refs/tags/refmap-unfollowed
+	)
+'
+
+test_expect_success '--prune with --refmap leaves the configured destinations alone' '
+	test_when_finished "git -C three update-ref -d refs/remotes/origin/stale" &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/stale base-origin-main &&
+		git fetch --prune --refmap="refs/heads/*:refs/remotes/none/*" origin &&
+		git rev-parse --verify refs/remotes/origin/stale
+	)
+'
+
+test_expect_success '--refmap is rejected when there are no refspecs to fetch' '
+	(
+		cd three &&
+		test_must_fail git fetch --refmap="refs/heads/*:refs/remotes/none/*" .. 2>err &&
+		test_grep "only meaningful with refspec" err
 	)
 '
 
-- 
gitgitgadget

