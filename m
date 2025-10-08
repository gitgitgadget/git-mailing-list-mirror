Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1C22BEC52
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915741; cv=none; b=bjPSdyhdmT5+iUIbD6LUTHmCNFYygpzdOh2nnbJ3TbWeynr+jwtGwiOomKWIerri6xxq3JLa/pwAcEg1XRy8ctD4mz6nDPpybVyHIgXbSNXd4AJjsVcqa8Rm9eadmhJBTylLsfy0iW6+3oji9rp+N3BZeTEshTEz/ydr2FWCPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915741; c=relaxed/simple;
	bh=ZaGV2ynDDhfS73gFN9Z8EQSQ0jNGxiNPuXtx7IIHrog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA9nWb+zAMd/Xx0fEOCmXHytKope4B9z18naYWiluW08t7DfafiiZfYw/4/3AEYh2PQYqmwkCuq73Cirx1gwPrrabCrrkK7dM/rr1fIVhTr0xn8oFb0gJYVwPkIjVbzKDDMBIomyK6OVhkwKgE1/01TwtB7uMHhSGtDzTzYo+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STmRBykI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STmRBykI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b4c89df6145so671671266b.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759915738; x=1760520538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJvUeTDv7ZT8jCR2V4v5AOXfZ8E4cY2Gz0FWWOVvObE=;
        b=STmRBykIH1rcQhQiD1VzT0VJo+WyeXJxEx+E/+N7A1SnJ1z74QKI5ByIyFjnJx9A+X
         Xlapn66oAIHmRKc49jI+Q8iqARpZ6pHWMOMhXCXivj4Xi2Ppdc1wgeDvysZP/3LP9EyO
         L89FWHVLMTxN6BQqhiADx853hG/EYRqj/emPWdrpV1K6ymYaKAlaJypsnk47+VICPY4N
         bk2ewzDc1OX1/i6c7JLY/97XuGB3Yyyd4kiSFr5oOudHyPqm4PpvHZB/SDQuWVCdkhFD
         Y2sIm3LBYwkwjhYZJflak7X8VdwR+5/jHnchgjalYG460Hv8RFzjRAF4a9/qLC8FESWw
         iGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759915738; x=1760520538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJvUeTDv7ZT8jCR2V4v5AOXfZ8E4cY2Gz0FWWOVvObE=;
        b=BnmFJs0nMybVy1H6DXd1Sw4N8Gpd3sSOg7WJrm/Oh6nOKk29dSlRFhrqahPM7QE0wR
         giVCGh0/lT6J6QC5cyOEbch/HWblEo2+nngSiMRMAVZgZcQtQ45B3vGTe+1sNcmlppDb
         aqRC22TAh1O5o+qgd9W/yhJooI5K2WNIxJcrdYfolKvvD0cthti/gZxn5rnuMIJtN054
         sVJM5hEbXUADkwp/dQZSvgu2Igh4NqR0kiBzY6SseQOrRdsQk/UpHbnLyuZxesrq0FCb
         6pQWktR25dZD7mQF+/FW6a6N/Gfm1f5KcmBLrwcuTphbb3Vy/W8u3gEjDTOa4Z5e7RB1
         vEEw==
X-Forwarded-Encrypted: i=1; AJvYcCXPVLYJafCJi2eAsd0HOqukFxUYDC0Ps1rnPwwF/DZZhSCF1bTSGX3mnfucAW9b6uRLxoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bQ9Ut1e021CzMW4onPdzwHWuTSotJf20kxJbA9T+pVY8g39O
	S6BEZnUx+gkWRAEHsELngWBM7HvvhFarF6uH1KFlP9KFEajEleZ5RLOmB/qB/ZduCutY1x5/NvK
	qfrms5NJzHHU2GCn8BH9tvnLt98eG/7DKarkGgWM=
X-Gm-Gg: ASbGnctJbgXypj9mvgjiga8p75+8ts6h0ttEi4UlILeCkuX3yWVqcfzLk32e02Ebzaa
	U5XEuxGYdnMYCt93Al/hGi07YW4j2Ndw2CV8B/XjCMxVdP8O6wZIcgz4yc2gk1lXggGYeSzuodC
	ETU17hBnAK+JRZCrz+GYvuRAyVI/i59/J3uqOqVYRX4wV4RAf7lemDn31xkKfmc9FHaY3OFycQv
	NkxmALvKoR37+8GpNV16pseeA/vHZg=
X-Google-Smtp-Source: AGHT+IG4j5k2yBSDA997ZRXq1LDcoP7WFqUjvlcWjBadF9/yz447a7+2CuCHtsB4QMiV7IyHunSNqR61E6PoMJHyKFs=
X-Received: by 2002:a17:907:1c0d:b0:b3d:b8c3:768d with SMTP id
 a640c23a62f3a-b50aa490851mr297104166b.7.1759915737919; Wed, 08 Oct 2025
 02:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g> <20251001140310.527097-1-christian.couder@gmail.com>
 <aN2fG-nS9fE5-2jD@fruit.crustytoothpaste.net> <CABPp-BFcg9M=XjqGPd+akrUOqJqREBmE9+NvO1Q05r4pUcOmEQ@mail.gmail.com>
 <aOBMHqLxNd86vgjH@fruit.crustytoothpaste.net> <xmqqh5wbq5z8.fsf@gitster.g>
In-Reply-To: <xmqqh5wbq5z8.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 8 Oct 2025 11:28:44 +0200
X-Gm-Features: AS18NWDy1RinPy4O8y-TuL0bFmZ7VD7P7ovUNtGR_oRr_emkcXgziPYTMIKcK_k
Message-ID: <CAP8UFD1Bc0bRdty9O0et9T=UL9FtN-g_K3DYUmHUR31waTQ+GQ@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: add section about AI
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
	Taylor Blau <me@ttaylorr.com>, Rick Sanders <rick@sfconservancy.org>, 
	Git at SFC <git@sfconservancy.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 7:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> OK, so here is theirs for further discussion minimally adjusted for
> our use.  I do not see much difference at least in spirit with what
> started this thread, but phrasing is certainly firmer, and I have no
> problem with it.

I don't think it's a good idea to be too firm. It could prevent people
willing to follow the rules from doing things that are actually
acceptable while it won't prevent the risks from people not following
the rules anyway.

Some of us have given examples of some uses that are likely acceptable
but seem to be banned by such firm wording. Do we want to discuss
again if translating a commit message using an AI tool is fine or not?

So I think we should start with something less firm, and then discuss
the pros vs cons of being firmer if some insist on being firmer then.

[...]

> How contributors could comply with DCO terms (b) or (c) for the output of=
 AI
> content generators commonly available today is unclear.  The Git project =
is
> not willing or able to accept the legal risks of non-compliance.

I think this could be understood as if the Git project is responsible
for contributors submitting content they should not submit. I don't
think we should go into this.

[...]

> This policy does not apply to other uses of AI, such as researching APIs =
or
> algorithms, static analysis, or debugging, provided their output is not t=
o be
> included in contributions.

This is not realistic. If an AI does static analysis for example, it
is likely to suggest a fix for the issues it finds. Hopefully the fix
will be the right one, so it will end up being included in the
contributions.

> Examples of tools impacted by this policy includes GitHub's CoPilot, Open=
AI's

s/includes/include/

> ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> generation agents which are built on top of such tools.

I don't think we should list examples like this. It could be
understood as if we ban such tools while they can help with static
analysis, typo fixing, translation, etc... On the other hand some
IDEs, for example, might include AI tools without users being really
aware of them.

> This policy may evolve as AI tools mature and the legal situation is
> clarifed. In the meanwhile, requests for exceptions to this policy will b=
e
> evaluated by the Git project on a case by case basis.

I don't think we want to go into such processes.

> To be granted an
> exception, a contributor will need to demonstrate clarity of the license =
and
> copyright status for the tool's output in relation to its training model =
and
> code, to the satisfaction of the project maintainers.

If there are ever such AI tools trained on material such that the
legal risk is reduced, we will likely know about it. And even though
the legal risk will be reduced, the risk to be flooded with bad output
might not. So I don't think it's worth getting into this.

Thanks.
