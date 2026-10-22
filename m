Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702822;
	b=4jfJ8vleOBPE4QkPBuyHkcgvGfCFp7RuUoKf2PabKvi2Nidtm+TDHi4J0oCnxciP6JMs
	 U0+kSv1tU0rCPDVHlY3lnHnAv571usCcfdCyRKpclYri2cPT6jMqh5tT5hfY2dBO1EQwJ
	 PmekO/apmywnMgIeiNOXh9wX05cd8TBOgtPRy3xwRdWqEHdzc4jlgqUjNgchnH8/FoSl/
	 MhDgN3cu4j802fSyEcbdyZsi/Y7R7/rd+CSQH8BpgmfRssued3+d3o6X32VFSkDQVNyHF
	 LP80f6SV4H/ylj3KO2zKh/hprUv/Yts64iI0igdVnJWN5/a71mIj+Vdutn7Ltn9adZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=1ZJHr+5lB6S5CQCiRKP00PwWOMT7UCb+trgvOOIuUBo=;
	b=1oGZ6tzh6039e0gCO+w1Vh0L9RWlehnOTxzOBOsORHM/fWISP/lyTwOxMH7zlPbvZSOK
	 uRYZ84yjar7gy+CrJy9yU/6k0Vukd2miDh1EE3lxaM3//3WQMpdkbLRBnxAkE2qmK8wdW
	 McYGH+i3kOib9ShSDrmj5K+cx2yqvowtbsQzdU4AiTwGffG6s7ABhZ1BAtu2x8dCxrp5+
	 o/4RqDTOSdHfbVT+a7KMSS2Yh7ID4PiIREFSYMgbfVnhTcyF9lsea9fAVynnhGPrOBTEj
	 3EsGTEBwjj0ktqRiY0U/oGPwzgyw+QQ5yuzk8kLogpq9tOo5ochOuUX0dEQm66xWebQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BNTUKjdj;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E5606A31B
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A5E5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BNTUKjdj
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so1181085e9.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792702821; x=1793307621; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ZJHr+5lB6S5CQCiRKP00PwWOMT7UCb+trgvOOIuUBo=;
        b=BNTUKjdjj/iroMMyyJVcfAiXsSqiwKsWdVRvIFEi0KlYYqr30sum+czlqVW3bmkG/J
         dvh1kZSyIeD0CqeNgmSxrJJ6J6LNjck0FCNCVh9UjuOcQWZWwzCrOe0QoMfmky08lkCs
         NOZzXU+3TjrTj8tqqDy/g5MXFKjqwzrQdQLd8h52bCm1c/88e/jTKqFIXTA5D7LhyRZE
         5i18dXZ0/tYpUZsgygD+bO5MAFPZyDwAW2qeTSPtDwVQlRpVFWfNljBEQhdqRjtPFLXp
         N4Z9+3iYV/kZ63NHY9gFbj2LEcZyMVThIApfWAAmnvSvD6WOCj6oSFKoILneQA+tlZho
         0UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702821; x=1793307621;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ZJHr+5lB6S5CQCiRKP00PwWOMT7UCb+trgvOOIuUBo=;
        b=tkY9SvCpAMV+wumA1ZPoh2MLKz3V0EiEyvuz1hZpaNnKX0uf3BU6oRtU39urLoDQ7l
         2vXCD13J/V7k1Jt1RSndW1JoMdTCPGvYLQZCmdvtMhp1s5E39BlDE8iDW2DLML2ssPxk
         sQYYfotbDSagcrGduAbwhrQtMQkZ70UrPMORKGPkQ4hw19HGZB092sgAlC04TT9SGV3i
         jCqp13VRsrvVZDzANSQmw+Wl3r4LOQAP8CoNUUzarZhvWQMfv+HzIZPm/LdXcAGt7QXp
         IdByk5fQGdoi/1DBgOxgk8eIGT+KbeM7bDiD5cEaZNmKpKbdaPiCWgZQOAjcn1WMuYxE
         +fbA==
X-Gm-Message-State: AFq9FYIH5fqMSyRxWIpeq2b/tATtKiQhZTeMKXKm5sz+OhlvazcrQZ/L
	5V6metUFENzR0gC1JijWUlbmXNpwlcWdKRaDQoPNINN11HjmD0PclFIE
X-Gm-Gg: AYBFou3DCk3CHZTFr+IsfkjScakLFhOHS7ZEyTS4Af5iTBkYXhGHPdlAeKIIXDZhhGr
	M1PeOvwhqqADciVkfRLxZTDG5NkdEXix7XZ0LWMcGcCqb2ErmLJxSw/rVLxwwWEKxyz0Jd6k80d
	eB4AZiXIiDvK6tq1oeiAwZUDCedfVAtUgNE9gfzOf6VlckU9N9pCJoOROpU3WbiAdr/qhjv3EEs
	T4BP3anEMLlGPpSd8cNM3UrvrnSk8zUb2ltW1EYraqcM+Wo31vVVPfj8EQNn+4jhYlsXnRlSAK6
	jwEmvvqpSnEqRzlntPtfrBevkeefy7Tw5pVlpqovATBJVp77HPuJHZjkTYKScUGl9RZ9Jl5ZF/9
	JZyUXsBxc/j6pG7lOoIhowdU/XRlxnsyE3us1eS6PTxSGxN8T72+BAIS1OP2KursqwpdDMGoT5g
	XMuVFKrwLgjdjf4aZ8htIFKRkjzraQ4kZvJao59kg8NNGIb0RZ6KIV97yTzA9ksgPnVGxAKryrA
	2aqT5W9z6gpK+tfeexx0jSlnYGKA8kEhMt1oU2IePqmx6bxa8ymFepnRtff8MIhuBr57n2xcfmT
	IduQo9ZA53iLlbITaMHTXs1kL0TSaj38//PAnfw=
X-Received: by 2002:a05:600c:81c8:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a211f0a72emr3310035e9.16.1792702820390;
        Thu, 22 Oct 2026 14:00:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:808:6766:ea9b:99f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2123613easm2737825e9.5.2026.10.22.14.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:00:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 22 Oct 2026 23:00:16 +0200
Subject: [PATCH v4] fetch: advertise fetched refs when backfilling tags
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Ny2rDMBCF4VcJWneCNPIlyirvEbrQZWSpOHGwF
 Kcl+N0rJxRMF14eOHz/kyUaIyV23D3ZSFNMcbiWUX3smA362hFEVzZDjo3gvIVWKUhB9/3wAE/
 ZBnjEHCDrLoFr0EjyBpXnrAi3kXz8funnz/dOd/NFNi/k8ggx5WH8eeUnsfz+SmqzNAkQIFvlG
 lHzSvv61F107Pd2uLClNOHKErhtYbEqFIKUFtJJ+9+Sa6vetmSxFDcNyYNRB4dra57nX8ffItx
 wAQAA
X-Change-ID: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
In-Reply-To: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8613; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ncgYe1ITLfdix4EU/gp7/q8kxzp5la5WEgOxSHqzsIw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGraeWPrNts8fZQmj93NBiY5JeXa7EK0gN22R
 e9oqjTrdyHGAIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq2nljAAoJED7VnySO
 Rox/1m4L/2b1mVMk73nVne1YpTD4Xky4xExJLX4lZAug4AjWHtt3BFZxuxkXWgLItvvdEcOm15Y
 pbLXQ1y9gL7DwxB9mQ6ABPqotdl7o/rax629xMRxSop7z+6vc+RNOJbhr5DmgdXQyYq+tVGTRdX
 E3P65S0Nukm5TMiK03jfpsXUV/oTjwHcW6bRUB15X/0pNR5FKWqmbiUgeKJ1liRDX8Svtd9Z575
 AQib6I1cIe9a7TSNjiKo/2j2+mwKJabGjtwOfGR97hNf811mseajL942Ef7FU7PW3lHBuhUqxYV
 aHW3JEz3tRgzC6jYNPII3XuYfnHWHt3/skZCcYL4I5Bej/CCmL4tEWQZv9a/Q0a0uE61mzlDCm5
 K9DOWuULt160S50YcRl4olxMvlc2CLS5C3XFuWmAn+5jhcYyb6ldv4y49q7io0o5eOCoyDwC6hh
 oXNfpftlh/RunJK9agwarpCPKGYIQYDiR9yAg9cotVOOet+PBluc72Jjes4IAGoZbe4QLyjnF67
 cM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
fetch code was modified to use batched updates to provide a good
performance improvement. Batched updates are used both for the fetched
references and to backfill tags.

When using batched updates, the references aren't yet committed to disk
when we start backfilling tags. For shallow fetches, the negotiation
phase while backfilling tags does not advertise the newly fetched refs.
This can cause the server to send objects the client already has.

The issue always existed when the '--atomic' flag was used, as both the
regular ref updates and the tags need to be part of the same
transaction.

Fix this by advertising the already fetched refs as 'haves' during the
negotiation. Do this by simply adding the tips to the transport's
`negotiation_include_tips` field. This also fixes the issue for
`--atomic` fetches since it follows the same route.

Add three tests, two which validates that the 'haves' are filled when
backfilling tags for atomic and non-atomic flows. The third, to test
that upstream is still set and tags are backfilled even if a sibling ref
is rejected.

Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].

[1]: https://gitlab.com/gitlab-org/git/-/work_items/799
---
Changes in v4:
- Instead of committing the first transaction and starting a new one,
  advertise the refs already fetched when backfilling tags. Thanks to
  Justin for the suggestion. This also fixes the `--atomic` flow.
- Link to v3: https://patch.msgid.link/20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com

Changes in v3:
- Fix the early exit, so a failed transaction_begin() only skips the
  backfill.
- Keep the first commit's result separately, so rejections don't skip
  the upstream and remote-HEAD setup.
- Test that the backfill advertises the fetched tip as a have, instead
  of checking that the root object isn't fetched, which passed even
  without the fix.
- Add a test for the upstream setup when a main ref is rejected and a
  tag is backfilled.
- Link to v2: https://patch.msgid.link/20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com

Changes in v2:
- Add benchmarks between master and this branch to show perf regression.
- Instead of checking the trace file, simply check that we didn't fetch
  older objects in the test.
- Link to v1: https://patch.msgid.link/20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com

CC: Patrick Steinhardt <ps@pks.im>
CC: Justin Tobler <jltobler@gmail.com>
---
 builtin/fetch.c  | 41 +++++++++++++++++++++++++++++++++++++--
 t/t5510-fetch.sh | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..9867e8c2ef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1676,8 +1676,10 @@ static int backfill_tags(struct display_state *display_state,
 			 struct fetch_head *fetch_head,
 			 const struct fetch_config *config,
 			 struct ref_update_display_info_array *display_array,
-			 struct list_objects_filter_options *filter_options)
+			 struct list_objects_filter_options *filter_options,
+			 const struct oid_array *fetched_tips)
 {
+	struct oid_array *to_free = NULL;
 	int retcode, cannot_reuse;
 
 	/*
@@ -1697,9 +1699,30 @@ static int backfill_tags(struct display_state *display_state,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
+
+	/*
+	 * References fetched before the tag backfill aren't yet committed
+	 * to disk, so negotiation cannot discover them. Advertise them to
+	 * the server, so that it does not re-send objects we already have.
+	 */
+	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
+		struct oid_array **include_tips =
+			&transport->smart_options->negotiation_include_tips;
+		if (!*include_tips)
+			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
+		for (size_t i = 0; i < fetched_tips->nr; i++)
+			oid_array_append(*include_tips, &fetched_tips->oid[i]);
+	}
+
 	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
 					 fetch_head, config, display_array);
 
+	if (to_free) {
+		oid_array_clear(to_free);
+		free(to_free);
+		transport->smart_options->negotiation_include_tips = NULL;
+	}
+
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
 		gsecondary = NULL;
@@ -2077,6 +2100,17 @@ static int do_fetch(struct transport *transport,
 
 		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
 		if (tags_ref_map) {
+			struct oid_array fetched_tips = OID_ARRAY_INIT;
+			struct ref *rm;
+
+			/*
+			 * Collect the tips we just fetched so the tag backfill
+			 * can advertise them to the server as 'haves'.
+			 */
+			for (rm = ref_map; rm; rm = rm->next)
+				if (!is_null_oid(&rm->old_oid))
+					oid_array_append(&fetched_tips, &rm->old_oid);
+
 			/*
 			 * If backfilling of tags fails then we want to tell
 			 * the user so, but we have to continue regardless to
@@ -2086,8 +2120,11 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config, &display_array, filter_options))
+					  &fetch_head, config, &display_array, filter_options,
+					  &fetched_tips))
 				retcode = 1;
+
+			oid_array_clear(&fetched_tips);
 		}
 
 		free_refs(tags_ref_map);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..ca5f9642fc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1942,6 +1942,40 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success 'backfilling tags advertises fetched refs as haves' '
+	test_when_finished rm -rf source target trace &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	HEAD_OID=$(git -C source rev-parse HEAD) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
+		git -C target fetch --depth 5 origin &&
+
+	test_grep "fetch> have $HEAD_OID" trace &&
+	git -C target rev-parse --verify refs/tags/tag
+'
+
+test_expect_success 'backfilling tags advertises fetched refs as haves even with atomic' '
+	test_when_finished rm -rf source target trace &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	HEAD_OID=$(git -C source rev-parse HEAD) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	GIT_TEST_PROTOCOL_VERSION=2 GIT_TRACE_PACKET=$(pwd)/trace \
+		git -C target fetch --atomic --depth 5 origin &&
+
+	test_grep "fetch> have $HEAD_OID" trace &&
+	git -C target rev-parse --verify refs/tags/tag
+'
+
 test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 	test_when_finished rm -rf base repo &&
 
@@ -2005,6 +2039,31 @@ test_expect_success REFFILES "upstream tracking info is added even with conflict
 	)
 '
 
+test_expect_success REFFILES "upstream tracking info is added with conflicts and backfilled tags" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base one &&
+	test_commit -C base two &&
+	git -C base branch foo &&
+	# Backfilling only takes place for tags which are not pointing at tips.
+	git -C base tag -a annotated -m annotated HEAD~1 &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/foo.lock &&
+		test_must_fail git fetch origin --set-upstream main \
+			"+refs/heads/*:refs/remotes/origin/*" &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/tags/annotated
+	)
+'
+
 test_expect_success REFFILES "HEAD is updated even with conflicts" '
 	test_when_finished rm -rf base repo &&
 

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0


Thanks
- Karthik

