Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9604BA1D0
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161793; cv=pass; b=RXuyp257I9qDrHa5RoY4FvVVtV0E4vbCcxWkmcVxMuoqgvyhrKgtWkJn2f/Yml1QUIrubO+ZsQlX97ybltJv3wTLX8S7uZ/vVMbZ6n3txi4rQ+mpVr4WcZtq+frcJMX2WXSqSpiYec3Pkl9nM+gTYvus5Bf6wgPPG9Le2DtclGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161793; c=relaxed/simple;
	bh=FKtbNbBzVOdF7TV9/h03LxzRPgWo3Wnm5LKkzhFiNlE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m14HMLatZw7G+kqmbzMiif0O8ApjUjWzT9zTYuxtsJiWQNox3gjduyRmBazAy5Br08DDhudnvsFxt4u4q701HCjreqZxXlehxKjitkgyDzdhqZmQTrPWV1ZKO1Elg6pTkthICFBuoixlJe6VhAHGtBPE7gF9RL3CAPsIyrfpQG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWQouRfx; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWQouRfx"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e8ef5b507so92992241.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789161791; cv=none;
        d=google.com; s=arc-20260327;
        b=I4AttXI/AF6uWziz8fXBIWyxPh2YMg+PV1xwHg/6dy2kEDHDUn7yuWuV5WWh2EWbHM
         HgMIn/GqPtXc2KcnlfbGN4nlwl0URiSP/GeNtgk2+nGM9uegQ/dZ5Osk+0vAOHgu04Io
         WrganfY1O9rMikUaEfpi0ikMJR4iAJLgIr6AXvbIheWwQMNc1tuGtE44WPdsG+vJ9BYs
         6fIc5Z/qV9v3+OfyS5+0TM/3Abb09/RsuLr2SEAvKfwQu0t2XnQYO/ElkM/KOFZEFrxL
         wE2S/aGfMBxHGg+wwOyiFF0KhZZxKt7L085D6bqfX1xQ3N9Wi8QG4vhlyL25AZn/gZ0b
         V44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FKtbNbBzVOdF7TV9/h03LxzRPgWo3Wnm5LKkzhFiNlE=;
        fh=BUraAcz4+WhQQNaVJwhMQndTjTGe0hDkZUT+RMBphDQ=;
        b=erIkQ9oaLPnOApSwamtEIy3xU0GJ0rFt8+tpKNBL4fB5SUw4WwWNATz5U4r/87xcou
         3HZ6UKq65iqOm8TIatyR0TWB2lXtuPWsdVVKvi86bN2Dko5yvYQvFUBIUOAzA8bFqche
         m290NulaS9PEYrMnMZLbrG9ndx1bIh7B9VEDXGmJkxpML1jR5fYLaoBqr35tt9nfpHiQ
         /al4NSipfbbRnMyNRg/hz0X0JQVu/Uc5N5TN3ODGrLmeoQJ4EjhTbKgq6qoIJyjE5/+a
         rFiXBAe9UL8LY/zFWGleszlxVl7OGRo8D8KKQoC+znw+jG+FC0dtmIdiifqXG3y+EZGB
         60vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161791; x=1789766591; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKtbNbBzVOdF7TV9/h03LxzRPgWo3Wnm5LKkzhFiNlE=;
        b=nWQouRfxWgEgYmpQ2GIUpsHZrTV8IHk3PeYGf/uJxVxbnUfMvBhOot9iXgSU26VHQG
         P9we62K8Y6dtjWkLQOxP7/+ciguI4TW8G7i/2e+DJ16Rhi2237nTuehXI4Q0wNwtBI7o
         5evKRq/JtBXbzyQls65HZvPF5ATYmc9pV9LTVHqiBNk7GWvY1mE9wvfNloCCxVMQZ74M
         DlhJRYexDtFq7afsZm5hUzmwDx/EcZabU6JKCHMyfPkI+H1jScpcVf6wzTs4TTuTJa10
         xIefXhTVuN+n67JQrcvgS8XJGBSH13xy1Sr7XReD/VnZ0onZi4c+A45cqavsjbaWAhkD
         aZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161791; x=1789766591;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKtbNbBzVOdF7TV9/h03LxzRPgWo3Wnm5LKkzhFiNlE=;
        b=rSOCQ1DOjW/4th2AXDYkpnEIIT4OFM13Qi3BJnM/P/HL2RDNJiOz9J+HfonrYLGhPt
         zeR293IAQ4uNwJBv24aOpcDkoJFzHjFq2hu0s5NYck1nTf/MxA6RA41fxFZQZELk6/u0
         bm7akt8ElKoiwtvWqpAJkMY2YpviGHWsYEjkc7Ae31zXkv7Mxf914qBuBNPoaQ6SFCJE
         DWDlScubmnsPFoyIuq4R9BYYSTMMZb00CSfi6OGnKfbdzjR3FYDzCDBp4nt0ZQxkIuks
         hutrquqBhhGR2ds5c5E+vRCy36dkEXD3iUKiTHGx3xF0MTgrymhJT8Czj1Nj602+Ymks
         4rrQ==
X-Gm-Message-State: AFuF++mR1NzumUQ+4IX2b+lAU6X9xe4ZJVHynOckpPxCRWsU+b/APFUK
	rhzJqsQRBU7m3bDjRc7jXFGSwgbW68k1IsaRV0LcQ4sqraYU7ZqEsYAX5XHA0U+B1XtNU27u5dB
	oTbC1WJqLiU+AL8MWg9xQOts5tTng1ho=
X-Gm-Gg: AYBFou3YQJEGfNYs4XoJAuiT+VJlqT46OMXbODhhERuaavM2Yf6nr4tRYkx5CyJrqm/
	ycyhyEdXEG+rd1uFbRj2q5F3AsTIYq+La4h4y6/wIsgyn+FEAHVsxL1kfrEuFT+nSGUKyz8gGuM
	rUdE538vHIrwu33Verg/iDUdfzN+MzaSgl7+vV2pxMa20QZqgXCX9lioYkwD4CFzHkBwkhka77x
	FTIpDQBHRreh6xJ+dIYsGGy8HsVHWNqcgrTLbbISMYinHrGwJsjgbpFI5T7I4/gTk9BRlYos4dg
	oUU88fBZ1zdt4VlIiLSveB8t7b9upRt1sPdOGzj96apGC6nbUEcKBlBnSBflAdpSAveoTD+tfT1
	7bBvXo5RcxBNG1RGae0jO8sXDEwwI5vu0O2l4RpPffGj5zA==
X-Received: by 2002:a05:6102:2c8c:b0:786:a11e:484d with SMTP id
 ada2fe7eead31-792944fc018mr1260321137.6.1789161791064; Fri, 11 Sep 2026
 14:23:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 14:23:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 14:23:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aqQIA37pZL0TZaDR@ugly.lan>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
 <20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com> <aqQIA37pZL0TZaDR@ugly.lan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 14:23:10 -0700
X-Gm-Features: AcwNN1W_wgVsCT-p7-VruIswEuHkLcq50J6stSm-61L0--dlrpIME2dTYBe911M
Message-ID: <CAOLa=ZTSMgbAZdXv0NoUSjFocOpYVKQavaKyjN9U16OcMNZaGA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] hook: introduce the receive-report hook
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="00000000000000adff065b3bb105"

--00000000000000adff065b3bb105
Content-Type: text/plain; charset="UTF-8"

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Wed, Sep 09, 2026 at 04:51:39PM +0200, Karthik Nayak wrote:
>>[...]
>>Introduce a new 'receive-report' hook. The hook receives the complete
>>pkt-line encoded status report on standard input, after all ref updates
>>have been applied to the repository by execute_commands() but before the
>>report is sent to the client. See linkgit:gitprotocol-pack[5] details on
>>the protocol structure.
>
> i suppose it's a matter of taste/policy, but around this point i find
> the commit message's verbosity to be counter-productive:
>
>>The hook's stdout fully replaces the report sent to the client.
>>[...]
>
> i would cut it down to the parts that aren't redundant with the "proper"
> documentation in the diff, keeping in mind that the central question to
> be answered by the commit message is "why?".

Yeah, that's fair, I think as the versions progressed the commit message
got clunkier. I'll leave it as is for now, since I think we're mostly at
the end of the series. But will keep this in mind :)

--00000000000000adff065b3bb105
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fb2dda183f1bba42_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xa2NUb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUZHQy80L2hhWmd1RXI1YjNWVlczYXVpMktLd1NzeApVa0JsSmlCcTBp
QmhjeWp5RWxYQkZXdFpXaXBGWk9xRVUrbXVMUnhNRjJTYTI1V3BSVWNmWVdVL1o5TFFocHZQCnBQ
N3RDcS9LU3Z3QWRFeGtNYlBBUGdZZFpvUFNOc0pRYWphcEVkZTY5YTB4TUJTTlJIeFJkV3V2NFdD
ZWxWc0EKRnIxT1hqNGptaWRHakJNejNjcGFFeTBFV0ZWayt6SG9hQ2N6Q01xOTlmWVkyQlMvY1hi
VVpuMWNaZ01DSTN5VQpySzk5SHpuTTJCekJQbmpYZ2kvekpQbGx1T3FVWUhxVGtaY1ZYUlovbXNn
QWtKSXUzNE5SWlhqQk9rWlV6RGo2Ci9iM3FoNWsyQ1dmMk14VStROHdMb0NLeHNlclFpcDlmNGps
aTNCelpISHBsNVREMndyOUg4MU0wZWtuVTFOOXIKY0ZDOFJRUThVcFVLaGVZaUJhUTcxN25DVnJX
dFFUeldhOVRzc2JrWUp4SHNBSkNlSnY5SE0yYjA4b2p5NU9xWApyRHNBVjJ5WHo5V05LMDN3cVFo
UTBBcENmVG1YUlBFSnp6b3NSa1RVZjFJTUp3WDdBNUlNZkczZm56aEc5cW9jCjd2RWNXa3g0c3hi
SmJiUDc0d2o5c3hBVmQxSDcrUXVCMlJiSEFxUT0KPVM1VzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000000adff065b3bb105--
