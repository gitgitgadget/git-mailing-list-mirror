Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22990261364
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838516; cv=none; b=NnRkl+C9EsAWg0igrenNObYAV3LekubaQk+uCZdydUkQtX/kQfbYdimJtTKGQbkOA7l6zO3Fii3bWxvIMyp46+Yg3lqUTeVyMBt6Zwzhsq5SCB9yNT1S2zNadHmDfWzBSjy9fgXxgxV3K74ZCgSdwX/DShZ78UVgxcZInjvW3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838516; c=relaxed/simple;
	bh=n8bf4CXei2pEROOJ0xU16z2OnyNcu+m1KrwncMQW52E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4IGrXHSxA871gpBuqhQ5/q3ZSTr3FtcBMbD5Q4udmf0h90Cq0n2SRqSxE9n/cjQNw0Hekzvxi+hx4oShSa6L07SbySE5qPliGELjXh12oEXQTszfbXibNJ06LwZidO1LDdRIpSNZxaEQW6UZ8mUvWLLAYAExaFuNOEdSbR4nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yunjnv+k; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yunjnv+k"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d30c329f2so4525947241.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742838514; x=1743443314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1B484i0ra0RUrZpio1n+UmcEgXNn7tsApDMrSXfLY4=;
        b=Yunjnv+k7luFRgijsiolbQVCWHiQO2nbDr6/GBoTi5TvdW6P6hI1dwDa8q/kTt20Fo
         WI0inUxwGpxHK5BlXIK3erhWKI4Ns+JRsLHngrnCnHJP90vFIDUP3KV17TbhuBgAGUhK
         8jYkBLTdQ4noiWlWecLooPNTOByhRMeVYBy5aCeDjMDC310ExZFEFPBN6siZJVCh9x7E
         ru507awodmu600fV1e10DIuIlMltahHFgrKMg70jyxyFbC5LsrhIVF6ZxKsVorf5a41T
         HNI9jOPPHjZCTaTd0mPVa9GkJVF3eglwL45NJijJZlf5zoxSA175CRHHJ8j214BZe7jx
         LGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838514; x=1743443314;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1B484i0ra0RUrZpio1n+UmcEgXNn7tsApDMrSXfLY4=;
        b=HCa8Gj/ZvB4K2uBAm8RUNlN7r0G1YGC3rUvvdcsIox/km8t7GDVwFDY9j+Hv932mlc
         E8/VhfsdH3YeNzqADjOUhakOmwNRQgjgYCuPrCBHZFCkE0f/RMsne/IHF9YeALuXwpPy
         ZWFDVW0mPa38QOFh0/VGa4JWWP18IXRWXawuV0Em48RsMcVGfJFEfferlbUs3+ei1IJ/
         s5tNDCX0ZLc2kYi3oOX50dakwgqg84tO9RRPhI9/EngGxKODaTmly26kj86ME9gdxVcI
         5ISgsFZWpmzbsN35mMpGiURbsOtYaswuUvx021vwAadXdjOuVRDx6CZjZTKjIW9fXcMb
         LJqw==
X-Gm-Message-State: AOJu0Ywoc3UJ3CwiOrCZr4L8Wf8X83MQaScjHt3SEX3ZGeazWvIVBdHe
	dmDzB3F1K7B2PxyWViY+bmODXWMVHBazCECjDJoL5/dNP5KdWbZm/PVRaQ/SfQHogdOZOgLrB4B
	NH4bh8i70NbcoaWtkEKbvZYXaHVc=
X-Gm-Gg: ASbGnctzvy+NFdSKTWR0cVb7SluxIlrNbf79CdYTh34WOog7lQ9SsPpX+eEAmp6QZa6
	yt5q51A7Eus5B+xaAH2z9ZVBLJZnP3FYAwSuoKBn6Au/gr2pwcurR9tc0IhSCRZN7ER8UUlS2iZ
	Tvw+1qqyR2Zr6OFZFSTr4zUOmyY12PAdc4sc5lR+PXXg2drBI/zrl/A7JKIMg=
X-Google-Smtp-Source: AGHT+IEMdhakeoOGAAUBRj3F8MD1olHw9qTjgsas4peMi2WI2WOCE3zK6YduuCvy1VdrlHAr7XdhpqSlf5qxyPWRCXE=
X-Received: by 2002:a05:6102:3f08:b0:4c3:346:29ef with SMTP id
 ada2fe7eead31-4c50c8eed23mr9163586137.11.1742838513649; Mon, 24 Mar 2025
 10:48:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 17:48:32 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-FZObjvIN-qzvlj@pks.im>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
 <20250320-245-partially-atomic-ref-updates-v4-7-3dcc1b311dc9@gmail.com> <Z-FZObjvIN-qzvlj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 17:48:32 +0000
X-Gm-Features: AQ5f1Jrt9xNt35Cx_c0l6p94f2FRymX7j_Szg7PvHsFT8FWBa3dgumQWfhoAniM
Message-ID: <CAOLa=ZRx8gt=_J2cRFEsUEi31ia7qNL7SZ-WBWuWSyU=8SRt+g@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] refs: support rejection in batch updates during
 F/D checks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000081e6f306311a36f4"

--00000000000081e6f306311a36f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 20, 2025 at 12:44:02PM +0100, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index b34ec198f5..f719046f47 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2540,6 +2540,7 @@ enum ref_transaction_error refs_verify_refnames_av=
ailable(struct ref_store *refs
>>  					  const struct string_list *refnames,
>>  					  const struct string_list *extras,
>>  					  const struct string_list *skip,
>> +					  struct ref_transaction *transaction,
>>  					  unsigned int initial_transaction,
>>  					  struct strbuf *err)
>>  {
>> @@ -2599,12 +2601,26 @@ enum ref_transaction_error refs_verify_refnames_=
available(struct ref_store *refs
>>  			if (!initial_transaction &&
>>  			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
>>  					       &type, &ignore_errno)) {
>> +				if (transaction && ref_transaction_maybe_set_rejected(
>> +					    transaction, *update_idx,
>> +					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
>> +					strset_remove(&dirnames, dirname.buf);
>> +					continue;
>> +				}
>> +
>
> Okay. We have to remove the dirname from `dirnames` again so that the
> next reference that creates a reference in the same directory would also
> be marked as conflicting. It does have the consequence that we now have
> to read the dirname N times again, where N is the number of refs that
> are created below that directory.
>
> We could probably improve this by using another map that contains the
> conflicting names, right?
>

Yes that's definitely possible, I will go ahead and add it!

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index be758ffff5..1d50d4013c 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -864,7 +868,9 @@ static enum ref_transaction_error lock_raw_ref(struc=
t files_ref_store *refs,
>>  		 * make sure there is no existing packed ref that conflicts
>>  		 * with refname. This check is deferred so that we can batch it.
>>  		 */
>> -		string_list_append(refnames_to_check, refname);
>> +		item =3D string_list_append(refnames_to_check, refname);
>> +		item->util =3D xmalloc(sizeof(update_idx));
>> +		memcpy(item->util, &update_idx, sizeof(update_idx));
>>  	}
>>
>>  	ret =3D 0;
>
> Hm, so we have to allocate the `util` field now to store the update
> index, which is a bit unfortunate because all of this is part of the hot
> loop. We cannot store a direct pointer though because the array of
> updates may be reallocated, which would invalidate any pointers pointing
> into the array.
>

Yes, your inference is on point.

> I was wondering whether we could abuse an `uintptr_t` and use it to
> store the update index as a pointer. It does feel somewhat dirty though.
>

We can do something like this, it would be _clever_ but does feel very
hacky.

I did so some benchmarking here

Benchmark 1: update-ref: create many refs (refformat =3D files, refcount
=3D 100000, revision =3D master)
  Time (mean =C2=B1 =CF=83):      7.396 s =C2=B1  0.175 s    [User: 0.962 s=
, System: 6.312 s]
  Range (min =E2=80=A6 max):    7.145 s =E2=80=A6  7.688 s    10 runs

Benchmark 2: update-ref: create many refs (refformat =3D files, refcount
=3D 100000, revision =3D b4/245-partially-atomic-ref-updates)
  Time (mean =C2=B1 =CF=83):      7.514 s =C2=B1  0.144 s    [User: 0.919 s=
, System: 6.438 s]
  Range (min =E2=80=A6 max):    7.297 s =E2=80=A6  7.750 s    10 runs

Summary
  update-ref: create many refs (refformat =3D files, refcount =3D 100000,
revision =3D master) ran
    1.02 =C2=B1 0.03 times faster than update-ref: create many refs
(refformat =3D files, refcount =3D 100000, revision =3D
b4/245-partially-atomic-ref-updates)

Overall the perf degradation is very minimal. I also looked at the
flamegraph to see if there is something. But most of the time seems to
be spent in IO (reading refs and creating locks).

So I think we should be ok here, wdyt?

> Patrick

--00000000000081e6f306311a36f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 230ce1955dc4da32_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maG11OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNE5rQy85dG5QTmk0c1lIVVlNZE5zTXl5M1MyZnpWUgpiNlVPZk1tWGNO
eU5ERHlLVzBESDYyTkxSSFpxeUduMkZPWEdZZU9sNVpQYlk2RXNtUDdHS0dnN1RBRnVPcktKCkNG
b2ZwM0xtWGxtTUZ3VG9HT3FuZFM0bE9NbTZpenR5ZWtKU3J3ZFlOdDl1NGtvUXNSYWgzNGhpWSs1
Mk02YWcKWGFxOVg0dGRrbnNXdSt1blhhbUdXcFRlbHFLN3lvWVdxa0JwSlJmTGVIS01oMjE0ZWVO
eUhSS1VlQldzdUU1WAoydE85UHhaWFJTM2lSZm1Zejc3alYvdEhwckJ1NFd1M1l3KzZKUUQ5L0Yx
Q0J1NVMwV1ZFU0NSdTdrS1hVNzlECmQzL0lWUkpKQXhzQk1yNDZQaFZQTDlpMmtKNXYwMjdMUERE
L2JpMkg0RHh5bklzUDAwWjlRQmdiRzdkQTRhZW4Kci9uY1N1dkt2TERUbGN3NVVSNWhjTXd3cjVn
Wjc5T09Bd29oYWg4QnQxeVVDblFZSEFBME0rb1BsTGdvekIwdApCdXB3VGRjbmZKOTU0N1JOZ2N5
RGIxR1l1OExGMkxXamRQSWJmU2pnaldvcG5uTzRZQWRybk5ZcHZRcnQ1RGZyCnBOSUg1c1d1Nllx
L0t5dHJGV25taXFSdGNEZjVnb2htaGVxUWlHYz0KPXFQa2IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000081e6f306311a36f4--
