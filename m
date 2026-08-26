Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56D3BBA0E
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737584; cv=pass; b=Lh5vOt9lLrlKmDgF1iQt0r0U5FWfqSKChm5nB0XPfPNFiz+uBLjbP6XRVc8Oc9FET1TZ6PeMSGFtSYf1OvzrZ/AMAvDKfsrl91It2GEiGdgwqEYcfpRS7U8YbkeiDqfx2lC/RGXDhKUhm13hhCR4yAlQvRnjNUAi7msBu5ST62k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737584; c=relaxed/simple;
	bh=oPPiuJT2GRY40bcULK+01ET/F1jcbNmm09PPFMP/ioA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2hvRNopZSellkB+BELtfKmLhMSn9MVGlkfZj4xHIZzHzfw4WO2oAZQf4ZpTEwuWf+0+GVTP3M/qSdPeoWZpJ48Rw69kXQPDSZ4UX3iVxeE/9DL/h2jW2WlM4JBAcbScgmE3fSOcuaW0fPhqzLCksyq/XGnMuy8WIfVeyNeCNH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrbCF91n; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrbCF91n"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-783c3744227so5398137.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 02:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787737582; cv=none;
        d=google.com; s=arc-20260327;
        b=T1gZkplJTZ0X299BweCDb1tk8L9c+NfA7NeRPG13APE0t9lNT944IknzTyMd6zHZsy
         HIoCCJvrMv+vmSfb0fENkO4m5Tz+BUEsqfhEGz4AgATc4OAEDilCvH2FdV78976Zuv/n
         ZtUm/5+KASLx88EbS9ZPwhI4vn+OmFC79dr36zlwxPSWP24bZ1N2S+K+cXlaay0/81d4
         gp6bJKS6zmD4ACIES4Do9O4mDbPtKGy+g11hSeBdibdbcPZwAcA8NxVJK6o8Dul7bLbk
         eeLuQzQvXvlriYlaTKI9PUmFX4vIZ3PaxaY4xPBDYiYTe1dXzNtnVj08ix+gEQjDF/i1
         j0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6H/uHQrYqAT37EsisxkMTzWgvaYthp1W3f6U7/Dpr+I=;
        fh=NvnRkRZ7iM6A9pib/3cJxIVptBzKJq1gYMEXR72SskU=;
        b=qOxhey1CttMw8SeVL5xMk/vwSzqgfa9MkD86peo1jwBkOCJNPw3f6Ksa1h3XF/U24J
         zMVFf+rdyukfYgOjFDzisQPy5Ml1ybmYEioaCe7B1jIKEvrifCIR1gcOwduuXscYvbah
         M2uFMrSgGUAGLQ5k5odB6WWlhxnmpAE/L8vXPCiNYKHUAG+SvSvrwxQtYvaWl9kXd3mO
         AC6S8zZwqnmO5E9NpxeY8WKDyRef99/NG3FIlHbQqn0ai4whZjayRH/TRfTyEANtdswg
         hRebGzkTZKFchUrsQ7TXjtrVhhkwn3BbI0sSD0MDl38BOLzMTmpcGTkRotsmdVcS4XE9
         9LEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787737582; x=1788342382; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6H/uHQrYqAT37EsisxkMTzWgvaYthp1W3f6U7/Dpr+I=;
        b=HrbCF91ndyVDIwoEcfVXiV2tlN148T7RNViZWgZ5jyXrXPYsgcL9lxDdTfO1tis+QZ
         PNEeN32dzq+yeoDkCxV2x89tztYNavtPdSsRsMsmX03rGeT2c64WjrEXILDoKSOIbhg3
         hFjBSs6iZ+eoL1Ubeu+f6uH3PRFLV1cVZXCPbVeBRKNtClfaYJfzL3/bNiNBQqUdLWEG
         GFW1Iy+mrNelvTn0PxJobJPdxPveuUMMacq7a6GdjNUA5/ovKSmesasxs8aoeXojYbbF
         ycHIWXaEElOLfGwIuu9CTK4UnW/r7WB7iIfP/UFzswqBAwptLAbszI0pOPaxGuHX9Oiw
         zUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737582; x=1788342382;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6H/uHQrYqAT37EsisxkMTzWgvaYthp1W3f6U7/Dpr+I=;
        b=eyb3M2cerJMHjS7hXFdArz+rANpEKZIEXk5g1mkD8F1kL839B78OMuK839hL2UNdl2
         gWafiHDz1nM/sMtQscpE/DAuNOTmVygn8rLZ4E0NBwK4cQ7aHjKyYNB+zPSY5ZG922NW
         3dyQsvDbe67b/R3hjmI0u2xpevxclxfU7/O1NM9bwCuNQ7rAv3eDc+RZQj97cj7GGKWy
         +dNNqaC3qtUqnraCPt2gUDeHRg8bkwk6kl7j5iZR/oT7fcj6PkWVyGSHBoXctCzgc36T
         tsAIiuhCKCOSBnaDC3IEfz25vqXKFzvZCwGfRXzcUWwcOEWJjSFB2ChE9nVbdTLZB2D2
         b/vA==
X-Gm-Message-State: AFuF++nn3nuzUw97R0Vl0u8Gz33waEDC6DoD3m1aRz4MuXzwZkj5QAMU
	0ypZxEzeqGyrV37futmV8ezNQN3BByVcDQcSFJ0yUnnUh2ilDvTs8V9a3EdtomlIZmC9hXiN+Aj
	3SQX416jxGSaUuaj4/+itdgos0fsTxcA=
X-Gm-Gg: AR+sD11d2oXJst/V/cFZcGNOFI2hK2Bpt433Hh5RlVlQU4fubGFctw4dCxQCpfSMFpZ
	2KL91TzUuZsPlbBvq5DPQIlQMyaJdEqufgybZLV05CmoH7JiODQjl3VLbBwSATSwYiRo582PPcn
	e4S6weIOd5z+RYuwLcsk+yfrMoV7BhZKFFGHJcdc7+i1hsGCA4wbGB1ctxqMLpAgmJEHp6PXlfP
	Tc2T+3IS1UKm+FuZLZP6N/ex+kQAADtpbthbrvFFIj9rkD5o1jyavK3oUe9zWOjTFv5RAm2Yj69
	zgK4y2SRL9qGpY4+HN7PggvNqr2hXI6e9fMLGFpYf7YG7ZqP/xjkSIgJ3Z8NtPfsAk4nZeMw1m7
	SJtG6rxqFtq0Z3YgCEom9eLBFqKl243ZqYwMkWmkjWg8fbw==
X-Received: by 2002:a05:6102:14a1:b0:77f:7c67:e864 with SMTP id
 ada2fe7eead31-782c02ddfa7mr1609315137.4.1787737582126; Wed, 26 Aug 2026
 02:46:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 04:46:20 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 04:46:20 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ao1uqpCxFHlOyTV-@pks.im>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
 <20260824-740-optimize-reloading-the-reftable-stack-v2-3-9c9de2eb0af7@gmail.com>
 <ao1uqpCxFHlOyTV-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 04:46:20 -0500
X-Gm-Features: AcwNN1XFk9IxUHty1Gj55iyZsO5f692_xrnTYRrE_1p_YySRaLZJtX8SQyOpo7w
Message-ID: <CAOLa=ZSbOFmsNUfhsEESsD5rBqUq0iX=Ls_TgfRkeo5FQpamtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] reftable/stack: move list lock to `struct reftable_stack`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="00000000000088f20c0659f017cb"

--00000000000088f20c0659f017cb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 24, 2026 at 11:31:01AM +0200, Karthik Nayak wrote:
>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index 703548417c..c3d4deff29 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -628,10 +630,16 @@ int reftable_stack_reload(struct reftable_stack *st)
>>  }
>>
>>  struct reftable_addition {
>> -	struct reftable_flock tables_list_lock;
>>  	struct reftable_stack *stack;
>>  	struct reftable_write_options opts;
>>
>> +	/*
>> +	 * While the list lock is acquired on the stack, we need to distinguish
>> +	 * which 'reftable_addition' is responsible for the lock. This avoids
>> +	 * clearing the lock of another 'reftable_addition'.
>> +	 */
>> +	unsigned int locked : 1;
>> +
>>  	char **new_tables;
>>  	size_t new_tables_len, new_tables_cap;
>>  	uint64_t next_update_index;
>
> This feels somewhat fragile, as tracking state via a bit is very easy to
> get wrong. I would have preferred a solution where we didn't have to
> have this field and instead a more direct proxy. But there's not that
> many spots where we have to do this, so this may be okay-ish.
>
> Other than that this series looks good to me, thanks!
>
> Patrick

I agree, I couldn't find another solution. The alternative being, we
move the bitfield to the 'reftable_stack', but that is more fragile
since there are more touch fields. So I think this is okay too.

Thanks

--00000000000088f20c0659f017cb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 39248ada9ea5f8b6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xT3Rlb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkEzREFDQTBuRkVqQ2tiQU5ORkV0VEtIK0dhZGFKKwo2bldldFhuMVZw
Y04wL1lPdGQvcHhXSjRTVVV0ZUpDc1JOZW1zYXNjOXFHLzJwSTJrVkt6Z0Z3by9FdHVhQmFuClhI
a0FYRkl2SFUxaHFRZERuSll2ZjNQc1VWSEI5L3JqWklYSXB4Z2RqL05adFRNclJDNE9EMVZSUmM0
dm5UUWIKNHdEelM1VzBLWU0vSW1KempmblU5aXdFY1JjaWFmV2traGswd0dkYTJJMEVscTl0UEd2
bHRaS0w1enhlSXFpRwo0VTNEVERXRllKbExTWEN0MVhLcEtXOWkwM0RJRGRkOGRlZVdOb1JUbTZF
dHk0R2RFbHlkSGM4UFlzZE9MRzJiCjVPNEJheUhGTm1NREROL1FSVGdiNlM2d3JSSGVRWlA0N2Qv
YlM0VkVOR3A5WmxZTEk4OGNCR3pHcWlxME12bTQKdHdBcDhUSzE1anNsY1A3SFFiWk5xUEkzVEpW
SkpyRmE5Q3hSZTJJajhiMFJTQzJ3K2ZIV0RKWU1ZL0l4ODZGWgpCWk9Ud1Ridms4YzVPTzh0MTFz
WTlkdDFKR0FHYlpKNWxVaVZUZHYzREhFTTRXY2VvYW1yWWd1UVd4SFc0THVkCjQ2bmVjdSt2THBH
M1huWkpramZuRGlQREFFTnNpNHdaU1UvTktuVT0KPTVjbE8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000088f20c0659f017cb--
