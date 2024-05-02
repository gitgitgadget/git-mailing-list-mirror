Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041D5FBB7
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647941; cv=none; b=oog9qxqnuVYfpwAEo7H1O58GIJlEummcNFDRY0eMM8jVu3/dAPm4lTQX//G15fOuKffp0UB+8OFb2hqDhQaiRh0DsIPv/Mc18r2jUgyKyVlbcLY4BBamXC/e/kwXUonvVhYzDHEio8KCF/NPIrNHdROBzDrWg4hUeGPHYq1afY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647941; c=relaxed/simple;
	bh=H9ZdBwLFkGBqFjUABbwb8R+w5SadIcVW3s7rbwnggGY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl4a5uBkEHaFj9XLNRjZYaBDLhJ76ALR1c3Vq423B5t+nP457JOvnzLXbeImSnmEZC9P0DHRFWxsEQhIxuVFi4bZpKM/S+/sE9YoJDpd1dLNuNJyiRI245d6VZlNoGlIPldpUx9XSnsCxcQQ2y1J88n7LM3UIYbe3URmYnfok/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/T4Ene0; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/T4Ene0"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d175cea45so1359961fac.1
        for <git@vger.kernel.org>; Thu, 02 May 2024 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714647939; x=1715252739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNbveJKNHKkujIYG8XXYq2N72H9xYMC/IRmPHfYuR1Q=;
        b=Y/T4Ene0YCyL0IOB7TMGZ6gYX3g1H09L7wJQBVY8Sf57s1JHVdRyUV1yoDt5KSi+KA
         r9VDRtvAguUKdOBY/SLfnIAwwPoELj9RMKmBfP/UlTXzmibv5a7Xoo7YzS9qucJpgPMj
         tfhZRIFZCa1AgWzyanR/mbwgVIHkfbQEw4f/4m6Zah1BnckwgEMyKTjVwead0EI+E53o
         BImbgGcBEwSr56Ln3jN4cfrDKGvCmKUEExnWFoX/rJSH3hZejE3aTnux8+V68ilvR0TI
         D/6Zv33ZVgMK6upduASS3RlSEWkSsnYbhqI35qWXPcA3zkFWhowG9r+lmSw+aj39SSYq
         m40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714647939; x=1715252739;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XNbveJKNHKkujIYG8XXYq2N72H9xYMC/IRmPHfYuR1Q=;
        b=OvlbsygFAKZGEgbpBNUtG3TRMIjv/5AU3THIQljQmjNaGb+6Bc9b4nyOxXBolrtVqe
         jc/y2NsYU5zTTtcTCsBYzcnCVUFIEBTRVY6OriB+Fa65miFmstOTru7ficVEl5ec+5xm
         nooRx8uSGx5gC2ItmKvNPedjNghAsmVHUPISJarXLVaY8bf2z59F2NBXqVOF8+oZuizU
         zU0dUJ4AHowkff1Ga5DgZ9NZLDlnAVsDXUTN72wsoRndKgdQVa4VsebjDgIaV3uGI01T
         GB90XrxXvPzlLBVPqR7Mwq8JgXtzOkzh1LIzBcS8Jev4LFPRmjshGbQKGkmqw9rXRYZQ
         MiSw==
X-Forwarded-Encrypted: i=1; AJvYcCXXhlOniohdySBj1Y2gIC1HSuRc2VEUu3aSWvXI2oxyx0/SJWHsO2xNA8EY9KouzFsMTHI/ef06FvdaHRCbwN0Ei2A+
X-Gm-Message-State: AOJu0YzuWzDYxhZpmBcmO/sYT6+XtzhGJ99TwgWnUN1xQZg+no4WaSXM
	eKuOIJEZEnYMKadgKEIMUzbVxB1Gs/Z5RJyaj0v0YcyY/4O+hV4UR66TqSlJDHaG9iyjKZwjFOl
	EU+hW2sOdkS+1pWgYdY7mdwC5B18=
X-Google-Smtp-Source: AGHT+IHIywigX6ItUWTRqKFv0CEQWm5dIb3sA9ivau9qRnJVzYOAsOT5dy4WPNeg0ZGvVoi1yypteMO6l2C+fEnFt/o=
X-Received: by 2002:a05:6870:5694:b0:23d:49de:970e with SMTP id
 p20-20020a056870569400b0023d49de970emr5775060oao.53.1714647938688; Thu, 02
 May 2024 04:05:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 May 2024 04:05:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZjNFBZOlcQNVYm8O@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com> <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-3-knayak@gitlab.com> <xmqq7cgdjig4.fsf@gitster.g> <ZjNFBZOlcQNVYm8O@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 May 2024 04:05:37 -0700
Message-ID: <CAOLa=ZS7Co01QegZcJ6uqRoTfQ6d7dXNMy6ZyajsonC2TOV1EQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] files-backend: extract out `create_symref_lock()`
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004d065a0617769596"

--0000000000004d065a0617769596
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 01, 2024 at 03:06:19PM -0700, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > +	if (!fdopen_lock_file(&lock->lk, "w"))
>> > +		return error("unable to fdopen %s: %s",
>> > +			     get_lock_file_path(&lock->lk), strerror(errno));
>> > +
>> > +	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
>> > +		return error("unable to fprintf %s: %s",
>> > +			     get_lock_file_path(&lock->lk), strerror(errno));
>>
>> error() is end-user facing, so "fprintf" is probably a bit too
>> precise?  "fprintf" -> "write to"
>>
>> Also we may want to make them (not just this new message but other
>> error() messages in related code paths) localizable but that is
>> probably beyond the scope of this topic.
>
> It only occurred to me now, but shouldn't we also support passing in a
> `struct strbuf *err` here? The transactional code doesn't want us to
> print error messages to `stderr`, but always supplies a buffer.
>
> Patrick

Yes I think that would fit better with the existing transaction code.

--0000000000004d065a0617769596
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 481a647a3217c27d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZemM0QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL3pSQy80eE9jTG52c0VUK3daT2ZLTTg2MnVmMURKSwpXWmZNM2M1RlZY
bnZUbklHSncxZmZVVGttUkhGdU54enBOYlZCMmNoYWZubWloazhRLzZkU0YvdVJObXdRK3pMCnZm
NnNhdlRPWXFtNGVTT29CTTZ4MkJXeXJKNGk2KzgyclFlKzFMSUpRcVUrYjFHY29WYlFqNWtRTWxv
TDBsL20KR2I2WG54b0x5MHg4dTd1ekYzRCsvNDZXTUxkKzIydHpza3RvdDI1TWFBM3F1K25qZURh
QVN2ZWpweXNVYUk1Zgp6VXBwSDJUalVxQW5vZnAwQWI5V2NTMUoyWUV4YlRWcFFxUnQyaHFROEFU
US9jNzJFYzVCR3cvYjU0bjA5K0hmCkRyVFphdlVnYnJsNjBFTVZlaWVyUDdmRUN5YWJUMnZPUlds
Si9JeTZDOWJrcHhMSVFBU0kxdHlhWWkxN2FJSmMKeDJTZ3lxQnl5N2Z0cEpMTTlNSHl3SmZoOFI5
OW5hVTBPcDNpN1FJbnk5Slp1TnE5bmgyekthbm5kTXRhaFlCYgpPK1FSdWtRWHRIL21OTHpTZk5O
Y3RNQlgrZWx4Y011TmZMQWRhRHo1bzJrOVgrdytnaWhyTXpwc0ZsVFRNTDc1Cm0rMWhjSTdaZG9l
NzF2R21WN3lYSnQwQkxaUTdZOVRpNUxFc3RyTT0KPWprbEcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d065a0617769596--
