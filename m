Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C81494DF
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805674; cv=none; b=NkOIPtyX35mDqql5iXRNyuJUgs/Phqq6dLQZbWSkEQMwSbMGYbp+Q9JtaggSAvvlfpLpYyj1zzeIFndYlNRu1V/wmI0TPErSRIpGP2Mc55qARTyQ63FLOGXfuYMAjhRX751zcIXeonWNlrzN5dpYGNtKzxO5fjvXbXXXs5XW6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805674; c=relaxed/simple;
	bh=2dg8y92k7HTLB6i3IwGjrtBhuzzBouLH4h4ow5bDd4k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tB5tZHIfCdXhbzRhs8p4q3J42XTx0dPH6wcS1G+cZ3DgJp1tl1cXXuNFMUHC6DOwjmKH/D5HQ8gJzyasJ+AzN1gWs1tcNaEhxkpIVY+m4KMNfjnX9AhdinDb1WEQFzsca2xqHiyy69Fv7IL9lsy5JTeGqhJqukHnBHkslCi93yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDjTgJEH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDjTgJEH"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso5527172a91.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739805673; x=1740410473; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dg8y92k7HTLB6i3IwGjrtBhuzzBouLH4h4ow5bDd4k=;
        b=TDjTgJEHvODgxZJnDqN+SDRTqUQpGX3qq5FWcBa1RhBdhZUR08cX/wHZCeYye2DZyC
         54LnJnj7uxl2gH0ZriZT19hvzY9GdhvHH3yQtwBIEg+iKNbRIMEKEbFo7U8tpNVPreWw
         /cEgAcYQyEBvRXO+9nRNuS5mipl2h16+O6ADa0BrnJVqYxwW0jND1Xdla/o1LgNzKg/O
         JngJLxPBcaEh4OxYjH4B7QrLOQ6lmkrB+Tf8uIg8tckiurgIzZc24cObq+HwaOg14+xZ
         5nmyBBCI66mxhgNPn/aMPd5urQqB8rxDEaD48WlSJsPrc+dgv1OkO1a2BysgO009miMi
         reig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805673; x=1740410473;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dg8y92k7HTLB6i3IwGjrtBhuzzBouLH4h4ow5bDd4k=;
        b=IcksPgr4h3029U8KYtA6PfBllrexmimiMfmRiMcYu8a+Khf1uI1+UEBWnIbfVD3b8c
         lS36qvLdJnXWy1V4cRJoOHZqgT/YiWJyHyzxS53j8GKzI0etuGkjg/Tsz8LWFq2J6OHo
         AFYhhUikOc2m3E4V11/o8H7cH9aXV6EGlqWoBUdUdrqcj7mYMYetkyiOo56jEjo9XJhG
         w4sPLEkO/FJ3ua0Vg9vB6eKhzcN2xnEQ/uw/W7JjtZJ/oQh2XoxHfGe6GM7atS2cWnGO
         FXJovOZUQ2nyj306grJmqY7UvwBi4E+0+UW60nvv9HVnnxbdNJLDkJ8eX1Uli0VUnEyU
         w94A==
X-Forwarded-Encrypted: i=1; AJvYcCVxjlcx7bxyNZW4PNAkoSnKD53N00yDE6HP17YdKu3HHJqaTlkUSAto8Ket9+MaJ5AJLCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIalzmSA2loOqLmlc7lo08giT6rrVHpkdRZWp8kLoWou4DRWv
	EFeYuqt4VHW0xxQzzX4nk5jTGXX0WrlLhqU5+nwGmRXPmhYxvSWV
X-Gm-Gg: ASbGncvA2kefD9W7YncPKhFaxuLBphu6cry+GivP6BT3IY/3JB+Un0aXv66s/h6tSW7
	4t2/3c6N7GaTgoaWU5/drEeULnM8R+AW1YM3tD9ON9XHGCCaFAY8vYOYpoNwkg+sjcPNJB2DYsd
	ViWpfaOIHte60aM3jWammnsgBOaRTbF8qhW714YI9APOJWa333vk9dDkbsaZfx9/RCKYdndNSVh
	ouzong+3lu9HfEMOpWJLc4bYUI/NGHhhGRBWEYaf4fxV9htNWzAomF6slQRvaKKv5+D9TO6piNb
	9gqiMXR5n/Cq+WwDOcU90CpI8Ny3RBsdN5k=
X-Google-Smtp-Source: AGHT+IH55amZtos7IjFSCFr7K+GZkWnaYacXaQvqyl4t0uReFKSkYwnR5gCM4Va/T0fdzAx4xDCyvA==
X-Received: by 2002:a17:90b:1e46:b0:2ee:fdf3:38ea with SMTP id 98e67ed59e1d1-2fc4104051emr12093194a91.23.1739805672602;
        Mon, 17 Feb 2025 07:21:12 -0800 (PST)
Received: from localhost ([103.31.220.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98cf1besm10228894a91.11.2025.02.17.07.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Feb 2025 20:51:06 +0530
Message-Id: <D7UTMXEUFQS8.15HJN6CTDM16S@gmail.com>
Cc: "Karthik Nayak" <karthik.188@gmail.com>, "Jialuo She"
 <shejialuo@gmail.com>, "Git Mailing List" <git@vger.kernel.org>, "Junio C
 Hamano" <gitster@pobox.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: Git in GSoC 2025
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
X-Mailer: aerc 0.18.2
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
 <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>
 <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
 <59004310-f270-468d-a248-c83c97de4a1f@gmail.com>
In-Reply-To: <59004310-f270-468d-a248-c83c97de4a1f@gmail.com>

On Sun Feb 16, 2025 at 7:23 PM IST, Kaartic Sivaraam wrote:
> Hi Ghanshyam,
>
> On 16/02/25 18:26, Ghanshyam Thakkar wrote:
> >=20
> > I can co-mentor this summer. The 'Machine-Readable Repository Informati=
on
> > Query Tool' project seems interesting to me, although I'm up for co-men=
toring
> > in other projects as well. Let me know if you need any help with
> > anything else.
> >
>
> That's great to hear! Thank you for volunteering. I've added you as
> a potential co-mentor for the project that you've mentioned. We
> could discuss about the allocation to other projects based on the
> applications that we receive. Feel free to let me know if there are
> specific projects you wish to co-mentor in.

Sure, I can co-mentor either of the "Consolidate ref-related functionality
into git-refs" or "Refactoring in order to reduce Git=E2=80=99s global stat=
e"
projects as well, if needed.

> Also, feel free to share if you have any other ideas that we could have
> for this GSoC.

Sure thing!

Thanks.
