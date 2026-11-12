Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498026;
	b=2yQAo24ZrK4YobESsbPJmGJXyu1Ntr1/3bjjCK305w39g/WFi7KnIuGqUTYPkbyWI+rp
	 WFvkKJUPZR7kaPUvmfjf9ILNhLhnikenKbA9Z4XkUueyZQRgd4alDSZ6764fWjTN7a9Zs
	 Y/DbuxW7eulAhdpgsok/Odc9wdBZXU18o9rhMdHQ86FPgLSSho0XQfgiAudRKe4+AyqwP
	 Hi0TlDo7QJn5B8Yl13TPeXCIdw9rnm93mQXeoBlB70MP5qveA0UrUh2nDCjsT9MOVFVV3
	 rr+fwygOMY4mOjzsScec0CtPQIfhbEk69+VOfwcHQiWNhu0FcwzsGYcyGB+V20JYtvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/kzDgX0iVeBxOE+BuUu0Md3BHoM3idePJgtkDUzt0Ow=;
	b=C5/7u2W6Weu+MX9Pv+kpmtA2F7BlmSYQ4+CRZnhLXqhMBBGD5WVnd9Zs/8CODBS/J1Kr
	 qkpJlkl2TWLuBmoopLubGY0pnQZ+eyrzBCKFtgP3mw+A+3wF7nNTUWnP6lRvLaHqiaL5A
	 uPavfa50orso31XRxr3xyRm03nwqrmUBmKgNZCTlnDLcrX1cEXUZDeRQvJpJApHLUEMQc
	 cS1VsGE+Qjw2A+++z0KXgZr7YzE25fvGUFY8M4H35L7u7485XzdcA9UKJkGMU6/nmyr/E
	 Ag2gvFps4E0bZinScTRTlu8Lc7mxT1vAOtzzl3ARbLN5eFteOugUm0O30l6tLjJCqfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hDilnkNQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YaZcwMV+;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57E606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F57E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hDilnkNQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YaZcwMV+
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93DA114000D8
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 10:40:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 10:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794498024; x=1794584424; bh=/kzDgX0iVe
	BxOE+BuUu0Md3BHoM3idePJgtkDUzt0Ow=; b=hDilnkNQF428jhK0fnz7Ki6z/n
	FlmgY7xt5pUf3zp8gdfDbqrR4eo0T9LGU9m8eChBDXK2OG4I5/Nn4sQsF49y2GSs
	dfJRRFgWeGbZBlY/IydivqlbqDmWqIQT0iP2KRgroTGxBJHKD4UXvkbCcbPJ6saR
	r5uBTtL/t9rgNjl266AMTY/h05nDMVzXlaRZiapz97MqP7fbAgzILSFxO2qZLqWe
	Y6d9oGHVr6Fpt3l8UFUvxsNTHZT9uEoX8l2iw9LolveRP8Oew+70/FHoYgNsLKNx
	cOn/aTi2f7jbP+NCjSvBfpfNhNeIxQq74ewO3m6SH4w27Mb2puL9RGoezY5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794498024; x=1794584424; bh=/kzDgX0iVeBxOE+BuUu0Md3BHoM3idePJgt
	kDUzt0Ow=; b=YaZcwMV+Z16HMrSFRg0s5p6eXHx0ImCg8w+UpB7hoZGr/qBgAaB
	NovXjI66vmlhEvlhSSHdkm+z7RxvtTjUQ5qjcgNwq6dp4aXBzV1lOMPu3/ARAYt7
	ueO4UqFYc6YksQz+U8Rl1F/MEd/CaBCo8GpYkkXzVvfSdnXBE3MEFtoNNkDwTKuY
	78KdZaBtIYYTaIUseSZHfFhY8qxESm07CW9lHuo/bGW0S66MkDkpHuEeDmJPQJWh
	HpzTtcZpmpGgv+C4/qFiBhhMUoPNlqsO57fyAgiAgvITnWeMZgDLKAqQkJKYikZ6
	zB18IPXUpC+MUvnCmat2LK+Dq+7ww71piDQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794498024; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MqPhbbQCCPaFqpALk/wVGyp0AwYSvP3Oj9gIsShy6kyfr4b
	4YbVl5oH50FaLpCzldhuiAogRgoFemlT4UE0xOEfjPTQ1DtWtjXuGjULsaqU2msi
	Rk1jJM2YUpcc/bcouaKDeiyUvxNMLEhUYPH6E0c44qYLIfhKe07xCfjuZRhX+yy0
	Hn3uHXxJkJba9kj6i+9N0sEKqk6VbEqDeU6u7TKB0hagoX0Ok0KipCrCrzZN7zc+
	XvgTtt0M68/c0/+mf8cKYvXEz1DErDWrJviuEaA/3dmOAAnc8J4VvX6FTVF2aXKM
	E4Qqr+FzT7/L77KnsCyyO5jgIQNMBAoau6+fTGQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4UZkqkdGruuTjGugW7GAtRo+z6M78W/CXt5oTX5JEe4=:6I68RqmJEDrzFM6GL//pADm0m5xn7KEN2hGd+WgQEKI=;
X-ME-Sender: <xms:6N31atPw7RUpM5A_ZxvqqR9XKDeGXD3eKeTjvAb2wdcQ7DPmnO-ntw>
    <xme:6N31aoZ29GHv_t-N1alVuitFm15IoWh3g1F_ijccv4q-eIOe8-yAEVhJf05cM7hH7
    5zu6USgSnANeeCuuefmM3rmappfuS4mOgWvpPLJrD9Esib3C_AtOw>
X-ME-Received: <xmr:6N31astKCLP3lPNDfaF8qlCOPONmUsyBPFa8mjOLTES5JjWDfcV1pycBp8rXRO66MdBgACmz0ZlAS63CbS9_kZMgEKrHIfDpYwn_>
X-ME-Proxy-Cause: dmFkZTGnAm/FvG03LO+2jvYFAFqgi6VOtY3245P3V0nTnqWS+h68SGuIftoy/f3RqwzsRg
    VOXDS8RFocgfkvDaOB6tF2dS3d6CFyRaIs9fsNdEFo2vGnnBnc3qjcOmR0A+5kFsUzj95S
    AifUFcru6PK4Za6EwhCvBD56/56QSZrAXPpU6era1TuZMlfUg1d8bERo8tN++1T4dcSsRP
    syO3I1ZT0Mk8fE+iwTWbGeiC5cCQFTD3Zo+JITCT5duBvsaWI9mdlWcglKaFJJUEf96XwN
    8e8Ux4XHmWf49ZsPmrY8RAGaG8lsUZtzeGBdMLOkWog+YmUMsh5pCxMDqVUZCbynr5GHes
    OOCleo4KxrReT4LO7183QtSi/2HLVivwtrLNpRMeZHnvHYZjqXzkaKof1CJ9XEV8NMSmf6
    ubgWpVvKlVv5vuRino7mtAJVUjm5y5j/MvEyWUpYefyy0k8k4cx9E8JIWsTF9pFOHP9S3M
    fyFtDGpJgP+hrsGYGB1GRBKm8NEZeTOi4Tr44E2UoaR5p6tRgUxSJJbx/1VZz/vghA6tXo
    KvzrL3m4nBQELuk/4+fuD2150cdo6B1oLeGMmRD8ubVMXYHl2NuIlUHtNblSGcLGZ0XPzt
    lmnoUiLVTPc88xx44361z+t95u5QgeiD1NsSPQZodg+Ji8yEymKQ0Gz8UgYA
X-ME-Proxy: <xmx:6N31aqMJVBEhd5jQg99OMSlnM1EuIisSyPC84Sgf8uBjuWLJI5Dubw>
    <xmx:6N31aj6r5KyCEBceLlMOecTlQZ3Tl-dBuAaYOrmP8ApAXaoexR5asg>
    <xmx:6N31agQUZ75qg-Hxow6ySrXQHvOkubhPnTrvt50othIqZN51W20kEw>
    <xmx:6N31agAiXZhrW2neggO2ljSSpvo8ZDXKPTjtwM8qhm8ETvmvfipZNg>
    <xmx:6N31auzYslyV1vPPJCnIwbP4SuxMYjyOdCNcmb4MI3VxfFWiMuDeCzXT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 10:40:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Julia Evans <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia Evans via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca> (Julia Evans's
	message of "Wed, 11 Nov 2026 16:45:34 -0500")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
	<xmqqh5ile4h4.fsf@gitster.g>
	<CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
	<ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca>
Date: Thu, 12 Nov 2026 07:40:22 -0800
Message-ID: <xmqq5wy2kqhl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Julia Evans <julia@jvns.ca> writes:

> Yeah I agree the "it's the parent of the next commit" would be 
> distracting unless there's a specific reason we need to include it.
>
> I agree "the state from which your current changes started" isn't right 
> but I think if we reinterpret it as "the current commit you have checked 
> out" (which I think has the same or a very similar meaning) then it'll 
> seem familiar to folks and might even help.
> ...
> because I couldn't think of a reason why someone would clobber an 
> existing branch to check out an old version of their code.

When I find something interesting in a topic, which may be an old
commit from the point of view of 'seen', I would detach HEAD at the
tip of the branch to take a look at its contents, because what I am
going to do next would very often involve modifying the working tree
files to experiment.  Even a topic that is documentation only, like
the je/doc-detached-head topic, can have a cascading effect that
ends up breaking tests, for example, and I'd be futzing with the
sources and tests to figure out what the best fix would be.  Even
though I am not going to make any permanent commits out of these
efforts, being able to make temporary commits to mark a resumable
state is handy, and when my spelunking gets longer, I do make such
commits.

But of course, I do *not* want to contaminate the topic branch I
have been looking at.  The work I do, whether it is for validation
or for satisfying my own curiosity, does not necessarily align with
the objective the topic author had in mind when they wrote it.

This is where detached HEAD is the perfect mechanism to take
advantage of.  You do not want to clobber the branch you are going
to start your journey at, yet you want to be able to make tentative
changes to experiment, and you want to be able to take snapshots.

And during the journey, your HEAD points at a commit from which your
current changes started and points at a commit your next commit will
record as its parent.

I guess it requires a developer's mindset and imagination to
appreciate why detached HEAD is useful while spelunking.  We often
phrase the act of visiting random commits (often older ones) as
"sight-seeing", but in reality, even when you are mostly looking,
you do want to futz with things you see there.

It is in a developer's heart ;-).

Hope this clarifies.
