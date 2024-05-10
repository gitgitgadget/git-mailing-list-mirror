Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBA15FCE1
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335244; cv=none; b=R1myN5a1UjvvorNbcV++DKOkyFYTzwqGQZAkql/QfLTxjYdCz4G1PKugQarX9magRynfqCffem/eaF7bDmVY0F0yAoFNn+BZXq4QfddCEKxOSOhs56yZsiOzNQiFWSByJtdLXnC1bRP5JojOnxDUPUHw2xh+QSUBqOJuNqtGtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335244; c=relaxed/simple;
	bh=mc+6pMarW/sV8Jr5P34LQHETs59B8Z7lX9KgD0qkpUA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=kAiTgtWuulthYiX/9RpvTv0m75iq45vv00Lqz4yOzg7gXzYjLQmVlqx+fy7hOBhlnKpXI/L67nCQAsYT8Tt5uw9O5zvKG/9Zgf7FZGP6XZnF1w+rVlv2Om1zbHnB0paBbnv85M7ubLCJBu250sRZ1tSNqMRluzTLGBTnoVGWv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgdqAnug; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgdqAnug"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f0e190e5adso653418a34.3
        for <git@vger.kernel.org>; Fri, 10 May 2024 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715335241; x=1715940041; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOptnStBXBs3IF6R3U19w7M+FiWBzDZ7vP7h3V0sJj4=;
        b=kgdqAnug7Ss0w4CvRzNQcEkOSQvn2+rCB16KlOVc4/P5puedXXlEYQGSPoqc8fbXm/
         PSshjELuKTarHJS+7fAOYmFc/KFY1prcwlD7mbgYhIgjq+XuEHskVBc1PGkAgpJVVqxJ
         sTLk332CAFEJhgilkqh6kwGc8OINUzSaFWTd2oaz4yplC8NUi2MFXSw6LYzzQjWfBYl9
         7zAJG5ORe0IJcGnIjFSgNqPTCxcrgnuaj1JwV5Qd9021WDZ2pwxryX8iL8PWdNA9B5A6
         DFaT//WQd1D3nGB0rnHLcR//n17hPSoC6Q+rBITMvmjCCizc5rFiYkR7JL8P/dD/PEpl
         TbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715335241; x=1715940041;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOptnStBXBs3IF6R3U19w7M+FiWBzDZ7vP7h3V0sJj4=;
        b=UggEZIDUuOa1f/6CfgbqrU3lc5QoolA/queZdu5BfJR+XyHpgJ29znP+TcHQYAY6mW
         nin7cZZ07k8qfOElEBxXXD5yk70RwDJUuE5E3wLHMUmiaxCxr6TV4JOw2mBhzi3dvd1+
         Gbv0tNYtWu/RTymO+fnA+niK1dID1oWA6K9Cb8O94uW3DvVa1RJ8ZdCDWv1lNwoWYX+N
         sbQHPJd6T/pg43FObEdBRzMY0Gu28u3q/OwNQGVu9AYcUvhesmrJGoezRutY47gMRT28
         oE+1x5Xu4jCjRt/k20gidzl1MRKQ5AwOkkX6ujEtEAdTPMNfkR/3J0f08ban6tHHnpUF
         F13Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOBiRfdHpSeA87Qieq02RC3euau2E7RffqkQKjfWXk8ow9qlZH17wRD1wqP9JteD8vrWnb2d32/Np0Mhv0jelNqQNe
X-Gm-Message-State: AOJu0Yzxq0R0tK2wtxOskKTa+cWLzSqkAJ/lJLWyUARtnlPJYIsXNsKo
	J7ELac1gCpwzhqPyZoqDnu8TtQJLzJh7wpq/Q/2/8+tRFMDfI30nSxpC2wBHrGBxwJDIU90V8P7
	rwM+htLxjcAuVPeANL4EKwWMoPeY=
X-Google-Smtp-Source: AGHT+IE6W3HzgY5f+8/VrEV6q5ZR4hQtYYEu6U9nCGHFtKIzYT+bLCX3feXZOeIcyfdmZwyWsMsLgKd8worNqC96jsA=
X-Received: by 2002:a05:6870:51ce:b0:23b:caff:be33 with SMTP id
 586e51a60fabf-24172fb38f9mr2337377fac.49.1715335241628; Fri, 10 May 2024
 03:00:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 03:00:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 03:00:41 -0700
Message-ID: <CAOLa=ZTz5k8Ge8Ba1f0AUXE1NRE1sO_g5zrtTeYcthKP9VVeCw@mail.gmail.com>
Subject: Re: [PATCH 00/11] reftable: expose write options as config
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bf8fd20618169b33"

--000000000000bf8fd20618169b33
Content-Type: text/plain; charset="UTF-8"

Hello Patrick,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> the reftable format has some flexibility with regards to how exactly it
> writes the respective tables:
>
>   - The block size allows you to control how large each block is
>     supposed to be. The bigger the block, the more records you can fit
>     into it.
>
>   - Restart intervals control how often a restart point is written that
>     breaks prefix compression. The lower the interval, the less disk
>     space savings you get.
>
>   - Object indices can be enabled or disabled. These are optional and
>     Git doesn't use them right now, so disabling them may be a sensible
>     thing to do if you want to save some disk space.
>
>   - The geometric factor controls when we compact tables during auto
>     compaction.
>
> This patch series exposes all of these via a new set of configs so that
> they can be tweaked by the user as-needed. It's not expected that those
> are really of much importance for the "normal" user -- the defaults
> should be good enough. But for edge cases (huge repos with millions of
> refs) and for hosting providers these knobs can be helpful.
>
> This patch series applies on top of d4cc1ec35f (Start the 2.46 cycle,
> 2024-04-30).
>
> Patrick
>

I'v gone through the commits and apart from a few small comments, I
think it looks great already.

Thanks,
Karthik

--000000000000bf8fd20618169b33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ed42bae51682f196_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZOThFY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTBPREFDRzgreTBSN25zVmwrT0JKMUZQMlJlc0swdgpTTE54ZmxFZGd2
dGZ5STJWbGJ6RnNXbktaMkJOWVdrSGdDUk1zdjRwZEFTNUVVZ0tpRFptUHFmV096VSs2S1Z3Clh3
SEZrV0ZaUWdXbFVjR000c2JvK2h3VU9PZk5LUUVkeDVoNzJDSGFJSWxhcXI5dzZvcnIxeWZjZTFm
Zmk0Um4KQ25sUDEzWFl3MGhnOWFaUDVnamIrVnJ2Z0NRc1VwdXdqcExPYzhiMUMwMzZaK1dnbi9N
a04yQllyNUpYOERZKwpSS2xxN1VGVUd6WDZrSHQ1Rmdlc3E4eG1BUi9sb1JKU3E2elJNYUY2NEVU
YnZBdFNEbVVzbVlHWEd6SVhIWk5KCm9PQUQ4NkFRbTM4MGhDY3UzcGVzY1NqOWp0U29HVUJNenNF
QTVMYnNKK2NkUFNvRmtZMVBoMjlBQ2I5VTZob2MKZDZydC90TllhQTFzVGszOERkTVBVckx4Rklx
YkxwTzJ6dDQyN0FiL2tCRGdYa2FkQzZUK2RXUHRPRTV1RDFFZgptamsvUFlPT3NTV2VQMVV2dkkx
UjROdnpHek5zNE5LZWkrMTE0ekROY0RydWMvdk56RXdtOE1RcHBlaXA2Vlh6CkRKb1VOMkxCWWhy
TjRmQVBGMXZjVDllYk5ZS2RtcVhsb3dLZkd0UT0KPVNiZksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bf8fd20618169b33--
