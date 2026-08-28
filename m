Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FF447819
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787917332; cv=pass; b=s1QD70JubLUbsaQoip+rxX7X+EcGgcrh7FsBa4drZOruQnyS97CZsgjh4uZn427kXo9wZTArSgQ5IaejH8YxRuIDPmsjUxoKeHvF46hzOCgH1cuQNQ4EvNrQbvTew7gtP41X/N2F8JfEMOWAz/Z+OsShNfvlidBOy+VN28ZyCmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787917332; c=relaxed/simple;
	bh=piDYHmxcJoeK3k1v6P4pOXaNHRJLTDnnS+kEv7Qi8p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuBCASL/HFO6psNrZj847Q6DPR6K6RWqrTMbbiUtnMIy/Ii2K6eo6iCy6DRnMjtkliFTENqIJ0Ruul+nwkSOzwPjLzy7XUR9OUkm9euG4CU96nqNCQT8/qrs55wnFmpRcCVKXuEXICKTgaMDsq6jsSHeD7KJDdJLACPnenEd2OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQFyV03W; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQFyV03W"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d72ae08fa1so7870285ad.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 04:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787917312; cv=none;
        d=google.com; s=arc-20260327;
        b=negW5zRyyr+DN/1oetsN60R44KuK3RXjloX2iVq5HbjEj7qD0FJuNFFBzDT2VVduUO
         tL0O3iACb3mxXv3aoFBqtb7t37DDF0vR4xh9bAnq06gtGYDw+4nVJKYbZInmRLOXEkLq
         n24LnyJoAGoqwnmTgtUL5qXKXB4P/UXz0c4zqAung2zD4HtE/EPOSrYEbLVOyGpR7tzc
         kvRoQmeuxAE6yBZg51/dbtq9QbEeRY9hAOx/hJj8BrGCTSrK1QEPF1YA1/2Q52Bc5fqe
         wXNOfMw49zAGsUW1DFUOX+05QEGjl9xOgFVw702x7yxL1hcsL4u40zmszcTBqstWFxMl
         3L4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BdAnxzy/rhrgsFzgSCCjcVbrS0RMok2Ex1YatIiXBos=;
        fh=cqVfl2EWxvXzBfR70BZqH7D8VzdjjlalI/XLH9zJF8o=;
        b=GNejJgyPRG+2GBXb5RzmFOoVSzCkAk0SGmm5nnLjR4ZM30Bnq1+k+k1D2+q/eP2L1E
         F3p4TWB9WJPodI/P96ROwvKiucyfFuCQrArpA8S/IX8cRM1aXCjC/Ml7ltH49Bq4k1MT
         28BZRcG2Y3NnjDxXwcLqK+LexLvv/B0PQ9QdeGB8iLTC9WyQr0ivRN1IT3c6/C4pqQ9v
         mm/MryEyicQhg6AGe4G/FfDxCjwn1cmxLpvGeip5eaiO3tVWdrvRblQxRYBzSHijh181
         OjgY0DvdzWm+JnXX9tWGx9F+sZdoGg4/h+7HP/112tI2QFXy/q9tK5dLDCbPcM6zktWi
         m6qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787917312; x=1788522112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BdAnxzy/rhrgsFzgSCCjcVbrS0RMok2Ex1YatIiXBos=;
        b=AQFyV03Wy7iVIdsIxOj9aDWDopy0n/j+RH52KgbRu49pxUZUR01m+SuMm4H4Lu1dNg
         xiS1+t+GcXVsjHc/Nh4ikRfG5siEnvfS1KPLl0axEh91vm0Tpr7G0HP95tiw/Wp3ApzN
         OodBGG2FwLDZlngnmN0gr8hQFdQfXxFUnqIZSi78PwGLs/r+eDswVD5D13SsVF7OTKpE
         W/5+VMnHrD4rSM1O3IJdvgI40MQIBwLC5In47UGI6+3E0PW+p3slwnEHS8QjsTvm05ZI
         gQ0rkpPt+E9HceO9t2PufNJRZRN7UzPJYbZobtk1eG+XinbpMykZkyozrEJwfU2EJn8i
         +ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787917312; x=1788522112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdAnxzy/rhrgsFzgSCCjcVbrS0RMok2Ex1YatIiXBos=;
        b=b4yB//Q8Fumh2PwXeBiYrhdGlsv77ZGbT7hOWoZit3QLm5NsbPr3hGkaN7FtkJ4h1a
         1zyOpIkklbYLA288sy24uy3h/B4cN/bLFtw13vLurSSkFRwrYiv0lj4LkvrQvrtjEaKF
         EleBAveHisLVY09evVgMVDgnPPHFZXE/GOzz6Imbhw9fucXXgHPCILLnhkbvR43kUd40
         bKVsv/5sgYZLVe4wJVGsAlfeR0oeqFzcBQq7UnN3GBCJjQB/60/8I1qE99RfNWlN+V1R
         96IqsBSqmqkcn2dkhwFp76BO4p+n4VevG21sWxu49Ri1VqZ9dxMyFaAE/O3UkOvtdbxH
         HbWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsMn0rx3ctc2Zi5/c9O0ARCzSbAipYVjSqdNi/e5+iGjE5CO8FLcgkHot4PsYcz5U1AGU=@vger.kernel.org
X-Gm-Message-State: AFuF++mw5kHKqpa8FsuA1A9JuotOyxaBYl5QqdvtL6e3vOPgNF3ufkpg
	YflmgmW7zpkInsWn26/VZrjcje7+CNkG9ljMyju5Jt+HKv9+V8LGoJq/bGT9Hj3fcN6g7LKXTv/
	QPtye/AeQETLuWBQV4BSOtfFHmaEXZY8=
X-Gm-Gg: AR+sD13Y1IvgG2MEirA1pKABPkBY3F0oSLx7LLXo5VLFOnWzN4PwRS5vRdZvCMcdRvV
	1Nms5RuLAxlim+lksFquFZouBE1G1F7s1K63SrUd7piOBp9z5O0BkFrisiJ9TyKH1qtzP3/Graz
	tio9TMQQV9yQqzNaVZCFnHBHpJDKtG7eg8HrGPmIuSpOCoKLwZUA+AhQvla7NyRrTJUzVw3INVX
	AcpnBpkAHq4YuSan6P5vfrMdfB8KdANXQ4kuPI5UwR4RYeKZJjc35pN5RppciIbNyBnpuQe5baL
	AEJoyZANr4Gzx2IRLiEFgRsuXro0sR2DglSx58gDyXjieCM/II7DPxhf3ySksz35pXF4gdoPPOR
	/oFA8o1TsVSg2XmZII5jPYaDSQRq8Mlj+ku0RBjXCy1agTneosFjbenigKoJs2B/JwYlO1UfV
X-Received: by 2002:a17:902:c94b:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2d74dc90f37mr126149005ad.7.1787917312118; Fri, 28 Aug 2026
 04:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq7blb8g04.fsf@gitster.g> <F276C11F-1904-496E-AA77-953724362C9A@gmail.com>
 <xmqqik4v6y6i.fsf@gitster.g>
In-Reply-To: <xmqqik4v6y6i.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 28 Aug 2026 07:41:39 -0400
X-Gm-Features: AcwNN1Xtb5N8d4Szdnq0xSwgM6SDsMAG_VNAbTkrllNrNXXoAEo9jdNqmRngpGo
Message-ID: <CALnO6CCsJGmgmvKyMdX3q1Kr5AnBwYJ=_UiQ9+m7jWe7hv=3Qw@mail.gmail.com>
Subject: Re: [PATCH] builtin: replace the_repository parameter in is_bare_repository()
To: Junio C Hamano <gitster@pobox.com>
Cc: Hardik Kumar <hardikxk@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> >> Le 27 ao=C3=BBt 2026 =C3=A0 16:30, Junio C Hamano <gitster@pobox.com> =
a =C3=A9crit :
> >>
> >> =EF=BB=BF"Hardik Kumar" <hardikxk@gmail.com> writes:
> >>
> >>>> In general, builtin/foo.c::cmd_foo() are concrete programs that work
> >>>> on specific repository (i.e., the_repository), and there is not much
> >>>> reason to rewrite the use of the_repository to use "repo" given by
> >>>> the caller which is git potty.  You'd also need to deal with the
> >>>> case where "repo" is NULL (hint: "cd / && git foo -h").
> >
> > [snip]
> >
> >> The utility functions builtin/foo.c borrows from outside builtin/
> >> directory are being "libified" to reduce the hardcoded dependence on
> >> the_repository, and cmd_foo() can call these functions with
> >> the_repository as a parameter.  But we have no reason to waste our
> >> time updating (and also reviewing patches that make such updates)
> >> the built-in implementations themselves to take a pointer to an
> >> arbitrary repository.
>
> Line wrap to reasonable length.

Yeah=E2=80=A6 my iPhone (from which I sometimes reply) supports plaintext i=
f I
do things just right, but it doesn't wrap lines. It's difficult to
judge where to break, but maybe I'll try hardbreaks every so often and
see if that helps.

> > Hm. What if a program wants to do =C2=AB exactly what =E2=80=98git swit=
ch=E2=80=99 does
> > =C2=BB sans shelling out?
>
> Instead of cheating, properly factor out reusable part from
> cmd_checkout() into a set of libified routines, and make both
> cmd_checkout() and cmd_switch() to call them
>
> An approach like that would help "libify" things.  libifying is not
> just reducing dependence of globals.
>
> Calling main() from something else is not a libification.

Sensible. Thanks!

--=20
D. Ben Knoble
