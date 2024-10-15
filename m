Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105B189BA7
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978484; cv=none; b=VFaRKhJ9q5tPWRTYPLZNICRlw4UrOxlDve30WLnQzWpn26q8ZSV2QpDOR3RvXXFJNRFwPndLEqHOL1nC5ymRocwOYUMpHRg97N8cu8XW/8MMHwrWdMeXvqLQ5wkNLNUkgv5vZJ8xq8DJy+PvHM4eh3PvOMWXauL0Ij9TurPajnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978484; c=relaxed/simple;
	bh=m2MmnTLKiCkDB/NM7dSqyqYKJNb43tL2WUOGbs93uNs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMejejaaI2LX3JscxofKGKsCtCA2LGHXuAWzHf5TtlznsRqVVakf7r3bxaCTk5j2+YcGo/+PcfNxkUIQweN/g06aXOdqTVr0u0pkwIQHqirA6o43TVxuJTD1jVoebJbpDXQOsDwj2t7KbzNwR/BchjtUPtu9P107qTAuJO4a2s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOx0ECr6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOx0ECr6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so2778348a91.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728978482; x=1729583282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWOxEWDXJhilDmFKvf/d1f4bJq1V/LcDjdAoXD7Be4g=;
        b=kOx0ECr63EAANgXy90He572GDEUnYYjeNB0d/ZCXLQ2QiOIjnUIxMzh6xtwonPIH4v
         5WZYaPX6OabGdT+jKe1k9SxGiZGHYAchgqOfT9+sjqkYD5mzGBcb6kGhYtFO9t0oR56T
         uNlXt5YGT3Nmj7AR6B+3ntzD3BHdeDFJU+NQyAqLcNi1h6WUdGx9P4mVmuJo3Z9Y4U0P
         8NnNeLybJid4nP4coDT3HKL+Lao5EAeEP34aJbBBV8aUcuOvD759/6+pX1lv27QzgMsr
         qIKD54I6TyzkMWPgH+eYZX/o4UdXfFJLbwXNXsllHXxvUcyp05tS6ajH/peX6NRhKtu3
         8YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978482; x=1729583282;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWOxEWDXJhilDmFKvf/d1f4bJq1V/LcDjdAoXD7Be4g=;
        b=IfmGQ5ZaOQ+Kbzf0tgw5wkUH9TBFGZhtWR2gF9njRgOrcxH9UoI2KL0qwznaHbbLGq
         6Skhec+yPawS2OWCbM8OIAclNSexO8hZPrMSXLVIL7tD/DNCUUhJ+nU4NPawoGLAUbXK
         +/3f0aNQy9iz+iNI/L49cBOQfRrPeLhnPUnXbZMlwaqWaqYFn4pQuhf0Zc9Syzp3YASa
         5y1xG25dsnul4VaCkZ/1n3Pzh7gez9jfc5toI3B8vJvOzXZTE6wfKFQ8+K92v/WcIDFO
         beiywzvFFsXNhDGbHNVbKSgaK6V6h9Fxk/u2fPVrWpE7FLb0aPZS+KTDJHg7AIVl+Yut
         hsrA==
X-Forwarded-Encrypted: i=1; AJvYcCVypbgMw+ztndVa18L96RmGorRIwSYQbr5pY4fj1OvVUbk0NzgT1ynO2uK9XZGJ5YW612Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvw+u5OrHVeS0dVXAQRUtV7RCRTeMxk6P6bfflcJfX4mPPL7Sv
	oE9KcnN3uWbaj3a3mNNtAdsQ2XzaUCckXCFDZ8ljdYSFYBPhgTsr7om5j+56FR+Rh8fAOBDGCcX
	6s4jcu7+Jc6YdZUOTfgg84rao+3k=
X-Google-Smtp-Source: AGHT+IGGRLk5AHU3YE2L/8fio/OIwJtZTEhc6XYMKUtS7eAkvRpslnlvCh3Tvyr8p+aLvsJzIVFpvrevfQy/11psVDQ=
X-Received: by 2002:a17:90a:a00f:b0:2e2:92fe:35d5 with SMTP id
 98e67ed59e1d1-2e315356673mr14154476a91.31.1728978481955; Tue, 15 Oct 2024
 00:48:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 03:47:59 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241014225431.1394565-4-bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com> <20241014225431.1394565-4-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 03:47:59 -0400
Message-ID: <CAOLa=ZT_m=H8pW9qkoOf+b0bLnzvT-3taQYFu+J6WT3DRi=6sQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] remote set-head: better output for --auto
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000003ddfc306247f2c50"

--0000000000003ddfc306247f2c50
Content-Type: text/plain; charset="UTF-8"

Bence Ferdinandy <bence@ferdinandy.com> writes:

[snip]

> +static void report_set_head_auto(const char *remote, const char *head_name,
> +			struct strbuf *buf_prev) {
> +	struct strbuf buf_prefix = STRBUF_INIT;
> +	const char *prev_head = NULL;
> +
> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
> +
> +	if (prev_head && !strcmp(prev_head, head_name))
> +		printf("'%s/HEAD' is unchanged and points to '%s'\n",
> +			remote, head_name);
> +	else if (prev_head)
> +		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
> +			remote, prev_head, head_name);
> +	else if (!buf_prev->len)
> +		printf("'%s/HEAD' is now created and points to '%s'\n",
> +			remote, head_name);
> +	else
> +		printf("'%s/HEAD' used to point to '%s' "
> +			"(which is not a remote branch), but now points to '%s'\n",
> +			remote, buf_prev->buf, head_name);
> +	strbuf_release(&buf_prefix);
> +}
> +

Shouldn't the messages above be marked for translation too? using `_()`?

>  static int set_head(int argc, const char **argv, const char *prefix)
>  {
>  	int i, opt_a = 0, opt_d = 0, result = 0;
> -	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT,
> +		buf_prev = STRBUF_INIT;

Nit: these names could definitely be better.

[snip]

--0000000000003ddfc306247f2c50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b369ff6baeaa85fd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT0hpd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memlhREFDSCs1bng3blZLZkY5b0pIR2FmR2kxT2pKUApYNXQzbjBLdTEr
SmUxR1FZVEoxRUY2NXpBOFFUOEJ6WFBiUlZFc3V2eUxkZDdoUlpvam9GSllTV1ZVNVhaRjZqCk1i
RVZneVVmTDNlKy9vdUFodnZEL3dpeVE1NlZBMVJWa3U2clQ1ay8xNE11S3Q5T0JuS1lSSUNRVGlX
NllHWncKazVnS29qWkhtMFVvM2RtNzNReEQ5SGF0TVJJZXZ2TUkxV0tkTkYwQitWQ2J5MGJycGVP
QWF5TkxmeTFIYmJwcQpaditpM2lQVXJnWHhIN25jWHc5d0VOTjJ2NUYwcFJwZ3NZanBlVGRQcVZI
bi9pVEwzalg2SGZVWXNOa0FneFFsCnFoaVluNFE2aG9MclNPanFzTjJodFQ2OVBsdkYwSTBFT0Vm
eTlDa2FEQlJ4TENYS3J5NGhDWjF1aGlvNFFyOGkKbVVUbkVlZ2xWVHVYRG5sVXBEalRjRndpUE1L
S2xzcXBuS1g1aTNRK2ZmVTRUbmRmK2JPendGcEl1eFcvemFKQQpRMTY1OWNSeGdxd3dYOTZDYWE2
QVNwelFRZFJLaFBLWmVpeGVONnlrUXhhOFpkUEJKZzVQTDVlOGcrREJSeWpNCnJSY3FNM2pwd2FQ
UFhLbHJTYy9Yd1pUemlPbjZ5QU1xL3FGcXZPND0KPTQxdTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ddfc306247f2c50--
