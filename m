Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793965523;
	b=0DHH/hKeF95k/pfrUgvse1AveKC9N993gvqaPXua1x5TDGeJiwRnBex7CJWFA+wkxyBf
	 F8hlyYkKh65XvhPGJ0Hyu6g9MPiln+sBEErM2sDuLN0VzevoNzwIYViX1eU+W2jUUBjYu
	 da33gPbmGeznQWFnHQLTRpsMRqrGL3RztEvtiav1Kf/My4kcSb0IBuoC9BTrRWVZQTDPn
	 GBqSLumhD7r8xC5aquNVdmASMm90jStc6qybZLe4Q/ShkhMEH1YcTf0n5XmUbJE2zUxZH
	 A5hkxB1Px3LjdIDSJoezhFTG7EfD4GlCt3pu2EWjmp7fDcFyEuzW+xXrVCE7iY47/CA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=b+LS1y2mKfJkZMevXtvkO9svZ3muWLap66SE69h9akg=;
	b=HjAlhWR7fZJc1tQPkIf7AgmNZlM603ShYfPIMpXxQ9UcoIrFKwxbbhyBnquy+64XDHar
	 AzMntdVBW61410vTJQ5uo/x7NhrwcUGZa64w+b31KHHQwWgREAuDCAB7aELMIVoRlg3u9
	 PS3KOkm2KI8QlIKdXdf9/gv82CrSZ6IpBm+zTY7N+e6VQiGh/1SWHCaHHOB8JPJuaK2J8
	 uz22RuJsF33xfSfQwrhWheQDQJo6YxO5N7gf1McwT0k/QW7GpDk1LCTVd8BOBPdPE36Dc
	 coIBDanONyNsi0e9SfUj2Nd0RT+Q9g3yna7I4GOVH1OXZen/Ke9g6Uv7rzvjfpG3Dqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DjJE0VTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF89606A32D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EF89606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DjJE0VTV
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso179755e0c.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 03:45:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793965522; cv=none;
        d=google.com; s=arc-20260327;
        b=jwUHKqK6b+LcfvfQTugAQBJ6Ux4vryPcnDj9GtkIIxBu/hmFP+F8XXsKe0RO98oBMv
         az10Ua2qqYCj5zGu+HZxz6UMmYqZggseyD5zwvqxiy/1/uLkFXO8txNXHpWo1HTKcTPw
         jmlzDFjDYmneqzujJ9HoSL9BOhxEJCjrO7gOmqCNrdBPcli5H7fUBVVHcmawwrJibOcX
         0M2s4Gr509HItjWAhWEp8T8iHj1jz9LUBijyyTOrfhDUo0MZ9E0Dw4LkeFO3VtEe0lZK
         HyjhBQ8w+ojE+cXiKolV5Hhse3OJJ7pJqGT953vk9qsViv782eOIqSw0bQ66kzRgprWw
         MVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=b+LS1y2mKfJkZMevXtvkO9svZ3muWLap66SE69h9akg=;
        fh=zYXFHR2u5u2QRto9nJlOPDQhJ7sQr73jJ/Jl2UX2Ooc=;
        b=EQzYcSTSiKBlTdX7XCfoiigNJ/VuSahdfMRG9vkyOgbHWZ+5AdlOAZvSRx1IVwISO5
         y9Q9q9dPux/kJ6hWdzIth8FcEOv8UJsxZ3rImRl6vKawE7/scj4ZO90JBDljAjzy2Yct
         pYgcYRj3dP24/2mrVZf3ApjHK6Omeuwt9Dtnhf1IvbSRsyPiyv35+Dd4FHrufzMa+aXs
         RWl4zyOODJuL1Ra7IwuulNq02JExzUUrAt5WZFrml4qWJySvEbZL0e9zKZiIZpZxo/t5
         1XOfEErncRzRIsYFlz/2VTm9eF3Ri6gyjbH5+4oCgsTKkz2FCe0Dj4AIMZRzcsOLw51l
         Ciqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965522; x=1794570322; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+LS1y2mKfJkZMevXtvkO9svZ3muWLap66SE69h9akg=;
        b=DjJE0VTV7cJ1zHErMm05jHB280rhY7rORxmSaPf6FCSFjI5IEhyovhMRngTzd0Z0m7
         bF9Ua5hrPfp6g84anb2oXS1M61zaHF0SSahP1bwZJ7M4JQLe5TYQaotAsoOeocMX9A4a
         g2kNxH6RchqZyTHxPNHHjAJpDB+YATlrk3lFpRaY4Jv4MTvY9xA7WCHNIO7UR5c4mwMj
         BNH1gAaOrBmFp3WO5QuNbSOGMkSe0b7TrISSB86HH5hikPcDFCNX+P/UhmRJso2W/KJH
         EghT7s49yZOaUZuQTBxJSdEzy5NidFUp07NYr2iAew0JNJeRZ8T9SdEao+0AkQwhqqQl
         7Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965522; x=1794570322;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+LS1y2mKfJkZMevXtvkO9svZ3muWLap66SE69h9akg=;
        b=tUYAFZRX4Zy3igBQHxTmPMVpS+X7oZwyHRey7wtMRxRMpqGTA6QJRJ6jedtsrjscG0
         1ue6NCZdhNZBhVos4rpEBqutEXgrkDIsPTCJfyx+j99ZPBm6DCCds+TdLqEh+DGeGPer
         E7rYJfIfjeCHj/Ahqd85f/1w9nGDT1V8B4R1z6CGY9ApvGup+v3ZH2eKsL/8iyXNBDEb
         qf/8H0KDEUysPdZUArZ9x71OGsIAMETATp7GxKOouNUfu6oFsqsZpFAFoWR0bMq+4VbL
         P38gnKgIRshZ7eHINmHArIFzK5vN/egW8fWDPbJZACTuQVeaw/GW2qsRGHl0BTZa2ZmH
         aCGQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1VZEgqPNJ/+HhA2avY9AJzCFpr/NT8Se1r6YCrkATDi7t+4ainezVWbDPED1UUDUfy6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/taNJyPz5lgYB327JYzEDKp2BcJbSEQaYoXaUTD2PqO2ov0wor
	o0TWoeOfq4qNvMV0VMUx5z3agDKQdvMgDVDrq8L5tXe2F6mBDVmWucOwgrUjqrPnrTah5hcTNHI
	6+SvpRFEFvqSeEW+5oZzDOoa5PRHEIa0=
X-Gm-Gg: AYBFou1RpqXcG/smH5zMcom/Cqy0k98e4sueXw637rAdsV3jrYnxBhPqm2ChkEVWVu7
	l0K5P8on0nLNBsYm93nFSxdm0hRmJMpuHtsFb+vcnYQFVxm9OnG1zejqV6OxlbRauHKbINaCdmn
	bX6KpxWdclao5es3DiPoWqlshEi0/VahxUYfmW5M0Rka2H4MHwWuPVi6i3Nn5v2/bsZSLQ2l6ai
	+0cCLhaK7xRfI+/NlGdZYX6vDgxNzS6MWdh889vQ9jdjGe3mcuZJC01blE7zTus1HIBJkc1hAUi
	Y6QW2gglu/KQnlWziR5LLLZrfgSYrmQMXwq7YhPH/7teV2R+0wzOju/p0aaK66OvMjpao3s/8Dx
	/NdTWFAsWy0enDF4rWb/QTmg4PhVDvyTkp57wzaqvdq8Dlk+MLqhP0vGNqypXexnEMSvJmTN8GZ
	etqtlMb8jx3EMOna5a1cpgQNWuKUw=
X-Received: by 2002:a05:6123:b2:b0:5e9:6d96:a910 with SMTP id
 71dfb90a1353d-5ecc4321207mr989207e0c.3.1793965522276; Fri, 06 Nov 2026
 03:45:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 03:45:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im> <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 03:45:21 -0800
X-Gm-Features: AclHuK847JBAUJ1m4kT3-mN_HToC4wo6gsyEOkI3ItSfgGo5MObTKI6hq4Di5tQ
Message-ID: <CAOLa=ZSiuNPmegF726Sw_7ieCnx-vPVNLp89War_Wvc9Tq4S4w@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] builtin/rerere: convert to use subcommands
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b1f664065f9a2500"

--000000000000b1f664065f9a2500
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> while reviewing some patch series around git-rerere(1) recently I was a
> bit appalled by our custom subcommand parsing that we do here. This
> patch series here thus cleans up and modernizes that part a bit so that
> git-rerere(1) behaves like every other Git command that happens to have
> subcommands.
>
> This series is based on 37b3475fb53 (The 9th batch, 2026-10-25) with
> ps/rerere-remove-global-state at b948c10c8b3 (rerere: get rid of global
> rerere cache state, 2026-10-23) merged into it.
>

Looks to be in good shape!

Thanks

--000000000000b1f664065f9a2500
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c51c20c6b3ae36a0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHZjNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3hvQy9vREd1M3pXVUhpcGoySjVhNVR0RlVUL00vZQp4ZmF3OGZmSTFi
bjREVUpTWWpabUhhME5OcWJadnNmYVRiNFlrUk1zMEV0UXVlZ001TG94RTY5K0UrZVVvdnBHCmZX
UUQ5QSt1bHJucnRib1BjUXhuWEFPOWMyNDQ4V2hlRldWaCs1Wjg2dU5ZQXRUVzI3NWQzTWloUDFm
RkpvQjgKdDYxT1NZOTc5OTlEV3pVbitqN3psc05rTGVMVWxEbTl4TGh6TzlOZWRrVjM3UStoRVBP
R3hEcVZjYVMyL2xxdgpVWGQ1WmJSNWlPYldGemlaem11dUttdWluQVYzYTRSeHdLV005MzBlZFpZ
VVByRmJVdUZFZU9Od3gyTlNSVHdKCmpTaWlkQlVWWitRVW5YVEd5OWxWbmJ3bzBUMmIrT1Nxa3Y3
YTZ3MFRqdi9wZmRxMG1RU2FZNnAxRGhhY1FkeEQKUWEwalF5UmNkaWtXaWRqS0xKYjNrL2xNL1RJ
Mm5hblAydzZMSDJYZnVPWXFUWUVRS0srbHRmUlhuU2RJbVVVNwpzS2MwVjRIbFZHazZGTDBWZ0ls
S3lreGhSS2h2OUg0T2tmUTBEYk5sSjNFb3RMY0tUSDFzUjR6ZFhEb0thZnk4Ci9OTVFsMS82WVdj
dEpnV2UzVVZEV2JSMnVZOS92NHJldHNaMHQzTT0KPVdXMEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b1f664065f9a2500--
