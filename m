Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9268D32D431
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421090; cv=none; b=LOuEFIO20QfWeG0BKbBIfjff4uMMLWx1Uc3EwhCHZLVj4nWfoWN7l1VxjdV44cqkoylbZlwk3vBvFNn1zH/5MzXzpcmYBrWkqKh/volNBzP2GXo15cWK2QfnhBWlB0qw2CK1fEhzXtREFbhyaLEDFKFDApBj4jod4F3/1eU015s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421090; c=relaxed/simple;
	bh=ZSFCWlAqV1cIDGyqM+Fm9o+f+IITj3pjdcoYerPYw68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpsPkCdQP5rkHgu+BBFQ6S8qCb/poOYM2R8BuNpEICZI0RZnSWB0p1K0Vc/+SXpekvGDVNC/kszIW1c3Aj+YfCZLIBnCe/lgCpUtEeQctufct79v6NJT5ZdkpX9/eWacTZ391byibGVTBuXAfLOA+QteBvvaoHy1EOpd39ZOGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FBczzGig; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3DM+aRy; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FBczzGig";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3DM+aRy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AE1141D00090;
	Mon, 26 Jan 2026 04:51:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 04:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421088;
	 x=1769507488; bh=QgnJ7WZBPjirhVKmmZwleXQhRFdc+5wrE+XegK0UF3o=; b=
	FBczzGighfKFrq9ZWhpwe0RxDACOVzkoUpiHLxeWxzP0Omy8V3dI1ayNOa9NV6di
	XginuOq+J6ll4Dks5EGIvtD2FB/SDFq+W6NmcySWba1evwDbXcLcVOfNtm5MmSYn
	MlSfTm8/7MiNZvT0w4uKp/5tu3+MYNDJgugx1K0DkiDEK8vId2elLY183QjSGzVw
	1q+ce3Nl9lIy9NUrtneMNhNg5f6K2A1w6I6WHHoWY6VoNdYEGEjwpawg7xay31iX
	J4+pptM3/24wI7xEhYclUsUp8fHNyAGIdJfLalI8Zxfoi+fwv2HgL+gg0g0GN6rd
	nq5inCoq+kmY2n0MOao+zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421088; x=
	1769507488; bh=QgnJ7WZBPjirhVKmmZwleXQhRFdc+5wrE+XegK0UF3o=; b=q
	3DM+aRyFPA7RdohBT8h8rcHIce8AyncHBmBiRIPgsG2jOi9pvMD7bODTFsOhC/rQ
	ZpDqQN01N8aY9L3y/i5c9jMHfFbB11iAFmmTZcvLKc5CqOEf3ALHXyvD/VGKM/hD
	CBMyG7g95lmhvYi0XJj9JvKzRwLVFZB4syOoP5ZuaXcEEHoyXRBWOjBrFo6MmiCX
	/1aOCEuzJMf4wuiv7Z6j7e5KkEbjdQUxm6b9/lSQ25GRLK3nhGrfSIh2t66UYZYr
	wyB7yzxONCy4IrjGGbO653YhoBNlMW+1c1nTUeVO1RWvb0BkPlRFicaLhWI2tz4N
	jvQ5S6BVDjih/aQ8OYaew==
X-ME-Sender: <xms:IDl3aVGr0ehP9vGRTeuuQQZo7KpwXhPWvMAntEr0lhOY-H9fYNGCIg>
    <xme:IDl3aRV4CxGgTNUZr7Ps8GlY4U9F09MsRndviHYlYoiNXXlzTj_IXHt9gCQpqFdRC
    fghuPJ85gE3h24ar98UI_qT9ZM538NvQzQHz_Otksvh0s0o6SgyFWo>
X-ME-Received: <xmr:IDl3acIMC-eUGW2AMICL6hIVnpUVdCjJzYqvnOhM3pWuzCy21hhuGcTtWnlLPeijb0vghQcGd5JsoamVEqY02_BINLOuJ_a6q4ErdPZwaRkcPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IDl3aZ_IIiUKnMnw6DTN96e6lcRId8StsRR9K1xGCHLSf1PCXVWrLw>
    <xmx:IDl3aXJ745FSpBGuQvO-4yjUOR4uIsQMff3MnfBAFekVILPt4gdzzw>
    <xmx:IDl3aWlJcnb_WwFTTeTrBEW__je8dZn7_F2bFLrKwxBPrdNDCdUtmQ>
    <xmx:IDl3aTOrVF-D8KirO2TW_uECB0T4FR3jcrdkYNi1RtlZi2Ec4BOFHQ>
    <xmx:IDl3aXr5Mg9J1PDmzSrQteKwzSb7DmgZlL6ev1iTb53iHfZD6tA6Jfgo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1de489d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:18 +0100
Subject: [PATCH v4 02/14] odb: fix flags parameter to be unsigned
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-2-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The `flags` parameter accepted by various `for_each_object()` functions
is a bitfield of multiple flags. Such parameters are typically unsigned
in the Git codebase, but we use `enum odb_for_each_object_flags` in
some places.

Adapt these function signatures to use the correct type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 3 ++-
 object-file.h | 3 ++-
 packfile.c    | 4 ++--
 packfile.h    | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 64e9e239dc..8fa461dd59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -414,7 +414,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags)
+				      struct object_info *oi,
+				      unsigned flags)
 {
 	int ret;
 	int fd;
diff --git a/object-file.h b/object-file.h
index 42bb50e10c..2acf19fb91 100644
--- a/object-file.h
+++ b/object-file.h
@@ -47,7 +47,8 @@ void odb_source_loose_reprepare(struct odb_source *source);
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags);
+				      struct object_info *oi,
+				      unsigned flags);
 
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
diff --git a/packfile.c b/packfile.c
index b65f0b43f1..79fe64a25b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2259,7 +2259,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
-			    enum odb_for_each_object_flags flags)
+			    unsigned flags)
 {
 	uint32_t i;
 	int r = 0;
@@ -2302,7 +2302,7 @@ int for_each_object_in_pack(struct packed_git *p,
 }
 
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags)
+			   void *data, unsigned flags)
 {
 	struct odb_source *source;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 15551258bd..447c44c4a7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -339,9 +339,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
-			    enum odb_for_each_object_flags flags);
+			    unsigned flags);
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags);
+			   void *data, unsigned flags);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

