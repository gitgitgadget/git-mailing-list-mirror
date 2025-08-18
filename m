Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BE1482F2
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561147; cv=none; b=SSheBj9KLfbq9weTO9bZ9PTbi8qfHBA9iYKsWaP2Am1Q5jP5+GtVvPIxjhEzIJVyE+xZVpruUmjpnICqeB7Tj8x3lHgZygUn3Dk/60VSwf4Xkqa4+2OO0/wB/EDTMCuO7JwG9eF7IMgd8+/hhY7yAAUZYx4cV0iEsGp1QtokqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561147; c=relaxed/simple;
	bh=YR7J9kVEPQTiVHaHzlDhV87r+vd9BDODYj4famHM9c8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=e6yQ6q4cPQ3kqs00vtDgCo+0GxRUkun5xkvFBiL5OOReZWUOI0wO0SkxtrHcRedOc5EB4k8F2CfxtoVyT6QsWCFgIqqwur0qV/7mnKhyXz1erZeg4oCVg4ZkIhwPTQOtcR6Hh6K6TBWQstI2g4W224nI6KXVAuJ2khKpbuZUzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYaQUZq8; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYaQUZq8"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e94dfbf7ba1so723765276.3
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755561145; x=1756165945; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJA6O6LflzKzpOUlZYxHRsvfsVIXTz1q0+nG6dQp6tk=;
        b=GYaQUZq8NN8JDCZ0cTkhsq1ePplR1OiWDqSHXap1uAMLMNi5juN7zmN3SHlkduvA7b
         e3tgnm4KYOzYAt+AfoF1B2vi9mKCDi6fQ8+oY0QSQOIy0lYP/RCm7KsQ1c9jU5l0dRYQ
         Y98MJzbueWUlM4RjDLuZucPAvmZH/e6HXEVlshGLNs+WTdsSh/SLvKpKa8I06PaMiTqk
         GA04e3/QBcr6R9qW1qNoiNNRpZq8l2UNsqKx6Ad7HseeviGhVTpohBEBAgDl68kRuqiZ
         tb9FfiPn6t79B2udq3ydyi30E8YUrjThTPUc9cAjsT2ycyo+lZxyGvPH6IKOdQrHlfml
         XxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561145; x=1756165945;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJA6O6LflzKzpOUlZYxHRsvfsVIXTz1q0+nG6dQp6tk=;
        b=Px2taf9Spg4hyrJc5m3YcsRKgdnOmpu3xial4U8/SkCjyMdeix8Lt1IwqZaRAKxcGj
         TgApj21pNgVZ2nt2EzdJWK7HTXltLazb0hdH3jedIyTiLTqtt1YwZeEpU5nLLn/OZ+yC
         ZE+yL8zXoP4Fcs6t55A/TMmc6JBb3YiDCcIlMJw8W1xOMwmEy3aLf5JPtG+eVEREd/IM
         vbfMoayxgDxx+rbZNlkTdS4VNDzCvZWm6lDiYmNMfbFOXttKgRKKDqwhRpBpRhE8/dSI
         vp0dAR0iivFTrl3hZmxjjYWO8mrLtoHfQdG2sxOIu7syb4ehD7J0Tg7LgXScFFNZQxQz
         4ofw==
X-Forwarded-Encrypted: i=1; AJvYcCVgwjerlDmurqdt8iUVjC8Tuf3Fecj+n8q497Mplz7GQLk7siHl6CbDBU5IZ5ktn1KkdIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNSaH6slMAvWvzdssOSkOz2/s3jdwByqm3pC2YDAsprbcQDMk
	v2hSYaVq/O0tSLcCJtJQalBY9D4w9e3Km96YnChdE22BDOTVY1qpHW94
X-Gm-Gg: ASbGncvEAfXWUBjJsiLSTf5BVflV+QSrM+iOGk6ZmgjUsGlJZHpFlO8CUvCUZY7h9t2
	oiOAIXV8A/sbKsaOHdRcBRUElcnQH0YqS+qGi9Rb5ULicTWgSdwUmET4tUq66JTZ3TQAcc/nt0l
	cnIkznz80YxGEVARZ6HHD5u+5reYaBNeiCy7oiTG+B3W/6kS1yx9qL/oktS1p/U0FV53/HUIwsA
	TG910refUOdXzq3N5gWstZSRFJWsQDV3yanOmwsPRnr9s0/WtDYozbedUdTPhLrT4GNKA8xjYp1
	tOoby6r6Gvu1K/Dbm44HiqejuH6UkbAkWfgVSgX1y5m0nbE0BbABFN9/Rf1dKx5YxVsARaxeFjx
	xObvUhjKEMxdhzPLChro8Fty6TE38tfsBquaALlRF0z/TRqn3ulUEQ5mkTnggvQ==
X-Google-Smtp-Source: AGHT+IGkN+xs9MOy/NOCiyJAzXDZ1AtDkAj6HPL43lR/SuN5dSzhGkPdtp2hEniSfTHMhZVn61rstA==
X-Received: by 2002:a05:6902:4006:b0:e94:e44d:aac1 with SMTP id 3f1490d57ef6-e94e6349099mr949942276.37.1755561144801;
        Mon, 18 Aug 2025 16:52:24 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:f9bc:536f:8d5e:1c8c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e93328849ccsm3620716276.34.2025.08.18.16.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 16:52:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 00/17] RFC: Accelerate xdiff and begin its rustification
Date: Mon, 18 Aug 2025 19:52:13 -0400
Message-Id: <2FE193EB-125F-443E-926C-E9460A1CD5BD@gmail.com>
References: <xmqqldnggt2v.fsf@gitster.g>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Eli Schwartz <eschwartz@gentoo.org>,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 =?utf-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>,
 Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>,
 Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
In-Reply-To: <xmqqldnggt2v.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 18 ao=C3=BBt 2025 =C3=A0 18:31, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes=
:
>=20
>> * Code style: Should we adopt a Rust code style of some sort? Perhaps hav=
e
>>   the code always be formatted by rustfmt in its default configuration?
>=20
> Sounds sensible.  I'll let folks with more Rust inclination to
> figure out what _the_ style should be, but having _a_ style we all
> stick to is good.

While there can be room for configuring the formatter if we have particularl=
y idiosyncratic needs, I=E2=80=99d second going with cargo fmt / rustfmt in d=
efault configurations to start (the former is a shortcut for the latter over=
 a whole crate AIUI).=
