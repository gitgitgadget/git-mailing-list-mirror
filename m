Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C62F9D82
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282440; cv=pass; b=DXziilru5Uf0X5sLB656hepr4LIFkrGJJVav1NfGLqsspErre+Gq81oSy6G1ou8RmoenkVrjzlHjCn7j1noDZlSussEbzpzMkKe8odBUt0XDp8Ueezgrs5wA9T+dUEYNmNE2BhUJCPyFZ6mwEsCPNn8kM/tlxF/pvym2pdvLdmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282440; c=relaxed/simple;
	bh=p0iCuhcoLdF7WS3N3ogsibcuuLeeGmWcyvKaFXKN/o8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNLP70TXFIYdDhbDIKaDy+2KWO8Eia4EZ7JyeEyi4FRyr6X6VS/kh2uX2+ePl+zXc2BRy3dtBix/B8fJcFEaD+fLMIIOL+0S2L4c8KeTMCpC+H8ztUGr/5lzH7fQzUeXTAfSzd3jQjqD3uf/DbOGY8uKFINkZmXlc0gul+Ig0+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP6Exvq3; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP6Exvq3"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-61399bdd395so3145297137.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 02:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282438; cv=none;
        d=google.com; s=arc-20240605;
        b=B1FmQp62J0hpyiS6kJQRhQGuVSRwWv1+wszDCebTcC3f/CPtrSHO7VTIHfEQmIWRLc
         KwLVIIIw6RM7XpDwKMPv9Yt4b5KR35tCistcUDORjGOM1tLjAUo8yoPP58sSkd6qcXZK
         j7exoGu6QjS+MzYfnrK8DbK4iHfvFMdhS2ed+e6Rkq8VnovK4O3y5otT/hfpuqIdlMby
         IEANK2Cx+oD9IrPo1lq23iFGbW+2GYvVVTyToJLtJmwNyzA4zeyVRa1LN8Tbliq4Nx8a
         AnoL1iqnobOHZS023eKXXlECdgssgQxAiy053dw26RFoEWt8G3yxIYVZJVfCVsJkYJy9
         s0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+0gb+fZd726hFN1RTkvwCps+jzURETBCPFY4758n5Uo=;
        fh=cfiiBI91Mg1/Vapr0wZ2Md8nP88V3wXWNqOESpk7WAk=;
        b=RfW0PYWx1fFNgIHR0ymVfegWW4gWK9rei0hwpmfqCIev2IdYPipf8RZBuRmWlwe6ZY
         IW0a1+unGJBFGhQ1/uoB1TqC84CbAEZdLUstG4jGsk3PRBd1lXpKio87eyQIR3AzqZZg
         wG9GTEhvmBkvcdoDa6M65gLv7CEnnBr6SZDfs91dcNNcLeFEFIWwA7M+oTwfm5inyQ5F
         +oDogqv6keU+IKbLQIbB7h11ZzeNEl1j90rx67IUA7vppLhi+bNVLjSHOza8oXuhMesi
         TSO0rnjCHHzO1DOHiHBKtkpLI93N65FikaMow1JtakGcjMBjiBJGuQXX8dLB2QhZtkVy
         2drA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282438; x=1777887238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0gb+fZd726hFN1RTkvwCps+jzURETBCPFY4758n5Uo=;
        b=VP6Exvq3Uu6uwi2g1yGZRJpqPJIZavjlxOJQ9B5v9l2NTmCwosTdkCvo7W7kUaZ1dm
         agVAh5G82sB3tbfxU5aDWOky0h7e2gGIWFQPK4tEV90p3lZac2W9GPg7qJDa/Diifh2L
         +npKa6InLBmmGgo4Q32v/sKsEwbkWe+O0ll6yyfc6pfRLkUmI/6m2YQm/LdZfDcJmjcm
         +XUf+aJ5rhyV/ahZ3gDVf78/cNBTcMIffUNhc5oV+rudbHB+r9c+JiZmW4re9OSjGNn6
         gL0otU6yBXqGaUHWSFTNK935pTACPDtXpYdSfP9WdwQfHGVFGZ6ccwgCXsKBUUPevmIY
         4V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282438; x=1777887238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0gb+fZd726hFN1RTkvwCps+jzURETBCPFY4758n5Uo=;
        b=LS05om6RrrdQ3PlelITKAkCm1EZbDa0XkBnUWrxk2l6JEX1bIKyzl6BTizOcthIYYY
         Mb5k8zkzwzAyi6DLJ73F2+WwUr4zpRTnGHvAO2/Bm0Im454quZlF+bCHtruBiFFeLWFI
         dfu8XKyZnv5u3ntNeWqHS7Q2/m60S+Ox1lLP77qeDKIh/09KumaIrKQfMfdruPJ4oMNw
         dpFhJNcfmVbw5SP+BQuXD/h3jl3NUSeQursYKB0WuziPlotUzOm6K99nOmJcSD1qXrQY
         Q275Y6Sxay8r7yfGl951xJMgsG0rZ7jJCMeyasVo5djFHzsgS26cECGnNfN/QLhpa7vg
         nc1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/6aYwGQo6xPhVh3++oHRMtKjusqZ8USi9DDAATF6HqrmZBCnmnYCmL5WHzentaKyYIGCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMprZB0M9A3PzV5ska18xU0rjfvIumfB9mDT5E7GAmfArS2/z
	QtdS2DSoQ7AVa4kdg9FhBlEhPIKF3EkTf2KbhqC1eLNwEb52fN3slvexv0D/egPfqIHs015azAl
	EhLdJyHo4q8zcV2YKR989Sq9jkSUyqeM=
X-Gm-Gg: AeBDieugLNpGFIkGhHFgMQudBiyJcZBpUlojCzPOCEZMhKt85wrxd5Nh1DdLqLwBAPc
	LAIlm5W7I5OxuBnaKkibauj0IytlwjWqyQgbPY+N+9GCx5gXrWRBrFgjUpiJNl35nL8adWcMseN
	KKQrIEyeUiedGE1cIsQBC59GUDRfcroeW2OqP2bd88sbiMaPiSwRYK/4r/FNXIB576kz5dVvYEc
	+uf9HV5hshjr9Bv1jU8mPDi0PZX2q2Vu/hGHR6KJQA1hvl44YpeZ1h+uuFBdpGhzLraYaTSCHbJ
	FjAdW8ZdCM9yOZvUrL1BVszPizM/ORZQW1N3uM3GHwPmCheaovx9Y283kbKpdYY=
X-Received: by 2002:a05:6102:8022:b0:611:e0c2:1604 with SMTP id
 ada2fe7eead31-616f68d76e4mr18629431137.19.1777282438293; Mon, 27 Apr 2026
 02:33:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 09:33:57 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Apr 2026 09:33:57 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <87v7dgcnp6.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-8-ae5a4f146d7d@gmail.com> <87v7dgcnp6.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 27 Apr 2026 09:33:57 +0000
X-Gm-Features: AVHnY4KLw43U0cQhmvz8EyoKAldZnZrF7WYfnJL1Mp3cPJJukxvilKOfcgrx4UY
Message-ID: <CAOLa=ZSwupDzWKk0bq=N+O8U0NV9y3h3hFsAeN8WJF-Nwj5vVw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] refs: add peeled object ID to the `ref_update` struct
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000668ab706506dd0b6"

--000000000000668ab706506dd0b6
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Certain reference backend {packed, reftable}, have the ability to also
>
> Shouldn't it be:
>
>   Certain reference backends {packed, reftable} have the ability to also
>

Oh yeah, thanks!

>> store the peeled object ID for a reference pointing to a tag object.
>> This has the added benefit that during retrieval of such references, we
>> also obtain the peeled object ID without having to use the ODB.
>>
>> To provide this functionality, each backend independently calls the ODB
>> to obtain the peeled OID. To move this functionality to the generic
>> layer, there must be support infrastructure to pass in a peeled OID for
>> reference updates.
>>
>> Add a `peeled` field to the `ref_update` structure and modify
>> `ref_transaction_add_update()` to receive and copy this object ID to the
>> `ref_update` structure. Finally, modify `ref_transaction_update()` to
>> peel tag objects and pass the peeled OID to
>> `ref_transaction_add_update()`.
>>
>> Update all callers of these functions with the new function parameters.
>> Callers which only add reflog updates, need to only pass in NULL, since
>> for reflogs, we don't store peeled OIDs. Reference deletions also only
>> need to pass in NULL. For others, pass along the peeled OID if
>> available.
>>
>> In a following commit, we'll modify the backends to use this peeled OID
>> instead of parsing it themselves.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs.c                  | 15 +++++++++++++--
>>  refs/files-backend.c    | 20 ++++++++++++--------
>>  refs/refs-internal.h    | 14 ++++++++++++++
>>  refs/reftable-backend.c |  6 +++---
>>  4 files changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index d103387ebf..307dcb277b 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -39,6 +39,13 @@ struct ref_transaction;
>>   */
>>  #define REF_LOG_ONLY (1 << 7)
>>
>> +/*
>> + * The reference contains a peeled object ID. This is used when the
>> + * new_oid is pointing to a tag object and the reference backend
>> + * wants to also store the peeled value for optimized retrieval.
>> + */
>> +#define REF_HAVE_PEELED (1 << 15)
>
> How did you end up picking this value?
>
> I did some grepping to figure out if it would conflict with anything:
>
>     git grep -h '#define REF_' -- '*.h' '*.c' |
>       awk '/0x/{n=strtonum($3);b=0;while(n>1){n/=2;b++};$3="(1 << "b")"} 1' |
>       sort -t'<' -k3 -n |
>       column -t
>
> (Yeah I got some help from AI to write the `awk` command)
>
> Resulting in:
>
>     #define  REF_EXCLUSIONS_INIT                   {                \
>     #define  REF_FILTER_H
>     #define  REF_FILTER_INIT                       {                \
>     #define  REF_FORMAT_INIT                       {                \
>     #define  REF_FORMATTING_STATE_INIT             {                0   }
>     #define  REF_NO_DEREF                          (1               <<  0)
>     #define  REF_NORMAL                            (1u              <<  0)
>     #define  REF_STATES_INIT                       {                \
>     #define  REF_STORE_ALL_CAPS                    (REF_STORE_READ  |   \
>     #define  REF_STORE_CREATE_ON_DISK_IS_WORKTREE  (1               <<  0)
>     #define  REF_STORE_READ                        (1               <<  0)
>     #define  REF_TRANSACTION_UPDATE_ALLOWED_FLAGS  \
>     #define  REF_BRANCHES                          (1u              <<  1)
>     #define  REF_FORCE_CREATE_REFLOG               (1               <<  1)
>     #define  REF_STORE_WRITE                       (1               <<  1)   /*  can  perform  update  operations  */
>     #define  REF_HAVE_NEW                          (1               <<  2)
>     #define  REF_STORE_ODB                         (1               <<  2)   /*  has  access   to      object      database  */
>     #define  REF_TAGS                              (1u              <<  2)
>     #define  REF_HAVE_OLD                          (1               <<  3)
>     #define  REF_STORE_MAIN                        (1               <<  3)
>     #define  REF_DIR                               (1               <<  4)
>     #define  REF_IS_PRUNING                        (1               <<  4)
>     #define  REF_DELETING                          (1               <<  5)
>     #define  REF_INCOMPLETE                        (1               <<  5)
>     #define  REF_KNOWS_PEELED                      (1               <<  6)
>     #define  REF_NEEDS_COMMIT                      (1               <<  6)
>     #define  REF_LOG_ONLY                          (1               <<  7)
>     #define  REF_UPDATE_VIA_HEAD                   (1               <<  8)
>     #define  REF_UPDATE_VIA_HEAD                   (1               <<  8)
>     #define  REF_DELETED_RMDIR                     (1               <<  9)
>     #define  REF_SKIP_OID_VERIFICATION             (1               <<  10)
>     #define  REF_SKIP_REFNAME_VERIFICATION         (1               <<  11)
>     #define  REF_SKIP_CREATE_REFLOG                (1               <<  12)
>     #define  REF_LOG_USE_PROVIDED_OIDS             (1               <<  13)
>     #define  REF_LOG_VIA_SPLIT                     (1               <<  14)
>     #define  REF_HAVE_PEELED                       (1               <<  15)
>
> So I guess it makes sense to use `(1 << 15)`.

I wish I has this command, I manually went through the individual files.
I think it is messy though, hopefully something to cleanup next.

#leftoverbits

> --
> Cheers,
> Toon

Thanks for the review, appreciate it..

--000000000000668ab706506dd0b6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7628f7d6500eb226_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1udkxZTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVNIQy85V05MdEhFRzRzYlV5THY4elU5ZEo1cmM1eApmOS83NzNsd3pi
UVZwbmVyaUFOMTZjeHJpaFFwRm1BZUZsSmFzUFlpbEJkUXY2ZWMyNm5vLzRBL1pFTlEra1JKCjht
WHlMWERvTU9tdTNBVVlUays2bkdJcTdKcy9oNnd1bys1M1NlNEFZc2ZaQ1JINkZVaWVlcVYwMWJQ
WWRkSDQKTUsvRVg3MDIydFh6bm0veFY4L3ZZcVd0eVZXWnkzSjQxME5hd1lFd0FTa1MyMTR4UkZH
QUQrcmdrOE43RnZaZQp1UUYyMzY1eGI3NlhEYnhFQmFLdE9LYUJSL21GeUhISDZDVWk3a29IYWNZ
ZC9EQ2xYcnZnMENZRXkwYXNmZEorCmJKeTNRNVlmV2RVL3JYdzJxb2UyT0NYczVwRTNyTDJwVWJB
UHlFRkZwYm9XMU9DcW5Od1I1clAxNlZ4cGhhQ0kKY2F5TEpFMlBsMXVGbkN2SndkMTQyQzgxRStK
QU5BaThxZFRlU01RaHk0bndFZ2tDY1RhWEpoR003ZDNqYkhGNApvT0FVV0VEM1gva0VpMFJJci9F
dkVmV2hvVU5kcUVnZXFRLytzRWw2czdqaFBCak01MUd4TWdRbmFTTFQyUVhNCjZ1LzRBeGJDRG5C
emdyb3NuTnk1S2lWTkVlMVNzVDErUFFSenFTND0KPUFqVXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000668ab706506dd0b6--
