Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008C1F8753
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339961; cv=none; b=peoZceqjMXh+qMvkzKGSUZ9Maeo3eXTn0EJ/B0srJxFh7H3JCWN3usOaczzy+npr7RWDyTKEEZYCbriKc83qKmpqLlKRTYWQWrAv1uelxUrTzovmdvPfAvNNIy9GhbLr33lHGAXJeBjCuXLqVEICwAS/o9zuVvMir0tlLq7ULQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339961; c=relaxed/simple;
	bh=TT55GgDrv4E9Xmljtw+3Thh20KsoZANSphR89ccbXGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0cwS85IeEGcuUwKeLiFQpqtHikggVtW6kVLPMuJjccl8Nounh5FT6r5xq65gAGx1Lbd02dsrHKuI9LejKcvuKiI6nTq70jNrVdEYyEwHs6vgIpj6C1yRunsJlUol6DGizkKm0JrA08Fzg3i1spDm+W00vb949ta0YQ9LHcEAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=a5Ux7Yms; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="a5Ux7Yms"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8efefec89so53188826d6.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742339959; x=1742944759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMkyeUhr2XlfFpYN4iyDUZp6LKk7F+Y9jKR3BVdsGJA=;
        b=a5Ux7Ymsq24SwHE40Xnm6LAk7vxhKnQR5c66ADW34rIh3TvuNCp4Lc6deZOSSdvU+V
         LlVVIxnlDXLgCUxga9G+ZzzqY6toUjNpa4GA4xX4LEfnz0nfajwJcP5kZMb2vxh3vkvL
         qBsN0wF8t4O28LqL4ug+EWwxgCJ5E/RIuomv99ipq8jb0aF8x80xGFYtyQ1wCw5uDifQ
         fGE1ytPIb466LXkKmq5uQQMehMefFG3XmnCqHJUYMZw9HpnlKR8ZJn88YEICYqNlGMtg
         N7lD87KjB2DKgoIELCUFA3BWyloNqP25zSs+dbRPb+Ico3B6DQbVMmrL6dN99M28mkB+
         FJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339959; x=1742944759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMkyeUhr2XlfFpYN4iyDUZp6LKk7F+Y9jKR3BVdsGJA=;
        b=T1OAlcltSJMFbPNZRTADYMl4gbw6tlltulhUGI76JdJV4oQUhk9hxRU4zm4bR2iVJX
         KLGa3uoZmpVY44E2tEQJP7oTea9nxA1ynWpKSUNSQFeunF+tcpGQMm0IpNGzpAmpJT98
         Chxmlykum2BsnwOgg0QpBpXe1yUYdYnjqTNQeCRt03Msfv/vWJpnEikEhb2sWoT+1e8f
         9fASCmCzu9ezGsBgOzx2OuLXjn5NaKGagNfarKhkvYevSzclNbONZZpcL9/AO9WFd0NW
         Sdtr7jvcG/zYnTR5vGPDbQjneFsxK6BSY6awhdAbEy7MIrctMVHar0ErW7wOnG+/MqFa
         yTqA==
X-Gm-Message-State: AOJu0YzcJLldcfCQt8kkDuJw6USmhBXMV3X8/FvDZxc5UMqs6fyLtDHE
	Qj3NxhLOGfl/xDvJX6LzSTcx/uKJXamFnGN8SAow0UJGlAvhesU6PN7YeoX0M0c=
X-Gm-Gg: ASbGnctZE2jNJtDWvAlKYQhkms3KfLCxOHq+Y/q67xGFqhfYSc+KgZMbgx6LzrcHrw3
	Kt4ovBm2XpdWq0Xh8kaw0Qa5vxW0rg2xgwhJY63aYnFJ+gMJg3Az3CgTUDhxhVAuoton0msMcJw
	sbgUibNOHExWOveaZCtRC36U6j8b+nhfkYm21nQ+p5cmQofJnJ4aRBeGe8oRbpa1B3eMYUfi3JD
	VDiHjPuymyfzZixnHhuncQleHMCxAmC4ksDSUqKFXkAIV7ymzpv2pNQ/n5k1R6GRgjbiEblw1ax
	o4NVvpBF+GLhq2Xqwy5CF6OKFY/zCcQTGzxDCnoJh13KwgEK0ZBit6RcU2sruclESu00MV3WbFx
	/myMxucdPtAVtozLe
X-Google-Smtp-Source: AGHT+IFsb9A4xr8OmiCWgBFkx/oeITpcJnq99XiyorU9wvbEr1R23w9pF0fkw2gq2zkfhHxPPQwXwg==
X-Received: by 2002:ad4:5bc3:0:b0:6e8:fac2:2e95 with SMTP id 6a1803df08f44-6eb29289ffamr6573946d6.11.1742339958751;
        Tue, 18 Mar 2025 16:19:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade209cd9sm72700006d6.14.2025.03.18.16.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:19:18 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:19:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 01/13] Documentation: describe incremental MIDX bitmaps
Message-ID: <Z9n/dX0HSjkC9PMd@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f565f2fff166bdf4bb2505f4a8853215a5365b17.1741983492.git.me@ttaylorr.com>
 <CABPp-BHMSs7R1kufM6f0PQDBAoPrOkKwnKK+hA+sK72LFLzCCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHMSs7R1kufM6f0PQDBAoPrOkKwnKK+hA+sK72LFLzCCg@mail.gmail.com>

On Mon, Mar 17, 2025 at 07:42:54PM -0700, Elijah Newren wrote:
> > +In the incremental MIDX design, we extend this definition to include
> > +objects from multiple layers of the MIDX chain. The pseudo-pack order
> > +for incremental MIDXs is determined by concatenating the pseudo-pack
> > +ordering for each layer of the MIDX chain in order. Formally two objects
> > +`o1` and `o2` are compared as follows:
> > +
> > +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`, then
> > +  `o1` is considered less than `o2`.
>
> For sorting order, 'less than' doesn't tell us if you are sorting
> smallest to greatest or greatest to smallest.  Maybe "less than (so
> its order is earlier than) `o2'" ?

Oh, good suggestion. I found the alternative a little verbose, but went
with "sorts ahead of" instead of "less than".

> > +
> > +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and that
> > +   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)` is
> > +   preferred and the other is not, then the preferred one sorts first. If
> > +   there is a base layer (i.e. the MIDX layer is not the first layer in
> > +   the chain), then if `pack(o1)` appears earlier in that MIDX layer's
> > +   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
>
> s/than/then/
>
> > +   appears earlier, than the opposite is true.
>
> s/than/then/

Good catch on both accounts ;-).

> > +The structure of a `*.bitmap` file belonging to an incremental MIDX
> > +chain is identical to that of a non-incremental MIDX bitmap, or a
> > +classic single-pack bitmap. Since objects are added to the end of the
> > +incremental MIDX's pseudo-pack order (see: above), it is possible to
>
> drop the colon?

Yep, dropped.

> > +extend a bitmap when appending to the end of a MIDX chain.
> > +
> > +(Note: it is possible likewise to compress a contiguous sequence of MIDX
> > +incremental layers, and their `*.bitmap`(s) into a single layer and
> > +`*.bitmap`, but this is not yet implemented.)
>
> "`*.bitmap`(s)" feels slightly awkward and only saves 2 characters.
> Maybe just "`*.bitmap` files"?

Fair suggestion, sure!

> >  Future Work
> >  -----------
>
> Should the patch also remove the first item from Future Work, since
> this series is implementing it?

Hah, that was quite satisfying to do. I moved that to its own commit,
though, since this series doesn't implement incremental MIDXs, but
bitmap support for them. Incremental MIDXs were "done" as of b9497848df
(Merge branch 'tb/incremental-midx-part-1', 2024-08-19).

Thanks,
Taylor
