Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAD1D356F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116479; cv=none; b=pi+rOif3SHveIo3ODP4Lh7Y80YoOE/xz/JohWUu1EsAHFxcWP3+sVeXHC54CoFfYgiych1rd6XwIINlZO8Vv9qAtsRCtUQ1bwPDhWEdGVkqHKshxKZ/vxOtFu9CGOp/xPXWe539YsguLjPX7rstjYVGc+FkBHRDEY6QwxR6OLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116479; c=relaxed/simple;
	bh=sjgE0r33+RzhFk706/S0Ah8Z12EfHXlweUmcPOv4+NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHYW7OZZDPMiQsxxjANbfBOJA6FpYIL7Um2eAR5K841Yf+iC0tPuoZsV2tn9MPwH4s/5mudswPVQj1nEzIjXIoGGfk1A3rLaw2sibkozAXLNhUL13RG/zhDQzlce7UKs8BO0bvmge0fAo9Suorpn+DYAWWYxiuzfNH0InSBuqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WUK8Zn33; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WUK8Zn33"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso304811276.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729116476; x=1729721276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AySUnXb7E3hJLvYnDNvTZzxR0lYRUAyQNZ5NaBJG9z0=;
        b=WUK8Zn33tYeSlT7YNqsfgYaZeXS+ToD6dEbc/GCqADTA/uBD2cXK10zJI+6fj4ityX
         pjuKRTPVgO/iQij8uPZuNTaHrbitizdW+sblH499GlzVRGZGuvS+NOIfd422OKHd5uHJ
         fM79F8twKLchMXfoNqtbtla2YNbR9buYcs/0uV2Wj4n1Rn2s0i7lHtOWehZJrej/CwLH
         Ct3HvgxYD6ZVOfU3TDIINLwt34LQPN+0foNySOxSk+XzdbUyZ/tzhOEoTOtsxIT1x5PS
         nNdAaAC7xrU4LYbHqk6E1QbT+ErOaoKUZebbfaKqga6qVYjK9t2MAcC4P6QaKMA03Asv
         elfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116476; x=1729721276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AySUnXb7E3hJLvYnDNvTZzxR0lYRUAyQNZ5NaBJG9z0=;
        b=IPire1kkIpb9fInvqScq9uBKyuEfAgkFuwPrr3zQOBB7SvdMy/JC5I6oE9rsdkOs1+
         LsJmQyJGrjZfDptyooAs2yigvc/mMEk2PCtVYQzSu1aqMhovPJoYna7RkBlec2JQ2l8h
         MlugxQ4dta1RxUjuTX+N/fR7H7/uI1RD6PLPx60Cp+K5bn3BmrVtOBaeNOAKeJYHjiLW
         yxF1hUQF53+2U5jyCtkwjUo1+wnOBiZ9kwdiGFOOT8io7hHnuxRTih1PDHmzbpLiSgDD
         9n9soKB4HyerS3PeRd/A4/hSCQ0aS9Gc0giZW3azyhjSfCBxufgovmy0VFkvTcnlGIO2
         Svnw==
X-Forwarded-Encrypted: i=1; AJvYcCWYSE0z2SBzImFZxwK3nYOHFHmB5CiW8XK4RYgk2K9aqC7jDRIWsv7aTfACTt9isOdA/q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljXzxe0uErYgINOjUiD/U1usZx8WzIVmb8sQjkLrGb90fDYPl
	7puCGM/gbNOlOX2oXCTLQQdsxFpr56jaZm9CORBmze/QlOthrIKfjiGwxEu7+1X0pXv/vqMogca
	U
X-Google-Smtp-Source: AGHT+IHwNeZ61GLsM+iB7Zc4q++XV0cwXee4Qh0l95Jq+2vAU7VIAD16e648e8DHjiouQJoMdYuKZA==
X-Received: by 2002:a25:b793:0:b0:e29:222f:ac2d with SMTP id 3f1490d57ef6-e29222fad9dmr14013936276.19.1729116476238;
        Wed, 16 Oct 2024 15:07:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cbfb079sm723535276.2.2024.10.16.15.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:07:55 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:07:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] BreakingChanges: early adopter option
Message-ID: <ZxA5OWL1AuQxA/NC@nand.local>
References: <xmqq7cb77810.fsf@gitster.g>
 <xmqq1q0mcnt8.fsf@gitster.g>
 <Zw9ppbrFqVN5S50J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw9ppbrFqVN5S50J@pks.im>

On Wed, Oct 16, 2024 at 09:22:13AM +0200, Patrick Steinhardt wrote:
> On Fri, Oct 11, 2024 at 02:49:39PM -0700, Junio C Hamano wrote:
> > diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> > index 2b64665694..eeb26c9155 100644
> > --- a/Documentation/BreakingChanges.txt
> > +++ b/Documentation/BreakingChanges.txt
> > @@ -59,10 +59,29 @@ over time. If circumstances change, an earlier decision to deprecate or change
> >  something may need to be revisited from time to time. So do not take items on
> >  this list to mean "it is settled, do not waste our time bringing it up again".
> >
> > +== Procedure
> > +
> > +Discussing the desire to make breaking changes, declaring that breaking
> > +changes are made at a certain version boundary, and recording these
> > +decisions in this document, are necessary but not sufficient.
> > +Because such changes are expected to be numerous, and the design and
> > +implementation of them are expected to span over time, they have to
> > +be deployable trivially at such a version boundary.
> > +
> > +The breaking changes MUST be guarded with the a compile-time switch,
> > +WITH_BREAKING_CHANGES, to help this process.  When built with it,
> > +the resulting Git binary together with its documentation would
> > +behave as if these breaking changes slated for the next big version
> > +boundary are already in effect.  We may also want to have a CI job
> > +or two to exercise the work-in-progress version of Git with these
> > +breaking changes.
> > +
>
> Agreed. In fact, I'd even tighten the last part a bit: once we have any
> breaking changes queued in the tree, we MUST have a CI job that
> exercises things regularly.
>
> Other than that this looks good to me, thanks!

Thanks, both. Let's start merging this one down.

Thanks,
Taylor
