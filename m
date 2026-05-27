Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F72F3C26
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911748; cv=none; b=CUtyGlNLPpcVz3Pg+2Q4u3LBWovB8DvyhzLp+vqnvxgnlM7AbacU+FSez18iGO44Ulh15Cop3Zvatd+61+bgG9QnHBIc7QdMHpVyBo54qywHny+79XSFnESr/6vA/VnJvDfEaczxHgIaBaN1kLXMPetHSEtNeWX8IfNXTPkKKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911748; c=relaxed/simple;
	bh=mBDvmQyc+pTB8Kn6jboxMvSYQkPDIOmEDJ+efbBMSSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+ceN0bT+Bih6/3wktQ6uogAWmhig4lQ/d6qR9NVoeydQT8HEclZil0EkrK9qD/y9h2lt+yR9QyHY4fyoXt9hfVTiHc08L2TgL5uSrgDJ/4SEf6BjjxfPvVunTnuZ/kb0cRosEZqZd6UfPXqvwB+xrZDjKc6vTyjhdDaEm6cf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QIHX1gfe; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QIHX1gfe"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bde9d73678so124446637b3.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911745; x=1780516545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=okuVAltqMllBvy5xCl+4qoclgq+WWn4pG5LpASLPiug=;
        b=QIHX1gfeHHOtEFy716pXKiWLJ+amrxyS/pV7Bxpo0gP4ur5T2JYop32wjLxTAKozWO
         tPNdMdZqvwqTZfnbXW+qPRkpiTWQuG+LjPTar5JOg/xpK+CWRD2gFIA6RFjYlWTBnwsb
         9mNusIJUH0o7hY3H5Ef7PtRzrGJNNK0hFWN00+s0TONciSqV+c8u/67HEnH4NNE/uZXW
         bqGZucv7FBE9ygtX1KWL6cXZ+Mkur5HYX6GQviUci1c5TPyhYvXowzIRn8Aq2GtxwEzA
         P25C1fC/ERvavGxd8wNqUe074uIxpXZxIPVPCQsSl781ByxtrqmrGEx+Hncz0kc9ZI7k
         o+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911745; x=1780516545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okuVAltqMllBvy5xCl+4qoclgq+WWn4pG5LpASLPiug=;
        b=hSQI7PRQYOrBf6E+TiyCjVu32IFAxN7NPHGimkS+hHCy4fl8a5HPIRmC3RAr+wqZNL
         Ui6fPUPclZt8zBOFrXLGuGzBSOZG/x/mxoEbr97344gYIClN3iYhYKHQYCIu+U8Z4g/3
         Ek4alTA4Vtb+uFDNc6yLnxCIom2pjo6owY48/+cwxqnLvStjE3qBOEdR6ZqpS0aatkdJ
         D7jy6bKCFDqoQaVAIyx1n92V8XkcWBJXU9zqHe7Qk56DAyYN2DRdQGSNRx0JDDfoUtbC
         gVMQP32wC902I7//CqVzQoqbuj7FQ1kvj07hnIFsOPjBMcL3ML8RzSXKUQLVkpAI5Tp4
         0XXQ==
X-Gm-Message-State: AOJu0YxU8MKv23FS8433teFLh4ojpS8HHIQNwEeH2m1HmpNwQxRTaZve
	H+QUC754Y2gPhqeYRHz0gAcp80Lce99usT5Qg7Q1pYt1pHqF7vp81vjYWf9t1pW7ktnDUtY1T1Y
	V4NHejHY=
X-Gm-Gg: Acq92OHNJ7R/a9W2Vc7Gfw0B7Lyxxqg7se7EiL/25Rt+3aoYZBO3KxF89TggVjh2t2D
	A6SCC7rwoglBY7LHOwEJM6GnJtBe1DisodA6645kMIGfFtfnvpjOI58hDCqI5QPwIDrx6JGwZao
	CWmBkxtSTSqYUGoXCn2vLG+onAHvGYEqPBTrtHp4KTbtidzyDSUXHm4OFUnIODY9rdLBczQAyBX
	abxuP9IpCfZMKvyR3WOZ+JGwAj94vGaWEVhDaGJwieu2DYfligQeqHmOQwnmd/gF/PLu5sDdyW6
	daFG5Y1/JkBWgfa9AciU/qNG1gfdCtBxxp91jKmrLgR+SSHAQ/7KdGEgO6Y9p2oNvIfIyItaKGk
	0JYjc+UVsZHxMi1j4NII6qsgBBg6hA+cGF0KwunJO6uuFQyMW7ghbFwGxabochyrsQ7mIlsbd/O
	C3dzrRGp+46aYb4HzBoNlG4pTJXQM57gc22GUoyNp1KWZ3qfftrfp2Z0zbWz5Sld5hdMPoGVXCt
	DWEwAFl3Cj2hIqIC4n3lPDVjsIMHTqZF2ktN/q6CbI3dwOgPaPrx4K8CRi64mvjpQI12yMHkeA4
	IXKX4XHWvdmoXYBtYpn3UeaOL1o=
X-Received: by 2002:a05:690c:46c1:b0:79a:b49a:cb4e with SMTP id 00721157ae682-7d355e31731mr201334867b3.6.1779911745597;
        Wed, 27 May 2026 12:55:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c8basm80774697b3.37.2026.05.27.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:55:45 -0700 (PDT)
Date: Wed, 27 May 2026 15:55:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 0/8] pack-bitmap-write: speed up bitmap generation
Message-ID: <cover.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

Here is a reroll of my series to improve the performance of reachability
bitmap generation, focusing on very large repositories and the penalty
to generate pseudo-merge reachability bitmaps.

The series is largely unchanged since last time. Notable changes in this
round include:

 - minor refactoring in the pair of patches which consolidate the
   `find_object_pos()` success path and introduce the object position
   cache during bitmap fills, and

 - dropping a stale paragraph from the final patch's message, which
   described follow-up commits that are no longer part of this series.

As usual, a range-diff against v1 is included below for convenience.

Thanks in advance for your review!

Taylor Blau (8):
  pack-bitmap: pass object position to `fill_bitmap_tree()`
  pack-bitmap: check subtree bits before recursing
  pack-bitmap: reuse stored selected bitmaps
  pack-bitmap: consolidate `find_object_pos()` success path
  pack-bitmap: cache object positions during fill
  pack-bitmap: sort bitmaps before XORing
  pack-bitmap: remember pseudo-merge parents
  pack-bitmap: build pseudo-merge bitmaps after regular bitmaps

 pack-bitmap-write.c | 431 +++++++++++++++++++++++++++++++++++++-------
 pack-bitmap.h       |   7 +
 2 files changed, 377 insertions(+), 61 deletions(-)

Range-diff against v1:
1:  13191c19b91 = 1:  ad025810ab3 pack-bitmap: pass object position to `fill_bitmap_tree()`
2:  7d6d1cec0dd = 2:  59da63d0330 pack-bitmap: check subtree bits before recursing
3:  6e1f6bef5f6 = 3:  f13d65c0ad9 pack-bitmap: reuse stored selected bitmaps
4:  c9a56066094 ! 4:  856aa3a6ab7 pack-bitmap: consolidate `find_object_pos()` success path
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-bitmap-write.c ##
    +@@ pack-bitmap-write.c: static uint32_t find_object_pos(struct bitmap_writer *writer,
    + 				const struct object_id *oid, int *found)
    + {
    + 	struct object_entry *entry;
    ++	uint32_t pos;
    + 
    + 	entry = packlist_find(writer->to_pack, oid);
    + 	if (entry) {
     @@ pack-bitmap-write.c: static uint32_t find_object_pos(struct bitmap_writer *writer,
      		if (writer->midx)
      			base_objects = writer->midx->num_objects +
5:  e43ef6a42d1 ! 5:  70dfa80d543 pack-bitmap: cache object positions during fill
    @@ pack-bitmap-write.c: void bitmap_writer_push_commit(struct bitmap_writer *writer
      				const struct object_id *oid, int *found)
      {
      	struct object_entry *entry;
    -+	uint32_t pos;
    -+
    + 	uint32_t pos;
    + 
     +	bitmap_writer_init_pos_cache(writer);
     +
     +	if (find_cached_object_pos(writer, oid, &pos)) {
    @@ pack-bitmap-write.c: void bitmap_writer_push_commit(struct bitmap_writer *writer
     +			*found = 1;
     +		return pos;
     +	}
    - 
    ++
      	entry = packlist_find(writer->to_pack, oid);
      	if (entry) {
      		uint32_t base_objects = 0;
6:  b0a4f31353a = 6:  b1184792d23 pack-bitmap: sort bitmaps before XORing
7:  0bd88e6a096 = 7:  673b6262911 pack-bitmap: remember pseudo-merge parents
8:  30ce254312c ! 8:  8722242f1bb pack-bitmap: build pseudo-merge bitmaps after regular bitmaps
    @@ Commit message
         portion of history reachable by one or more pseudo-merge(s), but not by
         any non-pseudo-merge commit selected for bitmapping.
     
    -    Now that we have decoupled how we generate pseudo-merges from their
    -    representation, the following commits will improve the API around
    -    specifying pseudo-merge groupings during bitmap generation.
    -
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-bitmap-write.c ##

base-commit: c3d7ca7d982efc3a848fd85f34e867cfc0a99479
-- 
2.54.0.rc1.84.g1cf18622df7
