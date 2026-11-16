Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811140;
	b=rQ/BPZIFFyTW/bzlQ7G4bqkweYsvX9Woo7ymoJ0s9JRUPqy3FZk9rCoZJ3u6hIabPf21
	 EhJMQERqE2966x5sC8O4BIk2LHyx0r/52x5PQURJRQJtVz0NZ1JV5uF5uoGPCD51Mv029
	 TG/FfaHt7CKAda0ohktDgEFj03tctiYO5r/KTwrwMuWnw2dx/WGVW25Rz/9CVzDE0HyOY
	 jRJ8HsHdVoaQU/cSFuYGlQvOQHka845bA3CnaYHRsDCIzjiy4m8Iu5QDEGPrjOTd016PM
	 sxFqzwhDt3nx9tkyaj2WyyrNwUSP2rGiVuzRHOEEHEqljKl8EbAs0C5M8t5cX+PmJdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811140;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wkEdHdwK4NHVoDAx6G1FV/tWujsM85FZl+nQcAmZRts=;
	b=3pXxrLNoWlCL1je5QjUq/A3m4FHegr8sHWvp0I0XwAZBVl/pTVJUN3G3bKdnYS4ldpBK
	 U10r/zEz0QFJuBshkGabsHyzK6suUUHyr/er1sJkbMe60kqN0MndI3HfcfsuafqFyf/0c
	 IY1aizMHFZoHOHlt7uA+2WL2mWUbaVgb60CdGIP0B67VrMfSi+hYw2F8QSn75o7zeqqmx
	 tzcHl5xuZNkZgPs5OdU5hMd3bcd/CNvN2lZDa0qaSnulo14lkj96XsXGALtVrZcO4VERF
	 VZL/QGM0lcyeAmiMQY4qLxlJu7h8HBACkGsWPbajxFT1BS3WhIUJFfSZx+6Oh1dLIEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=P1rpwFdy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5lbJnQWv;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF272606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 06:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF272606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=P1rpwFdy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5lbJnQWv
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10C0D7A0178
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:38:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 01:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794811138; x=1794897538; bh=wkEdHdwK4N
	HVoDAx6G1FV/tWujsM85FZl+nQcAmZRts=; b=P1rpwFdy7Y6D4d1JIqOwvMe51e
	DAgzE0byPEKZ4vJZ6pdMJ/iHGrnfRtCiYnsWk93EPDrjN1DAddpJyJaD9DTr0By8
	F7oe70LJWIzn4PQRMfzBVyMqrBVo8a/3SJgAOf5SpIYyTfysB6bbLtQF/ELWrGNM
	eKVg2kuEI5Yx8G/WBvs4F1pu88fkC9jdqjGQcoItvXsb+Oq2/oaMJ+V3OJq3jQbo
	2NXLRSTlrQwsWvw7bmUbHBnNjNCxftLIGpArOLmqrA7G7nQpzYrETqCVV0YG844u
	LOiZC44MnBjizk5Dfgei0LR85w+dyN63drJQwdtNwag/JsEZ3DShf4PAPNGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794811138; x=1794897538; bh=wkEdHdwK4NHVoDAx6G1FV/tWujsM85FZl+n
	QcAmZRts=; b=5lbJnQWvhueYthObjFQgN0JsL/bSUMQrq306s51DZ7JLbMKAmBt
	4C5W5hv4ENySIeCwS8sNOD4vDRlKIJ1GMYiwXQ5GATYUqDq37UwcK9BiDYZLTb7N
	I9ZK+ktafxUYwZH7kL/z66kW/YPjLg9lsenCgKJOjqNbfkR8M88LfvJ9D4ftWHeE
	r5xKPjsdWnb5Y2CJiiA1MQpMCpGc5pUFb1TU4OpkWriODhYXf8WhnQWjqYfTSEjZ
	2O/V0wtgu+RTSNQDPIxlQZqOyiZYCeqscYd8zwlPCCWzX0lvzWwm+FYsyTTXWGjv
	Q5n8Se4osNqegQxXt0RkJYBcvDyYIjsGQUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794811138; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:L30ba7u2bO3rfV5zixks3Zj2qa+4uH8z/VPLwAicg4Iw3GN
	wLhFzHFqod2ktBVL9SclThDKKxnDYHOsbBGabWujyFajK226ld6cfah7Zep/4TEX
	3tFTdFUg6b8S19ySatuaZ/Ut3Co7qT5XxbQ+KCdbRcE45qQNWYLEfiKU7Ro82JQa
	q563JaAC6FTYON7EyCZ+6+qarZXG1NF8D7h+KDEXmVppjXruLEHphHMgrXHC3+TJ
	4VQ1+kMO7quyw4+W0dLJpNDV4cKy0wC8ODdxKYkRX3bXk0B/y7VNvEb/bCte3lf6
	K1up0gstE5GqKEgASW6Pkf/yQtp1QMKBMPnx+EQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MKQcP4RPbydKSE7a+u5MkbCMYg8YIUMHnS2Z9ZBBoTg=:OnIMcaX2k4PRltoxZePkHfz2BI8oChksOo8Kam3xHog=;
X-ME-Sender: <xms:AqX6ariGQpWlJg_i_lX8BDJrDZeYqINUSQiF7ngwyL7fTfircrXZwg>
    <xme:AqX6auBLkOzuL9vNJ5d2tFktDxgillWa3KiYeyGSVSdw1xrMBYq-Ebugdc-pkeQtL
    hMfPOYbTDMRhuCrRKo2ZRSTgxhdu75N2iGMCQ33KpwcSo6zbM_rNsr6>
X-ME-Received: <xmr:AqX6aouEZMQ6ZQZa4zlmuIhf3jzY7zaYV8Vym27J6jVHYwM4F1HD8tsb2SWNwlljjsN7Qdo>
X-ME-Proxy-Cause: dmFkZTF6/33CrSaRjLHD4omcQa/x0L+0kg3QidAWxyDOsYGme3kxyntkPxlJwCQ8Lf7zK6
    tg+uB+ixoFjbOxzyIXS4LHPTLFrq04nv6Uw8CNfJTyJmh4bsPs/eRvl7Un6N12mXWquCcH
    rVWs2fHZr4KGzO2H6xMmwfBa4xP8sP3szwJdvbYhfWWWzfq2yGZAG0LNIsNfN2sO/aPuF5
    6+J/3K26rqppScDJjQij79kJZ04qdK1T9RJztVu84coxgZ2R1/sgpmg96rVNeADdiqvtPW
    iO7XeXOC7RtYbc2PHFKK2pum8e56msfo8lMhageYcEZRu0U19fYUCrhDRPWrxNbSalUETi
    S8oL12ky5NJwcJlEezS2hypsqhwoGSRoWbF/O9ZnsL51be7VR6b1AhPVJ4vWFPXF7hKbKN
    M4/HOo0twJZG4LMfSso12Vl/TykQ43PhAN9JJcDJofY9W8+cnjNlq+/omb/yvI8b6/pGHs
    TFwg59rn/OP6LqZoSOSHYlWgtb+N89uglnABr1mFQpghtyZjh2GPTmeOmW44Od3p5DipCe
    ADdixa6WacLZTAMSxU/8Nj6qUyATa+EmF9cVqAmCfiLqPQac+6bxNeujejo7lPMTUMjuM6
    preTNl3baz0lGRreV3BfOiXAis8gTODyZYc2zTaXm/tBHoR6k/YNgzmFkfZw
X-ME-Proxy: <xmx:AqX6ajaa389galF3RO8zXsZkfpHzJ0T7Zbzdk5VwKafR1wOBZxo-hQ>
    <xmx:AqX6arWqT07tsN011fJHoilw6ejw2rNTDu0B-azuNeKPaJpAuckLDg>
    <xmx:AqX6an44vt1PJSpSMoTyCn_C_8c51akd72QCjPAVmCTVv6nVLzGHIg>
    <xmx:AqX6amj0e4S0y1RT62PTSp34K4KFXG8J-OsX3AaIZCfQZ-XJyaoTlg>
    <xmx:AqX6aiwvIfR2qEQdfSwhxfaN3cZmN6XZoBb_T1pQzmqyty5PzUsw2kr_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 01:38:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b60c67a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 06:38:56 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:38:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] builtin/repo: only parse objects as needed
Message-ID: <avqk_DfxW1uKFXi7@pks.im>
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
 <20261113-pks-repo-count-objects-speedup-v1-1-7ba4f29e74fb@pks.im>
 <CAL71e4NfnYLAXQT-wpb6ciJZwTrT51EZVsEs8VertN=xBmUD_g@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4NfnYLAXQT-wpb6ciJZwTrT51EZVsEs8VertN=xBmUD_g@mail.gmail.com>

On Fri, Nov 13, 2026 at 03:12:19PM +0100, Kristofer Karlsson wrote:
> On Fri, 13 Nov 2026 at 13:50, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > +                       /*
> > +                        * Commits have already been parsed by the revision
> > +                        * walk, so there is no need to read their contents
> > +                        * again.
> > +                        */
> > +                       commit = lookup_commit(data->odb->repo, &oids->oid[i]);
> > +                       if (!commit || repo_parse_commit(data->odb->repo, commit))
> > +                               continue;
> 
> Tiny nit: I understood the comment as saying that the code
> depends on the commits being parsed already, but
> repo_parse_commit() handles the case where they are not.
> Since path-walk hands us commits from get_revision(), I
> assume that is only a failsafe?  So this is just about the
> phrasing.  How about:

Yeah, it is. I was wondering whether I want to call `BUG()` here in the
case where the commit cannot be parsed, as that case really shouldn't
ever happen. But that felt a bit heavy-handed to me.

> /*
> * Commits should already have been parsed by the
> * revision walk, so we do not need to read their
> * contents again.
> */
> 
> Otherwise this looks good to me.  Only reading contents for
> trees avoids inflating every blob just to throw it away, which
> is a nice easy win.

Yeah, that reads a bit better to me indeed. Will adapt, thanks!

Patrick
