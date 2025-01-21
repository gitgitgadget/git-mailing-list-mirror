Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873411F1507
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459871; cv=none; b=sBTLiQ4C0IOOycWctEV2RbhUhO3YCB8aIz57kmbTN6w64MpPKjuziI/7Rcdy/ib+rfploVtXtFh3JiDpbrxMEE63yfRjsYSwP91HdVAXhdNyhCMinHxrWzaTe+p5VfOh24k0UNmlyfU0bCjpt5KubG+Q3MY06R2GY2Y7118DSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459871; c=relaxed/simple;
	bh=9S5ClM8EtZdMBatKaINNypXNfgn+p6G+5OyKfIsXpPY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEG0ECARsZXjVkvWNTq10zPp1llN1yfU0RZ1iC6dKubDywcEa8z6Zf7N1pS6hybbZjziDgQjDXuUGgHf+7kYGCFP/Pw4o3AYdMp9Z+D1dvlcOiUf1WZPcrQYROWOeyegv7DLiPrDxeM0CB4WvrwJc7W2WaF/IXI7zy/1qT8/CMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTiLGEs0; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTiLGEs0"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c5d4f3d58so1413731241.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 03:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737459868; x=1738064668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuU6+L/L/mbLjr98OahQMcVdDnsdC6fyYBKp8aj3hwM=;
        b=QTiLGEs0TAab3WWWw8vG9IaHqIo4M7NhZBS17xiWtkMgVu/R4BHosUQ1pRoLPJA7Ak
         Va1bw08RFVYMkPBiFkAUAkFVm8U52ZBHGNDx59R9k8kiLGdeMcxBLFyCtiN8M5m9nV9v
         khnpBspxUiFOEecmdx4rYoVYXawO1nC6CxzOPa1vs4kMpG6Tv/shXIB0g/jOuUvbR1EP
         tQN1dr88sl8eCCQ+Jn2MM4wt5SJ0UJ5dzW04HpG5Pf+qYgkTRdvsWPjJPcRH9nb+ExhR
         LTUOm/041Z3PF28MGMXQ+LCjG/dvfW2OjAlcBzooAYD7EkqF+5vNnABTbuubDqJ287wU
         eH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737459868; x=1738064668;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuU6+L/L/mbLjr98OahQMcVdDnsdC6fyYBKp8aj3hwM=;
        b=CjCgyHVLPDuXHMYRMwhgGTSMkiX9ILVbclpcBtdsc3PEO8bZXtAO6wosVwGxrAnhFI
         hyNm9Qba0XwG9/za87+DswUonTblZQwVD3itIhS6wwOTWvOXF+S+Qmc2xQED56UU37Ac
         U3virx9BbKSSEd7Y7zb+OrrimQbt8pm6W8IF70+tzC7JFq5retWfaL0nGTo/cY7FpMTC
         LJiIcz92d4XZk/xBJuFa7qgQjytesvHL9qPDp+4l0OQNYbJplCfg1SqcMHRM05YmJN70
         eLxOGSPKo4swRsoZ3XZ5DIDqOyh4C6f/K/hljBA9ifjEPNqzOJwHQjxSSTp3IbG+Bmyy
         MOrw==
X-Gm-Message-State: AOJu0Yy8ovqiQ57umXXDQZDAylb+VfUmtYoE3X349mNpJ3X/YMVTfvAw
	CvEfv5+JvDYutVBqlNjT0sgqdQdXRh83xh1TTFFgSsX7fXGwDRX15YszaElCIxUKkd+axxYUbUk
	ZUl+dPROtjIWiYbs4yfJuJUsZfh5+Zge+
X-Gm-Gg: ASbGncvT9kJH3VLClfwaHtjjT33tP+HmPW9086TjjGwYbhjtCgh7vXWF72rSz2BUjwj
	HETQyt6K0v5B/4mVLK2B13vc3JbKg+TZHn2JFW3cNd+IDigwMAPf1
X-Google-Smtp-Source: AGHT+IGp0vbr2tl4F8i0Mka/Y9IMq9Wo3QW+4rI43MptALFrskBLEnyfmW0yNFXlES+M1uJqK/RnRJHHLA6UUjX3dq8=
X-Received: by 2002:a05:6102:2923:b0:4b1:3409:5dcd with SMTP id
 ada2fe7eead31-4b690cd0f26mr11864120137.20.1737459868048; Tue, 21 Jan 2025
 03:44:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jan 2025 03:44:27 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z49FHQgsFSX6sTxu@pks.im>
References: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
 <20250121-461-corrupted-reftable-followup-v2-3-37e26c7a79b4@gmail.com> <Z49FHQgsFSX6sTxu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jan 2025 03:44:27 -0800
X-Gm-Features: AbW1kvbZKLJ7qS-Rssy7ayaccwiR8SLRbueORwExSBgGqmuM-xopJhHUW6cKoPw
Message-ID: <CAOLa=ZQBoSpXiLHtwgaeg8vnChrqtvzcettRQZFvXZQrpr0=8A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] reftable: prevent 'update_index' changes after
 adding records
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003f405b062c35e674"

--0000000000003f405b062c35e674
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jan 21, 2025 at 04:34:12AM +0100, Karthik Nayak wrote:
>> The function `reftable_writer_set_limits()` allows updating the
>> 'min_update_index' and 'max_update_index' of a reftable writer. These
>> values are written to both the writer's header and footer.
>>
>> Since the header is written during the first block write, any subsequent
>> changes to the update index would create a mismatch between the header
>> and footer values. The footer would contain the newer values while the
>> header retained the original ones.
>>
>> To fix this bug, prevent callers from updating these values after any
>
> Nit: it's not really fixing a bug, but protecting us against it. Not
> worth a reroll though, from my point of view.
>

That's right, I'll add that in.

>> diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
>> index 5f9afa620bb00de66c311765fb0ae8c6f56401ae..1ea014d389cc47f173279e3234a82f3fcbc807a0 100644
>> --- a/reftable/reftable-writer.h
>> +++ b/reftable/reftable-writer.h
>> @@ -124,17 +124,21 @@ int reftable_writer_new(struct reftable_writer **out,
>>  			int (*flush_func)(void *),
>>  			void *writer_arg, const struct reftable_write_options *opts);
>>
>> -/* Set the range of update indices for the records we will add. When writing a
>> -   table into a stack, the min should be at least
>> -   reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
>> -
>> -   For transactional updates to a stack, typically min==max, and the
>> -   update_index can be obtained by inspeciting the stack. When converting an
>> -   existing ref database into a single reftable, this would be a range of
>> -   update-index timestamps.
>> +/*
>> + * Set the range of update indices for the records we will add. When writing a
>> + * table into a stack, the min should be at least
>> + * reftable_stack_next_update_index(), or REFTABLE_API_ERROR is returned.
>> + *
>> + * For transactional updates to a stack, typically min==max, and the
>> + * update_index can be obtained by inspeciting the stack. When converting an
>> + * existing ref database into a single reftable, this would be a range of
>> + * update-index timestamps.
>> + *
>> + * The function should be called before adding any records to the writer. If not
>> + * it will fail with REFTABLE_API_ERROR.
>>   */
>
> Thanks for updating this. I think the reftable library is one of those
> code areas where it makes sense to sneak in a formatting fix every now
> and then because its coding style is quite alien to Git's own in some
> places. We could also do it all in one go, but I strongly doubt that it
> would be worth the churn.
>

Generally I try to sneak in small fixes like this around code being
touched. I know it is a little more toll on reviewers, but small
improvements do add up.

>> -void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>> -				uint64_t max);
>> +int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>> +			       uint64_t max);
>>
>>  /*
>>    Add a reftable_ref_record. The record should have names that come after
>
>> diff --git a/reftable/writer.c b/reftable/writer.c
>> index 740c98038eaf883258bef4988f78977ac7e4a75a..03acbdbcce75fd51820c5fb016bd94f0f7f4914a 100644
>> --- a/reftable/writer.c
>> +++ b/reftable/writer.c
>> @@ -179,11 +179,20 @@ int reftable_writer_new(struct reftable_writer **out,
>>  	return 0;
>>  }
>>
>> -void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>> -				uint64_t max)
>> +int reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
>> +			       uint64_t max)
>>  {
>> +	/*
>> +	 * The limits should be set before any records are added to the writer.
>> +	 * Check if any records were added by checking if `last_key` was set.
>> +	 */
>> +	if (w->last_key.len)
>> +		return REFTABLE_API_ERROR;
>
> Hm. Using the last key feels somewhat dangerous to me as it does get
> reset at times, e.g. when finishing writing the current section. It
> _should_ work, but overall it just feels a tad to disconnected from the
> thing that we actually want to check.
>
> How about we instead use `next`? This variable records the offset of the
> next block we're about to write, and `writer_flush_nonempty_block()`
> uses it directly to check whether we're currently writing the first
> block in order to decide whether it needs to write a header or not. If
> it's 0, we know that we haven't written the first block yet. That feels
> much closer aligned with what we're checking.
>

The last version did use `next`. I changed it because `next` is only
modified once the first block has been written. This would still allow
limit modification post writing of first few records.

This should be okay however since we're concerned about header <> footer
mismatch. But from an ideological point, it makes sense to only allow
limit modification before _any_ records have been written.

I'm thinking if we should use both `if (w->next || w->last_key.len)`.
This way we capture all modifications.

>> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
>> index aeec195b2b1014445d71c5db39a9795017fd8ff2..b23edf18a7d75b0c2292490ad06d4dfaaa571e79 100644
>> --- a/t/unit-tests/t-reftable-stack.c
>> +++ b/t/unit-tests/t-reftable-stack.c
>
> Can we maybe add a unit test that demonstrates the error?

Good suggestion, will add it!



> Patrick

--0000000000003f405b062c35e674
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5448e43b328a088c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lUGlKa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEZyQy85bFNYU1ZyWm5TQ0VhU291VC9DTFJ2V0xXVgpLN1M1NEE4bmhT
K1p6Y0gyZzBnd0I0YTZORmhrV1lBcVNmR0crR2xOZWhDQ2svVUdyaXdIdXRCbFJ1QUdlVjVuCnlp
djg0VHJTS29sejZCV0k3MHhCSURtTlZnT09EQm5adFFwUUJXb2pUZU5LZkN4M2FGd2JaakQ3QVJC
R1oxMlMKcEFnZnhqSmIycmc2WjlrUnVTM05SYXhaMVdnSDQ3U3p0RERjUTBzdk44ckMwWlg4RGJr
WGR4bU15V2g2MEU2KwpHaGFOS0Z5NFEzTEZjVGJTQi85VW1MTkt0WnlJem1Tc1BLd1NmN3R4WVJ5
eDhvbHd6OG96N2Z3QTNFcXFjL1dvCk5NdTdVUHIvRGVaSWZHVldmWFZ6dlU0MXJ6dnNkQlk0Vkg0
NitSZFhpaSs1bXhoQ05QT1d1bUIrclkrSDIvVGUKUnMyRHVoR1RMZjRRUUpIQWNRc1cySHE1R2dY
S3U2RHVDSlNDNGM1RlJWL0Q0a1liMFIwTm1EOVBZWURqbmlIRQplWjlmRE5mS0JGUitDUjV4UjJJ
WTAyZlIxQWlSNmZEUzVFM3dILzQwUU9FZVEzQ0p1L1V4ZDZCMGdleFg3R0R3CkNsc3pBczE1STRD
T1h2Q2VHNmNaL0VnWUU5SC8wRFk0dWxjajZPTT0KPUxrOG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003f405b062c35e674--
