Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180889;
	b=JUoVc2CD5rGJNFlQoTXrgGTF0+6vpHsLDbHW1J3iwB5f+iS/rMCXgOl2u9tytFeYuhYF
	 Oe5Ai1kxzGbWZnliTpN88OMCcu3/syo+5UlxBFNYjMEs117rHaDMbDlgvu2GdPSOxVn5W
	 c3vySM91ZqMPopGe2qFFymRB+hQ+qyjTTFetG5uCybacRQmoSpTij/M79RaQOM3bXvopX
	 ptkS09a7OI9DwJW7WwsU2G1IU+FyThzYyc2ux4VC7vcKCNrtb9hdeQ5Dw6nd+ed6yAmhT
	 jHgnKUF48MhrNvlRsKtWypdEaQEKxDQfy1XtGhwdzDPaxRbTKZjrk1Sh2yfCwUGW7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=cZyhNqdKdYL4pMfqgDsJHr1O4QtWkOpOeuCljBemgh8=;
	b=rEcG1ZoILCUGIxaOiHl2Pn3xmFqCwSu7EGBqUwRc+5iSm8G1+hzAw43ilN/N8VZvcrDT
	 NVsc2xYGthgb2BvG0oUM8H4dBfC/H+G6XTSk6W2soqxm7sYOSMDcIjQHoAvDE6kpmQB9y
	 3Xef6UnGz/ogzinDhRfwcYwzcXOhuKGXcd+u4t7xByR1GD6F1hCP/wgBYuYINEq/Aye/Z
	 RgQXmL26vDenyCVYf9yKNLWE8PyyN7p+rWY0gKiVoAz5C9WstTiTTy/JvXEGSv7BvujAJ
	 5FRLaIgLiaVbrMRJBeRfAsFjE1Wdra2VZiDyOsLohuWpqyLOTL5WvdetJfXopqNQlZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNbJ2xcN;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C3606A326
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 09:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8C3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNbJ2xcN
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso6440665e9.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 02:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180888; x=1793785688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cZyhNqdKdYL4pMfqgDsJHr1O4QtWkOpOeuCljBemgh8=;
        b=gNbJ2xcN+8L3JB/rRIg4lMDOz2Q8MgrqCp0J2er0JibIL1X+bnZAwI8H9apDLPLELh
         /EV6lcURzBiRVRB7GxJnIvn41RrXaBBb4eSaSsrWYpeNCkW3IvjGvcuFsr2nLBsJ7lM0
         b8tmY4H6pxHeEvCqPLSdnczYzneahi7yeosxrYMJl311RMiZQDF7h3TYCaO2OrRIwgec
         HMIYGdNUUMGn/LP0MNRYhhJKpJrd3SKsQczz+f/EH8ireabf5Yz2W5hcgt6PTGHa+SCD
         S4ySmEXDhPgKeJlJfHRBKHvyCurbjAfFwmOyMRjKjplzzpviGhu/sVT0Mckdb4Ws43LQ
         1vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180888; x=1793785688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZyhNqdKdYL4pMfqgDsJHr1O4QtWkOpOeuCljBemgh8=;
        b=iSuWQZF/jfNKlu5JIWPQDUpGvP8IPuZltNEueu5K2nwawbrJ3t5BjyON32O054oVcm
         4iDN2FOg8i80DScMkiXkgicGDVR564iZcqq6Ie5FvOn3SgUtvuyNZjJdouB/+b2D6nMV
         L6Lct9LF1DhdKxF1m7uJz43J5oleVhg/JzXnQZ9+26UaE3EjJoQGIf0WgW5+N18i6Wwa
         vq67j4MrPA/C+073rNJkQVBXoSeBI8MDkNGoJXfdsBvCquZ0tuOKnoUsOXnFb7NHwGuy
         1R5ZrTvzja5+4l2zCvYg762G6DYkoPKqlcCX4vLuCFRy8TJrtJkU0HEFa8C+QpHORMYd
         ClmA==
X-Gm-Message-State: AFq9FYKRIyP9rJCnCn8focVm38kuayYilGbtb77Fkg7HajLgHILiKTIu
	2wtdspvF1zfI0Uf9/MFuB5b1UHbkW3qtA0/wFd0cKwNsM2uTfKYgClDN
X-Gm-Gg: AYBFou3Pr8sTLetT6Ieu6Pq7ewovJZL0wP2d2vFoEj5vYb2GVcX9/gD+OPCI2D8WG5M
	/2pwGGYZl7o3PDA/g7ocfgjW9VEgyGQvt4/zglYa0PnBSpNg2Kllfbmk+fNYR8GqmeV8/zxdth0
	LcUCEaw6P3hwQqQDnZD5teBodGQH7Xl89hfRQjFBOGPuDxymAG9QklFkjm9cAn8ntMu72xsLo3T
	aBLWW1P5SsLCYp67wLKZVjCojrMGUc8kMUZCMpl9rK3Qo5JHPsRlIOjvHditMUPb16euADihLdC
	4O4FNgb8ZOnnq63p9GuvR9wKqZx8JfSA2qGGyJTaMMMQlZHmaesp08Ziul5w2mAagqz5O3ZrcjJ
	oVkJeSDq2+2COHQ9zgV4SjId8SnQb/T4Sl9TX6/ZOPE3ROxtSXkUbru1Vl80PgiqSMfUh1cDqMV
	KysFR6qg617fOtvJFA7nSMPC0g5M9+ei7j7QO6b14Q/M7+hObdTigRRoSSUlpkrWu91rTtvu49c
	JiWy2he9Tie0z+qkQsfWdCFTRzweQm6jOQ94ZVmFzXRVzw+U70yXDuyNTU8pKN6u4qmyJznLByj
	KnHesHCyf9+IhzoBDm0ziRhJEHdEGlOfg4c4rFA8lWFlVf4iTy0UZ9iivDUpaORACvF3p39akDv
	ev+tkGe5MfGEE
X-Received: by 2002:a05:600c:6088:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a9677ca203mr38258575e9.27.1793180887748;
        Wed, 28 Oct 2026 02:48:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:13d:528:68fc:144d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94fce50a8sm26496985e9.4.2026.10.28.02.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:48:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 28 Oct 2026 10:48:00 +0100
Subject: [PATCH v5 2/3] fetch: advertise fetched refs when backfilling tags
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
Message-Id: <20261028-799-shallow-fetch-with-tags-v5-2-7c43cc9ae810@gmail.com>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
In-Reply-To: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5916; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=aG0LFaaZ6Zq9XB1qA3QCDv4R/Lh1y40fMLXZFPQLvBg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrhxNSXZHgAyIwoORqxYtG/3KnXd8lLO4aRb
 hweI1Lbl/mcaYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4cTUAAoJED7VnySO
 Rox/7BcL/3r4yOxxXaDWjTS/G+kMY3Ju7PxZTMsh+CyM4kaaj2T8n5U2hc6dfDSDYFuJusQW9fB
 fBobi8jZ7yBI7xufNs3Oia0EFfxs2JMqpH5b88zIL4oqciyKeJULciVjO39OmU3cZXufoIF9mt3
 PoS7uiuzlZF3qqBuHF3V3mCtiRSVSI9L4BBde4cfAQwI5Ax7SDoBQ3K0iXSZlpLZPO3SSDaAgpr
 GxrQ+Z+gRiPvMjUaeX9IW9Lo60fmpRGPSEPxYggb/1ch7Zg8+6PzttIDVZhyhh49kwK5S9WZ+sI
 tx2rVLSgIGmt2eGkljfN4CmOpRosWw9CNZqMdYhsFmVWpwIvUDonxHMIEdgbVq11Fr6iWzDmLWZ
 kOd9GaBBSBXQMN/rRm18mx2h8sy3TiwYZVM7Ws0Q1QY8SDQfc3Mgs0wbG7XP8099Eiu9qQJnJ5j
 OVOgp8GjXSXLUPX5S8w6WQNkmAyDQSF0DmvAYkQ3xDqLUH3/HxQhCfOwhowaPPY+ln/amP6LJU5
 1E=
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

This does mean that all references fetched before the backfill will be
used for the negotiation. While duplicate OIDs are trimmed before
negotiation, we could still end up with a lot of distinct OIDs used in
the 'haves' section. However, this is still better than the server
transferring already existing objects to the client, which can take a
lot more time.

Add two tests, which validate that the 'haves' are filled when
backfilling tags for atomic and non-atomic flows.

Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  | 33 +++++++++++++++++++++++++++++++--
 t/t5510-fetch.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..d3974faf6b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1676,7 +1676,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct fetch_head *fetch_head,
 			 const struct fetch_config *config,
 			 struct ref_update_display_info_array *display_array,
-			 struct list_objects_filter_options *filter_options)
+			 struct list_objects_filter_options *filter_options,
+			 const struct oid_array *fetched_tips)
 {
 	int retcode, cannot_reuse;
 
@@ -1697,6 +1698,21 @@ static int backfill_tags(struct display_state *display_state,
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
+			*include_tips = xcalloc(1, sizeof(**include_tips));
+		for (size_t i = 0; i < fetched_tips->nr; i++)
+			oid_array_append(*include_tips, &fetched_tips->oid[i]);
+	}
+
 	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
 					 fetch_head, config, display_array);
 
@@ -2077,6 +2093,16 @@ static int do_fetch(struct transport *transport,
 
 		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
 		if (tags_ref_map) {
+			struct oid_array fetched_tips = OID_ARRAY_INIT;
+
+			/*
+			 * Collect the tips we just fetched so the tag backfill
+			 * can advertise them to the server as 'haves'.
+			 */
+			for (struct ref *rm = ref_map; rm; rm = rm->next)
+				if (!is_null_oid(&rm->old_oid))
+					oid_array_append(&fetched_tips, &rm->old_oid);
+
 			/*
 			 * If backfilling of tags fails then we want to tell
 			 * the user so, but we have to continue regardless to
@@ -2086,8 +2112,11 @@ static int do_fetch(struct transport *transport,
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
index 300bd5396d..7c1f8405df 100755
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
 

-- 
2.56.GIT

