Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9D44781E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145867; cv=pass; b=ExbPIhyAF5/pJfmQ7yakWNL2JKfIIq8OXrTeEYZn25zeEFxFfio5t7LkuUrRVZladHjJyaHIzMwL/7a1jDxwIU99yqj7LnhhnXSmUb0Z95rnbUkjgFy9WTN3Rji8GRd9W+RLnxvHlJLTvGpAmnuO1X3LQIyRAXeA8uTVLnVXPuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145867; c=relaxed/simple;
	bh=AI1CXbVSA5h4LZ7ywptop4/C8IzmyCWDnOdQ5g3MBhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hox1FMo2BciMDTWfnXL9i+FMLNK5hSvLXPUfPa8nqttd+j0VqPnpH03wvaR/ss5OPznuXiGtGcOW2nAZXzXwbancl1PcGzB+Aop173kJQqXyAQagGwSAjGP/zTq2TJ6BIWNWMut15un6sqBBb1LINzHCG+sR3vR4Izl1jcUFb+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb6B+cNz; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb6B+cNz"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6cf995766a3so5008263eaf.2
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 03:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792145865; cv=none;
        d=google.com; s=arc-20260327;
        b=f8phXTiMdRYuqPKStswE6FGpBisTS/WxgDbT9e6qr6VXNvufHVbwY4S4x2kYYYDj7k
         W/T7uh1im01VnxzOKTq97tsXWRXUmue8BJgAl3+Ojpd4eO5GqkIkqHkSQwMERsVPJDj0
         gcIeC+FkHH7aervxx4kcOanYngE0K2GvGbT37qw5lTVs6uLv9RMNHHqDdotOmAMLPqRO
         J2PXbPuScHPgaUCxpx6UylSLQi/Uyv6ByMYB4oOZr8b1BtgTsU7O8lMFOfaOuShqarLp
         fLttI3JhdRehHvJb3FErcaIRvGUKUGHM5cKa8/0Hwh5u7ZW4K+XxThINpcNbUN7Enj3i
         gvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=orpPYkwzcyvNZJe/GccRvvnRqmRM2tBNRGK5vUpRIWs=;
        fh=DPgtX4o38k9SknCCcanJjrHRT2/X1rLoJ5TdHZzHSpk=;
        b=iiH37jEUGz3wUAjDVPbfMoKkV4mKcXBudkL7k+yFZjHxMQQPxHviMFPf19viqzb6vg
         XA0n4swEYmDGVjTPYaG/frCH9Vxad3zsUHRz9CBz/7uWBrx+f/e6KvJbtX6f7krI0BiU
         XrRKdNRayI3FPBxgd+tPdiiQu5m05r75K7WsMcx1at5ESpoNxqbHMVIKj732VaEhkPOQ
         lBJdN63ve1PUEQA5kieGvZTDiKGcFvCZIZ6mHMZJ9OP6UEPpIFqGpT+mrXmVZKe5CJRw
         8IZh9BxPnbCKeN4po94D0N98B+p+SIfRFoHJL0UY2V5ecFYj6L5NTeg/sSq7YwtnYqqX
         zl2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145865; x=1792750665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=orpPYkwzcyvNZJe/GccRvvnRqmRM2tBNRGK5vUpRIWs=;
        b=Rb6B+cNzo4ARCnxlom4grjHdTxWW7VCmyzQ0eMSpG2h7fLBtblhAEyar61k9pgRa94
         niojGpyaysfmwvkJj8IfcB0rurYChTqT6cgbS5yE3/nsidlybo7UQBl1aTi6QS896FUO
         2tZTFPny6AC88ZPpOm7lv1kBdLIffIXnB9qZIkE3PYSY8Ia9Z5klN+cesnlg4GRxnv09
         77AMbJ9ty5An8isnvID9brJCZ/xrQMtLNl6laEcv27ojngdGNYHu96rdxgpjFvfwl78e
         6IRlX5BWlOrHdcVU583qhEnr5tNvrILTGJGj3SGqE1HivyQboi6OOxZb96vlcPK4kjSP
         FAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145865; x=1792750665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=orpPYkwzcyvNZJe/GccRvvnRqmRM2tBNRGK5vUpRIWs=;
        b=FdXUKyuO0n7LZZAxmAU70fj4WEN9ceBIHl7TvM0DAGIlP2a41AXpvQHEUgb++FeYOm
         FLRlkCnpr+R6Vy3rZSiIQd2V+2qjdlcCT79d6twaI7rQyxJoJ30ZBd4gaN0+20E3IRUU
         sZ+u+9rin8pAgAkncdlPGHIYFLTcZOvDLRRRuUR2k03n8Vo/MLdnLZXLu52sWpwyfj5p
         3CdbN952tZiqcJHYsmusAhFRClL55NSRtyAAi8bGn/8TZOlzJ5rl2gNBRbnEInrufb7d
         GJknsXxbUuaQXqUCOeQzdBxYtMQo0NO+5ymElGBRa6L/mI76BvtBnVApLwHWZHJe8sXp
         HOzg==
X-Forwarded-Encrypted: i=1; AKwUvByySPCjiBbfiH/sNh5vVFUCZdg2uwhS2x0udKOF9SP6OEPeS+OVdEDnp4GY4ITemu5IDKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUWI0X2UxdqcjDCVQsrRJc+XMCCyKWdyFxbdcvWAwMZqf9G+aq
	mUIHD6Vfyzwr5xdaKeJRNZfd+j5OfDQ02LaIoC/HPAgt90C44HV2/3v+3gXHOdqc/s/nFePqexQ
	PX1lGAGmRmO/l5Pn+AMEx0WbGC+RcrTc=
X-Gm-Gg: AYBFou33LVH96XZ4h8640a1BIivHRP3v7hMcwrh6JY8J9UB52R3e/oX3ZqoNdF8gIA6
	1TKva+1v2MaItscFcgzP/UfYy5Du1P1z2X9lstiVFTAner+0AHGmJf8m2sP9zl4GvwPu+eWZEXc
	ahf8v8fjocNBlejPaA4CBy7HDivDnEPr68qkx7eXvbUg2rHo6JoFDWm2/k/dktBw0TIBqWcAl1L
	8Lg1TMPJhY5kSCK3QOywt8jkpjHupF16u9zMDhaUNmx4fHwkUrDOQNQveNhgSNEcPSYb7RwN4G7
	fEPx8QT4tUgG6F37bT2RYTf2yyka2pd2W9kwA3GtYkRTr66E2ZTrck0o
X-Received: by 2002:a05:6808:1712:b0:53a:e153:e901 with SMTP id
 5614622812f47-53ae1bf7276mr262256b6e.2.1792145865304; Fri, 16 Oct 2026
 03:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
 <xmqq5wz4rthd.fsf@gitster.g> <CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
 <xmqq4iemq4gy.fsf@gitster.g>
In-Reply-To: <xmqq4iemq4gy.fsf@gitster.g>
From: jyotish kumar <jyotishkumar725015@gmail.com>
Date: Fri, 16 Oct 2026 15:47:33 +0530
X-Gm-Features: AclHuK8iel7SpdTh3eEoqKBcPGTvd7zcBdI65skdR9hn3HnFaX3p9LUEsFV-q-Q
Message-ID: <CAGjZMyR7-_T+maSibej8cHn3wdWcYzbuQ94pmHj=MAdp9g-2OQ@mail.gmail.com>
Subject: Re: [RFC] pull: custom fetch refspecs and fork-point lookup
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thanks for the follow-up.

I followed the link, but it appears to open this same RFC thread. I
may be missing something, but I couldn't locate the related discussion
you mentioned about mapping remote-tracking branches to branches on
the remote.

Could you point me to the relevant message or provide a few more
details about that discussion? I'd like to understand the existing
context before proceeding with a patch.

Thanks!

On Thu, Oct 15, 2026 at 10:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
> > Yes, seems like a hardcoding bug.
> >
> > Is this for an in-flight topic that Jyotish is working on, or
> > something already in master?
>
> The former.  You can see the thread in all its glory at
>
> https://lore.kernel.org/git/CAGjZMyTQt2XEF69pJWHA=3DdiRjoidixGs48E1vA0ytG=
UgZYOZNQ@mail.gmail.com/
>
> which is (still) quite short.
>
