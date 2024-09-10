Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613519755E
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980194; cv=none; b=lXdlOQLHL6tyX+jRaUbLYvQ15SGCOXdeB70rUZVLVvdcvbjmOShLAwA0txkCpoKD/u9/3HwmxhPu301XJ+pROk7yCaRB9n46fDMoGlum77Z9EpN59buqHBreVeUViai95xh0jSOitwLfLPxI+DWFMsTcAsT1DEdsQQeZh8urE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980194; c=relaxed/simple;
	bh=8o3TZACIhh7gBiFhPF0L/LCXkHCFPRlw0ovnfqfbUJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8dJViGbuDBNknMSVUUbUqZCWK1LiAQNu9jKG388FyKDfGbOhsuJSmsxrqHKEl4YFZk8Akr0GESxQhmfRsq9cTFigbJ7vWMp9XAAT9zv6QoNJxvSqf+7eioYemk68Ou6BJCSrcdhcU250UYivcgkRMljOJLVD2RQqR2JqdqNULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MSNLFlLT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MSNLFlLT"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db836c6bd7so21179317b3.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725980192; x=1726584992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6kUNagZsurT5ZYbxMEkd2VSfHz9CMBYJlcDOVmatFU=;
        b=MSNLFlLTOcWcn1Maj4FLDJURhNoynoj1K4kqsTWBGRNMhOmR9xddK3xkYC8hKvLUNo
         uuBe3PRc9lHr4CdDugM0QUN08FjBTpwMDcmWI/A5MOHB8eDmLO5XGuTL1p/gfi4enCoO
         VIFIZg0xE5lc7iAAe24fOQKN0yzpCX41nMtUYs4h+d1T/T7r472pH6gSfpo9zPejdzFp
         ZExOBZpEseQWuwYWO1LSsxY6G94/w88NGtkJCOvDuqA4kW/mUGM2cGhdDfzCCKHYBPJ8
         6641dBl3YnBZ10WQGvPaqlDnbE313/pJZvqrcanPbwK51gb76Olfe7wo3UZ7KGWnryu/
         4drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980192; x=1726584992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6kUNagZsurT5ZYbxMEkd2VSfHz9CMBYJlcDOVmatFU=;
        b=FUxF6FqxTwW2WGz/S238Jpr1857Grl2s/20MPpyIj3UBjshRoqkvz2wq/2FA+TdMRl
         o4MbudtM5dCDWy0JCpGgZdedmx68C73axdubeLtyTs3w8xJIiG2KH8+taTp33kkmgAzv
         ZoODDC4YhQL0j6v6azIFYTSiwC/p/uSR7qs3I/qy4TJUwm/kTyfFJWrWk6LOh1cBTFNA
         hsKxwHzxBGJqd/MKLrmpngogbA1HG3qme7dBdKFVmKxuXtTOdHZ8MKMxavznjDQJYm0v
         tMg51Wg+jaS5i8Ylu+3v32tOcbQV/yPPcxb+Ar1KRQWve3e8J4Vw28kwGFf8m6s138Y4
         dhPg==
X-Forwarded-Encrypted: i=1; AJvYcCVHOCz0er+BcuxHr+fy4oIkp6FI/XPADNlAf8RF0R5M3UPLtrsSDiK/dwl5oHWrOpevfeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vdP1UawDOzyblv2suK3Ok77dYY2HjtpXYFYKx0+r2bFyu/+k
	NgdZOimDzkbfCkIuKwYd7KSL6MrCCPoqXJ+er+xLkOmLjj+ZJMB3xpd1x9K3maPcuVOOeHqqT79
	mrsg=
X-Google-Smtp-Source: AGHT+IHbkPG2Na3UBVI/yroDb8lJd+FP8b9NBR5/9RR/VelV8uPrisEgBHIUKqivTyW5D0b0gbVrrw==
X-Received: by 2002:a05:690c:112:b0:65f:dfd9:b672 with SMTP id 00721157ae682-6db44da34demr128313267b3.11.1725980191906;
        Tue, 10 Sep 2024 07:56:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db96521798sm3163337b3.128.2024.09.10.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:56:31 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:56:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	ps@pks.im, johncai86@gmail.com, newren@gmail.com
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
Message-ID: <ZuBeHh7uCfhq2XBB@nand.local>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <xmqqjzfkr9b0.fsf@gitster.g>
 <0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>

On Mon, Sep 09, 2024 at 10:37:30PM -0400, Derrick Stolee wrote:
> > I do agree that considering files at the same path from different
> > (but close-by) revisions as the prime candidates is very important,
> > but if you spread the "collissions" very thin by using "uniform
> > distribution", I am afraid that you'd end up discarding anything but
> > the blobs at the same path, which may go too far.  Having name hash
> > value that are close by no longer has any meaning in such a system.
>
> You are right that some "nearby" paths are lost in this change, and
> this can be measured by trying to use this option in the pack-objects
> process underneath a small 'git push'.
>
> The thing that surprised me is just how effective this is for the
> creation of large pack-files that include many versions of most
> files. The cross-path deltas have less of an effect here, and the
> benefits of avoiding name-hash collisions can be overwhelming in
> many cases.

I think that Junio's suggestion is pretty interesting (though please
take my comments here with a grain of salt, since I haven't read the
other series yet, and am not sure how much of this is redundant).

Imagine computing both the full and existing name-hash values for each
blob/tree in the pack. Then objects would be sorted in the delta
selection window by similar full-name hash and similar regular name hash
values.

I'm not sure which value you'd actually record in the pack, though.
Ideally there is a hash function which captures some information about
the full path as well as the final path component, so we could use a
single value here, though I suspect the implementation would be more
complicated than what is presented here.

> > I hope you can find a solution that strikes a good balance at the
> > end of the series (I saw only the first step), but I suspect an easy
> > way to avoid the downsides you observed is to use both.  Compare
> > with a handful of blobs taken from nearby commits (the original
> > object order is roughly in traversal order, and you can take
> > advantage of that fact) from exactly the same path (using your
> > "uniform distribution") before comparing with the blobs with close
> > value (of the current function) like the current implementation
> > does, may go a long way.
>
> Funny you should say that, since the RFC I finally submitted [1]
> actually does just that. The --path-walk option changes the object
> walk to consider batches of objects based on their path, computes
> deltas among that batch, and then does the normal name-hash pass
> later. This seems to really strike the balance that you are
> looking for and solves the issues where small pushes need to stay
> small. It also fixes some problematic cases even when pushing a
> single commit.

Interesting.

> [1] https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

> However, the --path-walk option requires significant implementation
> of a "path walk API" and my RFC doesn't even do threading right.
> The --path-walk version (probably) doesn't work with delta islands
> or other features the same way as the drop-in change to the name-
> hash heuristic can. For that reason, I think there is likely some
> long-term value to the --full-name-hash option even though the
> --path-walk option will be better in many cases.

I suspect that this is going to be a significant sticking point. Not
supporting multi-threading is work-able for GitHub (since we set
pack.threads=1 today), but lacking support for delta-islands makes this
a non-starter to run at GitHub.

Do you imagine that the --path-walk option could be made to work with
delta islands? I'm not all that worried about who does that work, but
more interested at this point in whether or not it's even possible to
implement.

Thanks,
Taylor
