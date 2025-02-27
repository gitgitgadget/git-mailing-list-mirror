Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1CF276D02
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698795; cv=none; b=NmMDetyRFYYalNdeTI4MBhrt5q7trzBzFeR8KZDhksNvxwD6803WJ6ezuNP3relUY5KUOUvdvXMiM2qmr45yoc0r8RWNY5W7mEEOmR1gfPVxw/F1KkUy2qQMdd5zUDdDbwzNLiLkhje9s6iUHMuQTojcQHUhuSU8nPYIsIUbfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698795; c=relaxed/simple;
	bh=84wxY3F/+K5cqyuDmgmNMaeFp3rTaejvVARNXJxGFk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nybixleA+FaZYg6pqr4y44ivTZ010fR+b6KGicqyfj6iIy+jiBuaVJY8S5n9CxP9EQujm7/ZM3Zzuv4EqeM9c6mrErQXAv7VH0Jbe0MJzsoptBKRcb49D/TlriYVYD2PTbZFAl9V3yyrmXaTBl0dkU261LHhf7j8PxRqo8SJUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=g+BMom3Q; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="g+BMom3Q"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fb2a0e4125so10096887b3.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740698793; x=1741303593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSXWXhodvUIatArYlDC4DIn+doepUc7QkTKhvsbttzg=;
        b=g+BMom3QF1UpfrwNcnX051oCrYsb1qpv4j2bj48u+qwSwbWI4gcbQFPlWVDAJiFIsC
         YDvi7LLoxarQJJ6AwqO1Fc0nKja+8yfaRBa0wsRFqAxjqzXRis9Jyu6uqWAnaDcVtJgW
         rDin57oCFBTSZZ//v0Y24YlwAy5Sg+WrtdUq8QuvCKH1yPIiJyNDFEZs9s9/7wuJFyzK
         dZGpZuN/JpRpVF7/EK53ocpYqtGffX0oK2imMQR0HeZSNxd1+Z9X7k00mcYfRhZrcKum
         wMHHaS0eMqnL9nxVAzfUB4mCJnx0J4o9P9fyXOmx5Pz1V6K/11mYEi8ksfqD/Zc8BHFt
         1giQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740698793; x=1741303593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSXWXhodvUIatArYlDC4DIn+doepUc7QkTKhvsbttzg=;
        b=uNkG5Lvb6nirVU40hNXLYIGyVlCZtrjF7IPGIZwWhfRgNdV3FUMP2+MNO7Xygw1bzu
         1bwb5/KAnH0o04SM0J394l1tmtThBCVKJVE79tCCP3mF99RoLjOcdBP/lDZLgyBInucP
         XtJx1YnI44+gIVRnIQYXnmErlEYCMfDmCpXDMHJDXsbN2oe7j3doPNyTFUibFVXPnYbD
         MsecjtSVbq5QprI/4uNkgnFQ23NaDdc8oSH4hjwdalGmH980cI6nNroowpHnD8LcOINj
         VtmyBnG/dZ/JPAeSPcKeh5Z3T5gWdppXlUlreOg7vhNf1ztIDzZbpUqpPxrh+niOaRGE
         oABw==
X-Forwarded-Encrypted: i=1; AJvYcCXIxVJUQHSPMMb/5IuetQKOfnToITTk01z0nelR6jxMIvR3lWiOnBqUaa9leLAsKc431Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBlSZ/xtflyuXri0bNMjN9YedujsGn7NMquTkKAcQ7oDjMk9Y
	WeA5xey+UjHIX0wDkQz1fmeNoi+8M98kdvrLQ5BUxLYEP+QGXv2FSNZh+K+5rs9jHnFdqzCSGM/
	k
X-Gm-Gg: ASbGncudpLUZc177wpjlkRius5PV2skCIv1iqMrLKU4Qwzom/Cg6mAsFBv/BQor5+v7
	l7mMn5OxmY58WYY0dkO9v09bCeIn8qll7adcHKDGb4fwwjFcE4FM6lbh4VfwD9ZnzgkbfisaafC
	BtQKb/fwuTF2gdKP980pBpGVjl0TQbkHewYGM0DDWKXj6kfB8T/49ZuSwd5O6CbXOKEUVcLGVwG
	JmYWQFDARKxzHthf6NZlv1hfKi3lXXDtR3QiuNQ0bRAxXV/8JsO/PNo1Dttq3xIUpioNYjlIUjn
	og+Lvtee2OWAm/DnuxLh5eId+03U8Gh1lQJhqqK9Ts93b9BsH4ZFjpTqxWTu6v4JAKnEU9xUKA=
	=
X-Google-Smtp-Source: AGHT+IFkBr5qhd+PCVgInRGYFjz+Ob2aZcc3mKy85wMBkbgXjPkiCqP8AjHWUKN8qcYGQ8e8taC9mQ==
X-Received: by 2002:a05:690c:4d86:b0:6fd:3dd1:7619 with SMTP id 00721157ae682-6fd49ea11c6mr22922777b3.0.1740698792814;
        Thu, 27 Feb 2025 15:26:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca4798dsm4976707b3.48.2025.02.27.15.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:26:32 -0800 (PST)
Date: Thu, 27 Feb 2025 18:26:31 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
Message-ID: <Z8D0p8oKEmMqmzrJ@nand.local>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
 <xmqqseo35ic8.fsf@gitster.g>
 <Z71qQvlqtoOwDabu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z71qQvlqtoOwDabu@pks.im>

On Tue, Feb 25, 2025 at 07:59:14AM +0100, Patrick Steinhardt wrote:
> On Mon, Feb 24, 2025 at 10:05:27AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > Expose a function that allows the caller to iterate over all bitmapped
> > > objects of a specific type. This mechanism allows us to use the object
> > > type-specific bitmaps to enumerate all objects of that type without
> > > having to scan through a complete packfile.
> > >
> > > This functionality will be used in a subsequent commit.
> > >
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >  builtin/pack-objects.c |  3 ++-
> > >  builtin/rev-list.c     |  3 ++-
> > >  pack-bitmap.c          | 65 +++++++++++++++++++++++++++++++-------------------
> > >  pack-bitmap.h          | 12 +++++++++-
> > >  reachable.c            |  3 ++-
> > >  5 files changed, 57 insertions(+), 29 deletions(-)
> >
> > After 2189649b (pack-bitmap.c: keep track of each layer's type
> > bitmaps, 2024-11-19) added <type>_all bitmaps to the bitmap_index
> > struct, this step would need some adjustment, I am afraid.
>
> Hm, does it? I understand that this commit only makes the bitmaps
> accessible individually per bitmapped packfile, but the bitmap indices
> part of `struct bitmap_index` would continue to be the union of all of
> those bitmaps. Oh, but that changes in the subsequent commits indeed,
> where we start to use an `ewah_or_iterator`.

That's right; the ewah_or_iterator is the mechanism by which we can
combine multiple "layers" of the bitmaps into a single iterator.

(As an aside, that was not the first approach I pursued. Initially the
caller was supposed to chase the 'next' pointer of each bitmap and
enumerate through whatever type iterator they're interested in at each
layer. But that was too error-prone, since you have to remember and
update the offset into the pseudo-pack order across multiple layers.)

> I see that Taylor's series has been sitting in an unreviewed state for a
> couple months already. I can review it with the hope of moving it
> forward and can then pull it in as a dependency of this series. But I'll
> wait for him to chime in first to see whether anything changed about its
> current state.

It would be great to get some review from you on that series. I know
that it has been on Peff's (CC'd) radar for a while, but that he has
likewise had a few off-list things to deal with lately as well.

I am still not sold on introducing a callback here, though, and would
much rather see callers interact with the iterator directly.

Thanks,
Taylor
