Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C939B946
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177808; cv=pass; b=aGAuxGwnkaPGXfIOOpe+NQLaZWajjVsy3HML09F5HRFOGxAxOsKyx4gOxDIWtpgSJClK3VUcD0Kf/rG6pqLlVoRNPqXIV3iLYGxL7kfwAaKSfY69MopZ8tS7kJ4dlg4KhZUxrhNX2EtDeOrBu9QvCXD/Wc5wtte+b4NDu8199HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177808; c=relaxed/simple;
	bh=6Aakfe+zXKXLknA8f1QFUQY/QQyOP+2RUozKoeR4GPI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3mSBTW3Ff/xOa1XFb/UNLtF7JFfKdabCec9xPjbivFSTVAFrv1uLgXmh0AZup4c1KbN9uW9ih/EgKxnWCZaR716fzO850RyjxUwn/NhdjZ2518X5hkTSU7bX5nsh5xu5mqvpXX7Rn6oD5UH0cxh/sb0CY9Rs/y1Kws4IwGNsGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nrkglgki; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrkglgki"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-95ce0cf2d4bso1955323241.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 01:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779177806; cv=none;
        d=google.com; s=arc-20240605;
        b=Kz167UiRY0TVq0RmeJSzKIxKLKybo29AvzNN/0IignWIAPhZyYTqDX6tjvqq9ONYqD
         3D2hkohAhYykqMW1teX3RI3iiOnqzI70W/+VvFzkrILC1/qINF4c+xBnFSUvBkKjUsVj
         YoJM5PfIvuA52e8plmBDZjoGnaEABeiIpkZ62v/oaeXKVlxPigw55LTXlZYy9FXqj7zr
         OZSJ2T2DZaWCjToVEj4CZLNctyT607B3rWG9SCcVxsbOj5mD7HtJ5CkbekYKjTpuMiYD
         HJBt2UK9FPfCVX9RzxeKVLhQkSSHHF/Wuxb4Fkos6T28qaV9AfX3Shi0esRYA121fuk4
         mSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6Aakfe+zXKXLknA8f1QFUQY/QQyOP+2RUozKoeR4GPI=;
        fh=oskFKpgF43WUheRIVxb1dg6wES63oXXzlTczTGCGybc=;
        b=QGXRW5nK8sdPa0u1cszUwURT4IjwddzH53KX8M04NIOFZAg8pk6QAlCCTN+rwT9suc
         LORuhn8I60mI/MPm3ZLJaKsctMI8FtrCsZ/eCRsh4r1JQOdshTzFHDuLlitSPa4NsPNk
         LXxqwrkD1oHxGCbinEjVXJ6RTF1wVnOGMVpAqM0APIvYxgMkjZi9MVwCHs5hwfGeCpGL
         ZQh5xTXiRs7uSlda1+NnMiJtPEvG/mc474/Qc7kMuuvQ2RpeZ1U7rLuBhuiWs9a2blNB
         U9vyrb/5/c8GtIlsndKlsLZxIhoHzlxaPKfAZLfd9Cptr4nQpT/LbrsML4ShBASzMtzq
         cPCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177806; x=1779782606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Aakfe+zXKXLknA8f1QFUQY/QQyOP+2RUozKoeR4GPI=;
        b=Nrkglgkie4z1UPJKxg+BGY3IVKVzfXAdNP5eBfKY6G881jRBfO571GUAwz7GYcZ93v
         XhKIEdasrVWbyg29Qfd+cmPDMA8R00EKHpYsoWWW6yc8+SBtRHxn4maQoeTHOi1/omUc
         iUOOXiP7mb9uapUTxHRnEOxW6D/vz+6S0C496DSo0ztgOujCumzoMslfRif9dkXux9/+
         rXWvAmU2jlfFzqvRM0Oj7ZpOjc6jabVWvxP8Glxw6e/tYVpuCOpOfw623wGIjKLeaYWC
         tAW/CeJF/2xF9OhcfPf75VVHca9652MIYvqxuTaoO+hE6v7VxOW6mv2WlMw16/Y+PbcF
         f27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177806; x=1779782606;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Aakfe+zXKXLknA8f1QFUQY/QQyOP+2RUozKoeR4GPI=;
        b=jjgpRWmm3hlM/6m0ZBAfmdz/dHQM1OleCuhLlGL3m14ZWcfjd9T1Tri45H/V5/4DwA
         pAVc94kDjybwD9Y7/sbGfQSUjJWkvwevsYxJlwcNwr8b0FEAt3qo0kMXRCpAXXi+BDr8
         OXiAVuJkQfRCbJ+EcOOVXVnOH2WCW6WaO6wKO3c3CbuMhaNDk2u8m6Zwqu2IAKcaVdIY
         CifNr5q3P/VTjwMAdPp+AQfdayUjPhPcvpKrEaH3P4H1fJDA5J8P10eWmnT2d81hXg/V
         Gqlfm8ecSCSa18fQJvTjzTIciW+iotfVfb7RQCSHvgqX03F9S6dTLTTJ5NKyGHbgtTh+
         cM4g==
X-Forwarded-Encrypted: i=1; AFNElJ+GbpfejuhfB6Df9q09TZM3Tj3lqlqGyPnG/KZhMqBwdlA9bnzuj7KKaO17rZ4CTw42rzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYlgJVLPDeUFJmH8eNjKnf97uM3dLxRN04zu17rO5DMrokR9k
	9NamOm4WzvEA0osxzFKtUhbg8DbeKjMrzUaN9v01QbU0JjFPZtsYbWVMO5ZhylQjhMuLQzJRq5z
	ONgV8+Iu/ACTqTT8yVkNYBR8Jre97qDE=
X-Gm-Gg: Acq92OFGtQ8f5PK07W74/RrKMTfUy9Md8i7hbBgkQIuS7GUypxkAZgVdkalr+HNuDOv
	o8eOulStcW7ZHFFCf+6Vu6wVURXMHBZhyculWLO6HcoBRFvzc29M6lXgQy76ogdX4qfPHogu9vx
	an6EyR80ywzLAnHq3bOprgRKjSsn4WsXa7m19Z/JL/dS40ZZ2QMK1C32Zk4YPPa/Zz29YrCHyZe
	F0EgSXgxupY8t0+AWdAHnbpT488NQuGzrtZL69uIy7CvEgJkFGiv9VjJ+wOdSU/X7SO2t45MZkN
	JbVqv8XJLoMav7BzinGHxQVSADURrix/kcP5WW+mbUgqmdxJVmL217r8Xr82WuaroCyoU5Y=
X-Received: by 2002:a05:6102:948:b0:631:c17c:2417 with SMTP id
 ada2fe7eead31-63a22ee77bbmr6158959137.8.1779177806430; Tue, 19 May 2026
 01:03:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 01:03:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 May 2026 01:03:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-1-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im> <20260518-pks-setup-wo-the-repository-v2-1-6933c0f1d568@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 May 2026 01:03:25 -0700
X-Gm-Features: AVHnY4Ijsz7YrBB6GSqd9b0j97rINTZVsnkFC35r9AJ3gZeXO-iJDdw71nclQn8
Message-ID: <CAOLa=ZQkj=__pALxUxbqzh9h-RVO8nC=23h0Sb=gnF-ahHHzCQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] setup: replace use of `the_repository` in static functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
Content-Type: multipart/mixed; boundary="000000000000251fd40652271d66"

--000000000000251fd40652271d66
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Replace the use of `the_repository` in "setup.c" for all static
> functions. For now, we simply add `the_repository` to invocations of
> these functions. This will be addressed in subsequent commits, where
> we'll move up `the_repository` one more layer to callers of "setup.c".
>

This commit is straight forward. We simply pass forward the
`the_repository` variable to static functions, so they have an incoming
`strict repository *`. I like this approach of:

1. Fixing up all static functions in a file to no longer use
`the_repository`.
2. Fixing up the other external functions one-by-one to receive a
`struct repository *`.
3. Fixing up any other global variables / config used.

Makes it easy to follow.

[snip]

--000000000000251fd40652271d66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3aec04566a0f4bda_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vTUdVc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWVsQy85aERHWHduMFZjUDE2aFVJeGU2QkFZZmVIUwpMSlMzWGE3c2Zq
dnArOG1Wb0h5ZDFLdFRuS00yRytyUGtjcFJLSnM3dnBvc2grVE5SQWxkZXA4MjBTWktkbXg1ClVG
bDdjRGtGa1BSOGtFb00rcWtpRG42MVM0Y3RkLy9lK1M5QUx0NUJhUEJQRG43cFZzcjNyRnVMS3Ny
ZnpkWGsKWHNveEtOditkM2Erak8rN2s2UlYyYmlyRSszekVueW83Y09Fb0Q2aUdFMmxhOERRVDBh
cklVM3Nyd1EvazZCbQpud3B3UzltbHR1S1ZYcDdnR1FvRTRValpMZkdjUTZ3NHY3UjM2T0V6S1A1
VDExOVlCN3JOei9OV1N0aHpZTmtOCjRCUXJ5Q1lkRkVjdmdUSSs5cDMvL3VxZW1QWGdZcTk0UGZG
a1ljZFR0SDh6MCsxZXplNkRrNWJLRjBCWWlEWG4KVHVvZnBHQ0lUZE9vWUZxWEt1c1NzM3lxZW9W
WUk0bFY4MWdOdTFwRzVEMEhtOWNPZTJqNFNJRXFWTEhPaUNtSgppRlNvVmpQUnJoMnNZU1h3eXFC
QnNnZ2Nsck1QOTkzcjdITjgxU3JFaURXNllKQXYyQS8wY3pYTGViTTh6R3UrCjZyNGZsQXphV2U3
TC9zdGduSkltb0NLaVpJRkFhdWZUU0YyRjZ5az0KPTZ4VWsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000251fd40652271d66--
