Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B291494C2
	for <git@vger.kernel.org>; Wed, 28 May 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435063; cv=none; b=b8H8E7+fcpKDbXRZVJKsECWpA3oAQ+EgEi+zXE/zXbg4BDdwJgfgIT/rDYSOXcS32wFfDwRaWmzsYkdiWBTbcb2KRZt9rKa4AeIT86jUzOF2s8YrryM9y/+R0Q/JzVFwnuP/+eu9nsSg5x2pMmKZuUzP/YdV94EkpAsxOo2yuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435063; c=relaxed/simple;
	bh=7xhXa/20lMhNN5lKzVe4Hcf8UcVTpxkBWk0ShDMEtqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBLJTAELyM02IH5r+u+/PDJeNFSBoJcZa2RFbuk8pOkEYTKDy88PXBqR2+Yg1zAOi2lJ8g1s9Qy7vp8I7hN9cixAGd83TIjS+nFxYFSnTWd3tz317qjYoplAIHXfuXtOz+XwOkjDyXgz0Js52K+ky181nKOmCTeJJyCuz8QVuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UlOvGPXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6tVL+66; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UlOvGPXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6tVL+66"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06CDE114015E;
	Wed, 28 May 2025 08:24:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 08:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748435061;
	 x=1748521461; bh=59onG6ctkcTMPp2oQIUuu8kF8iEW1FoL2X2g3UKkvS8=; b=
	UlOvGPXOed+tkWJlTVHWIL1AW1YPM3kC9rS0gEqdtFk28FAYyVi+EJTGv19k1zsu
	UTgVujKQ2WuW0JUjb+y8TSli2dvS1WNNtn40TV2PPf9fmrycbppVlu9jGlci1Ivk
	Ed30Z0LJl1YgeqzSvT96cWqvNhr3v8wOxxQSRpEm4+5acdJAnsNp8GBZs8/Dm2qY
	K/WVcSowyQ1Evc/2z97OM4/UWj/YjjWJPWRd5F+09e9Ln6yTY9B7xTlvU9X+J5dj
	Er1+9yhFQWDHtdgK81V4hKUB1uaOkVoxlj+yVngshKflV7bobhbByluVMRpjmhy4
	xhLXU1DzblFMi3r4c2YFoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748435061; x=
	1748521461; bh=59onG6ctkcTMPp2oQIUuu8kF8iEW1FoL2X2g3UKkvS8=; b=Q
	6tVL+66E2KVg7mUd2j2d/+mxKuHI7lkOdgXylCQqIfghqoM4p+254+32fpP9pQt9
	kWRAEhRuPq87Nawzln8q3cJA8s8gnmAxaWHNe9VyivhLN+X2V7rmaFERz2NB469V
	qSiMEBFzXSQvLGCNecd/YB34wCzX9iXNksAvug2AXAoPCEC75eB7K/D3+Jb4g5i1
	fEXm+2fwilRHJ4mFiANSIgJNOsTjTD1/aSTeFpsH2S1JgupB8tCkBfdMPitaeMz0
	NgzFYQFAKCvNt1SIdga6uJ8t6NVWrcvJfCRwpOdbwKbPkXdhTxiz2eeggpZ0hOpA
	GWHWT6HywNu5heAOnaLHg==
X-ME-Sender: <xms:dAA3aP803Dwvg2ua1MUcQBX69jSLj-Egavq_5aBOvLc5yyLPiV2zQw>
    <xme:dAA3aLvGaQZASaeqw4hvKME79M2fP_OzmBGGtfaFbYmzAbaPbNbyg9ZtVFoEXmwiG
    dOZ43yNwdxoMpCIOA>
X-ME-Received: <xmr:dAA3aND3WRlPdfx8ell1D5rC0qlvpOJnd4iczSXc74k1MaQy5C0KK5DxT01WS1enUxdQCH8EmWfz-fXyQ5d255v_9nrIBTlsHpcOUkuxPLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeu
    uedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:dAA3aLfPlrjTYBjR9fEdAekXliaQIbIAsJJQ8_at9LBqvG-dn1yX9A>
    <xmx:dAA3aEOfzIHkJ5g5VbnkfVly7yryyfuztiyNKPiyTZ0QIk-wAT2MFg>
    <xmx:dAA3aNmd4IdPRbHbuH3Y2JsBbdss7q-cfyqdjV2J1Y3AkxvegXJqJw>
    <xmx:dAA3aOu8Hc06g-YQKBYav0cdzdfa0vbSkwm9g3eJHdVIMP5I0TGH_A>
    <xmx:dAA3aI48m68jIS1wKFmm5ogU2aMVJ6xTZrlPBX8ZNssNaZWEMa-oiWqv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 08:24:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 670d5626 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 12:24:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 May 2025 14:24:11 +0200
Subject: [PATCH v3 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250528-pks-pack-avoid-stats-on-missing-v3-2-4cbd0e14bed8@pks.im>
References: <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>
In-Reply-To: <20250528-pks-pack-avoid-stats-on-missing-v3-0-4cbd0e14bed8@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The multi-pack index acts as a cache across a set of packfiles so that
we can quickly look up which of those packfiles contains a given object.
As such, the multi-pack index naturally needs to be updated every time
one of the packfiles goes away, or otherwise the multi-pack index has
grown stale.

A stale multi-pack index should be handled gracefully by Git though, and
in fact it is: if the indexed pack cannot be found we simply ignore it
and eventually we fall back to doing the object lookup by just iterating
through all packs, even if those aren't indexed.

But while this fallback works, it has one significant downside: we don't
cache the fact that a pack has vanished. This leads to us repeatedly
trying to look up the same pack only to realize that it (still) doesn't
exist.

This issue can be easily demonstrated by creating a repository with a
stale multi-pack index and a couple of objects. We do so by creating a
repository with two packfiles, both of which are indexed by the
multi-pack index, and then repack those two packfiles. Note that we have
to move the multi-pack-index before doing the final repack, as Git knows
to delete it otherwise.

    $ git init repo
    $ cd repo/
    $ git config set maintenance.auto false
    $ for i in $(seq 1000); do printf "%d-original" $i >file-$i; done
    $ git add .
    $ git commit -moriginal
    $ git repack -dl
    $ for i in $(seq 1000); do printf "%d-modified" $i >file-$i; done
    $ git commit -a -mmodified
    $ git repack -dl
    $ git multi-pack-index write
    $ mv .git/objects/pack/multi-pack-index .
    $ git repack -Adl
    $ mv multi-pack-index .git/objects/pack/

Commands that cause a lot of objects lookups will now repeatedly invoke
`add_packed_git()`, which leads to three failed access(3p) calls as well
as one failed stat(3p) call. The following strace for example is done
for `git log --patch` in the above repository:

    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     74.67    0.024693           1     18038     18031 access
     25.33    0.008378           1      6045      6017 newfstatat
    ------ ----------- ----------- --------- --------- ----------------
    100.00    0.033071           1     24083     24048 total

Fix the issue by introducing a negative lookup cache for indexed packs.
This cache works by simply storing an invalid pointer for a missing pack
when `prepare_midx_pack()` fails to look up the pack. Most users of the
`packs` array don't need to be adjusted, either, as they all know to
call `prepare_midx_pack()` before accessing the array.

With this change in place we can now see a significantly reduced number
of syscalls:

    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     73.58    0.000323           5        60        28 newfstatat
     26.42    0.000116           5        23        16 access
    ------ ----------- ----------- --------- --------- ----------------
    100.00    0.000439           5        83        44 total

Furthermore, this change also results in a speedup:

    Benchmark 1: git log --patch (revision = HEAD~)
      Time (mean ± σ):      50.4 ms ±   2.5 ms    [User: 22.0 ms, System: 24.4 ms]
      Range (min … max):    45.4 ms …  54.9 ms    53 runs

    Benchmark 2: git log --patch (revision = HEAD)
      Time (mean ± σ):      12.7 ms ±   0.4 ms    [User: 11.1 ms, System: 1.6 ms]
      Range (min … max):    12.4 ms …  15.0 ms    191 runs

    Summary
      git log --patch (revision = HEAD) ran
        3.96 ± 0.22 times faster than git log --patch (revision = HEAD~)

In the end, it should in theory never be necessary to have this negative
lookup cache given that we know to update the multi-pack index together
with repacks. But as the change is quite contained and as the speedup
can be significant as demonstrated above, it does feel sensible to have
the negative lookup cache regardless.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 3d0015f7828..cd6e766ce2b 100644
--- a/midx.c
+++ b/midx.c
@@ -13,6 +13,8 @@
 #include "pack-bitmap.h"
 #include "pack-revindex.h"
 
+#define MIDX_PACK_ERROR ((void *)(intptr_t)-1)
+
 int midx_checksum_valid(struct multi_pack_index *m);
 void clear_midx_files_ext(const char *object_dir, const char *ext,
 			  const char *keep_hash);
@@ -405,7 +407,7 @@ void close_midx(struct multi_pack_index *m)
 	munmap((unsigned char *)m->data, m->data_len);
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (m->packs[i])
+		if (m->packs[i] && m->packs[i] != MIDX_PACK_ERROR)
 			m->packs[i]->multi_pack_index = 0;
 	}
 	FREE_AND_NULL(m->packs);
@@ -458,6 +460,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 
 	pack_int_id = midx_for_pack(&m, pack_int_id);
 
+	if (m->packs[pack_int_id] == MIDX_PACK_ERROR)
+		return 1;
 	if (m->packs[pack_int_id])
 		return 0;
 
@@ -482,8 +486,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_release(&pack_name);
 	strbuf_release(&key);
 
-	if (!p)
+	if (!p) {
+		m->packs[pack_int_id] = MIDX_PACK_ERROR;
 		return 1;
+	}
 
 	p->multi_pack_index = 1;
 	m->packs[pack_int_id] = p;
@@ -495,6 +501,8 @@ struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id)
 {
 	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+	if (m->packs[local_pack_int_id] == MIDX_PACK_ERROR)
+		return NULL;
 	return m->packs[local_pack_int_id];
 }
 

-- 
2.49.0.1266.g31b7d2e469.dirty

