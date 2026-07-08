Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9B42087F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481498; cv=pass; b=fgwyt9H6SsLKos+9SIezEWGPp6pAkk8kpLCM+gkUrEU/BoGHNV4p7cGh3XnQFPURbxO+LmsbU7J56OxilXZm2+SIrmJtRzD0jLvzv2noiTvSN2wmXjutWp+tqcMb14VpDs/3RlWtew6mBlKSfGGQh2QaqFN2uQVk7FJnOxZuyIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481498; c=relaxed/simple;
	bh=y/+3tAMwwTZ3rb8IbQhui3FfRghR3FfuyY83oJZHxRo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZA2CF3QfkuxYpzKSyWNSp1Y9KPxFowSLM6zerT26hFJdMt1T5ds25uMfXhAJDucGM4eMABdz/6ZO2qlQ0QD+6Uw+YB2G+NkQpzJp+IS32P3s6giFn7ycmFfNEjHnA7oi+0UqyPVmtzUfXj6GQwr/p3PaxrWMB0sRq6jjkKaPiQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON4RdhcG; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON4RdhcG"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-45107b8abccso135622fac.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783481496; cv=none;
        d=google.com; s=arc-20260327;
        b=G79YHjhPaFZtrBXpbYVEP1kV3aluZsWiopMHc/F1CwxVKDVM+NCMpHoSZpcsO4YyMM
         xygB5NjTgWD+BZbdYD0N4wg7+UCxHUfmYDheQ7gDR7Rhl8nuW32zN7yJaynP/Lbo9uFu
         KQod40IitIbNlqo7UhYi4MwJxhvelNiJ5KzY9Zg/aMGwyA+R4X+PzEcA5DKt8NrpXEet
         d4tpjL4H5DcrgA5GVHC3FIpKEfHDCZOE+DZ9gKavRRDv3X/lv0QB7SZMnDsFrbRCaud6
         SIRCr/QJCRMwx7rpM9gjZi2h0IZNoxzCELH3P0D3jLS56K83lnJszi1OYC7Zw3ZZzCbf
         hQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mzpwSY6DuTkkkJ8jKLPk+rjx0FHfyhrnpEEO7wQl//M=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=DQ7ZpFNlphhyb/LD0Fv4w+HmXbko+pHOA/6kXWs25t1WV5DQVHG6OfDmNEzqg1DL3T
         eCe4qhlyY4pCa0Fya3t+eg1ZFO5R/TmJeoFeO1r9tRNM/0XbuY/Tn3qOI7XfaWOqaWLi
         W2sVu3PIYZD1jEDK+/d8fcPqrW/gFAq62WoSo9xcO3W90QWr7hZZE/WvdSKIjGvsv4g7
         r9jx1u3rDXDUkVrjp09X5hf7qA4Ms8WLlsWAlBE9v+7f4jqknfZi6DsjjveqTSbE/tzd
         oGLjIOcHlNjC5YQcmJvcVVww3q60+Jm8MSA00ysVevTWFCvFZbKzdkcxs7hnvj6S8Ae2
         FbCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481496; x=1784086296; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mzpwSY6DuTkkkJ8jKLPk+rjx0FHfyhrnpEEO7wQl//M=;
        b=ON4RdhcGAWcuxDzAlSx7jZV3Y46Jx7xYxsekFdi6pI9QIdOHHbaqk9tpAC8Q5lxsmp
         TL9JAjaLLABNKvro5nKPbO5TLG3LnJwkdQTar9A6t2P5YMAcl0kZsmT626ta9zUWv0LU
         xNqr3Fz3OoXtUREP3ObKoq3+DihmbFD33R+ib2n2HXaU/f33N7rwMXs1gYfg1tM/MhBw
         HeYXbKnqftHLAdagNogYKlWvungfTQRg9VmezqDdX2OwGzyBuljfm1H4bA/mnGfF5p7Q
         HcQ2ESjutPuOfq2JA68xhM/TgcfT/8s8cGcEpkw9ysc9JJNRaGWAQ+7kR9LdYdeSRoGN
         o29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481496; x=1784086296;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mzpwSY6DuTkkkJ8jKLPk+rjx0FHfyhrnpEEO7wQl//M=;
        b=oW8DEPJEEh167xm13ori2neUvbODKnGOhTj1j7EGEehXUGhwEpb8wjjnSqmjcalReI
         5hlscLIlG9dl0Z4tQ+masj42PlMC7TTm6EY5XXD2PcMnfU/jW/YrtXkmqqpnbkONOysI
         uirCcK8w2ZDFFz20/pNns9OzlIyAo7IPLkglWfBpZi5fcpm/4trLlX6pxUIqYXh/s+PM
         7ij6VCKI+pQphmjjYw/ZTBXleAZ9BnBbrwmxDbhh+gqAJWmU8hpYDHJIOcYxb4+IBz/b
         aIV0iggzpfz6C4j7Sy0QiGhGqPDL77Ujny/oD8XVpTwxl00fwxgeJzmUAJG4MMjb7EeK
         MZWw==
X-Gm-Message-State: AOJu0Ywegsuzwr+I8Unyb4R3xyy9Qkyi0bhNTi4mrd6ucKQcLBQEQRaw
	gMMMoEhedaHAR7n2OoeTvVuBnQBhVkUXx0giEHmXs/w7V86BRHOUR1/wFwX4ohVWSMq4Aky7VVT
	+NQpM07KJGUba1b4SYQ3KYnXQr5vMSYQtdjTW
X-Gm-Gg: AfdE7ckHiaXnAtEB3oJKIbwGWyvOkWNKgXKqs3zJWrKtpvC6r4YNkko5B9/bV53Xq3v
	SLkNpgVBR9hsmnwDVzi2btxAI0jIZoyK5wGH/3//iYKqwStY8ZH6vo0Lga9y0UU63QSp+X/78B1
	4Qquk6RB+W8pQtdRscdAkIQkzAlYKHyMsppYBBkWWzQyoW3xZbNvZtnm5DaHKZxyvnjAmKkYmCS
	5eulzCgqg66OTqKkYxLuU6t6di+ma1WdmCaENkAqm1fXNztNCdV9/msGxpcGPudW4+oLA562+zm
	sJFkyRg21sL9h7rbhkxUSN+XnnSnYLizSisKdUd2Ue1ZEhl3W1xG58KvHMOcM3mAQ/WGQT/zttF
	yAaOKYE+h/mxSnsQ=
X-Received: by 2002:a05:6870:44d4:b0:43b:bb18:affd with SMTP id
 586e51a60fabf-451637883e3mr553104fac.8.1783481496303; Tue, 07 Jul 2026
 20:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 7 Jul 2026 20:31:24 -0700
X-Gm-Features: AVVi8CefYriy_Q94DpdniCTIPwgf7MUyauAVW-w569ZWNZBkaMqJiSXC_0p_k90
Message-ID: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> +  A discussion on the list might convince you that your changes are
> +  not such a good idea, in which case you are expected to explicitly
> +  retract the topic, to releave the maintainer from having to worry
> +  about it.

s/releave/relieve/

Also, I might reflow the end:
...in which case you are expected to explicitly retract the topic and
relieve the maintainer from having to worry about it.

> ...It is a friendly thing to do to tell the list in such a case...

Again a slight reflow suggestion (ofc my own subjective taste):
"...As a courtesy, tell the list in such a case so that..."

Finally, maybe a rule of thumb as to how old a topic a topic should get
before a "staleness" update is provided would be helpful, or maybe that
is too contextually dependent / would potentially introduce some
unwanted scheduling contract?

Overall, I think the explicit guidance is helpful. Of course, an author
whose topic is going stale may not be on top of updating its status,
stale or otherwise, by definition. However, I think providing this advice
up-front will encourage authors to be more proactive about taking action
(notify of abandonment / handoff) before a topic gets too old.
