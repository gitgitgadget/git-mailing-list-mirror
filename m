Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF6153800
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982196; cv=none; b=g9lD//WZUT8qru/7s3z2k3M5T5i7M9hW+IAXAV3KyQnZ3BZ1IAgqhxTBXqOSjMa/GaC3Tb+4o68PcnNgKsXRyFfY3YUK1+v+wC8XKDGSPdNrfuqz56VtIPwdlUMuKPaClDkPbZok6Jm4ffIlSF8/OWC9fkGZ+AjwSPgqtBIwA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982196; c=relaxed/simple;
	bh=k2TH3D1Yu9muOU3m6a3sAYRl8I33z3wN0GgA8gjpD8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhXXHE4N5jDsBNTWgbJBLepW3XyiBxIQBGTcSWXz+8LeDincGielQmCHqRfe2wIR5qXsCYJdXg6Rno5/po173tBoA4QUcScCbn6d/RVo8y23S0VMSCvR5J/1+NL3jW2rNU9qQcH9wv6XUCyh7xcX8bkGSH2F9b/xHuXvTUrM91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ey/2nqrI; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey/2nqrI"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7272f35cdeaso1393987a34.3
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741982193; x=1742586993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTANR4yKM6Vk6y9k3qz04it7RAK1Oe2r3g6AEkDt9AU=;
        b=ey/2nqrIpetRzXK0Uc8p1vTaV2+yfhictEJMz07icydKNDbbW3v/V97rjRmTHLnXEW
         A+PQu4yIgdX7FFZb/PHZIWiQiEn3Ul/WqZ6ZfxelqQ9YpVumvPXcMPv40JfTURN6jIzZ
         fbctXp9kHbsDeyW2QCc7/NN+1SQ4IeeHJcVijNPLEWSXDxMBq6KE31uLEnzixFZUpI28
         hGVUGGIfjpGn+vCuogamAbBh/OVs5h0tMKGu3UA6BrcrRzwuZHWgqNdBXycm/HhnMQiM
         uzrnd9NKHfdarXhTVK3P7GVoGP6gIfKRQoIqmdlXcfih3VEF4TMwYrxqnsFPV4/HVTaS
         B4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741982193; x=1742586993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTANR4yKM6Vk6y9k3qz04it7RAK1Oe2r3g6AEkDt9AU=;
        b=SGzWbXWibzDJ4EeLWn/DlaHOGvy1b48y+f5QjWIfPpts0+r82FAhq3bKCuj5De8KR5
         /XqJdBl1J5JDEAvff79oCeChwPj/UAfUGizDS4nsZqDLJm/8ywN8Ae+yo3ivWBGC4Jsg
         X7iKHgw28c7l2aKdxWkDG1t61DRoI7iZq4gLA81N1pSgEhUw211bVytkFJ9iFhH0opp8
         FmFrb6UVz4ZyUQw/nqRBfcyMe3bIhcNyhB3KuA/efTKccr9rThrnWHYXo7WSV8EjMK7a
         pQ8qvrOdJOC+mXxkyK1fcwVyCSR6pq1uX09d/yxMle/w3BxePi5RDV4kiNMuAcVclLgr
         wD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUBcRgjn6wg7xLAQ/M7H50whDw25Z2VYGRK/Dn0MFgVmXjaDn07IZMNdeRgU/TM0Hgiat4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3psGT6oQaFbaO5us25SJxfEhu2II/JlKTn4yeMIW1GFUff4h
	AzJtdvlXjt3deb8QJP2/UL4K6XOGWGhNbVSycUWmjj56IOEquo0W
X-Gm-Gg: ASbGncuCbL7/HJiAFChvAqjJkE3bBXHQwTb3jRSKTULj1olWeOB5HgUDxsfMD7B5WaC
	b1DiqQGjAlgrsPXTZ0HVXDhDXicvfbvUcPdobksT7mE9Uad8DaFwOJ+AlR6rZTvb2T8cleMql+9
	aKLuZ7H/cNrWQde8CxbwarOcehe459ILbGJWiBIaDlZSrFq0BAKrTM1ylEiyM/zJOgu+jU6lUrp
	ZGu4s8WufGHIrEOpoF9Rfs017b75v008vjod2GkVxcx7DZFBYbaSECpsqS0f3BRHe0H5ZV+CJ8v
	vS04Hz4ua9dTr7k/J/sZwS9ssK7zNHrj/7wPLHaTZjs0AH7g
X-Google-Smtp-Source: AGHT+IEk+5k2Q8UlVZCgou20WN12aqPdA6ntBvGD9L5Li7HGi4Cu2OIB1qFLxoZhLMrXjcoLgPbNUg==
X-Received: by 2002:a05:6830:7107:b0:727:439c:d18b with SMTP id 46e09a7af769-72bbc26493cmr2660602a34.15.1741982193611;
        Fri, 14 Mar 2025 12:56:33 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72bb26be5dbsm774576a34.41.2025.03.14.12.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 12:56:33 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:53:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, ps@pks.im, 
	christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <po5vjngxt6afwdkg7bvpw5j4dhot5h4uz5yudb3o4eug4k2nqu@rwp5rpe5d3u6>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
 <20250313053329.GC94015@coredump.intra.peff.net>
 <qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
 <20250314024929.GB114103@coredump.intra.peff.net>
 <xmqqsenfk0ks.fsf@gitster.g>
 <20250314185914.GD578421@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314185914.GD578421@coredump.intra.peff.net>

On 25/03/14 02:59PM, Jeff King wrote:
> On Fri, Mar 14, 2025 at 10:02:11AM -0700, Junio C Hamano wrote:
> > Having said that, at the plumbing level, my preference is to have
> > two independent options "--nul-delimited-{output,input}".  It does
> > not prevent us from starting with a single "-z" that works as a
> > short-hand that flips both on (and is inconsistent with "git log" at
> > the Porcelain level), but we can make "-z" only for output for
> > consistency.  As long as we agree on the design to allow us to
> > control both sides independently, starting with "-z" that is only
> > for output may be the best way forward.
> 
> Yeah, I almost suggested earlier having longer, unambiguous names. And
> then that punts the issue from "which functionality should be available"
> to "which functionality should be mapped to short-and-sweet -z".
> 
> I do think it's still worth considering what "-z" should do _now_,
> though, because it will be painful/impossible to switch its behavior
> later. And people seemed to like the "both input and output" direction.
> That would leave the longer names as escape hatches. I.e., I'd expect:
> 
>   git rev-list -z --no-nul-delimited-input --stdin
> 
> to use newlines for the input and NULs for the output.

If we want to adopt less ambiguous long options names for NUL-delimited
input/output options as an alternative to "-z", maybe we could do
something like:

    $ git rev-list --nul-delimited={all,input,output}

where the default for the `--nul-delimited` could be both input/output. 

If we want to do something along these lines, I can send another verison
of this series where we drop "-z" in favor of using this option.

-Justin
