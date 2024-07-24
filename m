Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA00B17753
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803538; cv=none; b=GPb/KsVt/0lwtAvv+B+v2/38vLbhdqr/nAoIRbtW8FBE+LxrXtO+VbF4VXDaJGqYoO27Gl3fAJT+KeQhkD45SDZiyDTIuaH635r8dS8n1f5m0ztTVsbDSHbDkwnOSMiBjyXMQ3eqmS8WtXozwf5hybPZVB4YPOcEQ/StSSjLDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803538; c=relaxed/simple;
	bh=/dM5f058iXKjCff5HvFvP5+M/c5sx3E/qD6E/qxHvyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QogXD3yyDzeSxXLoFevPmffS2Tw8iWMio/TH4NsuS1U4nbWtf4ePV2dmRzI+atpiF5Jc1ro7fM6bRXO2mWlPP/VzmEy5dXgoI3dbSr4qrQ0lBIfKopxBb34QN9JAz8qabX9ZjOR2VE1P6LhheOQauo7cCF4qQ6TXz8o9XjqZmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGXKD+T5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGXKD+T5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427b9dcbb09so47535765e9.3
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 23:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721803535; x=1722408335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vNOm/bHYOCoY1TSXCqQUF94Tn0bXuni04F5tr0JnUpE=;
        b=aGXKD+T5U26Z9tADSHaJjy/jBNUtMSU0VyctbWhXNi5PM61+70xVo68Ba4MUu86td9
         uNQE0Le6ik0twyTOb3KaSWisMIHoTT16fGPAY0SCFI/0dLGqyamiDwibL9jtCPhkUxfJ
         nEnZD7emdsbnLRdwP3CflrZwj/sk8jykPsvBmRgplkxkLWwGndG95IJuCgVoRxq0gNlH
         aEnhEH2dyec0H4qRdZdX7mAI79JHHoCfIS38AB90UnDtVO300tJczys3tTavJxykWg66
         KoACEtcY1C0zRJ0xtU/Wbkn7Nvx3xknw4gC2PdmICvlWUKZ5q5LswMkT5p+npvPXJ1Ck
         m/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721803535; x=1722408335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNOm/bHYOCoY1TSXCqQUF94Tn0bXuni04F5tr0JnUpE=;
        b=VuIZzt7YSAjHCb8rXzC2WnWXoD4xRuo86QQYqNF3qooHpNVxO8dbFLdIkvcS6+uWRJ
         gr0LyUz/c9f3JwbxpCHsYxOjRIlJ0QvBxjSCOAZVAjoujc0n6NsLcKCqUD6tQ4PYaL1b
         H1ieyt4a2CLVmZH6sKvUlgfxz6mrKpvlWwP4gL1yLutygpKzer2XYK6G0SmYUnGkC5Mr
         75xtJw7m4yjv4Osb6+f6sNyqoVgpzqxUHCe81DH/oe2F/QMDgfeqFJkeKfSpSzp3RwKK
         sbE1cQifUF8HowT/t8YP3K5QAorEeDDmScatsDflaO8WZgpqkEtnVkp8wAnlF5g5thdE
         a9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX61XJqbiuc3F1Ek3rvFXWY5vg3aDh+J65BHi/t8Wa1XvuIQTjiJ+WjgQJQA6rrN1/sZrJJe+KPHx9sENK8RTFCRkMU
X-Gm-Message-State: AOJu0YwEyPY65cZCWnJdy+et2w+rc9kEo32QsAvwota7JNZcffJX+ClM
	tvzTK1JLNm1vsUMTfvSeLCKcgbQix4uIofNw9wFCNFPO8gfFX7ntAmTpQA==
X-Google-Smtp-Source: AGHT+IH9wTvtm/AAVv+owuxRLHLAN8qejJ+CCx5t79/0aZyYWK5wAA2YuIrMK1pmyiQEYSoBVPQ0VQ==
X-Received: by 2002:a05:600c:1550:b0:427:ac40:d4b1 with SMTP id 5b1f17b1804b1-427dc558a2fmr82048555e9.27.1721803534675;
        Tue, 23 Jul 2024 23:45:34 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9413501sm14420545e9.43.2024.07.23.23.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 23:45:34 -0700 (PDT)
Message-ID: <d3f248de-c424-4fd9-bb54-2314291603e3@gmail.com>
Date: Wed, 24 Jul 2024 08:45:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH] t0613: mark as leak-free
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net> <Zp4gILfskdpc6RUk@tanuki>
 <20240723210339.GD6779@coredump.intra.peff.net>
 <4b1391d5-89c2-41b1-b1de-e1bd26b9f10e@gmail.com> <ZqCOEGfTdOSAL60w@tanuki>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <ZqCOEGfTdOSAL60w@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 24, 2024 at 07:16:00AM +0200, Patrick Steinhardt wrote:
> On Wed, Jul 24, 2024 at 01:07:23AM +0200, Rubén Justo wrote:
> > On Tue, Jul 23, 2024 at 05:03:39PM -0400, Jeff King wrote:
> > > On Mon, Jul 22, 2024 at 11:02:24AM +0200, Patrick Steinhardt wrote:
> > > So I dunno. If we think people are paying attention to CI on their
> > > topics, and we think that we are close enough to leak-free that (1b)
> > > won't come up a lot, it might make sense. I'm not quite sure we're there
> > > yet on the latter, but it's mostly gut feeling (and I know things have
> > > gotten a bit better recently, too).
> > 
> > I don't know either.  Maybe it seems a bit early still considering the
> > numbers we have: 
> > 
> >    $ git grep -l PASSES_SANITIZE_LEAK=true t/t[0-9][0-9][0-9][0-9]-*.sh | wc -l
> >    678
> >    $ git grep -L PASSES_SANITIZE_LEAK=true t/t[0-9][0-9][0-9][0-9]-*.sh | wc -l
> >    329
> 
> These numbers aren't quite right -- you have to filter out most of the
> tests that include "lib-git-svn.sh", which reverses the schema and makes
> leak checks opt-out (?!).

You are right.  

> That brings me to the following hacky numbers:
> 
>     $ grep -l TEST_PASSES_SANITIZE_LEAK=true t[0-9][0-9][0-9][0-9]-*.sh | grep -v svn | wc -l
>     678
>     $ grep -L TEST_PASSES_SANITIZE_LEAK=true t[0-9][0-9][0-9][0-9]-*.sh | grep -v svn | wc -l
>     261

Out of curiosity, I ran this:

    $ echo $((329 - $(git grep -l lib-git-svn.sh t/t[0-9][0-9][0-9][0-9]-*.sh | wc -l)))
    260

which points to t9150-svk-mergetickets.sh.
