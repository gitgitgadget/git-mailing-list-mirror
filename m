Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C143B49F
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825004; cv=pass; b=T33fhzQdS3gBtUsV7mxM8DJ8uFHepEE52s0lRmA+jj3HKNvmEgbyhIG0Ug/Wu+rbb+BBl/ALSGaURL/kw9v7GzYmMuHpDKqSduGxHqufJFBlvdmFXecG4s/WIhR5yJSKw+FYv+d0cTiqS1ha0qxxiMFolUdybtmBvcr02Hw1CW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825004; c=relaxed/simple;
	bh=EGUUilKrzQyO7GHZddf/I/6DPEEEfXQCLSOCNxgg85c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=RJ5rbOCmCOngBsCqv/taMyLUSBgHkBXbcXXjBmehhLN1Ceek+y6W3gIoL+iu30R2Hi+fsEIjmUW1weBITtzrOdNLU56XllpNrLTob1AEiy4uwyfb/E2nRmbnzZYXDEUT0TIXPfQSwFfld+fb/clzdN8SpFMOgPEbIJc6/jrOShg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Moi4cpPi; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Moi4cpPi"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso126994137.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 03:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787824990; cv=none;
        d=google.com; s=arc-20260327;
        b=IwX3M/i05hQjSTP3NFi6VB6rFUUQypHiwEMhhyFbAp2rf1zmW9oPkMcMScPAyHqONz
         6frVV3RDKpF5iq1EpbWqmrbXUTr7pbk2gfVs+6Cxj7D8Kq2ESvzTDmOt7AN9X9NLmV8C
         d/wv5B81qgb/UqZTW+wIx/XS0stqxk8JoXMpBMRcTVolv3KV0+GrTtB7y0nMxIKrlVER
         g6T4rJfX/fES2pm3eW5pWwv8SAQVWnevyJ67JVgnbuKv4hGIQxH8nxQEd3RjlWAYh9La
         3DD4BW/08tpXN7Trxpfo3kRA7/0m1z9olzukmaDEfYmskyWtK+Hz/O47A35ahLw9koVK
         Qj/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=bbCPJ1efSUzwU5mfeaijExQPUHbIP/ERnCAkDKwHvc8=;
        fh=/hZ9KGdMZnYT8XCf321wAFEvTf+xHN/Pv9o0ZhMT1FM=;
        b=Eo+lB47weR+chpNLgLtOuXUWQW8BrathYdrAphZ1FxMFsNWpHVLaMGhzmP8CsFcIkL
         Ty53Q2/NAMtqXuPoJ14FXJE553hHHJILI5MqBswA+8uAflPMxgiXv2S3ianidjwXYWpG
         QXzwfFaRuu3TvUMv0HfhVeeaE7qyHmfyAo8Bl5uxlznBuib73iOrii1h+qpfRsTi8h4A
         5Br3tH6233Vig2gOlbSemQG+3K2EZEY1iZ4lh1s3GL1vH3aUCW6jGiqyhAoqNN9S2DMm
         dd3hLNM1WJeqgBw/H2IO3d0oJ2xib88F7hWyEWxj399cIzjFWzc5qprbt8ByDpqgU8Om
         PWVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787824990; x=1788429790; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbCPJ1efSUzwU5mfeaijExQPUHbIP/ERnCAkDKwHvc8=;
        b=Moi4cpPiFvCixB6/rKdKOFt+O1gc8tRbAaPJXsyZslvlt3uElAFcQnS0i52pcapX5A
         FItH622cTRlK4ts21cRQ0Le6XhgESJm4cR8NYt2kQkP+NBH8itB8RvVzlzph12VxHhRy
         8HPSqPtODC4HnBQOhnVVwQXSe02tkfEB4NGae878KGMKdONSlDa3fiGP36QXVwzQzmL3
         4k1ydb+iwkU9xJkZHmBIAmeCAf73kHLCHDVGIxCI+4KQJlP365EbV/oV58fLEfMpLks4
         WRreKMytvIw6ZJoXGskylvrtE5LL2ZqHRaeLDrO2nwMLo74UMRwS5c1lQRBvGUu1T5B0
         9l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824990; x=1788429790;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbCPJ1efSUzwU5mfeaijExQPUHbIP/ERnCAkDKwHvc8=;
        b=cKStPR+aW4ArwO0QdnycB6j9ifxQrFIgLBZtTV3+FEOTCYo/UfJZNLOZ49ktLsEDLp
         5Lxf2PZuZygjEf0KtCmnDiz7S/OSQ6jBcVsb1BUZZWEU7z6MJWfxDRyPYTquqkeGdgtD
         9kG7IbdfOx6dMTyos3qg7LQfOImCttTcnrKzkB4xbQV+f/CP+lEXBh8qu/K203SMOzUT
         PueU6YLzM6AOGip4VMYLKjBT/eNAJhZmz0qBAxUFl7QjETFNPyAqR91f+9mNwn5INwNa
         Ks1Bqb/TcYRrk/BQOV1wpf84tw7x8k9H5mecgKU+h/jme2hvITNw6YVTooeHR8mRJaeQ
         cJtg==
X-Forwarded-Encrypted: i=1; AHgh+Rrem7OH+8r0gIstBZZGgt5czzAEYrUVzunOIY0NCIHA/LTgc+IJR6BREA1jOYMwq440YZs=@vger.kernel.org
X-Gm-Message-State: AFuF++km7hB7Ir0UX3FF/RecSg4rtotzAblH94LTDKRNhYnJNfVofPsj
	QJ4wg4xoSuAOtAi5iV9OgZMgTBFqMot9AnKVi33tAxyt5hkGsA80tpweLYXMd2cplITkPkEQ1Lz
	vX8pHGXTk7yx0ZqyKNNUxAlwBwkvhn9s=
X-Gm-Gg: AR+sD13laXRLyxyEdoSlQhKExYex7i9+5fx3IIBQWXVTOTpQhPdG+6bapXc+iGyi/Ec
	1gES0ea7c4bCRI8ZTyw/NXuu++hcw5TIQfnF+cNC4XsTyG967DEkD8o4PNNRgOVI1liFaiS7MmP
	fLIVdoW2cp7v4uP+nWJ33QwnRjA+5adoqvcNRW5T/ydJnrqPpi27yXCLyixhYrwaKcu1yn4OYVA
	GOPcYwRLtErA5rAwCL1nikWh7B5hAYR3K6FCjqNL68a0K5QVT9BNZE6DGWvD2n5S1n5Fw7toZ0q
	k6IvsumG8dlJtWRFUvbVFGS+QWAit2xRlYeKjlZKrviu+uqICp2Nr+Vv+0k7LhY9rhrXipj8Lrz
	6esbjQlSmiDrIm5McFPamwDxITkwaCKbKIg==
X-Received: by 2002:a05:6102:5f0a:b0:76f:eaa2:6fa7 with SMTP id
 ada2fe7eead31-782bfabe54bmr3873603137.2.1787824990035; Thu, 27 Aug 2026
 03:03:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:03:08 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 06:03:08 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-2-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im> <20260825-pks-odb-source-fsck-v1-2-b756de0bf24f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 06:03:08 -0400
X-Gm-Features: AcwNN1WZOmKgzz6QwANPro6hxV3FGAkqM2Ou9qwlwcOuqQgVj7XvNemdzZHzXFY
Message-ID: <CAOLa=ZSmjfCD-5fPgJm4cbaKZOQa0S62wAf+vSxWFWLrrgczBA@mail.gmail.com>
Subject: Re: [PATCH 02/10] builtin/fsck: merge `fsck_obj_buffer()` and `fsck_obj()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000073d4c6065a047126"

--00000000000073d4c6065a047126
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The interfaces of the functions `fsck_obj()` and `fsck_obj_buffer()` are
> somewhat similar to one another. The only difference between those two
> is that `fsck_obj()` takes an already-parsed object as input, whereas
> `fsck_obj_buffer()` parses the buffer and then calls `fsck_obj()`.
>
> Furthermore, `fsck_obj()` has no callers other than `fsck_obj_buffer()`.
>
> Refactor the code by merging those two functions. This makes it obvious
> which function does what, and it allows us to get rid of the early in

s/early/early return/ ?

> `fsck_obj()` in case `SEEN` is set as the only caller unconditionally
> clears that bit before calling it anyway.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c | 47 ++++++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>

The patch looks good!

--00000000000073d4c6065a047126
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 46d18e534471935_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xUUMxb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2h6Qy85bnF2MTBUZWFXd1NHbmVySUl3Q0N5MTcwUgpXK3c2MVp2c1pv
U05PUkt5S1R2TnVYdmRXdXRiRmtTVU1ZZEVubEZLVXR0TTEwajhVay95dTR0aDdVcG03ZzZMCmVt
Ty9xc0xYdFAyTm5wUzRlcERnWnlaQ3ZvOGFZTHpmaWlLNndvYjU3LzZGNUlRR2lUSE5PVU4raE54
WkxZYWMKajRFWTVCRW51RFFIVkpMNHF6UEU1bHU0V0l1UHhFdEVtcmNmVlhqa2RtNjM5dENHRmVh
SmwrcFQyNmRpT0hYMQpHWmxJY05tclYyYlpsN2ZDV2d1R0F4bkpIS0R1Y3d5dVB6Qnd4RTZVeHZx
WFJBRkRLQWE1cFBwRi9mQ25yd2tUCk1BTkNhVWR0MGVPL0NGTGMvZUNLTmRmeDJObExsZTlaR1Iz
WXJzWUlSME1NYlgwdUJ1SHFQdXprc0JNVVpNakwKNGFJVFAvZkJkUDdqaU5GSndRWjJxbjdyUWJI
R05iZmtpWTI2Nlo1VDhWMko4TERQRnpyUGZtZUR2MlNGbTZZTwpCNGpPUURqTDB0bUU5WWpvMmYx
YVk2a25laXdrTXAxc3dONFdDZFZ0bkNHWndVdXhGSG9haC9HQ3l2TGZZdVlBCnFSdkR1Lzlzd1p3
enhQNDRZZWZZSktOZ0RVQWVEVmtScXUrZElRYz0KPVZma0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000073d4c6065a047126--
