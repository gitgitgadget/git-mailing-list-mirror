Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B918AFE
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023244; cv=pass; b=iuw+GiF5gL8JqTvvDP8oK5IGMy8pX31/4z3CaBWjxj1ipMdEVmgQ2u/GU6/Jwph0ndqESKGC2A0BYcrItATo2z4p/mWlLQvjS2PayaT3FHJAs/Uu2bWKwAPvnLnm5tjT9/44XTMMXN0EqjFB93jbsUDJSSoX0wsztGKBccELZVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023244; c=relaxed/simple;
	bh=pvnDJLqmQ42OUq9EqpcVCaOWcIZm7sZTPX7oJW1EHpI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTY+oIymKK8A5GXypd3g9b6laApLU1CO/D4Xv4PybeQ3huKAMPW3LSc+t6CbcFo/dvH9p81xtE0Sdt0aAExNp+RoM1kpHx+Lus3aHMaIaZEZBETvjSApx6kfVgWivNJkvV2xWiaMiQ4Hmg9/7u2s+d8NCYenHMT0xt6GGJD+X7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcO4/gS5; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcO4/gS5"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-61399bdd395so2422453137.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 02:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777023242; cv=none;
        d=google.com; s=arc-20240605;
        b=GPvfDgF1a8PQeEzQGuHhG5y/vHo426pYzRVbTXz3myhwPIVfpGDEE93ushKhvto+52
         Sz1UJzBahPg28Bc/YsqPdQGER+3Ia4HoR+PE5FoTeEJmp1DxvCqantdyXjenJdEViKSZ
         XZ7en1uxOOZGjBtdzEzvBe31lHr2H/qUXlCvdhhEKDRiWgazeZiuuDbGrfZMQgmfd96s
         BochsuG4/5Yngkmwv2+VpmZv/Zj/ZnjFsJdSwOEDZoaZ69ZLzYBmEZD9AIkohwe8BIeZ
         yrmcJfD8Pdu2KpM9lEmAovuH0udHbAJpNTEQG1aXEKoyZDH3TS0liptAXzymTqa3q1D7
         92ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vOIREMFhIxxUnVSXJlsD0QhWVWmJP790f49u1Znzef8=;
        fh=FhCDfeFbmycHGzY7HbKUSS8ZI4XWOfgXn11u3NYB6YQ=;
        b=BLQmg/T6CW394Ee0tiaJXlMg2jB8NMo9V2f8SaRtSub02XBJZr2kZD4jZ7TYwOY+N7
         6MMV1GEfrczK7DJ5yX/K+ftyUFHV7AuV49ydPCbI4X8966UEsLs50JkGRJ3L38KF24dt
         Na581PUUrQWha3HPcF4p8I7Lsa6XCPIqf5bp4/gg4TEAOLxZp40NWgHukMyEAyqSVKPh
         lctl3MZrh7GVTAK5ju15oAX2m7xQckLU0KM47KHlcxYZ12X2Lp0gRVEJ73r6Vjvlf180
         AAL/uvfo2m1lDK+hYnLJbFIF/MFgtYB7TqACs1Boe8zGo1m+HOrimWHvk5waTVKGvs98
         G9Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777023242; x=1777628042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOIREMFhIxxUnVSXJlsD0QhWVWmJP790f49u1Znzef8=;
        b=dcO4/gS5QlWjEYfKFgLh6SqubnrIFvVQuKfZfen8nrUPqdUDK03+7GtMFj5Ee2HMv2
         l3juos3r1e/1mrPJssZjy6t10LyfWO0pbdYwv5RF/z+rJmSS+0x6NoX+pjXYIlvPFqFn
         xTd92/lnFeAI+ddz6eK6cF2i1CzVVKc1hDIIBwqVNE4s+jMDA0bxvKdv4qlGv4VHBjTg
         Kub70Gver5NAVyf80KSWoUlYCMDu1vAIuFA49PR9RflyAsBn3trQLVhG6wzVfR2jv8yw
         seXtYGU6vsadOoOyO2ovnWqFjMIjQY3WljLha0beWjX5WOnZGfjFI06pDa/hQ/uU6S8a
         goSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777023242; x=1777628042;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOIREMFhIxxUnVSXJlsD0QhWVWmJP790f49u1Znzef8=;
        b=WnYs1TX/eQritOMirtDSURp7Gyd6uiFK0erE5xnFARUl1EKoopFZ3qHRaill7djfpx
         Hh93Eo9w4phUzjOdOAzYZZH2FC8wreOgDN39rZEVYDgSTeE/0Qwx2TWxLSPZEMD7B74S
         VjCGmhPFf69pyQi1gWD89wWrOT+jhHDbrgtMeFnAcWKDrNfnXhg2/JTW510MKOrcMUsv
         M9o1VSlNebxsqyAKnMs86QqfcXcZnQoHEReJJ0TA/iWPyGtVMwD33TBQBxghp5mDcmgv
         IkkSkeAmGKXJBWdahMTcbhMxIrhSjRizT7/T54diTMTpz6zJunDAOht2HCl4KlyzcLlQ
         H0Vg==
X-Gm-Message-State: AOJu0YxC75wKAs5lOP67QoYDo7ex0d4qAHceI9PyCKhtOT5EwjQST8Gg
	bI3XIT/lIhYpsoxz4NKbC0DNdP2jljs64WPXjYB1USWAoH7QNqgkC4wbWbO+MKKSFAFPXmWXnW4
	tXfvwEh67wRkwCufIR6ZJvR7a33lLQWvuiA==
X-Gm-Gg: AeBDietyx0ke3Qv8Cc94t2KcXmIGIVWVVAB2aJaWU0qt9CaAWLgDJlL+qRFPXfllOye
	tOtnYU6LNMTkVJ+YxteprrFkN8fGoUrbOxrqCQQDPuCXIODECqVMX+wTlsYXCxBl59zB8cuVCKI
	kFrpzKxSeJsHD+/Lrbo+uQOP6mwvgO04d7G5oDPmnIcGYQXFGzio1+8SyZcZ9bQdY8qHz9Dpf5n
	nU2tYLCKNOqh/jQ75VK5wQ3l7iuffAemfxsa/N2/w5dfNSsRz+jaxzLMC07Vuk76G4gKF6gAl7R
	LkTBZfQ9wsXmLOTN8ELlBIILZ/thCgPqAGm1N/5ncjerkDU1uM0m
X-Received: by 2002:a05:6102:6444:b0:610:5b9:dde6 with SMTP id
 ada2fe7eead31-616f474206fmr15804188137.6.1777023242095; Fri, 24 Apr 2026
 02:34:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Apr 2026 11:34:01 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Apr 2026 11:34:01 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aendvlxDYMHNn4Sq@pks.im>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-2-ae5a4f146d7d@gmail.com> <aendvlxDYMHNn4Sq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Apr 2026 11:34:01 +0200
X-Gm-Features: AQROBzALSZVu2hzgrN2B9cIDntqKUksLv5ovSQvizAXN7FO6TDExeohv9zEYxgQ
Message-ID: <CAOLa=ZQ=UdVvFVNCt8s-jqx1Aai1KmfzbEF1quHS3OG09vT5Vg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] refs: introduce `ref_store_init_options`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000001a709506503177c0"

--0000000000001a709506503177c0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 23, 2026 at 10:40:31AM +0200, Karthik Nayak wrote:
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index b3b0c25f84..78150ad209 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -120,11 +120,13 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
>>  					 &ref_common_dir);
>>
>>  	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
>> -	refs->store_flags = flags;
>> +
>>  	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
>>  	refs->packed_ref_store =
>> -		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
>> +		packed_ref_store_init(repo, payload, refs->gitcommondir, opts);
>
> Is this change here intentional? Doesn't seem to be related to any of
> the other changes here.
>

Definitely not, I think this was a messy rebase.

>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index 2d963cc4f4..f49b3807bf 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -385,6 +385,15 @@ struct ref_store;
>>  				 REF_STORE_ODB | \
>>  				 REF_STORE_MAIN)
>>
>> +/*
>> + * Options for initializing the ref backend. All backend-agnostic information
>> + * which backends required will be held here.
>> + */
>> +struct ref_store_init_options {
>> +	/* The kind of operations that the ref_store is allowed to perform. */
>> +	unsigned int access_flags;
>
> Smells like something that should be converted into an enum eventually,
> but that definitely is out of scope for this patch series.
>
> Patrick

Yeah, this is good #leftoverbits task

--0000000000001a709506503177c0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aa0e40d70fc8d2ca_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uck9RY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEh3REFDVDRXVVFjODdzL1E1MW1wRXdkMHdFcjNBTAp4YjJHYlEwZ3lR
YU9BSW55WjJxR0Y3aDcvSU1kZXVRNnpjQ2NYMG5ZQlZlWk8vb0lOR0xSS0tnUmtNVGF3UUs4CjJR
a1JJbXJNajhvdTk5NUp2TWQydVlhT3BzczJ4ZFo0dW1zanB0SnVidDhkdndyZ21PUy82TDBLR2FX
Vk5maloKRjR5UXZqM1pUalFtV0pOZDFVaW5xZVQ0RFA3VE5qaGF4ZXlBRks5ZFkvZ1pzNFgwdWg5
T3RVbGhnalc3T0d3aQo1Mi9WM2JTbjFpUlk4OGFnajNROWhucGNOVG16cWdlK2hacTZnakwwbXRa
dG1Fc1IvaFVDb21kRUd3ZTNiU0xnCkdhVlBxR2tZVFJjYm5idE9DUjdyTFBJVkx0MzZXSElmRlFT
TCtocEpFTW5aRDQzRC9VdmhCUHFBeW51NE0zeHYKb0pHTzAvcHBMNDExK21BN2ZNSnQ2TCthdHBO
V1Q2M0RERDRuNHlVY2QvN1k1d2lxTUhRQmgyOE9PaG16dkxTYgpxbmhLZjFzdHMveFVvR0xkV2hn
MExUSGZsL3BTNDdZN01icEUzeEpLSVBLMlFjYnhtaDA3eUVjVm0wOTVWdktyCmxLa3JUczJQM2JD
MjZzL0ZpSFI4MTNvcXN3QWlPbjdkbW5IZDdqYz0KPXQ5RTcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001a709506503177c0--
