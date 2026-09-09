Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F053D1AB3
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945820; cv=none; b=XG/onk8hlA2utkGiVZXOc7W/0rdmGmMdswsueij4yXeVqSeLjTc3tD4PGujX4J5cJfTnTO1rI2KmjYiaabry8vPwMWRRA6eBXhVS9UH8axGmHqJPKA9P/13JaFtGcJCIfWlfJJdEs+QR7ZbC2hB9KJ/tna3p5cksAThv8noLa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945820; c=relaxed/simple;
	bh=AAA0xpxD9fu0XoXlVrmU8eecwbmPdrsCRkbRC1Dcq/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeqJY36lBfXQOyBvDtED+n89eY/BeeLS9PBqkixYlP4CNEvya4i85ydjj39k1rd9Pmqk9tlM9Gu3J3CfcllNcDNra6Jv+gU7gCIZt9jH8JzfUjh3UOraphub/QK/jbU5v2NNtJLA14TvJ/MbRitUbpu9Woyu6JMpGGHKmtghDHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VNRey8me; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rKWLo8lI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VNRey8me";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rKWLo8lI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F673EC0074;
	Wed,  9 Sep 2026 05:23:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 05:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788945818; x=1789032218; bh=JIBLwcNweh
	osqnRIyjv41ZcNjrIA3S7OPi+4FBtUmaM=; b=VNRey8meWBZakiaWPHNSFUwGSj
	sJ/uRJbLfZlPJYBZejRlF0MHkSAaHrSLek/5x8E7ZuVcJaPZ/QgF2q7pjLNY3+3h
	3QCaIg2iFmIh/YJP/JsZSjL+5waG22Nr+LfrwAUvPI7AITFY1pl1YxyXW0U2PFAK
	DK36Nl7Wgjbv0aMJkzqHr6TGFsjezFF44EH8PqCA9i+ydx7ZXSHraLkNwLGjEGW5
	ff37Cmpz+Y4uP9x21ID9gS3jSqQ8JvIRIkY4R0XJ6XQKqt38D9Ca1sJc78b7gcej
	/84vk4SRQG2aW91pI9WHot1aa4eA443MDeGTGpDMPPlOrFYQFl0PUFqZ65Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788945818; x=1789032218; bh=JIBLwcNwehosqnRIyjv41ZcNjrIA3S7OPi+
	4FBtUmaM=; b=rKWLo8lIydJqlxkbhmiyPByYy48bwAFMmQfSsBovD0cQqyyqba4
	P4cfHHroNG1nllx/NKKEYWpWB7247BpU39+B7R0ttZokgyTuLyloH7m2rMV3cUjl
	WNcfZ2ewFB087vp0B7knGyGAr807fnTeI+MMlNUgPRglgDQD3rS/V/w4n9f0dQUL
	LkO1aSp4gTfKhYSakGwLianRXNuuymgt3WYAoZZGATqF/62CC2HBHPlww5iWPCwS
	ppfSNpPHJTADwFWy4RWCssC8x2odkVKmwmL6VZ3yrKkmxqzEQIoom3Xe8UhFNySk
	PTJQni8auEdlxSf4KnZu/cwPdiHJcDS/G9w==
X-ME-Sender: <xms:mSWhaiXwof8gUDioKvQBCzcgJ88qpugaa8BoRGnLU-jLeeEKcEapAA>
    <xme:mSWhalk-_zDdpT389zuSuyUQU-QIx3iTfJCAfChK4w7s8ms4bH0cQnaYVYqrz_Km1
    fVt-G2chIrRN1sqund1QX-wW16obFrvtN1ffJ0PeEKivQG4BW0pTw>
X-ME-Received: <xmr:mSWharaPp0RM5RzgaqXRrHu_nSBJa9gc_TIDGgatGJqd7Rpj4GM-9XuWuMSN_1TGzbcxQw>
X-ME-Proxy-Cause: dmFkZTFRkYaBeIOhonHYd0fRWCptJhQCOECbXmyyZvIhjDwA4EYhW8VkKKsRAqzlZfUzTW
    zZxm8nO7cu50rM3KSb2Y3WC/xwvXKsXJIfH4AT0z0fDFkVNUckPME/KMF89RmYHRc+Pp5Y
    dgx4HPzg+TXpISnhXxXwD4+e7ypLA1M5OJbbNT+InscDanRh7hlUeesmwihU2j3IPM/KjH
    v8ScVhJocyMhRfr/y/ZvT5u2Y9LTO84ZcyYpZeBe/ZVFqC8iYblDwOLeURWUpqjcVy7cP0
    inpVhJ0cICOcyzlEPDw/p1xmi9ZxbETIDHT3b6Eg2O45go3yHvSi3ABy+8DWwXJ/5jTQNx
    VerOIY57e2z7fxfBYdxfDOvc2/xURQJ1m3d9VEJaEt/+RSlmqGAgn13fMLihEieekYWRkd
    zn1AEmoGc4mf7OlKOCLQbf07rFP5l5biFxtEOfTAY8yVKNpsJ7bhn0DEVODdIWwvpcmos+
    lV8p49bBHqPRfAPPHmzr8QRO2SwAfnzp3+6Jio1f0ISEZ3qgwSnQt9uiVjVErtzz4DjO9l
    uAgo9ycQxedjQXTjSZv9OUUvSKeqKOdQCO/ZdFK6wh4Czzzi3RcmBYNd10a3LH97+nTZYK
    p2tQUEWgyAH7WWZNtNlhsJAZujt/p0N41hI6gxVKGycMaFUSNLt1o4RbOA4w
X-ME-Proxy: <xmx:mSWhaoPCXe82s5Ww4LVPMMqd4GV3sphUbkldnrftgjfRupxObGcVSw>
    <xmx:mSWhaoa5sr93SUzH6ugS-Ay-iqJCOp0TUod98wdbv7zp01eQ3pXszw>
    <xmx:mSWhau2v5bsvxdVV3S_qwj-LmN3lONzJOQfC5UyMWbyLOocVyJUUag>
    <xmx:mSWhamfpQZmnITixMWMVc9x237l2ktqqfuX25rIqW-CWGolRYZ16ow>
    <xmx:miWham41ARnhLx6-mgbZhj_-zlDaANNd62jzX267Uv-wmRcxWOjEmDSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:23:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8d78e1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Sep 2026 09:23:36 +0000 (UTC)
Date: Wed, 9 Sep 2026 11:23:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/11] setup: refactor how we configure the ref
 storage format
Message-ID: <aqEllv3TicOLB7g0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-8-6733c90ca5b0@pks.im>
 <be1c7560-0da6-436e-8f46-073e95bcad07@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be1c7560-0da6-436e-8f46-073e95bcad07@gmail.com>

On Wed, Sep 09, 2026 at 01:30:55PM +0530, Kaartic Sivaraam wrote:
> On 9/7/26 16:48, Patrick Steinhardt wrote:
> > diff --git a/setup.c b/setup.c
> > index 3be7dac452..38fa5e854c 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2761,40 +2761,65 @@ static void repository_format_configure(struct repository_format *repo_fmt,
> > 
> > ... snip ...
> > -
> > -	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
> > -	if (ref_backend_uri) {
> > -		enum ref_storage_format format;
> > -		char *payload;
> > -
> > -		format = ref_storage_format_by_uri(ref_backend_uri, &payload);
> > -		if (format == REF_STORAGE_FORMAT_UNKNOWN)
> > -			die(_("unknown ref storage format: '%s'"), ref_backend_uri);
> > -
> > -		repo_fmt->ref_storage_format = format;
> > -		free(repo_fmt->ref_storage_payload);
> > -		repo_fmt->ref_storage_payload = payload;
> > -	}
> > +	/*
> > +	 * If we have a preexisting repository we need to verify that its
> > +	 * current ref storage format does not change.
> > +	 */
> > +	if (repo_fmt->version >= 0) {
> > +		if (ref_storage_format != repo_fmt->ref_storage_format)
> > +			die(_("attempt to reinitialize repository with different reference storage format"));
> > +		if ((ref_storage_payload || repo_fmt->ref_storage_payload) &&
> > +		    strcmp(ref_storage_payload ? ref_storage_payload : "",
> > +			   repo_fmt->ref_storage_payload ? repo_fmt->ref_storage_payload : ""))
> 
> Rather than a strcmp, wouldn't it be ideal to do the path comparison using
> strbuf_realpath to make sure we avoid similar paths like the following from
> failing during reinitialization?
> 
>   $ mkdir store
>   $ git init --ref-storage-format="files://$PWD/store" r1
>   Initialized empty Git repository in .../r1/.git/
>   $ git init --ref-storage-format="files://$PWD/store" r1
>   Reinitialized existing Git repository in .../r1/.git/
>   $ git init --ref-storage-format="files://$PWD/./store" r1
>   fatal: attempt to reinitialize repository with different reference storage
> payload
> 
> This matches with how we actually make use of the path at runtime in the
> refs_compute_filesystem_location function in refs.c.

No, because that'd assume that the payload even is a path. But in
theory, it could be anything, like for example a database host to
connect to. In `refs_compute_filesystem_location()` it's a different
thing though as that call happens inside the backends themselves, and
they know what kind of payload to expect.

Patrick
