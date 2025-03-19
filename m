Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A25137E
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342566; cv=none; b=nSDY8SzAiP0NNzYCQfEP8NLY9X9+pfvG9MNl5nMaXKKzMvE+huaX2zkIq4UdugQas7PsIEflnMz4SHS+hdK34neKIFbiIC66DF/fhWpURYxbqVddYhYEcPfKFj0U38fM1R8HeuXzsmKOl9xmuvBcjtxclDKlJZzzh+ymlcN/fWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342566; c=relaxed/simple;
	bh=ZVkL1RkA+UsP0MZ7wPkvyoiSTXsgPOCZN/AHyYnqo6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsHpyZjF2qCqrPnd3KHlb9pLOV1JHqpB+Imp+rqdkSq4AOthXZNACMWqYm7u+w3PvfbksuUfNr1zVc/t2rQN3+DyZzKotrv695+yWmPVxI53KbQTdxQ7OAcEo2gTP6bA2UXDBPgIsr8KLuoAH2T3xbxymRsCpZaP2Jv+b/opyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dhkDnQYO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dhkDnQYO"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476a1acf61eso47172151cf.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742342563; x=1742947363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hoycj+eAGXwLoRawlwnfNVLErRdLmuXdBkUDvNBRTxY=;
        b=dhkDnQYOy7l1c0RPxvmSLrSB8uTlD6G1HihpTsMUK84y6nKUEoLffRc2vGKpwp5QFW
         MkKcIvkhUsj3F6yF8URWFAw0HdBwuxi6esByAWq1dMkxD5gteUhllIWUBRfJLI2VwoX6
         jzAyqTRvbJvLR/AWWIudWt5qogUtWohQZSqLdso7V3pamPcyX/orCygwYacFHfr5DOJs
         cwN5S38Hq/8cuD3tGfHIPdhiaVqwHfWGO5UOTJuCnRSyEkSc6DiiNBoHLWGbhe2Hhr7f
         BPZlm9A/H/n8QSP0cQ4xH6LFpDBuf3fVjZDEdNd7/FCYggIo02bdrjjTPeE+fwiJEZFt
         7P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342563; x=1742947363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hoycj+eAGXwLoRawlwnfNVLErRdLmuXdBkUDvNBRTxY=;
        b=NBmItcfc635QAvXgvhcTzw41eV5uwVqubFgQ/NZLL1gN+XQNM9k4YXWN9AXv2VMOtt
         VN9akBiUO0L5XvQUsY9SmWIlqM7kgw3tFZ0peJTThlC1NFxyaUdNn2kbNt6qbVgSGhgC
         G/1/N/eWpvVNDLGSUxStmj700fwVrZAuOCZOFQ5+ZEs5c/KiKziEadYR2YPB6ZdFvbpr
         9Z/DtKAZbpIkMDkU7igwB+dVUOGfEJOUFM+R99v1IjiLII2ZFv2lk8Rc2R1es3j14imB
         4+yh1HI8SeFFQjC5xb545PztnXu7cRp0XFpgEX555MWHTMPWrOKEyCKbfX6r16iyNvZL
         grnQ==
X-Gm-Message-State: AOJu0YxrYamqJdnm5c4DrIbBdDGZ0qy2oZghAge9bvplNSIe14vjLEem
	xl4D4MPKc49tNQKHfxzccfYNqNr61yMhmLdjjiWUtILVbshIbPRrC6dr91/NCgg=
X-Gm-Gg: ASbGncuRbR3FSPKvZTng0cTj7AW7il1zQPIHYF7jr8m8myur8k5hY4G38HWJ3XvyICV
	eV6SWFpV1BRW1zzPMnLQ480R0iQM+22iwFm4Pn7Xj8tA4RB73R6D51F8DRE3ME2XlKWo3yEoyXR
	RoDoSnIcXkhrBZdnd/KmJOTnsOZA6otHNpKXoPDkEmblCtLbAFn+Sb/flSPorjWkwRBy/l6GAZn
	7iyA+tlqCgWVQ5LgEb65cQ6BSSza8Fm74slkFfmmvdhhVr6Fb+cJk9VfvqpcL+tOhiV206qxDJa
	SOYyd+kImNFdWdUF4mPwYY/+IfCZCBflYZmnsnjyUT/D1sm+fV5oi9Jd+oNh93DoSYMj2yEqOSo
	LFiEjsEQ94txL5GSz
X-Google-Smtp-Source: AGHT+IEymwYKpZjFjdXOpcWDZMZeyy29BoGrkCoKaXHMlHNBBGb1WM/8muDlT+FST76KTv/MGJnfIQ==
X-Received: by 2002:a05:6214:27c9:b0:6e8:96f4:733 with SMTP id 6a1803df08f44-6eb29275759mr13981736d6.8.1742342562736;
        Tue, 18 Mar 2025 17:02:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade24e94csm73572726d6.60.2025.03.18.17.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:02:42 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:02:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX
 bitmaps
Message-ID: <Z9oJoZdfyA4eAbeD@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
 <20250318012726.GB1471939@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318012726.GB1471939@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 09:27:26PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:24PM -0400, Taylor Blau wrote:
>
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 6406953d32..c26d85b5db 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
> >  	return read_bitmap(index->map, index->map_size, &index->map_pos);
> >  }
> >
> > +static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
> > +{
> > +	if (index->midx) {
> > +		struct multi_pack_index *m = index->midx;
> > +		return m->num_objects + m->num_objects_in_base;
> > +	}
> > +	return index->pack->num_objects;
> > +}
>
> I understand why we need to account for the objects in the base to
> offset our total size.
>
> Similar to Patrick's comments on v3, I wondered about why we couldn't
> just modify bitmap_num_objects() here, and why some callers would be
> left with the other.
>
> I guess sometimes we still need to consider a single layer. We can't
> quite just access m->num_objects there, because we still need the midx
> vs pack abstraction layer. I just thought there'd be more discussion
> here, but it looks the same as v3.

Right; some callers care about the number of objects in *their* layer,
like computing the size of some bitmap extensions, bounds-checking
pseudo-merge commit lookups, or generating positions for objects in the
extended index.

I'm happy to include that discussion somewhere in the commit message or
as a comment nearby bitmap_non_extended_bits(), but I'm not sure which
is better. If you have thoughts, LMK.

> I wonder if it is worth renaming bitmap_num_objects() to indicate that
> it is a single layer (and make sure other callers are examined). I
> dunno.
>
> I also suspect from previous forays into bitmap indexing that it will be
> easy to mix up positions in various units (local to the layer vs in the
> global pseudo-pack ordering, for example). In theory we could use types
> to help us with this, but they're kind of weak in C (unless we wrap all
> of the ints in structs). Maybe not worth it.

Perhaps. I do like the idea of using types to help with all of this, but
like you I suspect they may be more trouble than they're worth.

Thanks,
Taylor
