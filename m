Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49002701BF
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751066732; cv=none; b=ai9eOYK+cPO3QatMGLzelWqFCz7pLic0aGfnei607s558jCrY0s3LL0Qo62euafWlrdUJeJGqdHEUaKSdApgEO7Hg6hlYHlX71EKJPfKgS1ukWia48BIzSfNrjgjNVQ4dRHQ1f7v2y+C8dg4G+7vQSXw6GXt6VVSeIgfGBrL/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751066732; c=relaxed/simple;
	bh=ER6+6XLgWiYwiBWiVKmDH4h93icvUTVx+8HPQPs5C10=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=u3teey6i+ugW88m2nQRjcNigT5QStRltU+EXmp9qVXBfBm/SaKQwu0P4LaSjtls/X4SSLZ9tA1vKP2V2LhbqgCxZyz1Waikg2OPUSWGyhP0mHPWi22rJu8kAnWspXPQgpopsjVOSzNZgjAB2hrH7xFRXH/V8zUVBUEp9+bmg3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ju0niuYu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju0niuYu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54690d369so262510f8f.3
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 16:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751066729; x=1751671529; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBmAt1Lg42BHV4EozJ/guu9axJJRvGPj4mR8V2Y9xX4=;
        b=Ju0niuYu7Fh5CTV6IRMh3aJdlK2iOeIimUEfnKoTyh744JMWA2APFIfNGySDgUVyHs
         q6cvWQ0Y9dAAClhxmxE7Q/3+spM82ys/w1gJRwJ80nxsMBLVjhg8YXY56JRQ0PhbVOmZ
         q04Gp/Wwmgy2lvFh1LmAjbK72vVb8Rko3bxjY1CwZgPUGOD0Op2P83mVQ6qJ6YZU5yeI
         B93PWIHcgppt5wCFLngQ9qf0GjImkTxgMGW7eNw4fVFf5bLHvWkBCTru0DRJeI1gmQe4
         vI33NgQ8HM+9c0IYDM1TxBo7N8X9FM6tR/uoC5NNPVqjJlKQT0gSWJIQ2gHvk0l367eo
         +ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751066729; x=1751671529;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBmAt1Lg42BHV4EozJ/guu9axJJRvGPj4mR8V2Y9xX4=;
        b=WyCFJNxG4qjMAdC+zqWYsiObR493ODEBzCFEqjUKe/bTE0sA3t1NEyNegmG156O24D
         m6IuSkhpK+TlCCiDgh0y/lNgf4PV7KWLRzWutbYpFZwHtAcPFfpicCt7m9BJ3a3oIhll
         2Cm8AivbJkaEsLc6I3yxrDhtJGNh52HqgGNInWlzKy0GdBT7Xys4q63Lgrzv6ptuhEkU
         dBsHrSvwCaWNiLr72QgvArjGLajJADAuOJ3H3qxaCnJSjGRU24zZ3eepryySvK5rc3C3
         YJdavr+2VJGv14Xrbcv84mfVr0EfLyAF6QvN2zzexD7jB1NiH3MyigQ2fVwlYxetF+qJ
         Xsrg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJTrUcG1MEVm2vJz9gEBgcZnTdYrTt5RKqvqj9ARgLpAtzCJj+AnhdCDdkk8VVnkMmbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezOYIZIiAayHxrA7zeRQ1+4qaZiN1avsNZGlAMJ8b/cobzXGe
	yn408XMWhtR5EVflbSw5RqaSGc74KsyOuJmIyVDK8L1YtyE8G/Fi5oLw
X-Gm-Gg: ASbGnctXCGYhjO4tI2HkjBN/cL+UplT7IqS2OnsJbK8YfpvPq0XWpD0YG7m2+Y+tqAS
	FYxYozYhx1k0ujNtQSQeWWskAsyKJMFpb/CNv5JrnssvRan2xXolnbq7NYwb5mpCjkeTPUD9t/r
	QRpPcDZ+b3cWXmtLymPw4lFtex54rLSsuCatfFSiutDnKbTJyYTkMhJwziHDBDGSCrPIs4cz94a
	wbbkcp/Rn9sZ1Et8JTgC0TzjAtGvS+G5v4e0K3iwLigL+WqP6xFjt6a0Z8hirrYyGoY8mBpjQ+F
	kj9nzf7u2flXUzPeTppaKQZ0J5X56fZ1UrcAUoSmXE6fVOuRFTvgu1mjhtMnPNXQe8JfjMVI9vt
	1dN8EY5iE48KDVzelGm80Og==
X-Google-Smtp-Source: AGHT+IEb2dlZ4Zbm3Liedd9YvD+Zc5mKgasHzlj47NKm+L/7NNTSDhFPczEjfcQcu3mbymMJ8brjZg==
X-Received: by 2002:a05:6000:21c4:b0:3a4:cfbf:5199 with SMTP id ffacd0b85a97d-3a8f435e0c2mr3449619f8f.9.1751066728878;
        Fri, 27 Jun 2025 16:25:28 -0700 (PDT)
Received: from smtpclient.apple ([2001:16a2:c07b:686e:f4bb:dd52:cb1d:994c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e61f48sm3924103f8f.93.2025.06.27.16.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:25:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in service_loop
From: Hridoy Ahmed <ariyanhridoy130@gmail.com>
In-Reply-To: <vgailqqh3bcip3gxtdffoo4ey7xjso4xerewxncy22shrzn4k2@25hst4sfgxq4>
Date: Sat, 28 Jun 2025 02:25:26 +0300
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, yoshfuji@linux-ipv6.org,
 kristofferhaugsbakk@fastmail.com
Message-Id: <061ECE45-21BA-4216-8F3A-61D5A8314706@gmail.com>
References: <vgailqqh3bcip3gxtdffoo4ey7xjso4xerewxncy22shrzn4k2@25hst4sfgxq4>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
X-Mailer: iPhone Mail (23A5260n)


Hridoy Ahmed

> On 28 Jun 2025, at 2:06=E2=80=AFAM, Carlo Marcelo Arenas Bel=C3=B3n <caren=
as@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Jun 27, 2025 at 01:19:18PM -0800, Junio C Hamano wrote:
>> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>>=20
>>> On Fri, Jun 27, 2025 at 09:38:47AM -0800, Phillip Wood wrote:
>>>>=20
>>>>> On 26/06/2025 18:21, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>>>>>>=20
>>>>>> diff --git a/daemon.c b/daemon.c
>>>>>> index d1be61fd57..f113839781 100644
>>>>>> --- a/daemon.c
>>>>>> +++ b/daemon.c
>>>>>> @@ -1145,6 +1145,7 @@ static int service_loop(struct socketlist *sock=
list)
>>>>>>          for (size_t i =3D 0; i < socklist->nr; i++) {
>>>>>>              if (pfd[i].revents & POLLIN) {
>>>>>> +                int incoming;
>>>>>>                  union {
>>>>>>                      struct sockaddr sa;
>>>>>>                      struct sockaddr_in sai;
>>>>>> @@ -1153,11 +1154,19 @@ static int service_loop(struct socketlist *so=
cklist)
>>>>>>  #endif
>>>>>>                  } ss;
>>>>>>                  socklen_t sslen =3D sizeof(ss);
>>>>>> -                int incoming =3D accept(pfd[i].fd, &ss.sa, &sslen);
>>>>>=20
>>>>> Why is the declaration of incoming moved but retry is declared here?
>>>=20
>>> Separating the declaration and assignment for incoming is needed so we c=
an
>>> insert a label for goto; moving it up just removes distractions so the r=
est
>>> of the logic is clearly in view.
>>>=20
>>> Obviously that includes the definition and assignment for retry.
>>>=20
>>> How would you suggest to arrange this better?
>>=20
>> I think what Phillip meant was more like this, perhaps.
>>=20
>>        socklen_t sslen =3D sizeof(ss);
>> -        int incoming =3D accept(pfd[i].fd, &ss.sa, &sslen);
>> +        int incoming;
>> +        int retry =3D 3;
>> +
>> +        incoming =3D accept(pfd[i].fd, &ss.sa, &sslen);
>>        if (incoming < 0) {
>>            ...
>=20
> That seems unnecessarily restrictive just to minimize churn and leaves the=

> deflaration of incoming strangely sitting in between two assignments, whic=
h
> while it doesn't trigger -Wdeclaration-after-statement seems to go against=

> its spirit.
>=20
> Will include in a v3 with all other suggestions, but frankly think that th=
e
> original was overall cleaner.
>=20
> Carlo
>=20
