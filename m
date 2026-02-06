Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D234F278
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369854; cv=pass; b=mqtRXZD2qZo48bwwbDsnFSc7CjXobl7NlRpaHXyjqs8YOMg+Vrna6EYR7i+2OlC+MaUOMHotcNRRaiHtc58qELYhgIytDUCNqR4003+bePAx91mV6Fh7TXbHU3JceAEOC2gBOyDQvhNBUeXWVFD0DGCVtbBmnK5m/gAUlZqUmwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369854; c=relaxed/simple;
	bh=J4aHKOu2m4Jp3ijsH7foPIx++YhNQKWpyZwJuzhv2jk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgzC1gmP7pQ0rbDuE6iOewKOd3CIunT+z3lpgGe2Lyj9KL67uTpqmAiOB1yXQX1B4BrMLmSqUwvf6KQZwPLLLd/3zXmEE6R/GdFPgKzVPGhTo1XmdR+qX8rjzyHLlzDF465wwDL4jglcVIRvrhZGxNDa8E629aFrah3eYh/hu8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsD7VwYQ; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsD7VwYQ"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5fac15a7b88so477988137.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 01:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770369853; cv=none;
        d=google.com; s=arc-20240605;
        b=URT4GiA0joIg5fsoV5CRPj77napEQyQdfH+y6K8GOBvH/oMV0XhxMkJCbg4qN8zeAz
         BF2xXj7KSDeAaHVapaVoAVziKcxGKpS2wbC78gocuaOXlfqpLTP/C07TXvP2f1ZxGi5c
         zSkQhY2g1rXmU3saUPuAqf2NbY/M1XDT6pb3NtsqY6ib0GIGPG1IucXCGgKq/eGOmpqE
         Vf/Zqh7ZPrGZZqf7SEq+H3wjlF3Hrj4gHTKnuWPyJWuo9JzrcObzdNlCSSYtwYzPZEc2
         h76ImGT2xkV4IPbITcJjmOQCp/+Xue9/MiHJpOD6DgA/ADSskLDBT7eT3Jdfdz+pN555
         3JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=J4aHKOu2m4Jp3ijsH7foPIx++YhNQKWpyZwJuzhv2jk=;
        fh=8abux2T0EnuzHLvme+jUEu0hmERkeYQ30AZBGhSj9EU=;
        b=EeGoyosfLe+Qlhs2+b7cEqJsVuJSidlq1A/wK+CzsBf4pa35GzQX4ZuXRQelZ9ZV8G
         lVVco2ok0+JeGY76ySblcxUyJF2buHijDMCOnsgasQrewK33Mxj5ukvdw1H7pk9YNoRI
         pY6QzpejzwUM+TrQPHvXPzj7hO9RGnubfHgZA7z+3b4fY6um78YYYbC1HNPKlf7ASZ1z
         Dg10BWHAlkF4/p/bylKe5PqBOYIfZTESPcg0Tid6bwPeHiIVyL6rcUvJPzcxhHYRiU1X
         1VmILVC/5ANM3cyFhHVKwSOnN2+mLN7o2IudAC3YUGjsVcDIqd9F9dWIdTY8zTMQ17Cz
         BBqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770369853; x=1770974653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4aHKOu2m4Jp3ijsH7foPIx++YhNQKWpyZwJuzhv2jk=;
        b=lsD7VwYQdiBi6Q7sk+gPsK9qjwY2hdwGxOy6Od54PGmlxW1yMZQUklfse2Y2E9oCx7
         dVIPX48XFbtuM91wMFhk8jMiQ6L8GwKA4acgFANTBdN7FH6jVQtju5Rn412FMDTSFc6n
         36preViMagysoWDSetPTrKi2spkqi88K+vmkzWGIhKbKSM4LhfxaQmx9xQBHEd0jGSqW
         PRyvMo9d87DJgGI7OocqMw6aNLz2So2iVfdLYnlK28WQK3PI4yscY1+IRnRsKgyIxN9i
         knDiL/K4NWKu8smAw2lMzJk0Gt57YwUJVzAUH7D+RXs/zDZa9KBJVhcumSjxEs1sJo37
         u7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770369853; x=1770974653;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4aHKOu2m4Jp3ijsH7foPIx++YhNQKWpyZwJuzhv2jk=;
        b=vcxrVBxQDzN0Um16wLnAQOc+EAxDEey1a4cRo1/uCsJtYejYggJz+X2NAInR6J67PJ
         vfSA/51IFQRvfMH9c1eFS2T2Lmh3/DdrKTsZOTIpqigJb9hYzVauk7DCMZzoZ6Dm4WCh
         0V25h3d4b/SUZL16xJDPiQMbTE5d2CPDxcwP1Tu6IxA1uWy0XpeirMJruxqwpY1XeiLS
         H0mVACjlQOKQmVIeQ8mEofvi8XtaiqvcnnIcFIwN6nQSVRv9RdNHtJm9J/DKtp40MGtv
         HaKt14emarHri+gXUZwH2IAL3CXuyYJS/O4AomY+d8Dl3TP7GY+Od24AKIdvqf1Bz8u7
         pZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZmFBVktM+4I0IgWIsziHMkYSDoDdJJd31HckjVGAWcqYkrr8VyTlrcylb8WIcjEKMKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDix5158YR9UvUAs9SoPUOimCHYVfMP8nDgEaSnJY6Y2sY1tE
	VZ3aOyZDa+wAjoyI5230zqFda7JI3hOQSy3O+IFkpgI8HWCcQloTsEMyhLz7fIdV42QXsIiawUZ
	dclTdBTcVIVXRgxkC8tJK7Y3odoOloL0=
X-Gm-Gg: AZuq6aI5aftdEnttrrnJbPKzeyhN73ELFcdi1fFXGewPznpepix2XPt5BHx6hqEnwZP
	wf0bk1br4jjOr1iQTEsaqS7cfgopm+3nKs0/fm50PdSie6sSccuVlvOpdMapNOyM9ZXBsA6c2TH
	jAmoDTQHerLyTFA5jx9L7geTuxFsgTqL2Qnra8QIUjSxa5dQ4LXGkRhPJr57CjaihOJ0TZhCBUS
	KxrhcHzqg5NNvqSqQ6hIOyf3ykZ61LTZHYQghy3j7QWPTwuk8WCUr31/ycuIy7v2ZVoLgvRVkJs
	QWU5npaaaEBjrCbFVMX71+1Wr5qVOw==
X-Received: by 2002:a05:6102:2924:b0:5fa:603:1d62 with SMTP id
 ada2fe7eead31-5fae8a87305mr409979137.14.1770369853001; Fri, 06 Feb 2026
 01:24:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 01:24:11 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 01:24:11 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260205121545.36442-1-shreyanshpaliwalcmsmn@gmail.com>
References: <CAOLa=ZSkTH8KC04KubktP1EkU4EHYs0CtmUPkPVe74zi0wcTBA@mail.gmail.com>
 <20260205121545.36442-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Feb 2026 01:24:11 -0800
X-Gm-Features: AZwV_Qjlw9gKSH7T6-dFJ3AOMLvY5A3eA9C3cA6g4eLzUqy42cddO5hce0ZDDNI
Message-ID: <CAOLa=ZR21J6sPDh0cUgzv+td70Mwck1-Ev-43OtZ7mYBX17z5A@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="00000000000035a83b064a245ad3"

--00000000000035a83b064a245ad3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> > Some functions in wt-status.c relied on the_repository because no
>> > repository instance was available in their local scope.
>> > There is also a specific case in wt_status_check_rebase() where the
>> > worktree can be NULL, so accessing wt->repo may lead to a segfault.
>> >
>> > Update these functions to accept a struct repository or struct
>> > wt_status parameter, and adjust callers accordingly. Replace the
>> > remaining uses of the_repository in these functions with the
>> > passed-in repository instance.
>> >
>> > This removes the use of the_repository global variable from
>> > wt-status.c completely.
>> >
>>
>> Okay, but this doesn't fix the issue I stated in the previous commit. I
>> do wonder if we can re-order the commits and pass the repo struct to
>> functions like 'get_branch()'.
>
> Sorry, I didn=E2=80=99t fully think through what you were pointing out in=
 the
> previous version. I initially assumed you were only referring to the
> specific call involving wt_status_check_rebase(NULL, state).
>
> So struct worktree *wt is not guaranteed to be defined and can be
> NULL. Because of that, relying on wt->repo is unsafe.
> Instead, rather than depending on the worktree for repository access (wt-=
>repo),
> we can pass struct repository explicitly through the relevant call
> stack, like in functions get_branch() and wt_status_check_bisect().
> I hope I have understood it correctly.
>
> Best,
> Shreyansh

I would say its not that black and white. There's a lot of context
around it. There are places where `struct worktree *wt` should
definitely be defined. So we have to take it on a case by case basis.
Which is what makes these refactors a bit tricky.

Karthik

--00000000000035a83b064a245ad3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6fe071022d978d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRnN6a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGxaQy85MXlpdXRtVmRTNHliTGpwOU1kR3M4dzdyUwpqZmhDa1B5YkIz
d2kyRlhaNk51R3R3T2Y5dXUwc3l2dG9ValJ4Q3J3TEJjZ0wzVUdnRm4vWXdpK3V5bVc5M21uCmRa
eWM1aU84Yk1lMnpTcW9yUUxJM0dlWkdaQnoxejAvNXNGc1VKa3NLTlphZjYvektRdmpPVUhDL0xV
ZTRrOXgKckc2cUZCdHd3cUMzTnV5N0YyTUF2czRXcEVYamx4SVpkLzdBQVBZNWdRSXdid2k4U2cy
VmtrMytGRDl2VHRtUwp0K0JMUTNnNVhBTitEM2Q3ekkvelVWVGNTSWlRVEhaaEtEbFJTQmhqbmUy
d1JacTk0ZEhaUnExR3ZGOUhvb3ZZCitueTdlbHVqV1Z4ejF4M3BLVFQ3V1VZbnRZSkYzQmJYWnU5
MGhvWUMyNUhFSUlJSENPWWZXeEVGWlk2Yjd2M2QKSDd1Y09HUC9OYWJnRytZNUQxenF4Z0toSEll
Vi9iWW81d21PcEZDcVpYaWcwOFRpM05RNUdVRHFGT05MOXdMMAowODI2cUdpa3pEN3g3WmZiYzNF
SFNWOVEzMVhpcVlGNnY2T1JrOGhpOWN1c1liQXp3clk5Y3l0emthWWg0ZWUwCmdlaHl5UTUxc0w1
VlRrS1llMitTSS9kOGpRRzRlUVd0YUVwM012QT0KPWpERksKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000035a83b064a245ad3--
