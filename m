Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426142EAD0A
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346255; cv=none; b=nDj3KSnw9hy+P7J9ZHUJnU2Zxfo0rBlKlZQ6o/3tvHKLYf6eJzVPhmqrf4fq57vmvGqWJNINt+2eTPzvbrvoe5PtNVukrN+jbuM5a9NNrlCoFrC4I7XOLIkDJ27y2YMqnvzoM1MtcwL5eiqRb+kDJxWX6ndiXk7+Cc2xRxZ6oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346255; c=relaxed/simple;
	bh=Tdacl0dDYBZS7XNjoxoRNbSQAzfPvce0sgKWEp+dsR0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5migC1jwfLi5XEyr/+KS9nKVsG59imyif3B1umjen3XhJZNtQ9DzpIpwvKvKEubQ7loyCSBmR4Fd5lkiLJGzgrlZvCH0PFWgagA8ESyDjzUvmH4xHSTdZfBWre06KNYM3sLeRP9K33pZKzOaKB3FQBdE/ddPM7w4Z6P2V3OtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+8Ot+/X; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+8Ot+/X"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5b99f5d5479so3656943137.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760346252; x=1760951052; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7eDZ+CAiSzh9I62qXl6pbpuDCZHDWBj7Sy2bHjSg/A=;
        b=m+8Ot+/XOf1pJNLQyl1ZFIE7iJO0/C6/4TKUSo/3Dm6JkTyvakhaQHcwnbK66K2dZh
         9CDT2mKpMFJDHAE2/C3spzllEsPFLxt5l7P30R37jPUMZ34/VNxWKT1t0xrk7r2cKglo
         dH6tfh+UQIm3s0glpFLUm4r6YX82REd0S8BdxG3qaGHRxpLrBqUyS9tA7U1gPFG5a+IZ
         1w+c1TxVg+9qEh9owrpnaXdXt9dOxUddK9JT8sYo4tfR5CDwpohkChDQPRQgfdyUiwN3
         Jq3k1FpPdClmMndz7a26sOA4qQDah6TSUuHzWhaZJDbU+FltF/KnEmTiqvOH4lhbTMUH
         KiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346252; x=1760951052;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7eDZ+CAiSzh9I62qXl6pbpuDCZHDWBj7Sy2bHjSg/A=;
        b=goIP4Gj+jDfB0wkU9RWyBxJBTkZSVnrW+xJ/8Hg4XD1ECUIn3Lqwn2nMbnIBYVxShC
         cOWNRyl6iw1tp9WZnWMSx270M0sEC000AQwvA8IrYeHlafkgpjFbnKGySttHFxd7KvPl
         rol0IPuF+g6CIEFP5kHtH+lUnH0LtWvbaSzcHhi1IYcuLSpDl5j42q63Q6reXweR8kYe
         d5C6AM3keXT5U3bM011w1H4DGKSOPEajfbzro5234hzCp/4vAsY22iMywS7EkJyufeTE
         l007tdn0rUA3gqn+ZvEaBaqsEwnAuA/0WHR/mWlcFpCi71lunwev+T8aktiTBJFbdhrf
         2Ryw==
X-Gm-Message-State: AOJu0YxBezbNweIlonxXwjruqWa/PLFZLHHo8KqcgbaFqiNKDTDs4t/4
	o2+FRqOnYrZRSNePPO1aAxzZ0n/LSy62fzdOpNCfgiakuMM70fxboDni/ejr48e831ga7xDQ2Zt
	jE+866YekzIUvJ6rp1ietq1C1hnOPjZ7RVQCB
X-Gm-Gg: ASbGncvQrkxJsmihcf9X7QpyZdAQIv6z63SRascCOYDLTadV3Cz7IXyrht+n+/xAw+B
	I8szuNxTKIcerRtNf25D1Vt8fh73/nPPGjCA9aG+ciCSAFINILVj6JZZNHYol9LIO8qDHmD5G49
	9k9HmFG+rhSjllv8MK0WXj/ipHtxtpojJFYZcLpe7DxEhgQCD+pgvzf/Zl5ail2BdqoZF7wRsoe
	4gn+zmahVXuNYcI1SkWc+AUbp+NK37wTACnCCdMBnuaaHKYg3HmQIjZx7Q=
X-Google-Smtp-Source: AGHT+IGWDKRD36XNqNPmMo7sbK5EM6TF5pAluEMFyVWLPSynqF0s+dLmEoDwbJ5UaoVmWKJ5uqKbn3qlXEnTG50ADOI=
X-Received: by 2002:a05:6102:3241:10b0:5d5:f8d5:e3ec with SMTP id
 ada2fe7eead31-5d5f8d5e3f7mr4175642137.0.1760346251877; Mon, 13 Oct 2025
 02:04:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 02:04:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 02:04:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjsgQge8Wqh4odB@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-7-c7962be584fa@gmail.com>
 <aOjsgQge8Wqh4odB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 02:04:10 -0700
X-Gm-Features: AS18NWDH1unT_CZlVW9_YDwKyRZw5FiJo1u_XZYGXmOKsxien2O8poNYgs010EA
Message-ID: <CAOLa=ZR2zOBkS8wQk0=dr-4wU6XR2O-GHV=8LEvzq6F5Bs+tSg@mail.gmail.com>
Subject: Re: [PATCH 7/9] reftable/stack: add function to check if optimization
 is required
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000067aa40641068d45"

--000000000000067aa40641068d45
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:11PM +0200, Karthik Nayak wrote:
>> The reftable backend for references, performs auto-compaction as part of
>
> s/for references, //
>
>> its regular flow. This allows it to stay optimized.
>
> Maybe: "flow, which is required to keep the number of tables part of a
> stack at bay."
>

Will change.

>> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
>> index d70fcb705d..754e955206 100644
>> --- a/reftable/reftable-stack.h
>> +++ b/reftable/reftable-stack.h
>> @@ -123,6 +123,9 @@ struct reftable_log_expiry_config {
>>  int reftable_stack_compact_all(struct reftable_stack *st,
>>  			       struct reftable_log_expiry_config *config);
>>
>> +/* check if heuristic based compaction is required  */
>> +int reftable_stack_compaction_required(struct reftable_stack *st, bool *required);
>
> Let's use a full sentence here, starting with an upper-case letter and
> ending with punctuation.
>

Will do.

[snip]

--000000000000067aa40641068d45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5a7bd5bddd1c2c26_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3dJa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXJrQy85bTVPblpvbG1vS2wyQ21sQ1YwQ1J0UlFhTwpCR3V6OEpUakNl
VVJ2R2grUlFsZ3BLZnZScTIyS01kcjBsN0UzdGd0VE02SzU0aTFyZndQT25wWG00RUZiNXY0CmJL
WTFzZHVQaEdQZWxZUUZKUWtPdWZNNEVyN052K0NOVlZ3V2dNZVJSL3VGckkzQ1hDanRreExzdWo2
S3I2aEUKdEZXaldlMUs4bGdUL0ZnYkJnbTV1YlpEUk9ON1NSQmo1TEdHQzVsaW9DQ08yVEJUbm9m
YVFSSnVlMUdnV2IxMwoybk9BK3pLT0ZwYW5Rd2xyT0pERjlnTGVGdDNWa04rcUUwS1k2Z2pMMDIy
aXIxckpWY0kvbGFDejlqeE5PZUQ4Cmloc3ViamlwcWltclhsb2JaK0hLc3FkT1pFbFpQYzNPV0ZW
TlhaT3VlYkp2bmZQUWxLd3F4MjBhaDRGcVRGODUKYzlVb2ptUzFZazRQaVhjTnNuYjY4Unl3Tk1F
akVURXFIY3pxZlFKVW5YVFdKOE5jdk9BRTVONDRPKzdXemlYSApWNUI1UkJTR1pRZXFhV3pCbkt0
QXlUeThtMEhLUVlRU20ybjBuQlFoSXRvSWxKMXllMWMrN0UwM21ESFRrTWlMCk1aU2lKMWNVUGRn
SXBHQ0NGSDlsRWtPQnFQbjZZU2dPSFVZeUdNND0KPWRKM2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000067aa40641068d45--
