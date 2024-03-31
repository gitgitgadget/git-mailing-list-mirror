Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176918495
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711872680; cv=none; b=P6Sz3nJGF0RcSYeZtvDrZiSd+9egMB4/rPoxdeT6XtJvMuAemKO9lSrjqmfhP92T1mPvRfWWlRdQFEOVgFUuTf6udfAEpbeq8cUdxPBvcCrK8mejttDizSSfBQxw49yMsFtiQI2YhQRAk9DeEhw2iFu9XNfcuC035syYdCwIzxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711872680; c=relaxed/simple;
	bh=EPNBS2lW9kT+I6Gx56Ft3i6ilBf13vCa19YZe8W9Ce8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L4hWu/wXfna/OPjYFdmgNTrMdqh98pOnEX33cyYOa8113lBCsmovnYGNEcPd+MgrUv9P0iPGHld3r7ZZrxSbxnBi7d/xMygzZWqB353oerUdldbY4WarWHcgX91pcE2Kt/ctD5QsWF66cJ0nYcexK2yNiEhAigAMfZBFpqmnLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESl84dy2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESl84dy2"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d599dbabso4047728e87.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711872677; x=1712477477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZMxp7L6nYf1iyxdX31WtCe31AJ+2D2s9JqJ+cI6eYCg=;
        b=ESl84dy2YBC4Axh2E8PLyVvnGlVD/mt7eZn+keEasgjrMPRILlecYI4mDqxj5mWiJ4
         fEHQyKpDUMiW4O91U76Z59VdCgaQVNvU0Ocw2R/2nEcssWcOFbwoyl95lRPIkKVEYRkZ
         kdtsunr88kT1hhnbhdBwmdRxCNkW53z+XoY9OKAV87mMmGFRrisoImrdUuWu7qM6/uPG
         k/c4hAFrlgjm5m/gmjYyUSjSkfJQDlqLjwfF23uzyqwxnoebBNoFJb16DcIt1FPp3rTO
         ujwtR0bLTAODt9dAnPMgbuNz3rXPCDD5Ifj18ghEgBmUwpNZupkkGo+jmRms8WaGk9tM
         JErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711872677; x=1712477477;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMxp7L6nYf1iyxdX31WtCe31AJ+2D2s9JqJ+cI6eYCg=;
        b=f9yndpXvtKXY0C/ZEexm+V0e1uAepo04c1XEmpUlISufAu3MMVrKohjTm58idrzi05
         rsJxFk9VnvWlF8gDSVs2Qjnek5/MljNzM5zcbpsSTzGJoIR475n07GL5fw0Vi1EhUucn
         eJ87m+Qv/vh2ylxYx9oZWuzOWjeGL5IN9+OO2Xc25YsFx5WHOicfBJzRducHeOmDA2Gr
         JskHWm1pC6LlQithcOwZhMJR1IqaHtRFsX8pJURIzFAlHNmBod/COdxh8cir7lAlYmu+
         wI80i1DK0BLWA5JrXmfPh5NAJMqyB0wU/SfjiZ585pzb2CIs4/8DTJf5J5r0cNOIiu4Q
         VbiQ==
X-Gm-Message-State: AOJu0YxH7NCBzXH5ETq8ixZU7DaRPzAdciVL3z5/5CCItm+RZA4I6MyH
	XjOsIt58iHkl+8B2KZllYXvUKk43qUjeMvvO4y0kwyCrpS0kqCBr
X-Google-Smtp-Source: AGHT+IGZb5Q9sNjN2heyBvJBV3fX317nvMMuP0Dl+X3lRuAvD486I6K5XFESvB8i1NthCz4JWHHhDA==
X-Received: by 2002:ac2:5e9c:0:b0:513:c4d9:a0d9 with SMTP id b28-20020ac25e9c000000b00513c4d9a0d9mr5324629lfq.22.1711872676914;
        Sun, 31 Mar 2024 01:11:16 -0700 (PDT)
Received: from gmail.com (26.red-88-14-197.dynamicip.rima-tde.net. [88.14.197.26])
        by smtp.gmail.com with ESMTPSA id fl20-20020a05600c0b9400b00415460607b0sm10356041wmb.31.2024.03.31.01.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 01:11:16 -0700 (PDT)
Message-ID: <3e35b731-333e-4b46-9c0c-089b5c47fe99@gmail.com>
Date: Sun, 31 Mar 2024 10:11:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: omit trailing whitespace
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq4jcooddp.fsf@gitster.g>
 <fc002d62-6efe-42d4-b562-c10d3419fff6@gmail.com>
 <4c8da56e-974b-474e-aefe-1ced5ee69327@gmail.com> <xmqqcyraj3z7.fsf@gitster.g>
 <0f43cd7b-a366-4ec2-9577-93708e21f2ff@gmail.com>
Content-Language: en-US
In-Reply-To: <0f43cd7b-a366-4ec2-9577-93708e21f2ff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Mar 31, 2024 at 09:11:59AM +0200, Rubén Justo wrote:
> On Sat, Mar 30, 2024 at 11:43:40PM -0700, Junio C Hamano wrote:
> > Rubén Justo <rjusto@gmail.com> writes:
> > 
> > >> >  	for (cp = buf.buf; *cp; cp = np) {
> > >> >  		np = strchrnul(cp, '\n');
> > >> > -		fprintf(stderr,	_("%shint: %.*s%s\n"),
> > >> > +		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
> > >> >  			advise_get_color(ADVICE_COLOR_HINT),
> > >> > +			(np == cp) ? "" : " ",
> > >> >  			(int)(np - cp), cp,
> > >> >  			advise_get_color(ADVICE_COLOR_RESET));
> > >
> > > Thinking again on this I wonder, while we're here, if we could go further
> > > and move the "hint" literal to the args, to ease the translation work:
> > > -               fprintf(stderr, _("%shint:%s%.*s%s\n"),
> > > +               fprintf(stderr, "%s%s:%s%.*s%s\n",
> > >                         advise_get_color(ADVICE_COLOR_HINT),
> > > +                       _("hint"),
> > >                         (np == cp) ? "" : " ",
> > >                         (int)(np - cp), cp,
> > >                         advise_get_color(ADVICE_COLOR_RESET));
> > 
> > It is not guaranteed that any and all languages want to use a colon
> > immediately after translation of "hint"; the current message string
> > with or without my patch allows translators adjust that part to the
> > target language, but your version will force them to always use only
> > a colon there.  Is that an improvement?  I somehow do not think so.
> 
> I was just thinking if leaving the format open to the translation is a
> sane option.  Maybe we can move the colon to the literal in the args,
> too.

Just for the record, zh_CN (Chinese) and zh_TW (Traditional Chinese)
do not use ':' on its translation, but '：'

So, if we go the way I proposed we'll need to move the ':' too.  I
still think it's an improvement.  But, optional to this series.

> 
> In any case, the patch is OK as it is.
