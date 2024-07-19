Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753839ACC
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378039; cv=none; b=eslfki4kLlNj++MvK1j2d5zeNYPeR24ypGn6na075nMQsBOfQL2YgUUign9juQveCoYR36RnOSFD7++wnel3Xthe3qNUf+8Jl1GM/G9DRt1BMW+VCQq7r4yy4YDaj9BpgBeHR22jsISJ7CQyYYawvKioEWblWRnhonP+8NrDRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378039; c=relaxed/simple;
	bh=dKqY6+E92Yc/TadQI8nTX4uW2zMfdcIAO5y1Yl0SsXM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouDfUGkrgQ7kGklE+HTun1EJGMd/CoX0vU423eztV+hr/8XIp+uvelurB270Oxs8PSvbPrif+fF0NrllSWLbcvFfSL46I6uWYQtrf9RsZrlXSB6jOnNXyIDX/9ko0aNb3eGnyZlHwqlt+vPljoMJx9GHJ+/9590aLlYojwZmT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNSXevZU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNSXevZU"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-260e99b6661so730878fac.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 01:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378037; x=1721982837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxQo8NsJ0jIBFTb4BQBjcnfoUE2jfWYloEALKvJnAlA=;
        b=hNSXevZUH4RW5Ydjh0gF0KaFv3Cgo+bi729jZv8TerIhWeRZ2Pn7QgpXXq+P9oWJRl
         ftlumkaGNHsfNr5fAuN9wSQQO98BxVIlWC1glLtB1AuM62hG48NdviJWrEIVQp/5k99z
         tJVqmXQioCpYu2IyA5Q5YQflrbHqLn7UqSfdjNYLRzAQ95kTRdQ03YqtkFMDNpDnwcJR
         +KJHGb7IF6M/haKrn5ccHYgobscVw+6zorcZWXQD6WDZcOx9SCE/0pXQj8RUIuIlXPNb
         8mPqvUH303BURZTZ0LHJ++pzeKPeYfLjUL0eYKPUaEO1f6sL8UDKks23RYfDQV9rqQCn
         uCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378037; x=1721982837;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxQo8NsJ0jIBFTb4BQBjcnfoUE2jfWYloEALKvJnAlA=;
        b=SYdDx7XOFmMrLctBqQmHw1L/KE7WObUPMeG1gVlsePStoB8JdAMyS24d++AwlgRV0t
         yhKfMIe8VVvAIffWzSy0WA6topw6VCqr4CbPoCKDje/RiYg1flQCjosWH5CRNgW36TC6
         ndocKxvSbxtbcNi6tSzq7dOEgr742theVRvTvgwtJJYTz9oXqeF5T0nzBRLn2usLBcTs
         Zhop7pfBRJcIZYJf/HC0GqfVpGSVaNH3mxDO0hROYIAGRVG0QcjPNTgiduoKb9N4DEbU
         /sjPOQhKDYSF8TnxKleO0QMcD9fQtriQYVDgRGoHfT9iPpkt84LOA6PrQFw7zGZjAhxR
         Pw0A==
X-Forwarded-Encrypted: i=1; AJvYcCWwTDGzYXx+grRtchJjLr+0LfvkTePIDovbaxTBZsQ/8t9pVteZiFgUkL03sCZkF4PVyCMHAw9ICLf4EKDvhsqQYbZ1
X-Gm-Message-State: AOJu0YwN6V6WoxbmUDLEyekxFwqf6u+J3lXlJsdqtI321lTJlArfJz9o
	S4Uc33KrCvE3OjgsOcMf6l9YYtRDa3dpUShqeI7DUlXFCXUomI/tF0HofAwSvPRoeWrXqtDkpoN
	KreT2W9m8oV6n6/Z1fNghOOErYQE=
X-Google-Smtp-Source: AGHT+IG5K+Tnifxcc7cdchI6qO85BgDotEaCTt6/JXQLN2VAwDJCYMuO5cIp/vqSM7aJUBDnYbK0wYjYfSN2wRx0QOA=
X-Received: by 2002:a05:6870:c6a1:b0:255:43c:dd22 with SMTP id
 586e51a60fabf-260ef89854amr2278655fac.21.1721378037325; Fri, 19 Jul 2024
 01:33:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jul 2024 01:33:56 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqsew6wuu9.fsf@gitster.g>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux> <ZpPFbYOqDVWKz0ic@ArchLinux>
 <CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com> <xmqqsew6wuu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jul 2024 01:33:56 -0700
Message-ID: <CAOLa=ZSx70nT1RoLxwipz5tO=Kkw25QWn_wL4TJRprNSi0cvvg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v11 10/10] fsck: add ref content check for files backend
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000707e14061d958e9d"

--000000000000707e14061d958e9d
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> shejialuo <shejialuo@gmail.com> writes:
>> ... 260+ lines of the original removed ...
>>> +		 */
>>
>> What happens if a symbolic reference has trailing garbage ?
>>
>> ... 160+ lines of the original removed ...
>
> It is a pain to have to look for only a single line with a new piece
> of information in a 400+ line response, more than 99% of which are
> quoted original.  Can you trim your quote a bit better?
>
> Thanks.

I usually do, I missed out here! Sorry about that.

--000000000000707e14061d958e9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5bf28d8c8b6d116a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hYUpQTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnlWQy8wY0Vjb0lSWFhDNityOUVoM0JoMXpCempIQQp4MmNEMHF6M0cr
dE1TU2ZGNjFvRS9kb1NJamZyV09tQkZTZUJyRXp0TWpLYzROaGNzbEkwQ1NPSGRTY0V5YXpzCnJH
Sk5uMlhsNkZnRnBudGFWdGRlY3FOQWpCbDY0Z1hLcGgyQ0NZRWZKYTN0OXZrSkZ5WU1ybFhzNzQr
Uzc0RUIKWUt3MnA3K3NpcU16cTR6UlFXYVJVMEMybU5UTmZYMWVBeWd3TEx5WTJSeERlWHlwRVgv
bHlFWlBuVk5MWEN3TgpQUGVFZDB5Q0R0S0ljT29aZDdLTWp5NFd6ckYvbVA4SGhmTklSRWNHM1ZW
V2JacGJoMHFMbHp2d3oyWXg0Um1rCmg1M3Y1bG1ZQzZlaG1VeUVKRmsyeDJjaVpXblMrVzB0UUZZ
MGVDQ0w4WVBnZ1M4elNKT3hZYkdsY0Z6emlDb1MKbWIwcGR2NHFzMTgzeE1GZGhPMXViRXNvb3Z4
QkVMeVFDTjRjMkJ5R3dPUTB0d3BvbzFHcGM1TGdNeGpYQm5BcApnSnRicHRBMFZhQTRYMlFqRWVt
eEJZaUNTWlVPdlAzemZZNUpiSFk4dnhXMEhoY0xNaDN0RTU5cDZjdkRRKzJPCitrcXdUek9QU1VD
eEFQV2cyN0pmUXdNV1g5bmdiN0xqeVEzcUk5QT0KPXNRVjgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000707e14061d958e9d--
