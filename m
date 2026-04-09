Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522553C0623
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733765; cv=pass; b=njXkGdSssJZW9bskHQgyOQRpzcCbPy+UlQ0Y5NeV1Gj4Om7SMeMy67c1b5VD4DFeQvenIwtOIS8EuNq4GUs6CyEBEIz2GqaDqUyuvlvOaHL/gvXjRjwlCSB99AY7SnOT4o/mNw/XaV2+CgTpweIjNTraze3Lm8FwaqqlvL/DdRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733765; c=relaxed/simple;
	bh=h3Mqw1eX/banXQvU7mgUxo+eMr9qbaxGeV/AJ0IkCco=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXIfRrN3CApCIwpy5/0K3sPrvCYEs6FDOBBKy2xfwU50bzC9kIrhZE1Q+BJFf+fkPq2/DR6Rf1ODqfjzpgJALu/5SonCRVyiOCha51RKXpC4sp+qFVd0eIem80DIFFnbWsGZsspEGChx6fnnEQdHiv0Y7GNeOh8q5xVADLfvYIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UROn/GdP; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UROn/GdP"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56d93355337so478631e0c.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 04:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775733763; cv=none;
        d=google.com; s=arc-20240605;
        b=XF0lSfwc9sjKJAwvoy1Mgfs3pJLAhL8fi/gHF94DYjNEE5e61XVIF0S/uAvfJ8beTH
         aj0POXCSAh2O5h0jHJ/Yc5QXB2ez0JbYA/eUDXbZnPLfNya5bHqhNDC6uSvEvzKcHFxt
         594bVXODFZDAISrDKPhMVy6Mi3INykPKNqTvJpk7+pjFu8H0LYBlNBvFjWXiFR4baxtc
         vvB69Jf6WuguIUsVx8xaT9Je/E+CaSNfoAOOsaWBolF1IzN/Ckl2TIsNVleDBWo3Gs6B
         CgVx7f9wTV7+IH86K0TK7lfX4bYl7CC59dZwrwUKMFF45qEYWJts7fe1NITk3wiyQGLG
         coLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RnJBDm2A1V3v4NeHB+MTPrFsWF8YJVX694dj4A0GU/g=;
        fh=en/eTjevAOLt2Dy9HfTEzVwFh/fl0oEd8cMtfc183zE=;
        b=IkWUwG7IwbTj+fvipgq9FndzEXSqEQh9rCbek1AkfxD+zVGeR+zeRGpIeKfgoqwFid
         5MUJTf6w++DhuKyaryrpmr5JAAuEhsZQV/OGFucOJTnKA+KVu8PioifJAFVLa7+x2fDr
         KX2o+lpblBkab9+lfwBPBwf6U/Me1rKNwLWMGm44JduAEUMsrQtSG4cZeJnqOss8p7jk
         ewtU3NdSmeNpSyQWV8VZHDaLhtXgHHOTcTRsDW+8mL/e5xb+7FpcBiPcfeHzUWY9wr2+
         KaphddKIMTqrI+bGKu/L8QMTxOkP3yIBfenZZODc44G0Oelk26FH4ypMiNV4ZMrAL8Gd
         xOqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775733763; x=1776338563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnJBDm2A1V3v4NeHB+MTPrFsWF8YJVX694dj4A0GU/g=;
        b=UROn/GdPEpwqzZ5aTgy4r3sN5qPIw6DHScpKArBMm3s82YtY+pGFszJBKkkPTmlKjX
         Gc6x0mITshG+ZaXGhMdYd25/wi3whRZgK4ayx31ytvEf615bBR/e2NjFRRasWNbZq2KH
         J68ORrCc7/8vtP1WiVOVzXhn6a861ywdcaHLW7OQdtkFITfoaESKkWzh5b72fMQvuLhC
         dXkevoRjntx1DEftKquUvJ0Mv3UH4ZAL/gTqbIj2xORMzZ8XitoczSiszZwAA4jZRUj0
         y6ZbOzJvhaUwW+vC6vLZsbG/zdz93XGydHXKyZf4VnMpGovcyKrsn031nuwNhxZq3I/L
         UPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775733763; x=1776338563;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnJBDm2A1V3v4NeHB+MTPrFsWF8YJVX694dj4A0GU/g=;
        b=WHd5R/OmqyR+v/15Cum2hkcExVD9+qUkkPKOFYOir/26iCH/WxTxTG0UJUE8MhGHnk
         NYdcchJel69RlpChhCQfMP1hZaPyB0HiOKpiHqBpwW4yJ0P0l7hbXyECEZXwNXDdzLjX
         cP3CpBBKnpDXw1aZx4oKxwNUtiPy/6VTQyXNQthJ+spiYrNJGvnWCDAMV3F9kxrg3LRr
         7sZ/cN/TLb+U4Wnwsb2JtjRWrjLJl0iyy69cZpzColZTYZ1LhwCo7gOLiioIgYY6mCuZ
         eTqI9kkStaSG0rDZZ/krTYfC+FAlyC9AH7YsnP52eOzIztBNy2ZW9JwRh69vxAbmch+d
         peyw==
X-Gm-Message-State: AOJu0YzwWQnLAAm5V8psGBMlmHMM+/nlvsf7w7VvoGV1Oddmkd1j/Y3j
	0jGczGe8wRFV0IlWCTFoNn1vSCgnd5HiIeKYkPbV7S7jZtoUp6Rm5kWmkmLqF7oE6gEFeIsJKHD
	5OTkwNoSW0zBYBF2saqglfoxUbTmOdxk=
X-Gm-Gg: AeBDievTTmJnLrUfjIbB6J++8IFz8Ofm/PhDKQWTbznUG0I4qTSg1waiGcZHljAOFxj
	Etmur8OZb1g/E9pc4xLHns5Hje5RQEYOJpMvasW2VDlP+tK4Vf6TXlj86cAtam2DbmyZjIPIbC3
	jyVSntxqXZ1jhvLxtzdVdtFBZ/Tl+lgEGl34La7i2N7SmXn43cfpMdAqduBz16ieb3mFLGytHfW
	vVVkO7VBt1EeO2KVMBYPn12p74956EWgTByO/xVDtFXmNhzwjz8aKXf87W0ddC2fTDenng+la4M
	JYXnOFyIyeHqlKXatTQTfdva7lrs3lxhax/nAKI1
X-Received: by 2002:a05:6122:9006:b0:56f:317a:65d9 with SMTP id
 71dfb90a1353d-56f317a6780mr377462e0c.1.1775733763193; Thu, 09 Apr 2026
 04:22:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:22:42 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:22:42 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <adeCY8QyvDnQdJU2@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
 <20260409-b4-pks-odb-source-inmemory-v2-4-f02b4f1c0f13@pks.im>
 <CAOLa=ZRwv_NYqtNyvhi=5auLhVx+FDbt+RP6Kj_ZqjF=VsefyA@mail.gmail.com> <adeCY8QyvDnQdJU2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 07:22:42 -0400
X-Gm-Features: AQROBzD05zZJ34yH5gvJgY6_Qxwcq90wUfZOYkzJ0yDFcJjc3lRIc41oB_RQJYA
Message-ID: <CAOLa=ZTcXerM6_zof5q6Kfav4N=MWZSjTJWSZJPLWZbW=+sNHA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] odb/source-inmemory: implement
 `read_object_info()` callback
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002be57c064f053c57"

--0000000000002be57c064f053c57
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Apr 09, 2026 at 05:40:01AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
>> > index ccbb622eae..12c80f9b34 100644
>> > --- a/odb/source-inmemory.c
>> > +++ b/odb/source-inmemory.c
>> > @@ -1,5 +1,57 @@
>> >  #include "git-compat-util.h"
>> > +#include "odb.h"
>> >  #include "odb/source-inmemory.h"
>> > +#include "repository.h"
>> > +
>> > +static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
>> > +						      const struct object_id *oid)
>> > +{
>> > +	static const struct cached_object empty_tree = {
>> > +		.type = OBJ_TREE,
>> > +		.buf = "",
>> > +	};
>> > +	const struct cached_object_entry *co = source->objects;
>> > +
>> > +	for (size_t i = 0; i < source->objects_nr; i++, co++)
>> > +		if (oideq(&co->oid, oid))
>> > +			return &co->value;
>> > +
>> > +	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
>> > +		return &empty_tree;
>> > +
>>
>> Silly questiong, would it make more sense to check for empty_tree before
>> iterating over all objects?
>>
>> The rest looks good
>
> Maybe? I guess for now reading the empty tree is the most important use
> case we have for the in-memory backend, as we only write in-memory
> objects in a single caller. On the other hand, `source->objects_nr`
> would be zero in all the other cases, and jumping over the loop should
> be fast enough to not matter in practice.
>

That was what I understood, okay so it's fine as is.

> An alternative I was thinking about is to store the empty tree the same
> way as we store all the other objects so that we don't have to special
> case anything. That has the benefit that we can actually modify the tree
> object, too, which may eventually become relevant with regards to an
> object's mtime that we may want to update. The downside is that we have
> another allocation here and need to eagerly initialize the data
> structure that stores the objects.
>
> Patrick

That would be good too, but I also think maybe it is fine to just leave
it. This is simple enough.

--0000000000002be57c064f053c57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9c3024d792412400_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGpBQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjBVQy85bWRyT2JRcTVtMmZvZXZNQWcyY0MzZi9lNQpnanZ6T3hmMEpx
ZVJNeDNJVlJ2ZWtyMkZJNDUwTHdjKzJVN3hZMExHRjB1N1o4alh5cTdCdENnYk84ei9XaXFWCnU1
SUtBelBEUDY4SVk1YWlBUjNFU1pnTzZ0N3d0cmdwUTY0emtTV1REaFZtbkZLek5lUjVnTzJkK0dM
T2VBU0sKVU5PTC9RZjJjNXB5ZFQ1MzRpZ2lHd1RDSVV2bVVNVFR3dUZPbnY3NlpDNisrbit6dVFp
ZFNveUdCdWR4MVkvRgovV3MxOC9kL0lqZzkrZW5xTU9Eek1SM3hnbW5tRmhEckdlbVdBNkdJS3hr
TzhKaUp5UlpTZllyRDZUS280V1hEClN1d25uQ3NvQjBPTnliRFkzck91ajMwdjc4SE80TlJDVXNB
Tmp5R1Q3UzhUZ21xelI4UEFaN3V0ajRBQU1XM3oKR2J6aUw5M09Ud2lCT1dRMkNMRGViR1VBVTYv
dHhzNzdGN3d5L0NRTGhUcWpja1VYaHV6L0hNNTFTMjJlODlqTwpGdHRxUk5VV1E5aS8xV25wSGJR
VHhTMkZVRWFpNlNiSzNiSk5QVFY2SUQwTW9JaHBDdDhlZzN3dFRGeS9OT2I2CjRYUmU2YnJYSXlJ
R1VyUU9xN1B2Z3ZBc285V0I0c01uU00yTFE1az0KPVlYT1oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002be57c064f053c57--
