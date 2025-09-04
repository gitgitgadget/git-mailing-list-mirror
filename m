Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B927FB28
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017486; cv=none; b=RibuorhdQujBFYZKT9m2vs8srgYfptseRYwOjnlz8Sas96/Xz9LsrRXvgHMcYsWccLBYDfPuYiv1UUtQz3vTgkhf28TWbnQwCMY4LJ8STeQYQo/VrwVQE60G/nJyJAm/T831piwFTOBKI7IKtrgAgmOTxY+edAZUq/B70P3D60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017486; c=relaxed/simple;
	bh=PUp4bqzWRK1a3QfSd7F1KwoMUZYLd4W9cGv/cO0pvAE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJdNyuiDARvzshHuTRl6u/OtAXjJPSfu3oFW+nRsMitiQh0BUJ+Piz7fS8/viJdGNbdESsADZOpWVTtNUXaxeE4Jn3tWYGrmG0u2EGJi9Dr+NGIDtzXs3gtbb1T/q2alIaClJsQAnRgaaMAlWcaqVbK39oSXXJlhkuM85wFz9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzmgWRSp; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzmgWRSp"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544c620d486so1050735e0c.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017484; x=1757622284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUp4bqzWRK1a3QfSd7F1KwoMUZYLd4W9cGv/cO0pvAE=;
        b=GzmgWRSpnnLVBUjwKXIg8cTQVdZ2UjN0Xitss3FbK8aYOGUQAomiwR6rF55tB1WsoD
         Zoi0yaBy0PrpW7CweLbOeYT9Sp2CUofp2LbmBAgF2e3aJkDPce72oxA/zKH6wDoAB6ij
         zE+3kNt/+ydZ3mwhHp6c+94aPNlK05RRppion+PLBuGfCKINlom9fP1hA5vPqFabFsUn
         QaCpUbY3GnwS2djXsUAJzej0PpQN5OgO9+W46rYlROiHmmPK9p68BZKBDU/gR6Fe62xA
         nslDNhz4pFOYA74sdlJmx33dCSxFHs3RYE9UfhvZ9LUXJxK5QLMSzDPSHpv2vpHIkk3E
         yMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017484; x=1757622284;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUp4bqzWRK1a3QfSd7F1KwoMUZYLd4W9cGv/cO0pvAE=;
        b=LLT6phkfdyZFOdexAO3WKO3sIBN3EFZ6Bn4TK9YtehzPuxS7BMe8v14miCeL4u5ITp
         iT62SmK998pKlAINTgtRsjFPTfc/lsPOkUKedfZcOAP17WdGMXTUM7x3Cb3qXerOVzrI
         YvlkC8s8HyxABuIg9r9MX1/wO3GY/23okX3RL5AZzRCcBrYc4HiF2WfrGuHQILU0X7DT
         RmfPO1eHr3jxXkdAC8ZRfrGXGc5QbLsFwNkj2E6WICeaKwbG75u61Td1Ve4b0uKTaVCq
         vHjWQyGbw3FxiTFVhXhu1iTL9spx0UTIXmBi2B+ua21mKYfve55e1ICb1uOT45+isnyU
         adBA==
X-Gm-Message-State: AOJu0YypQQJiLIrzMkNylIm2Lsv5QmulmPswk6Uwzfmeefqenbjz7x0X
	9C4s2OkpuGSfeGnXfdTi2cqt/dqVUxY/AMUaTYJj5KDmiDPvMpnmET353D0xlIdpsK+dG5mQ0tM
	SjVayHYoLp6RewBPDz+nh96G+PIUsqMI=
X-Gm-Gg: ASbGncud566BYyG9xEubF44moXANAqTPk5lT3eqV6JiX3uQ6by8TYcvdQAdr3ta2N0Z
	XcUTfUo1LZ/V0L7cpFeEWV/rqkZXyyq+fxG64MhhLtdtx03fM1wouz+CYeo50x2AVf5eBAKqJHZ
	vhepQCsSblRmsVNHG57/DeW85jscLtrLTdf+IwJFzkk7fkcJEMgMryy0jOWEOqF0IQf+1wm4yQI
	Bu0cF7IKZoUyu2vZHPMOh6Nm0c39uf86/McCq4OckcWe1m0FpW/wDz0bTfRL1A=
X-Google-Smtp-Source: AGHT+IEbQWcA24Kbx4WGqne4qBc1WSH0/V0p6USM3p9jzcwx9Ow+8m0yX0UhH/skvcZPKmcDhdcGuxcgDeZQXB6/7R0=
X-Received: by 2002:a05:6122:4b18:b0:544:c9dc:478b with SMTP id
 71dfb90a1353d-544c9dc4b20mr4271376e0c.14.1757017483940; Thu, 04 Sep 2025
 13:24:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Sep 2025 13:24:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Sep 2025 13:24:43 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPx1GvdA3dhWN8b6wORdL1MktdVoJ3E2s9sgoAyUDwFK+7WdzA@mail.gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
 <CAPx1GvdA3dhWN8b6wORdL1MktdVoJ3E2s9sgoAyUDwFK+7WdzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Sep 2025 13:24:43 -0700
X-Gm-Features: Ac12FXxv4nOq61a-ss8CFSYWmQQdbrldikB6gauURWXpoa5IQVtv9Sn7CHK-0Tw
Message-ID: <CAOLa=ZSj5iggtNuX3FDNdDsDFKE24+bmQSe1xeXmsfcWGagkWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/files: use correct error type when locking fails
To: Chris Torek <chris.torek@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000feb59d063dff8259"

--000000000000feb59d063dff8259
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chris Torek <chris.torek@gmail.com> writes:

> Minor:
>
> On Tue, Sep 2, 2025 at 1:40=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>> During the 'prepare' phase of reference transaction in the files
>> backend, we create the lock files for references to be created. When
> [mass snippage for space]
>>
>> This is buggy behavior since the user is never intimated about the
>> overrides performed and missing references. Nevertheless, the user is
>
> "Intimated" is the wrong word (also this is a rare form, "intimate"
> as a verb that is, at least in US and British English). I'd suggest
> "informed" here, or some alternate phrasing.
>

Thanks, will swap it out!

> Chris

--000000000000feb59d063dff8259
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1d43705a8b21142b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pNTlZZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejVyQy85Tm9hTFZYT3VlMm5ab0R1RUpHc0QxZUYwQwpMeWVOVHc3cGxk
OStMbC9EK0lYNnV3RlppVXVLSk5sZGR6dTF4R1FWVmpHeklTT0MyMVZOdzVMcWtZcGhJYTdyCmxD
dnFQeUVMZzV1Tkx2MzB5OGsxaDlxd0c5TE5UNjMyREtSQTBCREd5MVlSZlZ3RktqdVhVOU1iRFdk
S1dPb00KQ3BwU2lreUd2eVpUZUhTL1FRREdHR1RicmQ1OWx1cmVEZXgzdFV0ZzZJUGlSMnRPakN3
TVJYK25KYzJUbTROVgpaVUxzeC85eDgzbDkyZXhrdGtMZUd2WkZmMDhnbWEyNXNERHhOVFVGQkRL
U3lMTEVEVEJWVHZyTjYrUE80M3czClFsQjhSK1M2K0dTMXExdjIyT2grYWFRZ3hscHh5UmJabkY0
ajVpWjRWeWdnR1BZajlaYVovSlJ1K0hlMnpVQmgKSzNHaCtJcncwVUpUTDRhWUp0UHhCeW1ha09Z
YUZhcnNIWjBodFo5aExoZTdJU2hPcFU3R3lUUmdSTWZ2QTB4aQoyT29YRjE3K29FRkJWdDJEUlFs
a3BFK2I1QVJ1bFRGMGoyeDFRS0tnTmJDRWtEVE0wZm0yZHM2alZ1R2hxOFVRCmRtZWUxc2d0aFk5
WkUvalBrZUpjQktaMjhJT3Rua1FndDJXdEZ3ND0KPXJtclMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000feb59d063dff8259--
