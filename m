Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3423C0C
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062583; cv=none; b=GeoqPbm0CQpiY9VRY2wtqKsjly32yK1odhEvSn9b65TIAUWYVdUMZUXr66bEcHsPUGkRaWJZQoLZdgM2FsbVBrOPB7WdNkwS92nsV7OEvw0q7iuYyZNr7xyFOuMm/wuBRCVlJV1/uwk1rBYLzmPHqaTzXwSeBLFYvrI/rPa3cRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062583; c=relaxed/simple;
	bh=cCnF5CVV9+5fnIOLrL0rXqOeO0j9BleYt9wV2WHy79Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcUzi9jUT3x9ZlWv2/3szIIrYKbBlPVJ3mu/mFH2I3+N9nTbRdXwwhb2ZUDPMqu5TIAY3cM7EjyJMZmecKwkwd5OMQSTL44uDGHF7as7oEYBhvKoZiqklszyQwNBYXULy8V2r9fOblgiBpIjnoaaW8omNNeY7UpeoDxhy3DSA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5MuCJJt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5MuCJJt"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-702555eb23bso3873314b3a.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718062581; x=1718667381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gow1yIyxvOh28uXmDi4NbybOiXbsXTzO1Y1LxydMwHA=;
        b=G5MuCJJtH5LZqmNu3ageNu4laqz7IrxEPZexnIjEtLoY6ld1HwxRHvgP9qS0mdDrN/
         /BRgZIBuWjmPkODm8c87QfKFLBx/eu6WVenci/AwXRZxZ0RrFdpdf/BmgsUl9eAHu267
         S9/8hKQ6l+O9m6DWhgKz5TDyvGNOJzqqjTicN3nEMEC4P2+ud3w6U32hL3XeN2A3lwf4
         hl8DAJyGogGDd2kpb3flxOJNHSJ5hozm8dx0WBXAcc7tRiHfy8riIENg0bSpdjC5VFo+
         cLJ5XtwQ3UQeb9YRULUEUV/yunFHrJRiPuUUMawLPSxxmL5cXBySSyfPyaKeIXxDp22C
         5UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718062581; x=1718667381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gow1yIyxvOh28uXmDi4NbybOiXbsXTzO1Y1LxydMwHA=;
        b=J5Ammacns/hB2MY1gec22dvK/Is9ncp/yiBybWqaaX0jKu6BOKx5GlmneEP7c13k9L
         1Y8KwVIN97fLmA2zZea6+D0MXxtouLKC8+UP0MZ6YAI4ifdpw7pIwRiMqFHElA4hGf2G
         /0yRUvYUYc+NWSEoCE9GYdPKpfbkl0Zu8CBs7sF6kb6wq/A75by+gRCH9RkcFcx9r4HF
         NQ8/SHQmOIFLWAdzafIyPI2PgNqL3R3zH6XXNF9suQXLh7GSTKrsZVRDrIOE3U+q1+4p
         c3gc4NM4qVisPJvSGwykphWc3cIexS/8I1wgysLnWdMS+/V7GAvjSv6vdRrNEOOiYfYR
         1tcQ==
X-Gm-Message-State: AOJu0YxWKMiosQwFYVh4/o5rR6vMOxt7KaD9bEG52H19Qr00F4coLEX6
	Aq/yjmg0ngS1iYkLnelPvrKxf+cHkamAakqCHXY7Bf5xSyoi9/PK
X-Google-Smtp-Source: AGHT+IGQ0vRK1F4utD/NMSFmiMCSTTdnKdL8dqB7j0gq7gM2k+N35ZkfhamrV/msn4lGDAGxCdIOqw==
X-Received: by 2002:a05:6a00:4fc1:b0:705:98e7:ce6b with SMTP id d2e1a72fcca58-70598e7d1e8mr4130133b3a.20.1718062581143;
        Mon, 10 Jun 2024 16:36:21 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041d383a46sm5154201b3a.93.2024.06.10.16.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 16:36:20 -0700 (PDT)
Date: Tue, 11 Jun 2024 05:06:17 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
Message-ID: <ssl4pyng2id3hcp2ssvi4artjxnsdcm7h4mnocidasxggnztqe@c62anllwrded>
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <20240608165731.29467-1-shyamthakkar001@gmail.com>
 <xmqqed944uq7.fsf@gitster.g>
 <72dncmhj2qt6ufh67gbj3ctnwnssnlc3w22x77chcigzxou36f@mnwnrwg4oo5r>
 <xmqqr0d4zevq.fsf@gitster.g>
 <7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
 <xmqq8qzcz8pd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qzcz8pd.fsf@gitster.g>

On Mon, 10 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > Yeah, I'll reroll as rebasing on 'ps/no-writable-strings' did produce some
> > errors but the change required was minimal, so I'll include it anyway:
> >
> > diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/t-oidtree.c
> > index cecefde899..a38754b066 100644
> > --- a/t/unit-tests/t-oidtree.c
> > +++ b/t/unit-tests/t-oidtree.c
> > @@ -62,7 +62,7 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
> >  }
> >
> >  LAST_ARG_MUST_BE_NULL
> > -static void check_each(struct oidtree *ot, char *query, ...)
> > +static void check_each(struct oidtree *ot, const char *query, ...)
> >  {
> >         struct object_id oid;
> >         struct expected_hex_iter hex_iter = { .expected_hexes = STRVEC_INIT,
> 
> I somehow suspect that you do not even need to depend on the
> Patrick's series---tightening the constness in the function
> signature by itself is a good thing as you are not writing into
> "query" anyway, even without his topic.

I'll clarify "I'll reroll as rebasing..." -> "I'll reroll, as rebasing..." 

Yeah, I meant as not depending on 'ps/no-writable-strings' but only
including the diff above. But since you already did that, I'll refrain from
sending another version unless some other changes are required. :)

Thanks.
