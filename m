Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3063CF688
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881624; cv=pass; b=QWdnBidx6gn0OuFk3hkZBS30zinvWYwgHoUPQjvIOmIVqqqMhTTaNKWYyawuvMa4eqqPX0H7RvMmtVsANcegfk74+QHag5ciBOX8sC0DguZDZ95qlIYyXgTGzGjcRa0Cke0GI/Pdfdf/Po9axEAdj3YjjOlQEOMhIMa1FlhFROg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881624; c=relaxed/simple;
	bh=qe1Y27uKm+0Bfo3cUHp0ck8aqdJEWl0VbSEkikUo/Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MKFve77UU8KYaC1J4KmBPtL+E6hFBIoAj0VPwp6Elt2mihUHBuuHGJop7qfruEO62CIhB3nVseWpMDbzfTB6mTrmMpl8NzXhWvBQ6wIWHG4AAVb++7a5qWBxF0//ncWoP+jB34NksMPn7bQagUlitVFRyyr9qBujFLi3/12Yc6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEfZ2F4E; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEfZ2F4E"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b458ca2296so37975605ad.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776881623; cv=none;
        d=google.com; s=arc-20240605;
        b=ei1hhlpWqB1AAfj7HR8hQIwwP7V1LiMYa+0fL50AVHIwZsUncsOFHMk9O/35uffF6H
         QbeAtAZHX2E7DgF0ry2Rb0hjgMKrkZLjC5ppRNOTiJIybApVDN30XVYYZWyj6VStB0wc
         Z25nPVRztV1rKaq/6EtG5DGPZeQPm6bVFJ8vvzXKWEvWR98i5/TRaiVEz2QVuq537/7G
         JtEKUCs9WrupHRcHG6Qowz5Kl0ViQg50lBOoe4JuAfOc2wl4j/2dEKn93GwGwkA0yc2k
         N4DvRAmNCktJHEjuXS1S1/cs8Xmz/1MABra8WsSGIYfMfxrxfsZUUxo8VjuLoDQBDkYV
         K/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SyTgFjQev20GZvOZW1yWtONYGOVCAPetQIIOddjI4rI=;
        fh=mXFDQkn0s1TPNQDNoJk+lK04lWs2rLMo8szSuj9V1LA=;
        b=S4gcVEunz5g7JAhAZLAEowp2AIiSojw5bsuDvkugt40iG+eR7X2uXO3QBZdX8ESza0
         m2N/DFzxPVOT8+QW4XgzdJKnRAz7VjCWHqkgm6uxKSDO6N/ch73m5xBIMzRc+kdLEP7l
         Pm84HbL/gfxF+2UBwwetM5eP2P4WTeusMxN0Va57bcZMHdEz0xAhGUF3mOql+75+W16s
         dEQ0UTScM+yCCjIEZAnYx1C5hlaovJmWgn4UzohVaZW5lkuK/XAbmT3UwKgmPJ1lQdW9
         KjAdIWkrYTEkWLPIoQMERpibqI2mbfuA2mJTrJdJynKaX3Cg7rgAzOVVXQAyGQhq18BI
         wxtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776881623; x=1777486423; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyTgFjQev20GZvOZW1yWtONYGOVCAPetQIIOddjI4rI=;
        b=pEfZ2F4EdDEYEr6gxYXkMlMUHAstoLCCx5REeAStCI5Rn50TtZ9mUneAteWJn5llTT
         jozoFH9fnx4TG6Vlf7ujOU4k7UC5p1G5shQg7G/cHfR3KumqHCVMK9jmT8GhBv2exANN
         /vO4EPPG+utC7IYf/hzAe/VZwC9fLOTOlkz+1tTBSv9H9CheZqJ1ImRQnXY/e6y0rxk1
         YH7ZEB5TIEvZEfYGLOyCwcTFK5NJm8QYrx9/R7cJjb9+DAuwCNb2WVmrGMHWecillYMN
         YrdPyd+HUWU+FUNETR3Emx3OmS2U5jIctV72KLLN4Uvkgptd5KtHP6axWoCVrLsbTlv+
         Q26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881623; x=1777486423;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SyTgFjQev20GZvOZW1yWtONYGOVCAPetQIIOddjI4rI=;
        b=PBJdhKFtrgdGinss9o8zn9Pw3GFCCD4CQLZ/q6hujQAdNLu1iH+OCdxS404yvkxN3/
         +zaAu2wWLf4YezNxOuTkY6GlUx+c4EQjZaKidSRVogA03Dmn+aYa8Ts4y0z/cqjCNY/3
         jmSn+UkAUBcdsMAgCx3BtCbaFdE2PKpZKzF+jr6fsJFjrsGS5NpqcM6ErXvbbpl92lP6
         FQAP2kAYM5Ip3SLRx8yKGBS3Yh5xen58z/JCRTqibpJBnnM4FHB1WaaSJRqCLsI0gu0X
         aG43gXmfTcs4VVAEjvMHmcbiI+82YYCBFjRT8MK6FXInFYJBhgYAt/wFdxSlyZr8HCWX
         Vo+g==
X-Forwarded-Encrypted: i=1; AFNElJ8dJN7i7zppYVreuC3zDwvUnBaOPqR28YUyHiK3JnWru9nVQMMYRq7t5rWz6fP2cmfDpKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyrJM4cDJEEFKnptOy+hn/oMra0uU7rnqD8aJbMLPICsRNaPQj
	61hudUsvZrQZ5ena6hCDoniAJxn/Czv+ENs0Ds5ufTHC+YJx8uooXHDOVP7+jYyU12dCj/G2gJK
	njGfMmLJZXnuEMHgRhEpQQI+bcG9zSoY=
X-Gm-Gg: AeBDievkurPLEw2siygSDsS9OGa/GUo6aT+vvpzeJXUJJlaZxyszKZM+qm4rC48gk6p
	hBPezJFZbJY9X0801Tpun0GOid/60LRzJyU94irKtqs/44558tQt5ujTWIcLJJ7Tu9bZE0BjmGU
	UwuBadPQtySa2suvX4ZuzM3QdGhs7U/axq8AlxrsP1EPvOwuGjyXlfWXEZbRjqKgMBS2HDby0Ea
	lL8e+/FQDjLQkO0fPS4gpBIzqZcO15uBv0lq0WZ+SofWe0enyrrBby6+2QxdAYsr5joMSj7sy+H
	Y6LrNY+5u1zaebV1MESSyn0UX9VhHqJJaAe7q0cP0j+1gInp1TZSrh/07691Q6rLFZ3bq94TV7F
	wSG/LVi24fPY+yjoca+iy0KvRmA==
X-Received: by 2002:a17:903:1aae:b0:2b2:45b7:306e with SMTP id
 d9443c01a7336-2b5f9e85fa7mr232324305ad.3.1776881622444; Wed, 22 Apr 2026
 11:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d5d04e2-49c4-4781-a289-f8cf79570643@sunet.se> <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
In-Reply-To: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 22 Apr 2026 14:13:30 -0400
X-Gm-Features: AQROBzBeQdh6HmefX2l5MFWPXbv7sFP3R3AP_Km4uWmuJmoUhcqugi32l1K-LFk
Message-ID: <CALnO6CB5TX=zi7Ghhnvv4wCatLPLKJFT5g1_hf4c+pno2zC3fQ@mail.gmail.com>
Subject: Re: [BUG] v2.45+: git commit -S invalidates signature for non-UTF-8 messages
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Kushal Das <kushal@sunet.se>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 6:12=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-04-20 at 08:59:05, Kushal Das wrote:
> > Hi all,
> >
> > Every `git commit -S` since v2.45.0 produces a permanently-BAD
> > signature when the commit message contains bytes that are not valid
> > UTF-8 AND `i18n.commitEncoding` is unset (i.e. the default case).
> > Verification fails under both `gpg --verify` and any non-GnuPG signer.
> > The failure is deterministic: it happens every time, on every
> > non-UTF-8 commit, no card or external tooling needed.
>
> I'm not sure that's a valid configuration.  The commit message either
> needs to be UTF-8 or you need to declare the encoding so Git can convert
> it.
>
> > My best guess is commit 6206089cbd0b1cb30a017ec904567f040ab4cea0 starti=
ng
> > this (and I am maybe 100% wrong in identifying the cause).
>
> It does bisect to that commit.  I wrote that patch originally, but it
> got modified and sent upstream by someone else.  I'm not sure where it
> got introduced, though.

According to the `amlog` notes ref: <20231002024034.2611-9-ebiederm@gmail.c=
om>


--=20
D. Ben Knoble
