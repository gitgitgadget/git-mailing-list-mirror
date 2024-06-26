Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C13148FE3
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401716; cv=none; b=YAYk4Xj47Xizy16K5FZ2aoiZ7/gQUtDS0hncOLKFsGX/u1G4jvqZx8UqgggEjYXj4ZEA5xFVXj48eSffs9JDJtvIQaLZnV9jwuv25IrQpgV5K/8ERqnXZkMEeqpgHHSnFelSqnS+2CtqD4idzgLpFkDl/vik7BJFe7zmV06p6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401716; c=relaxed/simple;
	bh=/HFFRJ6CSCmd8b+iqbpF57rWVbU4nLVP8vF4S6i7B6I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2KcEo2O4wkjRTBo03D8AZVnonxqXbavniXu0L6Xj+l7Y6JrCI0DF7BvV4IB6SxJaCSlIwbd2gB3BND8m9/bStK+l2CUq/bhES2WBGo+Btksp7r/ICAlim9m5HaF4skC5p3Lg2ct/lg5LjSUiU6g2xX8m/1EiayTYF5ESRhVq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U62Ky9Yk; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U62Ky9Yk"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25c9786835eso3368008fac.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719401713; x=1720006513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlH+qwouGpMhR7nw4LkW/yOLPTRRTMe1X05qoTCFHeU=;
        b=U62Ky9Yk6xQqZyEuD5HC7Ht4nc3mjZYqb07aEiDGEB8Hb0tpBju5M7uI8XSzX6ltuH
         /KTIcaTRhakTc9gH+J3tgpAZ4HOpZEhsiToI/f+6Zno+b06FbcYaP56eNZQpljEisF6e
         z/esUfDLzD60QnBusTYELDUAXtFajfw5M31UJsZ6zGqqo+KbyfCRSYmttVwfIKR7UPZH
         5TprI9xKmA3FVDzSNAdvD4h2O3XNo69FAe5+Zm+qyhRn56IcAMs0UG6bjqdDkDRM+zsV
         yTCfbaBhn8rGvc0nFX3/nl1vWJxziH9ztdjKobkQzTvmwom82j3nhitxdgNXJZov2dBe
         VxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719401713; x=1720006513;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlH+qwouGpMhR7nw4LkW/yOLPTRRTMe1X05qoTCFHeU=;
        b=oPNfmeH2PxpC5q3Uwjy8M67/0CJ7vrC/lJy4BZciYy3/Kn5S6K5VMTsOHaa5ffoP6D
         epE6DB+V0kRfvO33C3epHZiKCS8UeB28RhdNJp9GisBZ6mLQzH+UeCDfGUhZWE7TyCOs
         iwEpci9k0e11LbMda2jZF80OSsU0TrnoexBKwAoyn4n68QJYzWnbjHwNcXD8ghvA+tMR
         d47HmkLuFvy1uj7jblug6ppyNxRFRYjHepmCSf9K6NDXi5LLoVmEO/vDBWdD156kYZcS
         PDJbxDrgOrzOJcxmiszvPOOmbESpGTJRi0LlIkv6ibHVZ46v1gShhmdTPSmooKKkOYXA
         2blw==
X-Forwarded-Encrypted: i=1; AJvYcCULL6Cqaqf4hkPFw7jXh85XFxt5E62B0d2X8NErLxDL9OyqmBLajWmVfGaxswvYdaUJQhXZWcbVlxC0R7pcbNjFrApc
X-Gm-Message-State: AOJu0Yy3Ko2hKQa01LWlAhoBb34aThJMPHuTUxu9jCM8B6aOtSFZUbn5
	Ns7O+DrdxECrKqSZeogMUFi+tyDAP5prbnqtniqTnqmZsnEBeSQLcNJbsx62icEVeVirMeKd710
	0sfevQXlKdEwv5lAiteLse58jZgI=
X-Google-Smtp-Source: AGHT+IF2pHmsqnpsTGFd4h0Eul0QBJFk15w3Z/bni8IbEw/U+W8ah04hDhegTQCNgvvQVx0FGbebEnQnJPlbmsf+/+8=
X-Received: by 2002:a05:6870:524b:b0:259:ae64:9231 with SMTP id
 586e51a60fabf-25d06bd5514mr10741861fac.15.1719401713599; Wed, 26 Jun 2024
 04:35:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 07:35:12 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cQFnKXeHJwKxSShXQOwP3fbjfSMX+C04_5urQyL9+uWJA@mail.gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-7-chandrapratap3519@gmail.com>
 <CAOLa=ZSKcpOVv8wcDpe8mgtu53aWrCKG+scMqNix_BfBrT=KkA@mail.gmail.com> <CAPig+cQFnKXeHJwKxSShXQOwP3fbjfSMX+C04_5urQyL9+uWJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Jun 2024 07:35:12 -0400
Message-ID: <CAOLa=ZS+jdxFzmBbM0nVsfdJsR+vvVx_kgtWyWt4FiPgVzBXCg@mail.gmail.com>
Subject: Re: [PATCH 06/11] t-reftable-record: add ref tests for reftable_record_is_deletion()
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org, karthik188@gmail.com, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005dab22061bc9682e"

--0000000000005dab22061bc9682e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 25, 2024 at 5:15=E2=80=AFAM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>> > diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftabl=
e-record.c
>> > @@ -121,15 +122,19 @@ static void test_reftable_ref_record_roundtrip(v=
oid)
>> >               switch (i) {
>> >               case REFTABLE_REF_DELETION:
>> > +                     check(reftable_record_is_deletion(&in));
>> >                       break;
>> >               case REFTABLE_REF_VAL1:
>> > +                     check(!reftable_record_is_deletion(&in));
>> >                       set_hash(in.u.ref.value.val1, 1);
>> >                       break;
>>
>> I think it might be easier to follow if we just move this outside the
>> switch, perhaps something like:
>>
>> diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-=
record.c
>> @@ -139,19 +139,15 @@ static void test_reftable_ref_record_roundtrip(voi=
d)
>>                 switch (i) {
>>                 case REFTABLE_REF_DELETION:
>> -                       check(reftable_record_is_deletion(&in));
>>                         break;
>>                 case REFTABLE_REF_VAL1:
>> -                       check(!reftable_record_is_deletion(&in));
>>                         set_hash(in.u.ref.value.val1, 1);
>>                         break;
>> @@ -159,6 +155,7 @@ static void test_reftable_ref_record_roundtrip(void)
>> +               check_int(reftable_record_is_deletion(&in), =3D=3D, i =
=3D=3D REFTABLE_REF_DELETION);
>
> It's subjective, of course, but for what it's worth, I find Chandra's
> code easier to reason about than this proposed rewrite for at least
> two reasons:
>
> (1) The intention of the original code is obvious at a glance, whereas
> the proposed rewrite requires careful reading and thinking to
> understand what is being tested.
>
> (2) In the original, because the check is being done within each
> `case` arm, it is easy to see how it relates to the case in question,
> whereas in the proposed rewrite, the test is far enough removed from
> from the `switch` that it is more difficult to relate to each possible
> case.

I agree with your statements, my argument was coming more from a point
that the switch statement was used to check and instantiate data into
the structure based on its type.

As such, it would make sense to isolate this away from the checks made
on the same structure.

--0000000000005dab22061bc9682e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 55a653bfd8215981_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aNy9POFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVhvQy85QkoxYjlBNlRhL2RoOGlBclMwMG52WHdORAovc0c1UnErY0Zw
U1FYUElXU3orbEkvWExIVmU0dTVjSWhkM3ZXZ1IzS2pML2NxdVBYS3Nxb3VRMDRzaHN0ZWMxCmwv
dGZvT21Gd2UwRUxGMEJ5cW5uS2RKTDkrYmZ6YytoVmhNK2hkWlM2MHNYMytudTB1ME9PUE96aXpo
K2gzMzQKTGtPTUV3VWNxL1BWZlY5QkF0SFJ0d0JqeCt3SW9nUy9TS1lFYjZGK1pZNnVuZVN0SnhJ
ckJZSkp0dEpSYUpoVwpkak1WZGRIOUFtUVE3elpvTTliTDBWUG9nRUhxbk5ISWNaUnQ2MmpaYmhQ
bFl3K2ppVlkwSmdxUzdremU3SGxYClRHWnR3MTRMQW5rNUpwcGx0ZDhvQUFvWXMzeVFNZnluUVJY
cG9LYVN0VDN3K1IvWlIzMDU1TkZVZllZbVo5RFUKOE1BQTNMeGtMajZjdFhia2M4bjYvUDRnWEhY
L3BQd2QzRGV4Qzk0QnUzcXcwdldsMGhNdWt5LzNoYjFrbWw4UApkSTZiaXZ4Nm55UTdYRjUwSSt1
a09Od0tUNWxXclJlcXpVOGpvaGt1WG9wY2hSaFZrNm5UREhFa2JwNGhoaG1DCnBRV3V4ckNpLzJt
Z1NxMS9RYTAwM01mMFN4M0N4RFlncjFlU2VlST0KPVR4dlQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005dab22061bc9682e--
