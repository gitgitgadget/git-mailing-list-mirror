Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBF15B97E
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141840; cv=none; b=p2b6tIf7knaQXC931jsm6tuJvdqJkxzPMAtIMrdEHLnDD/6+XOP8qGN9HTl00iJauMRp3rAmPawOLKRRjTJcmsnL9V2E5tIeYlsefAPu2xjIsQO3cgjZWeH3RYKfIdNIawVlC4XCMvZvd4+/oif38Tm9VpEVZoslKUKrJhd6Sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141840; c=relaxed/simple;
	bh=fiC1/zJBMOqvhTvaflCtMO84HR0RZdPKbT2mlkAdllM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDWKai08afncoMK8VZvU0/iaYwiq9c7CEsm3QP/0Um4goRgBiN4c0ji8kct4ogjhAvA9OLl+qc73k2KUa2laRmxlJkTJ+ORX+UjxUL0BvRc6oBDyRXHt1f6EAsJq1+7ad03SKENIlgKqHu0ME5Ee9H3dv+23tFFg0q2+WSuBhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ghzp2dD7; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ghzp2dD7"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e38df4166c7so232084276.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732141836; x=1732746636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDwwkBTZmZzeNQ60DDwQ42RHI5OJpvlRQC9R/+DiDho=;
        b=ghzp2dD7WjozzkgVDORiszAspbJXHRKxcAygd8ApQI2FrOyo6DPXwPX7dFK4FhhR0b
         ilwNtm1xuxbbhtSWyOaVptN9CoLyLNPLcHDsajVmfqZi1UyY19MG+Hv1jrUVLO//5bsH
         oRA8m3qvdAu7e4cc+aoV0EYnNB1r8ah0vVyB94VRGNszDT5Bm9L6Vqf8QuM0tv3bBJxI
         Y+ytgp8FHBGcwmZWdMWgY7lmCZDbvlBLg6GMi5adEmbuZ69+Z6zcuEQDFPd7mzwaJR/j
         GhHxzWiqidrk8oN+8UIzCKO/FtcFlvOnzn2YXnpevEtGJ4gXqPB5tckWaqNPB0qUOqcZ
         16mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141836; x=1732746636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDwwkBTZmZzeNQ60DDwQ42RHI5OJpvlRQC9R/+DiDho=;
        b=qA+z9pFtbgh5CLtmpMBvIKt3eYOL1ukqQAgP3KU/1Z2YiwvrcHAIaRqVvB1vN1Jnhf
         C9xDVyF+MJS944yN9Fopvoz6SlKV8x54NMhSb/sIhcus60ITz9ZS/NQgZX+10Go04v/V
         wUk7zPrkBguwmgAwbXPiAhjKmaODzLwABWtjOHOdNG1vwN5OkdM5TDQ3tj7m2Y1BLDDQ
         auZInNh+gm5YLA/qLZ6MSfzr12WEiovecw86fr5XNsl67DniEUlHtVbxPnlmNSiclDf8
         wtAHPM8+bM+RRkSksU55jPNUqv05iS32CwUHXpPY28QOoFvGKFt8954bJS4WdoaXJe8U
         3+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVD5bOzFj/RvdaP7R1TBUT94usIW3ERVL+RVcBpN++InV4CPMtdrwV7U6NphKGVV7WrjdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4aHkFf3Rjq37enmmhlJsBpyJdZfM5LI2qmiLeZCEIpguNuWG
	3QRVN6Y5Ep4BNWYcIwBVLMH53JldolkOY8IE4G7Y1vMGWVaKx3rsbutUixH+jWQ=
X-Gm-Gg: ASbGnctWVty1qWk+CNdbJCBDm61penJ2d6yiJdYGnnsX0UMy4Lt89vOfJleaEzFno+3
	Qec3kNYtz1FgJZsYDd2Mtt86ksmDkMS4JbbXVK6cBuCL7kAnkO3N6I+6xkRm740HDWw3m4BMUXq
	rtAqvgy+NYfdE7EycRItvn4W251FmjpP/nWZgirqlJGoL3JCBcJUSpxkmnSRub3TyJc7eA8egV1
	gAJgv9Ja/gHB4Fm13JXereSNbI5jc81AsWTD/kFWcn+eQ0DugcxUsD+KyKS5KO1/qVScTBt7+u7
	FrhjS8kxjTistNiuq9JHPA==
X-Google-Smtp-Source: AGHT+IHlD5m0oxwlgcZQ2TuthTcUR92EcbTSlQheWn2EUwdFhPgloJEOg8oyAoOmmkEMKe9dfdDMgw==
X-Received: by 2002:a05:6902:102d:b0:e38:cd01:36b7 with SMTP id 3f1490d57ef6-e38cd013a6dmr3609987276.27.1732141836530;
        Wed, 20 Nov 2024 14:30:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e7ffc48sm3316950276.49.2024.11.20.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:30:36 -0800 (PST)
Date: Wed, 20 Nov 2024 17:30:35 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v7 1/9] packfile: add repository to struct `packed_git`
Message-ID: <Zz5jC3gn7obrXGr2@nand.local>
References: <cover.1731323350.git.karthik.188@gmail.com>
 <6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
 <87ttcbi9w1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttcbi9w1.fsf@iotcl.com>

On Wed, Nov 13, 2024 at 01:41:18PM +0100, Toon Claes wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > [snip]
> >
> > diff --git a/object-store-ll.h b/object-store-ll.h
> > index 53b8e693b1..538f2c60cb 100644
> > --- a/object-store-ll.h
> > +++ b/object-store-ll.h
> > @@ -10,6 +10,7 @@
> >  struct oidmap;
> >  struct oidtree;
> >  struct strbuf;
> > +struct repository;
> >
> >  struct object_directory {
> >  	struct object_directory *next;
> > @@ -135,6 +136,10 @@ struct packed_git {
> >  	 */
> >  	const uint32_t *mtimes_map;
> >  	size_t mtimes_size;
> > +
> > +	/* repo dentoes the repository this packed file belongs to */
>
> Small typo here, I think you mean "denotes".

Likewise for "packed file", which should be "packfile".

Thanks,
Taylor
