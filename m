Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794223805;
	b=EFUzghLRxURXQspTqei0+4EaorceVRDVSl1bGrXO1DckHUBgq5F70uZAxgD4+twEwIqA
	 H+VqWHEmflrt/IpSPAQTpYfN4NHpROPps1oSvv9bn1m85cs8HBw+wgpAWDZV8OE+3QEm4
	 OZ2w7E+4akAx1qWz1MpRyTGx8hmFaHQo8aSDLIfzU7A/O0bLCQDTaMbax3Qd9Xji3338s
	 q5PN3IVnqWeUsoc0UyD1aeowVXDOTOCLOcM/9irtmxJC+tXG0tYYaFiIsnDWxzVLo5jhA
	 XHlytK4lelR/4zN9DI8l0haynexT+fQJH0OqwKgs65Gl2hJ4c/z21eqOlQSSvVfYHCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=JlAURwij0MUrrKX+77kEFhTovXARBQJHCM8OjgkUFxE=;
	b=mqmxkv3CVBvvX2iqFgQlBoVm0p0zl71BAxt/R2oFqvwLCLMdlc97yGzYuBTUBcBwGBsV
	 9K6jq3Wa1IddTIyESS6fhZfmdDf7CyOnaYQxFNmA1au6TWBjv9wuAS79l/gGCZuX1fTed
	 7Fp9F39WQIdYddbRbeSCh8uDKwg3D6cFHR5FTKPFoffQjpEQnGkRcoa6OFhPA8po+MN/X
	 fGjo2MYB3PeD4Eul+ugLwYYY60bPHU024ow5C8E4ykauT1XnQX6XcaKYISiphxW5d4Zz9
	 jbexSncwXiJ/nDqO4d2A+CbBXkh2meyFn0ApJZVWCi/KyeJkI9Iv0M3fyGvrGGE1VVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nh8O8fe3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AF606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 11:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 933AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nh8O8fe3
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d2ca055399so217905137.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 03:30:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794223803; cv=none;
        d=google.com; s=arc-20260327;
        b=mQ/XH0I5edMZpV9aSD08P2UNqaGRflK21VBhuIcZnFmGOVw5cD2NPyYpR7R2EmhVwh
         8Nyg/3UkwPm7n4M6U+dtiuc+WTlaYR+R940oJNd22IkTDnki9YBFgEZNQrq/sSyQ8T/G
         pnL3SRcbTMnD64Zca5v8UyuqXeSYmMlfxJLlwSYrNjmumWI0l7sWTLRkJvPt+cNC8WFw
         vYvQfBcJG9QW46X/7GHGScHZ1w/CCM8BPgBPslNNgxGR14HjBi84GJiJ/0XiIjkx4rxi
         44Tv+K5LspZF34XnoDndyIa2ujuyUApeC6zOeUzRS2gbt+PI6NgoQzWOxsyEZVl2bXdt
         8I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JlAURwij0MUrrKX+77kEFhTovXARBQJHCM8OjgkUFxE=;
        fh=ypDDCT5+de1Yg7Bg+Z6H/2Eq1+3Bw3LF/HLkbCTbqfk=;
        b=K4P1J2Ty1QSULmV4Aygbxq5hFEC6RFSW3/rfkXS0bam2tx4WSXCmnrCHegCVGK/qww
         xRNAnkjZPkV3ExhEekyhgjKkaTTAGyzF4wZYaxPOjE+Albv1jarZKY/S0wYtt2eR+LiX
         1cDKNYoSeoGgZfV9JYiG6a6x48OO66KY0Exe2i4h83tNsxSOxQQc08MyEFczvEou0BJw
         CKvYXdgr/zVT1xgh9iGb8840XVhlvUBm7sgwy/2IdkWS5Y4895aXPUDI/b1AJ8BCuTx7
         w84VPeXH2fCt1sfpUNsxP7Fg0//A/J91oCrIHsvST/ooUjZ8JiHoz8BsTyXlce/TGUeo
         n1/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794223803; x=1794828603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JlAURwij0MUrrKX+77kEFhTovXARBQJHCM8OjgkUFxE=;
        b=Nh8O8fe3fsFjqqgTfxFdEB6OlLG8S7e343D/cLz6fmzYK0PxpYpCOiK4r2ls2+CYVX
         waH/FwHcaaQXQobB8vonB2TIE2Xu/FcRWF+mOpOtBMEO+1+FrpHNwdSr2uhfJBE4l0xb
         AVJtwg7ZJUFhFygKJBlLHVczog5X+rlUFJAXI9wInWMitz9vCAGiSmSQbwu9b95LTJ1O
         KIQ57Iit8ItBzRdq9axnfCLrw8F9cFaJuELL0ws15aIXNNzoqxlHgLpMGKg01UWJhzGt
         iWiTdF4ulokQSS7ELIgLb4GqyvXbk5ywJHBw7C+30pSHBfrpjXgnxRe0+GQXEN7PlRIw
         BrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223803; x=1794828603;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlAURwij0MUrrKX+77kEFhTovXARBQJHCM8OjgkUFxE=;
        b=mpaseIVD/CIOt/kKhezpGNcJPhg8BoijgiV/KBqZxyzdnRf3g671AZGNUgoeJyqV3x
         NgLRobaHfQ9ToZykS/QyP52W6GuQcH/vr0QF5fq4AD3hYAQd3RKvRLtwdtxmnGWSwKeB
         9tVHXMDNRjZbcCVFJMrP0HkVO3BY+CfjoqDZgJnXc2EqKkxqE8Z7ByWvG3RGnQuiYHVD
         8CIPXLhg61Ewv/X3cCCaGwJ1xzNIyuxIhUPi+Rs8H/BmZ4MDcEzC+xjgmuSW9BiT+mj4
         QYeVyExQJT/QC/6KXC4qHBbWU6W4maPgl8cRNlVMr5GZHNz699WlbY9OFlu+geaEbtE5
         LfdQ==
X-Gm-Message-State: APuU4Z90ahy4QTRZx9V9OPtWK6q4KC82PUfIhnX0Xm8uxJOv4XI5KroH
	iD9GSLkF1IxwTzhfHpbzieDiI78guFJdhDNH+x3psZJbJSVRMJNxLzvriUhNCnimVw9AWPUX/HI
	rSTQN6FWUh1YmrW3zuaS/OpC/i8d1JgDV0A==
X-Gm-Gg: AYBFou1f4vs+H2GLY498YpaS9sN4nGZAYp4o82mJ0NyO8mYM9Lo9psDAKIIGKmANuFt
	NOR4L6a0ZOOk89x4rD2dIGk9/rdkMizxuIb5EMGMz/qeocyExujoW9MY93Yx5QR38rMOcLa3C4H
	PEw/Bb9dFMLYecS21seIM0uPs6ORY1LabGDe2L+1u0eB4nDAoPU3md6+P7Za6nsg5qgmDWotgek
	80RsKKBgqVRJoTamzAEj5d7tb5NuouFoa0LriI3q4BnRn6v4o6r+/ZcwPMTY4y6pAwYKE/im3FH
	sIAhEXDYIaNkkmcCYKqasw0fkgPsYp+MSnbfvBnGPAbtXqGwKJlTFwQihcqGnfVQcDu2vznrSYo
	kZQRahpa5X8y1P2IJ3lCiucmy0xd51NJJb3nUED03X+lMul7seG0PWsiqGpc7IFTUWYvbKgkfFf
	uOPQZBGla5cSlYAbUXHz1yk7gJtA==
X-Received: by 2002:a05:6102:2b9c:b0:785:c39b:6a1 with SMTP id
 ada2fe7eead31-7d2daf4d6eamr892496137.6.1794223803508; Mon, 09 Nov 2026
 03:30:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 03:30:02 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261106195313.1015-1-herroyalpriestess@gmail.com>
References: <20261106-kn-parse-options-doc-v2-1-453ee7155348@gmail.com> <20261106195313.1015-1-herroyalpriestess@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 03:30:02 -0800
X-Gm-Features: AclHuK9g4yx1--KgCPUWDenDglQDvclKChxwY-76_k05Ndfu5wdLWQnMCmV6pQo
Message-ID: <CAOLa=ZRLqB72uJAhq2S5iSKSoWsEZX3zxn=nrJiBnEOEbBSckQ@mail.gmail.com>
Subject: Re: [PATCH v2] api-parse-options: add missing flags and macros
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000074d8b9065fd6486c"

--00000000000074d8b9065fd6486c
Content-Type: text/plain; charset="UTF-8"

Cynthia Uche <herroyalpriestess@gmail.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +`OPT_ALIAS(short, long, alias_source)`::
>> +	Introduced an alias to another existing `alias_source` option.
>
> nit: s/Introduced/Introduce/, to match the other entries.
>
> Also, parse-options.h names the third argument `source_long_name`,
> which says what to pass; using that name here might be clearer.
>
> Otherwise this looks good. Thank you! :)
>

Thanks, yeah, let me do that!

> --
> Cynthia

--00000000000074d8b9065fd6486c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fe8ec5ed9d356fd6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yeHJyZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmk2Qy85QjFwSU9Ba2d2dUg5VitiaVcwaWJiY1MrZQpJeHJSUTk3aExJ
Zm12YXIzVWdDVSs3ZGt2WTJKZDFodGFvdGtEb2F1cFFqWmdkZWNOOGJ0bFRWSWk1RjI3YitWCk5N
UTVTVDRBSktOZVh2QzBXME0xWHRNMEw1M2tsVWpEdUxHQW16R2JwUWY1RTFyVXpyKzhEejV0MWda
dEo2UU4KbFVsbVVKWEIzQVRSTVJ2VUhhUjNIUE53QUtYaVlVM2RWVTNCQWdrd1hpbTYyTXF5aFZx
UEg4N3FNanlwZjNGTQpsMWpVYitiams5cmY4L2ptOEhLclRMakJkZEdMMU43Zy9lTHk4eVI1NEVY
eUFVVSs5TG1kRjVqQXhHcWpLUDRwCjh2YkNJOU1wZmk3eUJiczIrN0VOUm9valZYWWxDLzB1R0hZ
M0oyOGJ4UGpvTzVxSnIxMWdaNVp2UXBLZHRMZEQKVmpqS1dSV3hkbzdaRmNtaVp0MkR3ckczdmx6
bGhsbkFvTFo2NlpXUWNzaktsQlJQTlBWWFl6UnpXZ2FKUGdHQgo2cXNtM1g0SDNUNWFVZmZBTTFZ
QnlaZ1NiZFJQcFo2eHNlcG9oMWp4ZEg1OU5VcjFIZkx0ditiZ0s0TlNTVkhQCkJlaEtiT0VRcWQ0
S3BsKzl1TDNaaFZNRzdjejIyNFRMa1lvNzAyQT0KPThUMzkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074d8b9065fd6486c--
