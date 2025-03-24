Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794D25E466
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827860; cv=none; b=INi2+5XRDri7K2xhEA4Wbek9vgyx81SNtxhL+HWO90t5RsCDSGXXcFReDFY12ptOYv9cCWVvRFUmgnMXy27+Vx4mziyIn8/jenXPXSF5FNGgpjAdH3DYZzl22p7SbFTmY5vt8FyTbGQUcv3koPIBaSsrQQtCG08FOvmb34WwUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827860; c=relaxed/simple;
	bh=00Acf+rnT8rinngsZeQPa//QEHdAB4A22b9Wx/TGSVI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOOEmyIwog55nkaexVuLM11zWXFni4kjEzczqlup76ftytjt6oa2/+U0wqHcwguXgqOoZZTlFQkRv2nxEU8vYl1Jy72bn2NYR84WjDald/0/K7FCty9zF5STrGCKzmo7JoXdTtAkrhWN/dszoeQCnXIsgw9o5NBVBT8AMKOlggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SudLlH7R; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SudLlH7R"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86d3ac0fec0so4078568241.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742827858; x=1743432658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9bmMygW/pok7eb7X1IFDyCkq+ch08iMWte9l5e4Cfs=;
        b=SudLlH7Rom5v0xI/X+UD6PoGZPemEdwLr84tINdvE054eh8poVbJ42MTFSbxgL6Afm
         dcjxtKZ9qOQKVCG45zBrOvIr32HAjcHqky7DI7VoVbQgsqHoNL9SQdJS8kJ2VC3ysjp2
         yS2Kg1kz/H/Q3XCMdxykF6RB3nAcjHB6ZfdohxkyZtImr8OouX/ZJyamgPgf5RTLe2Vh
         2yoAtWyA+kGGDuOa4moYS8zPheLo9YpA/R2ULogYi6fbo/dAaEQF1k648PDjnZ3FKGIE
         g0C/GT4WbIN0YoTDGSd8uvumAJtj7Kmrk93VQ7UBpCJ/pJM81RcL/jkxxT/q6q3vkAXU
         9oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827858; x=1743432658;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9bmMygW/pok7eb7X1IFDyCkq+ch08iMWte9l5e4Cfs=;
        b=w3PjyPXJ+cjxF65ezlIUKv0Z+S46HRxdhpp8dFfONx8yrXo/umqHVx4zNtGVR8SBem
         8x19KXCoVGZfAtBODBhAy8D5LUny1L30jeaBB5xkEjg9T5gLE8u9RdSkGA5U9yQv4j/r
         TygKT+w2odmfk3ygRD+L2cvHfbGlIQ/MZafhiSza7+XjMoDdhPUl9jubvh1euJyy02IX
         pdE84/ayRbmUmjSh50grbRyEkDgubeMOoFwiWlCPKMM9xw2bBabafkcP6aQIaZdEoWLI
         avoVfUeEkNHSLLiz8AS909wTPMVI9BSLSyF4HfCLCdnYk51a5yOcAvzeRfsf8YaCTUGA
         z9PA==
X-Gm-Message-State: AOJu0YycJ944yzKsoDh2khJAmfDo4ngl5ebuy3RCVI8YASSiLwRyBjA0
	IyxZjudNoCB+jfmN9MbDv2qQO6ifS/PVmAbd790m+lVJTTcLiY5RqxouBZOd8K6l1zMi2QqkrO3
	kfw6M0G4ipf8Hl0L2m11pON/lFvk=
X-Gm-Gg: ASbGncu+5pkeGGAw/MRqx/NKuW+WZZ5LeRKmsBa53I6PFOB3E2m+PxzM8KZWZHbYta5
	dHKkY7D7Q/lbrhAF3+F6+fzZEy6edMpAXq1g9xx7eh0Qt1kI+YHz1ul8tbcZg/o1tqjARClLG2v
	n792joo1HTFlB65e2cqdhiyGaJ6r9HLktjkLYdJKVByxrCU9tGm8TTnZ6abCFMHM3c/w3YyHU=
X-Google-Smtp-Source: AGHT+IHYmHqHb2KwRpKxzmTPI7mx/or5XPCpjhWe1eT4zHvtAsvuqw67ewP1G46iMHPNaWAXwy6kxfgqKD8IROBbA8w=
X-Received: by 2002:a05:6102:1625:b0:4c1:806a:3b44 with SMTP id
 ada2fe7eead31-4c50d47f7ecmr10105181137.2.1742827857814; Mon, 24 Mar 2025
 07:50:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 14:50:56 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z9x578gHJQPCYU4v@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-5-3dcc1b311dc9@gmail.com> <Z9x578gHJQPCYU4v@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 14:50:56 +0000
X-Gm-Features: AQ5f1JoqLjmKbJZFHrnEfNf9-zTHVwM5I0ZWyxSo3Taon-KEcE0g5fwHBCH5CFo
Message-ID: <CAOLa=ZRM8EeeVXpZFpLU7Wg8k98_U+0hw1y63gQDjPEfR2P2cw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] refs: introduce enum-based transaction error types
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000005ecfd7063117bb71"

--0000000000005ecfd7063117bb71
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 20, 2025 at 12:44:00PM +0100, Karthik Nayak wrote:
>> diff --git a/refs.h b/refs.h
>> index 240e2d8537..dcd83e81e2 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -16,6 +16,29 @@ struct worktree;
>>  enum ref_storage_format ref_storage_format_by_name(const char *name);
>>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
>>
>> +/*
>> + * enum ref_transaction_error represents the following return codes:
>> + * REF_TRANSACTION_ERROR_GENERIC error_code: default error code.
>> + * REF_TRANSACTION_ERROR_NAME_CONFLICT error_code: ref name conflict like A vs A/B.
>> + * REF_TRANSACTION_ERROR_CREATE_EXISTS error_code: ref to be created already exists.
>> + * REF_TRANSACTION_ERROR_NONEXISTENT_REF error_code: ref expected but doesn't exist.
>> + * REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE error_code: provided old_oid or old_target of
>> + * reference doesn't match actual.
>> + * REF_TRANSACTION_ERROR_INVALID_NEW_VALUE error_code: provided new_oid or new_target is
>> + * invalid.
>> + * REF_TRANSACTION_ERROR_EXPECTED_SYMREF error_code: expected ref to be symref, but is a
>> + * regular ref.
>> + */
>> +enum ref_transaction_error {
>> +	REF_TRANSACTION_ERROR_GENERIC = -1,
>> +	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
>> +	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
>> +	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
>> +	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
>> +	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
>> +	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
>> +};
>> +
>
> Tiny nit: I think it's generally preferable to document each specific
> right next to its definition.
>

Idk about this, I based it off on `enum bisect_error` which is similar,
but I also see the same in `enum scld_error`.

I'm okay to change this though, perhaps makes sense to document the
preferred style however.

> Patrick

--0000000000005ecfd7063117bb71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 957e901ad574f8b0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maGNVOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1Z5Qy8wUjAxc1VYSDlnd0hNSkhDUHBHenB6ZjNxaQozU1hXWk8wemNl
OWtSLzdXd1kzcWlvVEI3V0dWUW03ajZOSHlON2wwdk1RL2tnWlRzMUZUTFkzdjVWOHJEMTBUCmpS
aDhIU2JqS1BDZ3BnRXI4Z0ZRd2J4QXArbkVyYkRxVnJyTUk1VnQ3WlNNRTZScjRoZFV5YUFYRVQx
ZEwvRHkKdUJkSjNKTVNJRE94Q2NpVmZpaUtkejhRN3N6MEJtS1RPUytsWTgrSlZscXFZVUc2cTEv
Mmc0Z1lGODc0VmFCSApjRnhBQW1wbnRoUVNPQ2MzeHRWcG92VS9WczlMOFJCVGduNmF4c0lqU0ND
aWUxRCtwZEJHRlg5MEIwckgzb2o2CmhST1NKMlFsZjduZGdnM1J3WXJTUS9ST2k1Q3J2a2dCbXI4
YXpCOGpnZDVLVjFRbENKR0phaDQvaXh5KzdHYkgKYk12R29LVXdXUW42eGEzYms1TjhhaGc3dDRt
ZjdoNE9tbFNMellGVGJUcTVYZlFQdDc0RHRRRk9FVi84VmdRTQp2bWNXTmY3ZlFVNUVHRnV6Q1ZB
TDVkdEZaTDFWTXplekhGdk5qaEpHeXdtcEFTdjM4cTV4cEVSQkdlN0N3c09lCmYvVXlRRndBVTlN
WnlVaGFHK3ZoRW1sVmpBYkxnaE1tMi9aQmFIYz0KPTV0MHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005ecfd7063117bb71--
