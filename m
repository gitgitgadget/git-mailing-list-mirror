Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97DB1DFC7
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710731325; cv=none; b=V71j/nNrY2nufeZXawVWCszcsHOmAVe981e5/oK+hw54/tnyXkEPFKY/SvStpzPtodvoM/fqzOg3cd/6ZQsq8eBubelzTtS5uFFIg8VWtRNvYbIOU44E6JLxg+psNoMz/eRDcwhXE9Q4VMeqMljU8PazhxWbsloZKySi7ukMb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710731325; c=relaxed/simple;
	bh=1M8jWps8ICatiM4kc3G3N9fQ/EL3gTyrr9E2GUdSsxc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Hnl1fGOg1SNI1fZvndKcKBQArtUyfrnvVQdgJxFr/4IN4xnxK0k0JjNgC54LD44ZFWiJTgpkvEmkSEa51jSBXiXP5ZLihbzo6t9RWDDuDaBn1tuSzSZNLec5V2yjbOpAzgDhVyHZhdW2+WavSzCe4IIjci6e7LvVAv3h6zgDdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZI4Bk3U; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZI4Bk3U"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21e45ece781so2777134fac.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 20:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710731323; x=1711336123; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPTd4dnXMecgQjiJzPtW5uJSUKxggvax995lLZUuQlc=;
        b=ZZI4Bk3UKyafUnuzkFCQZ99dV0nRjbdebSxLPcy7BaWg0em0sX+d7zR3jMl+6/h1Dr
         G6KG4vufV9ugSyW/vuCRzu0409W6EYU2qRZA27a8OEeAP6Ht6vjCRE6sAXVAkwJljp/w
         ZLIxHm1XF+lBz2+9mfcWmBbyE65RUeb40EfUWOULGnePqOWXqc0cdy8Lc17f330rZ9fB
         KagPSkcMfpinRNj4llbERjGhKvg8IBfN+cQzJ3rMgIcFyNSDy8mF4IS5OiPH/GaLtawh
         tXWOtXIa02OthzyxNfJeQtSXPb5S5OCbdN7Hc/aD6mRbnDe7schqQ6jiNUFXMn01zloQ
         2ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710731323; x=1711336123;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPTd4dnXMecgQjiJzPtW5uJSUKxggvax995lLZUuQlc=;
        b=MrVkqbTSlvslmdWlLlfQalVNrEuCbcEt6VfP6ipMcoEcJ935kKK/G5bic3ffZ3un7x
         VZo741p/d0EizRMWSv0riKFSYNAiNR2a8xD+ctcVBcirwLmVV1yvKSca/P9DojDpMVGa
         uQ4rcYX7+Cmme/Llqaz9cFj/UO3XHROwspn+dcXRckqsJp1WumQe4oRhrEJ1TGhABe4l
         z5//NVkMjtKzxrIlG9uKUuIn3T3Jcic9woEMWtYhp7FH/qgXjlFrE3KX7Z8shJFFmdOX
         MJmbctbhDBYCCOz6iQ66Xcofnem13KqG/XPJif3QdvI8N2yfXR0nUJgtzV3KCQriaS78
         iAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXj8H4gsw9nEUlr+jjwEXAVIsYutPCfPE6KmAglUazyiApEZhKKQbaJVWzMDobqE/RQiAqte6Uzia2CfUzuCOmN7TuI
X-Gm-Message-State: AOJu0Yz6ceL9KOXon14vVO2XhP07UpfFKeqyv9Fww4wLkOLjGCmtnPRD
	Lrr/s6/FZyJ6iEs5x/leG1AN/Wl2T69HCj88ZERpn141CfvBGHQFehxYswVbJKesIElnYa1MMsn
	T0mFnTrzzAtKK0Izekx8r1nlD3Rb4IHvktrSCSQ==
X-Google-Smtp-Source: AGHT+IHS+qmv/pTfmpudX47yTDoiBzvDpdVc/8cjLrGzjV0gfdV4foiOf6PEX0Ix1s3YAJCTPLfa/flqEcTMl/B0zMs=
X-Received: by 2002:a05:6871:7888:b0:222:bbb5:83f5 with SMTP id
 oz8-20020a056871788800b00222bbb583f5mr4380995oac.46.1710731322611; Sun, 17
 Mar 2024 20:08:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 Mar 2024 20:08:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240313223751.50816-1-garyan447@gmail.com>
References: <20240310162614.62691-1-garyan447@gmail.com> <20240313223751.50816-1-garyan447@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Mar 2024 20:08:41 -0700
Message-ID: <CAOLa=ZSijjnfa8UEEWPi8Cb7Q1hLbgrez7VX-LxshmUhNM29DQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] Optimize ewah_bitmap.c for efficiency using
 trailing zeros for set bit iteration
To: Aryan Gupta <garyan447@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ca7b850613e6ace1"

--000000000000ca7b850613e6ace1
Content-Type: text/plain; charset="UTF-8"

Aryan Gupta <garyan447@gmail.com> writes:

Hello,

> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> ---
>
> Thank you Vicent for the guidance. I am still not sure how
> to do the performance measurement for this improvement. Any
> guidance would be appreciated.
>

I guess there is some off-list discussion here. That along with the fact
that the commit message is missing makes it really hard to understand
how this is better than what was here already.

The guidelines ('Documentation/SubmittingPatches') also state how to
draft the commit message. This patch only seems to have a title, it is
recommend to add a description as to why this change is being made.

>
>  ewah/ewah_bitmap.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index 8785cbc54a..1a75f50682 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -257,12 +257,15 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
>  		for (k = 0; k < rlw_get_literal_words(word); ++k) {
>  			int c;
>
> -			/* todo: zero count optimization */
> -			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
> -				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
> -					callback(pos, payload);
> +			eword_t bitset = self->buffer[pointer];
> +			while(bitset != 0) {
> +				eword_t t = bitset & -bitset;
> +				int r = __builtin_ctzl(bitset);
> +				bitset ^= t;
> +				callback(pos+r, payload);
>  			}
> -
> +			
> +			pos += BITS_IN_EWORD;
>  			++pointer;
>  		}
>  	}

The bit manipulation done here is slightly hard to comprehend, it would
be nice if you could also add some comments as to what is being done
here and why.

--000000000000ca7b850613e6ace1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e01c932345ae05e1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YM3NEZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK3ZrREFDVUhtSmlXSmpkbDNUd0ZyL1ZuaXI3bGRkWQpCQ3o5UElqSW9U
ZmdKcDZnc1BUWWJzYTFWT1RZR0lkUkt3ampEZVBTaEVvVG1sa0J4b1ZXSXR6dkhJK3NaQmF2Clh5
WDNiSzRibmVBd2J6N1hGb1d6S3k0aXlSNlcxRzgzQTVhU051ZjFPa0VWdVNzaHhWSnRZZHlqeS9S
UTZLLzIKaG5zVXNwSEtLQWNpQ1pEMGYzcnh5bTJabkd3WXE0V1NWY1hUbFNZM2Z6L1d4NEJsajNH
bHlMQ2hYdE96UnF1cQo3QndOVTUvWGw0Y1JFTXpXY0E1em1HYURPeG11MmNSWGFtMDdZQVVjTEtV
OTluN1VXcVVsak9sMXdneHV0aUZNCm9jYnM1d0NaSGVGWE4vS2dKWno0NzRGZEppVFhZQVNTK0w3
d1JlY0o1R1ZtTHpwYlNCaGdBZzllajhGL2g4aXcKdjUwUlRTV25oUHJYNkdocGJKYVdhYWNKeTZC
Q05PT29hU0hiY3dDNTRhYVdaY0ZlYUFlT3lSN3dhaXltN0RzaQpzS3lXUWxUWXZXUjI5UHh1V3hT
U0Exc2VpQjl4SGQvckIyaE5ZbklVNVJzS2tVVDR5NDJ6bm4wMWdKSEs0cERNCkJFRWR2enE4K3Np
YTYybVpqc01vUmJhR245cVd5NC9WYXhwR3ZGaz0KPWlEWisKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ca7b850613e6ace1--
