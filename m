Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108249;
	b=e37i6ZJQuIrkhdqYbVyCyz/VqTOfodRgw+y01BWTXHEJxQNIjwCL7u0ERtoaVxPT0eNq
	 wDjMPJIoBPRu28JDksyKIWIJZUkTB4ur86en58IKbNWRLMJLY31hFeR66PteNSCGfqQgK
	 J+hekO9/M7AUaSpoXvFy/0NRsHWSR5VG9dkSqu2UhtLaBBvPmISBvl5kxLen5f4HvRTho
	 bo944spcb1srJtMfu28D0lMwCWI/txvD807hszfR3pkC0bejE+LDn4aVGuYAoiweeCpXc
	 W0bS07BNW09FazPsLyu4OuoPcMOSmziiQSEiM7RQZuvLCnkVBRcjIii/kq00k4tbU3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=HI3TvdQWSoyFDSLo75CqjSLtorEOR3XrfVjh1yRd8EA=;
	b=b2vKk5lJv/hrYX8qPZa0DF7Dp4+Z/M1wcCNbgWZwbOm9gK+EgxwOFUMnsct2Yel1hvJ7
	 FyciUDHgytXTvlQy8ciB3NnHfDpoU5zoA+cZbLv9EUsV80Yeo6QYV5Z/QKdHTvrvEZYqE
	 rx7FhHez3TioKDcuFeTSPoHKziSZkWA/4GYPP837HYZdwXrsKkg4j0zVQZoiBE/KHKeCd
	 2UJX0jTRJUsLFXdpLM6EepbTxzKa7unPEml7J14rB9Xw4PUv09MQq33S/AORrAmwazaRY
	 p8WBNPs4SAFNkLYnSJ8gX8V9ElNme/lY8+dCBOrciukoNDao1Tf6CvBFuzAvbALmHog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8PnnARL;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57603606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57603606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8PnnARL
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53665358476so45053481cf.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793108248; x=1793713048; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HI3TvdQWSoyFDSLo75CqjSLtorEOR3XrfVjh1yRd8EA=;
        b=B8PnnARLMoZiFkK4m9Gk2Smrmjn3AGw1jnFGw8Vnv5WXX1VNz4eQ6Xd1va/4UsHnI0
         joSy98B98iUc447sEnTilEXWefUMRsNPNYlucRtyetUOT5lc+9JAtGUidNv0H9wHhAtH
         LScoccWWaKOzOvfBKq665Fl1RwXugDe5Q24GWHuO/FmE2pIDGYduGTfBwq93FiIXCKhj
         DjE/CU+fjy50Tz7p6sUtZaDUI+A1VOaOwpcoaCAemHSIuI0dSQNpSY+ekOIgr75ApU7n
         C5ncMrRdtOsKAqn6ZV5XkBmAvDAlvJgpYBc23dxxCWgyoisVz0BwnXd5zBZI7XSknvMl
         GvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108248; x=1793713048;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HI3TvdQWSoyFDSLo75CqjSLtorEOR3XrfVjh1yRd8EA=;
        b=WkCopBsKA0HHaZKyY3soP6SiJwE87Wcsw9EUaeFIzp+v/2DmyDoEqf/+mVRGq2TVdY
         xXuArELjgNAkrAQoy9+S0sQrfphAcPKcAn/Yq5/34rCRIr+mybXgtXzIWjHE+lOsKgrL
         UkK/QiAhowVVtPBdIkeZ72I6ffkFbvNcOFwpWpGSeMg1uF41md77fYmOuWN+kLT7lmTV
         2qbXgxHWnP6iA3ZQJO90uPctRs5d1j8aAQVyqCf+DrdIwOR23cPCX+5Nelfny8+2DweJ
         3gLNyNqEL+WCesSwcgVsPZVVZ469Y8PMmSu721AdbyL/zCo111F/GzepP1fAFjjKb1J5
         oIGg==
X-Forwarded-Encrypted: i=1; AKwUvBxKBgPQPsQMf0kHnKjpELlQpDekI9Zk5p85j42W5WW8hXnOpMrz84MT23ypk7MSEQIaHSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRnreVJLqnSVrbvW99NOt0l71+PrvJlGEzxDA32eLuD5zql0cn
	vlXjaB/bAYCIiRedBoyaoumN1e6y1EcAIotxLfbq97LySd41OvY5pv8H
X-Gm-Gg: AYBFou15lG72duBu6PkKY4eR4RuHpT98ul9xFYxfHeSd0c33i+hbcNP76ma2D5TSEjW
	bUzh60fGN+aCKdn/H3Rn0zkBrmx9qGclZug3niN0al+j1XH8Vg4fE6nnTYRNgZeKOr9Pmg16jd6
	1zjqlw7oLLQhhQs9PrBIV7zKeM6PX8JeAFFLlOTvZMOOB8cjjr6MJ3bzxTXGqJAcyMoLnfFaRmW
	2mbWYOVBQDt+DQavwvLiQubcOmP9ZrS6LQ7NT53osTZjPlwiKu1J4XCLkMSya0qZKiGjt9IakUu
	BG0IBvEbuoLk5kcOBlvUilXqD68JDz/PvSkjlYI2TBhgO80X7pMTEzZ1eVeDBKSu9AxbMKcrEKs
	l4zQqu9Y+lZ3YAMrrlsD/jLNcuhaByufiIeRgsZox1UHkqBvYBhE4EJRhQbci4qKj2ak7B7TgrI
	nfAni6mlCVV3RWrvdvZshPmjQl7BTwaJ8F8yOsCh/qdjBzw/Yr/G3k+LXSz7brIOSWVj1CAw5Ha
	mTJAFdAwfXFGD8OnahAKuHs+0kzEdbHIBv562PvmwYSqMY0WmJuTWr2584V2ZV9suqt7RGctTJ9
	MwGWt1P7/vUKOAH/T1LLOmGVJ7IRRfTJQbD0GxtSArEqr9gz2YviKZ84C89EqhXuzKfUzKluhEj
	rUXmu/cMG0krcV4EcZcoqoaUA8uxFPOXvvqwECl26deBxLAmQCWg=
X-Received: by 2002:a05:622a:14d1:b0:533:a8fe:e43b with SMTP id d75a77b69052e-5383b53186emr157746081cf.38.1793108247981;
        Tue, 27 Oct 2026 06:37:27 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b03e:6cb9:e8f7:7afe:bb4c:405d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6abacsm102879476d6.1.2026.10.27.06.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:37:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/3] reflog: add --operations and --historical-branch
Date: Tue, 27 Oct 2026 09:37:16 -0400
Message-Id: <B734A6B4-CEA6-4CF2-8BA0-A4D8CC4125C1@gmail.com>
References: <1bc5a05e-3d3b-4f56-8b11-2e276cef48ca@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <1bc5a05e-3d3b-4f56-8b11-2e276cef48ca@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


> Le 26 oct. 2026 =C3=A0 06:53, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn 24/10/2026 17:40, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> I'm rather skeptical of this in its current form. Not all commands that
>>> modify the working tree update the reflog and some commands such as "git=

>>> cherry-pick A B C" create multiple reflog entires that are
>>> indistinguishable from multiple invocations of a single command.
>> I like the direction to make the default 'git reflog' output on a
>> single branch easier to understand without needing any extra
>> filtering in this series.
>> 'git rebase' doing its work on a detached HEAD was likely the
>> first, and we may want to convert more multi-step commands to do
>> so, including the multiple 'git cherry-pick' you mention.
>=20
> It would certainly be nice to avoid creating lots of entries in the branch=
 reflog when cherry-picking. I'm not sure what users would make of us switch=
ing to a detached HEAD as some people seem to find it confusing; if we do de=
cide to do that we should make sure we update "git status" to explain what's=
 happening. I'm more relaxed about changing "git am", but like you I normall=
y detach HEAD first so maybe I'm not the best person to ask about that.

I sometimes forget that Git detaches HEAD while rebasing!=20
The prompt script shows the branch info, and git status (I think?)
doesn=E2=80=99t indicate it.

All this to say, I think rebase=E2=80=99s presentation of a detached HEAD
that is somewhat =C2=AB hidden =C2=BB might make such a change more
invisible to cherry-pickers?=
