Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5CF13D278
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698578; cv=none; b=kd1rbzv06NEAw8LGA3HM1V9ZON4Ri3DG/JGFY83/WqcEgMlmC6DAVwdnPmwpahpFroL6INTLAyFUj8ZwTHr6X0LOKVJ+eeokkNTYoEQ1KCByxwclzv2IKimYD+XYz1HosG1DNJ8u/6bWKGpRSwIvxBVVKYMjf3rxHaryt0cnfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698578; c=relaxed/simple;
	bh=H7oNkSNhi7yAjSVv60ll+H3w0KilRk1tuWLjCSKnvjk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzDAyekIgxaX2nDV4fixJV+KGkJm7XBm5hXaJOsDH1h8i0GPe6IYvB4Zh3irrdoqT/9O8eUxjqOrnr78HAMUhfL+rlL1WPEuBYAg0D1HjHnAhodnZJpz6cDJl61hYQhJsa7H7i1acCTjwgFzHRFE+HgTYDZ9S0A9BQq9jUAv0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je8XRiUv; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je8XRiUv"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5152a86a097so785671e0c.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732698576; x=1733303376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7oNkSNhi7yAjSVv60ll+H3w0KilRk1tuWLjCSKnvjk=;
        b=Je8XRiUvbNLNovtfzqW/3hlR2PUosEIzvtlEACTZkMQ8r7rMFH2FyexQ7TIu5mDPAY
         Dtk0u1N/NDpk2ev7yCawbsl74HzJZm/E3mX8fS5xEPS93xH74qP5sMTjVCjFS9YH8xhi
         tU8KSQPC7tV85DoYrD1Ar6Nl/lT5zKZLWvOFRqjWydu+P6mzhukUgi9A0txO7IP1cGwc
         4EEK5rKKtszinrPXcVIlQ35aULn1K/WK9NqJ+yfn8awnbsOs0a+utdkC/r8Rx4hxkgOh
         w+mJiHF2wxaAjVMRQwHfHJ70jgFbsWM9KaBT4XmI8uBBQOOOSkD2RQvg1P4M/wl/+A/x
         9keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732698576; x=1733303376;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7oNkSNhi7yAjSVv60ll+H3w0KilRk1tuWLjCSKnvjk=;
        b=Z5+B5eH/swY7g/Zl/BCF0ZAzEhp42+ZxZjxa9S6QhiB5SSjNIx0I84Kpg2c3FWIv+g
         5O1B2rVNgNgxsRzxy12ZNUXlzgQcCKsNup+1VBbBAL9FHTzSYfpSwTI5i7YqDKBXcRK/
         d/CEcxtokvgA+NYT8O3uqFV4W556f0Vc6yz59uy77w7Yz9p3sYpqwzFkI84cq54ftnxu
         wBFqBLVm/9omWxLxgrQ5ptpvnqthffy5sG4Vf4rxO4Pf89cmJPZv2ZgLXor9kDDHvvv+
         sQqx7aKVnolTtkwPbnD4zhM54xDAHH+dU6/XwAx53+CCTuVbBR+TY58elryhkfjhUqNI
         Ei0w==
X-Gm-Message-State: AOJu0YwdF52U+rDC8caAvM5sBGm57dLzm1y4nESEefWVwYXe4ytZvo0m
	Wg63tqsDlBN/tkfoiQhCMT2Sk926I4i+8SetCLFyJ1Kbpqvfgc/nWM6E8xj8NHcxDIFdL8cqe4V
	IY5EhfdIDO+RlGt+vDW+eGhQlATw=
X-Gm-Gg: ASbGnctFyTYwIeLrojx2TlnBpeagRh4DWkhE9c9BKJnCYRCA1GaQD8jNo3F7R8U+TXR
	67OIY67uG2+SyVhPsYHLc39J17e/nusBediX1Wm4+OsWVnKSlZJQsB4+J4DGtk0bA1Q==
X-Google-Smtp-Source: AGHT+IHyZ+Y6t5ZEp5qy714HW2h1Qj0CUoELEwml3+oEddwn7uHoCFPtdNH2Zdao2vvkVp0UZfUXSogZHEbc+CBJAEA=
X-Received: by 2002:a05:6122:7d3:b0:515:3bb5:5775 with SMTP id
 71dfb90a1353d-515568ec44amr3237604e0c.3.1732698576267; Wed, 27 Nov 2024
 01:09:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 04:09:35 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <69d332a6-fee3-4801-b920-e16da730c1c7@app.fastmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com> <80632934d135bc1a5cc2fca1a69f398b692a38ce.1732618495.git.karthik.188@gmail.com>
 <69d332a6-fee3-4801-b920-e16da730c1c7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 04:09:35 -0500
Message-ID: <CAOLa=ZRozCrd_rcUq7vsmrDL=Q4mj59TzGsfJhDXA7CGUKoh9Q@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] packfile: pass `repository` to static function
 in the file
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000244c6c0627e1535c"

--000000000000244c6c0627e1535c
Content-Type: text/plain; charset="UTF-8"

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Nov 26, 2024, at 11:57, Karthik Nayak wrote:
>> Some of the static functions in the `packfile.c` access global
>> variables, which can simply be avoiding by passing the `repository`
>
> s/can simply be avoiding/can simply be avoided/

Indeed, thanks for noticing. Will avoid an immediate re-roll, but have
added it locally.

--000000000000244c6c0627e1535c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fed1ca9ca9afbdc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kRzRjb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVZnQy80ajU1WnBmblBwWGZpS3AvYnNJOWtvMjkvQQp2NzR4N2xrZkJY
QU1Ud1FpWFJLdDFxZXZXYnEvMmdJdE1weE1RUitUU0lNTFZweFIzbGNsYVRZbUR6QmUxRUJlCmRX
TmpmVENQVkEwd294VVE4dzY4UHBZa3p2ZWZ6MFF2TlBOdXY1dE9LUTBXaXI0MDMrL3B6NXZvd2Jm
RzM2eU4KdUkvLzdHbDJJb3JMaWI1Y2RFTjEvdzUrUWJEYXY4MDRSajVSSUwyVTcxVko5bzl4QmVx
NTVHMFVVVmFVblBFTApXMjVaWi9iRjNHNjFmczlncW9RRGVzMWdrTlJMdGI5ckI3QlJXYmpoekhh
ZFZ6WUJNZy9WRFo5Mk0wSUVXaUdBCnJYNm1mVURjSjJXc0FmMGFYQzJnblZ1YkREaU5XVjV6bFgw
ZVNPWVR5d3lkSUNJcUM1NE12TExZVHkrRWdjUkYKRWg5OVVNSVdPOUhScTlMdVc5UVNvLzVkaDdI
dEY4cTBpQnY3U2tqb1c0dzk4aVU1ME9WQnlUWGpKOXJJMnd4SQpoV3dDQmVPVExVVWlUN1JyZmV0
RlpseVNhY21sSVpWL0JIS3ZBcDV6Y2gxTDh5N0oxTjh5dElnRU5Fc3cwMjhrCnhId2QxNFVwZHFl
WWNLMGhjcUF0R3hqaWtqbTR6VStVeGNhdFRhST0KPS9nM1cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000244c6c0627e1535c--
