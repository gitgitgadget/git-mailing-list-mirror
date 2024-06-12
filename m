Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276D16DEB2
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185767; cv=none; b=Eh+IRiRnwD9gm3/WDJUv03ESbir9kv74taOsU/zREcyjM0qgMId59USyvgp+gsDIhbuO7y/7RbiIJEqB1JE44G16w4LGzabYt47mATBzZQJAqNk4eVPd37WQWmbCr2yA5mtTie1yhXxJ4Og/cYpvyBVfV6qQMjHtI0wbzLmwGng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185767; c=relaxed/simple;
	bh=dHeEp0pk4vzBmTBLbP28y72TwA0CB25AVvQdjA2x9+M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrhuF2eAo1bJaPmN9ad6yXne8JlUdrO2VYCMlDqYWeeLEejnh1+Gv4EDldX8y7erjSioXqVz9tM0w2HIJt7GeP94LhKgxaXzlUTprFhUDcsOJWajCAX5l5x9lKiY7OmhDxZtssYHEOHPloFMW0VaDR6K1PLWW/Vf88fZ+irG2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6W0l5lk; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6W0l5lk"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9b94951cfso3813165b6e.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718185765; x=1718790565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qy4jE9jdZHA5hNSzfiv/gZ8ZeGcLHMzXUI2k3AxIYZg=;
        b=Z6W0l5lkyf0Wffs0sxL0r26XMOXDa2LhrYGrg1Lzs2AFw31HSdltIYDVw8E1n/PCeE
         vv8wsilHnGok0QGdHZjQe5jp6TwfayL3iSzIU0r+dFtL1q979RnYR5mDRcpQSpPAmD+e
         abLqJmLj3r0aX9wNsOoBNlxM9amCQl1CwNRE70iqzrkMT/GkPu1TxF10jsOaZK0mIeMM
         jRc0pOxZoAa4gHkQPzW+ecH6C/maOHLqOG6vuHTVlI/xrBYXYJcQuTJcxEUZ5/7bY+Iv
         oruhapVvDJnzn7tGFxaIsfemt2nu760Xs9wxMN202CN4u8GPvrjEsjYyS5/YZTZsJdyv
         289Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718185765; x=1718790565;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qy4jE9jdZHA5hNSzfiv/gZ8ZeGcLHMzXUI2k3AxIYZg=;
        b=T+WyF4mB7yF5SivrHli8Q0nZmfMYl8I139u23S5AWtUQ+s+h1J+TaZ7WEBx2kqO1sv
         9Tea3oolpIgkd9GEUEgN/kyI7ZcYV6XfmRxf7J5Uk6LhiKwvA7cMCLdKiIYEnx+OE4S8
         td1JZyOd3s76uZm+qZf0eXSCHYDCwI8uHDIcm4y/N4JlzoPG2JUoH2ZX0ueh7Gh3Gd2R
         TeaACxyLNAl5gwsaDKSw1l2rDtEheqV9KFoJuaN2WXsdk1hv6nXvqj3PedUIuOqcp7b8
         IImbC91p9yfIImI0cTU9js4Tss56PAZ+3w449JpmLTMaoqjKd4NkeugNUhGXoU4FX9j8
         Fsgw==
X-Forwarded-Encrypted: i=1; AJvYcCUw40pY2r57GNgQ8AXl25CMf8FCwK3lTSXgqVJ6NVFJkeC07eJYYJVpRuHcuqZRwLIzFMY2iwx4v2ltnttcbwNZ9z1h
X-Gm-Message-State: AOJu0Yx/P1KWHRlQSFMESJ8CkwV0VyT25VF5FHfXV7AHtOPSHZeIqcuY
	QM8hQTW7cBKUaqTpuTxk9gxr5JMaddebVEmg2zrckdwRedEhEoKMxJYcN/pHuMeBe0mkiOtSB9D
	kAYytt7RqzbFzcKHGmiqZezBzyRE=
X-Google-Smtp-Source: AGHT+IEeNJnL4FWv/sHGRcOPqPrBp6Blal3FOYxOr1tGmk2PTvfGaZXpBk2HvyIoxpklrJDzN+0pVs5FKo3yiQgEr44=
X-Received: by 2002:a05:6870:420b:b0:254:b299:47b with SMTP id
 586e51a60fabf-25514ee5705mr1350852fac.58.1718185764787; Wed, 12 Jun 2024
 02:49:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jun 2024 09:49:23 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
References: <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com> <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 09:49:23 +0000
Message-ID: <CAOLa=ZTgP+OwVrT87=og4tVdhsqjErMUJzCuT9bdDatFS=J8hQ@mail.gmail.com>
Subject: Re: [PATCH v3] date: detect underflow/overflow when parsing dates
 with timezone offset
To: darcy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: darcy <acednes@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002b3659061aae4c4e"

--0000000000002b3659061aae4c4e
Content-Type: text/plain; charset="UTF-8"

"darcy via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: darcy <acednes@gmail.com>
>
> Overriding the date of a commit to be close to "1970-01-01 00:00:00"
> with a large enough positive timezone for the equivelant GMT time to be

s/equivelant/equivalent

[snip]

> diff --git a/date.c b/date.c
> index 7365a4ad24f..95776c8a92f 100644
> --- a/date.c
> +++ b/date.c
> @@ -868,6 +868,10 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
>  	return 0;
>  }
>
> +
> +/* timestamp of 2099-12-31T23:59:59Z, including 32 leap days */
> +static const time_t timestamp_max = ((2100L - 1970) * 365 + 32) * 24 * 60 * 60 - 1;
>

Nit: but since we're calculating the number of years here (2100L -
1970), shouldn't we also be calculating the number of leap days instead
of hardcoding it?

--0000000000002b3659061aae4c4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d24c542f3b531b7c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1acGJ5SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmxCQy80OFlPc1J6Z3BycjFKZ3JmZmNJbkpZK0NmaApjLzlWSFNaeGZs
bG5BN280TWhONEorbDA1V05MNUJ1dnBwczlTNVkxcnR3aXU0RnQ3TnJyaU9pNjBua1E4azBKCjVv
NXdSRlRETVJiblpxcnd5QTA1UWNxaUN5OHFmM1lzWGZJMzIyZjJwOFNBeG9pRXdockhzblVDUUxH
ZnV4a2IKczZzUFlhM094V2pIZkxHUmhHZXVQendTdysvU21peEJQR3JKTUNmZVJBb2R4Y2IzREVh
SW1yZU96UjBMY1l6SQpqaG83MkRUQlN4ak1NSE51UVNQSmE1L3Q2USttRHUyeS92WFRPZXFsTmp5
TXM0NncrTGZnK2VOc01FVWFlSjRmCjFUcm5BTi9aaGlOaWg1YUNMUys5dmdudVBoeDdEMGxrYUx3
VUZvRXlPTWRPWkcrY3h4MDVPTk9jK242QTd5RGsKR24rcnVSNHBpTTlhYXBiRndtM2grbENJU29G
R05HNEZKdXVaZ1RlZVUvWldzeHJwU25JMUdsdzBKYmxSWlYxTgpBMGhlQmFFb3lZTXJybEZCUDg5
Um9HL25yUGN0UW5XQ1g1d1dkWVNCOTA1VHozdFJNUWo0dDBtSFlHUHlqMDlFCit3K2tKR1YvNkRV
bWN4MXVJUisva1oya2x3cDNvcDNOTHdhNE9oUT0KPUJFeDIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002b3659061aae4c4e--
