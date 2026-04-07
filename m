Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729051A683C
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563567; cv=pass; b=Vtb8nxBbCiGRCq8RcAwtMmMmsxtt06ihiZlBoQ9+1H536TGLDITOmfe2NAN3x04J/5WUNoVX2BiiqumB92pxuRoKoHDpZNaasGhfC440Dw6x+YI+yh+meiaSB3zHJbLTlqrzjNMAoT4JgDUES6aznMsKO2eRupM++Ce/uu2pVvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563567; c=relaxed/simple;
	bh=rTSDHixgHdkDNk2yF42Z+Fgx+DzcVhbQRqa/z3S9q5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvtwzmP5+ZQekH55naTczPT/qb9xuG7KFx2eCHz3mlddzKtK9sf32Ci25Mov3qfqhzXP0+qGzyWnt4iRwkB/INF/zWWayrd8LfJkCalT8KiEFmmmfYE6abz9rLrWpzaCAAHLJlSOTKHj2VCiIBLrspGmjH0dNS/lDVftnnFPEIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rR/xPDxw; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR/xPDxw"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c19d23b19so398031c88.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 05:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775563565; cv=none;
        d=google.com; s=arc-20240605;
        b=AAjQqPdEegJPGyRJxJ9YLvncGLxd+5fvQ9eI9XRawml+Jb2rEADj5lqixXB/ivN0rh
         nRh4MM13K3oMMhNDGQ9ftRtVPTh9xWWqzg3XbBzb6GzdMqLqbD2RTM/VCNNJCsQLLm67
         +DYr/JJzZsmDSxIqRL5/5QurCQqhJEOqBqrPvEaRB8K2cxsDiYC9SBKkgMaTH32fj2jb
         NzfPUHpLTPRXGmGZACib1pt2xv+cwu2wNVof6qOieNxrdJZxSQFIf69iiGRPBzx07oUT
         tSZvJnW2pXZX5aYD+Q7ksLLz02CSgi3YHGgjvoUEVYbqRUpXpNtKdLy4ixcAoSJ/kY6B
         Pnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2XN+TwqJCDIVD0wY2nAZx+aoG9yO9B9y6RkvMiODNUM=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=H9CpZ/UXPcZh4gd7ApM0luzuxf8HM9EToS3v69VLoUbyzr8r3dHtz/AW/Rki+Vdpr0
         +NssfpZ/X9X59OmjjZDnbLv5yAthRGxPWWBWK7LaeHx2vCSc7gsQSSIf7LlPhmbT37dB
         sINOvcb3396BEXHyPv5Mkue839efDKY9KylYxa5L2G/pw/rrtBuTO972y92VaJr0IbTT
         m8nhKN4Cr5XLTVXeiKBUCUZ9OEL0I3i2UCneJyy6vnB80uBTb6HIn5Jv5g4B2hFmg2Wa
         lW9b5Iwgb9a3UCpXsto9W1PXIa5vklN4VvHvyfa1n2J5GnAM8bajYks8MFLPUac5RsN7
         Q/rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775563565; x=1776168365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XN+TwqJCDIVD0wY2nAZx+aoG9yO9B9y6RkvMiODNUM=;
        b=rR/xPDxw/oblleu4fr+qQQBahnO0eqIo68EUxGznwDXpH2QA3bvfE2YudIIQm3A4zr
         TDaESvNnkenIX7gwKgYkbnLN3qUX9xJlWCAeeyovNHpl/rGm+dN9i0zTbugX3l+KbkYC
         QfaF8npAGtArblTzbLZTz43ztnh4mF6Rm69wReSBE1aNB0STMkGGkweIC73Z3PGG8uQ1
         vQUhDnTYzVFUTrKmfADKeIDc2nuI3Ye+EgSxKI3pvGRI83Rrok82+3Jq5FTi9O04Mmeq
         79BUCTVZdtII+dIloXYjL6R1vbEYNDi8/tnsb2j/Cylm6E+oolDLjHgYt6qrpqxEBOfs
         qwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563565; x=1776168365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XN+TwqJCDIVD0wY2nAZx+aoG9yO9B9y6RkvMiODNUM=;
        b=Hvc/lVvkwTtkfEP65Li9n3zQU+VoXdTXVPPSGxdRm1josPEeIuP/W5ooH09hE/WuXd
         kEzZlta0sJvJxD0ewNJrmnelLIYiFZRrwSjgv5OZIDMOyhALho8owfp5XlumAPfUIKQn
         UGpEcsbprSNG/kqGVucHX6054CgvnyjUbWeHQl4etkZMKoq+XxBOXGE1agn4KdmOdHxj
         O31/FyHpu8dV0JwWrt+46POVQyH+1P3sqxPrLYx3RMhEPa5FoUhp9xRYOaFiZwQ0GY+P
         tAI2aSj/fhcyxY13ASG8Q4ztyb8DPBG5jie+UTN/P2GkDtA+idbmRhEugmDqtmDGNggW
         IXRQ==
X-Gm-Message-State: AOJu0YzL9MUUkPPDGzhZb074ubs34Ly7l3XPoZGF2PAYs0gn/QIkMYv9
	ovTtqfyR9O+jC8kUH9KN7FhL8PMjTCkNRKa/xQDDKXr1YKROZRtm60lZQy5DU1fIyJZoRzco76Y
	J2YxAz8fH0mhgsQSYckpMr1QM/qtOwyY=
X-Gm-Gg: AeBDieuAJAqrtPfwd9FpEcF3Y1ckSd5roZIS/SLI1fTsGSsbJtQc6VErXAJXhF3ZsP3
	EDvzEXOkJ9JgdFgPhgW69qZRoZKktk/5e3NcNKzBw78pXGu1axdqh1v0Qz51xa4aNbr8XVf96cc
	vQqA32iUTQqzRCIPjB6SDGruW+lfYFiVnpnMoIGd5ZOHadZSah2rdUZYe7QYPCDCpFfCYM/h/nx
	lT+mSZdsLU8wAQqww+bUKJoJR1MTqa61+Gf5WdZl/E0gTfz5uIpDrbktvt2eaW7byFP5k4Qc/2U
	aR0kRURXVoSb8JXF0kYG6RamlCireZItI/yq6AhEuCCaqDuGSYouvzuZImNxfIdRwITf
X-Received: by 2002:a05:7022:62aa:b0:12b:f899:7185 with SMTP id
 a92af1059eb24-12bfb711224mr8124877c88.16.1775563565334; Tue, 07 Apr 2026
 05:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260402070613.85934-2-christian.couder@gmail.com> <ac4evWK9k69LIV91@pks.im>
In-Reply-To: <ac4evWK9k69LIV91@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 7 Apr 2026 14:05:53 +0200
X-Gm-Features: AQROBzDWHxuvJW5RcDoDj1fXAyiqRguc9_kT-PAD7AwFIObg6wDxUZHTGkHIzwQ
Message-ID: <CAP8UFD1iT12ap7_A7Hq1KVPia_mPwqXN7W8Q0atMo0hz3qn8FA@mail.gmail.com>
Subject: Re: [PATCH 01/10] promisor-remote: try accepted remotes before others
 in get_direct()
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Thu, Apr 02, 2026 at 09:06:04AM +0200, Christian Couder wrote:

> > +test_expect_success "init + fetch two promisors but only one advertise=
d" '
> > +     git -C server config promisor.advertise true &&
> > +     test_when_finished "rm -rf client unused_lop" &&
> > +
> > +     # Create a promisor that will be configured but not be used
> > +     git init --bare unused_lop &&
> > +
> > +     mkdir client &&
> > +     git -C client init &&
>
> Tiniest nit, not worth rerolling over: this could just be `git init clien=
t`.

I copied this from another test, and I didn't think it was worth it to
add a preparatory patch just to fix this in the other test, so I left
it like this.

It could be a microproject idea to clean things like this in all the
test scripts.

Thanks.
