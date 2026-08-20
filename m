Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721F3DA5DC
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259594; cv=pass; b=r9782Xq4zcyd1EfA+Wpx40MCV1WMozgP3TlFpEmTBLjxcep3FNzai0StfldTzM3rqJuVsafZ1vPH0G9qgu1/DvIdkb90pb69ErJWxVGM+uL0J0cnMJIBhxGCEBIgL6bgM59WdEI/5g0l70eZX6gUxh1D/OzM2HvEx+WRbfnnwAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259594; c=relaxed/simple;
	bh=7Y1PSU0ofKyy5a9swIPXDe4Dsl++LdfQpj1b0hhoqxk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA9oQHa1obM1AKUFwFCRKbpYKZBkvTdVTtLR4htnCIPFbD5PmQc+tYvoXHwEkliB8TPsNGBSGmXJFj3kredDd5GUJvpkps/GbZxOZyCzIE7lCvz+Oo7fzcMwTTLsAt5INfut9hs5AKWpqiZDIoJS6sGCN1yvrse5yZqh+SoEc94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGOVonrY; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGOVonrY"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97bf8f395f5so171120241.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 13:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787259589; cv=none;
        d=google.com; s=arc-20260327;
        b=eWSPsFM/rP3+iT6F3tme76QHCbCbdKMGZyDK9R0tfUxc3ZmdoDu8ZIOovLo0Q/kKIX
         fV/a2Jb7+hBDr966X9k/leHw44jtqUOavHkZPR7j5RsG5a4Sage1MW/oAfreo+7utCFo
         ltQMaURgEDr+t/t4wnNU4pWfiPqEHLlCa7MvHWuOwmOv7e5+zYKsbGTFpGCTIlFMpBdR
         ujO2BKD2YUn/8DlPqfzoXxNj9p+eepf+gPrl9WEDgQCnyoBiGqw+rkPI5RcmgmLR/gVc
         7V9SqX+2n8aYnQU6LUTmCe/na7/6mKhOvNrhSlGc+zV2Q42zG1tabLbF6jXwHUbFkAFF
         XI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=C/43iO/ys4o6SNPjBqiITUUVeBmmiouk9xcYFh70HUQ=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=EJeghnKriH5jKj3lX4QJmkEOxkSJy1N5zmz96NF71Y1BM9N/gxqb19n5P03hWK5eSy
         S+Xa0IHjgbM8eaicWwmw+2dOuEHvV7RCLUhXaabofxvkXlWujqJ3TpjTtc1PsPvTSpkV
         7fkIwcKWj6doZDihg0hED2CeNjFCijpwlBVlXcqy4+LtYXez4bbf2QrcW7rEmrGJGFD1
         LHZSfx4ShcVh2SSksVM6W+9Rgcyz1T9A7kj94hlyNGDZFRd4XDGNUkc08qTu9bfT+e9b
         4slUiOjLxTpzCa24ZCwZJnx/UlN9LHxLBYVzOnKXxPacPCabnkQFTs9C6GRhYa7YLs8/
         c1xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787259589; x=1787864389; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/43iO/ys4o6SNPjBqiITUUVeBmmiouk9xcYFh70HUQ=;
        b=JGOVonrYSUuBatiNYbZiMJyMBImFMe41b7IC3oBPE68e+/agkbAG1U/MvkgUCHtK+N
         ayjWwH5jr6arOoe5OPAYufD+RH57wEXtaNaI4VJHOw0gJsVnQQmCtuh69M3WGo5zqbEZ
         2plWhaH4SEhOYnvXHPRmKThP2uk1/3t5GvTg3HnsUvDmx/hTLLKNtcmKNdBiSRseNFtq
         EPr6Z2axv6+Qbww+ijJahtu/gOa5UQBsR9SSidzSGSyMyBYk5RIBnEFmzIW3mzn/ETku
         GIghjCI5y1meNNrKdCepzn5BDJ0qdp4vN1p9SXZY+i7mByYPqkLM6OKxV11mdq8mNcN+
         Ug2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259589; x=1787864389;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/43iO/ys4o6SNPjBqiITUUVeBmmiouk9xcYFh70HUQ=;
        b=q9KHOgJk/3m6a8CQt/HGPxzQldOrCgS3KrdVuqs4b4a6Xsx31acg7aITH8iHncq6KB
         /EEn1eX5XL+PCJD146cQuC1xZ+FyhMKhNTHTKBHmL5A//7CRMHSko5dneIWNqcGxXcIn
         8D+8eZeUVYWFDCognuLwZJW3bMyRbyQLF8h5skQkIo9wOJTi/Y2PyUs1ybuj2A597iQq
         nbJbLghUHSmkpHUVEPjaQxrT5rkPMVf51S5PuYag6QJHcjoPepbmnM/xJ0ZuckVYkbzv
         lHiVEoCjNYCRVAoMvtOivX/+/4IxagIzKwz27myTA74E5pA171SEPZThvD/TH3QjseFD
         a7/A==
X-Gm-Message-State: AFuF++nQnUWKqawj4lTcE1nnwFDI/A6if9lomK/qYW1IbPe8fJq8SODy
	Gt0pQ7wIEBFY3h5yFL6uN262jNilkSdlYbLXizWXSqfqwpZolcauzvGDOF8RsEChpoFPEpOhkTb
	ZZmR/PLdjYvnwPI69EaqUXC5ZwycwZoLLlOaZ
X-Gm-Gg: AR+sD13u4pZVotIEBBSjDV9FuGnu4PfKAMO7a9CU9Dastg3R2b1MMnxdH60tVaHwjBS
	hQa06ztFd5X1MvAC/Dtqj892mVukwVm1eDqemmQINqy066ch0PL3j3P63AMPf1CeIQsBQXrOWCb
	GGkEA1jbbW8gxGFINFnwF5ZQtAkyVAoBldsjeY2Cd9RCv4BrZ5ywkM8ZB7M4ZaNuWhxaknxhH8v
	hL4vvbmPta0IBcbDY8lGxSfJn5BHwWe7oKaTzERSqZZHA5sMSXp5i2rn/uMurGyN03HLaPNR5zf
	3LeHSUaRghQS4/BQ6zZOoDZ4JgVb4mcPwfABm/IF3lZB5lvIuBFQFJgbo8T4WK7zfZNjn5vMjin
	50C0ziSLxY8R8M9EefhOuo9wUjNQYk7TOf5o=
X-Received: by 2002:a05:6102:4b07:b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-77a63548bfcmr883978137.4.1787259588930; Thu, 20 Aug 2026
 13:59:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 13:59:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 13:59:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aocNq1N9MWS4BeaJ@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-2-a984e3a0ad6f@pks.im>
 <CAOLa=ZSCf3CvTwtgj7RXncT6zPhyp4EX9r=g55uD+mTA1zp-5w@mail.gmail.com> <aocNq1N9MWS4BeaJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 13:59:48 -0700
X-Gm-Features: AcwNN1W_SefD1P-LF1Am-urxMMNSnCFgbjAQqZFWvKr_PcHygr8V1Gl69frUfLc
Message-ID: <CAOLa=ZTKqPa-9j8UzqQQCVwVk=Yt7aQVxg9qSi41Q+=A-6dAow@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] odb/source: introduce error status when reading objects
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000eb8b76065980cc6c"

--000000000000eb8b76065980cc6c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 20, 2026 at 08:41:10AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The `read_object_info()` callback of `struct odb_source` is documented
>> > to return a negative error code in case reading the object has failed,
>> > and zero otherwise. This is overly broad though, as there are two very
>> > different kinds of failures:
>> >
>> >   - The object may not exist in the source at all.
>> >
>> >   - The object exists, but reading it has failed, for example because
>> >     its on-disk state is corrupt.
>> >
>> > This distinction matters to callers: when an object is corrupt in one
>> > source we may still find a good copy of it in another source, so we may
>> > still be able to proceed with a given operation.
>> >
>>
>> But isn't that the same for an object not existing in a source? If it
>> doesn't exist in one source, we may find a good copy of it in another?
>
> Yeah, that paragraph is a bit odd indeed. What I really wanted to say is
> that the failure mode is different depending on whether the object is
> found at all: if it's not then we'd fail gracefully, if it is but it's
> corrupt then we die.
>
>> > diff --git a/odb.c b/odb.c
>> > index caf1d0f542..1b37b26376 100644
>> > --- a/odb.c
>> > +++ b/odb.c
>> > @@ -696,12 +696,12 @@ static int oid_object_info_convert(struct repository *r,
>> >  	return ret;
>> >  }
>> >
>>
>> Here and elsewhere. Shouldn't we explicitly return ODB_READ_OK or
>> ODB_READ_ERROR instead of relying on implicit conversion?
>
> I didn't want to go through the complete callchain to make sure that we
> explicitly return those values. I think it'd be mostly pointless: the
> return code convention is established enough, and all callers already
> return the expected values anyway, even though they're not using the
> enum now.
>
> Patrick

I think logically it is correct already, but returning an enum type but
seeing -1,0,1 in the return statements means that we have to either
remember the different enum values or we need to cross reference each
time. Eventually someone would start using 'return ODB_READ_OK' and so
on and then we'd have a mix of both (this argument does go both way).
Anyway, it is fine as is.

--000000000000eb8b76065980cc6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f2a892dba98f4a2f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSGFzSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkVWREFDTi9TeDBleVpyWWhEZGNFY1lTUkJCd2NCNgpHTm9Gc2ZGRDhu
eWN1VXFRM3pTSnNjQWpPQlJQSU5uMFU4RGhuOHRhd1liMFlCNVRiaG1iZmpkZFl0ZnV5L1dLCmE3
ZDNtYXRKSXJrZmhTVEl0eVlwRldwYnIrQ3lWa09jbzFpOWhRR3hnK2tLbVdDOWlSVUNHSTVCajhp
U3lTRDAKeHQwU01HbUhucUhUTXhvL25UU2dhcStabDNMYVNrSTdoYXBYRDNhMDhGTUVtMW1mL2NE
eUNVM0J2UFRqNnVCVApsbStDcFE1T0k4UCtER1F6Mm10OVR2MFh6SnlWUUk5bjc1MFJFbDRicHJT
eWJmcVFzZVZXQVdMb1VteWlrWHpqCktmem1aWmc2SE1zUnArRFlpWWlxUE9TdzJzczJRckowRzJx
ckhkdzVVcW5YdjMyRmtLczlXOWFYRnJYQzFxWE0KOUpMTkxsWFozbktSTE5SU0xJZklEUWFtWTJP
dlg1WTEyMm0ydmFaWHY0R3Q0dXIrWEYxUmFXQjZlOTFIejV0bQphdHNrRExpN3Z5L2hhTy8xMDBZ
STB5ZTcyRTgva0RYbEdjRHF2RFA1OHhuSnB5amptbk1SWXBMTE50dHFXOHQyCjA1Y0ZpVWpobTZk
Unk1SzBVeXRLWHR3c2ZLVUFST1hlM2EvMGZ1cz0KPXNOTmEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eb8b76065980cc6c--
