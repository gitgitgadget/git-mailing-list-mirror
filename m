Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E43DB332
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260194; cv=pass; b=jkw9/LkEMyPv4GUNvKRkc3+D4XVySZ5AwIJBwbX2w5XxVACIDX992T/chqWQOuukKt8wuOsQ+kOlEeXHJVizTquBpmh0mOwLu+VAC/+edn93VMJn8dx79DfLI5Y+fgW+EHjlnWiz9l3qnR9ank9n5S790Kl9OYImdVSU8aW95OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260194; c=relaxed/simple;
	bh=lcKd1UZRIbKpFftr05SkcqAKrsX7PkLn8PMg/B1+djs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSkDE2MsnxB9kctCMlmEdFlxeHw8mcGyTS6yNeJsl520dZcBcBsOJeA8zQ/+FOUCXtgXz6yTh5RIUBKczEQD3L+RZDErfmK0H38gkj4JH83f7j1rpnCzXxmgc0fNIyQ4zmRHF8I0GDxl1HobOrJhkKw2ft0ie971D72PPgO1Ius=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U59acE3H; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U59acE3H"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-74748e3a4d1so204560137.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787260192; cv=none;
        d=google.com; s=arc-20260327;
        b=fKieG+Rddn3bZ1rBuKf4z/F49cUZvgtUSG3qJNwXaedADT7mRALzo43+Ckutr3Ns4I
         lwVP+XL+ijAiPMpSUW4PrpmW6EZjYwlLK4RIWScmKvD3sRdzQGkE7x1in1Ph6aSBpFD4
         O3yUXrRW+qUqAaOTVDQyKMCra0f922W2C2K1lf01EoaxzW5B9eGHKNKXTfsg/uxfMCAP
         NL1vWUhIiuymGd4BlqVW9SYVs9SlTl6GG/ZMIDDMpb4b4w0VW8o6pCxnc9jkdL58So9L
         4d8wuxQfD62T/nTuHGQ2KoJy6WqVga3Uw2ddAx2e1ynv1CHrzuLNVD4KQyMMo2xTbUfO
         k1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NKFm/plQhV5nxck68qTORka82814sYIu7HNV9T+9phk=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=fXRdUixO8SpbfqCtnA6zJIKzXV7Oe4j3EOInkycgr4hBh+P+bkPJAmFLpEyLALtMXS
         PZ6UTcJMqkL4NNppKghweh6gU4J4/AVw7lTVsfkD+z05bkXFP+tqBg4d16WmbuaqS3QJ
         ft4OvY9fcS3FEeg7gNwS+Iaf2DtsJhLLIzavK578ivSjiYb8yZy1uRZb1rqv3SkYI7EU
         mvjdVE9b7aXJ6vYN3pqFDJbfIgeqGh5uL6RAojRAUgw9v6A/mPK/bPL6kRs/jjrCvcla
         7Lo/ETdr6AKuLMyWfKL9x5qSCIChGBwt1UvJBudKTgcSitTtz1NcfOF0d7mWPBqhW6/0
         GZHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787260192; x=1787864992; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NKFm/plQhV5nxck68qTORka82814sYIu7HNV9T+9phk=;
        b=U59acE3HbeXIv11YMLthsLwWY2bAxjq5kmNNCMbwwM0h/IDiEo3bcdwr7KNp1l8WDj
         5GD/qog4m4YTHUYhKAk6ZawoTU0dUuuajj7WYrE8YmVgUo2sTYtqRSOv4miBOIuqrcg0
         ARwlwYRmLq06xtuaOlfZ3pQBirW13uWI+47x4gaZFj7AcFuH+GKYF9U5ni5X6Jpxogra
         +cRLmrj69RJJQCXVR8X9cO18yAsMfRhUvMJ1WWEohm9pwyT5hu5MS9Zer7Mm9x8+goz+
         jF8PcvfVa4yIn4/vKb4R0APfqMgk2ZBkidd54qsBNftAEMf8iUSGq8bakWSSBltMn7Oq
         WW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787260192; x=1787864992;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKFm/plQhV5nxck68qTORka82814sYIu7HNV9T+9phk=;
        b=D7CBNULwaoyp4nvqwpBzDGUgbINhWWfnF+MleVr87S/QJlk+HAhhXxc58vVB2xu3lc
         0lVmuUJlAGpd1anRO/H+iNM7mGJVi54zBi0X46NxUXO8B8a8tvthSdO9yw4r9dbHs7H9
         EI1k7OzrrocxIcs1OLAx6vv+o/KkldsxGnG7zxvfGZId+RZb1PVbevEZd9JU232NYppS
         gZmNW1qDyIYN5f8wbqomUV7v61/0isZRuBhuH7JK1h6OVeJcOx70tV5k/Ff0J/5qUe+F
         IBBC4uvihQXWoRcrKvIaSkCjZExVZuhDPFcZ2AhQ+PROptSjOZ9M1yQ6eFl/dxXxESAA
         901Q==
X-Gm-Message-State: AFuF++kE+jczUq2YWc+LbFQsPE12nmtCqCcEI1NofS/vP1AhyHHYuuhg
	fbrOUFds4/Oebvv4zn15Lj3he2mdV/x4ENhNAGS5p8y3WSfFo8DU4FepC8ISDJKFmc58T7bCc8i
	N2mG1/oWmCd8PmdwY/cll2ZmdjzvGqBlD2xZE
X-Gm-Gg: AR+sD120Z6+6fy2KhYPknRFccZv/SV3FUyIDW5Hz2DN1OMQE8lmZzoiwluuOnUeRkff
	I/ARNGCiAsv5VCe8ERoUflMN8NMgNfdNVQTFjnGqsVYeLRw30oEt/uTlJUVWAK/cyPZlPHCTEOy
	R5pzpsdaTtOpM9Pl6K6y6o20nENLAd0dbc3myp9WKwFZfw0WaZyxDCbJxlQgbTh3ksxjyAqsrsg
	6+CBai17KGwtZJ5E7JyBBbokQLqYW7OF5a1uK9UUxTji4LClY/a7wA2jpVu0fOOTR2+DKlOTB69
	zKARLD3C6ZUOFducc8OhowD9jN7ZfzLCL++gbwpWJGXCSm5NzO07ElujlySimwEc0drElw8ZnUG
	WK1zDECnHMlPdDjFld39kHKlwGnZ9Qsz99707ag7o0wKUzg==
X-Received: by 2002:a05:6102:442a:b0:738:1ef6:51b9 with SMTP id
 ada2fe7eead31-77a60c1e95fmr838501137.5.1787260191907; Thu, 20 Aug 2026
 14:09:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 17:09:51 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 17:09:51 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aocNsR60-8W2A-fy@pks.im>
References: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-3-a984e3a0ad6f@pks.im>
 <CAOLa=ZSSzR+qKh4Do-F7xZQMO-pE+t4N8qM5hsbfM4Uh7i3d1A@mail.gmail.com> <aocNsR60-8W2A-fy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 17:09:51 -0400
X-Gm-Features: AcwNN1UlPjUTEMbyAQC1W0aHVjo-Ewx3OX0cRMFZS3DXthRURA2w8BqGWECGk30
Message-ID: <CAOLa=ZSs-9VU2eKT8DUJ7FzZCAkgRzZ6_XQZBP=x7avxpFp7qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] odb/source: let callers discern missing and
 corrupt objects
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000dc3df8065980f0a1"

--000000000000dc3df8065980f0a1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 20, 2026 at 08:56:50AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/odb/source-files.c b/odb/source-files.c
>> > index a28aa5042d..e88fd1d399 100644
>> > --- a/odb/source-files.c
>> > +++ b/odb/source-files.c
>> > @@ -65,12 +65,26 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
>> >  							      enum object_info_flags flags)
>> >  {
>> >  	struct odb_source_files *files = odb_source_files_downcast(source);
>> > +	enum odb_read_status ret_packed, ret_loose;
>> >
>> > -	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
>> > -	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
>> > +	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
>> > +	if (!ret_packed)
>> >  		return 0;
>> >
>>
>> Nit: Similar to my previous comment, wouldn't it be nicer to do
>>
>>      if (ret_packed == ODB_READ_OK)
>>         return 0;
>
> As mentioned in the preceding commit, I think it would be somewhat
> pointless and only make the code more verbose without much of a purpose.
>
>> > -	return -1;
>> > +	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
>> > +	if (!ret_loose)
>> > +		return 0;
>> > +
>> > +	/*
>> > +	 * Reading the packed object may have failed even though the object
>> > +	 * exists, for example because it is corrupt. Report this failure to
>> > +	 * the caller in case neither of the sources was able to read the
>> > +	 * object, and prefer the error of the packed source in case both
>> > +	 * reads have failed.
>> > +	 */
>> > +	if (ret_packed != ODB_READ_NOT_FOUND)
>> > +		return ret_packed;
>> > +	return ret_loose;
>> >  }
>> >
>>
>> So if we already found the source we return early and only come here for
>> errors. What I don't understand is why we filter out ODB_READ_NOT_FOUND
>> for packed. Wouldn't that leave us with
>>
>>     ret_packed => ODB_READ_ERROR
>>     ret_loose  => ODB_READ_ERROR or ODB_READ_NOT_FOUND
>>
>> Doesn't this come down to preferring to propagate ODB_READ_NOT_FOUND over
>> ODB_READ_ERROR and now packed error over loose?
>
> So here we know that we didn't find the object. So there's four cases:
>
>   - The object was not found in either, and we'll return
>     ODB_READ_NOT_FOUND.
>
>   - The object was not found in the "packed" source but was found in the
>     "loose" source. So we'd have `ret_packed == ODB_READ_NOT_FOUND` and
>     `ret_loose` at any other error code. And consequently this block:
>
>         if (ret_packed != ODB_READ_NOT_FOUND)
>             return ret_packed;
>
>     Would not trigger as `ret_packed` _is_ ODB_READ_NOT_FOUND. Hence, we
>     favor the error from `ret_loose`, which contains our corruption
>     error.
>
>   - The reverse case, where the object exists in the "packed" backend
>     but is corrupt. In that case `ret_packed != ODB_READ_NOT_FOUND`
>     evaluates true, and we bubble up that error.
>
>   - Both sources have a corrupt object. If so, we simply favor the
>     packed error because we have to pick one.
>
> I think you've simply misread the condition, as we do exactly the
> reverse.
>
> Patrick

Oops. Thanks for the detailed response.

I think I made my case in reverse, but my original argument still
holds.

ret_packed   ret_loose    ret_packed != NOT_FOUND ?   returned
-----------  -----------  ---------------------------  -----------------
NOT_FOUND    NOT_FOUND    false                        ret_loose (NOT_FOUND)
NOT_FOUND    ERROR        false                        ret_loose  (ERROR)
ERROR        NOT_FOUND    true                         ret_packed (ERROR)
ERROR        ERROR        true                         ret_packed (ERROR)

So since we return ret_loose as many times as ret_packed. The comment:

> and prefer the error of the packed source in case both reads have
> failed.

isn't true entirely. So isn't it better modified to something like
"prefer other errors over not found errors" or something. I hope that
makes sense?

- Karthik

--000000000000dc3df8065980f0a1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b1e94aaf1314cd70_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSGJSMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDJXREFDUnVQSCtpS1FYbko2Z0J3MkRQaEU2bnlxTgp5UXVnSG83d2cw
aWc2SUQzSUtSL0w0TkZORFlPMUVuTXBNWDM1bWNxQmxWQ3ppeFEvYlc4SWVLTG1hOXJ2ZEdMCmZk
N0JaOHdRRXh6N1Y1NVlTVlIrbEJMaGdPeGUzUEVyOVNIVzFKenVHS3RNUU9LU1lxYzJZaXBGY25N
WU1oWVAKV2xlOVZmVVlsNlBoWEVWd0JGeTFSa2RjRWVtQ3hUL3dWTzQwNm1pcU5lUnluZThqWnR5
aFNXVFM3bzYzZnZuRgpXaTZ0cFdjUFk3anQyQVoxbTI3eTI4Njl3VHNsZEZPU0dpWDJlbzhQblIy
ZFd2NE9wK0NCdEJxSndzOHVEcVlQCmdVc3ludGxXZk9EdmJJZUI3NU5NZ0ZjekJ1eS9YVnpRbmFi
N3hFMXFIT3NxMTZWdmx1RDg2YzFwMUczamFaMXYKU2MzMEdTaW5CUFhBQjl2czkwTG9KVU1hT0lD
MXoxYzJyT2ptbWVyWXREaHZqam44Um9QOFdFYWdmTVl1SDh6Uwo2YWFvOTdXL3JoK1hnZWsyZGtD
NElJM2hGRlBvSDlLKzBhOVNIQlJlQlA5NkxBcW5ZTWl0OFBkcTRIL0V2M3dRCmdaM214ejRXYllR
ZUppMUx5L0tlcVYyUmxwZlUwenkrQVVwUTRKND0KPVdvR2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dc3df8065980f0a1--
