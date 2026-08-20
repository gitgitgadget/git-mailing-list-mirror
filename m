Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8C47FB0C
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260277; cv=pass; b=CtJQWDB8ZSaSV14m9XzUh2+3ABsA6/+XSfa0+skQaBbNHpjkXEk8LJOy7k5kVc8+BDrqdWmFysFXk/2S3igqTpEXWALq3oOlD9g+z5rkoD+ECUoiZ9qYvJM5A0sa8Ejhaw1fj7ZK6UrQm2xMeoxrWmVpOr4Z61bAAglQ3LvtTfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260277; c=relaxed/simple;
	bh=KRshHIprTPf4/Hb/8rtJIeIDHDpKBZFh1QWAockvtPc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBHqRcxVSJSnOrHxm88FezSAsgcF1o//7x6uoHFqQleDTqqKDYULNqi6DhG1Z7VhH7wYwXmglcvOaLeMy0FGjbQREYkF7ZEiNBJpifeqva8U7o5feBwG9SK1t1IrY1by8tcBGV1f875HCUoMFuULO1q/ffXpaDsPbZdyn45sILk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpPQVfI0; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpPQVfI0"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74dceb46291so187702137.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787260275; cv=none;
        d=google.com; s=arc-20260327;
        b=gYzzQbuK6GckAuirFaFWR+65azFd4mLAmisi2CvEjBw35ZfGnMQknpdvWf+jr28aok
         Xx6tnBTK2LkxaXL+kpR9ITQWOTUdWXfAJfR5YlfhZLXuzvM08BppAA4VxAhnmoOnu5Fw
         1CKwo8DgVmtu5VRC/kBDGVfS3hhlre73uWbzyS+y2Q0zzZAFGjR68WQPMxfSs5ae7RPT
         2oJZZkECAttPzSt6lywBh0gmiJS4d1LoURWSFhrtZcQ1K/mYW/LIX5ymYnx3D/gpgNqb
         sn8Z/kY9JtkNskBQm2TGeS4tfEEkqB+XMycry7eHX5U+ZrPPXNm758LsbnaGp8lEfdYH
         BXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=t6yyWCqwLcTfW2XcYlAXbHpXij+I5v1RfFIUTUAPMvw=;
        fh=j3Oq9jCRJi2io/yemcD2h0y6lPceAaCOj7UoSpvdJbg=;
        b=duX1EVD7GekW/hsUwY89mj8Mah5kYY2qbECC850msPA1kl7MT1zYzhG8s2grrDY8Wa
         0A5M/dTVdc5oSBLmyk/M+gpdxcEkQacCESWE2RpWUdD9/MPbujmHft9/nvtvPZVc1v9Y
         /fRV9+co7HQwWw+COfsGDMzGmdcjfoexOzAQDg9A+EbCoAtBFQV9jwX0lJgA6Uk0g5YZ
         lSwPbAlKeJr9YhHoH7H4Tp8Ecr2qpELR2VTJqJxn5k0DSDeY9dKO8OeqSS23gJtD5aZu
         4AIvgTVTzyg8MO0r29OVo8xbXwwysAS6kQQZ9V1qOZDEke2PsoHZcA9MqNMkIQQHQEHX
         a6ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260275; x=1787865075; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6yyWCqwLcTfW2XcYlAXbHpXij+I5v1RfFIUTUAPMvw=;
        b=PpPQVfI0P3mhVxp6SSbFBAsvIQgVKDUkKW2PQRYObGBE/aq70+EP796cvhs9u2rh2l
         wNdi9wSY+78z/6QFrHnayuUgDNKIQ1XwDKQR4Rvz265K1mgKhsYWUF7huFnqXBo2SIda
         fLQHyBdK7d+yHiyqJIBR8fyZACEWmW0+HcwuzJ951GTLg0K/wBEwFUiFi1/syTG5zgcY
         oPD1h3E15wGohcN0rk+bhPk/TbBeQWJPL1Yy9LKa/SM99pOdD7n5+aoKTmBymKLdO/Tz
         Gg0h0UWhcfg3igQoFDLDoSbcvUeXpPJY5E9qKxLh5YcfiTjcFvnlI+KvG4IJVDxeJ83m
         xY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260275; x=1787865075;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t6yyWCqwLcTfW2XcYlAXbHpXij+I5v1RfFIUTUAPMvw=;
        b=n7s9hWot2PXkchh5+TdwNZRxyWjEb5WTQ3YREm/cNSilFwS43wA7uCdqgUGDJdt3L6
         PWy4NuGhwYo5/Mw3AUIgqonlA6PTesQhaDkf8ojhOFLhWWBRWn6Yv3aPGg8SK/AsbPjS
         32AZfFhYqYx6a67deXpjqDaRwd9oOaHmpiVZq9yDXVfkm/1edobNY8SgiYxvHemkdXcE
         5xuR9d61SGRM/1w3KDJiBWp5Y6Uzhr+7SNhHNGxw6dbchm7JSbFIH4UzjuDurITLrVaU
         7mA0OWOcfTD9oJcVMx0/OQTjGqcMJDhNviojx+m6taJ2hkqO9GeQW+B/DOnqx0K3NjUn
         D8pw==
X-Gm-Message-State: AFuF++nL0tcijAe3BaJMIVFTlN6GIIuwyODb6FP6I2OYWDYKrtkSgXk2
	vPmc4nfNbjHnjLYhlc4RRF/r/84ZFKmAFeh6A9YOtDYs15rF/ETk6lfis3UC1G6C3dKxA/15CAX
	zBtlj3/spglQTsmbWl/nth8m83K8S+36vK4RQ
X-Gm-Gg: AR+sD13v4HB5loc802sdGNr3lKNkG5a+6c2naNnMCm74a4FPC/O+9k8mvEG5ac2crHc
	doQhdEnOrauRWpM6mtVSgZZn8es1VrqdHiq2H8cAFKkwRo0jwW7Ni0szUI4KqUcSpT7ycw1OneM
	NzFra2zJ8wtgC80wSlf061fogmcTCkDftr4yir7vIbWlbd/A7sKD6gWVBqM5sWGJjbSh4VgIdxM
	2R8Ej2AEN3WKRWcG5mqk/c0+uaklBa/hBoj/BEMoRIW2e17t9/bV0T3BKt0su9928xTiOmLvkSZ
	hUtyRHaZhSDKa+R+SfjBeFKOVoOQlb4NEUPpm4rmGRBUEDdcitUJuGe7QF52YOUS/VladQSYsZY
	3BzxDJz4/GvlaiAQjEAGWmBi7yEdW8mkptMh2
X-Received: by 2002:a05:6102:5089:b0:778:9439:b3b1 with SMTP id
 ada2fe7eead31-77a62223a09mr913644137.1.1787260274876; Thu, 20 Aug 2026
 14:11:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 17:11:13 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 17:11:13 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aobnT6mmINHBmV4g@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
 <20260820-b4-pks-odb-generate-pack-v3-2-bc42252f6169@pks.im>
 <CAOLa=ZQcZ93R6wRyDiQtyATBNfj_6Eu0zXtEx7kbfzihvyP5qg@mail.gmail.com> <aobnT6mmINHBmV4g@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 17:11:13 -0400
X-Gm-Features: AcwNN1Wz6hvlMt3T23W3BrPcV1TXpI8Q2R6Nux258gyM_Ip-zpBgvMuBrXVGuWc
Message-ID: <CAOLa=ZQLEg-Ufo0QUEpf2sxuJ=G=8zvT1+deDg7JzxNQTQivLg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] upload-pack: generate packfiles via the object database
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ce5bd0065980f567"

--000000000000ce5bd0065980f567
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 20, 2026 at 06:24:09AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > When serving a fetch, git-upload-pack(1) spawns git-pack-objects(1)
>> > directly to generate the packfile that gets sent to the client. This
>> > hard-codes the assumption that the object database is able to serve
>> > packfiles via git-pack-objects(1), which is specific to the "files"
>> > backend.
>> >
>>
>> Naive question, the previous patch says that only the primary odb source
>> will be used to generate the packfile and we added the implementation
>> for the files backend.
>>
>> Does this mean that this will only work if the files backend is the
>> primary backend?
>
> The primary backend is the one that will generate packs in the first
> place. For now, the only primary backend that we ever have is the
> "files" backend. But if we ever add a different backend then that would
> of course implement its own implementation for generating packs.
>
> So at the status quo: yes, but with the added infrastructure it's now
> pluggable and can be implemented by other backends, too.
>

Okay that makes sense. Thanks!

>> > diff --git a/upload-pack.c b/upload-pack.c
>> > index a52856d869..75a857eaa8 100644
>> > --- a/upload-pack.c
>> > +++ b/upload-pack.c
> [snip]
>> > +	if (odb_generate_pack(the_repository->objects, &generator, &opts))
>> > +		die("git upload-pack: unable to fork git-pack-objects");
>>
>> Nit: should we still talk about 'forking' here? As far as upload-pack is
>> considered, it handed over the task to the odb, 'forking' is an internal
>> implementation detail.
>
> Fair, we should probably just say "unable to pack objects" here.
>
> Patrick

--000000000000ce5bd0065980f567
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dacf88d0ba0b81cf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSGJXOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHo4Qy85L2ZBdG5SazRPdmFkUlFtTHNZWld3VkdxSgo5UGtKRjFQYnpU
Q1g5U1pWRFE4MTVuYlVJbmRHTlJzVkN0Q1UxSzZ4VmRvRFRsUCtXN1VPUDdQcmxTckd1MGgyCkhM
L0FzUjkxaEplOTFTNnIra0I4dEFMcTREUThZSURjUlNjcy9rdkp3VGtET0s1QUxkREhwMDVGWnRa
UDhtN1gKamtNZm9sNkNEcjVIL3Nkb1BZaXpXY0paZHZKMXJocXZBL3hJZzkwN3dCL00xNEJmVHRY
bkdZTm5SMVlVNEVDZgpkTFNyYmR1UWlyZzZ6S01rVGV0L1V0Q0Ewa0hEYWhXOFdyNnRJOWdOZWg2
RXF0M0ZHenY1dHBreUUyY2hXTC9uClZocTZjd2g2NHNjYTNoR0RoM0hFSUt3Rnk4ejJ4ZVV5QVNm
QzdhMHNzbjg2a3FtTHVDbzBjVE0zVHhtUXROeWsKYTlmVXg2T1pnWm5kSWZ3dUhOTzdtdVJ1OTBw
bUY3MmJFZ0VuckIvQmYwRDh1YVlCY054SEpxcjMzL3JHV214QgpqZG1DTXdlS3g1TWhoRWxUckY3
NEpRK0s2Q1YzbjdUODgvTDhmZmpEODdoRFpzbFQzU0dXUlp1UTlYMHVaK0RTCitjK2gyTU1YamZ2
emk3RUFEU0UzNzAzb3d4ZTh1UFhMWUtyd0R2QT0KPVB6aWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ce5bd0065980f567--
