Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DF27713
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863776; cv=pass; b=Ulsx5JaBWh+D+Mrnoht/1YaMyuEL4iYUhkiNs56rV0cmQNxKO8ZfupCrvl6i5jBddJjYN7tQO6vPxsGqkSHs95XBfynnf2li4qZHuUThUyfBwD2OpF6JRGKJ+1LJnmb1Qeez0fYAyIumoP1kZxuUo8aE9cmuYBXe0WcfJV8v1D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863776; c=relaxed/simple;
	bh=LXir4+nxOrlat86dsZJz7pN9JIO9Sk49a2Jk0oF9zBQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oabkscHP8s+WNbb54ngiGjs0DdvbBlO/6PM8yHfJWTXZT+p9UW5mvYaI9I9S8S8pXLmACflRnKjC8vnMKhygJpX+DOsZJi7dPpjBthxYccnzPvS0e3859lTIrOtMY3EVVEQoDmzZUEbfROyXivn20m5kReFUWRuw5jmOL8xYHTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQ2WQI3N; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQ2WQI3N"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-60fea0840f3so4255419137.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 06:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776863775; cv=none;
        d=google.com; s=arc-20240605;
        b=YtMcIRAD42Cxq1n7e8zJydh5Q28cjppMUMccB04qreAaDPH1RYTg5rSEnCZa1lGOlV
         0Aj9SxKIjnwvlMYVoW1DFMxqETkRm+8Agv33UVdLA6sz4ynV+K8uzvOxLHNs/i1gXcRt
         imRoScaWryyqoVhPq7myJdyERs6PdbPBZat5I+j0l30AgbfL75mpxBRpZ7fZPPrEAs6Z
         SialAHVAXgddgraMmz1acUOpQgOqMvNf2FV3La4ogTHOcVkfCmnR6v6Y7xD9x8cwCD1w
         9nmRLdUa7J2em+zOGp03BXsyHGObMI5x2q75N1Yt2KCQkgZclxUYvPgBuoZKc8aUVLnc
         tbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LXir4+nxOrlat86dsZJz7pN9JIO9Sk49a2Jk0oF9zBQ=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=YaikYEIy4/u7nAGTZWXTJ4g2B15eMew5LBBMz4+BSov3NT1w9AWAtn6BU6OT+l1KGS
         e8VEkqGt8i5GY3SeNfPPjxsXJm6IKKXORNE2yVrkFFyY/WB7wxkSezRvQ0ZCSXw3COlT
         6s+RH1RPfg9wnMR8vXQVQPVHTUi0Ush7bq2mLH3/QqpqJaxLD9Vhwx27JPuOwZuxhLLB
         iBjrwzdoaIo6h1YezxZAz6r079MnlxOUNG777qNNNaDAgSfWbs5cTCDRLYRzJfAiWjYX
         4Pst1Vm+KmK2LyV2p/D6i/E5+UnhfaHZYSZfRWFZ92qK9a4FMqzznyPMNhvOWz3B9PSx
         2tMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863775; x=1777468575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXir4+nxOrlat86dsZJz7pN9JIO9Sk49a2Jk0oF9zBQ=;
        b=qQ2WQI3NXOW+Up8j67/mLO8jjwa6G9nKVZoGDm0wq3ciF/uorgfJe2FOmwqePoM+xZ
         irC25QshK0zVQs/D1clOyfJEQwp6ij4QDBDSE+vEEbf19ykcShbhwNjPDGKHw6NUw9HJ
         bXPmlECHHcOg53B6JqpZj2R2B2LtI+BHuJuPPF36uhiBKyWaF95t/vjX9AQ9wSr48tad
         soyWrCu8wEWmWzkS1cbiPiiAM06yWMlkDvqa+nuw0h/YpBeUGqMh5c18hrzApy5bZv+y
         mxJ5ftA+HY+Tizf3aTFHjRlRKuD5Ujm4g3/2+95FFsQh7ZJRZVWiJh57lubzkFagIaBo
         gslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863775; x=1777468575;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXir4+nxOrlat86dsZJz7pN9JIO9Sk49a2Jk0oF9zBQ=;
        b=FDiFBnCBjTdrYKm0+CCYIa9SMtv2zWw+FgIVXrKxwhLD0hW83doTihtvvnrTAO7LiM
         eomF4Ejlok4tw9pWknV0HlB+svwF8WLY07uu1l/Hv322YwMEKBNDszsxcKo7UcJQ96HB
         Z7U3BJGTO1Dyj9GN4AMx8i9TcIgfAqUEAAGnfN4UzuDBD57Bs1HAiDWB+u4M1BNtQrMA
         UCzMjErQGx1mblbxzqKDlKjollrm5T1NW8OuJW5Qjt5Xt1sKJtHTmH5LOFWB0MHgqGHV
         PaQWHOC9i9h6K1A/HfKjgDZcnd+svv/Gii6sVv7F3BE1MfzO/pDZmkamNC5+MV80iNc8
         5u/A==
X-Gm-Message-State: AOJu0Yxn8gtQE+ncMezCLyGxLCvDXrtw4c7X5y/qUpglgLGB+mU4vRDL
	nUvi7texkODDPx7293EhFPa6aKRkRC3m6g905kcOzwwQGzvcSM2ZibPVnNyhduR2lEilbiZ/wPe
	ckyA/ZOC4OxIrRngJk1Cb1R1BMif8GR9Hlw==
X-Gm-Gg: AeBDievr0UCTbpSVjiRuWYp5ovEWjeVMEnRTsjVMYPq2JE1a5muNTve5OgsI4JuTTsZ
	GcLBHbHnsC/pYvzyYIltdc05Jwi3Gynyu/b8jVlqNjUJa1FptFSl1kLsbJBC/AHpRfpdGsSYTH4
	ApYYPDL4TNQ84rMHEjxu4LLgfw4FW5tlIHku7teGp3wZ9ceJDR348ipoEI1hj+F4goFg2wIeFRn
	OrdhJN41Q+QmMSiptpOUMMkHmgjaR1sQk1CjnxNhCsBioQpGt9HQsFx7R5BIbKtDU43xPPH5oiX
	Cw+4xp3DNG3Jiasv37Ypvrm0O0tQQDV4JQcI8CREQN2v0lC+iHsw
X-Received: by 2002:a05:6102:5114:b0:608:ce6d:4db1 with SMTP id
 ada2fe7eead31-616fb5837a1mr7116856137.3.1776863774644; Wed, 22 Apr 2026
 06:16:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 06:16:13 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 06:16:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeit3RVFhX680NfZ@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-4-513e354f376b@gmail.com> <aeit3RVFhX680NfZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 06:16:13 -0700
X-Gm-Features: AQROBzADr1XuZyD-E40Jw1-36IUJ8nPfaTG54Qqlig2Jji_tF1y4ul_fqy3v0eM
Message-ID: <CAOLa=ZSh1ciC-JD9M-dC9iiT=Q0up5UfodQ5VAGvNtTsZMUYww@mail.gmail.com>
Subject: Re: [PATCH 4/8] update-ref: move `print_rejected_refs()` up
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001a50ba06500c5648"

--0000000000001a50ba06500c5648
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 20, 2026 at 12:12:02PM +0200, Karthik Nayak wrote:
>> The `print_rejected_refs()` is used to print any rejected refs when
>
> Seems like a word is missing here. Maybe "The `print_rejected_refs()`
> function"?
>
> Patrick

Yeah adding 'function' reads better. Thanks

--0000000000001a50ba06500c5648
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5b93c8923403fa8c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ub3loc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWdHQy80MXhSYmh0d3U3M2duNWc5dVNsMGpGclRVdAovaHJHRHpHSzdF
QWVSay8raEcrbUU5MEk1b0xDVmZIR1FSdnoxS1Q4cHFqcXNURU5aci9mdW5ZTE9FRzdQeXFECjZD
dllmbXFRdVVaRm1Pa0tUSlQrVU9ycmsva3FITnhUZHk1SUUxbUV5eDZyUXNVVWFWdmZJbzV5ZGM5
YUlkUE4KemlBcGJKTUpOeTE3emcyLy9PWE5hVXVZYjZEcmcrWXc5SS9UQVZYWGxhYUdiUmZBMEZr
UkFFcnF0T203VEpJUgo0Zy9PMmFnTXBtaGVtbFpjYVpSYzVSMFFvSWdlcXdkUVA2MS9mdUQwYzBu
NmZET3l3TCtUUWVxSzFIUUlyRVFyCjF1VjdxOXNKTUJIR3lKYlhUWVArWjZJQ2N3d0MySGRJRVg0
SlF3S0VMcDZONjdlZHVGOFBDN2VRWENGejZnbGkKQjhTcnFlaVM3elpwbFZVYjduRzlqVGdXaXZP
MDRnd2dKSkYvMXQzaitxcmo5VTFUYVBuUHpROC91WnVQTXZKbApBWjM0WlBVL3BmYWdUcUQxVzN2
b3JWdnM1QXpmTUhLOXZSZnMvWjNvUVM5blFlUS8yVFNpand3QStMVkdxQlVVCnJvY2pEYUNia1Ro
ekp1T3JPWVRlVjQwaU0ram0zaGthRDhyRk9LOD0KPTU2THUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001a50ba06500c5648--
