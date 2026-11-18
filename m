Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969175;
	b=iwyhG6uLsfsqnEIrJDOvIcjbbb5WuWodHCcqx0vnMUw9K2zyTP/zqPr3vOaTgX+NLkFk
	 M4XyoWXaNQgeYWDZywrEOwKTsS8cLlnz+hCxBXCy+1IXZ30lCtCc0RgukNMKkMVoI/ASM
	 x1LWySbt3dyroX8qNQJZicAkepIOyMSamkZ/kg9SSpFnI8FctGJmj16rD2GBg+e9LA8M0
	 HJC877nwTa8ReWEpVGvEm+B+dTBahaNHp4kjz3z0DTDWprmr4QI0XkY1zBevCsv4RKq0V
	 cHn7UF9dNkTdCDG2vnW4onuBt4Fo0jzVqLnvR3MrzjT/uRGxBOAVEKBZR1ymIZPRmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969175;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=76EI11K9yoeFRrVwl7PBgmE8NDOy22DSg0fmw/JtFj8=;
	b=Hj23UJz8sA26jhy7l3Io5fXube+Mi1oIQPEDuNBX7ZNkEzZuVWgbPB3lMBcXgU0YJco6
	 cN62qzB8AXUtgpk/PiOym4FXD8AXu3doLIDVNtt9E/kbp2qud+yBnuWKnJ/8k00/H6wkj
	 nGalB6+stWXkqXLOIeL0dfMhznrkQ1w0ZctuhU1vXD30TIu7gJE1zwPdi4pV9NEjN/f44
	 UTsR8JgsAMhIqkEJOyMmztRMed9Svmdza60v6Oe6tJ1pbc64XZM9ohRszSmUQanIC4k3S
	 PIXRMiaHGp+EwogGBHu+11D+FPnl5XfDksgdmTTet0pjoDkhgUfPP8bghwYvgP5hsUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RnDSwKs9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gMSjvqTm;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71665606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 02:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71665606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RnDSwKs9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gMSjvqTm
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CB8BF1D002A2
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 21:32:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Nov 2026 21:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794969174; x=1795055574; bh=76EI11K9yo
	eFRrVwl7PBgmE8NDOy22DSg0fmw/JtFj8=; b=RnDSwKs9kpdnOJxK5xmzlk955z
	rSEOJtfVwwPVbLPcANAATU3syxS/YUQjW9lxfV9ZfdrL+ib/wWdkMu/zUdwGj30T
	Q4wmH+1n+BR14X8I/k9aIQdPzgZ08TjbgcjgrS0ahFF6At+nrg7kN+XruqhpyzxJ
	dsmwRZHydabasAaZeG7yRYC2h6OB8gLXLAt8W3v/r4VTriHVPlbLzjGK+Tshm2VW
	5G4ADzYKFib8zg9aKHQHYZ68G/KlYwdrl8bxevV9772vt+j60zPkyzY1PlRFqDrd
	ACK72rlszAY0JB+o/JR+aCzhL2SOdHRowGWwjIHuLIEo41xk5zhriSPyrUnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794969174; x=1795055574; bh=76EI11K9yoeFRrVwl7PBgmE8NDOy22DSg0f
	mw/JtFj8=; b=gMSjvqTmlWBHBN8KfAByF+6NGLGhzTKKWcR5cbfIJiY0CGq8jM1
	O8A5WK2SiZEZqtf7zOjfmPNVQGXJDkOe+RatyiRFdXpkbH+6xtLzDj2FcbOezdOH
	Tw1TO+5mRREmX2cix+Sg8bAKyBu+TBAihElU0QT5o6YUn4qTRJj5CMVHF8+551Iw
	4NX7I94+6nDfla2wy//xenFXUJFbwhn6nEy6P+A5EYIebvRYzx3oG0xuy2TY6eYl
	PIp4ksIqc4Os7lOCWVSLLKftyRoSLenK3YuOgqeshMLzbNfXlO2OutpWvu3voWCN
	Mur03ZU7CA/cV0gL1RMdklTp1W4s2Kgefgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794969174; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SDriMAs0K595mU2qRD4B3bF9Ot4VzpzRrB5UQDFIm6kHAa6
	FnjkjtGiQ1X+636IBbQBrV5O7VBiRP8nCm2j7agXGHCRIA9jq274hEUVOLwUs2Q1
	OEWjJVS+PUquQpSz2iwvNa3xZHgajg9ym85YVmDTGAi1fnWuBA9FHT5K1FGJMAI8
	JqIrhhILuGlOJ5cwzzgTaDR4CIEph97pCYLpsxPHQtUyICrom/wxLDRsMpOtT2Ph
	kcMyOIPnmSJA2iWMjoadq5vPL1fQzUpQwVKTp8UW6efx17WlRvtwl0vczL7roARF
	XFIsfaG4GqkCWFdjiQiY3HEIJpz7H2hgUfZdlGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xMiEkJtq2yrnqmnTFuCIpkTQi9c4o4Z0s4lE6YYvj0E=:ks62KABqr8OiS4QKemIhAZoefB8CKPsf75pFrV3oVzM=;
X-ME-Sender: <xms:Vg79asWuaEQPgfOGmSf7_tHrrdCIAh6np5cKOlR64FexcnFIAx301Q>
    <xme:Vg79ai1sASBEZ8_Mj-ZSVsp7Bd7Vw81wZ54ENXfO8y0bR9kOjTJzE0-AqlH7cCqmY
    f3ISkBHBEjnxOrxWKzubi5KiuS8WzV7vsiGTPcvutR3FPuJXfy647s>
X-ME-Received: <xmr:Vg79aipZi5L0plHckHKf-AVNY0YLSg1PrpZxsB3gTDAYXr4mRAhHVFt_4ZmH-8TPL3WKNex_Ryssqo4dZCwRNJ4ODmTlbp7g2DsJ>
X-ME-Proxy-Cause: dmFkZTGJ1xFPhYf29K14QhZqgaGtQ2v27iETf78HOAOTfm6r1SIeQvUNqG3ra8OS9vX3LO
    BsWNtbBvu2LkVBuCg79xi72J7+EjvNXRS/LF0TX+EhhTV094OTth9ZvCkJm5Yw8hLPxA/+
    6SjqkDWELnMAr/rw600vccX5f654rpUOYFwJpOCeQVDd2HdjzApQQIJFq4IBvWrYfprT9v
    zlXch6d5qz/ks/QRVuDmkS8u27Og1fyFkmzPQeOFUV2JRqXgwNSq4v2CT41ShxttybOmo9
    jx8hOSvOlXnqJRHjzLzFH4jouWXRyUbu1aIDAQeV/Ks8UgYlN7q9l0kgT/Q0ukyHzaN+LH
    o3iWcQd433yqdV003U+ebvCbPm6eL8koFCCTPcG4KXFCcjyn+yNyq+ghE7slGwJFWjLHgZ
    7cX8LrINdBHBevHL0zpR0i1sBXQPuVe+XCk+FcHEIcPplKZFOrKbjBvAdNd4/iV2plyfEF
    JeA9rKxJrtfX6s9JeydzXmke4vKsQRuKzAqo4zMMzvhZAFJZJ3sAkxVzT0+Lmde8Ri79Ku
    VldK3B8vquL77OeSSeT0sUx7XYnZMZPME9OinIMd9/1ZWD18/pvfLqcleirb8x8QmYNdOd
    TzHxtQ6N/p80eLpv//gS5ZaB3Wm6R7XuUDk9ENLGAsAU7pnBOMDyJQ6tlj7Q
X-ME-Proxy: <xmx:Vg79ahUh2MSj0o3dMxCCL8jGZAeSSOfcIXRO5mZ5HHWGlTM8H96jRQ>
    <xmx:Vg79albIz_o8YNRBj22No_mLTiW8jw0OmZo9WImolQdxF66MFmqQ6Q>
    <xmx:Vg79amfwCg4KMWgPmytA7Ij2eEl1B3Kn49Mpy-cO8me93vcl_g8uow>
    <xmx:Vg79an1BczPoGKuVftNkungNWBKVay31sqfPdodSaFa-4rlHZaEmkw>
    <xmx:Vg79ak4s5BxwyRIbezwNCobjl36eERmNetVwkjKvTW6d93ExWk4sPiPK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 21:32:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  "Eric W. Biederman"
 <ebiederm@xmission.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] tree-walk: use size_t for the size of tree buffers
In-Reply-To: <908bcf7a607195d7f5215f191a85f25ab0059e8a.1793357680.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Fri, 30 Oct 2026 11:58:22 +0100")
References: <cover.1793357680.git.gitter.spiros@gmail.com>
	<908bcf7a607195d7f5215f191a85f25ab0059e8a.1793357680.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 18:32:52 -0800
Message-ID: <xmqqmrr698dn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Elia Pinto <gitter.spiros@gmail.com> writes:

> diff --git a/tree-walk.c b/tree-walk.c
> index a67f06b9eb..aaac1fd48d 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -14,7 +14,7 @@
>  #include "environment.h"
>  #include "read-cache-ll.h"
>  
> -static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
> +static int decode_tree_entry(struct tree_desc *desc, const char *buf, size_t size, struct strbuf *err)
>  {
>  	const char *path;
>  	unsigned int len;

This change (and all other changes) is not very interesting by
itself.  Because the size of a tree object may not fit in unsigned
long but fits in size_t, it is obviously the right thing to use
size_t in place of unsigned long.  The only thing we may want to pay
attention to is if arithmetic in the function that uses these
quantities does not cause unsigned integer wraparound.  The type
swap from unsigned long to size_t would affect the correctness (in
other words, if the original was correct, then the move to size_t
would not make it incorrect), so if we assume that the original was
correct, unsigned integer wraparound can be ignored.

Other parts of this function, not the type of "size", are much more
interesting.


        static int decode_tree_entry(struct tree_desc *desc, const char *buf, size_t size, struct strbuf *err)
        {
                const char *path;
                unsigned int len;
                uint16_t mode;
                const unsigned hashsz = desc->algo->rawsz;

Our buf[] starts at the beginning of a sequence of tree entries.
Each tree entry is formatted as a variable-length record that
looks like this (see update_one() in 'cache-tree.c' that writes these):

        <octal mode> SP <name> NUL <binary oid>

The primary caller of this function is update_tree_entry().  It
calls this function starting at the beginning of the inflated tree
object buffer in buf[] with its size in size.  This function carves
out one tree entry of the above shape.  The caller then increments
buf[] by the size of the entry this function read, decrements size by
the same amount, and calls this function again.

With that in mind, let's see the initial "sanity check".

                if (size < hashsz + 3 || buf[size - (hashsz + 1)]) {
                        strbuf_addstr(err, _("too-short tree object"));
                        return -1;
                }

The first half of the sanity check is very pessimistic.  Given that
an octal mode must be at least one byte long (in practice, an entry
that records a tree object with mode 40000 has the shortest octal
mode, which is five bytes long), SP and NUL take two bytes, and the
name also has to be at least one byte long, hashsz (which is the
length of binary oid) + 3 is too short an estimate for the minimum
length of an entry.  It is correct to reject if size is shorter than
that, of course.

The latter half of the check is constant across calls.  It insists
that the very end of the sequence of tree entries contained in the
inflated tree object buffer must end with NUL followed by a binary
oid.  As I explained earlier, because the caller increments buf[] by
the same byte count as it decrements size when it calls this
function again, checking it only once (probably in init_tree_desc())
should be sufficient.  This does not affect correctness, but I see an
optimization opportunity here.  #leftoverbits 

                path = parse_mode(buf, &mode);

We read the <octal mode> SP out of the buf, and point <name> with
this variable path.

                if (!path) {
                        strbuf_addstr(err, _("malformed mode in tree entry"));
                        return -1;
                }
                if (!*path) {
                        strbuf_addstr(err, _("empty filename in tree entry"));
                        return -1;
                }

After sanity checkint the <name> part, we try to figure out its
length.

                len = strlen(path) + 1;

Here, we assume we can run strlen() on it, but have we checked that
there would be a NUL before we go beyond size?  Actually we did,
sort of.  The redundantly repeated "last tree entry that this tree
object records must end with NUL followed by <binary oid>" check
makes sure that there is one NUL that would stop this strlen().

That does not invalidate my earlier comment on optimization
opportunity.  As long as the caller does the right thing when
incrementing buf[] and decrementing size, checking for that NUL just
once at the beginning is sufficient.

                /* Initialize the descriptor entry */
                desc->entry.path = path;
                desc->entry.mode = (desc->flags & TREE_DESC_RAW_MODES) ? mode : canon_mode(mode);
                desc->entry.pathlen = len - 1;
                oidread(&desc->entry.oid, (const unsigned char *)path + len,
                        desc->algo);

                return 0;
        }

What the patch does looks good, by the way ;-)

