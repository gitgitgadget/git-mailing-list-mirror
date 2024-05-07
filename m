Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CA15F416
	for <git@vger.kernel.org>; Tue,  7 May 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089034; cv=none; b=Rmm+5z+rkDU80mcktgSj4A/J8K7w7DevfQdn0QjFSGrH1SAyWK7ZY8IV6wiDOy06TmZkYlsAMhGtmwoOtNNrZv2du7gRuEAKDvcqn/gQoizwHZilOb9FWICGQiaIahUigXI1cJxix7ppHbMZCZJj2xyq85gpaTdlr+zA94gdDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089034; c=relaxed/simple;
	bh=4R1mLIvdn5LH9Ns1ZyFon7SlkshNsr4Ig++rFQphngA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxuRDvm1vIU+cISMnvOn1wEK2QM2x2VbWjkWoQJfLKQfWKWU6sUw1gLpqcMBBzqUdMzYKarpr2+xChi0dB1TG+NzAw1uBPfpnW6ISQ8NyvGdy9eJyq7Sb/DTWQZlOquo0C8wpzCBjDJGUAOuIY8L/P3Ux8u4RCetkCUZGRLS8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZrYdKVp; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZrYdKVp"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23f9c2f1df6so1294407fac.2
        for <git@vger.kernel.org>; Tue, 07 May 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715089029; x=1715693829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=x26qugptdrV0Il6VqFWNwJ0gYHSC8QXMPROp1Kef0KE=;
        b=hZrYdKVpl5DSVmf8m38vXX3NZrpI06EFnzcPMPBJ0Nbxq00vpi2bKS4kJEni2KScjS
         zjSZZE1JkS+cLKiZ9+N45G4+MOH8vCG8qtsWpthrgsfa3yDBmqNP/VrisKrMBii2C8ta
         CWnAHMyLmSRpL56GDcWlb3V3sS+RVJzaZa2DpRYeP41jtCHfVK+nEsDwWIYujuRDDq11
         rvKszvCRdiXH9UahLXAChZ3ZARNXcHZzhVSujczj2uWbfFVSUjMNKkayaLcMUbPVW6TQ
         GT21I35Jlm3e4hCwfvUZnvpEC67MEesA+l+cLL2bbr3I4QjkN3N3klzcAafVRll/LwDg
         gfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089029; x=1715693829;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x26qugptdrV0Il6VqFWNwJ0gYHSC8QXMPROp1Kef0KE=;
        b=CJKsxFG7tUe6VUcLz+Cir/u4xiILMiYtn8YdBCSuRFsnUtvoej1f9iobJonzi7Gk/e
         i6gz69mo4W5F6if2qCrVt91IkVntDI6txuiHzerv3SPw9w+S1gQNdsnx8KVesZosaaDc
         EmmYsTDxt7OqXBwc77dfmXzK4Rfcdn188vNZc8VhyqFIJtvNo2bu2RlJn/RFj8fA/DsH
         sAz4LPohoitA8xZvTTojR5tCxkD1tUFS2779o1OCQmhPZIRtVEriKFoJlzxBZWjvHIbj
         gpMRLwiKyVFF+l5dZkDtHsYy8vn4X9geJVwIyZGdqICQCndyszyj6cPdQ1FyCuHScWIq
         8OEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuZRYcZ/HxWvrFC2SsnWnSgr31/X+Exi25w99OmPih6ranksmY2HZ5cPDX87Oi3zZoSsYTGiQPHOfcRHnhYZl5YND/
X-Gm-Message-State: AOJu0Yx5ReUjDco5oyeZDJ61HaEvkCCB7wIjLOhMTWbNCl8RFyv5krbn
	XnqrZzmaIKc+KfeXVPuNhcjCBVEZeqVp8HjMH5tnyCSzfasgCk2LUYmZRwrjHAFk8heKqMDF+Yt
	V1e8U6o07P+/eSuh7spdDeY/oDxQ=
X-Google-Smtp-Source: AGHT+IHqf9IBC13rXy3OElFkMnqmCwDa7M4tbT3zuL/02/45laFcxyNm5dDP419FVm2yt0rejxwX0fm5l4QapAeRb0E=
X-Received: by 2002:a05:6871:4006:b0:22e:7ba2:ced4 with SMTP id
 kx6-20020a056871400600b0022e7ba2ced4mr16595296oab.18.1715089029481; Tue, 07
 May 2024 06:37:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 May 2024 06:37:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+WCWMyxBA90QRsxn-i0H1TRi7WrhRcD=Tgj07f_Y_=UVNkhbw@mail.gmail.com>
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
 <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
 <CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com>
 <xmqqttjaydbw.fsf@gitster.g> <CA+WCWMyxBA90QRsxn-i0H1TRi7WrhRcD=Tgj07f_Y_=UVNkhbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 May 2024 06:37:08 -0700
Message-ID: <CAOLa=ZTu1to4HRc8sD2BcA+1ZzgcnXW9nHb1gg_VEG=nLOjHvg@mail.gmail.com>
Subject: Re: [PATCH v3] refs: return conflict error when checking packed refs
To: Ivan Tse <ivan.tse1@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000005c65290617dd4810"

--0000000000005c65290617dd4810
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ivan,

Ivan Tse <ivan.tse1@gmail.com> writes:

> On Mon, May 6, 2024 at 3:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> >> index a098d14ea00..97473f377d1 100644
>> >> --- a/refs/files-backend.c
>> >> +++ b/refs/files-backend.c
>> >> @@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *=
refs,
>> >>               */
>> >>              if (refs_verify_refname_available(
>> >>                                  refs->packed_ref_store, refname,
>> >> -                                extras, NULL, err))
>> >> +                                extras, NULL, err)) {
>> >> +                    ret =3D TRANSACTION_NAME_CONFLICT;
>> >>                      goto error_return;
>> >> +            }
>> >>      }
>> >>
>> >>      ret =3D 0;
>> >>
>> >
>> > Shouldn't we also do this change in `lock_ref_oid_basic` where we gath=
er
>> > the same lock again for creating the reflog entry?
>>
>> An interesting question.
>
> Hi!
>
> Apologies but I'm not sure I follow - could you elaborate? I am not
> too familiar with the Git source code (or C language) but from looking
> at `lock_ref_oid_basic`, it looks like that function returns a lock
> struct and not an integer success/error code. I'm not sure how we
> would apply this change in that function as well?

That's correct, my question was merely that we also have a
`refs_verify_refname_available` function call there and was wondering if
we somehow need to catch and propagate the same error from there. Like
you mentioned the way it is currently structured doesn't make that
possible.

--0000000000005c65290617dd4810
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8303aa5579b9efeb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNkxvSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0ZqQy85a2ZVMDhBWHZyaHNZUlFxSVZXQ2krNXV2UApwbFV6YUZtME1k
RUpQaW8yWE01WkJPTG0rZlkxVEcyc2V2N24vZHRDY1NyRWxncHZGcG5EUVc1S2NHUmc1Q29JCnk0
RGZLQ2xsQVZlYzhhK0xCSDdjVE9yN0ovaVQ5S2dVOEZaYUtPamNpWWYzM0RDU3NiaXE4ZjJFY2lx
cHNFT0EKMlVnUUM3UzdPQjBBS1o5MVVteFdhd0ExbTh3QzI3WjYvWEkrZ2E1UEV1NVFTTUlqK2N6
MU9vOVBsTURZUy9IOApTampzSWpYSUw3M0w4Q094Z0ZCam1CNzhDOU9rYWJYMGN6eFNtemZJancr
enAyZlZKZHpoYzFkSFcralNsTFFyCkJWMXVjRGY5VnYxcUp0RnI2U3ROeHYvditCUG8xdEgweGVE
MlQxekFNaytRTm5VbE1RR1d5LzI4NitWMy90NWYKaWFsUThYL29MRVlPekFnTWxWeTROUS91VUtV
T290WThnUWNRQmxJeXJrVnJZeVM5aStFRkxQZW54Nm90bWxZdwpvdlN6YldTZzFvVXNzNzZHVVNi
eDMwdjZmMGlMSnFzemFmUDQ3ZUh2eGozdFRmUXVyN1Z4cWJaVEoxSlVTakFjCnFLNzZiK3JxUXpL
Z2MrWis3T09McVB6bWNpQi9VakJTWjRZR1RFMD0KPVNldW0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005c65290617dd4810--
