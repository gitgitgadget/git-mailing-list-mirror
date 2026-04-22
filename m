Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C73D2FFD
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859499; cv=pass; b=uSK85qVx1w+V5ywEeBZkDMtm03NtqxHLq3JlC2ElGXfapHz7+5Z9vH0F6000D0VmWCclcvtNtGhEnEqDZb82XP7U/JjXTYjoi/J2GPtidZV2IGJnIGCp6OTr5mo+9VDZQjPYEC2LIRqiN+aTCuoKKAIbVuMgnLsnAcD5D3r0MxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859499; c=relaxed/simple;
	bh=nyBdVAOYf1XFpuLERoE8LpOmwEFFJW9mN6U+jm2ikxM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNfug1hqqjfmG1XW1rf7XIyJx1PbVoe+sHRjyZLOod0IJGPTovX8l8sKzKhV+VifiizniuwdDcheLsd4bGxCA2Jbk52cCHWHYG5yaHP5ABQCmNe0yLPQcwzYRg8Ag1PsVYHALsyd2Yv/RIU94sqLu+FJm+aS9unogVVm+r1CrII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYiZx8Gi; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYiZx8Gi"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-60fa13bde2dso3457613137.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 05:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776859497; cv=none;
        d=google.com; s=arc-20240605;
        b=lBkG0OJPKpmlgTDfZn17Sc7+frf+BSUjKN7lHZb4J1F5/uIol6vbEsZ93AxxyRTcdZ
         FSP+2NuL8PY30ck2lqT7klcieCHV+rwHzUEu+12Cdb650fYH+c1LDrp2IkdIpFHmfnjY
         Uzkx5eyATCC20jIrMCMNQnbh6tFvekkb/z4Hr0o+N6RCS/VCKMnlMdM8MnH81asxsmtw
         cwwDRyQbT6kIDfr5uz+dxRPrfXVwKZPQ3nDQO2qDpPAnVrfhdABd9aeHak2DXSf5yhQ3
         +1IiWKiXnBQktzXYH89QiaOXIdnZvRNM3D+4MPuV3XmQZN/tIFXlR+apU7d2VlFwuGIr
         ZFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=E/qgAPeikJIYyd45798LOR1J7T4zlOfsiRZWijUYqAg=;
        fh=wGUO1cWQgMUfUsI3b11YAGcfHb2MuH2HVgwXwqOKUSU=;
        b=BcqE2oZhtH0MK8T9CBYQ8gN7OByjZv+fJbjzT4Sm9lkHRvLS/uFTtujA7BuRtxcZZ+
         rfuMSBVqb3+1DDATOn2aQeWGbpPlFOBiY3AHLcCXuqD89kIoBPAh299Ah1NLbeL4j5SI
         RJX7MO1yMfr138Cxu/PJSEXxC+i0O9flKK4JiOzdwkcs0YNfvDtOYDrnpXP5Si8oU3Kn
         lp5RDhg9RSIL3HITM1kkGqRMt6ucIC72EMKYkkyMnDhaXWSXkMf5d2i+DHYqJWhYUfvp
         NGjpYk4ovnqAr7jCxvAukcCa9/ih44rl8vCwZFSqFzaBRmgxbrDS2kJWoBYwlUOioZ5U
         CumA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776859497; x=1777464297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/qgAPeikJIYyd45798LOR1J7T4zlOfsiRZWijUYqAg=;
        b=qYiZx8Gitcheh80U4BGK7VYkLtC5I8DtMI3xagiBpjTwwB3oHSQ2xTJOssRp6ElQ/G
         2p4GSREntbcd7lw2LfRdxyblTFCIN8o3R8TdKohSNRi3QDYmmxPDOd3rzxHnI/wq0V6P
         iUMHGNQ0uWw2m/fXN0my2iMhdh3aH+ga4IOhmJo6EFVBGOQwhe+bx3w1HC4fULH45E+M
         Dowh/D8sywpYoaCkk8Cu0iIrwpAyuNeX82iZE6oSWyXjaQDO6lsRpzisRuMTdedr5uZH
         ikT2DqSRLNgnGFE4umnEs1WHFO0YIjdMqcbkMa1a4dC3cEnX0Oh4O2dBuh5lNaSMbcN0
         QF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859497; x=1777464297;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/qgAPeikJIYyd45798LOR1J7T4zlOfsiRZWijUYqAg=;
        b=DWrx51ZyYKgRfs50OtPwOUVHv43WTKXGcCdk2R6o0U2hLGgFGTVznax4qjR2tpJFDR
         d4yRKP3WLSw5v1w+gmbFYH7s6zDGwefxipadBPbmvaAksMacnKp8CkkvZxVfcGMa3vkW
         7dgeteMtj/og660+aFmyHtVtAlOUCsGEQfypJ9TDGpc5CB6+E8+m08OHlyvxjyIJ8nd7
         LXuLu89gAvGbAWcaG76Ufw/XIIbdYz7fdNnFoZYKGQVGfzDKgMu0oJX7MP895uf8s2zk
         fEi2hu3F4Wf7Kn2j/v34dm8cnpCrY9xrgo2YYbA52H1Jtsjl+nS31dWxmFkKDfEwHBD0
         Yk5w==
X-Gm-Message-State: AOJu0Yy8oynihNxzjC2VsU1uf4Pz99S5Y1xzLnOSZ9j4GZQ3gtVJsJi6
	DI4s/9aN6aHdUsri+2MP52SCgtMfhsIGKmpfvkBoNY4BN/AZmHSOEuLtNY9797ylk0ijiy3A72/
	r181SIdAOZhI2Bx+GY6/HbZXJcFgdIoGMeg==
X-Gm-Gg: AeBDievyU1TjxDSJqId0nzzZANYJroD1JBqgwXTi3AcBvPW0se/+48lT1C2mvCAi3CJ
	UbjKm/VorkAI5eiTyLAD8iSvp32r7dWirLBmc/eEL4CLMdF08kNHccTVXO7+lnaHsIZEsV9y34r
	I4Uxl/ZbkDYa9j9M+hyXlWxfh+SxyOto7mNgQEdaHy51VsrKdbzbEtsL/7pAUzvo+zI3l0ewS+F
	xHQnHPzx2RL9PPDBJcK+mZNWI2tSGCbsp52RUseyYhf8cdbA3KrjfgjxCp98MHdUDlXAbE667nB
	/s+2REQWwvwNtvGagczpHklFjpy5joDJvjdYpeHkqsZC12pYrs6+
X-Received: by 2002:a05:6102:50a7:b0:601:f85b:efeb with SMTP id
 ada2fe7eead31-616f518b494mr10541352137.9.1776859495916; Wed, 22 Apr 2026
 05:04:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 05:04:54 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 05:04:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeil2Q_Mh_fKCwGa@pks.im>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
 <20260422-refs-fsck-skip-lock-files-v2-1-9607571ae59a@gmail.com> <aeil2Q_Mh_fKCwGa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 05:04:54 -0700
X-Gm-Features: AQROBzCCoTtlwcOFFcttI3g7VwV8v49H2VLWpFC1sbBWE11reoOy_IRMFx3UdPM
Message-ID: <CAOLa=ZT1zE+MLeaYE_5jWmNzSvtTTBw3ZAopai+2Ei27kmYm2g@mail.gmail.com>
Subject: Re: [PATCH v2] refs/files: skip lock files during consistency checks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000012213306500b572b"

--00000000000012213306500b572b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Apr 22, 2026 at 11:49:58AM +0200, Karthik Nayak wrote:
>> Consistency checks in the files reference backend involve two steps:
>>
>> 1. Iterate over all entries within the 'refs/' directory and call
>> `files_fsck_ref()` on each.
>> 2. Iterate over all root refs via `for_each_root_ref()` and call
>> `files_fsck_ref()` on each.
>>
>> `files_fsck_ref()` then runs all fsck checks defined in
>> `fsck_refs_fn[]`. Step 2 goes through the refs API and only sees valid
>> refs, but step 1 iterates the directory directly and will also encounter
>
> Nit, obviously not worth a reroll: maybe do s/will/may/?
>

I thought will would go with 'intermediate' better, but 'may' is the
right choice I guess. Will add it in locally.

>> intermediate '*.lock' files.
>>
>> Currently, `files_fsck_refs_name()`, one of the functions in
>> `fsck_refs_fn[]`, filters out lock files itself. The other function,
>> `files_fsck_refs_content()`, has no such check and would parse the lock
>> file. Any new function added to `fsck_refs_fn[]` would have the same
>> problem.
>>
>> Move the filter up into `files_fsck_refs_dir()`, where the directory
>> iteration happens. Since step 2 cannot produce lock files, this is the
>> only site where the filter is needed, and individual checks no longer
>> have to re-implement it.
>
> Makes sense.
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index b3b0c25f84..1504a1e2f3 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>>  			strbuf_addf(&refname, "worktrees/%s/", wt->id);
>>  		strbuf_addf(&refname, "refs/%s", iter->relative_path);
>>
>> +		filename = basename((char *) iter->path.buf);
>
> Not a new issue, but this cast made me wonder. As it turns out,
> basename(3p) is documented as "may modify the string pointed to by
> path". I assume that this can happen if the path itself ends with a
> slash for example, as in that case the basename should of course not
> include the slash itself. So maybe it modifies the caller-provided path
> directly in that case?
>

I guess it depends on the implementation, the glibc for example doesn't
seem to [1].

> In any case, it shouldn't be much of an issue as we only use this on
> discovered path names, and those cannot contain contain a trailing
> slash.
>
> Patrick

Yeah we should be fine here. Thanks for the review. I'll avoid
re-rolling for now and see if there are other changes needed.

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=string/basename.c;h=1658ba98d3ff89e8257b36219599184866798d0d;hb=refs/heads/master

--00000000000012213306500b572b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5477993b1c68ad7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ub3VXUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2hHQy80NWd2WGYrS1NjVnlWU0tPZ0NJWDZDWjlNdwpseFRjNisyRXl5
aElKRytFZ1ozVjQ2dlM2ejJqR1A1Qzg3WU5mcFdoOHkrbVFWS3cvUVQwc1FjZWcrNGN0REpRCndm
d29sc290Y3UybWU5UnhJT0lkS0JNdFRIWmllNldJM0x0UlY1VklqRzl2cDBrUVNEUGJPY0tudGZy
RHQrQnMKM1FBRlFjOVUxL01iNmI1MldlTk1pZnNHbnkzbDREVW1WVzlUdTd3Vk9saUs4ZGc4QlEw
eFRJby9Cc3laZ2ZjYgpMYVFvQmZZRWg1ZWU4VEljOGh1WVVjeFg2b2txSUtEbmc5VXlhaEwwNFVz
QkFORlhvUnFqYkZDNTNWTExmSUhZCitBWFZkYWlUS2N6MGYxenpNK0VTaVFGUW9mMDEwTWl1NXVa
U0ZFR1FJVzIvRnBoeEJLSnFoWFFRY0dYckQxQ3MKNXVrSVA3YXBCOU1ja2xYZGRhUG9pT3JlOTBH
c0puaUNVSTFSWS9vRWswZmhHb1lSano1U3BhZ1o0SzU2aVl0cQpGWFh0QVFJcGk3ZzBneGE4TkFZ
L0Z4ckhmZTJTdzZVYlR4OWN2WXZvYW5IRmx5emp4TXZZYXcxT0N0UlhOSlJTCnBXMmtvUGhIMGVS
YmMxc1ZIclloQ1Flc1FOYWQ4RTRFRm1IVkNEZz0KPW5BaGcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000012213306500b572b--
