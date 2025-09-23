Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54B27815B
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622635; cv=none; b=q+9C9ostGU+9ZyNw3YtXYKI4bWOOytwKmENq3egf1Je6a8Asyhi37CSHlPXLXSJb9j6IO6In2qfy5zrT0Y0GwZisUfik1J/CvBty4p5cztsZATVb9+e4DYLWKx0WLQN+CkJomZVJI+BptiHRZgSWMbMuh17hYaLGDxCycUmmLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622635; c=relaxed/simple;
	bh=peo9aUgNWe0aUeFBPFlYMRTKgX5VQZYW6XTo7LVcrn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHDKWwPLQQd2HB+ipJWjIYr8hcGmAU+TOXxrnDM6hcnt4HGZCoTRJ2ZwPOwIqdo4J6D52/EQHVsIESMXgdjAkH8PSM6XtXikglNSN55pezYov9fzkGwEPMXqZvs12DAhaEYdtCyIa1GiJFZ3oXk8LvOVx7/A1RcqoMuYRmQ20Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XtikaQrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OTzv/j+2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XtikaQrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OTzv/j+2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 31D541D002D5;
	Tue, 23 Sep 2025 06:17:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 23 Sep 2025 06:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622632;
	 x=1758709032; bh=RtzpVEii54hek+TXakdGSefeg0m+FwrOhNTqzQGDaB0=; b=
	XtikaQrrongANCZuzUgtA0SLsmIPE2nMIJ8uiIv64Mzhh5ds9Q425cJ94mGNSfLK
	pmJDQs3A8+puyvbdE2w2SQEsbLMtCirSYy5iu+Fz8/kcBr/9yUHQ0a00QsKEdpe0
	ssQX0A7FRwIfWx8H15CeAShIVr5IMljB1bEU5XtmMPQEnyyrrBie7tCZ3wFnvC0W
	nhxuRxbe2TtRLleWw+PpiWZtmFTSBCeOOREfDEwumPUgbUF4RZ5txrTA3ZzxzWe1
	f9CUt9Bp6S53gNXHTnvrLvkDKk3teGmqnKUfJwaSP8z0tCMGXNEwPoY4xWJvAm2K
	Oh8GeEnqLN9enHrc3s2nqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622632; x=
	1758709032; bh=RtzpVEii54hek+TXakdGSefeg0m+FwrOhNTqzQGDaB0=; b=O
	Tzv/j+2TEknL2YQF3ij8h+Qp1QN+18kWLQ1BhxDRorZFPS0jHkLEpC7jrW7Un7N6
	ubaY0vnthBpVIDzy/8JOxrUJIHNVODN3pB5xvAPOrD3z2g/MQOG8Y1C3+TolLPvG
	+MiHIwnFeM6mlNY/KxGHEjWQW5mv1nn3Gy/dPOkVIn8DmokJSbYmDYFfIO9W/cqY
	ot95sienWjNtZ3ApV58deEoFKK5dLfSh9osktnst9V0HI7lxdrVfU2Zx/S9sT4OH
	cqw2QiwuJHlemRUxZf0enX3SLTK0gYtwyYvvHrcJk5TW4wi5Cuwas/kuHJeNacb5
	BOB0+14JrUcHbw7xewpmQ==
X-ME-Sender: <xms:p3PSaBpWCy2SQBHBJ_kjtRZZn9K65d7W62EeORDzi1Qj7Ll0-P3C0g>
    <xme:p3PSaMFf6pHRcntJHaVH7Ra8yRe3AtDfK1kkx9sYyoio_sNvTxrisbhKSIb-610jD
    mWpp-juZK0aVQuhB9-gRWKGjh2WSENwcMbo8HrsZNab6MpYD_Zf>
X-ME-Received: <xmr:p3PSaOqaqzph043eXfvhpaiS3r85SWT4KQjngZgReiSEpqr7lI31ONDi8YDRAxD3lKCxf-0pb5RAqafnvP0BfpBYL3GYs6W5ADuQ-jOG0RJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:p3PSaNYAbUp-p_5AEnIH8kDAkVdDHZCqSc2CcupIakEwUi4ihHcjGw>
    <xmx:p3PSaPW9oYeIb-QpSWBNM4iN_90TyvD42Y24911_N2TPdSy9DprRYw>
    <xmx:p3PSaO91bLLSITBiPj05dka8Iny5KbiGgVWk-YBZeWbuaDqw1jcESg>
    <xmx:p3PSaA_1RGPQBYDyxGgrtfoo3n-4E5y-YbP2PPBm2_2vMoica8Ssmw>
    <xmx:qHPSaOChixRHeFqvqhx2QgS3LbDFmzSzN6999m760YYhF-Eo9RD7MUEm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 444446ed (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:00 +0200
Subject: [PATCH v6 01/15] packfile: introduce a new `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-1-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Information about an object database's packfiles is currently
distributed across two different structures:

  - `struct packed_git` contains the `next` pointer as well as the
    `mru_head`, both of which serve to store the list of packfiles.

  - `struct object_database` contains several fields that relate to the
    packfiles.

So we don't really have a central data structure that tracks our
packfiles, and consequently responsibilities aren't always clear cut.
A consequence for the upcoming pluggable object databases is that this
makes it very hard to move management of packfiles from the object
database level down into the object database source.

Introduce a new `struct packfile_store` which is about to become the
single source of truth for managing packfiles. Right now this data
structure doesn't yet contain anything, but in subsequent patches we
will move all data structures that relate to packfiles and that are
currently contained in `struct object_database` into this new home.

Note that this is only a first step: most importantly, we won't (yet)
move the `struct packed_git::next` pointer around. This will happen in a
subsequent patch series though so that `struct packed_git` will really
only host information about the specific packfile it represents.

Further note that the new structure still sits at the wrong level at the
end of this patch series: as mentioned, it should eventually sit at the
level of the object database source, not at the object database level.
But introducing the packfile store now already makes it way easier to
eventually push down the now-selfcontained data structure by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c      |  1 +
 odb.h      |  3 ++-
 packfile.c | 13 +++++++++++++
 packfile.h | 18 ++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 75c443fe66..a2289ea97d 100644
--- a/odb.c
+++ b/odb.c
@@ -996,6 +996,7 @@ struct object_database *odb_new(struct repository *repo)
 
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
+	o->packfiles = packfile_store_new(o);
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
diff --git a/odb.h b/odb.h
index 51fe8a5a92..33034eaf2f 100644
--- a/odb.h
+++ b/odb.h
@@ -91,6 +91,7 @@ struct odb_source {
 };
 
 struct packed_git;
+struct packfile_store;
 struct cached_object_entry;
 
 /*
@@ -136,7 +137,7 @@ struct object_database {
 	 *
 	 * should only be accessed directly by packfile.c
 	 */
-
+	struct packfile_store *packfiles;
 	struct packed_git *packed_git;
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
diff --git a/packfile.c b/packfile.c
index acb680966d..130d3e2507 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2332,3 +2332,16 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	*len = hdr - out;
 	return 0;
 }
+
+struct packfile_store *packfile_store_new(struct object_database *odb)
+{
+	struct packfile_store *store;
+	CALLOC_ARRAY(store, 1);
+	store->odb = odb;
+	return store;
+}
+
+void packfile_store_free(struct packfile_store *store)
+{
+	free(store);
+}
diff --git a/packfile.h b/packfile.h
index f16753f2a9..8d31fd619a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -52,6 +52,24 @@ struct packed_git {
 	char pack_name[FLEX_ARRAY]; /* more */
 };
 
+/*
+ * A store that manages packfiles for a given object database.
+ */
+struct packfile_store {
+	struct object_database *odb;
+};
+
+/*
+ * Allocate and initialize a new empty packfile store for the given object
+ * database.
+ */
+struct packfile_store *packfile_store_new(struct object_database *odb);
+
+/*
+ * Free the packfile store and all its associated state.
+ */
+void packfile_store_free(struct packfile_store *store);
+
 static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
 				     const struct hashmap_entry *entry,
 				     const struct hashmap_entry *entry2,

-- 
2.51.0.536.g15c5d4f767.dirty

