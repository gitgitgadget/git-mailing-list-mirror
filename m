Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD90111AD
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726393; cv=none; b=mcW+irYEyu4g6g2XAqYBLuyp6ZoYkgWY9/K6ui7GWThBbkjdIES/5bzk76jw3joG74xYv/+p20m0qkI052zGhWDAiv3A/anpBaNH4P4HKtVoaKOBa4yzPofznVNvmf2zrT9rV6soyByBJq2NoxTE6N91mU4ZWGFwokb+7UVaeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726393; c=relaxed/simple;
	bh=pd5mKsNi461RBleH4qxTjMFuwa3y6zVF3aMKd5rlpkw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3Hdzwr2UHY71Zhx1fU5ewQVug2BWJsgtarGacV1gJZK0rXv0UgAEdHn3vDzX0KEPJa/BZnBNF45bED2jcUQF3t+abqgUw8geU4qHkj+HJYxPH/Y1w1UBnd5KqiCc1V2nmal6b6a8pXSLDsAShHYa2fD5/GvUbvbpXIiG2amiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKu8Dp3k; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKu8Dp3k"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23a29c6bd3dso95251fac.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713726391; x=1714331191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pd5mKsNi461RBleH4qxTjMFuwa3y6zVF3aMKd5rlpkw=;
        b=BKu8Dp3k02n1raR5R1hhkolhRrg7dIpaIFaKx0S1mLRX72qNWbGddaJ6vCldQy6CMK
         bWlitS365AlMnWxyihL8tuoIp2JshsEO4pLhc9QJWIUJlZcRcDz34SQ9UDqOb2sTqbPY
         gQxZThp3gnErw4KqMvuVVzZORIp3NfyE4D57mYUYk1yxPJeKEO2RilYOLmxuaf3kwoHo
         S0qClShziByJcjvAtYzf7g3OnqfSmW4G3ZBldEcDuBAN/Ih4n7ElG6p9qkPaBfNmkeDm
         bNKK9jxZWtx6jIXDYpIld021wNApdnRCWxSCRKxNsW4desR2bzqEMwZZTP07RdIicQMw
         AKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713726391; x=1714331191;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pd5mKsNi461RBleH4qxTjMFuwa3y6zVF3aMKd5rlpkw=;
        b=JCKLvQRAXbR4hu5gWqp018v4nKg8S2hbjSOueN/APjMEYlI3OdqIAAA1HR10LIdTgh
         4S/bHOkZOIlKFuEfHMzChCNYy0NHQNmnHlBi5trJn18dQ3G+C6L8/uRKMGgpEGQkUMxp
         IC7lRLltHNPuU7Kn64vp606biApNDcG1vCU4nXthu1GHjaSE+9thKqPGexy//OUSg8gC
         tsRJ+lKQPQjPNUWL0Z4t0MRdP+uV6jvP28hMMnejxu7vlhznCxsNkCjtnO9ybtX3QzOy
         vXXe2OR2KJwrsDlJKiHaLlY6KSR7tNABxNO6lrK8Rft6atsWKCEFXtj4mzYqATMIiKM6
         GMqA==
X-Forwarded-Encrypted: i=1; AJvYcCU6bGKnLzjP3Bqb4RW2PBkhOKDV/Yg0tkmtacJ0G1+VM2Ow9QCMpY6eoOfC0J6LDBCaLdP94gqc6IWpcebGC/A9w2WX
X-Gm-Message-State: AOJu0Yw+rrU2H7aixPpAf2EOkAb6LiGiDmnW166NxBbrS0jPUCyyObLs
	Ewe6SZkZAw0O8R6Z9JAYMlF301LkhLlLduza/0NP27AkWkwOS9yRLcCaxj5EY0ASYTTy34fMyz7
	lay9+VfMZsj3Umi4bN1LBtku2oaM=
X-Google-Smtp-Source: AGHT+IHjeDz/7XxMCQjun4tZoAE2GyBSkYUolaBCM/zLEhoWQvivEV0oll4gdXvFjBaiIHiR7ZsGVGgMqBhq9mMCh5U=
X-Received: by 2002:a05:6870:a451:b0:22e:83e8:2f13 with SMTP id
 n17-20020a056870a45100b0022e83e82f13mr4904899oal.24.1713726390841; Sun, 21
 Apr 2024 12:06:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 12:06:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD19J+KY51hVwQbnF8CaK_ZqqjdqW49qjGtJ8A6UtCJeUg@mail.gmail.com>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <CAP8UFD19J+KY51hVwQbnF8CaK_ZqqjdqW49qjGtJ8A6UtCJeUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 12:06:30 -0700
Message-ID: <CAOLa=ZRrb=MnHZVQZ5WxT5D0HF9Qk5eEnCOhPc=ZS1_32bQgsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] update-ref: add symref oriented commands
To: Christian Couder <christian.couder@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c4d4f90616a00486"

--000000000000c4d4f90616a00486
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 12, 2024 at 12:11=E2=80=AFPM Karthik Nayak <karthik.188@gmail=
.com> wrote:
>
>> The 'symref-update' command can be used to update a symref, create a sym=
ref,
>> delete a symref or even convert an existing regular ref to a symref. Whe=
rein
>> like the regular 'update' command, the zero OID can be used to create/de=
lete
>> a symref.
>
> Is it possible to also convert a symref to a regular ref, like when
> HEAD becomes detached?
>

Currently not, that could be a follow up, since that would involve
updating the regular commands. A quick way to think about it is that
this series adds commands whose end product is a symref. Since what
you're talking about is the inverse, it makes sense to add it to the
existing commands.

>> 2. The flow is now changedc to send an old_ref, new_ref pair in suppleme=
nt to
>
> s/changedc/changed/
>
>> the existing old_oid, new_oid pair to the reference backends. This allow=
s the
>> backends to simply do a combination of changes based on what values are =
set.
>
> I had a number of comments and questions when reading the first few
> patches in this series. I also took a very quick look at the rest of
> the series, but I think answering my questions about the first few
> patches would make reading the rest of the series easier, so I will
> take a deeper look later.
>
> Thanks.

Thanks for the review. Really appreciate it.

--000000000000c4d4f90616a00486
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b4cd6ce7c8f73a8e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZbFk3UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md29qQy85eWhiTzUyTEJyQWN3RUp6eWQwT3pVem1TQgpwQk9ib3BpR3hr
cVRMdEFhaSs0NmorbmhOU3JnMFloWVMyKy9FRGR3UEVDUVU4ZDlZbENEMlJRNllselZTOEIwCnVQ
cUY4Ky9wN09pRXUwcVhwbDllNTJXQ0FVTWRXTEZobFJJeGZMQnlaMDJpUE5NMUkwYnZmSDZ3Vkdu
NGFiNFQKVVFnYkRwZ2dMUm53WDdJdkZjeGxTa2Y4VWgzenRPRDJmc1psQWQrdzc0VXFkTWRRckFv
VitqTDNVRlNwNGplVAp5ZW0zYmJ2anlnbmlRWG1oVCtyMTZTa3g4WWJCWVA3bkFyY1RuQ0Z3SmMx
cHRKWXNJWGR5MnU2MUNlY2lRdDFsCmNvblpCRlhGS2JzakJUWklvT0VldHR3VUtscU9yMFo1eFJm
bjFJZEFVNVdhZkZ5RkVKckswcDJnYjhSTE9rYXEKNm1NQUw2ekI1VzBkVHZwQyt4ZFVWK051OVpF
NjdkQ2NhbXZhd0pPTlROK2hpZGhQVVBoYm1sSkkvb2pJVVVGNwpvUG9DVFhpb1plZ0ZRNmxQRHFW
OGt2N3BKRjRmMGZST01IMnhpZEhsVjdEOUFSYVRpTENraUx0SDJGdFZsOUNNCkhyZXp6TTlucnh4
TTdWTjE2ZmsxNFlJUEhiVk0ya2JTWVBzclRGTT0KPUFvengKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c4d4f90616a00486--
