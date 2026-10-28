Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180888;
	b=EziVxvIL98oTow7C08KH3cXbRj/XWVoUvRj1guEir8WoElAJJpNwASRyvg1hgG+DwK5J
	 fY28yw3Kdf2jBQC6mjNeR+TdosIHzqPN/caVGrgLhG4PY0GosvCfwCE6jyzBvOTvPu1Tx
	 xzX0kbG0TvHBrG9t11yY6+GFN7KCGc+de6LLnZIQcJp8iPGbc8epHzpjPrElqhmZUIc3h
	 DRG37mQlUg9MRqsHtHAODZ1OaHO0VlR0kNlXnk2Tz6HNs10uQM40nUmprxKQF7CI+239L
	 SMaZbPvAknRuhXu7+BuVgpk/IhJxcG+qprr+PCrEs85+/MnDrA2wVUi3SA3CdSUaUcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HYZhchboGdwW91hytv6v3TXakRJE+HGcbwVnqbNsAYI=;
	b=mLVeJZaru7nn/+axavEjTGt7GSEk2Jw4fDecqV5d7nRHK+vijQoDsiV3c/fiFnnJya/u
	 rDkbNXeQkG1rdFDEoTjcVLgY8cSpqv9xAt7c96TxaO4DncyHJ1pUN18W83/PRDfHdH4ut
	 IeXlLgV5senGwzn8KB1/NXcRBnT9PN6fO/UB/FK2/d/O+Zlk3xKDt9H4XbhV3F4dVhCO9
	 HPKcQIuHQelXmwym1ZoZUG7fDs6/4wHZgDUmH6crZWceo5hWOrfWXXTBdXa5nBWQZoOeV
	 kHE34JxTCvGWm+EqTT/CeK8vNGXJlSsXSDhboglwSdCDNwCV4DC8OETuQl6FyFYoCEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USgGtozf;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A0606A323
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 903A0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=USgGtozf
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so6908455e9.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180886; x=1793785686; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYZhchboGdwW91hytv6v3TXakRJE+HGcbwVnqbNsAYI=;
        b=USgGtozfhzOC4d0uAJ4+LHRt5ge5+3WRenMB5UMdTlTWt2by9cnwvXi4tmLida15f1
         bxTUKviPPALoltjQ4KwXlLf+bLeZCQ7aOXV0pVyLvryE4wuNRH7sXi5AZOw3D5JwQEwf
         uT6AfWWiD1kDwZ+TKc7Ri3iZG+2CNAZdA8Lst3Lkz4a+t13+lIoacqOi5xQRqUFO7u71
         QoHxsRkU1f3iOr3ZRYcyTIgM/yDDUTvv/d/uDEPwYJQxqpfxkm8xmLJST5p3KtgTsCHP
         tBR1nAaOHqjUJKAm4bTrheGtAHtK2BS+6lQWW02l3QMBGoCUk0r57bO1yDH7nihQdiw4
         XrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180886; x=1793785686;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYZhchboGdwW91hytv6v3TXakRJE+HGcbwVnqbNsAYI=;
        b=RXMw0TkKCPbIj8qKU/HW4gaiuDHaUD68BD2yYsIBOj0OrBOaWEN9QOfmhqn2M4sExJ
         XqIiarrlBp33lOWJvEIgTEBzeSv3Jysd7tcpz5rfc8ZjAFlm1BKbMrzIybyD5YlcU1kA
         clMHT806ju2ub5qEViOxKOBwJ9QW3SJQMcxOYd3dr7UjTlj23F+Nizv0Bbe2/OHlnG8a
         1ZGmx9tTrMqqhGGTMCDOTrGPlDuzBKq/JUvtS2FJXhnYbObvmIktmYyc75fGRLvRIgcQ
         WrrFsMqGvgsWluV/82J4E7HLOWlpjPlFev/yLRUiGH2kX5D8MDxZmhDjdSifW6hVToOz
         ka9A==
X-Gm-Message-State: AFq9FYJMAdqqzetrm4F8URAOF8/PZ8B9s1xLRIjYqzFmgFme6gBvZUkE
	BjMgu70IC1QbK9woZ3u/dIHVWipUvgDUCS9tvjwd7tOlexLOC/ZVwc+Z
X-Gm-Gg: AYBFou0FfxVeYD/VzTPX9yjuHgT6mYedKhrIZN42+WQZhRkMdS7bPQ7Uco/bo5GRQtP
	TllLsze3aZuhg9GZlrtPyC42TgbqDOFXD7E5Exx8GeOcW4e9PMGls19EiHgz+c7zLX1UWDn4G9I
	Nu0dQqZ8BRUDLiW9K9ysPyBpM//oIHsowqlhwWG9ryCttNvIC/rJyT9nc+O2zPZRhFfeA6D7Rh9
	N7Sg1Hjy9cZgRmpMhC8RoE0gqwBolVazTHL1lF2L6AoNVj1iEFloSAZhp8YPJjCDakTeFjzvrJ+
	B8dH2AwligVUFQKLFtRRRdLPnnnWTE4WNsCzJ4Od05gDkkkPDe93lngvj4jSkOanbbZyvFhufYV
	JEX8r4t8wtWrjvYuoAJ/Z2XNoIdZ/h7MFRKO6hi5RTv5LvNhk9p6x3qSBmPNDxzXEO+cJ4c9I5n
	VOq1NWg2hxnMgkw51AYqf6GONhcStDmtdOHNxLnItaF0C1ch6G3gsM3b3yO3xjj9sOZRD27JmVq
	IugvsEvA8hLUxSdWcXp5BEEya9Ir8lxf7tUZ/fEx6h3zcJgQNuFg6ckT+HK5ebcjk5VQY9JfgbA
	8OgS75cfxNqfAJcLNnsK9mT1MBbxKRPy2BxNkoYKOQzJbTJzsz3Z56OEfTDAE9iAoG0=
X-Received: by 2002:a05:600c:1d01:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4a99735208cmr25407025e9.12.1793180885624;
        Wed, 28 Oct 2026 02:48:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:13d:528:68fc:144d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94fce50a8sm26496985e9.4.2026.10.28.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:48:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/3] fetch: advertise fetched refs when backfilling tags
Date: Wed, 28 Oct 2026 10:47:58 +0100
Message-Id: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOy2rDMBCF4VcJWldFGvk2WfU9Qhe6jCwVJy6W4
 rQEv3vllILJwl0eGL5/7izRFCmx4+HOJppjiuOljPrlwGzQl554dGUzENBIIVreIvIU9DCMN+4
 p28BvMQeedZ+4a8Ao8gbQC1aEz4l8/Hrop/ffna7mg2xeyfUixJTH6fuRn+V691fC3dIsueSqR
 dfIWlTa12/9Wcfh1Y5ntpZm2FgS9i0oVgVSEmqpnLLPltpa9b6lioXCNKQ6g52DZ6vaWPDPX1W
 xOi0tkleI5LbWsiw/xtYqsLwBAAA=
X-Change-ID: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
In-Reply-To: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8404; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=CkKw6l0nUOhcc7IcL44qU/oCsdNepuTJ8v++ocC76t4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrhxNN16iws3rOoYTykpXnSyU6ncBZKRfmzI
 neu8H3JbK/JbIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4cTTAAoJED7VnySO
 Rox/arkL/0t9ckZGk2Uj+KPm5Ai1+HJpt9gyCW+E+B4/pfDxhSme5FSteO9m15e6Ov8nMxDQTRd
 TIhvQd5PfwbLt+4sy03qZl3iD/718FB1EibZj2FLJaV39qKQGThJojVeHbyzU6SIFhDNFy4ItGz
 2IN37ho3kNdY2L7SKSF9ENuz5MT1haUsFzbJzj5ZyBY5maUQTcrbaqbXo0XKfWS3m95zlnxrhgo
 cV22bGMdF9AKrWNNalmu2T7EWvdJl8KXGsbgx5DjEKoZYwQtXLAvLdeUcen1TILplGfkdehlydU
 xvgTJtjbXjAbaDO7ojyFqPebTxiEQucYa8lw8PitUynGCG2jiqV6WKYhMKTqgkXSD6NFeP3/9Ex
 UoEKs7YPyVN3CkqUGVssd0uEXW2SVw7r3dyRXVUnvEkw7B3vz8ic6ZY4e51D/RQyNE6i114ApUm
 zjKUezUmN8xTdHJNsuXuK/zxAvzQcNPT8m8KptsHU58ZlT+t4reoHBhUObAfUnQIpH1xJvOIXX6
 sg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].

When fetching, git-fetch(1) performs the reference updates in two
steps:
1. Fetches the regular references
2. Backfills any tags

With batched updates, both of these operations came under the same
reference transaction. Unfortunately, this meant that the initial
references fetched were not committed and couldn't be used as 'haves'
during the negotiation when backfilling tags. In shallow repositories,
this could mean that the server was sending objects the client already
possessed. This series fixes this regression.

Earlier versions (1-3) tried to fix this by splitting the transaction
into two. Which works, but makes the code more complex and is a bit
messy overall as we have to deal with errors and also jumps in the
codeflow.

Justin suggested that we could use the references already available for
negotiation instead, that is what v4 onwards does.

[1]: https://gitlab.com/gitlab-org/git/-/work_items/799

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v5:
- Add a patch fixing a pre-existing leak in the remote-helper
  transport's cleanup. This allows the patch to drop its manual cleanup.
- Move the upstream-info test into its own commit.
- Some cleanpus around the commit message and grammar
- Link to v4: https://patch.msgid.link/20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com

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
Karthik Nayak (3):
      transport: add `transport_options_release()`
      fetch: advertise fetched refs when backfilling tags
      t5510: cover upstream info update on fetch failure

 builtin/fetch.c    | 33 ++++++++++++++++++++++++++++--
 t/t5510-fetch.sh   | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c |  1 +
 transport.c        | 24 +++++++++++++---------
 transport.h        |  2 ++
 5 files changed, 107 insertions(+), 12 deletions(-)

Range-diff versus v4:

-:  ---------- > 1:  583369ce44 transport: add `transport_options_release()`
1:  8e21cf3377 ! 2:  3a53029bb1 fetch: advertise fetched refs when backfilling tags
    @@ Commit message
         `negotiation_include_tips` field. This also fixes the issue for
         `--atomic` fetches since it follows the same route.
     
    -    Add three tests, two which validates that the 'haves' are filled when
    -    backfilling tags for atomic and non-atomic flows. The third, to test
    -    that upstream is still set and tags are backfilled even if a sibling ref
    -    is rejected.
    +    This does mean that all references fetched before the backfill will be
    +    used for the negotiation. While duplicate OIDs are trimmed before
    +    negotiation, we could still end up with a lot of distinct OIDs used in
    +    the 'haves' section. However, this is still better than the server
    +    transferring already existing objects to the client, which can take a
    +    lot more time.
    +
    +    Add two tests, which validate that the 'haves' are filled when
    +    backfilling tags for atomic and non-atomic flows.
     
         Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
     +			 struct list_objects_filter_options *filter_options,
     +			 const struct oid_array *fetched_tips)
      {
    -+	struct oid_array *to_free = NULL;
      	int retcode, cannot_reuse;
      
    - 	/*
     @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
      	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
     +		struct oid_array **include_tips =
     +			&transport->smart_options->negotiation_include_tips;
     +		if (!*include_tips)
    -+			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
    ++			*include_tips = xcalloc(1, sizeof(**include_tips));
     +		for (size_t i = 0; i < fetched_tips->nr; i++)
     +			oid_array_append(*include_tips, &fetched_tips->oid[i]);
     +	}
    @@ builtin/fetch.c: static int backfill_tags(struct display_state *display_state,
      	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
      					 fetch_head, config, display_array);
      
    -+	if (to_free) {
    -+		oid_array_clear(to_free);
    -+		free(to_free);
    -+		transport->smart_options->negotiation_include_tips = NULL;
    -+	}
    -+
    - 	if (gsecondary) {
    - 		transport_disconnect(gsecondary);
    - 		gsecondary = NULL;
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      
      		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
      		if (tags_ref_map) {
     +			struct oid_array fetched_tips = OID_ARRAY_INIT;
    -+			struct ref *rm;
     +
     +			/*
     +			 * Collect the tips we just fetched so the tag backfill
     +			 * can advertise them to the server as 'haves'.
     +			 */
    -+			for (rm = ref_map; rm; rm = rm->next)
    ++			for (struct ref *rm = ref_map; rm; rm = rm->next)
     +				if (!is_null_oid(&rm->old_oid))
     +					oid_array_append(&fetched_tips, &rm->old_oid);
     +
    @@ t/t5510-fetch.sh: test_expect_success "backfill tags when providing a refspec" '
      test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
      	test_when_finished rm -rf base repo &&
      
    -@@ t/t5510-fetch.sh: test_expect_success REFFILES "upstream tracking info is added even with conflict
    - 	)
    - '
    - 
    -+test_expect_success REFFILES "upstream tracking info is added with conflicts and backfilled tags" '
    -+	test_when_finished rm -rf base repo &&
    -+
    -+	git init --initial-branch=main base &&
    -+	test_commit -C base one &&
    -+	test_commit -C base two &&
    -+	git -C base branch foo &&
    -+	# Backfilling only takes place for tags which are not pointing at tips.
    -+	git -C base tag -a annotated -m annotated HEAD~1 &&
    -+
    -+	git init --bare --initial-branch=main repo &&
    -+	(
    -+		cd repo &&
    -+		git remote add origin ../base &&
    -+		mkdir -p refs/remotes/origin &&
    -+		>refs/remotes/origin/foo.lock &&
    -+		test_must_fail git fetch origin --set-upstream main \
    -+			"+refs/heads/*:refs/remotes/origin/*" &&
    -+		git config get branch.main.remote >actual &&
    -+		echo "origin" >expect &&
    -+		test_cmp expect actual &&
    -+		git rev-parse --verify refs/tags/annotated
    -+	)
    -+'
    -+
    - test_expect_success REFFILES "HEAD is updated even with conflicts" '
    - 	test_when_finished rm -rf base repo &&
    - 
-:  ---------- > 3:  e8a5ce9e5e t5510: cover upstream info update on fetch failure

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0


Thanks
- Karthik

