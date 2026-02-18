Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB33446BE
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445208; cv=none; b=gNfMsidJvcJpBbr2CNMiqh+ccUMSWOEJORnpq2rkkXSWupTJg6pLOsa8ieTL8CKE1zOxckyvy6N2dknhqnTqXmW/JF7m5qFMUaJE8GEO2ttMvo7E5mGUGYuoV/Ue/G2s5Nk/FmZMHlJAl8dC0jSzU6ReTrYGcmCaW1ipzOaNjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445208; c=relaxed/simple;
	bh=BNAHnvUzk8lZnXgMAzJMVhTJDGywsUwkS0w8fQkU1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hv7TzNeLkExhxLdggDaoy5CcFKW7LiBTEhLcTgjleOGdRSdaHU9awRaE57OGMjnzKmk71/SuZtvRZMsuu7rboFktgge/bx4kWbZcoPevFmulZPtBbDf71qWEGlG+fyw9ndyKXWUPMp/LAY7tpky1vY35j2ax/v/2ItQgZfDd50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsG+6QSI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsG+6QSI"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-463ba60966aso69231b6e.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771445206; x=1772050006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eh+gv7QbydUYfhqR6Miej8+XhtZ2T+RDofIsXfJr6zs=;
        b=jsG+6QSIfz4Y7gGYSQwqExgtIgw6CCZC2kh/HNMt1XOO/VfaOU23slKwynTHlpdqpg
         ddSYRjQnCQGjzDi8MDQhW6AY2IP5zmRJtT6BhsLF9bcPFvxN170On/Le2EXYNv0s6lOK
         kjYE20r4rsV9ob3dDb/hnHjtL9AYjzagPfqc770/BdD0+7cdB8n6Yjhs6+0idI6kxHJ8
         pEjqLzv6QIO4nIze7tDTE8aw/C1ndxljBygbUyO/FBsldk+55pAo4OKa96HezMFKc1CK
         dcz2ztw2BMKLWm8NFAdgDLmSC5B8IubpFjYRi+JB4blt3ZmyM9B2pQ6m7BkqjrkmO/tT
         yUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445206; x=1772050006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh+gv7QbydUYfhqR6Miej8+XhtZ2T+RDofIsXfJr6zs=;
        b=mm0yyy/9SNXVTcx2bMv+yZUVlGmZHpWUQQnEj7nzsSY8GsSX+SMrrl5nozQPd2R+wc
         UL68uMqnbNDot50PWG5MgMbQXnUiOkYnLD3KfgMXvu5jhtwwmYAuWeHroc8xuoNhuOGt
         kwv5mpuFaYTX3wwIDTgNRDwSwTVejDEv+AfzLRZEVqzar2+Fk6ja9hhqZEQ6dm7JD/Mw
         MJbx3aYJdJ/2XNaekUfSxRCoWXea6KvVoELnYr/zB9NRDyUUVOg19wI5Sz70X02zKKKY
         cggmqqhmjihhjR0GiWOfUre1I4Vm04XQa3O1YmexByaov7BwTxORvFI4skmAHdtL15Zr
         JLKw==
X-Forwarded-Encrypted: i=1; AJvYcCUl19e2dGlabCHhyEAkCCQC2Kbm3p+ZdtC1wtrn0YiSve2J89aDqgimcgj//qecmvj1DRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztdG/vfSAk1IJ4TpXGljQ88I4NmuvV1zJ1ujOO8HLnTwczd6ub
	VSrViWfvF48aIHHAsE9ldxot0cqK1I4RcOUpHDyFHp3ekLXiZsX7hIQX
X-Gm-Gg: AZuq6aLcvKYNL1d+B4/b0SfchsmyGQmchW7Z6e8TITG4DnkiZVRPNxkndK+Z0iN0bNy
	T7QjKa7vX6a6259TVVubQqdT10BA/rLjB61Z1GaSMMF5ahWTjKaF4f+dp6KwKIR5iK1pNmPDON3
	TzYQ71u72u55+hnsoh4brO/Rs2jLFKCd92RviNlFdQPKu4amHgiRt7arsTm0TiVuZMjELnneyAt
	qITKZ1ZWmGQ61nwygpcy+TatUt3zUjQbdMM+UkWQaKttEeIDb1Gu9ENXmNn945lTFEdTfs56Zmg
	/79tUCZNFq/bOREOuMs0TtAr2jfqOqaZeuSg9oLL4UplbA2D9o/VczdUYi/qaHt2tFKi8ajquUZ
	jOkS2Ns6f4ougvlEdPOKDNW4cd2vFH7JBpOsK9PHndPga2UIvZV5E4XCPJQVOnozv7EroykTJRM
	6rR6oBgN741A/DxVwa
X-Received: by 2002:a05:6808:1491:b0:45c:7306:505e with SMTP id 5614622812f47-463b40e3869mr8588620b6e.63.1771445206478;
        Wed, 18 Feb 2026 12:06:46 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463b83bb884sm10271361b6e.11.2026.02.18.12.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:06:46 -0800 (PST)
Date: Wed, 18 Feb 2026 14:06:45 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] builtin/repo: find commit with most parents
Message-ID: <aZYa8U1hQ1oaeCKn@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-5-jltobler@gmail.com>
 <xmqqpl6lqw86.fsf@gitster.g>
 <e48578d5-ec48-4369-901a-597de3be9455@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e48578d5-ec48-4369-901a-597de3be9455@app.fastmail.com>

On 26/02/04 12:14AM, Kristoffer Haugsbakk wrote:
> On Tue, Feb 3, 2026, at 23:48, Junio C Hamano wrote:
> > Justin Tobler <jltobler@gmail.com> writes:
> >
> >> Complex merge events may produce an octopus merge where the resulting
> >> merge commit has more than two parents. While iterating through objects
> >> in the repository for git-repo-structure, identify the commit with the
> >> most parents and display it in the output.
> >
> > Does the size of octopus have anything more than a curiosity value?
> 
> I’m guessing this stat is inspired by git-sizer.[1][2] This is all that
> the project says about “octopus”:
> 
>     * Are there other bizarre and questionable things in your repository?
> 
>         * Annotated tags pointing at one another in long chains?
>         * Octopus merges with dozens of parents?
>         * Commits with gigantic log messages?
> 
> It marks the max of 10 in this repo as a “one star” (*) concern
> (lowest). The 66 parent commit in the Linux Kernel gets six stars.

Yup, this is taken from git-sizer. From my perspective the max parents
value largely just provides additional insight into how the repository
may have been used/structured.

-Justin
