Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1967428379
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039285; cv=none; b=Rgg6hC0gcolTuc4erkqH4Zgpf7Gu1zrKo4bUNWuep60/9MWFqSoVnGWWx1rqIUOt9EnuRI/iiJPBAdiJlqSMsj+zxeV50yyprZGQ+usbJ7f1d5Roz4cVunAg444qmEKzr17d/JA2522NjxhPFoMjp3YS4TDYp1ZcKts8wC5vVNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039285; c=relaxed/simple;
	bh=GqpPHuk+s9xwTRFccy20gVpLn6hE5u0hZKrRX6wXdrg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g629YKkHHfIDmkAEj3s1ZmTG1f+9LO3JEhwB1tGK25eS/O2CmDY8SD9MqbNlTD83Zqzw0RNTFoO+nMkZdU5YCeX1Iv1sIgDF9wmpRKZTlCmol/JNXs953j97RX+fA9UYAwPQYgH0j3THSZUCeoNPVQiq4+MWVTE6ueooUpws9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGo7t+dG; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGo7t+dG"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25e1610e359so471405fac.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 13:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720039283; x=1720644083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J99kcnNu/aIovWC5VF5Or+Sm2mJZIoBvEmGhOuLu8M0=;
        b=RGo7t+dGk9rHPQKjP2BYSsZdPdOvWxybfRMTnjDCfDVr5eX34CCmkNcGfgDgb7o2N0
         OYr3VX6s4pDsmw1kuO0sDjFRGkC/7FTYUfOpQZgS+H2SD5llayA/pf8Ee8/4zypS820U
         xJHScXeurCZbbZZ2vc1rrYjHIDg3ADsuF7S5sP8MEhx+K/tlUlvpyiShb7GW45zDcyhd
         DdQMQ1H7cPS5ppCgZmCAFu40JI6gLDlIJIfa9lixuRBL2+U+NFi2VEx9PtH1016+uInx
         OGXDZoT9ygxDU2yru8j0OI39QcRm6SN7myspMomomjBJ09jmFekSQZk40WNJ7Yb5wyO6
         O6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720039283; x=1720644083;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J99kcnNu/aIovWC5VF5Or+Sm2mJZIoBvEmGhOuLu8M0=;
        b=Aaea3M6ShqndCwaCNOxaGvYaT2i2ZtmdA0pp/YtSe3SzeR4sib9Am3hMr2T1pSfGCF
         PH6yYXwyGw+Lsf96P/8qwCDu190oaAAWkSA1pOfsrGRVu26KkVMFGvNnqsDiC9nlznEO
         fihGSZVZIZffA6BLkjSrqdic/WOLn5QOvdAJgevYeEoPzbT/EHeWmh4hq8vZRh7tEsQf
         ApjUySnFRcgwlHYu2i7Vx5+h4wkN0T5KhDt2H7O4ASMWp8g4IYQKsnnhYeHRUQMokk0H
         Hie4wmoHiJjEPhgplJqFh1X3rPXC0xc1Nh2BCaI2euHqvIw8YmG1DW7Sh90U+qxsUsHs
         ha5g==
X-Forwarded-Encrypted: i=1; AJvYcCXo4blm7tbXS7PuPADo5ugBy1jTOjZ73kT4du6yTfDY1KspTF3r1QdASfKWuop3vaX73cK6FfsvKYMGwVEOveeUHoyk
X-Gm-Message-State: AOJu0YxazzZM0KgHdCWfeHA9XxOGCI5hku7DxdO7mD89K5qQg3tP4L/g
	vhDY0JTYaIOgeU906lioEVAVfP2KgqmSBEs4xNuWaYGckVCA9znC/I/0vYu9NAMwd9zvCRaI9Bw
	12jkXNBBnn/v0zGBGSnkOl5YCk78=
X-Google-Smtp-Source: AGHT+IFKP+IRX2E1pk0d++MC7SBiDEqoKr1Yxh0AggCFcIuvOXaMWQ3CjlojER6HPFa/E8YPBC+scNC3JSilRrutncs=
X-Received: by 2002:a05:6870:b4a0:b0:250:7b2f:f273 with SMTP id
 586e51a60fabf-25db36d60b2mr11771371fac.53.1720039282934; Wed, 03 Jul 2024
 13:41:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jul 2024 20:41:21 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq1q4acpcv.fsf@gitster.g>
References: <xmqqpls3zhc2.fsf@gitster.g> <20240626190801.68472-1-abhijeet.nkt@gmail.com>
 <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com> <xmqqfrsyv155.fsf@gitster.g>
 <CAOLa=ZS359bMtUd+ktvJgHsiG-0=VVdGWYA2mKCNjc_1BrzcvQ@mail.gmail.com>
 <xmqqle2lvsmz.fsf@gitster.g> <CAOLa=ZR-g4G0FaxnQjjkOST-zeRxBXXK1gpJ=P3xdbi_9eN_rg@mail.gmail.com>
 <xmqq1q4acpcv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jul 2024 20:41:21 +0000
Message-ID: <CAOLa=ZRm_-9aewE-7JXa2LOBoddoBTJgcTTcJ7FoUvrLRR=_JQ@mail.gmail.com>
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>, git@vger.kernel.org, 
	Paul Millar <paul.millar@desy.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="00000000000075af23061c5dda11"

--00000000000075af23061c5dda11
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> This explains for why 'broken' must use a subprocess, but there is
>>>> nothing stopping 'dirty' from also using a subprocess, right? It
>>>> currently uses an in-process index refresh but it _could_ be a
>>>> subprocess too.
>>>
>>> Correct, except that it does not make sense to do any and all things
>>> that you _could_ do.  So...
>>
>> Well, In this context, I think there is some merit though. There are two
>> blocks of code `--broken` and `--dirty` one after the other which both
>> need to refresh the index. With this patch, 'broken' will use a child
>> process to do so while 'dirty' will use `refresh_index(...)`. To someone
>> reading the code it would seem a bit confusing.
>
> Yes, that much I very much agree.
>
>> I agree there is no
>> merit in using a child process in 'dirty' by itself.
>
> Yes, that made me puzzled why you brought it up, as it was way too
> oblique suggestion to ...
>

Yeah, I should've been more verbose there.

>> But I also think we
>> should leave a comment there for readers to understand the distinction.
>
> ... improve the "documentation" to help future developers who wonder
> why the code are in the shape as it is.
>
> In this particular case, I think it is borderline if the issue
> warrants in-code comment or if it is a bit too much.  Describing the
> same thing in the log message would probably be a valid alternative,
> as "git blame" can lead those readers to the commit that introduced
> the distinction (in other words, this one).
>

I think it is always best to err on the side of more documentation than
less in such situations.

> Thanks.
>
> diff --git i/builtin/describe.c w/builtin/describe.c
> index e936d2c19f..bc2ad60b35 100644
> --- i/builtin/describe.c
> +++ w/builtin/describe.c
> @@ -648,6 +648,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>
>  	if (argc == 0) {
>  		if (broken) {
> +			/*
> +			 * Avoid doing these "update-index --refresh"
> +			 * and "diff-index" operations in-process
> +			 * (like how the code path for "--dirty"
> +			 * without "--broken" does so below), as we
> +			 * are told to prepare for a broken repository
> +			 * where running these may lead to die().
> +			 */
>  			struct child_process cp = CHILD_PROCESS_INIT;
>
>  			strvec_pushv(&cp.args, update_index_args);

This looks perfect, thanks!

--00000000000075af23061c5dda11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c862fb1b702ed3bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hRnQyOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVVRQy93S1VvSW9FRFJOQ04ySmtlWDU0MHpTdzJyaQp2M0s5QVlEWjJN
cHVRYVpHTXJDVGl6djhLR04xcFh0eGdmVkRneGJ4M1IrQ2Qvb0VHcDI1S3BkVmJ5UFk4cFdtCkJz
NFl1QzU4cm5KVTRRWkI0NCtYYkdCSEsvN0Y1ZUxmcHZGendCUzNHMlNoSmlNT1JOVDdYY2Z0TU1V
VDNkT0sKRVdsWS9hVGtQMTYwWkl5ZE5ObGhpSk84V2daNW9CZnJGWlVvRFZUaEo4VUMxYUlqcXJZ
MHBwR3Q1MjNKbEplaApPVmRQaVM4N1BBaVNBOUt5d3M0NGRtMWdIR1pJUEhybThuUmZrdVZ0OEdr
UnhPMnF5eCtQUThjbVVBckg5aEc4CklKeld0bzZEenpnV2wyMUwzdnJJdnRra1lrUW56dG41R2dr
SU8wNlFwQXpkNGpDbzNrSWtYZURUNVVNWWVvV2sKWWVkb1AwTkkrYTJ4N1A5ekNNSzBJLzBKQ3Yw
MXJRL3M2S1crNHlESVVQNE9QM1dyczcyYTB6WEpUWHh3WnlVNApsYjFXZ0hhZ1p4b1Y4TTM3SGpU
YzBTSk9ESmtTakFhQTFjUjJjcHA1R3FTVWxJK1doclZRL1RORUFsdmFBekFFCnRTTFhnMCtwakJt
S0RRNWVQV3lZNlZZa0s1cUtuUjU2bXdJSlBudz0KPTNnTEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000075af23061c5dda11--
