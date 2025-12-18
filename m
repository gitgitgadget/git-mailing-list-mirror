Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1362264AA
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039307; cv=none; b=Afp7QwiTLP9V+rR4B5j4kQfC286oGQTHZLQk54+CHTAGzLrPkM0UFshTJ4U/fNT1takugHFQn0hfsnLbTQ/BOTcTsSYSQqX70E2q0AeCMeVm8QNJDG6H37ylh7A/ZYA8IqV3ueFeCvk1AS6ddnyDHU7LObXX5zr636FMC5DGhoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039307; c=relaxed/simple;
	bh=132u8uAoJEVOni2Svzagv2Aa8GO42b3kw1GHpNIISnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NSZ8DG1lkknT0JU70jWvvbuScPXNqvc8oUP9uuWffe67l4OwxlA08P4tlvtjg8tGDpCENxqb3+272jQLJXpfYKCLiPOOM8HW3daHIdza5qiFikG/Rpg5DhWERQtxhAXnTQsCbFMLbuJrMbUWuHADK+sq40Nk2/2FGbvOFzJOfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o80sfCKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bdoPi4vH; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o80sfCKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bdoPi4vH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86C8B7A0177;
	Thu, 18 Dec 2025 01:28:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 18 Dec 2025 01:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1766039303; x=1766125703; bh=crZjYHehSB
	HtgIyduMUFt1NZS88wr1oUB8cQmejSqPg=; b=o80sfCKKI7GC6IW3sd+xhncsMW
	45fTZqIgR6KIPXBIWzuDr2mPVgD0Mr/z3+RuwIqqkMb1C6UwdczcIs3+PWQWmxBF
	urVtI0U0qANFT+rIGCzl8ffBQIZHiHGpsw5zRSTdNkPUpwR4gOnraK9sBmuVZdwy
	2NbT35SySV1c8PHBzw/fZZQP7A6oFeuvywDD8o5lvqpXRR95gYw9wKvEXbvh03ub
	ALK9q9EN/66nGfqL8x9HkURIhY7guFjYb1RjLctyiJeTUym982Y3KxHTralg2iW/
	FY+Wbw8Rupef1/T/piayfcRtXzLlFzzxUnATDesrQor99BMeTAh2p8yhwx/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1766039303; x=1766125703; bh=crZjYHehSBHtgIyduMUFt1NZS88w
	r1oUB8cQmejSqPg=; b=bdoPi4vHJKsLjBbf6Os3SCgtnjw5IFVTjZ/f6alD5KIn
	0bJO9My9kfD7G6s+qzbySJTACiH4V2TRrzWg4068XttfbxN+BidbYvThN/YlXELX
	xcsIEHa5GrsX5TNdofhTpD8MvHBd4iW734kqxjD20/3pRJ27z/mBYmZrLF2xDD9C
	59OV7ruotffyl2AqBbOmReqmp/9+LMBBCn2EL870ljtxsCeBUdWJugp8FlbF5oeQ
	ASkKLmo4lWLOuEioFXVokckG4drMC7sGGGQJ/1TbjHxL1jJqZvf5VZLr1ATdhprD
	p93SJfzs3NFacbTYTAHIWDKxc1b2hawGLWnOImneRQ==
X-ME-Sender: <xms:B59DacN3Luo9D757hrYFAnCMQIgqr0NsXtaxZSHWVGXupjD7WGXllA>
    <xme:B59DaaYn-KiGKJxEQrDD8BsE8otr4I5O6gc5iNecpH93DxW8LIw7RI9W_UukM_5-V
    cOuL5U-jz9Ky979xmrJ1LjxY5TD20xw80Ku9ZVDQNPynRDZR0oS0w>
X-ME-Received: <xmr:B59DaQoOzpoIz3mDbi0heASHukcEjpWeRTpXOSTegDFQigemYrJiThF_yRKJucw_6gpvW-IacE7Ztlwde-eimNglzYnT0vIgNI9oYfIcNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptd
    fgueevveetjedvgfelheeivdffhfdtjeetteejudehfeehueffjeejtddvhedunecuffho
    mhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B59DaeZ5W5B5QqRM_lROQfNxqUmp2lYlxRHe1P9Uco4yAL81DlXLFQ>
    <xmx:B59DaYQG4eTbDSzLBR4pw_ZzEqIgnu6HBHEh4Xoi-1FhUj-7v4QNgg>
    <xmx:B59DaV7f6yMuBiCa0ryfmVFIJ__p404vEeAGH1W59T4OYUbYuyutyA>
    <xmx:B59DadyYlxKNYQCkhlGaNZPDwtmowtu0ttQrFaYVbHZluOsFFnrK9A>
    <xmx:B59DaaB6RQ-O4mWB9c3RcwlYv1C1eI-1dQg3CaSS3Yg0pmPlD-EB8nlm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 904da0ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] Improvements for reading object info
Date: Thu, 18 Dec 2025 07:28:10 +0100
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqeQ2kC/x3NQQrCMBBG4auUWTuQjC2KVxEXTfNHR2kSklIKp
 Xc3dPlt3tupoigqPbqdClatmmKDvXQ0fcb4BqtvJjEyWLEDu57zr3LyjgtGz8l9MS2sMSTWOZe
 0YkZcKhuYq0W4y80LtVwuCLqdq+frOP7wo/0AegAAAA==
X-Change-ID: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

Hi,

this patch series contains various small improvements for reading object
info for either loose or packed objects. These improvements were split
out of a larger patch series where I'm about to introduce a new generic
`odb_for_each_object()` function.

This series has a conflict with ps/packfile-store-in-odb-source. I
decided to not make this a dependency though because those two topics
are independent from one another, and I expect that this series here
will be merged down faster than the conflicting one. Furthermore, the
conflict itself is quite minor:

diff --cc packfile.c
index 8daa5a5ee7,ce6716fbea..0000000000
--- a/packfile.c
+++ b/packfile.c
@@@ -2157,10 -2132,11 +2151,10 @@@ int packfile_store_read_object_info(str
  				    struct object_info *oi,
  				    unsigned flags UNUSED)
  {
 -	static struct object_info blank_oi = OBJECT_INFO_INIT;
  	struct pack_entry e;
 -	int rtype;
 +	int ret;
  
- 	if (!find_pack_entry(store->odb->repo, oid, &e))
+ 	if (!find_pack_entry(store, oid, &e))
  		return 1;
  
  	/*
@@@ -2549,9 -2555,8 +2571,9 @@@ int packfile_store_read_object_stream(s
  	oi.sizep = &size;
  
  	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
 -	    oi.u.packed.is_delta ||
 +	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
 +	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
- 	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
+ 	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
  		return -1;
  
  	in_pack_type = unpack_object_header(oi.u.packed.pack,

I'd thus propose to merge this series via an evil merge, but if this
proves to be burdensome I'm happy to defer it to a later point. Just let
me know and I'll adapt accordingly, thanks!

This also fixes the issue reported in <f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com>.

Patrick

---
Patrick Steinhardt (8):
      object-file: always set OI_LOOSE when reading object info
      packfile: always declare object info to be OI_PACKED
      packfile: extend `is_delta` field to allow for "unknown" state
      packfile: always populate pack-specific info when reading object info
      packfile: disentangle return value of `packed_object_info()`
      packfile: skip unpacking object header for disk size requests
      packfile: fix short-circuiting of empty requests
      packfile: drop repository parameter from `packed_object_info()`

 builtin/cat-file.c     |  3 +--
 builtin/pack-objects.c |  4 +--
 commit-graph.c         |  2 +-
 object-file.c          | 13 ++++++++--
 odb.h                  | 18 +++++++++++--
 pack-bitmap.c          |  3 +--
 packfile.c             | 69 +++++++++++++++++++++++++++++++-------------------
 packfile.h             |  7 +++--
 8 files changed, 80 insertions(+), 39 deletions(-)


---
base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
change-id: 20251215-b4-pks-odb-read-object-info-improvements-0e031ef827d2

