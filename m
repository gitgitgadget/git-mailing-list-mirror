Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92ED1AF0C2
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368531; cv=none; b=MVzOjzwrfViBQLMO0sAGkvvoBVUWb6YjI+cFWK6J7AVfTiJxVz3Nbcnwsb/BO+n8Ep6VTVW2e7bDjbsLdvAcWnFmsowZJ1mhDJttwL7YR1uFxQ+tzw6R11bkCuYijdGtFmKYcy3KWaMVynL7RC8DQeaB/w2glOu6Ln0DA/b4P20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368531; c=relaxed/simple;
	bh=tLMVB/EpO/SDsOzRoZVnLAhzJFGIs9pqK36TLqpk3/8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omwA8VwRK7NNRDWd6EPaczSRs2KeeR3ynzLdl6IvqkHnM18tZ6Df59HbMN+Wq6hDG1RNTHRw2e8UEUyXk6g9thde1BWZxReNZR5dI9qnhbATBYkx4M9mBajCjjpcsSznxYogtJqVjiWheFTB6nRzMmepBvWP4jOsMX2RvI0Kjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoWaLRQR; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoWaLRQR"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51882748165so1379078e0c.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 02:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737368528; x=1737973328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLMVB/EpO/SDsOzRoZVnLAhzJFGIs9pqK36TLqpk3/8=;
        b=JoWaLRQRjLGMDCqxEPaMlhTnEp5RHL8nC4yYdXBRvLGpG8RHrz8rbvMfsbMeiUCfEP
         CFwOJtMqYZg2c+FCucVOLfxGBd59xIUO8ydKVjo2TEw8FR4uT78+OTn8WX328vgJ4c3q
         GjoaCTbxDjiSJKOIQlWNAvzZnJ2nHM4eNudEQ1BW/uvfjMKGXlezyUPJRv7hcXaDrfPQ
         K7RIXIAinBQaH3A+dz1wdn5fzxaT6C8f/c7zbkVUAh1XHp+fu/2Q1C10v2+KlXYOyOpE
         195/kmGOjrpmnwzlIKqNLHtHkugRnF4y+ENnKRbJ068kDesDpuHhhPOZf3OlTRytdR1V
         4UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368528; x=1737973328;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLMVB/EpO/SDsOzRoZVnLAhzJFGIs9pqK36TLqpk3/8=;
        b=nzZgkrmH9ZHXvcVsoSmSNfhIPeMKCYOPhFrTr9GV5P8O8QdAuQPfP3iWav65sO8wQJ
         b3RLvWMz6nMLXxaG2mublXQvgwa3ulAH8Kvh7Hx+bMEua7dwL1IX8xZOrZ2QiIlx+70H
         MmY9ywdlcIQu/bCCHagsT+Vnm0Z4OzngWwL7QEWbZ6WJ62OpiEugcLzRjUY5y5j/jDya
         0T79/xTsKs+3vFkwgrY3+8mXI2yZG+iYKq1Lfc8yEPz0VgNIe/9/e4/Gs5v5Xqzg/1c1
         pVWZqguRRQvWVKN5GBayiifHMSxBgDNSV6D18cqhx3vfqJ8Kw6xUxNV91f0h49mbZqly
         O/oA==
X-Forwarded-Encrypted: i=1; AJvYcCUl80dI9w4AQTJbulNPtxLPWh+F9K6sA/pq9dkqk1NdfAZ1C1MauDIUq45l0Y6ZKRqB+Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmN8RPqrWwjq2afzacOkXIEDX2ynwLDu9DpycnUISyno2wNhw
	4bcVbY/RA3ffPEcjnwP07TSERahh1nJAMNuaGdOGDtYU4ncRyJ5pNBwDPdx9jxfnAA1Cv3nh/Ds
	twpwD/Yif/SZlnKGQcESiRzUFJck=
X-Gm-Gg: ASbGncsaqHXfDclM+wie/s1OnwS9fj+4nszQP9T/sr55qOi36OVMn+y6TkT/z22V8Az
	fHSkkx+m7YS6xDLCgO6hL96Ye6q3LQqU6HmMtrSDoMLYhilrJ1IBG
X-Google-Smtp-Source: AGHT+IGlLEHy2dB8b9CaWKSLvS9/d6RwNjvDjZcjZm9NeaukHcHdcWjuQHiwmhHJZ2gMMTQuzfvZ0/y8Cq88XDHGYAo=
X-Received: by 2002:a05:6122:2202:b0:518:97c2:f21a with SMTP id
 71dfb90a1353d-51d5b2c274amr7465086e0c.6.1737368528371; Mon, 20 Jan 2025
 02:22:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 02:22:07 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250117122926.101749-4-kuforiji98@gmail.com>
References: <20250116161559.91038-1-kuforiji98@gmail.com> <20250117122926.101749-1-kuforiji98@gmail.com>
 <20250117122926.101749-4-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 02:22:07 -0800
X-Gm-Features: AbW1kvbgpkQbt4_70NZn1Cfkra_TUGP0WdAcatra33rloi0CqrNjerPyoyZD2X0
Message-ID: <CAOLa=ZT=8V6uP7r-qf55772KEXmEj5H0xJWtsfGWt+Ptjb9YWA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] t/unit-tests: adapt priority queue test to use
 clar test framework
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000fa6ad8062c20a139"

--000000000000fa6ad8062c20a139
Content-Type: text/plain; charset="UTF-8"

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Convert the prio-queue test script to clar framework by using clar
> assertions where necessary. Test functions are created as a standalone
> to test different cases.
>
> update the type of the variable `j` from int to `size_t`, this ensures

Nit: s/update/Update

> compatibility with the type used for result_size, which is also size_t,
> preventing a potential warning or error caused by comparisons between
> signed and unsigned integers.
>

[snip]

--000000000000fa6ad8062c20a139
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f6594ea01bbe85a8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT0k4MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHNHREFDZEhudk56N1BwTEErN3AzU2hSN1MyUkRvRQpKa1V4Sll6b294
cVEzNHF5c2VCNjRwVDFVK3YzWHFvTmRjb3ZiQkJUKzZNalpKak9pS2tabk1sTXJnMlFxOFllCis3
ZzF2T2ZlT3JlcTJjNW5vVWg1Q3VTQkkyV04wRlI3eVpDUGZSbzNIRGhDbUFBSDFzMzZUYmRScmVU
alpEYUYKaVpHT285SDBNc212aGp4RTFYWnB2WkI2d1p6MmJDcVNzM0ZmZmJKRkRrSHI4ZXBhRjF2
TTE2aHg2ZVV2K0U3ZgpRcXdvc0pBblZ6NWx3OEtqeU5RcVMwTndseWlJZGhuV2ZTNzhkbTZEYWpj
SnFnSisvd1hmd3BwejJab2lGVGptCnB0MVZOZnhGRGdENyt2cU9hcVZhSXViZnFBbkRVb0NjT3pq
YzF4bUJ1VFZhOEN0RUhlTGpIcTdhVFNQVG9HYmwKQlVnT1d3bS9ZNEY2TWxXa3RKTjIyRjBsNml1
MjhaLytaZytsUHZEUFhqTVVHdlB5V0ZSK0hhU29KTXdSTXlHLwpOWDhBYW44QWVCd1hPYkl1QUFW
NDRNME55eUROeWtOSlA4cC8yb1RLbjdicnNETkZxK0NrTy80VGJ3MGJ0N0pDCnE2cmd6cDJqYVdP
SnNhcENRRnFzbUJ3TzkycUgrNEp5Q2RLZEp1UT0KPXRza3IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa6ad8062c20a139--
