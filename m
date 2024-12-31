Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED130187849
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 06:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735628156; cv=none; b=D2Fx0Wa0HUCdKCLEMA8g7qcePcA4PPqJ8IksHMKxQ83ap1AbNX88q4kFURp+7pGcJP386PpD2ogOzTZxi4R/4Opcm+4B/1cd2FIspqIkesLpWJhDYI11mcEgESvJRpDrrq0XhkxULOdJRKBO5WJMEb2l+7xolMYDwXewLyIwfGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735628156; c=relaxed/simple;
	bh=y3Qsw/eOPe9Ge+L6zjE6wVqm0aHUBYlbjcwjGR6q6uk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E818zRpHfYAJNlYcBylgzPMvrItrE0ZRSNFgOSmkJyhrYfSjFtG9XSouByk/8zrH1HU2LDav7Z4x6/hmtMkBeNr+SRx/ZZYXw3RGlziwntHiQzk2aEZz5ov/qRwugKyIO4j0FbyqsearMHeNmXalX+TEPW2UnpP3nnRDMZSS0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvJK3n41; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvJK3n41"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51878cf85a7so2834195e0c.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 22:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735628154; x=1736232954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNKfucPa7FrYx3jb+YZ6zF2NUx8deJ6OuSaKlvW7mo=;
        b=QvJK3n41SWgMjn2+Q/l2sj9JiBuI/btkpdU+DlGt7kRtPpAnNbJpPsJ9Ak5WV0+mN4
         TVbH/vIVTXunq2WADxoMKWT7hOJnrmLfnPVxkIaj7X8nxS4ErDqQye7nBCvgHK+2em8L
         R0QhqfE9K3kevyyzPa4TB1ir2EEg0vtT7Nb25XV/MU2dmMPq5VJMqBM5wXwDMHnBAb7x
         IdzBlFOd9QM/0wDlJ0uWphaQc6aI0RKY4RR/poXzquo2wXjYeG4juUTG+8y6Ub4yB1H2
         ERCXASc2qhOGal2Wny389bDXjd1rvxBhsXXl1NWwvPlrp53Y4uzmT3qQuHeSZ6VKQc5p
         ugWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735628154; x=1736232954;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJNKfucPa7FrYx3jb+YZ6zF2NUx8deJ6OuSaKlvW7mo=;
        b=CINxHGCb2FKXvlfS28BfvpfOTWSKaGEL30Fa70pA2wo7L5gm86nM+O0DrmzEohuq3o
         6OlCXIW06rc5eCZpkLEGaVl3uVeB6wPxXv4ZN3+DpofGo1iJiXgjpm+h8r+zvkdRBgwS
         CeeKXvD6dIzY6oZLJ+oOh2ryjU4TnXoszIeQoSZ3OKecEBXl0V2h4AwHxHM6YGVc6nMF
         wKlLJLhnic4oBmMrSkGjAA4K5YEAOeeV67nk0qwr31nBdlD9mJ8ZcbFXHExzYsUkaHqz
         LTI7Wqxrt66wnn9QJ1aMPiaXIT5Tu4FTMEEC2dXQqPjyPRMfxVlBK+Zq9se5Nxd2bF/C
         KAWA==
X-Gm-Message-State: AOJu0YzhLRwwJXgzmyGXdVs/unPQtmDXb7Q8smgfiOJefMpC4H55gO01
	GRZh5qW9HkeAACnvfhSwZgknc0CnxQZ6oMnGfeVH23Pflsqd0gHiY149zO/MU948b2rjAcZz7eH
	QnsL06LYeYRoRqOsbrStYN4Qe6Bk=
X-Gm-Gg: ASbGnctFpGDJRHyxAdWRswNScLNXLtDdSDwmlaRpg2iXdIWIF9SXgGDt1DFdFvM8LUU
	iaEuRZb9SV42jwZJ9aVDXIWLmdtd8wN24Tv24HB4=
X-Google-Smtp-Source: AGHT+IEuv/pt74RunGhtbLgPhLLKOV13j0hW3PJ9FdmApC2oaAVPfXfK94P8DGmdNMcIguTNyMn8l8w/1ZInI0qo4hA=
X-Received: by 2002:a05:6122:3708:b0:516:230b:eec with SMTP id
 71dfb90a1353d-51b75c6ab54mr29470638e0c.5.1735628153772; Mon, 30 Dec 2024
 22:55:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 31 Dec 2024 01:55:53 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z2Fr90U9ujGFv2IT@ArchLinux>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <20241217-pks-use-the-repository-conversion-v1-2-0dba48bcc239@pks.im> <Z2Fr90U9ujGFv2IT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Dec 2024 01:55:53 -0500
Message-ID: <CAOLa=ZTh2Nwwo7VKcXGC0zVivmPjxXr7R-cYC_A2JoeVvRsb1A@mail.gmail.com>
Subject: Re: [PATCH 02/14] pager: stop using `the_repository`
To: shejialuo <shejialuo@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000917e63062a8b6b45"

--000000000000917e63062a8b6b45
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Dec 17, 2024 at 07:43:49AM +0100, Patrick Steinhardt wrote:
>> Stop using `the_repository` in the "pager" subsystem by passing in a
>> repository when setting up the pager and when configuring it.
>>
>> Adjust callers accordingly by using `the_repository`. While there may be
>> some callers that have a repository available in their context, this
>> trivial conversion allows for easier verification and bubbles up the use
>> of `the_repository` by one level.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  add-patch.c     |  2 +-
>>  builtin/am.c    |  4 ++--
>>  builtin/blame.c |  2 +-
>>  builtin/grep.c  |  4 ++--
>>  builtin/help.c  |  4 ++--
>>  builtin/log.c   |  4 ++--
>>  builtin/var.c   |  2 +-
>>  diff.c          |  4 ++--
>>  git.c           |  8 ++++----
>>  pager.c         | 14 ++++++--------
>>  pager.h         |  7 ++++---
>>  11 files changed, 27 insertions(+), 28 deletions(-)
>>
>> diff --git a/builtin/help.c b/builtin/help.c
>> index 05136279cf7b1007ab754f5630c34536a5f9461f..c257079cebc3c09fb91f258c3b0148e2f204c0e7 100644
>> --- a/builtin/help.c
>> +++ b/builtin/help.c
>> @@ -658,7 +658,7 @@ int cmd_help(int argc,
>>  	case HELP_ACTION_ALL:
>>  		opt_mode_usage(argc, "--all", help_format);
>>  		if (verbose) {
>> -			setup_pager();
>> +			setup_pager(the_repository);
>
> It's possible we run "git help" outside of the repository. Here we still
> pass "the_repository" to the "setup_pager", it may be a little strange.
> But later we will use the "repo" parameter instead of the global
> variable "the_repository", so this is OK.
>

Well, the crux here is that the pager only requires the repository for
calling `read_early_config()` in `config.c`. And that function is used
to read if there is pager config, since git allows you to setup the
pager via config. It also checks if the repo variable is set, so this
would work as expected outside of a git repository.

>>  			list_all_cmds_help(show_external_commands,
>>  					   show_aliases);
>>  			return 0;

--000000000000917e63062a8b6b45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 29aecfe803e9081b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kemxXZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjFHQy8wUnQxT3FEczN1TkI3T1NCNWhLbFRkRk1ndQpWQW1aaXMrVk4x
VlJJbTdOV1RVczNpZWZXck9PVFc4amptTG1MZHptclZidXgzMUkxQWtQMnBXeldaWTlVVmxhCjlY
bmRyWXdkNkJJWFV1Tmd1M3BUbWZhTi9HT3F1TWU1dVJJRTFxaDdRUy9KUjlzZGY4eC9aL1NaVFBr
SkdaY3MKcVBUbm9qei9Cb0FQeFMvYXN3TE40aWcwS2N5YWNjYXBPTmhpb1VIN1JRT3hWcm9KVUR1
TjZxcDRWdUdLMXhUYgoxd1RCTGZydWZnSnk1OEQzU0dsV3c2d0xoZXBtNFFERFF4U0ErelNvOUo5
SkE1R25mK3Q4TGFwMzcrNlRsRkpFCnRabmxuSGNTdU8rZ052Uys1VEtyaXBDM2xJZkEyMjFCa0lI
ZHExcVBtcFhyRmxvUThaMUJ4QjBnV3lWOGhGbXUKV1BEZFA4Rk1ab09mZDRmRjh2UysxV3FyY1Jh
bkRSOW14QmhOZGd4Z1hIem9idFVSTDBZcEtJdms4RjFlRUI4QgpPQkFhT3hLTjNhUEhHOHR0NXNB
ekp1blVjOWpwMEViRkd4YkM4UGR6M3BVdGYvcmxCRUZPZDlmSHhFQzd6SzNtCm5DOW9SWW1DNGYz
Y0RjZ2ZnTThSRSt5dmh3MURlZ2Izb3JXd0FYZz0KPXYxWnEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000917e63062a8b6b45--
