Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618442;
	b=gKPoGYpStrlGBPX8qw88WF8EQM9ENA4O/55CptdKEqJJ+kBjXGs4Y2ArJTSQAnnQGHqp
	 KEYQX8d13fClwx6bHLNFL6Tet/XzIP+qMO6jav6pjnlqoSwyin7BMsdB5ldHz/kmQxnmo
	 pshGs+DC8o4KqsVnt4ZA7gPZWwLN7b5UbWWl6ANBlRQSis4Kq9CoRA6jR+cOFeuEFEN4H
	 opafZ61yOHS1xK//yGHT0q7aUDbc+Xvgp+ZTsUH9y4C46O0P8AK6qdSFlBt/8pcaNhvGY
	 GKAIaOG87/Dr1gaEwwcCIbFeJN0aIzwBYfAWvKyUJRY5ir48XDlm07xkgAklycjPdlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618442;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Qz5NOc3AohjWQ/A6mIFyxyDxGG/YQLPO8kCfS0F+DG8=;
	b=c4CeNaqxCWQDpHH56x7fQoVvHy07wzklLeoIlqGMxqVu781jYKbls8DTmC5hLEFTBA/d
	 nu+HRbUVh+8vWPgGmrO2ZX16hU/GIZPo4/x11xxPLcjARhTj4MSyatCWkffhElr/v/Y2y
	 Ns83fscIMoCu4eCUeNQwr+pGdU9JuPrnVpM4ksjA9yxn/1tAAdjDVR8la0T/QKowTvBPe
	 7WP8St8GuOoafjgEtEJ3j0AR8ezKl+n04TMgmisrNdqfINl/piJRZYVJgMwgv7kNYXkrE
	 GUhFMioMhmUKdfpbRm18zasnI3JUeJx1WM+/fMiWi5b0GjjSLfDYCIZio9UNoBa4n4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NL3GIeKr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xLWY9KqZ;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B84606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66B84606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=NL3GIeKr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xLWY9KqZ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BAD4A1D0014A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 06:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793618441;
	 x=1793704841; bh=Qz5NOc3AohjWQ/A6mIFyxyDxGG/YQLPO8kCfS0F+DG8=; b=
	NL3GIeKr+kceWVN+oDH4BPswM9ta9P5p/+ybq3wh+rKvHJGTvAJRBZbETdQ+3box
	GlFNArfvRa5XRS4HZDOeDxjOvNE7cnj1/t4mqBF3U4/x36/XdLKBIXTYmgC0eX36
	edi6OR+5WgKsfdsNIkp+k50qExiJ1iLZYWbu7oK5jbtc++X/YsopbDcE/P9I+3CV
	x4hta/eft3k76CbZ1H1Naims0jD7xuI/I35Uhl6rPopWEWpJ9hh1OLbdSqwN3Tv+
	fLp7R9pD+DzNyuQF7mpLxNP3g2y2aEKqPKyl+uSF42FG224ACsIxzKp1WIvHhXuY
	zVjIuwmLWlM41+nfP+TlGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618441; x=
	1793704841; bh=Qz5NOc3AohjWQ/A6mIFyxyDxGG/YQLPO8kCfS0F+DG8=; b=x
	LWY9KqZbmYk62R57dxxhnt00pQQb/N2kPl+7bdsoONs0pWry0wU0wWILeDnQcB2A
	8Z1ieh7bAHGGJmVIvEI7ikzieL+DeGK2wip52CcrZN9WlO5hv06fFHK/bDIR2wsk
	FXbpuGDaTn/78jsFvT5jDx6OwFU/rSGT3hHNNSbZjNKCAFb9NjRc+9hLwCHD8KWJ
	wMBWOL3+To1LkIPAZSvoU9aSAXnPVlfOvsvN4IJNzz5KHTFXcPT1uhb2zFfomImE
	yBskKxsU3RFNVZvJN6Jspk6nJPwO0CguOqbwdv6sWfEIRoPoAfxuCvcWkp06+sxc
	K7MoxVRIE8oQHKrOl2FEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618441; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dFLCViQtJ+AvRm4c7KrD53wKiFgAN2Dyx3piyimaFfeSt7D
	4K8MwOi13s4FveYzXX8BQA/DQez6E+YegLF7vz13bZ21qC/djzO76vuPeKBU6hca
	qumJ9JDjjCMPLx5KjbBoz+U7XzGYNlK1pv6+4/tMsLEYQi8N8dhxbMG3gUWDIaQ3
	IDWV0TPWjLtk0FqSlREopp2jSvTPp6hl3w//SYK9T/8ceJD3vFTCh3cWFP3J5AmG
	YTyAV9j9ixNbckZ3xd2PaV/YRRpSI38TrbV80xyMzhZVwiknkocQqr3UwOUAwS3L
	8+RvjgW2bNi9+QLSQZ9VkRdtmy0NOEWfHAMEnzg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6U+rzu62asJYU+CkUoaC+K2ySGD/b7zTnH73S/mmz+8=:CM/pkBH00PTxPjhV7DAuZzAKPzKtUTxOmxiS9OFz4ws=;
X-ME-Sender: <xms:CXLoaqGO6BaSk772kmwXBM6zLLAwJ5URz4eWAqXF04qYRSOe6bvWig>
    <xme:CXLoaiR1NXKACQmGevZuKxp5vzuGy0uCaJ7vjMbv9i2MzJ-CQZryoRRV8q0S4W3Ss
    u0gycuQPPu5GvOnKf3exFKYV2nsSMAgpeAEDcjbPouKEOVBh6M66Q>
X-ME-Received: <xmr:CXLoapyjU1l0ePCXagxgPw33t4i6DcEMsdGn6srQdvIEUxqjxL2ZWNCQNiEzPoVxLf3jDQ>
X-ME-Proxy-Cause: dmFkZTFmjoZME9HE3u2FhWOW93LgHNK2jOXSy8KSI2Ds1OqzKZFqUYOKZ4B1+3GD2EwvqX
    c0NwthNEyE/Nc95k4wpPTDNJumy9ygiYf2B9dzpzhflTI9GCeW3Lk12nJMlnySeAbjQWll
    aQqWOxMQz1mpijmu/11bUj26lhCpefnojaTrVKX4hZiset8hXkX++ENs5cKG1+TRNxiDQC
    G8/gOCe8/jtEExcnDQz0Rn6DLL8yFZq8jka8pVCZ04lkg3WdePdBzuJr3NN2MiqZ0Eayxn
    hqQvXYLdUO3I9/mCddciQnKH75kgN9ZSxSJuVUwYXibUPRJ23EJSgwAUqEz2hcAzbWLBhW
    jC6a1phPv4QogzFZI9zXU1rTkXPxqA2Hnw0hEjoXvb1U8THpkkC+Bpr4eOGwdgpJdTGeBp
    vzVOEx8Kz73dXZXPrmsWn+k1f7lM7qAach7IMq7onn4CJbvEm2g/sNZIzDjhqXkLg7CWB4
    v6a4e8plEr71jrkpWknH1jvESbgmAiV4ixyCSo7ERFscfAoDsD4isliE8hcr2qvvw2orul
    sotODaI1arZO2fHU+kcUgavKJwKaTVu7ttgWktF7+WTxJZzdoIb5AMyITXClNrmOfX05N7
    /D7PU/zAWsAxXoVXrjWx8KT7SxdhQi+ScDqZPas/YzwQRFj37+MJ8uw6aeHQ
X-ME-Proxy: <xmx:CXLoapNS4LGrvdqNLzAZezB8DuCU-X7lG8NzGlASEfDuArKnggZfPA>
    <xmx:CXLoagMwXIEJmQmo49mmPb7wPHsplcHOTY1xo70r5_ehdPnlca8qPw>
    <xmx:CXLoajQQ0oVllFX1zgBiKANb_C_4sokH-RNYVUprYBghLh2PTt4DUA>
    <xmx:CXLoaqCn7svLgDTzgQ2yOFKzFcZC5gWPYTkArcHVjk7CQUEtYquZIQ>
    <xmx:CXLoasVsKte0vt0hc15eTx86vUi25nyBd30vjEEc2dU0sX83du-lhQms>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85c55edf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Nov 2026 12:20:20 +0100
Subject: [PATCH 4/6] odb/source-loose: deduplicate logic to mmap objects
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
Message-Id: <20261102-pks-odb-loose-cleanups-v1-4-fbbc86c29693@pks.im>
References: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
In-Reply-To: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The logic to mmap objects is duplicated across `map_fd()` and
`odb_source_loose_map_object()`. The only difference is that the former
takes an arbitrary path, whereas the latter derives the path from an
object ID.

Deduplicate the logic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index a90268e200a..5cd679e802c 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -544,28 +544,11 @@ static void *odb_source_loose_map_object(struct odb_source_loose *loose,
 					 const struct object_id *oid,
 					 unsigned long *size)
 {
-	const char *p;
-	int fd = open_loose_object(loose, oid, &p);
-	void *map = NULL;
-	struct stat st;
-
+	const char *path;
+	int fd = open_loose_object(loose, oid, &path);
 	if (fd < 0)
 		return NULL;
-
-	if (!fstat(fd, &st)) {
-		*size = xsize_t(st.st_size);
-		if (!*size) {
-			/* mmap() is forbidden on empty files */
-			error(_("object file %s is empty"), p);
-			goto out;
-		}
-
-		map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
-	}
-
-out:
-	close(fd);
-	return map;
+	return map_fd(fd, path, size);
 }
 
 struct odb_loose_read_stream {

-- 
2.56.0.500.g5d06dc02cd.dirty

