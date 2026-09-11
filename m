Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33047126E
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129422; cv=none; b=i6XOZqibvKqnh8z6PE8ThXXe2VcqCm2gVfEpTPO3PTkHCdMFcJG19TzuY7edkU4r9FPJ8pUb2mt4Rvd1s/wwwJIb1AWW9yQsFSjFxzLHr6JeQ7F4T7VA2OBb9hOJpvizlWM0XH4TIREtqkEOrAh+GokWYyyISVLcpTQeoq06ZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129422; c=relaxed/simple;
	bh=l/8DqVcqdBA4t0CfAQLG/QQ0XFTz0dTZMlpHEGAgbIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lctkDbFM9vK+ZPy+i7jK8lpDaZGwLAN8w3hQ14pOUzvG5APnMrwETwwmnPyhBoI3lo3f2DnVl7ZnbvjCmHyL4uk6TZNfoXpxkeicPYtCTV3Wc7PsWju2v/n+MOeYLopnfOVCL4eCpME1eaaDstR/afaaazA8rugOmRcLkTQv0zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U1Z19Zl2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=akMuEJjK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U1Z19Zl2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="akMuEJjK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6289BEC0282;
	Fri, 11 Sep 2026 08:23:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 08:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789129416; x=1789215816; bh=xZbQHPEsvo
	HXacFgsdUsbdW/kZsB2r51kMDxHpykPUo=; b=U1Z19Zl20XeO5+nbzgNiojLODV
	YVeXnfTRhNBYt3lzDV9+M3JntHizQ4sNEsgJLKIbXoTGi1KcZLKqXTzASRhdLo5+
	xgHLF33P2OmIMlYfJFbJrt7A+aVdbS4/th/DzCAO0mfs7hg3jxbV9B1VAK2fu66j
	GQkFtOe0X/vcIxXlDvKn3VZ9fMm0pw+hJyFurI67rv1t6wxtyp+RA4q2ylkuKUg4
	BuyFbetup6Jy389+203mwhOMlaiSZtGKL5x831suY5Bu/OTiEqcUB+Q0TxPLy5XW
	BYiljOY+eMTD2DVmWUrE9LskOAukBbzCAXcaSO2GbaBMWrYgalTqi8QTt9AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789129416; x=1789215816; bh=xZbQHPEsvoHXacFgsdUsbdW/kZsB2r51kMD
	xHpykPUo=; b=akMuEJjKwp6BvAz2p2zN6SJ0cqFrxDZdy+c0/RQ8oQ3t+3XUGZt
	4vyYWZbs8CweWtPl82J1s+W8vAaSqesmlUxmqNmadOqG8HUPwLN/PbwXup4Gnz3J
	fb/V5ypMKdlYsGJQDIG4a6TtgQyHXTGC0P4mgdEZnArh65cUhdQWJ4O3w7M2EHed
	HwNFIhb7bE0z6ehUXj8X064RWKh63n/9Ij2mJf2kIozoG2Hq+QSgG+qok1BPAP7o
	rSidWy3qI/nqQ41+s0w4yQ8Q47PhaQSu0H/oqJ5vNGxU0p2aMH2/Yb7wow7lcWTq
	MuXy5T/+s5QJh00y/ueQJRcXpNsiO/IUaFw==
X-ME-Sender: <xms:yPKjamWk3gkHE-ba8ztUBN45QecP9YxlmXRLdS-9eSlul0q1xgdjXg>
    <xme:yPKjal3FGJMjUsKF9LCW-7XYUJoa2w8VbgyzgN2dEvktegX6UY5gGidH9zvlA1TPn
    OhTgVrrsz6dqcBVJaTpCjgq8BgcFdd33sKnIrHKLIdzDhlW14pGijhe>
X-ME-Received: <xmr:yPKjaj0aZGNCHLctasCdszfhxxR4KkFt2m5T97hYZn02SMdOqaX3RdIBoJN2WAntVSJEpA>
X-ME-Proxy-Cause: dmFkZTEs2iWGcBIV73ja450eg0sA2ip9PEUESkIlRLNRh12zPgwIVaiYFaWkdSxPB0XeO5
    z01WQRjzBqWJ5uEnUzBnFdh9O2t/XKjAW0OcFG8FSNlM6DzZRH60V4Av4LHxvhcBNjMGwq
    70eSEC0ErG22FZRP+mlefetcu8w524ygWWByeTdfC/4YO97H+pfAbUq3BM7JvRIZBa0XHt
    qK6e4udGS+bSnOuzInP/QCubd81Wavn1vbUgpdAuH0GIlvhefZtsyEQLD2hiwS5UpHIqJ4
    2e4CCFWoHxczWUfodix5K1PEitNRmtcoUYSftxOK4txds88YEQ/L3F5vnoYkmYrT29KxJf
    dl1nF/NdMe7ekgeV/Lvfsr7TLlXsov2eZZD2gBTtuyfMoLXOzcblCbpGUFVEGs6t1fTw+D
    YPiRhD/d741SPj52P1ctwhjjHuuA2xWcysHNmfNAcffAoimtVFhWKT1uSsfd3Nxp/a0Zfe
    uO9vlGjn6gSxe+YkCKy1Fo+nvP6ckRjALhJplbxmHAuYibn8zbB01zI0GE9zdBAwVsHwM0
    IX45M0BPyBNtXDdprSVOiIyDcyGaLw0+rRGea1VNYSbQJSWv9U50Dim8ZpFDZTAq9FLOAf
    eTGzauLN7Ty5TY6noxHqqiGmchMdFGUPz6giyRNKvutZQWrt0Ice9KS73Nrg
X-ME-Proxy: <xmx:yPKjao91z8GW4Z6fTzGuTHAKYfEiXkgTGTubp50JM7coGrd-NtgY4A>
    <xmx:yPKjag0JWVXAIgcTAc3NX55KsXZbqwjJRLz0O-MNmlT9TSm9iPWLJw>
    <xmx:yPKjal-S2WBRPO72lcIfBk5kChlhFQwoujVNq52xolnBaEw1_bpsEA>
    <xmx:yPKjagtt52oelhJRVQQTVbx1eRd2BH7CC9Aiy-HV1CRtXfICZoj8cQ>
    <xmx:yPKjaiew-XYFbKZ3mGqR1Brg4OQWvZt7O6pZ6AC2fj53FH4Xm-UYqUmN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 08:23:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c47adaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 12:23:34 +0000 (UTC)
Date: Fri, 11 Sep 2026 14:23:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/10] builtin/fsck: move multi-pack index
 verification into the packed source
Message-ID: <aqPyw2mHJ9kt-xna@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
 <20260831-pks-odb-source-fsck-v2-9-f9b16ef4957b@pks.im>
 <877bksnior.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bksnior.fsf@emacs.iotcl.com>

On Fri, Sep 11, 2026 at 01:14:44PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > index 2b5dc502f5..9f42552377 100644
> > --- a/odb/source-packed.c
> > +++ b/odb/source-packed.c
> > @@ -14,6 +14,7 @@
> >  #include "packfile.h"
> >  #include "pack-bitmap.h"
> >  #include "progress.h"
> > +#include "run-command.h"
> >  
> >  static int find_pack_entry(struct odb_source_packed *store,
> >  			   const struct object_id *oid,
> > @@ -897,6 +898,29 @@ static int verify_reverse_indices(struct odb_source_packed *source,
> >  	return res;
> >  }
> >  
> > +static int verify_midx(struct odb_source_packed *source,
> > +		       struct odb_fsck_options *opts)
> > +{
> > +	struct child_process midx_verify = CHILD_PROCESS_INIT;
> > +	int ret = 0;
> 
> I don't see much reason to use a `ret` value instead of using early
> returns instead.

Fair enough.

> > +
> > +	if (!source->base.odb->repo->settings.core_multi_pack_index)
> 
> Because we cannot ensure where this function was called from, shall we
> BUG() if (!settings.initialized)?

Good point, but I think it's preferable to call
`prepare_repo_settings()` instead.

> > @@ -912,6 +936,9 @@ static int odb_source_packed_fsck(struct odb_source *source,
> >  	if (verify_bitmap_files(packed))
> >  		ret = -1;
> >  
> > +	if (verify_midx(packed, opts) < 0)
> 
> Any reason why you're checking negative value here and not in the if
> above?

Not specifically, and in theory both could check for `< 0`. But I
refrained from doing so when moving around `verify_bitmap_file()`
because in the preimage we didn't check for a negative value, either,
and it would have thus caused more questions.

So I think I'd leave this part as-is.

Patrick
