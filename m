Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1C221540
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245870; cv=none; b=W59quGLxBFpApVL06hcbmb67drFU/Lu2a6/+1LolNUouI+x5KRMPUklpoZQo29gzKRFEwVtescVf3VpnGLS2t1S4AmXadPqeWO9KtEg+rm+RHOM6xmb24gDrp7qmzcN+7XLLxMCNscBbzDrIHgvITKzvuucOT1gJ+aL/GwqUVlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245870; c=relaxed/simple;
	bh=pLGLchjOWomh+fzFqOXaG2bTafAqz8ijlsc7STMx9Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrmQoflAlO4JZ+vu43kD/DqKmiXXkVtfF5pVnFVc62PGAZ96Yz9U54JrBVdEFIxR657YmrUoXNDonkvqbZrNAfFtfgaMY6y5PjkJiufD/5mSp7ItYI/pwVwW3yK8lMPi2ryACi38m4ZW8RFRbFe1qdr/+HL7CGlTxdyAuCuk35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VeM3b0F3; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VeM3b0F3"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6443bc360bdso4241579d50.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765245868; x=1765850668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcD3i3uhjMQRDbW/vRAS7fZ4W9SrKX5EdUMA2VRGMr8=;
        b=VeM3b0F3CS6oETpc0i0nCE0u0LstZtEg2bRGAuM2lxVAfgDM1gdR99RTofWSNZgSz/
         7w4SR9gjDSZItrIoijT7hZlboMWHExfcmAC02aBMYhKNe38pJTk4/8N6xcxodHGuyn3z
         TTaL6vfrFV/DSwLSMw8Yy+2BO/n/rPFLTsOxyIqmtXcBLpAkGCP+nFXdkpQOYcq8iTKn
         SLIxtDNTubjV+Oia78pzutZsyrpbp7Lp/2o0NfMks2lEFb6kqzjXUSlro3bSPVGiBmEC
         +UeB5ptsnZXV/fmEgDyrsRJ3ZAOhxufzQMGW/eVTjLAfUdwtat53832E4tIxPdaK5G8i
         +Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765245868; x=1765850668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcD3i3uhjMQRDbW/vRAS7fZ4W9SrKX5EdUMA2VRGMr8=;
        b=qJqvY/UcPZ+YQoPIvS/xph5x8Q2+Bvcp8IbjRU988hK0zZCTe2hHV6seG+v7qr2DeC
         ZfBDgpaCbmOv5CkZIz2AjfsWNCx5StQ3U7sEfrf4xHKTyGhP1rz/B7H4QKnB47SR8vq7
         1RnwEGicmwt3KLoegWx+OUWKVdJ62GEXpATFoAAQsmx7T5hkDfQGwKRHbKYydHKRk7lh
         71JpGNN2CJ4LzzxhLL7P5Ib1opu3akckutbTi05qEDd2fmRYEaDlPcPFS1jWQlgUer9z
         zYkncUgZv29xiLKZ2m+d6PwKaZiTFjMnH2WXDscWKj0TnlKyuuCXpxE4QiJO48gUKSn9
         wAGA==
X-Gm-Message-State: AOJu0YwGOwJsRKgxq5yMegNC3JsE5pqUaaypQSj+wmjD1nqfm5Lh2Rai
	29mAPIazmdnRMP4NEMws+usSE506Jj4vklx9Sa4bl10Alf8Y4pKp/j6lQ2NJ9WxF6BM=
X-Gm-Gg: ASbGncuPoz2cGyV9GinjGCoUFWWwlG2AOZKmsCxvvsK+rhv0dbGFqoOjmiAB+iwjxEU
	T+IOOLjX5KDYWkXKwrKQ2sW/rkRpgFalXWP4khldmz0BOWh35umYbx6In1BqJXGLS1Sjh7u9y6y
	Q5GP5mB7HZCQu3v4tRRlmz6Myc3wFdQNYQX/D+oCOc7C1d08rEiPxk+T0MIgfybQ3G3X8Sh5Zj2
	mJ5H4lykAxaQ+yGMfrCme0QSgu/A/Rnx6AdSsCX+WUWuwFdcLmv7KIlmxXP9F7L8PsTrRjTl/Xj
	wP9O6nUVukaAz89CvwswTBtiVr5E6ANEQPpkI5bXUmBuEXg36EviY+0oBAONelgZVDor3ebg9c6
	vuzxmJrW9+dDt9BL0hVBdgxGZpiGyhC0WXGuozL5koRkhmsptqWJzt+1db7UJzG2TTuic/UvlF8
	vAmascluffw3d4IET2QJj5ZqzhZvYG028z59ri3K2uiucXtGWph7fe6jgIsXbOVN8FiXkR1sHQh
	Pi1eNu9vFqDStxsuqa1PHSIvizZ
X-Google-Smtp-Source: AGHT+IEY7XP9GYzEA3YzTidrPMFar0Mb9ccWzqF10mPENtEWiDbSxm93yQHeYXq8GMR2FgCUAayOjw==
X-Received: by 2002:a05:690c:4907:b0:786:69ee:15f2 with SMTP id 00721157ae682-78c33b1ab15mr193844627b3.3.1765245867707;
        Mon, 08 Dec 2025 18:04:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b779437sm54266647b3.33.2025.12.08.18.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:04:26 -0800 (PST)
Date: Mon, 8 Dec 2025 21:04:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/17] midx-write.c: introduce `struct write_midx_opts`
Message-ID: <aTeDqfOlDK9terAD@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <47aae3bf2a83a2724aecd3314f8cc5d47e8013f1.1765053054.git.me@ttaylorr.com>
 <aTcYXJr_-IxPmC65@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYXJr_-IxPmC65@pks.im>

On Mon, Dec 08, 2025 at 07:26:36PM +0100, Patrick Steinhardt wrote:
> One might argue that parameters which _must_ be passed could be moved
> out of the structure and into the function signature, and as far as I
> understand, that would only be the `struct odb_source`. After all, we
> are talking about options, and a mandatory field is not really an option
> in my book. It also makes the interface at least a tiny bit more self
> documenting.
>
> Other than that this patch looks like a nice improvement to me.

I think that's a reasonable consideration. My preference would be to
keep everything contained within the 'struct write_midx_opts' since it
makes it really easy to pass everything you might need around to other
sub-routines by just passing a single pointer.

So I'm inclined to keep the new API as-is presented here, but I'm happy
to discuss changing it around if you feel strongly about it.

As a reasonable middle-ground, I added a "/* non-optional */" next to
the "source" member within the new structure.

> > @@ -1566,8 +1586,11 @@ int expire_midx_packs(struct odb_source *source, unsigned flags)
> >  	free(count);
> >
> >  	if (packs_to_drop.nr)
> > -		result = write_midx_internal(source, NULL,
> > -					     &packs_to_drop, NULL, NULL, flags);
> > +		result = write_midx_internal(&(struct write_midx_opts) {
> > +					     .source = source,
> > +					     .packs_to_drop = &packs_to_drop,
> > +					     .flags = flags & MIDX_PROGRESS,
> > +					     });
> >
> >  	string_list_clear(&packs_to_drop, 0);
> >
>
> I think this syntax is not allowed in our codebase except for a test
> balloon just yet. See aso 9b2527caa4 (CodingGuidelines: document test
> balloons in flight, 2025-07-23):
>
>     since late 2024 with v2.48.0-rc0~20, we have test balloons for
>     compound literal syntax, e.g., (struct foo){ .member = value };
>     our hope is that no platforms we care about have trouble using
>     them, and officially adopt its wider use in mid 2026.  Do not add
>     more use of the syntax until that happens.
>
> > @@ -1774,8 +1797,10 @@ int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
> >  		goto cleanup;
> >  	}
> >
> > -	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
> > -				     flags);
> > +	result = write_midx_internal(&(struct write_midx_opts) {
> > +				     .source = source,
> > +				     .flags = flags,
> > +				     });
>
> Same here.

Hah, I even remember checking to make sure there wasn't such a test
balloon and then thinking that I'd need to adjust before sending. That
must have been just before I got up from my desk, and I must have
forgotten about it until now. Fixed up locally, thanks for spotting!

Thanks,
Taylor
