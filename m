Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278009;
	b=0PTszsQcPIIKsTkd8DLdXB6vp98C38UZ9uhbXnBKLk/Cqtrc69KIVdMv/QY7symyg5D+
	 brUCii1MrHWJnYPk4pfmOqVbuXpqZSVDB8ULCqRjBSlBH1lwbVnKI96tshYX2HuuTqVmO
	 xrxuSrToo8NLjVVCHoNE/puTppBdPWNFhj+ewPSM2k7FxagaZfyUZk77Q+tThHgEBPnzl
	 PAT+06Po0CES7rsZ9eYC8EUYuN5XRS6f1xxVVpqeZztnn5SN8A1+Zvk2T3JO/WDFnDj5S
	 O/V9Al+zUoifbFI5ihJxEbaRtAdI9tHaCWYii4qsAxo2yjTh9ydF4lhyRk6FfNjJNAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=TewcAqaMjz1SdNVvgURSQ3e7oimLZulGAvliEbwRKlY=;
	b=YTSSB+kdQoWeZYN+vB5JYAmSrTFgTdxdw/6ZC4tbmYkkTp2rYDkw/ezp3TXA/35/ylau
	 J9/eS0NQfQGeEFPNXB1GCq4G0CwCmwvU5DBfyWFuzFrZQiQ8NFX5O5st4Kz3q5JwYxbsA
	 +zTPqHISr96Fo97XQWDXCrXnYnq7601GOt1PeSPa10504lA/RfwDLjs0yhFDvLk2cT7+/
	 QqjYAQpVDDMm9r/i3jGWlVHAUYATaSXe37ReTLehbXtFSxaGbYBE8O3QlFNCqrODWWNcM
	 is0k6O0kCc+9PFdLsEkHPtAXqaUEFFPuI7Re0iUSMVzlWvxc6EuyN5dBIuyJB2F1vTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dFqC9blp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DD606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B92DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dFqC9blp
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a3c08d6928so2750902c88.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278008; cv=none;
        d=google.com; s=arc-20260327;
        b=YGN8toVrlUvxwhLSXKY3N9IdL6QVJJayOQLwjmuQjho8l+IiEAEQuybp6fJuLhIOt+
         7FDqxAHj+/XGP/Rp8wIbBgntV5Uz1ZQbaeJHwpIE31j1rulzrvX5vVmVW52vcGcknk2x
         dDBDGrziiUiMbUm/8VsDJgmvcrIr/Esmsq877d0JZhcROdlWEFBDTGA13FxML16eKYkc
         QAooer1iykMI3TZjpFFqJlYag8QVG7Fx3CteJnHEKz3+PkO7D3Wt/plzrigRtSeO4CIA
         frISQ+P7qeZIvQAtay1/UXhXckxPl1zAu/8evQhMB79uKLtGo2jU5/7OG1GoPOgamIGN
         oS0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=TewcAqaMjz1SdNVvgURSQ3e7oimLZulGAvliEbwRKlY=;
        fh=lyRVSDRDdA6UzAlN/x9NEoYZjoiGIiZt+S+t3wc1xic=;
        b=lFzVxytBn5yVXnuUCiZJU2X0p2J0yzA4Ysdaib+c7lKGnW+zNGJgtSZzaDtEbqp2HU
         V7Sr+WPLYihhmxfcC+sJSC+gRI1+LyxsMt6sVwvwYGqGASE9JVxb08SMDTsA9bOzWIjs
         lsRQ7ID/mWh5WSisipRY5erObu/4/FfOKzup4ivQdWlKHfkMBzRkPd3NDjTfM81SiRKD
         LIYpmI8b0hdSZP1GlBeZHtBe0sNnv/L+k4r16H6ZL2HYQEfSdpLcT5Ww5NktFlnApxWA
         IZkhycZT4QcN+0odoYoHfiCNSBEhBXbBm2ITDoy/VYrgKEmbum0hXy443D6tklBuLYij
         7efQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278008; x=1793882808; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TewcAqaMjz1SdNVvgURSQ3e7oimLZulGAvliEbwRKlY=;
        b=dFqC9blpcSVn655ELVzEyw+jrwE/kgPZA9KA1tWkDTwCGSVnOjZ0qqK8vO2PLgP4PQ
         Z4jA2DOMfCdgJSv3R3MaAyaUNNj0NlvSz6luUbH8Yr91AfLvT/ZTminA985SnNWhP1Kb
         a+Q1XMvYtsx9WmHEeF6fsZi8cRZftnrOzdIKpe7RbJwClEGLbj4sQ9UBeHuIUDrGptSz
         YTeIle+RITqYztRVZ8yj6Yu5cX6V0hykmwQ0XH0cjQTJI68jBRD6xRAwwmw4xrNQ0vS+
         QAQbb1jexM1j+gSWoCMtc8553TAa0lx9jmeBEsOD4kD6sA4BQ2AWAWps0Cy9R2fujnA5
         1xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278008; x=1793882808;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TewcAqaMjz1SdNVvgURSQ3e7oimLZulGAvliEbwRKlY=;
        b=xTVtx/qoG11zt347lxnM+QfRucZ17dhmOokvW4VsJop1xKs/Dmp88eA4bqQZ+RIGNp
         nTvLxmPo4L3lXHVfRck+HItqXKucK9ADJD630u8P1FZgbRuBsW12rQx9zc5gaCoDAY0X
         L4A9Lmdcyj58TCY/RkD6dTlP1HOOW5fb4abHka/IE3hlChtlyEvP2oSHa9ICCoz9jyWn
         4sa57I7nfcTBz1K4rqofAukPnRHgKs8k7j8osHCd8KBzuWCyA7Rk8NCctybK+72n6KLz
         06y1gZq9lEzVg5H0+BXe2KYG3DfGcP0oB71AHe33xfAr/AAw3jhid+Eca/woS3csV8EG
         kJUg==
X-Forwarded-Encrypted: i=1; AKwUvBxd711gEusbIulLSDS/1aS6j6kdIgqESP/U/a7SobHONtdnr+xpRstU5pAWPrC0iuIr9rU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqPjDAQ+k7AmYMSeA70MCmFyAZUsSy171ifWOn4y6GWbieLcd3
	l83QXXNkj6rnKrLeb8EFbil7dIq3ygkfisMHCwf1S4a+LFIW+B+/L0Jzx0FHjl4o1Uif3WzdcpK
	ey4s0ex7wzIcZryRNFRqHvki7nyDXg0RAfg==
X-Gm-Gg: AYBFou2vMs9RP1KOq82FUmMzZiRfwYNc52uoaMJTA5Pb2SUHf9ucpf+wy4CG5eC7qUN
	B8kIId0HHPujl0x9Y36BWPRK/Pvm021BSqJL/3beSXccd+XFt0nIFUb48AzugKGcEcZk/CS6hBR
	jadAg3hSvhKJQ8W8LM7JoqdxsPq8MqtJ6FH9VVRgJYwilktPXZ/rnyB0cuNip1En/n9IeXV9cUg
	RNoUcEsy0fzv9PQ9v+GhY0vMRAudb+oRkKV+ZkE+h5YZrMITbaxLi8F0hHp1AlMTS11SUC/TGGw
	LdgfKra+5yM5ETcn1WklY8Qu0hbzH7zRbouvAbB362bxVLsiHD7sMj1ibaqhuXX7sMMEyTxl3dk
	cpVjVVf6rm8VALDP4M9/1zL3fB5v+lPLSl/QfVwI5JrYly+0AB8Or64XlcKs+hH6ipsflUvx93Q
	CacHbR2JFtQXbqTKY/0o0od4WIF1o=
X-Received: by 2002:a05:7022:7f0e:b0:193:1148:64fe with SMTP id
 a92af1059eb24-1a6c87bbfabmr6778214c88.6.1793278007747; Thu, 29 Oct 2026
 05:46:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 05:46:45 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 05:46:45 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6cd5hnt.fsf@gitster.g>
References: <xmqqo6cd5hnt.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 05:46:45 -0700
X-Gm-Features: AclHuK9E3VQ0EE7LNa-YhoDXrAAllbCsO-XTJETTIrnxOwtL2uvjZ_qAK5ASfP4
Message-ID: <CAOLa=ZSKqRU0okvmvazTieLFKJKZPAxF=1fsVFa7mQhkAz4iLA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2026, #10)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a3239f065efa12cd"

--000000000000a3239f065efa12cd
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/fetch-tag-backfill-batch-fix (2026-10-28) 3 commits
>  - t5510: cover upstream info update on fetch failure
>  - fetch: advertise fetched refs when backfilling tags
>  - transport: add `transport_options_release()`
>
>  The tag backfilling negotiation in 'git fetch' has been updated to
>  explicitly include the in-flight fetched tips as 'haves', preventing
>  the server from resending objects when batched reference updates are
>  used.
>
>  Will merge to 'next'?
>  cf. <auHfmzP3aXyonp3C@pks.im>
>  source: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
>

I've sent in a v6 with minute fixes, that version should be good to
merge to 'next'. Thanks

--000000000000a3239f065efa12cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 803a38598ac99676_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yalFETVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTg5REFDQTlxYkhjS25kNVFYRWx4cHc4alZ2Q0V0KwpRWlRGdzQ3d3k0
SXNCWkJFZFhnbmwvYnl2S2lQVmxMUjlCK0N4WmpOa0JMbXRoWHRnZEd3ZVdqditoVVB6cktaCkgz
anRDWGdQM0dqTDNBVGpVNTA4cHF5VjA0UkJpTUJsdGFXWDRiVXBsNFYxb2lySFlHNWRuOTBIeXp0
Zzd6Z04KSnBNMW1raHhaMjVTMzZIODNRM1pDalcrdUczUUFoVjBWbUU0RmRNTFZ1TENVcW9SUzJX
VGo5YUhNRzU3ZG9jUQp6MHJkVzI4N3pjOFNCamI4ZUsvdUd3MmlEU1NmSHY3QXhMeVpZaGFZSVFO
emY0Rk1kWDZ3bEN3NTBVYXN6VFZnCmlQdW00WDZYR2hsdnRzbDlCdGN1UUttY0dvWStCRHg0SEhT
U1k2akVCSVFOMmZCMGU2ZmtPSjZQRHdlcE9jK3UKYk5SSEVqUVlleXlsVHNRUmpBejY4SlJIWWVT
dFh6S1Q4aHoxbFd1SVkrOGU5Wm5Fb1F0S2xyZDNxUENETGNWUApsdlRVV0NtamhiZ3R2Yklva3VL
ajEyWFd5RHlaY2ROc00vVXVMVTFSajcwNjBsZWkzRWt2OWFMMmZQYkNFUkdNCnlKR1pUNlBSSHNN
Q09rZUtlQ3RaSSt1Sm94YXhCd0h5aUlOenE4RT0KPVM1bi8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a3239f065efa12cd--
