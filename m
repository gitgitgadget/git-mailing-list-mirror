Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176157;
	b=i6HOx/03Gl7Cdlqm5ZK4/CRiTWZF4388lUUQLMy7yz/0v73lFSsBsJhb0Q95mrYty4fZ
	 SjNHBW9fwfx5NMPJttzYlmp0mBzxN+LNUK/8/lnLwhLXaQ3HgI3J6k7DiQP2zCTIAGB60
	 5UAQfU/O5g+4sQ2VIDyofjbxG2FBAalw5xlS0tH0MUUHaXb2htOQ9d4UUK3VE/hOQ481f
	 N/OJsipNllULXYQ7fUXT61fBckZSFvnU3CDITT+rKv37fmKo+bOF/k+DdVlaAMBPhbMII
	 SOX6vn3yWVfEBgzqHnmOtdh++QXtRjwSh9yp16/bwVQdg3SWnjL9jj1qYBZn7X2S0oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176157;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=Oe8PMyEoeE6rINCeBHAJnZtROWupxIzPSM1xtXBCpMw=;
	b=L/0r9SCbx3UbtIXwkz272+UL4/rfNGJ81FI/tKY1vv1PP5hS3khjGVcQkfyIeRc6AwOf
	 Trdm1r6CLL+eJG9BAhOFOQ+7ioqWkfP11RiL+7rvm6uVGZfYtrktg5U2dp1I/dl6GISDc
	 XnoOrJ8L+Do8qoT/FRrlu4yESVVS2zsb4cL1JkxfiHcjhLK/NvCSUh/6t553COC372hl8
	 fJvGrG9AUc0TLo847GDlt4395ooUmDG0Km6zLczQZWcESrZke7b/QOcsqLOiiRouTha02
	 OZ75XnQgwZlKJ14gP8aynH7H/3J3KmrX7Kz9BFzB0JzKnf1ij9VKdXbETLFSYA8iF1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gWVlmPKx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DGZnPga3;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369D606A331
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6369D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=gWVlmPKx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DGZnPga3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98047140020B
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Nov 2026 07:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1795176155; x=1795262555; bh=Oe8PMyEoeE
	6rINCeBHAJnZtROWupxIzPSM1xtXBCpMw=; b=gWVlmPKxL03QaTc/5XbAwJ6Tlx
	y4F3259qKXR53jwZeA7NQwofXyfCN7unkIYuFQT8bZp5PwsXbGwe4Lrf16+YQkrJ
	6cVJCycpIU6T8Kg2OSvem8FusbyJPH9RhVgS+5K5a7+4HskL/m/W6MOkZvatoq11
	g4T53TQkSlACLrFUbHXAVqc2rDoIhUA27ykbRpTFMotPqDBm5DNcAuVLljNQqmQA
	vDA2+tagkQwe9GAnNeT4mLUP7/F6JbJJil52/dKhXwFAsvu17tbsgbNGyhR5shND
	Gs/J9OhkcyT3xrM5Mjxg9GwJCj/YyMRcof/BvizbpY1lj7JxaWhd+msv4iMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795176155; x=1795262555; bh=Oe8PMyEoeE6rINCeBHAJnZtROWup
	xIzPSM1xtXBCpMw=; b=DGZnPga3jmQ6V9z5cEXXDaed+qRbIK6vRLg3xq+dZ1iT
	J0VVOFfwB66P3qOJFqP0n/A6VAd1xRnKqKyD6ue3kg+lnQkcGyPLoALe45wZRSsb
	CSitpVaxnOX6JP/j31NLRTxNSHfxDqEQME66huqC138cirYsFipcishe5d8TBkxz
	ZPw4gT3QSMjcQrn6qnCSvyO5JmF9CCmrxB3oQ7ZJkcgslTXCGHLpJOeG6KhsnUUx
	ty1Semy3VOkHV2Ro4kfMbtBTI9omHv5YlAedJD+9odWokL7xw4aeZ8ekTgvizG+d
	frRxGBXhnIw+tSoqPtcFpv5x3XaS6xVwvZ54wlvvHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795176155; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:zUQ03xOER71o+n2WNUMCdTkPDBjuBH8CHicGEHlus7eDTcb
	Lt4apKaCqOQJLKy9bfjwoLEcA0bAgxe3WNRCehhEjQt7F8xdlRUV+MPAixitV1rW
	O/ZgcuTU+VUSRSTwjYDNZHRv3u7Hru/ebjvhxBiEL50XjVJeLm6xfKOGzeh013vx
	0PNZggWkuNEpn0F3VtnILwiPcWaueMdvKl+kf7E1tjQtNqiM/8upJ2qtWufWNf/4
	lTPmUXcOvDVFOBZUFgyLWp3CmV/13DxvKUHqn7NCtMjGnAxqLzCHCkEEtf94uoKW
	f0VkGM7J/z/iDi8GpFGwiZiRfs31R4qJoG/+V3A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:MXIiCsqe5TsNU6NOjRzcgcG29/2vkftcHxoOhRiEuck=:lQ4+FgwYAKInVFNZ+gGHWRlID/2hyklZ6pdS4BDipyk=;
X-ME-Sender: <xms:2zYAa66xnEjuXvKiXFSShiH-rdPRJgYw2hf-Psw_TQzVMXGuGSFRAg>
    <xme:2zYAa60PYgksQsRIY1hzEQUnygt6bMnJToJg5SZq3lurDpGPc3FOcEVlS6u_umlen
    _nkExG41luM5CN1IDS9SP8csLPe-6VNkts8yZw-wB_7n5ssD6bd8Gs>
X-ME-Received: <xmr:2zYAa_GFdA6azyvHkX8KiOzkvEwZ3zIMyPz-iTwB3nUpCGxJxQwD4FC-adNULbnQss_dwJ4>
X-ME-Proxy-Cause: dmFkZTFnm+ppWlR7FG30OKHM3IByVAjs/69AsVvXbUqO9QuLko4zbooZbC2uSpTlPXTLfc
    QL9V2M3nzXWkk6T3qG3qkp907MusFHRLQKmmJ7u0StM6oLrpuar4TZLKCkuVrUFVGLkrXO
    pOfHhlZaMJO6aWv2zKKKRhj73ZnEohYfHZp0gCCCeJZVT/SppOyM1BImrxfscz7ZKNxNSo
    VjvW/1DcxFBMYXADclRkMyseX4Loew6YhjYbn9DNrAPC/M5U0qXjgPaMZFFqCFKMhia9AJ
    iXBpdDnWA8g/TdKN4JnaZylv0cSBeeKrf7xGzSUovUNZVvvQMGwOvEO61cG0ivlcopSfD6
    Uw6heK3/ZVdXhUHSRdr0sdIaRB3XhPWx/RnOR3ZMFqgGpWdz06uI2eZaD8GVnDnJYkVEie
    sxv/oIunYDUFOHuq8wPAc9cjT+MJaogKs0sVaLCFbh507LaI4QPlB2LRNZ61VqmzcGOIII
    8fvuojQ62OkCjG8KOTayPckZsn+n1Y5M17Iap7fV4RU7Fn/Q7EzLtCS6C0LT+nT2HgBwOQ
    4ZnVtDFQHrRN0IEUotpu2i2difVimjYxHPRJlimenyuErWVi81LqjIIvU8UqNbqT/fYqfs
    pr49YL2INVZcNRdIcRaqmoPORrIqnY7P9s40+YrNn/maSAZA+jF80LawivIQ
X-ME-Proxy: <xmx:2zYAa8QOlbio60p0XZwwecKRrLY7uxulMFYxggVTXr6bDYVtkzp2gQ>
    <xmx:2zYAa-BWkLj9-4v5frp5j_79b2PyrJuX4VLpYR9nihVKQQtjIftZBg>
    <xmx:2zYAa00qrVtzKm66QqYjVO2hFvMRVXCHdkp1C_L3FBu5NMKSHrOhWA>
    <xmx:2zYAa0U6t3BPKM5IEkbyFcHXYmU5041PHWu2i1n80VQA3yPMy9YuWQ>
    <xmx:2zYAazaXupo_gIT6lvkehjxY6IsD4P78WI5ympIcGoIRfBf-tWtnfOeO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Nov 2026 07:02:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cd03f1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Nov 2026 12:02:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] packfile: some lifecycle improvements
Date: Fri, 20 Nov 2026 13:02:27 +0100
Message-Id: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNMQ7CMAxA0atUnrFUZwCFqyAGJzjFNGqjOCCkq
 ncnwPiW/zcwqSoG52GDKi81XZcOOgwQ77xMgnrrBje6I5EbscyGheOcNAtOeQ2c0Ro3tabR0Dv
 2QfyJiRL0SKmS9P0bXK5/2zM8JLZvFfb9A66lSRSCAAAA
X-Change-ID: 20261120-pks-packfile-global-statistics-92a9be97a11f
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series polishes our lifecycle handling of packfiles a
bit. The original motivation of this patch series is really only the
last patch, which fixes how we handle process-wide limitations. But I
took the chance to also polish this subsystem a bit, as a lot of its
parts feel rather dated nowadays.

There's a minor semantic merge conflict with "seen" that can be sovled
like this:

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 77f8227ae52..e24f6cc7ef9 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -898,7 +898,7 @@ static int odb_source_packed_map_oid(struct odb_source *source,
 						       &hash_algos[src->algo] :
 						       repo->hash_algo;
 
-		if (open_pack_index(p) || !p->num_objects)
+		if (packfile_open_index(p) || !p->num_objects)
 			continue;
 		/* Only v3 indices store object IDs in both algorithms. */
 		if (p->index_version < 3)

Thanks!

Patrick

---
Patrick Steinhardt (6):
      builtin/fast-import: stop reporting packfile statistics
      packfile: rename lifecycle functions
      packfile: inline `open_packed_git_1()`
      packfile: introduce function to free a packfile
      packfile: maintain process-wide limits globally
      packfile: skip closing packs marked as do-not-close

 Documentation/git-fast-import.adoc |   5 +-
 builtin/count-objects.c            |   2 +-
 builtin/fast-import.c              |   8 +-
 builtin/index-pack.c               |  16 +--
 builtin/pack-objects.c             |   2 +-
 builtin/pack-redundant.c           |   2 +-
 commit-graph.c                     |  12 +-
 connected.c                        |  10 +-
 http-push.c                        |   2 +-
 http-walker.c                      |   8 +-
 http.c                             |   4 +-
 midx-write.c                       |  23 ++--
 midx.c                             |   6 +-
 odb/source-packed.c                |  14 +--
 pack-check.c                       |   2 +-
 pack-mtimes.c                      |   2 +-
 pack-revindex.c                    |   4 +-
 packfile.c                         | 233 ++++++++++++++++++-------------------
 packfile.h                         |  30 ++---
 repack-geometry.c                  |   2 +-
 repack-midx.c                      |   2 +-
 t/helper/test-bitmap.c             |   2 +-
 22 files changed, 182 insertions(+), 209 deletions(-)


---
base-commit: f7de81456940dd6f3274e461149bba12965de609
change-id: 20261120-pks-packfile-global-statistics-92a9be97a11f

