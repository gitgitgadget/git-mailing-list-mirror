Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1D367F21
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776787447; cv=pass; b=HRzhIJUcRopBE3tVw7X6xwfdQb6nk5PkLelu2N2cExg1K2uivKC4i5WPCK0e278q93d8cwifYDYXSMFemOUIqcVenTfQW4i+6y9MlnhLu2rlqNXY60zemBfA7qZ0bi2yQG1/SCjrJ1+TRpO37vNlEOwzDLwXwjlo+9tCFAjkJyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776787447; c=relaxed/simple;
	bh=4f0+f/Zf+jYXEc3p/GHHvLWbpnk48AL8CPppAxT4eAQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdtAxEVTrDSna4ljVPyvFF/inJvFmyU2kRXb+ohimC61anit54lUY2bsGcPRPBHNSxp1xkYjla54nSQW9NJQ+0cD6xBLicaPfMJY4NELwQIVAb3a8CFY+M0RVt/3lQnyNJ3vurL2jnZ5wbYIEnUhwDHMPK03NSqhmrNADLsOMng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9iA3RN6; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9iA3RN6"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-61399bdd395so1404494137.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 09:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776787445; cv=none;
        d=google.com; s=arc-20240605;
        b=eOKtnLr+NgNDqnrCk8gVA/kv2zaWFcCBBe/4yrc+HZti4xQHJ0jfdQFmuVyJUk1EZg
         Q7ykyGavWAn5jshFM1U0q/ytL+OLJElDvMmpcVJK3LTl57WfLXgANXLIDSx8AZ5gqgJr
         5xqjLWqsf+PA/kLtoRaZmJFHG1XiT0BRbO7Al6YettKmVYFzpCcZ38GBCNqriETLH2Wb
         oT9+r5gCNObMKi/5iELCXqxzSgPES1ljt7OEMl1JTG/TRTKLAzhFvh8GIqxAKbslyA+c
         HmSoUtXrmhH3nLXaaAEhcMaE+4usSz3N5sij4wQQ75kOCm+gXXpG1B0LvGCfGnPKyVwr
         Qr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QddbIskh4OdWOlYrP4j24AlqrBwt8Qdu2X5SBfFupgo=;
        fh=cOxbKG8AeF+aLUK9mjYpQk/iVEAL40kEniqv1xdBC+E=;
        b=fbMWxImx61KImtMFVhKC6zOTs2k+ezSFVtZoxYng4wsfZcf53SNoxhbX7Ng0HIbI+s
         E+lsOf6R2S94rNeG9yG+LBQkmoq6hhtnBq2H7FvgoDSZ17Hb4dMWSRlkmjAAak72v2u9
         y7J1thdyWlrMUEeoIozl5q6VLRTMfj9vsrTnwMpja+U+aSg54/YgEnqsX0QGdOCiY6qI
         X+qEzVC27hsCgseMikDq70c0k/apF3HlCFmB0uNtHmTcSyrsA81JPYmKdJQMeOUdlgpq
         vk9R65cFO0iIdH8f5ZOxpqIck1EYVi4Kqk0CrigRBiZuz4LsGPM5C/L8lr20cMEP9o4N
         1TbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776787445; x=1777392245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QddbIskh4OdWOlYrP4j24AlqrBwt8Qdu2X5SBfFupgo=;
        b=F9iA3RN6NgaaokGd3quO9Bmr2P1JXnVBZYHa2C/NLgkDqCLV7HBxhBiv4WeUDIBH25
         Vv66eHoMvm0i7rJuM3Nia/HKsg3dj2pqRdRf/+5EFbpCAaPyhSlJhtQ0eZgrxchDn+PO
         3hZTkPSNSabm82TlPmNoW6wtPZy4bmNiMWV2U8ytEk9vuaBgzf8V+1abArBHWOVRMx4b
         Mft0swwssEc3EKwQHxpiziHVtWRm/mTISlbgEq5FpZmC1dq7Idmo0T6o0fuTJZz7tp9n
         1d6gE4bv57vMjsiY2b+fRgTENw54nhiANdsexNBJh7tzfgOGvXtGP7xEqJrmNwrpnrLh
         49uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776787445; x=1777392245;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QddbIskh4OdWOlYrP4j24AlqrBwt8Qdu2X5SBfFupgo=;
        b=mLL1bzKp6OyFc+QhPkZCNsFO1s9/g1FRCwD23YMEMSvORn5BWpzbERU7pk30pjytwq
         YZ7hWUbGl+LWzRVOP4zy/CEovyxSU50/CzykI9cmJmQ/KbzsC+r4UaYbrSeOWhR3YA3o
         RrMzreqAKtwUaGcxuQSJCLZnykFIT/sLsG9pNm4QtfuUc3lx69d1FOmAd7eb4RqepHBT
         xUoEv3BMeAuyvmJNKFfi8FgbUtvybcS5an07ySefxWYefMZUFaWby5Lc4rMzVO0q546L
         Dt2w1CcXES7dsAPkUPd9KIXS8Cxvf1louh05qYWT9xTPDm/klz2vaNx6NinLpH15gwsc
         XdqQ==
X-Gm-Message-State: AOJu0YwPBsgGWSnzDuJb2aWfaIWQXKCzx5aU3XMoBp93lZMKZkUh8x8A
	jnejmNnDBJQLf+m31us0qjywWLUBcBmuyx+Zzg+zGd6n0yuKn885ioRrEbMuILXmg7ll29SrPtC
	l8MDbrcRVCGdebHp+rwhG1s4HFvyGiqU=
X-Gm-Gg: AeBDieuV8s3y2pQ7P/FXGpHO6OViIftI/mygK0ihGdIfB52sI3f3yuVZtGnDIuqblvm
	L7KNL/74kdwr10VXyOQDb0jM9JpqpEDS98EdNM38gALIC9Ou32BKKimNMZbFh/ztAe0MjT/zh76
	bWStqyfNf92bnbarqwdDRzW+GkVD8yTBkMGDK2fy9Xx2bYW2i7TwUZKIaoM+4im8cPbBDlFRFwT
	H0upd+PSgE1C+00WwlHhWXjWVPutcgRlfCz2wC72rni3AIx1yYYGITzMafP6B29jko2MMsoyjKP
	QiRkryLNdbe3OSq6
X-Received: by 2002:a67:e111:0:b0:60c:fe65:7dbd with SMTP id
 ada2fe7eead31-616f4741f51mr8067233137.5.1776787444322; Tue, 21 Apr 2026
 09:04:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Apr 2026 09:04:03 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Apr 2026 09:04:03 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZSj_fmDNo5bgtYeRs0piCq+QR4aydDtRsqK19nPnDFvbw@mail.gmail.com>
References: <20260420-refs-fsck-skip-lock-files-v1-1-c2595e206a76@gmail.com>
 <CAP8UFD2vO415UfEUw34_Whh3bTG0ECV99APH=uaDyiGLiNq1yw@mail.gmail.com> <CAOLa=ZSj_fmDNo5bgtYeRs0piCq+QR4aydDtRsqK19nPnDFvbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Apr 2026 09:04:03 -0700
X-Gm-Features: AQROBzCD7qBo5cSJVEl5twDCJj-Ed0PSLGI6L9DCNTbAyWmi4Qn9SuVi0MV0FNg
Message-ID: <CAOLa=ZSZ=fFCjXt6bM3vojjtY+1imjbw5a7FASnGnDrPYoaBgA@mail.gmail.com>
Subject: Re: [PATCH] refs/files: skip lock files during consistency checks
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000075ecb2064ffa907b"

--00000000000075ecb2064ffa907b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Apr 20, 2026 at 5:21=E2=80=AFPM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>>
>>> @@ -3962,6 +3953,15 @@ static int files_fsck_refs_dir(struct ref_store =
*ref_store,
>>>                         strbuf_addf(&refname, "worktrees/%s/", wt->id);
>>>                 strbuf_addf(&refname, "refs/%s", iter->relative_path);
>>>
>>> +               filename =3D basename((char *) iter->path.buf);
>>> +
>>> +               /*
>>> +                * Ignore the files ending with ".lock" as they may be =
lock files
>>> +                * However, do not allow bare ".lock" files.
>>> +                */
>>> +               if (filename[0] !=3D '.' && ends_with(filename, ".lock"=
))
>>> +                       continue;
>>> +
>>>                 if (files_fsck_ref(ref_store, o, refname.buf,
>>>                                    iter->path.buf, iter->st.st_mode) < =
0)
>>>                         ret =3D -1;
>>
>> This just moves code and associated comments, so the following are
>> probably pre-existing issues, but still it seems to me that:
>>
>> - "do not allow" is not quite what is actually done. There is no ret =3D
>> -1 set for example, so if files_fsck_ref() succeeds with the ".lock"
>> file it could be allowed, or I am missing something?
>>
>
> The intent was the same before too, we didn't want to ignore bare
> '.lock' files. Then, we raised an error and we'll do the same now. 'do
> not allow' is a bit confusing though, will amend it.
>
>> - a filename like ".stuff.lock" would be treated in the same way as
>> ".lock". I wonder if it's what we want.
>>
>
> Good catch, we only want to ignore reference lock files, these are files
> which have a preceding text before the '.lock' text. We could simply
> check the strlen of the path instead.
>

Actually I'm wrong, the check is correct, since any refname starting
with a '.' is considered incorrect so we do want to report such refs.

--00000000000075ecb2064ffa907b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4ad1b725dfd8a53c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ubm4vRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUx6Qy85OXJ0NXJyeVdLckdvdkgxZisweThoeitTbAo2MjVrRkdZSDRI
dmQwb1A1STZIQUp5ejFpeWFYTnpGU0FtelpXSXR2TWlzdU5PTmhTeGR0L1pGUXhnNnpydEt5Cnh5
OUJaQ3I3Q043cUtmNWxYRTN4eWFGTlZib3pmNFhVYmlJYnZHWkdkV3FJQjhyd1RSTXhENnRqbXVN
ZDMrbEsKMWJFMlZGblppVm1vMzFWVE9Ld011SFExU3JJczR1SFdSUk1VZW9lUW9WUXV2cHdlNjVD
c09zWC9pTWwxL3Y4LwpkVGVqaExGczNhd1JON0F2MnNvcHJWNHFvbko3b2piamZCWW1nWFNQb1JJ
a3lLWUZkTW14Vm1ibm1JNnZZeEwyCmhGMHlvL1JHZ3hpeVRKTHBmdE10ckpEL2swbUw3dUppSzdr
M2tDZDJDei9DY1RWWGNiQ1k4S0VDdFFLd2U4c2cKZWc2ZnloMzRBdjdmaVUxc08xQW0wRSthOG94
TDlpajBReEtsa0dkb1I3K2pXSHJFaGhBQmttdFhnRnJSRDJkTApKczE5SER6QlZ6NzFnaVkzZ29w
M1lZb3VPTnRsTFYwSzZXR1ZEa1krRXZJc0hJRWdLdEdxTVJHSWo4RFdMQTJ1Cit0MlBxbU9hY1pQ
c1NUcUpvNVJjK1ZhRjNGMGRLYTJSNnlrSzR5RT0KPWpQenoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000075ecb2064ffa907b--
