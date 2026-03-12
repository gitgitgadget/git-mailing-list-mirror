Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573637DEA7
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342247; cv=pass; b=p/H5sDXhRb6QNeHPQ2fMCb/5u0NjRzq+TB2OB9ociXzv8E2OKWYLg7B8s/K1xKMa9GbA70jYfwKAoHw5Z7Xybvtlb3GuA4Vwxr7KgT5D243lmJT1qs8A2oVw6ugSQFXdi27n97B1RWA34I3LlMgI8n9Ywl12QYyyJnskynA/Jk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342247; c=relaxed/simple;
	bh=UWAfx65VCb+SzH8zRcuWqJLwgcMbrUTbXeXfvNRhVvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqSHj+rRu9MxDb8hz/I9E2MT6O2erjx/PdxnV9mQIMt03E8oJMofLmG+R2SlcAZ5/rQrD+sEiCMuVRUn0NLQFuuIIK0dopvhgQlahCnont7gS011KFZ1IUJpEcJihqmVDD3FViYOlSXcDehdDjV6yi1oCSDWw2f1IzZ0RSqQgqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am5U68Ra; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am5U68Ra"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffe1c73287so500270137.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342245; cv=none;
        d=google.com; s=arc-20240605;
        b=KYBryP0C5QP78i7wyjJyJ6bskGyP+3rEktUJapP9EDtwlXX7oX2KseX4uGVvw953sQ
         Sl0jxptR+sBs1KAaziCIHEyHVS/8tDNnp+DQ31956yut9H9NHN80gZr49+pGnQHqw0Eg
         qY4ThBCnq/0l3to5efW54b1IRQC4RwoR6u6tOwFocNuYzaZg7DMRGXR+9WiE+6vhsJRA
         q+Y+c65zzTB6niLh5Y/v34Lkvd+2cYSX6v/GbGbkid2v5bFdgKhlm+EpfPK14qtMr2Mi
         opBAqahB5FL4rbRACw2l2p6BoZoRulXkIpCharEHoVaYA43ZleswNa8mewu2Aty55Nu7
         dKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sfNL01KNyCtv5hMgyudy+EsFG0uovXZcUuUTRJ+Ak2o=;
        fh=ZDPFNd+nZFQcRhvBDlHNjSJurlzdrKraECmW4dxMQcY=;
        b=YwA+ldiYf7MEhARwz4RRz6F5w0gAGI3UwLMEuZiiVM1/ScZC5Ff5ve5BhXuMyM7irk
         oYcd+ZEYjxPa8ZWpDbepXdTPnyk2PZCa/U9f1JYvcVOJzCaAyexa6ie6Vqh1rBrF5b+u
         m1gvy3tn8jLt0F7PEFJhI5g4VAemtLxZKGVqunuPAGDgeq9oWmMe/H34/co0SZ/vlEok
         4L9OzIAoqJA3hZhIF3W0A5NZauHwMruk6qKXpLVZZTZV62snxMi3Nfe2V+LTkwNbL+74
         WUDCurd3cXPsMN6yHnu8HRXxqVdPcEVHPCJQ7WWeoWYvpxCrv5/6/3TKamoSnaHTtQ8H
         SIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342245; x=1773947045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfNL01KNyCtv5hMgyudy+EsFG0uovXZcUuUTRJ+Ak2o=;
        b=am5U68RaS37x6cQa0IAzYyfhc/14l0tdbi86hegXbbLQYPbB/66brfKlwc1UCBV8Q2
         Fkol0iHLfLxb6zfr+2TdBWJa1m9oCo2EuO9kuSA4HyMXGh0hWNlebI/8xIbrf+MuHkFv
         Ftzv7fYVwvW93zFG/pUECvcP1f7y4u7vdTbrizuS5xaASgs84wqNlmBtO3Uh+IlWiV1R
         Q17Q0nGRC9PgNHkj6cz2hndWsn7ARD60BRmxQB3STdnyFmP/oDvSSNjkrpOS0yvImYQB
         XO8GxQSoRWGeAc3PTH3ftFB4gEQEmKmmJ6yYuxuMwy9PqaYIzU10YWcaIdIJG0H0qdo5
         fD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342245; x=1773947045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sfNL01KNyCtv5hMgyudy+EsFG0uovXZcUuUTRJ+Ak2o=;
        b=I1Y0D8yNkNDqTMu293HMIkw3qxcpppGhJI8a7sIFeTWNJm133XY+iJ8vtrct1SDefI
         yvzx+q0suMzIbiWPjedGb7rZgT6UMaX9Ey86xqgZWKESuOSY/K9gmiYyTTzNQKKfJU7t
         yHgRI0nopy8gq78/UbC5p2WRrsoFypxENnfGMroRZOM/WWpJGwzFRy67r2rwsb/CtmWH
         /3GsMb8cmoe1vxZqOBvXWEnDmaTwdbrQI5AWdw1vS6pcMR3hm1CaAPoztzL3FhMaMfM0
         Gc0A5SgdKxJxnbILdEibo76+NQEai0B2rQD50VHbeqL8m/h8VkqT9d7yRQ9hIHHh/kLs
         I/9w==
X-Forwarded-Encrypted: i=1; AJvYcCX3R5gsm+Z0avJglaGeBWufSq5rmFTMN02lzc417g00ka28F2+X4ecRBDV6nAIr+RVlttI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjA2K51WxiCfjvf5ljkJPAEUkkytNx3bzX3/5lk7xN5BpkeCd
	FAX+5uDYkucpXphnMuISq1InWeqIxSOl7sD55+AhZovgcIENTE1sQ9XoL+a+6bEGRJTnWY37CYb
	3yhrvuKK+gl/qW8mZ1RMPhkhLdebyq9IO/oc4onF0Tg==
X-Gm-Gg: ATEYQzwenoYfVJfuOFn2cK89i6xiOWRIXc0jRthmAZV+rnhnGT10YclAek3qzqO6Dph
	0czx8n3sHeQO4YfFCH91+Gz+U+8DrvZzVGm0N7jX1eC285aJjc+algGvSFLFs/HfHwCNjz283ZG
	arriR74FHZvRlL5birVio0EZTq001q8bNaPfXuHnVOpQByo4zjbj8OKmkjiTfEKAT2YJIKYwMoO
	wGBWqJy3U2dDG5l450Wjshj82pF6DB9JhT354SIQiQt/Hcode4ybf2huPHLFvbqV6fc55wmV48r
	BZgX/BjpzznbjahoOq1ifRz0DWV4SUeoNcGtlYvogaAmyXs28ylx32v+Lwj9asqHncO+HHJpMua
	GCuOG36QuRF3KZpLN+VAJvp4WDuDLAxgWO4jDvdPHHkntZg9WQaXMjqQXmy6QTofNVMIky12qH7
	sf2wfnJkaWbjGUIsc=
X-Received: by 2002:a05:6102:94c:b0:5ff:f516:a2aa with SMTP id
 ada2fe7eead31-6020e20920emr252664137.12.1773342245079; Thu, 12 Mar 2026
 12:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
 <pull.2233.v6.git.git.1773288013936.gitgitgadget@gmail.com>
 <xmqqms0dghgk.fsf@gitster.g> <CAOAgETN-UVtee5OjjcLE45sRxajCkgF3nipBqXpec4JjN8+vfw@mail.gmail.com>
 <xmqqwlzgev16.fsf@gitster.g>
In-Reply-To: <xmqqwlzgev16.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Fri, 13 Mar 2026 00:33:51 +0530
X-Gm-Features: AaiRm50GqU3p8a4YPQZzGggmVEsdot8Jp6nBvmJNIX-lubYzt15Qk7vsD1mZ5wk
Message-ID: <CAOAgETOd7-vPpBK+8rhE-i_vpqw48gDBdc3QPm3xWOR4w3c7jw@mail.gmail.com>
Subject: Re: [PATCH v6] unpack-trees: suggesting 'git checkout -m' with its repercussions
To: Junio C Hamano <gitster@pobox.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> write:
> I wonder where this came from, as it is quite unusual to have a rephrased=
 summary of what you respond to.
> Is this LLM-generated summary that was copied-and-pasted without much hum=
an brain effort?
> What is more usual is to quote the message you are responding to.

Actually as suspicious as it looks the mail was written by me only and
I thought that each line was as important as other and
I wanted to reply to each point you mentioned
Sorry for shortening your response
next time I will make sure that I will make quotations direct.

On Fri, 13 Mar 2026 at 00:26, Junio C Hamano <gitster@pobox.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes :
> >> The commit message should focus on the "why" and "what" from a user pe=
rspective, following the project's standard format (problem description, th=
en solution).
> >> Also showed an example for the same.
> >> Also, note that "extention" is a typo; it should be "extension".
> >> Having said that, I am not sure if we want to suggest "checkout -m" in=
 this situation after all.
> >> Pointed out the difference between "stash" and "checkout -m".
> >> When advice requires a multi-line warning about potential data loss.
> >> The goal of these messages should be to provide a clear, safe next ste=
p, not a list of advanced alternatives with caveats.
> >>  After all, the users who need such an "it failed, now what should I d=
o to recover?" message the most are relatively inexperienced users and we d=
o not want the advice to be overwhelming.
> >> Suggesting this "one-shot" approach to a user who is already in a stat=
e of friction (and likely less experienced) might be providing them with a =
"foot-gun" rather than a helpful tip. Generally, advice that nudges users t=
oward the safest "golden paths" like stashing or committing is preferred.
> >> For a microproject, you've successfully demonstrated that you can modi=
fy the advice system and update the test suite.
> >> it might be better to drop the 'checkout -m' suggestion and instead fo=
cus on making the existing 'stash' and 'commit' advice as clear and helpful=
 as possible.
>
> I wonder where this came from, as it is quite unusual to have a
> rephrased summary of what you respond to.  Is this LLM-generated
> summary that was copied-and-pasted without much human brain effort?
>
> What is more usual is to quote the message you are responding to,
> trim the parts you are not going to comment on and not necessary for
> bystanders to read in order to understand your response, and then
> sprinkle your comments in between the parts of the quoted message,
> instead of saying only your thing before the message you are
> responding to without trimming (which is highly frowned upon, and
> people often tell you not to "top-post").
>
