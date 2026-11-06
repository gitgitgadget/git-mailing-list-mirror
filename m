Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793962276;
	b=c4lFgTL/fAd3eGz6SWbU4VcbDme5L7uWNVAiWC7D0w1oDMBjAbazCkJCE0Bq8sbKkNyP
	 E201dcjEmpxVx6vMViZiqLD0dGfWHnZ84P+NXDRxBtdkG5inZulSEkZUirOW08ING3yQt
	 tIqzIKF5ybCT1bABVlc5sej4wpJbg0JB8pWnv6s1LFp+RhcCsltn3QVOXp3DyS8b4ciqR
	 doAxtK0rFe+lGR2tBEZUNGZzVtOMTkv2vLDMpnTyMefnXci9yl5J9KEjbl0Bupv3tPXao
	 OGwei4a1CXRT7HCBV+8v4s7f8Cgrq8U7kN7k4TwrwUJUdZJSPbyiQmrqbg/WSuFGtdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pTwDHNCcXB+0AxlCujyU5byOYvOrFcJse11dXUF5IoU=;
	b=4SaGqVvDboHMA9tuUM+Tp5LveVOIJUCQrkguGuh3qgvpgcwyeRsupAVi0QuXUJJYnMNG
	 O1QvfIG+rtypIDqs6u/Y41aoOopKIceh2Ahg5Ic9l0d24eiwcLKwonrz374hx+k5O96kG
	 S1NXkjvjHxgL7ThvKKFEUKs0cz4FSZDUixKJ7wZlcB9J4QLNYdV7q3uKeAvXCO1/HZDu/
	 g/X4Gbk/Sp2QolFAEpezbN11LZMDaJriZ3+tsES8zQ5cMMdUInl9F71xUzLARJaGcjWwf
	 tg0bNPA4uUp5GfCB/ZwN15xODZqNgeprODjQFM7niePWmHbMrTmbmKMQkfioIeK+0iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPMDKBFx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6C606A32D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9D6C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPMDKBFx
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9851592ada1so106972241.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 02:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793962274; cv=none;
        d=google.com; s=arc-20260327;
        b=qbLSdiSzQ3GHHm/wjKCd5676sPMglb69v5MBDqVUiBEei9GWG6yHCm8E+l5oOwV4Rv
         srn9PmGNGyGWLCoNWWCAoLfo4w8pToXy2X+zMWhhalnecVjVXpjjZkaJvOXaoyPQ7oi4
         vtzZ7lZ2QNXmULpDGRyThfhBz1h3+Zf+RC3Nu73yncMwGV9Bh6Fw2KSeHKVoT9T/I57B
         GKZcHLfaxRQf737f/rA0ClhJV5fRwx/rPGJDlMJWO3Q0yLU9NlMPkt5xsQ7D+p4/5IY+
         yuK3urA47zb2NbwPOAZfX4laeLlnM1dxeQkK7EHlT+L9HPOOdUb2zF2yDvxeNZMQkG8A
         8yTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pTwDHNCcXB+0AxlCujyU5byOYvOrFcJse11dXUF5IoU=;
        fh=YNzuR7EwVwJoGY7YbYdl66hgEVYxKb2KDEiogPl5j7Y=;
        b=WtFOmefSWWm8NSF04kZSGvbVf2tz1JagL7Y/IOyPTz2CHJvb12j6IsusXu2S2ZUdF2
         509gcjrJnCqkPP9KiWPY7zzChM+37KO+nyaeOohpgR+3PRLLbLFmCh70nmuw1FXohtEO
         EPuwXJyDuKQrx8MvKRd5D4A2AJyKtEg2UeyCEnUOC6ciC1ZYFuNZtdaAI1salEun0sQe
         tSaUvD8zQ0QtJ8QXak1dwUzoc8I2iMx7aOyuGiEiIIDVIkw2wHRxqQJcCecmmidCDm5u
         zhEyrWklEwV3zrO9nEzpXDUi05DZoMxP2Wa/tO8faoaNt8Nh4vYjMvRWxH/yW357czTV
         G52w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793962274; x=1794567074; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pTwDHNCcXB+0AxlCujyU5byOYvOrFcJse11dXUF5IoU=;
        b=WPMDKBFxq36MGN/aIhplt5kzE1IBTI8D3vl9x099T9CsHXFBjmA/RbYtizP8Gj4/Ae
         DW+Qo2c3wWXQF9hlKTQSwJsd35o0vgPsXcvNsMPfkV2ApcvhJr6AHnawtadNuTwhWl2o
         vCQtETraIxecyyJAt+FuRwobxgjGJzXORdGLb+FrKvyrmJHpZ6i7w7oHO0tk4ocLEFgZ
         Ab9bMXgzlQ/6/seD+T75SyfgjbSmxrKzfv/FxJf713fnHVz2DRNRnF5533+c38SHdQN9
         zjBUt6JY5JzDfBdHA1/f83hLgwFg8yv3SBV2f4Punys+gJci277v/zCIP89fiG1cR1Vq
         MlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962274; x=1794567074;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTwDHNCcXB+0AxlCujyU5byOYvOrFcJse11dXUF5IoU=;
        b=lJcbryrzLQ6GHYLRtRa3kYd9iFZmXdCRHRXqqPryJJ2uGkJmEHgmMDuuZ7WxbBYWjz
         ky7o7Z8UKgxuUtaf8J70lvpjdfCRX4JtoEaoRmkW9hTZ3NL6JjL1U3YpdfNGF9FdNb1D
         3du8wiYmnPxmJkLyQd7i8tbphxp/isl/4X9MWGGBR+zKyxAsFqKgNKi+nQmurvPkiDbl
         pV8kTmGpqXPUs2CC+bvNBMrlJct5GwLLWV1zvQ4TaSvN+adSjjo4YxUIUpR7ich3bBYZ
         DO9082H+lCRXAKRbyU2ZHyHD9rlOqNIZ60qFcinhhAgpemt8yixqjmYqJD3TPeTbY60m
         PJHg==
X-Forwarded-Encrypted: i=1; AKwUvBx5Oei6Z3QlUPJv9WYMSkWNy+MnpEjPUtWgqpt+KwJF8+fOwgp9/b1KrjG4x0rpogY9KWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KPS4iHk6bBd5KsObMpo1LjWps75P17lUfB4+JUDTlJl+NJ0+e
	g/QfnP4i9Cj0f+MT1LECNvvllaWD9Gppkhc59H7ez0gwPvi63oOBSJg8Gt3rEMDxi1xsH/M4lEY
	DzP0GFHzGQDXetYtorGVShORWZPQEPvA=
X-Gm-Gg: AYBFou0l5/uNyD9ZmxKJktVzZzsUzU0stufeYcK0EwpxG1BerE736b/L2gqkpRSjuA3
	gg+0Fh991QuW+lfAaBG0aHPsC7sqV1GSJ7bUZlD19ZW/wwi7C13LIPi5sQaYyYSjZL125itaIfl
	odlnDGrpWTRDT5nNw+ytOjq6jV4UHMACg2puZh3jQRKKIPRSLnc1OoZhZTHs2QR+Sc5L+TluJAi
	/kLt11ySrEzJe7Jgke6ZQDVo64LOUtBG6QAbagAZKF54AWPQD1c8Kzgypy8ZwJGOP2CRdGw1zbi
	Uywk2TSJqAxbHuZSNyNKqIy2zYpD0qX5NpNwW3kmeCA/Xj1lE08QL3pTQOUymUPF9w9GegWBzZp
	jGJk+p0poaGT9iPb6wExM4ArjbOSgLUFKnBk/LedqrvC/cxRllKb+KRCBOtPft9gIPpxNeh1Gyq
	9C3NHaH+zcS3JGAVe9uuGJ+96WGO8=
X-Received: by 2002:a05:6102:61d6:10b0:7cc:2bb7:1321 with SMTP id
 ada2fe7eead31-7d2a526b9c0mr394804137.31.1793962274652; Fri, 06 Nov 2026
 02:51:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 05:51:13 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-2-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im> <20261029-pks-rerere-subcommands-v2-2-07d5ba18e882@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 05:51:13 -0500
X-Gm-Features: AclHuK9Y0rfer2EsVye2XJP3zr0l6TgC9NS1Dw6ivw4Q1iWHydvtJ0vFHjEStFc
Message-ID: <CAOLa=ZT6XJK_duCu5E+i-PxXzaCt-JUOsHAsTdysc7EYY3pBdg@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] rerere: convert flags into an enum
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000001f251c065f996483"

--0000000000001f251c065f996483
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/rerere.h b/rerere.h
> index dd9da03d6db..f13790c5dcd 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -39,10 +33,27 @@ struct rerere_id {
>  	int variant;
>  };
>
> +enum rerere_flags {
> +	/*
> +	 * Auto-update the index with previously recorded resolutions. This can
> +	 * be used to explicitly override "rerere.autoUpdate".
> +	 */
> +	RERERE_AUTOUPDATE = (1 << 0),
> +
> +	/* Reverse of RERERE_AUTOUPDATE. */
> +	RERERE_NOAUTOUPDATE = (1 << 1),
> +

Nit: From my understanding, RERERE_NOAUTOUPDATE outputs the conflict
resolution information to the stderr instead of updating the index.
Perhaps that's something to document?

> +	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
> +	RERERE_READONLY = (1 << 2),
> +
> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled. */
> +	RERERE_NOWAIT = (1 << 3),
> +};
> +
>  int rerere_cache_setup(struct rerere_cache *cache,
>  		       struct repository *r,
>  		       struct string_list *merge_rr,
> -		       int flags);
> +		       enum rerere_flags flags);
>  void rerere_cache_release(struct rerere_cache *cache);
>
>  /*

--0000000000001f251c065f996483
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 80e8716061b3837_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHNTQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzB5Qy85UTg1NnV4M1NRbmRXRHQ1OWx4OWYvK0EwNgpzdCsyRzBDc0xw
bGFiVmNlTWxrSG5DWUwrZjVyNlAvejFLbzZ6VTZnMkZ6bnhsYUQzaDNrVm9ZWHdxNzJ2VlZ1ClR5
dnJlSm9DcUs4bHNSUVZodDNwQW9RS2FvU0QydGxlMEFyMldLOUJvY0RyZFdTbWYxQmZwbVJuaEVI
bE1QT0YKNFhuTGtzT0NOenN1eEEvZGppaFhsVE1JMnJXQjBHUEhOWms5elVkVm13dURSakJRUjM4
Y0ZGamhYcHI1bXlSUQpqL0FiWGY4blpBc3BMQVA0dHBhc3daYjVYb216eTlQanZ0NUNWL2t2QTVX
ZFVDSWZRbWNoZ0hTQzNGbmJZT3V6CkhrM0xNQnptZmh1NkNwK1I0NkxWOGEzSFg2OWwrNHNHdkwx
dmUxUTRRbXBkV1pWTm1PZXQxUmVrN3hXWjNNVXUKVXZYci9wdTlIVGpRd2FDT3d5cjFQQkxubG43
SEhtUkpLaXJqbWtwT2EyYXptelR4Z0Mrby8rNk1SRVo3aVNqSgp1UXlIbzEzcVUxQUc5dFhVL0dL
eEdDb3FiOGNrYis4UjJBUWI3S3Nha2lCTVN0SlhBdFpPSEtzZjJOOWVyUXExCit1b1ZuRUljbVRL
VUIwZTM0QUovZXNRMUI1b0NYYjZtTU9Mb09VRT0KPVpPUW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001f251c065f996483--
