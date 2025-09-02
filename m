Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03B283680
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810131; cv=none; b=kUi2CkVCZqeanfp30Bwtp3fJNy5mXTNIpDEja+yCkfIfce3VjIYkP29iiqaQIIYKfT5/zcGNdIikslM4/7Qp3CEgRVmgKQ9V3WfHZEOEBU9YAW5V3Gj3Xhp16aPeY7KQw5fW/oqqKevM3cckyUZUHXrakvXxr7RP9HQztqiixK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810131; c=relaxed/simple;
	bh=uNV4j04NNNWTV+NE7biOeygbNh9NKaWVP808bLTKLjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOT0JsngwvJ1yE3AY17cs9Up/hwPRQSl62j4jG5RWWYjICf002iWipv1nmMRl+m/mQbLOBlDTqn6YT+t8F8gwIImoVyJY6Z/9emuRfnvbyyup70PFB0k/EnziEwlU8mor3gRwgnu9QcQ9cTyMaVhsZRRVXZ3LGsr9ZbPfH2/xCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XK7z5Ztq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcfOqvO7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XK7z5Ztq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcfOqvO7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EB6114000EB;
	Tue,  2 Sep 2025 06:48:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 06:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810127;
	 x=1756896527; bh=MEScM1ASgp53xX1zwfbFQsl65s5Uu5DACa3h4WN7Apk=; b=
	XK7z5ZtqvfXodRP7pxZAs/IkHsQs792oNmCXBzdCXXbBvYu1Ry9hXbdhNyq7ZI6J
	AndS8KHTvHAsqYMgWWYrfg644HMlSJw2dl3yrybvGX2ltFk4kh/b93bXksAI6ynu
	NG96eMh7zkUNE3IAm8cSNDwji1ibQATX1uKZcy8y6R0c5QRsvr5a8yu0WWKhasDX
	O7P8m1HlXKedDW0pXNvI9fFx6D5iMG+GEv6ce3ycXoPflC/9woUQ0TGOiRknIDex
	AMkVv6cCmGCYApqErR/+7n8I8f+8aYwEmL0VfVvUpZyhN0QvA/2eHdWbHrS5cmx4
	El7g8y4M+4x4ENZebIi3uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810127; x=
	1756896527; bh=MEScM1ASgp53xX1zwfbFQsl65s5Uu5DACa3h4WN7Apk=; b=l
	cfOqvO7gmCnUeznRuJiynU8vu3S8YM99g51w9Up0g8RmuGF2zXQxzjteUGiNttmf
	VP/7ZXnxmka4G1IY8zsaPbIzas1G1+GEg+LybUEcYkJGrfghIGQD0v62DdkX0vAT
	b2KQsnj+mZdtswQf5p4RXDTUoXB9nkhCqf+rs4lGEJqajZbphQW4uwXpALlzuyWT
	IYlSHxo1iDoMn+itzpafTO0xso+xXxoNbRRt1qMSL1etkG8/LK55sD/Zr9nLksBb
	Hzie2MeDed6kG+27+Dkr9S6lVMf/j+HUqMK5VnOtKPDIw1ZT4Ijd7aMdA5hUcIWM
	FHn6KNS9JHnP2lHEqVAvg==
X-ME-Sender: <xms:j8u2aFeU77C-A12-6TiY7AXttB33jvUei19l3d5Rd9LMKJa93NXFyw>
    <xme:j8u2aOvljmoPpV_ipPOYZGuGRFsCbvbiDL15C4K8-DE4gTytML0smDJB5U1eYaqZV
    awORGSHUVCehkCZ-Q>
X-ME-Received: <xmr:j8u2aE8xrgU2FRpPR4O4Q1UgTllkb6yYWuu3pjeNWv0SKZnf8pj8jrVPGbFG7kfqyk-VvKwORvN-8JtN2Z8xGsBCZRXZ_LgM-_cFreZK4SczkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:j8u2aJ21YRde2TCoybml4qnmmqmF55REjBbhttg3arDHBEUChigfag>
    <xmx:j8u2aJC7fVR0ifc47H8qAacsPQe1A5hou1F3kxIsoTnNRap_ngefuQ>
    <xmx:j8u2aFeEBQ8dD82kQ2YMiuVEKurjxu7djmKqjf-EdaTDT0arGopMMQ>
    <xmx:j8u2aG7E5MOiUUAJnclPfy_WxHLVUf5fh8FuhyUtjt9LeklqXu19sw>
    <xmx:j8u2aNBBw4Kmi4mxzTjJYz2F0cqpvrbjQv90ECIrghLtUFXExKPplSZV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:48:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10cd480a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:48:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:26 +0200
Subject: [PATCH v3 01/15] packfile: introduce a new `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-1-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Information about a object database's packfiles is currently distributed
across two different structures:

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
2.51.0.384.g4c02a37b29.dirty

