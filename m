Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB83A5E8B
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562785; cv=none; b=DNHpTl83AhHfdQ4i6P1RQ/dlWcL9RPVLHy+gY8kkMW8sEVsJQIMnYOHdzH1PTtUHhj8RRJdbOP3M8ySzVX2SljMk2ktu/X9WscR6S7vBb5XgSdM8STORPbWrLWe6fuVHky/FhjcbtqVcFFZ6sQFpDoep/ad/zpzv6zhPoqXUXMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562785; c=relaxed/simple;
	bh=qxiJksCtRvwZgz9XuLkn74oixBAiZkS/ecv9xlq0pko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHLNH3NR+rqp04RlTIHzgzlIvi2gZ5w5RPOs3ngUSg1zTuZz5Js7GFI83TlTA8400WONvrE87QW7ZzqKrNZP1dFZsgUs4wunVzkhrWhdWEH2V/kqNXL7eI/J5V1Vj4HKQEfHdlBsQHWhHdDzxTxoAWAWmimE2cDpFyvhJDZHUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEb+2tZs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEb+2tZs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso15342835e9.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562782; x=1776167582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bCqnrnHpl8GOV7NAaKUCsDgciGNJsvbp8OH2Ezs9EA=;
        b=MEb+2tZsm3+LuQVM0mfugS2jV0akctfzP0R/IwsYJJeYAjWSpOAPbQbJSypt/t3Iw2
         +Lq0qJ2PXEatep3FLRba4KYT3aBkmIgSwydxq11Ky/fytHK30WYvvZZlQryxfS2h0e3r
         mmR7jWfumxnBv1I4OgLNbJPMHB8V9IZO4GM24oOVKPw43MzNJ/LdpoyUFtXyORokGBUh
         R4K1s1grQ1EPmRa+8Hwup9uRd15PW0r5VWUoDctPIrbi1Xgw6p2l/Jdmgs4L3kdTXciT
         SDWUqHThTfrcma9DEcbCH5guk46IN9FtdqDj2EOgmTPfL0AP/0cm9YNoNCqla6fJUy2c
         JHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562782; x=1776167582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9bCqnrnHpl8GOV7NAaKUCsDgciGNJsvbp8OH2Ezs9EA=;
        b=iD0X9fFcGUca3zxsfhgOWnu7rRVW6ybqxCYuaLY8F+VCKzVZmSW/HW9QG33NoX2opQ
         /Ojp+yYoqxJ4NdtZGGw5YGLCSPjS9wDNNWA8smUUASgrlwYwGAT881006YjF8+BsvTXm
         uS6ca88auz7V3Oasuo9px2kwZFkj+lPBUpDsdeSpQHoO6BePEafv68wxtUy5EIfa09He
         0my2R+vhR9e0RblgW2Xfu6lE6NStezmqm8Z5vAiS2xSb4U0LHtj1m4gKnkkDS1tTLDge
         abfbX4q8TManjW+7wE4XsGxNp8K5DSr/26Tl5+2BvD76bx7YnRdDdCoB3lxpqXSQ5WXX
         JinQ==
X-Gm-Message-State: AOJu0YxQL2Rw7dSLqXGH1hgJL/NRukVcYziSP4Uc0zPP65fDzo9wgev5
	f91Lq9wTSUZlVzy54JJnArBfoqctJN7bSo/Oj/VK85q0Aoc0+23Y3tRrtyxwfw==
X-Gm-Gg: AeBDies5NEwOMGjOJGbBHr0D7r0+zRtbEwcvsKWZXd6jlDXQ8GDA6GXWzcCXw98J+Ua
	Xd1vchA1TAaDx0Et/+lJDC7X2KaBO4u6KqL4hXatu0z1SSaDOLe44BlsxIdf3iomeRl/Q6W4p7V
	xhqtxOrwRgyZxpMRjFQvBWFz6SWYJWWV8YZhJm8QT4EqpXKQyPKPx9PZVpKLl0N4HozOla7uE6H
	0ygklHIyAL9uqowF+JZcBr9aN2x5OOMyJel9yH1yHXag6P+XDXljO7dzbS/67zKtqzortWOoZI9
	YsFpk+5FSgKUTjI6+qZXPt/FvXneGpVQBwUFYvW1kbJTP37GPhe1AzYZBpbNXapeq+SwabVB1mZ
	mCugSzCk7+nck/HLpo4i/Rh3JDgxv321h/8BFpGhrexYjm85lycrd2p3bG4GWne5Q9pmsC3LRAm
	M3Ep8/4MKbXnM0IMmU3DBzbKg7562X804rqSTGdQN4mFjvDRqfBwBU5j3mM/HT9GdjOMMVuskV7
	J6NDeB81FNXJlJa2rBAulP5ul+ZK/u3vlzElLQ=
X-Received: by 2002:a05:600c:6986:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-488996ecae3mr207800295e9.8.1775562781859;
        Tue, 07 Apr 2026 04:53:01 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:01 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/10] promisor-remote: try accepted remotes before others in get_direct()
Date: Tue,  7 Apr 2026 13:52:34 +0200
Message-ID: <20260407115243.358642-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a server advertises promisor remotes and the client accepts some
of them, those remotes carry the server's intent: 'fetch missing
objects preferably from here', and the client agrees with that for the
remotes it accepts.

However promisor_remote_get_direct() actually iterates over all
promisor remotes in list order, which is the order they appear in the
config files (except perhaps for the one appearing in the
`extensions.partialClone` config variable which is tried last).

This means an existing, but not accepted, promisor remote, could be
tried before the accepted ones, which does not reflect the intent of
the agreement between client and server.

If the client doesn't care about what the server suggests, it should
accept nothing and rely on its remotes as they are already configured.

To better reflect the agreement between client and server, let's make
promisor_remote_get_direct() try the accepted promisor remotes before
the non-accepted ones.

Concretely, let's extract a try_promisor_remotes() helper and call it
twice from promisor_remote_get_direct():

- first with an `accepted_only=true` argument to try only the accepted
  remotes,
- then with `accepted_only=false` to fall back to any remaining remote.

Ensuring that accepted remotes are preferred will be even more
important if in the future a mechanism is developed to allow the
client to auto-configure remotes that the server advertises. This will
in particular avoid fetching from the server (which is already
configured as a promisor remote) before trying the auto-configured
remotes, as these new remotes would likely appear at the end of the
config file, and as the server might not appear in the
`extensions.partialClone` config variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/gitprotocol-v2.adoc     |  4 ++
 promisor-remote.c                     | 44 ++++++++++++-----
 t/t5710-promisor-remote-capability.sh | 69 +++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index f985cb4c47..4fcb1a7bda 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -848,6 +848,10 @@ advertised, it can reply with "promisor-remote=<pr-names>" where
 where `pr-name` is the urlencoded name of a promisor remote the server
 advertised and the client accepts.
 
+The promisor remotes that the client accepted will be tried before the
+other configured promisor remotes when the client attempts to fetch
+missing objects.
+
 Note that, everywhere in this document, the ';' and ',' characters
 MUST be encoded if they appear in `pr-name` or `field-value`.
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 96fa215b06..7ce7d22f95 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -268,11 +268,35 @@ static int remove_fetched_oids(struct repository *repo,
 	return remaining_nr;
 }
 
+static int try_promisor_remotes(struct repository *repo,
+				struct object_id **remaining_oids,
+				int *remaining_nr, int *to_free,
+				bool accepted_only)
+{
+	struct promisor_remote *r = repo->promisor_remote_config->promisors;
+
+	for (; r; r = r->next) {
+		if (accepted_only != r->accepted)
+			continue;
+		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
+			if (*remaining_nr == 1)
+				continue;
+			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
+							    *remaining_nr, *to_free);
+			if (*remaining_nr) {
+				*to_free = 1;
+				continue;
+			}
+		}
+		return 1; /* all fetched */
+	}
+	return 0;
+}
+
 void promisor_remote_get_direct(struct repository *repo,
 				const struct object_id *oids,
 				int oid_nr)
 {
-	struct promisor_remote *r;
 	struct object_id *remaining_oids = (struct object_id *)oids;
 	int remaining_nr = oid_nr;
 	int to_free = 0;
@@ -283,19 +307,13 @@ void promisor_remote_get_direct(struct repository *repo,
 
 	promisor_remote_init(repo);
 
-	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
-			if (remaining_nr == 1)
-				continue;
-			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
-							 remaining_nr, to_free);
-			if (remaining_nr) {
-				to_free = 1;
-				continue;
-			}
-		}
+	/* Try accepted remotes first (those the server told us to use) */
+	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
+				 &to_free, true))
+		goto all_fetched;
+	if (try_promisor_remotes(repo, &remaining_oids, &remaining_nr,
+				 &to_free, false))
 		goto all_fetched;
-	}
 
 	for (i = 0; i < remaining_nr; i++) {
 		if (is_promisor_object(repo, &remaining_oids[i]))
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 357822c01a..bf0eed9f10 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -166,6 +166,75 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	check_missing_objects server 1 "$oid"
 '
 
+test_expect_success "clone with two promisors but only one advertised" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client unused_lop" &&
+
+	# Create a promisor that will be configured but not be used
+	git init --bare unused_lop &&
+
+	# Clone from server to create a client
+	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
+		-c remote.unused_lop.promisor=true \
+		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
+		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
+		-c remote.lop.promisor=true \
+		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
+		-c remote.lop.url="file://$(pwd)/lop" \
+		-c promisor.acceptfromserver=All \
+		--no-local --filter="blob:limit=5k" server client &&
+
+	# Check that "unused_lop" appears before "lop" in the config
+	printf "remote.%s.promisor true\n" "unused_lop" "lop" "origin" >expect &&
+	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
+	test_cmp expect actual &&
+
+	# Check that "lop" was tried
+	test_grep " fetch lop " trace &&
+	# Check that "unused_lop" was not contacted
+	# This means "lop", the accepted promisor, was tried first
+	test_grep ! " fetch unused_lop " trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "init + fetch two promisors but only one advertised" '
+	git -C server config promisor.advertise true &&
+	test_when_finished "rm -rf client unused_lop" &&
+
+	# Create a promisor that will be configured but not be used
+	git init --bare unused_lop &&
+
+	mkdir client &&
+	git -C client init &&
+	git -C client config remote.unused_lop.promisor true &&
+	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
+	git -C client config remote.unused_lop.url "file://$(pwd)/unused_lop" &&
+	git -C client config remote.lop.promisor true &&
+	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
+	git -C client config remote.lop.url "file://$(pwd)/lop" &&
+	git -C client config remote.server.url "file://$(pwd)/server" &&
+	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
+	git -C client config promisor.acceptfromserver All &&
+
+	# Check that "unused_lop" appears before "lop" in the config
+	printf "remote.%s.promisor true\n" "unused_lop" "lop" >expect &&
+	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
+	test_cmp expect actual &&
+
+	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
+
+	# Check that "lop" was tried
+	test_grep " fetch lop " trace &&
+	# Check that "unused_lop" was not contacted
+	# This means "lop", the accepted promisor, was tried first
+	test_grep ! " fetch unused_lop " trace &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.54.0.rc0.114.g05d466edb8

