Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B81395D8C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112015; cv=pass; b=Yr89zAdVKEjcI+iZFBXHVHrA+PJBqoIClKOHMu0Tz6LZLzQN+3hP5vMOqzvNEjxZ7vRsLFNC95619+k6lqeuPNx4TOHZ+vEG22ixr5z/n2WzQGEFGBusTgwnQx2Tny4irMDQ0APRb8JK38p9ZJWwUkErlJsFDPvUVsIscdU/Vws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112015; c=relaxed/simple;
	bh=m2QJXBdj942rX4TtZWD0lhbtN4LM12v6AWEnhtG/t0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0Wg3W4Py7F/bBBIfk7+xqMF2o9DdGK1m6e8Y7Ek26LWRBdeP3Sqmtic2ZjNrWSSCMWeONxGDfHsJLMUL0pS4vq3I0i3y8ikkMr6NCHM25A8250t+a7Laav2zVhv3qOFNHarmR/37qSF/LAVmB2WxIs8+SqGWWtA5s9VAUf/LTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWqhaXgt; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWqhaXgt"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b71557299dso5516294eec.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 01:46:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770112013; cv=none;
        d=google.com; s=arc-20240605;
        b=igvCQdJ+N2oEivtASqfqTly/Ar1ix1J2fWJM4Sb7JYsIA3WfTR5SztbpN9t8IEF0PH
         n5o25kZwLCK+lcSunHQq6Q4iJCa1g/7N5EPXhHSYAIQsnr8JfhdIqXLbHyomdJ08qA1P
         A3MCdCGTVHbEWzLGCIbw6QhuwdUj+b30IAoxprSXxHdAtJtQIN07Ag4ZsCxnQ8vB6DjY
         b/cC0tTCrtECKDbjlkrHCZvAu1k6Vj/5mK4uoicGiG/0xvn5YPjNsdaaq9ZluejtovwT
         JzPZ5Jphhsf/US3e8YD2Z09D6ggHAENpoQAQPINg25uCWP57IqGAKZw8JkZKVTi5RCIY
         bxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2QJXBdj942rX4TtZWD0lhbtN4LM12v6AWEnhtG/t0U=;
        fh=72DZwrL6WutD0dXulxyRnamIEaSbcDDe6zpqona4wh8=;
        b=T7IB4H/7Kgq7PJ8X8/hntp+Ruao2NeKPmxeYnL+HZf5/QWWL43y5HEP4Yg/1Pk7+sv
         FsgMdk4ZQoXWTMFMvhzDjV7Yn9xUYQjqS7QbqIfHkzQLQ8CU4gnrIP7LeW8zv5yxLLLz
         jA5EI6Xh0m8ulZ6pd/TUrZ5F7F4GuC7J5nFfag+/jyj8ByK+JuI5SeWyb7qcuhGfW+xJ
         HVHH/rbM8VJ7Fwjr2gpCY0+gYwZJIC/O0WAWeFtmYBGEyo3PUMsWvfBMYHzkIfA/YQRJ
         II9K0O52/NLU/LRfFga+l8I82sRszkeaz5isWqeyKExTQ2aU368KD0FNJY0kdEH13p8/
         SrmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112013; x=1770716813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2QJXBdj942rX4TtZWD0lhbtN4LM12v6AWEnhtG/t0U=;
        b=lWqhaXgt651+Ay0zM18nSbZ3wY1FmBpwuSIzh0Wy4KLyozjVbx9ln856i4n0tyP1iy
         HQM/sX7ZR1OLebsSRpRg+nt1qgTVPOhe8RG3z+pwF7fbYlw59369ZYF8R17jhB3hoeMU
         bAsgVe2PuCopYUxPFhlRT2XAv98jCPl4yX3NdBFKAFP68kn7oWrVJ2G4FTBoIk2OOii1
         N0P9q2fAYQyl9nBxHlOcvYA3+GoLOqirwMQngn4VVZh2l5+5+EXgaH2GxCryzjpBQT+C
         bPPpgBIq9+BT9vFLNcLrmaBIZ75LHfLF9QsGjdPTJjxG+KLEXhDSfWSARQaL9GNSquJt
         IoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112013; x=1770716813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2QJXBdj942rX4TtZWD0lhbtN4LM12v6AWEnhtG/t0U=;
        b=aB4pgpjsQlpZ1hexh8LnNNOXWQx5mGELFzJCJaLkAJSuox8jXdy/fGT3jGuOqptiLV
         hPhdo8XAxdqSfxrD8vqKv5twc/kl+t3XlPJG3bRgKWfnIkb7U9Kd0ERgCAOuFjeHWA1Z
         s/9lC1S6xnANZvbERZ/pP1uHdynPQsLPwEa71Gxku87v0qEiK9yCss28t/CyUByGI5K5
         RrhWobCil8M4NXW4vXZKcn9wflZpqLbhBXEVAUQnIDVssQ7VrFtV+rTUdB3XNwVNfmOv
         M6Lur1xfuaV4C9YCc3PBhK06iI1J2y+buFxfzKrVh5am6khYpLR+y1f3lx64nmtnt1F7
         CKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVscmCQ4UgGzTHMfmqnWtXFT7BTW4YD6CXxhLkNe22y2h6xzdndow1xD0LpmnePgKRKRdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/ail8SwK1ByM0icyhReUKM8/ntbUwMJsFM2ZEqJhY6zSG5Pd
	boS/8VdWDWmTbZyIgVt7HZOuy1+dSiRWXuKGTHXzfg+mL0SHbD6lXiVYf3YKzpLmgQtuyfjc4td
	n0M+03Gw2bH5NgEUxSKInfQ+BFzDx82E=
X-Gm-Gg: AZuq6aIE0v78HZHP1/ri868VRQykLbKQZZ2IuJCUMFYDEoo83CyzhM1NKtqV1kOfx6C
	7jCH3SDPSkoeNw7RqwhxNptrbdoLn24G951qbJQ+EuqYn2qg2BP6HCBcTOfA2wevZeOsuOtXHv2
	w+GOqZv0GNJoIjLRkgfKqsreJ5K484Dd7dloc4ISFcgXW4jDikXGGO/Ky89vevLGZQIOsbjjIjJ
	YRCn7jFdZsIZZdCr1cwq0GhMsfrg/ZLm9ebXTObQBGYpHjpill0a51G2yoRvvzTy9hd7ljSQh2C
	74cKZuuK/3egfuQXPlW+Q9UNSKaQcushKKrCXbQ2eD65jhSwK+ukDt+h
X-Received: by 2002:a05:7300:ad08:b0:2b0:4c5f:c05c with SMTP id
 5a478bee46e88-2b7c862d9b9mr6214693eec.4.1770112013183; Tue, 03 Feb 2026
 01:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
 <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com> <CAP8UFD29LtG2dRRB4f6mZAHNGqDmDxUV4ULYw3w3OYg15ZBBYg@mail.gmail.com>
 <CAOLa=ZTK-PdJAYfDVPW3qLN+nBCe71Q=E8xohJzbFK=EH8sNkA@mail.gmail.com>
In-Reply-To: <CAOLa=ZTK-PdJAYfDVPW3qLN+nBCe71Q=E8xohJzbFK=EH8sNkA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Feb 2026 10:46:41 +0100
X-Gm-Features: AZwV_Qjx8lHgM6cooTYcFMANf77Lj64xSy46x-2ZJ-KawHIWB8sy4FuM_NNnc0s
Message-ID: <CAP8UFD3BM1TOK+KUPp-BztCH-vOi8aqjNDN2hXO8bogG_cnWsg@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git <git@vger.kernel.org>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	Eric Ju <eric.peijian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karthik,

On Fri, Jan 30, 2026 at 10:32=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:

> I'd be willing to mentor any of the projects listed. I have a little
> context in all of these, but that's a good reason to understand more :)

Thanks for being willing to mentor any of the projects. It will likely
help us better manage the different possibilities.

> Maybe we can also decide how many projects we are willing to mentor this
> year?

I don't think we need to decide right now. Let's wait until everyone
has stated their preferences. It might happen that other projects get
proposed or that some mentors agree on (co-)mentoring more than one
project.
