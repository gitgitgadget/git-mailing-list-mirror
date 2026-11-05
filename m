Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793887018;
	b=ok3Gz/foq/XwlkhZXb+Jgq87o+zOF0hQxAU+H7VmQtgBVqf8Axf9OhdwY0YAZ+5nE/9R
	 yNvN+qBG+0cMValwZQh1hgj4mXwEaKOTUxMqEEt7Pkr5fayDmKYPjtI0xq1mKVaKnoGXk
	 YrQqKg1Lu8uCX816TvPPBzCJlUt9H4iFPB6GNzw1QvjQuXWZnQUYTTDkEKw9h/t0nXWsW
	 0igeBQeSKHzF7MwpFRnfrmQi5ZkZS0h2c1OR2TqF+hg7UjYYi30qlAJAZltGmnmTCbW9d
	 Z/IFyperuxYnEbiMkxkwESLcnlkurmIbwk6MWdW8ulyrqCBjMR/khaayrTjwqkYntTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ESpBjzUQ4h+G3fOrq/5xw1RMYAG49BHS21NjCOWxtYI=;
	b=YoNNx/AXpPI/5G6sjhBHLpJ1bABi2CwpQWgXss1XJWu4QOtISh9gw621x9i5I2jfQRRp
	 u8jLHEXfSYBCdNGfyj6K2fPHqNAIfZ1ND6G9Rj8nd5EM4cs7vOycqnYGJi5XVzh0NE4d3
	 1XyiWe42hIeRntzKcc0p/CkKg3v+OjlGBlzM6ubLT7TNhv7hYpbIrs1BlTALUv6nNoYqT
	 4vQeE0eVzN4pHg4bpQ6xCoYUqvHmuYdkN56118rh2ods3vLsm7c0NBrYH97/piXIbohgf
	 3Sn2tHX+6AJO1jt3LpTFxuUxDT/APrSbmIG6lZmLd1qbnu9W/k8cU0YjdWUtxsBywTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ntOmQPj6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C88606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4C88606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ntOmQPj6
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso644728e0c.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 05:56:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793887017; cv=none;
        d=google.com; s=arc-20260327;
        b=TUKghZErvKBnJb+l1cKtviCEQcVUJf/Pzwu3hnJO1O7qff1bC+UHzUhkPuUaUvwEls
         ejcvCdEjS7oUJJIirPhv7oSATwQ8B3HbWXiPVjdLU/C4g5cIQZeLZP8svVOOwd5nVe5i
         Fep4cJcY6O6cbMtewQz/Zv+NZlGDfTmaov91HzkkfVVFCOtPxy2FX8sGX8nHyulM9kOj
         nHk7gyfjc09Sm6ZBHxEBhqBm0wsiMw8om7pSInflmvjNcu0cDk3HMqXPHMQf+ZRp8Cgz
         pehOwJh4l6owI0OhEJn9gzSty6vSd+syPr0wVxv1NJHjnAWJ9nlmqW0v+XkQuw5ng/5M
         vMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ESpBjzUQ4h+G3fOrq/5xw1RMYAG49BHS21NjCOWxtYI=;
        fh=ypDDCT5+de1Yg7Bg+Z6H/2Eq1+3Bw3LF/HLkbCTbqfk=;
        b=d8NcVzmgd7YSnMVBgVQnPGakH6vFrNyTDVbTfbdol027Vu5CmkoEBgOlJ6B5LWgUnu
         Hz74SjcA7xB+NfiPS3WSE0YPxrwrzI3cO6u8XPqVbI1EvPXp1ALfUVFHDxuQzpgCXJlL
         p7g2c9CPJAw0ZluXCAFzS/5A77XIV4LKbVAPUorNrYC/JhZgR9BVRCot+X0rb2RdCLlU
         eOBzKDqJU7LzcgsIftAPO/aAOkSXxFQayGry3dqJQxC1Q5f9oYt3/atSzPkw8zcn9o6q
         bMccrp7ULpXuIkPsdtNH7VU/RMmTeG/s6GEtqtE/2dkIsi0znMjflqYUIswmVf8JbJ12
         lhog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887017; x=1794491817; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ESpBjzUQ4h+G3fOrq/5xw1RMYAG49BHS21NjCOWxtYI=;
        b=ntOmQPj6vzhf5m00iy6ROqJYkda4fUc9iD2yvRlt9MiTOys99TYucE8HafqaeeissY
         WRaMGowH0IJyX/SrUNPto0X16n4bsLYxjas1RfWJEVlsAutpNLsiJAteV8PRi1tt+EBL
         cXx2O8O71DIVP+3b5rwacG9wW5NHTrLwla4a+4PIqK0zgkqM69SxIwW2ajPsN1QU16O7
         VJV4KUqyWAQWXT8h9z0/YMCCAJsiIKkyfZSu8IkNG3cuCxKIMpxiW9AGcQ8xN2Dv7rAc
         1dRzqESMiVvlrus00N+QlBqQFb/H4SRY4Nkxh+zjy9+9FVTpPCCgGfu+/njXmKtStT++
         3GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887017; x=1794491817;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESpBjzUQ4h+G3fOrq/5xw1RMYAG49BHS21NjCOWxtYI=;
        b=mjjypkI4o81R7Ymk9Du71ItESazrMdWYgRX4wXKzie9p17Y+TS4q9sezdZao8frekG
         BuCiz/oIhUyR0QJCrigROHb2BnB0CDnyVon3wgOW9HgWQP0tofuEyO1QfcumeC7rkxzb
         YuNv9lwc68uOPECYO66vM5Vga70/ZL5KyfT135pKPcWvtE+EVw05BRBosWVxG2N0lB6B
         AiI3rgXaBcoTRMKUrh3aJBjbDaJ6HMNZ7ACqBODwl2Y5fm4bfgiZ/wTlj8D+d2ONbjhD
         YIXNGsd4p/kJuj+uj1lxan3vcR1NRksPqfi2XhgQA/ld3KcGtfz6MDW6HIYBUTnVr1uw
         Xn5A==
X-Gm-Message-State: APuU4Z9f2L7qREXg0/wk04Z67Kneo4QiQi/fH1zUTK3bw//ez++Wsu5d
	o1sXgptulsIVqirANxr1zQFZy737K6FRxMCqSRlUIyh9wLoI6Q3Z/9wY0nC7qniwDAUb45M2blS
	PQcMc4cLFyeAt9Zt4pFkJZvoH7hxma1NZiQ==
X-Gm-Gg: AYBFou2gGYcdKWRfloaO2Xxxfav+wg2NHwIBqTKhatGj/s8G5F2mMl9pEj+T+C3kCJK
	NPnzGjH41tp3RAR23hxhvvKsBPIl4vmNoi18pepQE7EoN8Fm72PfO9HXyUaJHHKMyOPQ3eVAwY8
	n2LAX7Uv86NoUNnIbsYNsJ/kfLlqfaAhv7wEZbIGzRmASW8ZdQhoPr/qzYbAGLI4wh8ZRklff/G
	eg9K674fvAgDGau9gpJH/uG8gv8SCJdGDYSwHeaXVTjNJw9sx0BGWRy9u5lrzB0vFyNqausGa/9
	q1J2YWX2ck5jy7FFkXcoY/Auh56T4j87hAn2cASY7euDTZlfcwCs1/WTTHZoaAiTvhTk2tdBJPF
	SDy6Z4JP2jEO+rbj6tqwAh5m7fPTEe6kBVN0bA1rsIysLIvkAvBELpIRxvK7MQgFvklkRmVQoGX
	uOXiuiRLggiUtKUXBp+1pnje6iSj0=
X-Received: by 2002:a05:6102:549e:b0:7a7:196a:84ea with SMTP id
 ada2fe7eead31-7d072719b19mr8149361137.34.1793887016790; Thu, 05 Nov 2026
 05:56:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 13:56:55 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 13:56:55 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261105122532.391-1-herroyalpriestess@gmail.com>
References: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com> <20261105122532.391-1-herroyalpriestess@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 5 Nov 2026 13:56:55 +0000
X-Gm-Features: AclHuK-QIbp3y4k9mFr1qMUVyuL3tjTWiZFQGMEsR3CmgiVuIem9gl1tBdGw9bY
Message-ID: <CAOLa=ZSfNPt03R2F_xG930pBmXCJ-CcC-GnTTLA5AgWoZm8eaQ@mail.gmail.com>
Subject: Re: [PATCH] api-parse-options: add missing flags and macros
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000675386065f87de23"

--000000000000675386065f87de23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Cynthia Uche <herroyalpriestess@gmail.com> writes:

> Hi Karthik,
>
> On Thu, Nov 5, 2026 at 11:37=E2=80=AFAM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>
>> Also add the follow missing macros:
>
> nit: s/follow/following/.
>

Will swap out.

>> - OPT_NO_WITH
>
> The message lists OPT_NO_WITH, but parse-options.h defines
> OPT_WITHOUT, which is what the diff documents. The diff also adds
> OPT_BITOP, OPT_STRVEC, OPT_UYN, OPT_NOOP_ARG and OPT_COLUMN, which
> the message doesn't list.
>

Ah right, let me fix all this up.

> I applied this on its base (8d1b215c01), built the docs with no
> warnings, and compared the descriptions with the code on master
> (0ffa3e35c7). OPT__VERBOSITY, OPT_UYN, OPT_BITOP, OPT_COLUMN,
> OPT_CONTAINS, OPT_NOOP_ARG and the two new flags match
> parse-options.c and parse-options-cb.c, and the git-add[1]
> references resolve via diff-context-options.adoc.

Seems like I forgot to update the commit message after making some
changes. Will update it.

Thanks for testing.

> OPT_ALIAS and OPT_ALIAS_F are still undocumented tho. I wonder if that
> is on purpose.
>

We don't add the '_F' versions as we talk about all such variants at the
top. But will add in `OPT_ALIAS`.

> --
> Cynthia

--000000000000675386065f87de23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 888bd8e65e61271e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yc2l5WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEdHQy85dzVOZTVDWXlaSUtzcDd6Wm85Z25uZERsOQpiclBUN1VIVXZv
eVU0ZXp0NEpwVnFTNzg4OElNSGZIRUR4eWdpMWdHdVJ6Skw2YXJIWVpuK2EyV2ZPN3hwWmJKCmlx
SWUveUdPZ1AraFNVMVlLSVlzNisyci9OcXJhU3NRTkxDMXNyTzBwT0paUndQQlRQaXIwV241dWd2
b1pRSlAKL2dDNG9LS2tUbXozckhUWTBVTkkyZlkwSzhseU1OYXNJNERWS1lkOUhkSS83QlZtTnFR
Vzh3WjJkcng0REpRZwpGYVVLT3Z5N1VMZG9sVms3bllkMnA5N2Z1aEoxNWdjZkVzcUtqaTU2NTVP
Z3BNQzg5VHM4RUZ5dGdnVVJKNXhUCjRpY21jcG9YYmt1RFVEbXRPeXlMRWZUMDJvaUh2OTJZVVA3
WkxpaUF4NnRZMW1Jc1JhWmlBSkV1UkdMYzNZRy8KYjFPaTcxWXFxQUtEVXMwR2E0NDhoaEExd0lP
Z056cC9HSENCWWJjQ2U2SU9STndtVy9nN0VVTC9GUENKL3d1UwpjcUp0KzgvSG81SFcvbEtGRjRs
OGNYY2dtNmo3Vys0eVluM1dUZHdoK0JPNGRKbDR2bXlqQWF3RzVkamZuTEN6ClVvYzNCZi9La2Zj
R3Nvem1UYnpyZVRGenJlZENyRkZjdkQwT0Flcz0KPVR2ZUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000675386065f87de23--
