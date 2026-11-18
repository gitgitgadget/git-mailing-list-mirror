Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038779;
	b=Tnznc3wxjSBDYlDkCME0+F1Az5HEXcCN7SvzBBQ8KTqzqursB3OK4yjyh/gYcAhgCeTg
	 JThqlExOVBtOGSsnaH9nGQGkuT7SqV75aXBI3K+gYlte3BUXYmIHOaDrbx4fzEzdTyye3
	 S99Wf4Kv4zuAmHw1A5KLLgaP0oUdEktNgxwFaRxDJYOVoZB9xjUyNaKuL2IGz6FhMKpgo
	 Gsd+T1j4CpoDQDeBuFxvYQ3PAcutE4Dix4HJcAspW3fXcEu7uQwyKddDwANNKU/CaR/og
	 9+AgNO1+MewLLKH29iyWH7LnotIno6b2JoYCskJUd1sGFBFBjGwPgpqPt3UCUaLAWjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=GVjB5VVIkiK+o1KTVntr+N4H0Xj8GZCDMyUQZO32sJo=;
	b=O6hLQl70Dm2BW7fDzXFGqTGbLH/eG7eoXPJ38ms69FH0/pesboUW9hXVegCUG7O5Yv7t
	 EC71FqhxQ35EIrmRg8bddNj/I406ZZLCwGADfHLjek3sniEZb7jL9EO8/dK+xROME1m8N
	 o0jSQNypG7y9gWWCiqdxXg2CGXhToDRAiheEGsopfEXkMus2zdnHNteV+5TO/3NT7CyQk
	 k9d4DYFLa4PAyDJBuSoJDehvYRH6PKhe0AuMUdCjPqHjXlboY00k1PoHxZ9VfvuplbaZH
	 /KusdbeHxwed4sDw5DOWBmljanX0azaKreV4SMg0uvq5E7Esl+T/syiCsErev3kx09A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="YNt/sV+H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48763606A32F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48763606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YNt/sV+H
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so4636a12.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038778; cv=none;
        d=google.com; s=arc-20260327;
        b=ljobAoUHE/yG8wkUNN0OE4FI9ueEhiCJD4AHPSxPEL6vR2yXxLa1u2Qan+HjbzRMju
         0BNS4pq0B1KwbUxwd0WYN17exfm4taSgSr+Vq/GnTgA0X9pjTboeyOExmo+bHLqkq84j
         cPg1wzjch9SYlJdqvfenjKBRgPr636AmzmOrJZietTm46Wr2mmlAyk9W20FCTHKTPviC
         fzsXkHWBJX2wTTC8+W8aa1KZlDOGDEDzTCdbY6vQ2CM0WXZyMZz39xlhTdFeBl1JMVKE
         t95+h7ucK7q1O/Lnt1Td2Wh971okxXBXaWxoJaSIpoFrYDZDLFhmW92paMXPgZEce4CM
         fjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=GVjB5VVIkiK+o1KTVntr+N4H0Xj8GZCDMyUQZO32sJo=;
        fh=eRTGcWfg6Tz2ooqzFoLOKcskZpyt3Vhwu/ugeZYBj2w=;
        b=Onaje67Ydd9RRQnfaFzLtJWPdUFg+2x2ndSv4tESUkk3qIIIj1L48kDxG8ETeyomUi
         ahGf71UBmCmhM5g/2+o9l6Evz12GXQO/xhso9Mbhnje2GBtMZZUZGnfKqwlI3NRqBjbt
         QxhHF6ClZyVQ8fJ8CetZy+Boi0ovKjNw0bxX+2HxGUMvqx35vI1PZLvpTTaqpyj7LAUB
         yI02Gxd82Y3wR3M4R8jy9tVmyYJM4foTTR8rLtwy0xtkrAu2f6fXm75eQOUKnPhsN77U
         f/gDAa+0oJLbbYbt6rdcCvxRN0FjKDan+aSEpJ7Q3oDvlGcwDl65t6YkHBv7NcRAbIVt
         JVHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795038778; x=1795643578; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVjB5VVIkiK+o1KTVntr+N4H0Xj8GZCDMyUQZO32sJo=;
        b=YNt/sV+H4a7EulykvveDn7DxUBwg06qRUw16RiRdzhTYm4zI4wARSu2kIZwLy/Mpsl
         rILrj6lHRdPzPrtnI/l3/Gv/exhJZEWBzU32jDP9PmWsFiYOAf1hhGrMg53Jw3b68Kqm
         VcwVzfqc9+H6wZeyiTxHXgdtQlFLQl0EpxOqExeVnuUnjr425Qpx18SwI8GZCZw/JIiY
         nW0moYJC0UvDJjmCJgk5HpP+kLYoIKT6mXl2a0M3f5hz7uLpZUKNZtfN8rU/O0FpQBYb
         OIqowtOQyodGzLxgHen6SrTnCbM5Iolfy0jJ0EOuLJ3NYMzZoU7lYSXfszxEljVBWsVx
         rigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038778; x=1795643578;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GVjB5VVIkiK+o1KTVntr+N4H0Xj8GZCDMyUQZO32sJo=;
        b=YPKo4FvDPxRs/6SZiO/Qp7vwIHDjelNZe1YtPpRvnZaAhXuXKOT3fgvfCly6HF5GAl
         bzqfsTBwLt6Ff0wFMvXNlX0w3+8bfhOWll0WSbmUD0mpibP0FVtyo/c7WNYgc4q6BuyH
         +0Shk2ZOQI6qQi36yPOurrtCUJf6djDohTZh5NBzJTc7waOaj0mUtclCUKDVYUr4RRD9
         FMTCN9JMdsHKu89v5ijSiIIVtQu/yN3uH5VTUiMVslEMEl8g7+lhBUg2AhfwRamAzDfL
         6JqsUwMd3654TTSTp/2gUjubRPcC2JzGaOn5BprLF02GsldZ8cC//nCBpZuk8uQ+SlBX
         noHQ==
X-Forwarded-Encrypted: i=1; AL+hErGwjBCnTGx2eM2+hBHD9pxeG9EGdKKvpkgMxWDbgWoIiJSLfcJHZ6v8xmkPRpOvPxyILso=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NuPXQrqUrvFsRsF427JvJCwkqzV2frVLD9r4y0uByG26smCgU
	9kAcV16bwKbKBKtv4sXBUd+Jspyj260XysKn7upFFbIsMEAzL/Sq4PMhNmwwxglwi4timUGM9eV
	d3zIhlA/OjqzFHDwJ1qvOvsfibR4UiWFSH79WWJBZ
X-Gm-Gg: AYBFou39BVkntA9Im/fjsNA4uFeYx6iEi6vofvShf55LpBGrs6/5kloNSidOkvnR95i
	S2xaVxsVjxYwGgVaoqjLXQXXU7TDEDU7mp/p9vj+HArqH1sT/vMnLstPRe+VuwW8QeJcU7ADpWs
	c42GgPaWVTSsOJ8/I7koJLY44mTkIQmGzma1czZroR79jYDS7WxkvFivvh7RWqJxfgmJNl6lmrh
	j5cceHVvUmnFBU00rNjK49BNGVUl1opBzUHVyGF22jzxrcpnLn9VOLQCJHdqSPwfPH+rxszRUM6
	eP3mcvVzYcMbWNfvtI7h6PMHCbb4HqbRPqLOc06pu4tOMV6ws2tInmDuo6QdCbaWqBbarlCj7I0
	meG0Jzq/enciOwxl8mQ3NED5Ayh6fUN+WLXDUdb5mZugoZp4mZkg6Ypuu0ZQ9RIzqmFEdGjRIUe
	YVzeaf8UqQeg==
X-Received: by 2002:aa7:d58b:0:b0:6b8:7775:5154 with SMTP id
 4fb4d7f45d1cf-6ba100a8d10mr8048a12.9.1795038776992; Wed, 18 Nov 2026 13:52:56
 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 13:52:56 -0800
In-Reply-To: <av2TTPCkiA-49K_I@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <d53778dd4635bd7dfb5b115a23f3642ea3ae40e8.1794022836.git.gitgitgadget@gmail.com>
 <av2TTPCkiA-49K_I@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 18 Nov 2026 13:52:56 -0800
X-Gm-Features: AclHuK_kS-mWfUdCmEMvyYMbtTXsWXgmAuGy-ey6H1gdESEFqRoRbbfA6wWN5VI
Message-ID: <CAF+mdif2EC7_OZ8jHgGjVeSG3BpsmOrSajSW9jPqrP7nMDutWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] http: fix retry count and Retry-After timing
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Nit: feels like two separate bugs that should have been fixed in two
> separate commits.

Since both are small fixes to 640657ffd0, would prefer to keep them
together here to avoid churning the series layout.

> It's a bit curious that we return `HTTP_ERROR` instead of
> `HTTP_RATE_LIMITED`, as we're essentially still rate-limited. I would
> have expected us to only skip loggint the "retries-exhausted" message.

That preserves existing behavior from 640657ffd0: when http.maxRetries
is 0, callers like discover_refs() keep printing the standard curl 429
error instead of switching to the custom "rate limited" message.

> Nit: coding style, arms of a `case` statement are typically on the same
> level as `case`.

ACK. Will fix in v4.

Thanks!
