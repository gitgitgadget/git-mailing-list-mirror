Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09EC3CAA31
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164049; cv=none; b=evhq4AA8lhwUFEvLiIQ99LlT/ndgp6iFtYgGdCwVHoAnIlml7WnDXH+DaNf4JL6nXq/6RYEhcpI7IK1uZh7gDVMng9ozh8mlzckWrZPRnxi9BULfCYZ6kqTT2wK9pa9ystMREiaNVifP5vyeORGVxWnv46Ibdim3+C71us7opjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164049; c=relaxed/simple;
	bh=baUlDeEKCVPmNV38y3AqcakI5bI5hUDfI9zV0ePkFwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTRiHX7cv6dVjQsOHaL/lIqs57u1O6M23dd2t78RjDfIJmAtm1W8gstsA9rpfT4nxAJD8TuHqQAhcxLA4Wp79wwVTaM15pLeQXAtRJDR9tXcTDiTHdOopzD0c1aDNzXTieUcWEjH6KMSIi0K4A7VT4xzEO9N6aGs2GaEcYufubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LIyDJHwT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1ob2sNm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LIyDJHwT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1ob2sNm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F7D07A00C4;
	Mon, 31 Aug 2026 04:14:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 04:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788164047; x=1788250447; bh=IZl3S/wgov
	0BKRSWkTV3TVkZKNWfRYbtUi7YQ8NiTd0=; b=LIyDJHwT7SNZyo1LD6Stnqq/qh
	hk95aLenGXXn27pzRv02rlV0sOjHQUN57uGEssu6d6Gst6LSTEobtp0MaZ03vzUf
	90VA9oNEUrXFDKQZpXlVwNfuFbmX+xDN9m3aPPORI8SmgIzzc7itANjiST52K1cg
	JxH4imHRLb/q/5Flrbuq2yXZ4x+dUi9urHGQYQJHlNFoVlGTJ6UQkRFU2G3AKr/e
	e6Hz+l2IqrjreL06REDWYbq1ycty0Gcda8tsjpYTw7ByU9DvQvC4NlFm3v2ReHmY
	bZt+ZnB/6RDz/FDe12RILQehWr9zDFhAJl6o63n2R5itSaY9x3THx5RwsnHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788164047; x=1788250447; bh=IZl3S/wgov0BKRSWkTV3TVkZKNWfRYbtUi7
	YQ8NiTd0=; b=M1ob2sNmBuA3US7leD4MWZoL/qzeUb9dufCVlTrnjSW7YY+wst8
	wmEwDWpYeAFxNe60tb4xczLZYzGHovv/Urxb4w+auAPnMOEQAmcdBFLWQUD7EVAj
	Wbnzk6pU4ZDPQmsa4e+PXqhYnacIyiVMnigN32ZBCX4k4q99SSjTBlY6jS07L/8M
	6TU+z8/yM4WVLVBsa0At78qE0GTLFXxsx+nrm9Ses9NOynW7acNeGvq8I9hvvhXp
	P3hEdr5uk2U6Z4PkBT7vcRRhNht8hJQBwrQQYJihWz8vDzsjJbDJ5GaYIfa6JuCG
	dfv4tinuH6Hfj62vVdMw8FIA5Sg/qKMeGaQ==
X-ME-Sender: <xms:zjeVaoyfqSk4aaXVaWWDS-hVaJS3uwIbYm8sm0pGCnO8Qboze_Fh9Q>
    <xme:zjeVaiRWNHh76Tnh8NOzpchtk77FHZUBTM1goXK70nqmwG29G1zBzAgzavTNtjxA_
    rxG9imK-LUXjTIoiah-5zGZAFZef4Q7QjV_7NOQaft0v0DfceqXpg>
X-ME-Received: <xmr:zjeVan_7JQlfZ2OWAlTCcIthkcOQOdf9xNtPbaiveMMUjTf3E-Yi033_QRSt-c1gE9qzNQ>
X-ME-Proxy-Cause: dmFkZTFZXM4nlK7FuyZfh7KCinb1QyGk2t3KSS9yX5r1PCB1Xa5vcF8NfeAsZ67pSXj2ji
    fAT+1vdX3nk639xkgZMwzZT5pzCYuwKtrrf+X55yT+oZv2K9xDX23VMWH3hwqiWhBV8BwZ
    Wy1AB3wM7mVN+sc4Q2PZI0DpMgOEfkJBhrhHEEQCGbDsPXyNrDwh8Yxp3EKVJStka+0YV/
    cA7j1H4qwk/p45uS6WLyAy/hT4bB0VmK1lbYNulT9LAUcZxIyA4CjG5osStpowI+IyYttD
    w5TXW1cS6UZxtFPb/7gVJaYXUWCdvApbm08K6ecFPdWCI73cTqUzZU/ZpZik8DucGQjdea
    at3xzrx1ImRX/87H2ayscdQ+DoxpNzQmAEZ3m9co0uAH3aGVVowRVnO0mdWxOT+Ua64S2X
    9/IWJT6nD/A3XtqZWgQLRJv2LJkh0uKz9hqsn1qOiwvXhDOowHwanq41yBQMHwexmRPrWq
    4JFfxDX4d6UkRK8ngOal9kMHgh8qtWcgpTxIEHKGAVCQLX6KjdBGqmnrBEN9z6leX6X8Ap
    OGcSG53YkSHORiTSzV41wQV1KYPWc8ajcgQqMPOyRWk5UJ0lAn+JMV6EKWi85w5Y48yzCg
    wtPjR1HVLrBHisOH+MFGe5ogCnojVQ6NvYGWh/u6Nhxa2h3KxWmzJ04yaGDQ
X-ME-Proxy: <xmx:zjeVahp4DigClZH3CyjnNrWkyIaqvD8M8f10Pl-Mhzn-MmSwhS6iKQ>
    <xmx:zjeVasn8zjs0Tot-HC0SJ8IW4QublbPZ4RA-n2UqN5I9RP_BBUqucQ>
    <xmx:zjeVagIjImMI8fk477-CFcNo0fBEz0K_bejWo4v35WvOfopW3kLFCw>
    <xmx:zjeVapxmab6HJx8CVVJBdNpBpOMxgqIMZdEC2vMnIW8kg2tZcDG8Bw>
    <xmx:zzeVasJj4RFAh8bRZA8_8zIygChkpc6_EWBH4BsDN9fD9-6ydbaBCqt4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:14:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 240dd523 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 08:14:10 +0000 (UTC)
Date: Mon, 31 Aug 2026 10:13:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] builtin/clone: move setup of alternates for
 non-shared local clones
Message-ID: <apU3xpOZf0b9P6wT@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-5-911513ba95c3@pks.im>
 <874igeuwja.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874igeuwja.fsf@emacs.iotcl.com>

On Fri, Aug 28, 2026 at 04:52:57PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 08c8f5a94f..2e3473fddf 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -195,29 +195,41 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
> >  	 * to turn entries with paths relative to the original
> >  	 * absolute, so that they can be used in the new repository.
> >  	 */
> > -	FILE *in = xfopen(src->buf, "r");
> > +	FILE *in;
> > +	struct strbuf path = STRBUF_INIT;
> >  	struct strbuf line = STRBUF_INIT;
> >  
> > +	strbuf_addf(&path, "%s/objects/info/alternates", src_repo);
> > +
> > +	in = fopen(path.buf, "r");
> > +	if (!in) {
> > +		if (errno == ENOENT)
> > +			goto out;
> > +		die_errno("could not read alternates file '%s'", path.buf);
> > +	}
> > +
> >  	while (strbuf_getline(&line, in) != EOF) {
> >  		char *abs_path;
> >  		if (!line.len || line.buf[0] == '#')
> >  			continue;
> >  		if (is_absolute_path(line.buf)) {
> > -			odb_add_to_alternates_file(the_repository->objects,
> > -						   line.buf);
> > +			strvec_push(alternates, line.buf);
> >  			continue;
> >  		}
> >  		abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
> >  		if (!normalize_path_copy(abs_path, abs_path))
> > -			odb_add_to_alternates_file(the_repository->objects,
> > -						   abs_path);
> > +			strvec_push(alternates, abs_path);
> >  		else
> >  			warning("skipping invalid relative alternate: %s/%s",
> >  				src_repo, line.buf);
> >  		free(abs_path);
> >  	}
> > +
> > +out:
> > +	strbuf_release(&path);
> >  	strbuf_release(&line);
> > -	fclose(in);
> > +	if (in)
> > +		fclose(in);
> 
> Why not put this before the `out` label and remove the if?

Mostly because it feels fragile to me. If we were to ever extend this
function to have another `goto out` it's easy to miss that we don't
close `in` anymore.

Patrick
