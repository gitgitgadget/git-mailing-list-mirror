Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2E495508
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207907; cv=none; b=jfH64V8tjF/FcuikgSOkctCUCocjSlucWWvq2lMwNS0DBWjGvWdS0+e4fhRz5DyNhlVihvDlLnvy5LxXb+rD5vO17Gz9WTtggwQiGUUJelZsuAGxXnEI+7s39GfdwapW6ltimqYfAP29apNtmX1HWnh2kRbxDKpSzytWelivg3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207907; c=relaxed/simple;
	bh=R0dIITEvNCIZ+VcfRpbNC7dzRbDdVz1XgYOx0cyB/E8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jGXrBU9OU7244oiSah8JKRRm83SbPsDaikvmvi/A19DfuIeVYux84f04irYxRdlIc5JfVo6aQ42uX4RYOg05weGbAJjsjTwVIrLxexZwUlqwAJW6ABeBYLsEHq65DTgAu3fjzZ/0z0Pc19UW90b+8gomq3UjGCzmnE2iM5W+whY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E91dXRdY; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E91dXRdY"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4992361eec.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207905; x=1779812705; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBcpYoUKCCelQTZZOV4T7sEX0Z+WoWiIZ//NeHzQmDc=;
        b=E91dXRdYEh1FFaSqLHFtySy/6jMx+S5djkp9RCGsT7bN8iyto0d45PglghxNEDbse6
         /rsR7EVxqqZt4o7qZt1UGWAtZJImqOZIPsuOZXLJrKEKQW7tTYYzGJPUflI/JHHy3O7n
         Wtm9f7K1SFtRtw/jQ9NjfG6miy7bdp5BQsRcxqBSh7z1ABQDnq3Wtr3YWRXIVx44bic7
         iMq3IwbBOQbzzdCeLiHkvDhOLBvYoW6/urzo+R0d8xl31zmroJsarrq3PP0rSB+3YbTo
         jffjHwfBigrAqjrEUn3IkT0jjKa1o1XDG6sE7ZTQ13WAz34FeF4oz2aZ2BaON0ziPz6z
         a4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207905; x=1779812705;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cBcpYoUKCCelQTZZOV4T7sEX0Z+WoWiIZ//NeHzQmDc=;
        b=Ni+cyrzFo5xIMd4rWBsYATj51rdhMCuBKm/x79b6GYteaoG6Fz8wXS4AdtHgUO4qFQ
         duH+3GW/AB4ShYZGxWoKqM6KltPdG8tuuDmfQ1QSm3qZA35lmwXpsoFkv3bqSI/2ULZm
         1C2OG5yUdzpvCyL9176X0WyX3nfKmAA0n7hgmBbPruGtqlE89Kj2yPcj+HSrw3qHYdJU
         DKOC86BP9uElTkWz77xVGOtr1lw1TP0c+xEcRp8hhhsbUKdTlBRiSvS6G/pE0DeqbzhY
         v1LgyuPfobv88I8NYpn9v2Ft3yCAKityequsj5Ds0gbmbyasI6rn3nEpSwl/0S7BJShy
         BHhw==
X-Gm-Message-State: AOJu0Ywx9s6ZxS8LR/KTQxk0RaZpiyjMQavM5ZXyx8EfQw7UGQXoY0BB
	rW50+JZkWTuM6LmfpqcIw8VNKVejKQ3EYb/EksNlLHap8yYm/wMx8/TlkdBoRw==
X-Gm-Gg: Acq92OEbj7rvkr8BSdbzFUMwsAy6wc63CuxGPVUH92VeVY5w3rnmYedGvcT55dc3r0T
	BcbfjfiZH20CwJGe5KTZrNZrDy/ujYjxb7K1/afs86m9h0HGePdC1z3LeneqmUgsmmTrFLYT4S0
	fi6E3P1uSEuDL9YOeD73k3PmMFkmIBnQ38E0YZR2BcN6lWtPsUZZrx0D7gBLFE7oD89odpvIO7D
	K8k6KrcYQXFs8nH+VVQvnfH9MeNDoC5yl3+EpE1csWrlW9+n+FkQABdQgNaOwFvpX+GkPN4uAkC
	7g5YHwM+GFgOGfl2q2tihKjM5RKCp36kUxl3JjKgGvsqGGEsJbUXV1LhWJU2DRJFFUNZCyiXCU/
	T+ewc5MctmbetTZMzPtfJdok1VLrG+U4ASJ5/pi7sAK7Z4Yg+8uviOTlaK4ONyCVDllt3H+xgHx
	o7CYZdi8yizFSZrjtF+rHyRTq+f8YK
X-Received: by 2002:a05:7301:4188:b0:2e0:909a:b9c with SMTP id 5a478bee46e88-30398183f2emr9083349eec.15.1779207904477;
        Tue, 19 May 2026 09:25:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30297bbc9a3sm16453657eec.31.2026.05.19.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:25:03 -0700 (PDT)
Message-Id: <840db1d957cc7f59cf42476cb05cc389a3f34509.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:52 +0000
Subject: [PATCH v6 5/8] negotiator: add have_sent() interface
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In a future change, we will introduce a capability to choose specific commit
OIDs as 'have's in fetch negotiation, with the ability to have the
negotiator choose more 'have's to increase coverage beyond that required
core set. The negotiator works to avoid emitting 'have's that can reach each
other, but that logic is hidden beneath the negotiator's iterator function
pointer ('next'). We need a way to communicate to the negotiator that we
have picked a 'have' so it could incorporate that into its logic.

Add a have_sent() method to the fetch_negotiator interface. This is the
signal that allows the negotiator to track the commit as already shown and
can perform the proper bookkeeping to avoid emitting those objects or
anything they can reach.

For our non-trivial negotiators, it is sufficient to mark these commits as
common, so the implementation is quite simple. This logic will be exercised
in the next change.

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 fetch-negotiator.h    | 9 +++++++++
 negotiator/default.c  | 8 ++++++++
 negotiator/noop.c     | 7 +++++++
 negotiator/skipping.c | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index e348905a1f..6ca422a064 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -47,6 +47,15 @@ struct fetch_negotiator {
 	 */
 	int (*ack)(struct fetch_negotiator *, struct commit *);
 
+	/*
+	 * Inform the negotiator that this commit has already been sent as
+	 * a "have" line outside of the negotiator's control. The negotiator
+	 * should avoid outputting it from next() and may use it to optimize
+	 * further negotiation (e.g., by treating it and its ancestors as
+	 * common).
+	 */
+	void (*have_sent)(struct fetch_negotiator *, struct commit *);
+
 	void (*release)(struct fetch_negotiator *);
 
 	/* internal use */
diff --git a/negotiator/default.c b/negotiator/default.c
index 116dedcf83..05ab616f39 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -175,6 +175,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
+static void have_sent(struct fetch_negotiator *n, struct commit *c)
+{
+	if (repo_parse_commit(the_repository, c))
+		return;
+	mark_common(n->data, c, 0, 0);
+}
+
 static void release(struct fetch_negotiator *n)
 {
 	clear_prio_queue(&((struct negotiation_state *)n->data)->rev_list);
@@ -188,6 +195,7 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(ns, 1);
 	ns->rev_list.compare = compare_commits_by_commit_date;
diff --git a/negotiator/noop.c b/negotiator/noop.c
index 65e3c20008..edf1b456f3 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -29,6 +29,12 @@ static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
 	return 0;
 }
 
+static void have_sent(struct fetch_negotiator *n UNUSED,
+		      struct commit *c UNUSED)
+{
+	/* nothing to do */
+}
+
 static void release(struct fetch_negotiator *n UNUSED)
 {
 	/* nothing to release */
@@ -40,6 +46,7 @@ void noop_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = NULL;
 }
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0a272130fb..69472c58e1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -243,6 +243,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
+static void have_sent(struct fetch_negotiator *n, struct commit *c)
+{
+	if (repo_parse_commit(the_repository, c))
+		return;
+	mark_common(n->data, c);
+}
+
 static void release(struct fetch_negotiator *n)
 {
 	struct data *data = n->data;
@@ -259,6 +266,7 @@ void skipping_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(data, 1);
 	data->rev_list.compare = compare;
-- 
gitgitgadget

