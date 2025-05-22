Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0B22259B
	for <git@vger.kernel.org>; Thu, 22 May 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904272; cv=none; b=flRQMWuQ6XZDaa/NLp9OQLrV2lnALQ9iyogsLGVsY9d36wr5hwn366fJ3SXeaHOo44Lmp6pVd+eZe4ZGF+6NoQjooMq8H2tzZeQR4QIPJxpsb5u30JIwVT0wIAqhMaN7bE7PsYXb8n06FlDpWEmSnzyAsHoeY+WdJsw72guvHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904272; c=relaxed/simple;
	bh=869mmJD5gQzY0j95EtpuBkd2avsYd+7+I0Oj9yv8x+k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDkgX9fhvJH3imtLIqudHN3X4UCSnwpBeBtSht6kNcNCsxTA1w8rCyiaCCaIPRlf0qR0Y7zWopBoL8KFokaL8FDgcc7Q+MnPB05IWVW2M2lFyrlKy/K66WlZNs2ew6ksPVNlrppJjuHUf9sdq09wt2+sWGqj78a8uAqtVStaQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYIbQpVL; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYIbQpVL"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4c6cf5e4cd5so5260018137.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747904270; x=1748509070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A82LqCPKyfKdVnraRlx8ok/jnSbhKz9rQJc6DFLgRH0=;
        b=TYIbQpVL9zXleUzEs1iB8X/wsqN4PVjKHZkwJ8ThMw8gFceU2wxZznYk9p1rzF4PM4
         DzeR/dwq+NxY2blOYmt6PnHVPnsK7KMtrdyaW93ggE5NscZ3x/rMA3ZvvQrycmqLObwb
         3ixfwzpCLTMrUt1936Qt9EqkqWbx/nHBnDai18hrKwCMc38TFkuEB/XI5IklfT7LvonP
         lHYCBiDiu/WPDX6GjI2PStSOTqQxhHHwfNcgIn22vmcq0IOzEEKD+DGIDiaVtIS19EnE
         grcYbvab1oUSNcOEwhm0zKcKzrFDPjLWX2liUdQMGAWT5SDNJ8ByvYFfvDF/khC8k9Ex
         /5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904270; x=1748509070;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A82LqCPKyfKdVnraRlx8ok/jnSbhKz9rQJc6DFLgRH0=;
        b=ETXfTG3RWkHAUdv9rbZ5FmWSEFT23YGaCJMHdk+m8+z4SE3QmAHI75jYwEuCgpl5/+
         p7DRpTxjcZ011bFbj/SfvtyF6RCAVTL+sNd9TRMxcW4kkTF2+0cd6+eB89uuXKodtqfL
         t3mAMfn/jaqjdk75b+6rxalHvu//JUX30FQfQJfAVQFmg8UEqqbYaSqxgPUmxng/sR/M
         1MT2TeolGe4QjYDRjsyCey/NRPWcpKjBu0eReRliydQnQ4R/uxkT6otW3P4SpsMwvblw
         FcAIpFofXJqCI2QZUvEaDhoE53ChHxHt8Q4gw8bbP6phZvDU29GMw/sMXS4A8EtrALaz
         T3Qg==
X-Gm-Message-State: AOJu0Yw8wtIiJga2+O1Xob/IBkrhxL37F6n2A5GcqHgP6FeaLCRfcRZH
	jQN0Xslj4wdySiLTIBjmCBA31yql4fvIlSOZ0ofge6pRmeMsQXu18N344Zu8bgf9fIJ1Vs4en7h
	QUrMrn1h2NBAKDxWG1KI4P8VjkElk//0=
X-Gm-Gg: ASbGncuDHLbedzo+AgfDbm2WvIcSXKKBL0eIK5fdkJ/A1PaTGvCzCb4kCV3bbjC5ugr
	gfdOqnf+B6Lkiy5nI2bR8lHdDgt2oTE+yirxRRec1Np1J9NKHJ1N7jGlS5OX+4ZgVYWgPVYJeXj
	gE58hvLBVa9p3OaXb8DUrS4HTCoUFjkaHiIxY3EspECc5cOuAFCCzfkKX3c+MlhRWlTA0=
X-Google-Smtp-Source: AGHT+IFVdfSjMmI4LqMkBe4lXSGO3nv8TTac6+Q/bCduWua/LaLKtDUlbCj50cMW4/PUnoUdiNFHmG6x+VTQzNJgsyo=
X-Received: by 2002:a05:6102:91a:b0:4bb:de88:d027 with SMTP id
 ada2fe7eead31-4dfa6b7d4d6mr21233611137.7.1747904269937; Thu, 22 May 2025
 01:57:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 01:57:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 01:57:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtt5ec8t2.fsf@gitster.g>
References: <xmqqy0uqg4w6.fsf@gitster.g> <CAOLa=ZR-OaLPueyRcXYrN0rKPnVXPPmJ6drsmM4eRs-6yKEgQQ@mail.gmail.com>
 <xmqqtt5ec8t2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 May 2025 01:57:49 -0700
X-Gm-Features: AX0GCFu0fyN0CdfQ6VnsEipgrrYQbNjV88PdE-Wxgj9pl4E70pknjrRGZOnswig
Message-ID: <CAOLa=ZQvow9wkxKPFtfLHFxXvBvnZ-U6+qgfVxWoLfuH190Qjg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #06; Tue, 20)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001c96830635b5ade8"

--0000000000001c96830635b5ade8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>>  Will merge to 'next'?
>>>  source: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
>>
>> Incase you missed the cover letter: I would say that while this can be
>> merged to 'next', we should delay the merge to 'master' for after the
>> 2.50 release since it can be disruptive. Mostly letting it bake for a
>> longer time before hitting a major release.
>
> What are the things you are so unsure about and guinea pigs who use
> 'next' as their daily driver should watch out for?

The patch series changes two critical sections of the code base and
could contain bugs which would disrupt regular workflows. There's no
particular part I'm unsure about. But being cautious since the release
cycle is coming to the end. So this won't bake in master for long before
it gets released.

That said, the series primarily touches The pull and push flow, so any
edge cases is something to look out for. Specifically around the usage
of hooks with reference updates ('update' and 'reference-transaction').

Thanks

--0000000000001c96830635b5ade8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2982d4c2a4c0ce88_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ndTV3b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWljQy9pL0htWktOUlptL2QxVmoyMHlWY1cvR0JYSgowVDc0Nk1aaHJN
YTdaRUprV0ZWVjdCbktFMkFRc3FhTzBScENlZlBITUpqUHhIMWFtUGpWNGtFL2VlUUlZZ3k5CnZK
bUh6Qm1CbHBRSzNqUkZuZnpDTkFzRFV3dFZRWjNVS1pzclQwRFNoMnA0WkRJOHRYc2tDazhZVW5n
YVU3dG0KUWZOd3MrL1Iwa3FFSFMxeXdlMmIzNmpMUmZwQjNPck11RmhaZHZsVWZ6TCsxckxJUEZC
OVFPQjR6YmdxZlpPdQpjbkRDV2dHQXQvMnRxWFpHZEloeEM1UFJMeTl2YnBTMEVrMHBmTzFCWHdo
ZGMxVnVwcC9acjNZMnFqZ1ZRODV3CjhlRmNaU2hnNWw4U3ZwYU51d2xoTDJRamtRRDNpdTNIWEJv
MG1QOXdobHZ0TGdBYmJGbG5CUFByZ1VGdWE4cEkKd3VpWnEyeTd2dUh6WWVOT0xqTGtwYSsrdTd0
WkFIT2YzcFVGb3NqeStPL3ZXL2xkTzVkQko1QS8rVzY4eFZrcwpVQjRoRkJQVUdMa0FZN2pUOHFm
elU4M1dhTXdnVTlmWVRYQWVFMDZmaUQzOWJ0OTVYN0JrT2EwRTJ3UU9ycHFmCjhKNmFiT3pWeUF6
VUtPY0JHaWRFQm05M0plZkh6N1JJWGdZVG1nPT0KPTIydEYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001c96830635b5ade8--
