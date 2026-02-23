Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CA34D391
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849272; cv=none; b=JhGedpyHxcl/mJhExtyE6K80UHry2JQ4vcN60vn1Ee15SWAilE6h2mANfqsgCoTCJKWKlmRQs4WA95dbyZbRTZspqp0K6FSfH/an+raP3e+9NzhtG1b2PwW/XMglwP4FT3jU2WEcVVbcUyZs+sxnWz4wGiifvtnhGqDTzUVrMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849272; c=relaxed/simple;
	bh=vCTOvMhdSkDZK9G+zEBwZZIDZacF7AyAhTbfCrRLr7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqzXUdlDsPPrrRFZFkLJ3lvJU56cqrYDioLxUxLrJeDTHKPpSsH2w6hNk36YwEn/B+YvgDnf0l8F1JPhRoNcpiaGn56E4sjsW5A/Ul2JqK3akcWLhlPQJssdnDoePxa/kLh3b/9T7MVxdcBx2oFWL3F7iJESHxo4v8wVwJ7kgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=erkuHGHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bMeCcjiF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="erkuHGHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMeCcjiF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3E7E1400189;
	Mon, 23 Feb 2026 07:21:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 07:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771849270; x=1771935670; bh=u7SxTio9HK
	hglPBmnJQPEPcz6lCRBB5Mx30qNAe+nXY=; b=erkuHGHg6nDfnxXq04jtd/F0ff
	b4SfrAxTeoGYfFCQtqGBtk5qSaIAAp5I+gcxRDiJNsc8wWprq0OUHmgRgVAUM3rY
	6PFAfzZFo+JDAO7HJLMEm5133/1tgmz9AFtfOZ+gqSNj8RWIOTtGqw3nWFvWuJmE
	e1zHGg961SMSGaR9ER3nak2TwfwHRMvYhyHeyvjibqjBQaOot8EC1VedfJUbguJH
	dGDAWq3t5KiAH/BsFvN8H0B04j20Z1XWEYyRdoghLtTGCBrqcLDHNM37puSfBSWz
	Xf9IuFBZeFhmMJpQRm0PYYAR39yhuisA63YUQtAF9Vyh+Qk3I9V5PVIxodvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771849270; x=1771935670; bh=u7SxTio9HKhglPBmnJQPEPcz6lCRBB5Mx30
	qNAe+nXY=; b=bMeCcjiFQpHwSA5Y7dEwvqqlzAENxoF6s/O+BqNRMJPPsUsboiS
	Y9WvjYRcglL+qVTmz2JYRE72I6t/AGGAsUa0hhqXp+F+DHxofp+3BSHd551aa8dB
	fThFMWpzgdQnjsLpSIwWV/gt/NvYzP3lkNobbTqgrAVc2vFsTk3OqHbcxKja7E0X
	ktEFxOM9ZJHfQwxv4qAFifydAPCmQPNFIotAScupMn/crFrMukpTLHRC8EJ1NpdE
	MRIiPW3gyIRUn3nLyuZtgKb+qT2li2oRiQ2YwMr6nV/auLjCX5Lbc/vV0r5nKm2V
	SJCMNIMvPAISEPUYAXfPVA0fNvn4Ra6Hmgg==
X-ME-Sender: <xms:NkacaZkGPOHGlMiQUMKPvNC41epltlz5mVUaF8RFiBFvAvEx3Ni6ag>
    <xme:Nkacab0Ft_oiFLbRd01oIzE8Y_xrXeMqXYm0lBbpFxKUQEOA1nmS-40T0iexrC0Tt
    xVizS85WAWcrFG49RkBk0_Av39HcAkwszuD-kOnieIcvFrERJIT>
X-ME-Received: <xmr:NkacaUpNO83mYgz0xZVuux372W_i_Iqw0cE3Ku-53ay_oj32MnKkWfW77vdaW67Ai4ZWQ8gq5rVxJHaJh959VDpY0pIpJpx5wk49DUkRMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NkacaYdyCO9EalzyPBVViR2GRIQUHz_Hx-GSYwiehum7AZdFRsY5ng>
    <xmx:NkacaTpDM7E-dALA7nuX_mLuDfv_eHTp72-21LtTbTm5KwatXifTPA>
    <xmx:NkacaZEJSBUJTIq5r-M0FyTY0hRzahfdlfx9H3oFrJxv_vHDfc1eNg>
    <xmx:NkacaTts29-0F6YV3qpBfR5Li28qVgRV5AVS55U2G6Smg9ALZawU2g>
    <xmx:Nkacaaq4HyWys8ayLU2DRhgPlQPIX7wDWckVXA5aIm8-ADpS-ELfIQxT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:21:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6059f63a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:21:09 +0000 (UTC)
Date: Mon, 23 Feb 2026 13:21:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] packfile: expose function to read object stream for
 an offset
Message-ID: <aZxGMrGkVNeAdC1N@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-3-c29036832b6e@pks.im>
 <20260223110722.GB215364@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223110722.GB215364@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 06:07:22AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 10:50:42AM +0100, Patrick Steinhardt wrote:
> > +int packfile_store_read_object_stream(struct odb_read_stream **out,
> > +				      struct packfile_store *store,
> > +				      const struct object_id *oid)
> > +{
> > +	struct pack_entry e;
> > +
> > +	if (!find_pack_entry(store, oid, &e))
> > +		return -1;
> > +
> > +	return packfile_read_object_stream(out, e.p, e.offset);
> > +}
> 
> OK. The original read via packfile_store_read_object_info(), which does
> a bit more work. It called packed_object_info() and if necessary would
> trigger mark_bad_packed_object(). But now that we are leaving it to
> packfile_read_object_stream() to look at the header, we don't need to
> load any object info, and we have no error code to check.
> 
> It does make me wonder, though, if we are missing out on marking bad
> objects here. The idea is that we'd usually do something like:
> 
>   1. some code wants to access $OID
> 
>   2. we find $OID in pack $P
> 
>   3. that turns out to be broken for some reason, so we mark it as bad
> 
>   4. we try again, skipping $P and finding it in some other pack
> 
> But now I wonder if code that tries to stream will skip step 3, and then
> in step 4 we'll find the same broken $P over and over.
> 
> But I suspect if that is possible, it was already true. We were only
> asking for the type and size, so any content-level corruption wouldn't
> be caught here and we'd have the same issue. I think the right thing is
> probably for the streaming code to know about the pack/oid pair it's
> trying to read, and to mark it as bad if it hits an error.
> 
> So your patch here might be making the problem a tiny bit worse, but not
> in a material way. I think we can ignore it for now.

I guess the "tiny bit worse" part is that we don't handle the case
anymore where `unpack_object_header()` returns `OBJ_BAD`. As you say, we
previously didn't fully parse the object anyway, so we couldn't have
detected all kinds of corruptions. But we definitely handled the case
where `unpack_object_header()` failed.

So maybe we should do something like the below patch?

Patrick

diff --git a/packfile.c b/packfile.c
index 9d795a671f..3e61176128 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2554,6 +2554,7 @@ static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 }
 
 int packfile_read_object_stream(struct odb_read_stream **out,
+				const struct object_id *oid,
 				struct packed_git *pack,
 				off_t offset)
 {
@@ -2571,6 +2572,9 @@ int packfile_read_object_stream(struct odb_read_stream **out,
 	switch (in_pack_type) {
 	default:
 		return -1; /* we do not do deltas for now */
+	case OBJ_BAD:
+		mark_bad_packed_object(pack, oid);
+		return -1;
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
@@ -2601,5 +2605,5 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	if (!find_pack_entry(store, oid, &e))
 		return -1;
 
-	return packfile_read_object_stream(out, e.p, e.offset);
+	return packfile_read_object_stream(out, oid, e.p, e.offset);
 }
diff --git a/packfile.h b/packfile.h
index 67d5750140..b9f5f1c18c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -437,6 +437,7 @@ off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
 		     off_t delta_obj_offset);
 
 int packfile_read_object_stream(struct odb_read_stream **out,
+				const struct object_id *oid,
 				struct packed_git *pack,
 				off_t offset);
 
