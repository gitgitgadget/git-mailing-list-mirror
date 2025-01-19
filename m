Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536F74BE1
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737284864; cv=none; b=c+rh1a3A0K0TU38sw1+OsUQvC9fbaPhh6aPkowRa2x2BxVobUgBNagtwIauePtMBgPJA5+UAHeFt398W3fzM40QGeQV9rm9Jx55AbrS98Su1wG7aeK5KloVFEc1lEF4pV2exuZSRo7Qr6b0eH5QVegbPUZMGF6H7ghzwpc8b8IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737284864; c=relaxed/simple;
	bh=tt4ccYyw5lbDQUWaQeBzj7PiYuMZ0ctIg4+T091F/Lo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcOBA1Uv+YS9kYgdxPTbxFMx/64UVxF3QenafE1JuknxP/70oOAjgV46n5YAiQDOF+VGHK5nJtBgtwutNoPibDSplJYkOIs7YrCXDU1zs1gIb5yrbPrwm48DvWwfOeTGoG1zlyI1CggywMnaYEjw4j9QqRton3HtfhXq4VdNcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlWX2zYq; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWX2zYq"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51cccafb073so1278086e0c.1
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737284861; x=1737889661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tt4ccYyw5lbDQUWaQeBzj7PiYuMZ0ctIg4+T091F/Lo=;
        b=OlWX2zYqNF2fdduQLMtcW2ps8eUvzQkI5401zzmMDPrGB1Q+AM5GWqTxsNHTPSExet
         Osq4OtgqLg+A1cWJIYhLISuR5QUzUS23nm8Znq+nfjaTfcEVcOv75wjO/m7rUywy+pmI
         g/tAbvmV36bUN+KNYJYe4NeOYDQB5Rug3uU1yiqZu3b62uGdxUy+d306e6EDDkZ9bN8M
         dgyWBbqoC3+XJlW2EjRv5vJc5BB7lVV3mMs7lTkNqpEaLNkcIvTYWQ6l6JcfFH0CjHq4
         6rOdEpNEkCz134IFM03GnJgXhM2Q3UX4sCIn2hlj6ghhro+QXZMmrGiti6B+6OBzoX+b
         3Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737284861; x=1737889661;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tt4ccYyw5lbDQUWaQeBzj7PiYuMZ0ctIg4+T091F/Lo=;
        b=oCqpIRzkm/He3a3RQsxtMdp+YC7p7ueaVQiDW12IedI5xZlXsdyx/BxKm632T7tL5s
         yHL2BOGx7oWK/+ZVqL6HkEYZGSCXp5W2m1DBzgX70gUu1nLpz77yhw3hGsaCV0hHA65F
         l42HoFbGJ1uH1m8LqzTDZvtL5eKXwUzDR4cHyHNgysoV+bpGy0Ab3o6XBiSUOGPfNVuE
         +1K/J0rozUGElhZLoePbJ7fKJYDM32iP64sHIrx1Zm9TmLCto+RKma1aeTmgi10eDQC2
         t3QKkYSR069LqnJi0LWho1b6LvTcMXDfAZKVyAkD+Npy9GKi/Ur7/vrfaC9gDYpFGL4t
         zTLg==
X-Gm-Message-State: AOJu0YzDr19R2OlEuaLOR6bwzMP9cBbfJ3nKL1Wzh31yHQgCDs61RWUX
	+/Afd5cLyWt2F5fr74suHouGe/oE/TSJWBKbv5kM/XFurYXk0UlV78cOth31hkqNUFLSdMbzgyo
	lZ8VqT/6xmMDmqCkIdAkUsBngd7M=
X-Gm-Gg: ASbGnctJU5akT7cRS4och8ApX56ux6/Pn3hmKkVaTkoxzh1splZj1Kpd7cst9sjj3Ft
	Dq0YQ7zEG4I6ULyDF6tj8Wqbe1GduOG9BgvNxqCNdqjscMHLWp3c5
X-Google-Smtp-Source: AGHT+IGCd8tZi8e6A4BGhuk2CmxgDNOkimL5LFUeJqB3hmy5FnZyGy9fNu/OsCoTJbDX/DbPBQZSNpV8Atamzv2fufg=
X-Received: by 2002:a05:6122:2403:b0:516:1582:f72e with SMTP id
 71dfb90a1353d-51d51b782c3mr7660558e0c.2.1737284861091; Sun, 19 Jan 2025
 03:07:41 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 19 Jan 2025 03:07:39 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0z9l3hg.fsf@gitster.g>
References: <20250117-kn-the-repo-cleanup-v2-0-a7fdc19688f5@gmail.com>
 <20250117-kn-the-repo-cleanup-v2-1-a7fdc19688f5@gmail.com>
 <87zfjpiefc.fsf@iotcl.com> <xmqqy0z9l3hg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Jan 2025 03:07:39 -0800
X-Gm-Features: AbW1kvY5piGsGft9T502GRWRLmk9kkHWJ9GWrtZfZA_fcxm98ORHMGJosyE03Eo
Message-ID: <CAOLa=ZTziDsW+M-oQvW1cqp=gzjc9ncmHFMR-vVvHK0aHp9ZYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] pack-write: pass hash_algo to `fixup_pack_header_footer()`
To: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, ps@pks.im
Content-Type: multipart/mixed; boundary="00000000000005004b062c0d2735"

--00000000000005004b062c0d2735
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> The `fixup_pack_header_footer()` function uses the global
>>> `the_hash_algo` variable to access the repository's hash function. To
>>> avoid global variable usage, pass the hash function from the layers
>>> above.
>>
>> I'm probably being overly pedantic here, so feel free to ignore me. But
>> you say "pass the hash function", technically that's not correct, you're
>> passing down the struct that defines several properties of the hashing
>> algorithm. This includes the hash function, but also other properties
>> like the hex size. By using "pass the hash function" in the commit
>> messages (and not only this commit message) it sounds to me like you're
>> changing the type of the object that desribes the "hash algo". But
>> again, feel free to ignore this comment.
>
> I think the phrasing in the title that uses hash_algo (instead of
> "hash function") is fine, so we can use "pass a hash_algo from the
> layers above" in the body, perhaps?

This is a good suggestion, I'll amend! Thanks both.

--00000000000005004b062c0d2735
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 610045298d3ed31_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lTTNQa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDdoQy80djBaQnJ5Z012aTE1WGgyY24yOUxtRWVZOAphUVR1UzA0WjRr
SFk4cDArY2N2L1gzakFPUmFJcFpqVDZPa0FVN3JTcnYvYzZBSjZBcmlwQjlKOE9VWFJ5NldVCmkr
TkZka0pvUENqWjRHZG5NdEhJUGYxdTV5YjdwcEtkTXF2Y0VVMThyeE9wMC9qT3JqZHkreFdkdW9P
QlNEVlEKdExaR0xabXc2Vk5pWjBsTFBEbEsyVUtJeVBSRVBKQ3Vza0w1ZnNIaGxjdVhpWFZZMVBj
K3A0NzdkbHg0dEtuaApXRDh5MlhOWlNROWNhS0x0aWF6bERmdEppdzNzcjJhT1Z3TWRYWnEzaXFh
NHRGTWRocDJiK21wVEJVaGIwVHNUCkc0a0lkMUJwOUJSUWpDeWlydDFPVE45WlF6WVZxb0ozd2w3
NkJCZFNqWUcxSS9LU1ByUEt6STBtSXdBUkRFcEMKK2lzWFAvbmlnOVRydHNaUzRGdysrQTZDWVBI
NzJCM1hJYWJpL3BiL3M5MGNuTjlwUXNRR2pVck1FTDZZVlZvYwpzRnduNEgwbytWVWVsVi9nL1E3
bkY0NjZ3MDdLWnc3TDk0WlluYUNIZm1nKytlWk9ieUp4a3A5d1BXaEZKaFBWClptT1dSQVpVaDRr
eGkyQi9INy8raHNwc3BUZTdEUzJucEZDT0Exbz0KPTFDZmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000005004b062c0d2735--
