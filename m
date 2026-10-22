Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792660440;
	b=EWCFG3nGQclEBE8x6ZjRKYIxMCQ+k+/HHdlqgBrWxXBXrxqK3eoZls97h8WLkdqPKLpI
	 UoIo7Ilrkr1Mpn0L3TSyu+w4OD8DCEr07i0YQfoxGeFR4KkoKnzfD043275Btg2q+ejEU
	 OCRP08nnlAC+mOGMldGMo7TtL8ANBIu5ziwc6Kwfy0n3+0+KLY28sEfgg5n1JtZZZ5rL5
	 TvWPEGV2rAZlFUPe6YMBjUAesXKawEFWoaW3+fLka4EloG87LaE42K6VlNk+iFxJ8+Tyn
	 UxIwn512dpdj3r3+fSQ9FdXnbf0qbs8b9JGl+yVBJmIyX7qHPp57N2pDUvQyu9MjC/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wr4gJnEkG6BKHsFxdmtfqs0x+4X+/mQyCJlWCYXOs/M=;
	b=NDXM0HH9dVqYuy5qEoLtLV8PP/jddguG+IDGaYe+ggkEMLKazwRT0c6SlkBUIvwlrvtA
	 x1vfqgcBXfC67IS0G0zMhOLoqMHS6g7ntc8s1N3v4VQjZcc7Pit/mYCmreolB/25H87bs
	 tJBAzm52NsMR3ujXjQSBThy6y20foquWnJsJtzqCmfqNaulAw8Uy3SI6Cp3GoHK09Meul
	 i53BVqR+pxADb5pTYbBzxRp8BHD/GED6ljtCFdJ0F8xldfHpY/nK8Ii+lKt9+dmq/GtPj
	 duvJ4RRULiBQRdxw3tnGJvAiIDaMuPYnR/S1vGEN8GpaIuR7CpUxxj3Os43g7D776Iw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAVcqzo3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.54
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF21606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 09:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FF21606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DAVcqzo3
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-988c7371716so588230241.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660439; cv=none;
        d=google.com; s=arc-20260327;
        b=L3oX6D86iLBsoxqQ3c56lLWEDVWCiIuJpbOeWeks+UKj5P8oFDcAmU0J71Ym77aJvO
         P+kBs5H+dgqHRWXgTfXtm7FZIWsYW2fINxWayosGBSJEolkxXOVWUQTcUfRh+qUaD/df
         2xleecrabhwmv/Wo6HD2MnQyF0x5iI1tF8FCp6Jz8deHmwU5+f234rvbr9Inluw7dTsj
         P1FHNr96QOG74Dq0axigxzKtyv9yW/yMZYQKM7TuHS2ZGY815QkQgof3OPysNx5iCTPk
         c1KJ9x+cFMUPQP6ATKZ1Z8vWOqcc3RTQTphzLxotwVZoBXk7cigJRqWc/nnSrG0c8tzy
         muzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=wr4gJnEkG6BKHsFxdmtfqs0x+4X+/mQyCJlWCYXOs/M=;
        fh=amaa3UYkmzG0k/kGfe5S9gzvn/PWzEuZfns1NfhlYd8=;
        b=KDm+1ykYK+r81qOkOh0RpmRForEvPDi1Ez+uImwNmIhL9eZgaFcbBGNG1JHdlqksqz
         FsPZJHt7tztBLzKv/i8gulalO+bEL7qKbXjOqGDulSRBWrXyKzoCTO7DXlAf2qtjUVGm
         7hgdJyTDSHF8XQMLL7T2GMerGWpk/kCOOS5CAonWuCcv4fnrIMjNS2XcXxTShHlYrLWA
         fal1ZFFD6fRDIzG4W7sSJamzL5oCo9AVvQafUqbBmlPfAGVkd94cPABfzUUg4corfuxe
         UbVt9NfnL6lWg5lCYslFvF5MbU0TAOEp9uLfkUHjIXXLZ8vd2xdI/HR0UWuGCt8E6PZ+
         nglQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660439; x=1793265239; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wr4gJnEkG6BKHsFxdmtfqs0x+4X+/mQyCJlWCYXOs/M=;
        b=DAVcqzo3sd1iShZ7BN/vP5EG45T+kZIXtbXEfcnnKZl2NKf55mQgK+/+aM8YiMXw8K
         uPvaKwPbwANAO+Ig/tMP8W/aZk29phBO90L6GBVPwgUFbQP1HtgWB7gnSNxdRX4PWOSy
         Cpi7M31PF09270HiL075H2w8C7T9DEUgLEHPcBRZ6iCBbvZqgdtZP0iPJ6tWDP8z348k
         IRgumh8zyQvQZBozQZW9O2h3MNtpVuZDU/EHQz+MgfnUvUs8xNNsCMJMYxbOIsK4Muwp
         dbrqZvoK9KoD57DNjfCgnHDe6boOsGL9df8T2npe0ANENubTj1qzHhZ2aHbDMUsWoQxX
         G4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660439; x=1793265239;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wr4gJnEkG6BKHsFxdmtfqs0x+4X+/mQyCJlWCYXOs/M=;
        b=kd0wB9LBirajDP7QeAFrnKyZ/Z/Vvj8KXtXjUzqrWBt8M/IaAqCJifz1CRvTDferxZ
         ZoIQqqRXj56v980P0ku4zTaIS8erzrw4zh8nFIehZOlViIejJwdsOSnRYbqiqErqqeBX
         32m1a3lOKc0lnEuG3xW2etSubtuDL5n8C+VPF9o5xr2ELTzsNQlsNuC6E8Q4mPYmRpin
         pJDZ74zwYhTuhxy3rnRGPxhjXvwHK6Zz3UvwF36pSODQhqRLPIu2xj8m/VE5ITF+IxV2
         1e9bfJuT/1LVCE38aFZPNKGDOmSdXCChja+ekqN8iseuFLZDa29s0B27SICXTDVBOi+b
         rWAQ==
X-Forwarded-Encrypted: i=1; AKwUvBybMZ07wWlzfKLVHdnutj7Omqrc15Icr+/cXm3pwqQCE6Ht0ynCCbDydU8VFH5zQuledds=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcymX/Wu3FrTgyZOBdCY+4DgTN/bZC2JxrRw2CVF8t091XmbNO
	M4O6im8Det/U6QpR28p4aNCyce7EXNvkSV5kwZfgoNggZ1o1TbSntQAyUnul8n/nTCvOWZ+aduX
	nUOLnd4uItQBcRNXna7WeHTpWops+SfQfoA==
X-Gm-Gg: AYBFou0710fktZqRifRpxVefmipePAp8/yCEgnQfFeoe1LVAK7sM3VzVPP+zSvn/1FV
	n5O3pdHV8nSSm1+Jax8GOBUwaYJrZ6oM74gW5TgU6rfWJWzIVkeQ4PGvgPQ3hYUy93BK1j4e+bK
	GPNw/S+VVVKnYp5xm5SGV7lAlu/vvfrDJqLe031lko7S3Rty9hO6loqCWJ6czS0uy+ZpUwiMwht
	VyhnXNydFrfAYoqo7B5tYHfMnUCxmLYBYLrSTl48gAW8zwoURNjICzZZdtJCH7qsV6vyaM7hv+V
	C1jQcp4EokNDJkv+Yq0LF9ND4gtK8VSpLPS51GlHc2O+Wk4HYKKIYx9EYDlPMD8YCCvZMZlITM2
	WvFHng3nIK/iYQPqIQcQf3Ho2bt+pxI4eIO7B9zWdlJ2DBnWWGZf7NW4Azt+7eSyaBdH/Pm4+Ac
	xjsd+eRYKp6+Rp5gQmDKdFpKSB
X-Received: by 2002:a05:6102:c4c:b0:7cc:2152:4f72 with SMTP id
 ada2fe7eead31-7cc9247ccebmr1711708137.1.1792660439007; Thu, 22 Oct 2026
 02:13:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 02:13:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 02:13:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atjAS1qQ7HyDYbxh@denethor>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com>
 <atftdOihoUHTdvfu@denethor> <athd_dTKZYOv01UZ@pks.im> <CAOLa=ZQ_sgz9e4JFWj61HNnKXx+pTvTYhENbbtRu+ATUbXxS9g@mail.gmail.com>
 <atjAS1qQ7HyDYbxh@denethor>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 02:13:57 -0700
X-Gm-Features: AclHuK9_EgVtLgrSPbJNpy992I4zNRl5uVBGXKjizjUb2RudFMo8-K4YLKATubQ
Message-ID: <CAOLa=ZShCfEMEgvYz+s-F6X9zjO7fxuEAnzrhwEtj_RerkMirA@mail.gmail.com>
Subject: Re: [PATCH v3] fetch: commit references fetched before backfilling tags
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>
Content-Type: multipart/mixed; boundary="000000000000aba69a065e6a486c"

--000000000000aba69a065e6a486c
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/10/21 06:01AM, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > On Tue, Oct 20, 2026 at 06:05:22PM -0500, Justin Tobler wrote:
>> >> Naively, I think it would be nice if it were possible supplement the
>> >> backfill fetch "haves" with the non-committed references in the pending
>> >> transaction directly. That would avoid having to commit the references
>> >> in the middle and probably also fix it for atomic fetches too, but I'm
>> >> uncertain if that would be a simple or reasonable thing to do.
>> >
>> > Hmm, I think that's a sensible idea. We should know about the ref
>> > updates we have already scheduled into the transaction, so in theory we
>> > could use their new object IDs in the negotiation. If that's possible it
>> > would definitely be a much better fix.
>>
>> I'm a bit wary of going down ad we'd be exposing un-committed references
>> which could fail as 'haves' to the server. This doesn't seem to be
>> conceptually correct as we now expect GC to not clear the objects needed
>> by relying on the .keep lock instead of durable references.
>
> I'm not quite sure I follow why this would be conceptually problematic.
> Should it really matter in this particular scenario whether the tips the
> client advertises are committed or not? The required objects should
> already be present in the repository from the initial fetch.
>
> Regarding the continued use of ".keep" lockfiles to prevent newly
> fetched packfiles from being GC'd, that still sounds reasonable to me.
> It is expected that the ".keep" lockfiles remain in place until the
> reference transaction is committed any way. To me, conceptually all we
> are doing is allowing the current inflight state of the transaction to
> be used to affect another operation being performed within the very same
> transaction.
>

I was getting at it from the point that '.keep' lockfiles are created
for the reference transaction to commit. So while they keep the objects
in place, we should only rely on a committed reference to keep objects
in place.

But, you're right, the transaction here keeps the lockfiles in place
until we commit anyways. So I guess that's okay. Let me send in a new
version and we can see what everyone thinks. Thanks!

>> But seems like we have negotiation_include_tips in the transport
>> structure which seems like the right fit?
>
> At a quick glance, this seems like it could be a good way for the client
> to advertise to the sever the tips of the uncommitted references it has.
>
> -Justin

--000000000000aba69a065e6a486c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 26cbd12e605e5b92_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWjA4OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNC9hREFDWHFTUnoyTzNBM3RwNWVpenBWYzUwSzRKSQpUYWVUMHpkQTBy
OG1KYzFlQzlYKzJWS3IrSXpKMUgwRTQvallTKzBhODdCVlFjb05PTjlLdFVmYThJUDRvZzBGCmFt
ZElpK2UwYnluTjZnQ3ZHbWdjNjlmVHBRMGQ4c1BJWWtBa2Rkd0FTNEszOCtVWGhqMlI0N2dSRTJj
ZThuZVoKSXpWdWhEY1VDU2M0N1VGR2xFT0wyZVVVaXlvL2ltYXhzTzkyWmJoOWtEaXoybFcvZFdJ
TW5KRkFUM2tkNDY3Vwo1RDV2MXdmVnoxUU9tVEhLK3VxcVc0dWt5NytHdFJpQm9jWFM0eEtGQ00x
SW9wODJ6OEo2V2VDbllUbWJxREZkCndldi9MMkFubkpCeHdjNEU3NkliYUFSNVNsSGc4emdCdnpn
WDkrSU02ZTNiS0w2MlAxSmpUU2habDY3bFFBamoKTVdYdk1NNjdXREs1QVdwb3o3bTBMTHk2dm9K
V2c5a2tRcDNqWUpzeTFmWVlLT3JWOWFvY3d6T0ZuTTNvQkUxWQpQVXJKTlZJRFF3RDNlc3hDZTFP
emF6MzJjdHZ5cERMMnQ4dCtpWTlOWmFWR2dVOFlpQzlrZUNHNk9rdlpYYkUxCktERFhyVkZIdUZP
RUcwcjVkMXRFNUtMb1dHU3J5c2kySUpLUGN6QT0KPXgzNHQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aba69a065e6a486c--
