Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1E331205
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770636102; cv=pass; b=pTdCm7fhOlF33vLQM6ZVigHYYan5/+EVH8xL+6QsZC1WtQxZ7ri+bU5Xd2HL+TRiwXQLLsYtTNZvV/K5EfLDxaVl2oHbC+gFb9uPi5dvH7xOUp5NqX/z5/LYqNnG6STs2x6+XusEtgvknVkHujDR7OOba+F3I1LjTk2auTAPzXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770636102; c=relaxed/simple;
	bh=dghYH+upG1JZTZ7YVIZoitY2OAn+HJT22JXa63zLDYM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+XSdFX317hccZJFzcIx2wNrDCFm4kUq8gyQ0ByLj+khpCj9QHCwHKLl7xZ0bH6jSsWTnsA5piyIme5Mbwo8GSbGKNF7gtKRSvJl80odBJg6l6qhWnDHtPY6xsg+HeONWmymRl0wWvNOIbYZL0mjLrW3PBoSribZTMybybCnPPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEBTSBJ9; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEBTSBJ9"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-948bff012f0so515693241.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 03:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770636100; cv=none;
        d=google.com; s=arc-20240605;
        b=A0q2622aZSvV2V1eXrAeRn9qIh3KRg6pPEkWr8J/M+g2gmjgclLV8zZT/mXarKGzWO
         uOxXb5FnGa0F8DeHHjyvpxisyvFxNxkM+CDORP+TRg4/Vhz7MOUJS4OTG2B/v/FfjFqv
         ui1TsN2SJhIdrbk0UmXDSTeKAJfgMprFHqQ+aptrVyacxyAsPSccR++vzVPEOhFCbGXR
         HcjoBiKCFqkUktUc4QEfCfPnSy6WesDy1tfTqqDF7Y5ijUr2IhpvS1A+w3VUFjn7dClD
         /HgYKF387J8OSSd9J3hR7kN4A8S6pEIXBlmZ+Sd/O2Z7PCV4guLS0MhRPYnrMS/3YbdV
         V39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ghAs5Ozwvo3bb+m93pvjetNxB2d8C4xgkUeHWAFrsEI=;
        fh=FhCDfeFbmycHGzY7HbKUSS8ZI4XWOfgXn11u3NYB6YQ=;
        b=YSm5PVe9R/ePUrlgWhLV+ig9xb1zi0CN/uTR/W0aRIKzEv6abPM5bhjysNuCO6TuKQ
         RPO4OIkcpsiPMOUS6UuwFiO+HHzICLwCnlnkbdp+b68fLLfmqlg6aQiES4yCRLQ5amhZ
         EAk3+5THKmWLyRjlJWDDpxtnZ5zeZ8kyAW/zVWhqq7GuF6H2MJZNtkHEMJAe7A0dv5l8
         cA3fv7GiiU8b6unsXpqR4sL6cHPtKdpF8CHnXTJAObVLA8cRo4dBiSzTaT/9Bxpy8gOI
         3C3KSv5qGcLCfpNizl+B01I6TJqTE5VxjrBT6l5kV/eab2xtkp1XK45s1d9HsMXPJrug
         zvfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770636100; x=1771240900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ghAs5Ozwvo3bb+m93pvjetNxB2d8C4xgkUeHWAFrsEI=;
        b=eEBTSBJ9EopRkm7I5r+IZ1Yk7XY/yOoaKLZ+N9i/siTbmryVv9xzC0d7JPGCScBOMW
         F1snxRXLOVor681sHXoK3gcsilza0eVxdCnYG4G9CGxtci5Wsoi04qHTbv/tsPY57X7L
         U77npZFFMFCyq0KuoELuJuEiZ4t10R0B+DlSLapaXrIjsYs0/NjI6e5vSQRNocah5vCJ
         ycvf4mSsG/M3vrCk1TGae3B52DHTtMKjA7tRTOqZvQuRmNleU1xvHx0fW288I65zNvpt
         YTESARQw82pnZgRq1XW/aN718EM6xzPnT5GfVuIlVZEqCWoMTHnQG7yMbuG7/bc+uyfo
         NdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770636100; x=1771240900;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghAs5Ozwvo3bb+m93pvjetNxB2d8C4xgkUeHWAFrsEI=;
        b=VL3oWsAYvIBk+F23X1o0Gk3qPDk6X/QSNgQveMbzCyQjZ2sO89021nevXWjavezMqJ
         EagFZnQ5g9O3r1XWAK4GbtB/HCm4JMlt/NU1I1yzW3TYxkasFguHbplSt+awTAEB/YOk
         QLZuHC4VuYmG3cBxDwhSpgN8hNg5L70Z/p6hZk9+yviQrsIfAKZSWVU5Z8yAf5XjikCY
         GzrmysrQ3aL2BiLltrfUrBL9DSz98aCStfVHlqU8nBZwf8As2orJVJ6L1qtQBlLpJgMC
         /65MoCcsnCHJ6KBsq30vJMVoDPNwitg735oQAtE6HKUz9Bw1WeMvHeIDPFasuM0y2Ez0
         32vg==
X-Gm-Message-State: AOJu0YxUjyy9ppHAbIQG01iDy7oboSUFcyIVTxoTxP3QRgRK8gXSLi5B
	ayJttmJ43BH3yEi0ZEqGti5gseQFKq5vbBlttxKiuN4oVRJRIZVOBwbYzG4GMMzK9x+kI678hOf
	ct9piM5bh6iHJt3Z8q8oLpAAwucdH1gs=
X-Gm-Gg: AZuq6aKt4geXxWOnCmqvpieYegNrLjHYXNak0vXk3ndM2Vq5OXzfrAJpoOnYkfTqhO+
	QE/7d5GgMQQ58gki9aaoh26Zwoa8UUT93Gwg8Mn+iCAbkpVjg8Hdc6tg+FTizJ9KI0jKeX4U5v3
	fZSnwZkI5dayEVXXtX7B2SyFBrk2oQzG3lCkZmpVimFMAXZtofbHMkvZ4aqtvcQEc8YusiCzH6d
	s9iG35h+cM2EMotdGvlXUUOi71nT9x92EzQ8D0Pbz+wlLgFVwTGUvD2wMl08p/qHs3fISizaIHO
	S5yag1UJdMVvshYPmL+WTBbNPBT8gA==
X-Received: by 2002:a05:6102:dd1:b0:5ef:6550:ea08 with SMTP id
 ada2fe7eead31-5fae8c28d86mr2535535137.36.1770636100633; Mon, 09 Feb 2026
 03:21:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 03:21:39 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 03:21:39 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYX7vfG8XQ0p6h1F@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-2-3b30430411e3@gmail.com> <aYX7vfG8XQ0p6h1F@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 03:21:39 -0800
X-Gm-Features: AZwV_QjiJwrFeMBiEuSmqRlVuA3GOXyavoVvTTHHNgm-kCHz_clzQ1yFjF4bhLo
Message-ID: <CAOLa=ZTji2h22bCUvMBB0mrGY12EGxJmJVQ02cDgTXmARpy0Lg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] refs: extract out `refs_create_refdir_stubs()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000ce2724064a625776"

--000000000000ce2724064a625776
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 02, 2026 at 01:26:31PM +0100, Karthik Nayak wrote:
>> For Git to recognize a directory as a Git directory, it requires the
>> directory to contain:
>>
>>   1. 'HEAD' file
>>   2. object/ directory
>
> s|object/|objects/|
>
>>   3. 'refs/' directory
>>
>> Here, #1 and #3 are part of the reference storage mechanism,
>> specifically the files backend. Since then, newer backends such as the
>> reftable backend have moved to using their own path ('reftable/') for
>> storing references. But to ensure git still recognizes the directory as
>
> s/git/Git/
>
>> a Git directory, we create stubs.
>>
>> There are two locations we create stubs:
>
> s/we/where &/
>
>> diff --git a/refs.c b/refs.c
>> index 627b7f8698..32b4edaf2d 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3402,3 +3402,27 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
>>  		return "unknown failure";
>>  	}
>>  }
>> +
>> +void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>> +			      const char *refs_heads_msg)
>
> It's not really a message, but much rather its content, right?
>
> Patrick

Indeed, will also patch up the typos. Thanks,

Karthik

--000000000000ce2724064a625776
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 732d232047e3890d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSncwRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2JiREFDQmd4TmpnSFZuSVNOalBQTG50bUxtN0FTdwpuOXJ4RFJROGFk
RUtOODdadCsxSlZIYWVOdkQ2SEFHRFRLM1RMdlhzV0ZGTVlSSUoxSlpicmZJM3RwbjVOVDhLCjZR
d1lCNmhvcVkrUVdCZFYzN0doNnZrdkV4OEdGM0o3RUFHa0xoOXVkc0QzS0pYdDVZT2NuYUMwRUVX
UFNKYUoKV0hjOFhTRzEwMmpWeHhhOGUrbFNibEZidEVndlhEbU5NVlp1S25vYzBlZHVwTTBWZGtY
VU43YVh6Qzl0Nk5DVgo5M2k1dGVXdGd5ZGxTOHorWVdGVGlOOHluTU5nTVQ3UWRvRHEyTzZISzEw
aFB1YkVWTTFvaGtiUWVGVHc0SWZRClNMUHB6dUtqL1haaEtpRmQ1U3FaZ3lYdERNa212U2kzVENN
YTRrNjJycTc4VCtSK2ozeDloc3FJSkZETDh3cHcKTENEM1djbmtYK25aOG1rcGlUdnd6V0pPeUJk
VXRraWQ3VWtXbE40SE9xemIraGdlVW9ia1N0RXRjN2dQbGRrTgprZWc4cmxlZEMxcS8wa200VDBT
ekdpaFY0Y2s4NVlJZHF0MUtBdHRKR3lHWHFKNTI0akcxWEZBYWE5R2lySVVzCkRoWXdwYytuVGMx
ODBwYmdQRUpuanpSTWR2NGM1dTdMYW9GK3JuST0KPUcwVzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ce2724064a625776--
