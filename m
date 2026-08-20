Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E4361974
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217207; cv=none; b=SxS5RrEyU0o4hWor5CPGMg5YYrgRPnaR01OZOBxxanFq5SJ/CnV9IzYmx6yOEvyE9ObOxNo3sdL0kPX4Yo9V8+pcDdmLDUBTYap8JHm9+0/Z32m/3xw+/qMaLnBf71nlrkhBi3HvHxlL3zKQjP01XulyXGl4TIpGDVDVK6qRt+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217207; c=relaxed/simple;
	bh=7vQ84vmuPGfpVvGx/V+UIM+r39FpF401QTZxDy1dkCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7rhCMa3ZINmyPQWoQY2FYtfEF09IuPFLGhaSWy8HbFrYPxrpoEMXlU9CNp1UGnmeMO2QprTSKSQnb+UDq+25EFnVMOzXFbXhQzmd1bJsx2NCvbJpbMrpQfJ3S4PTZqubleaouyN1QBjZEche1i28RPqFAbjVGAybFiHcGsnRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hRpWNBdZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ott2pukm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hRpWNBdZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ott2pukm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41CDE14000CC;
	Thu, 20 Aug 2026 05:13:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 05:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787217203; x=1787303603; bh=4yHpTxUwcU
	XibWOMu8FXoDmv2Cndf2D50mujef9WFHQ=; b=hRpWNBdZexBIDKEyJIheuf6qaI
	IHrUHBU3ykRjtpXqFANfGR3URmAejdKODu+Yz2N7CTIr+Sw4/74GgKBJmFYNVEmp
	HqsMZNAkIMbp0H/54OcCZCEkV7iPKpkiVHGn4FnHS86xj4RN4Ux4biNb7t/42n5V
	PavV05Oeqpu7wH9Xch60gyA4nex4R3HtRwVz8oaE5xiigPSBSscjcItptbJ6XpJr
	NTasVDeClePD4C4f64SiZjw/ZkQ8BslsG3Yu/o3figr6z3NtjepvDerj1Ysf/nfV
	dMQWO3T58R33AsrqM9mLKGnZWJQ274OFQuA9+5CIp1GKmHQwh60KmBU1ZU+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787217203; x=1787303603; bh=4yHpTxUwcUXibWOMu8FXoDmv2Cndf2D50mu
	jef9WFHQ=; b=Ott2pukmNkB0/xnJPULTZ6FIuh/qqTksjp8HSwzXNEvJqKZtCJy
	UK7cMyO3NPazExO9cjLfmCdzEdbS9wPDDDnHEUYwIEQAL8xiNimcBVQSCKavoVwO
	4DAi+HJOuoHRFZ5qjAqUFqnBLVBisvX1Qz4clWYM14k4QRXyeolmer/B1KTiMkxF
	Qy8jyNZafhZbPXM0ENWShwBbUsi4z0RTzpoMjV+7kT/iy9Oix5eZnQDyxufDhPI+
	XjKxO7vL3HJEqyqQ3p27pdsRjUyY1uRSm6Yv3dylsmFK/P6wR+Ci5NMS2tVBhabg
	tM7ovGF8c3/l9QCjZnpeJMWqdXqA/POWkCg==
X-ME-Sender: <xms:MsWGarmjF-zZ2yMF5Hgdo5h4LLRIYFzfh0JasoqtqQY3NFvsUWapDA>
    <xme:MsWGal2s44JJDsW3BLet7otudhPc1IY6Ub7lcfSk2OkNZkwNCxuNScK5xH-TZqtoq
    V0hMjkhyjpobkbwFCgA3PFgmM-bt0zT9Zo7vlGiatirv2jabH1Dvwc>
X-ME-Received: <xmr:MsWGamr_cUH26330SHbg7JvhpO69qPMAkp0M2vZdL7BcEZuMoic_6qzb9bprg3fJwyk2H2icYa1-3qCUF97yj5_ZTeFf0ipH6xJTo0-Q9Q>
X-ME-Proxy-Cause: dmFkZTEETB6x3HPxJRILDnZLS7Oyhai6wVui9gsL06wlxA+fkwuxw2N5Z5PJZENMQZjUHh
    5OEtYVsI4iN3tIL6kAbvdpSXMeKlqGtXcosZCVSjKH744PULebfc3yx8G16eflwQ6S35/E
    O10fsvQNBNwbFDmi+0Ma+TGdK5QSsw6XyAF/TghHjOhcDFJtDYfRPzu7PMO/8+eQwGNjkd
    q+rlJgPiO0A75e+f7CrQF5tzIsSa2wJtUncOpCP2+sp4e4uIy3PjAK4A0LzAzijMG/s0az
    QjL4/C2k2C21uM4ltm9RqMpXsFSA+MfEqAIxhzJCsMLMPrNzYaIm275J7+O31KVCtFFZez
    ZZXD1CWO4X9v7UAqBAHwvgTCft0p8R35tpDwXxCUlR05BURwj3mFR9f/C14G8/pEFpEyJY
    thQ5HiQ/R6gx/p4G3hxSyqpA3cFEmYPut2OI3e+jUNuqC3gt64mdm5CyslQ5CAjyPCHjEQ
    RJrBrTR8ttfnQKPReszzIO1ABfuVAqU0A1cbFefNubRKcjNRUeuxKGN+J7C3crQhZMF3lg
    cGGy0/22U8uqUuABMMjVrIj/oovB4fl4EYwILCpuS7U+KJAym+E5vEZnNpJUOdBNT4c0AN
    S/0oJNNj9fpVy6iBhm7UfYE6/wnxJCLChj2DooKWaYo2030zqKLz5VsNXNsA
X-ME-Proxy: <xmx:MsWGaicK24Pt80Bv5bowvNjpK3ugGlbIktS-bSePpvZg7T_QS5eONw>
    <xmx:MsWGalqSl8oZ-OX8C-YLvcQ_ZLlP9UG6rGs7XUz5hJO821lfzkpklQ>
    <xmx:MsWGajF6lLWxaJwAomoW_exAdznMu_9QjMK3l6z56DZ1iOwo1QVr0A>
    <xmx:MsWGalsgF2EQqgaH_0MibXgOQcG0F3PemFOS3pPmNBqZiwvl94L0gw>
    <xmx:M8WGamkiBp_U64hp__aeER-NcdKYN9cBFq2kf4VVZr6Wm-DVe41hTy9c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 05:13:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b0cfca5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 09:13:19 +0000 (UTC)
Date: Thu, 20 Aug 2026 11:13:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: friel@openai.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
Message-ID: <aobFLJuiuM1EuNpv@pks.im>
References: <20260817233914.8740-2-friel@openai.com>
 <xmqqo6f02q2f.fsf@gitster.g>
 <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
 <aoaTjWMSO8og_iFw@pks.im>
 <20260820082102.GA2973952@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820082102.GA2973952@coredump.intra.peff.net>

On Thu, Aug 20, 2026 at 04:21:02AM -0400, Jeff King wrote:
> On Thu, Aug 20, 2026 at 07:41:33AM +0200, Patrick Steinhardt wrote:
> > On Wed, Aug 19, 2026 at 04:28:10PM -0700, friel@openai.com wrote:
> > > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > > index 1ec5b6f206..252530172c 100644
> > > --- a/builtin/pack-objects.c
> > > +++ b/builtin/pack-objects.c
> > > @@ -1389,6 +1390,8 @@ static void write_pack_file(void)
> > >  			display_progress(progress_state, written);
> > >  		}
> > >  
> > > +		bytes_written += hashfile_total(f) +
> > > +			the_repository->hash_algo->rawsz;
> > >  		if (pack_to_stdout) {
> > >  			/*
> > >  			 * We never fsync when writing to stdout since we may
> > 
> > I guess the addition here accounts for the trailing hash written by the
> > hashfile. If so, shouldn't we also use the algortihm that the hashfile
> > uses in the first place via `f->algop->rawsz`?
> 
> Perhaps, though that is used to write the hash (via CSUM_HASH_IN_STREAM)
> only in two of the conditional blocks. In the third we finalize the
> hashfile and then use fixup_pack_header_footer(), passing the_hash_algo
> directly (not even the_repository->hash_algo, though of course they mean
> the same thing).
> 
> It all works out, of course, because we created the hashfile struct
> earlier using the_repository->hash_algo. So I think this is mostly
> academic in the first place, but your suggestion harmonizes two of the
> conditional blocks while creating disagreement with the third.
> 
> I think something like this would "fix" it by consistently using the
> hashfile's algo in all three blocks:
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 4a5fcbe5f5..0fdff72f41 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1413,9 +1413,9 @@ static void write_pack_file(void)
>  			 * If we wrote the wrong number of entries in the
>  			 * header, rewrite it like in fast-import.
>  			 */
> -
> +			const struct git_hash_algo *algo = f->algop;
>  			int fd = finalize_hashfile(f, hash, FSYNC_COMPONENT_PACK, 0);
> -			fixup_pack_header_footer(the_hash_algo, fd, hash,
> +			fixup_pack_header_footer(algo, fd, hash,
>  						 pack_tmp_name, nr_written,
>  						 hash, offset);
>  			close(fd);
> 
> 
> But there's a subtle yet interesting difference here! f->algop won't
> necessarily be the same pointer as the_hash_algo. If we compiled with an
> unsafe variant, that will be used for hashfiles. If we're just looking
> at rawsz that's OK; the two variants should be identical (other than
> performance and collision detection), so taking rawsz from either is
> fine.
> 
> But fixup_pack_header_footer() actually recomputes the hash (as it must
> if we tweak the header). Right now it does it using the "normal"
> variant, but we should be able to use the unsafe one (which my diff
> snippet above would start to do).

Yeah, I agree that switching over to the unsafe algortihm is sensible.
Being able to speed up hashing of packfiles was one of the prime
motivations of introducing the unsafe variants in the first place, so
the fact that we still use the safe variant here feels like a plain
oversight to me.

> Of course this whole thing is absurdly pessimal in the first place. If
> we are just going to throw out the hashfile's checksum, then why bother
> computing it in the first place? Because we don't trust a disk write at
> all, and actually verify the original hash computation as we read the
> bytes back in! So we'll actually sha1 the written packfile three times.
> Yikes. I wonder if it's really worth being so paranoid. But that is how
> it has always been.

That's... awful. Honestly, if we cannot trust what we're writing to disk
we're going to be kind of screwed anyway. We don't re-verify loose
objects, refs or whatever other data structures we write to disk either.
So doing this thrice here feels wrong.

> Anyway, that is a bit of a tangent from the patch in question. I think
> either spelling is OK for the purposes of this patch. If somebody wants
> to pursue harmonizing the paths (and maybe even doing some timings to
> see if switching to the unsafe variant is noticeable here, and what the
> total cost of this triple-write approach is), that can happen
> separately.

I agree that this is definitely out of scope of this patch series.

Patrick
