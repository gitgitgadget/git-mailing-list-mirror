Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B037F33E
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859374; cv=pass; b=SJejt1a1dubZFVLrJXCG1uoTQ2hUbRZjyYIfTOlzJsniTuoCglfRy7LKSmJB6fjm+FfEWUfvjAzDnds0oSFgCDuWQS3G7wEmC3kLA7SbMW0zPnLC/B0kgH4loPQjUdejPYqWImrNvEEgOWWWsIUFaHbIOYZLUZIhqKYiOkCT7wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859374; c=relaxed/simple;
	bh=HQsjc6ZoBSbv+vEzZb4+TtB3BfVjBCPs/6RRqfeZHN0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDtiFkzMgI1fxHaTMKmbQvwhOHxXKhN0yJgrhVyE53fCpp4y7d+AhHktNd4O2VRO3Mn+whGGBs66eGi+CKjavmXOKHpBnoVFYrupqR15PXC9RH1mneFscgG8aQrUeHkFlTfjLVzdkkQVWxkdJg2OhYEMORmZrKVcDSYQpNZfyiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TINUB7A5; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TINUB7A5"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-73720e58dafso2957555137.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 02:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788859371; cv=none;
        d=google.com; s=arc-20260327;
        b=p74iLXEqCfhRGld5LbF3Nzwq7xxQ6nvoAgSr6Li+W3yESrG0AqO5FJWPlKaLRyXLdt
         FPezEXvHiwzSjWP/UDTILrmigjvg9tWqN0yckepnZa88jsUTZYFY2giARbsA9iG/MKUZ
         hnp/73NHVYy/A/zmlJXBkpLRiuMqyyOMyUYhLsRVSMfU+L2XZaAaKODjfNjOMEiMqlgY
         LwK7gArPTgbzAWlLOPL14AiPTCM1FR/LpWrZYdC7tPJswsrDs8s02kYKeeokA/7Ebomc
         3j16xPf9xmzN+KuDRuaFKcn80JnCo0eOnl0xPCbXEeRdmb5t16Dvs7I2orxdoyoa1RNR
         kGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pXgI0tDxCeBmawDha3EtuB/Eqy8bIvQRntn9XN6UHwI=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=s4mka8QO9stn1IxAEqkF0wqblNMzKD78DjhzS1r/CXs2eZWM7l/14oNEOqBwhDpwZt
         jw4r0L+rlRQ1uQKSBWASY4k+jQw0xTV/r86iuJK6nkgJuZxfhgGou+LPVZ+V+IERN3D3
         iblB/r4Q+OOS/3zD5NyqY0N0NLAIK9wQYQomnpjmgHseaNDZXExxAEY4l57w/wQrJVMv
         A5kW0VEQSXMCgiBU6vmMv9nlD84zKpSYO80NLGL5MdfU1ViGIAz+ARmstvaxKWZ3Mjb1
         IsP9mFWtJDR6/4M1NtJNjtX/Abx/h+JU0kIJoBeAw/s2iNFcybe9/6d3pEBxkbMGD7zS
         dtgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788859371; x=1789464171; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXgI0tDxCeBmawDha3EtuB/Eqy8bIvQRntn9XN6UHwI=;
        b=TINUB7A5w5VUXLBu81FpRn4+Fzmkun2vU9665ikMNsY/5GfTZuY7vE7Vv2v0DzdhKB
         /x/56I4FkrFs3wbsNAjV5nxqsrjs9+6rUSLxcxuI+sDgcsmVcJw5qRRyc3jpZqcZLeko
         Uv6pc4Hb+1mx+OYy5p56OoicCOJ9YLciojbGPYlAsixRrNUHt8jn6WO4V1eOamM3QAni
         pLhG6kaKo2fagF3xMh10P8UP8REQ4trSP1+iOMdiNuE4Jw0HA5ViMSJ5VPaRVCQOcCYB
         d7LNSVl1PBBC2BlYKb3zfHoVleu4nz+iLZszUZGT+/yGeouiS0qMhT0PVLaTwu56+orU
         VFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859371; x=1789464171;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pXgI0tDxCeBmawDha3EtuB/Eqy8bIvQRntn9XN6UHwI=;
        b=hFdmBg2iAKTWG539VguSCuCToUaVhC+UYTQUJvCcl0vpL17mTeCE+94WyqRUrh5cTM
         p7rLPYuji5SkCFCLNUiTRnx83rnUezObaSqCQgHDmSz+JY2TISh2gy6UhMN7qApe5Q5T
         6CHpOsP7O8Xod+Fj0tgCZGGaTDRyrB8CZjAAniqaTPyOKc1rBINrpE9qsqof93Q1CrTG
         8m+ncUJRBAnNErImadys4z5CzdVXvaPWDUV/PZUzXOpZqrLlqkBVZtyydbjKjSKqD8K2
         uroh8JHTTWyTtyz4NNUaYnOVSWPeKtMFA8ubRl8zDltNq5eyv1OWvngk2YU0YpIfEtOt
         QKMg==
X-Gm-Message-State: AFuF++kfh8PM5rhfbdATAvCpslzgQhjJGY46IYzoLeKcFczoN2NgbT+C
	4sd14BhS4BT2bCly9IlwnjN7+sDL2vcv4LRXwStzP5jiALcwDdOI7j03dc7FzmHPYYw1UV35v4V
	20C9c6wuSVaS+4y4PkuKgt8M0ZGyZav8=
X-Gm-Gg: AYBFou1F/DF5WXcVy06Ao1+YMdig0Kmho1nQ5dyRqrDATg3ybLZ1SSPyxyJnL4vvK2O
	TH5ZjDlw+fW333JCxg5kHDLl/strPNsYvQ0UaVu+pr12tLnFV7bh3ZHrHRzuo7ksG0TmLQO5UMV
	f//CEtJzKaEdoo8rjepwoazKIVgaOeYTIygvhQw08REWYwE3cCqPNvx8bXSrwDpXEZl7FI7M8dM
	1Nh/sVJ43rTf/YRs9FVRL/+J6hFAUUDZhQBOaMXoDUsW+OZJImwULyNfFrUfqH+V6Vuvq3fn99L
	Qp2v8ChfQEXqnbYsLDGnAGzIWuCyjr/CBAjjaPAeUqplw/rIeetKj9qaz5sC9Uq81LoaHEzwJ6d
	hgA==
X-Received: by 2002:a05:6102:80a3:b0:77d:9fe9:1716 with SMTP id
 ada2fe7eead31-78a4a6e83e9mr14573972137.2.1788859371457; Tue, 08 Sep 2026
 02:22:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 05:22:50 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 05:22:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq1pb43hjh.fsf@gitster.g>
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
 <20260904-758-introduce-hook-v7-3-6c66f0a3a572@gmail.com> <xmqq1pb43hjh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 05:22:50 -0400
X-Gm-Features: AcwNN1VJhCfIgjzqBpZNBEvAan35Gekxa4H3YfkzYCyYVFlK-68BUBGTO87uWgw
Message-ID: <CAOLa=ZS__CA3AhBTR+ndW=fJN1bA9VLa0v87eZ4ja+NN6vc9WA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] receive-pack: move message generation to separate function
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="00000000000063b36c065af54710"

--00000000000063b36c065af54710
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -static void report(struct command *commands, const struct strbuf *unpack_status)
>> +/*
>> + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
>> + * For v2 protocol, set `detailed_report` to true, which will also add detailed
>> + * report per reference update.
>> + */
>
> The second sentence is stale and no longer matches the interface.
>

Will drop.

>> +static void generate_report(struct strbuf *buf, struct command *commands,
>> +			    const struct strbuf *unpack_status,
>> +			    enum report_status_version version)
>>  {

--00000000000063b36c065af54710
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1d6c7ad4a29e22f4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xZjArY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNC9BQy85akdkdWpOSTRvZ0ZTMnBlNVU2QVF2S0Vwdwo5REg5MmQrcWNG
L1pDaGltaitNSHNGeENMMHJ2cEdMd2xGWDBRRVBjWVdvS1U3M1RuSDN2SlpnRlZxcW8vT3lYCmdu
cnUyK2J0Q2lwc1NqRTVZdlplYlV2eHFzdkV0cmdFeS8wY1BHSU0vdnZ6WHlmdmY1VHJiUmc0Tmh0
cG5jTEcKQXhERlNXZ3k2a1J5ekJGOHcxQnM2Z3Y3eEt3YkE2STlpV2NXaG84YmZEeE54TjI3V2ZE
RXJWczl1RlR0TWM4cQpaZEhHMG93Y1c0WlJOV1hrakMvbkVZOVZTNjNTTHZCRXJZeEpmUGx5eGVx
K1pLYXM2NEdsTmwvK2Y0S09oN3RyCkt2RWlOYW1laU1HTlBqdWtyMkN0a2RaQmpDRGZhOUhNZG5r
aXkxTHJsbjEwS1JxYm53VjhOWitvRWpKTGFlSWMKTWUrTHJ2L0oxaDhGUi93aS9pd25IT3lPU1BN
Y0YrQld0TnFwWmZ4Rms0R0xJMnZmTGZnYU80UWUwb0FtZEFXSQo5dklhZUR0Y2d6WU11Z21McEtD
bmVMY2JLRkZnRFZzeUluL0g3U3dBWG9ieWE4R0o4S1lOKzlNbzFnR01EbGliCjZXSUIwTm8zMzJm
MzRXWDRyblFWSG5tVEtRU0l4MjlOY3NOV1pKWT0KPUhSQnUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000063b36c065af54710--
