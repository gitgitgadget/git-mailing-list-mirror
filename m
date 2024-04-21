Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE7205E2F
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713714090; cv=none; b=qGLqFebworHRfNrikV3YZuMa6omWq4MfGCcpFZBZXU+HUc3p79IH8pDtlMqzWeOI/n2J+dp1duhfdpJEgNx+dSCNDKvFCkFV+x8EEllUgPiZknED81K+VcTnsXSl52lVZvLUxbug3tfmcvTEovAvbD2ohLsP01n55kovb4N0HOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713714090; c=relaxed/simple;
	bh=D6xv+wS629t+W0elhX0VptalnhEx+AusbZzRkaorvUk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2J2wgcOWA4huWFAhJqbHwglJhhLdJ4mNOCaqFereh80hvgt7hzeOUKP9jKsXmItyLtYgsRwiAmskRyisWi0OgrSZZoJ9eP7kHsjmYsweBPorF8Xa3WA9Gz2AA0KvnksA7kPxNfwDxL8xc0gwlCQCP57cOgHyx+5shEkSP1yXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdwJEPk4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdwJEPk4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-346b146199eso2659027f8f.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713714087; x=1714318887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhGynfaMJ/K70TimaXhXHzGjRX5kCTeCwavp5GT49NU=;
        b=NdwJEPk4+30qCU3iB/XmGEM8YdKLYk6tVsEeQHooml9lZQf0J18M2PNrghWcrJNmbg
         YFmg0OvLdsYEnLjJxlNrNdkQO7SlB+gHLFXbkGNFQ+lvohmFHgde4NJvXPqfJkMm2nQK
         e0GKlDFxoAGI8hVqnnwG3+eJNGeER451yFFY+gr0GGkv64gT55UsLHfArXzMtNE/8ueX
         Kcqbe2fkymjXK6yOJx1rJeH7qkYa8efJuVFL+QwpwnV8rSbu9jt9u8gVhQWJC8kZzNP+
         f7hmB3qaTPX3z1xj1AvAqQNec8LOUYt8C2b3M15V+sTR9PTAAYaZdc33F/WJ3ckpBL6v
         Wn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713714087; x=1714318887;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MhGynfaMJ/K70TimaXhXHzGjRX5kCTeCwavp5GT49NU=;
        b=ktYanZUhKcwv6/zVeX/bFo8PyRLejP8T8BrEaPV5XD0nEFj9D0LM2gJhGY7Xqz15Ph
         E+z2m425O/sfpfOqPdP3nS9kQ8PuroAxYH89VJNlA82nxtx9ttoh1Z1lG1ECJ6WJ1RaF
         yA15rxP9n2PMHE8N3AFmOtCfewuRuE2nt2mYAUy/M4jni+xN0Jq0EGrdKQVwujQks/T+
         /jUdQryrtiA59Ri2072Ula9o5jSoj/rGHgF+4lBYFrNp6V6idv6/sDO4+hXMrbCfMUcr
         sphT2/f+SN05gs9dtHMJ4siH5pUUCTVAavwlzQbbr7pEaZRWI/Ozq/yPXDiNeg4saJnV
         irig==
X-Forwarded-Encrypted: i=1; AJvYcCXLxKEBBHcWFKEzYLINIv+2ruXhVFfHWZM+XgeDSJn9cjXIYcneccEXgW6Zxh5k2/bwibbzCtV2oFVmsy72sb0Kb1Gu
X-Gm-Message-State: AOJu0YzdRx/njQRzfU6kPTzDb+f7ojtbbsPDSN2LfJwkMTHi8u4kr2qb
	rHzmxtL8yERarfru81vunB9CB4nsB2sRzvnM/xbLI/SLbE26kRTEUfZEcQ==
X-Google-Smtp-Source: AGHT+IF2eidX2MFA++3KYtVqgCqcaskTKeKJQi53is6gUMV8VBcw46LAIUm+iJGPaJ7rarh6/AB6EA==
X-Received: by 2002:a5d:5265:0:b0:345:66a1:d949 with SMTP id l5-20020a5d5265000000b0034566a1d949mr4471391wrc.0.1713714086836;
        Sun, 21 Apr 2024 08:41:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:701:9864:4109:be00:6ff6? ([2a0a:ef40:62a:701:9864:4109:be00:6ff6])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d59a2000000b0034aaf0f2bb3sm3909039wrr.20.2024.04.21.08.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 08:41:26 -0700 (PDT)
Message-ID: <440ee2b7-2ed8-4c8b-96e8-623ef45efe42@gmail.com>
Date: Sun, 21 Apr 2024 16:41:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] format-patch: allow --rfc to optionally take a value,
 like --rfc=WIP
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Dragan Simic <dsimic@manjaro.org>
References: <xmqqzftqnuxq.fsf@gitster.g> <xmqqy1993tc1.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy1993tc1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 19/04/2024 23:01, Junio C Hamano wrote:
> With the "--rfc" option, we can tweak the "[PATCH]" (or whatever
> string specified with the "--subject-prefix" option, instead of
> "PATCH") that we prefix the title of the commit with into "[RFC
> PATCH]", but some projects may want "[rfc PATCH]".  Adding a new
> option, e.g., "--rfc-lowercase", to support such need every time
> somebody wants to use different strings would lead to insanity of
> accumulating unbounded number of such options.
> 
> Allow an optional value specified for the option, so that users can
> use "--rfc=rfc" (think of "--rfc" without value as a short-hand for
> "--rfc=RFC") if they wanted to.
> 
> This can of course be (ab)used to make the prefix "[WIP PATCH]" by
> passing "--rfc=WIP".  Passing an empty string, i.e., "--rfc=", is
> the same as "--no-rfc" to override an option given earlier on the
> same command line.

The changes in this version all look good to me, I've left one comment 
below.

> @@ -1907,8 +1919,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>   	struct strbuf rdiff2 = STRBUF_INIT;
>   	struct strbuf rdiff_title = STRBUF_INIT;
>   	struct strbuf sprefix = STRBUF_INIT;
> +	struct strbuf rfc = STRBUF_INIT;

Looking at this again, do we really need an strbuf here? I think we 
could we use "const char *" instead as we always store a static string 
in it which would avoid a memory leak from not calling strbuf_release().

Best Wishes

Phillip
