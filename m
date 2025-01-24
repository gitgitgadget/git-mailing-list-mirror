Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116D156991
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705090; cv=none; b=p8MEpnG1bD44+hotjlVJ9Q1oQYHto5K5T0LcWQZNNTm1HHg+tkEqVDNOyYUsiAPSO2r0KfyJbVMQMhwMTTWwj5SZHdP2BOecgHgsNNUnWL7NuST3OqCwuKej/Q/pa89CB4AtIlPLdBjCpvWpNJJazLnIC1SN0DGiw8839lW/P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705090; c=relaxed/simple;
	bh=qi6Nr+moyy7/v+eDgSgcf9GGpBm44SlqFCTR28yttvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9MHiCSjwJb1m3PN/Sm0b90ER01CeFQQWrIyUmwG7cHKGKZ2775u4n98duLG/ufkr8E8p/A3az+XpXwaTg/yI1EOxREAXQoMaOb6N/q1odHnVHD+wMmigIaCsjl3Si47lqI+WsHaGRB1PT94Pz+n12uQCJNjhe+nKWmPPMWZSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gKY7gMnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5WRL6UR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gKY7gMnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5WRL6UR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1959B2540192;
	Fri, 24 Jan 2025 02:51:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 24 Jan 2025 02:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737705086; x=1737791486; bh=61zjm409Mg
	91hpR+zC/b1TEK/ZYpBBrZyEo/FVLrLjs=; b=gKY7gMnclU/hKdv0sJO7hq80/R
	v9ljNrJJdnkQWNYp44kFtX/tkqGTYsSk1sV1O/8rAJOhnHmjIwxoGB1o2Ronddtv
	XtXbxKjdlnDo6UdnQA4dabzEkQu00oTLdmYwZ0xOBxTwvyW3+GHKXr07gnvfyEub
	YQOrItY/9LlgBZiVCiQZS1GxQp5hW5F0NY+u6PR+Dm4MQFogKexjT+hwUqGQhfMU
	A1bl/8lfIKKhWLVPAtH3/DBVMbLCYuNls+kKaP061A7ZtwxZD45eUSIDrXSYeza2
	siVYzDCKm3GaxXM9/V+RGNk838yuszbVq4u55pqPKGkx8t/i1w8a7yGfL7YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737705086; x=1737791486; bh=61zjm409Mg91hpR+zC/b1TEK/ZYpBBrZyEo
	/FVLrLjs=; b=Z5WRL6URkItpe/ZuiCXCK+eeGSKPNUmzQfARb16Sd6ZtPf9Ujnf
	GAPMLlSXsq8kQLUnF9JQNTwQhCTa8nuqSa4cs5zigZsK/tpRpD5BMGazIspOZB2r
	qmJVpT+Q/oTPaYlFAsezTbDZEtshI0b/dZaLNHjTmCZsHajW0o9QAdKC9GtItHZn
	+0TpUf5kpnBJmkrE6ywNe9sIyIRLOpnf/wfKff/ac6sOxiWCtIXmXrFE+Fmd0vry
	5KTo0TSSCKER4A+C1Ypqa3slYV9E/dUIbsN+WStImqlt3hir2QKF38rT9+QX8ns1
	elFZwSaUXFOnAVtSBC3N9GQXTufeCDokSpQ==
X-ME-Sender: <xms:fkaTZxjnKB4Bwhl4m54M_p-vcUQGIVuUQDB5AXCN-mPN1RH4rfW3Uw>
    <xme:fkaTZ2ARILl4StKS_TriVirxHnv2ppumCYEVZeakN9nFrTp-CRL07EzKJtf19bH1K
    8e3dQqxbGo3218G7A>
X-ME-Received: <xmr:fkaTZxH-I96rfcJCLd_3JMTTXcmk4NLMA4HydYSrW7usZ8gnUbJ4FSJL2KexDnJdwXm8U-TEqOXgOwZC0M1TvUU4_8_0oJ3f87RO-xvUWytm0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehmhhgrghhgvghrsegrlhhumhdrmhhithdrvgguuhdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:fkaTZ2TfJSaPEbMFtEt0dSvaRb9K5Ep-4Dl-yMaxXvRwkOGY5uG-9Q>
    <xmx:fkaTZ-y5Ryns9beHlSteHu7MEU4BTTJgqqpMlllJlq_kIOwGpLV7UQ>
    <xmx:fkaTZ87NCpOJopF8AO_U6OgE0eEHLf4tq0e3_ogUKxtKnHYnvAgCXg>
    <xmx:fkaTZzxGBiH_s-E5vvA5584pr8NOEOW8iNVYXZs4qApl-l1uXPD2Yw>
    <xmx:fkaTZ1pzOMq5Ky6BC5AXIGyUL-l9xRvRQUvTVrpKK_vrz5rY58kk8slI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 02:51:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de530cc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 07:51:22 +0000 (UTC)
Date: Fri, 24 Jan 2025 08:51:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/10] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z5NGdXJtUngG478V@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN8U2VbZBnUSWj@ArchLinux>
 <Z4kQUb7og2Ce1iCo@pks.im>
 <Z4pnyhF2V2ykuHlg@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pnyhF2V2ykuHlg@ArchLinux>

On Fri, Jan 17, 2025 at 10:23:06PM +0800, shejialuo wrote:
> On Thu, Jan 16, 2025 at 02:57:37PM +0100, Patrick Steinhardt wrote:
> > On Sun, Jan 05, 2025 at 09:49:37PM +0800, shejialuo wrote:
> > > @@ -1779,7 +1867,24 @@ static int packed_fsck(struct ref_store *ref_store,
> > >  		goto cleanup;
> > >  	}
> > >  
> > > +	if (strbuf_read_file(&packed_ref_content, refs->path, 0) < 0) {
> > > +		/*
> > > +		 * Although we have checked that the file exists, there is a possibility
> > > +		 * that it has been removed between the lstat() and the read attempt by
> > > +		 * another process. In that case, we should not report an error.
> > > +		 */
> > > +		if (errno == ENOENT)
> > > +			goto cleanup;
> > 
> > Unlikely, but good to guard us against that condition regardless. It's
> > still not entirely race-free though because the file could meanwhile
> > have changed into a symlink, and we wouldn't notice now. We could fix
> > that by using open(O_NOFOLLOW), fstat the returne file descriptor and
> > then use `strbuf_read()` to slurp in the file.
> > 
> 
> Would this be too complicated for us to avoid race condition and we will
> introduce a lot of code to handle above logic. Because there is a
> possibility that when finishing reading the file content to the memory,
> the file could be changed into a symlink and we cannot notice. So, I
> wanna say we can't avoid race condition totally. It would be good if we
> avoid race, but what I am concern about here is that we would make the
> logic too complicated. So, could we make it unchanged?

It would ultimately only be two additional function calls, so I don't
think it's going to add a ton of complexity. Whether things are changing
_after_ we have opened and read the file is a different issue, and I
agree that we shouldn't have to care about that case. What we're after
is whether things are correct when running consistency checks, it's
always a possibility that e.g. the packed-refs file gets rewritten while
we do it.

Patrick
