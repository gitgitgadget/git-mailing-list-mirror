Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3842A94
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441898; cv=none; b=bBpdxYQ0XEzpPVnYMhx0tjOawnirim6AyEClvLjKjzDXffrIysofuV9RQAZ79bt6u5+xFEmcjXRC9J3+xIgJczwSsHQaL31OrTqu3i4BA/5b8zE/fwuvug36rMaMxO5DJZuP35qnpDXR8/sFdLSBape3UfpaP852xHCZEXSp94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441898; c=relaxed/simple;
	bh=KJ6vk07150hPRDNdZpwtPLrJtxY0r1jP8nP5s77OTtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ynlat4Oh2Vji8R7AI937loa8xNQtY9NWpraoTCZ7gZ+FFln4/zJ2ybXtaIxzNcd0aSW018oHnDswV8MrHzwdgIFZc5ksGQ2OkZ4XuBpKg/5TW5zVxbOgA/inNZAmp5RVawgj9rWqGNEQ5YU45gOpJ0C+6/MA+JZ6stknGP+efZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klfQPd3k; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klfQPd3k"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f68460865aso3171533b6e.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743441895; x=1744046695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwZJLSb4eiWO7ma06TM/tEPwROtPGF9Nkzp4MCBURaQ=;
        b=klfQPd3kTI2yhRpyOQ3bqIooWRVtvja+U/qkgzwHO+BWDKarsou4jgkELx+tFqKQ3k
         8/kxyp6OC/IS8DQ6ogYpmwMALntcojekCw6dGm/BfJZz7MOcN2FrCDuAaau9AvehyqxH
         gmnVc3WICPVW8FidhNTStJzh3G4rV9fdMrB6ILnq6tb6tfjiJFGGJUJGnNIlbyNX6Ki7
         20rGDhWR1ADHBieYeiR5Za9rh2v7skvM506kx8dXE/xqAs2PoUGuOaiQ+G8UFeqqAZB/
         dF086Am56TUJ8VqP5g5RkodJtdDtZd2ZqFhpUkkCS9IzMKSNbSCrk3gn2mTUIeldDFOc
         RmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743441895; x=1744046695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwZJLSb4eiWO7ma06TM/tEPwROtPGF9Nkzp4MCBURaQ=;
        b=SX8ciP8CgW8+SX1DA3BQIIMQDvFacRbaNhh1PMRfgJL0xPo0A7FzsQQmYOFycZPSGH
         Z2K88r8b98yBz0aCYZV/plFNpQPCOXkAWX2DIFgw7Lqip2Hr04AWqChdIDRLyJ7W2Bkp
         5QAwrEDg9iSvQfjMHruJX6P0V67aiRrPX9mAxAdptOPa9wD2er58w6SMZ74yrIquqorL
         57QLzXfv6qH8ZeoNWpOM206/5IlFWsUO2bADqMtMGwKeb71VPybyaPA3JKLXrh9r7Ctv
         WppYDbKOWzqKOjBJ7zerXniFW0wIPDpwY7qWQBLfeuNIWG1JsaxFGTtFVh9SQbdw9NUK
         n2hQ==
X-Gm-Message-State: AOJu0YwOkHVQkW3axfXeaDraU0pfrJGIHFGnmzATaqWtXK4iYRZYkBs6
	Ig6qT3VRd3O5s+7TksyJMW8nuUIj39ipn+wH9U+V6sOPbBfHYTRDzCcoIA==
X-Gm-Gg: ASbGncvWNaANM1Nagp1A2TEook2x5PM5FUnLhXJX4oMlvuaqRvsIIq4tbtK465qGyty
	kcWu4cnwsqYSnhs6vSS92F+eFoNQryZy01xM3hGaOWoMhbZzIfEZgox8wMdrCgMHD2/97hJ1kKG
	DxagLjOMLSg/zOsFQ1X9WlWOkFwbpc16wJ+cgNBGU0hR0aQ33UJsBuJ34Zi4gDclnzN7O5Ur7HT
	v3r1uxcPcKF+jxuLBFszRPmL9cGr6g53Kj1fxLbKz1fNM+Ay4t07ZB4iDHEGaiOjch49Ue107h9
	mgjCyU4FAX1rCWtct9Wu6PDPUuTwUw2WGz+ftg==
X-Google-Smtp-Source: AGHT+IERWF9W1nBWRvoHBheUfTKsiIyWUQn1OvuZABqpOxPCaJgI3Hrljk8WXImSdE1EyDvHXy3RaA==
X-Received: by 2002:a05:6808:d4e:b0:3fe:ab9b:1a93 with SMTP id 5614622812f47-3ff0f5b4670mr5592368b6e.26.1743441895513;
        Mon, 31 Mar 2025 10:24:55 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-60284517a69sm1583217eaf.20.2025.03.31.10.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:24:54 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:21:09 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 1/2] help: include SHA implementation in version info
Message-ID: <qtnlhy36oqqewpb5fnzirfzwtyetpad64rxwgokclb4p6fbsxp@bg7gdukunxgu>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250328170121.157563-2-jltobler@gmail.com>
 <xmqq8qoodq5u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qoodq5u.fsf@gitster.g>

On 25/03/29 04:36AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > When the `--build-options` flag is used with git-version(1), additional
> > information about the built version of Git is printed. During build
> > time, different SHA implementations may be configured, but this
> > information is not included in the version info.
> >
> > Add the SHA implementations Git is built with to the version info.
> > ...
> > +static void get_sha_impl(struct strbuf *buf)
> > +{
> > +#if defined(SHA1_OPENSSL)
> > +	strbuf_addstr(buf, "SHA-1: OpenSSL\n");
> > +#elif defined(SHA1_BLK)
> > +	strbuf_addstr(buf, "SHA-1: blk\n");
> > +#elif defined(SHA1_APPLE)
> > +	strbuf_addstr(buf, "SHA-1: Apple CommonCrypto\n");
> > +#elif defined(DC_SHA1_EXTERNAL)
> > +	strbuf_addstr(buf, "SHA-1: Collision Detection (External)\n");
> > +#elif defined(DC_SHA1_SUBMODULE)
> > +	strbuf_addstr(buf, "SHA-1: Collision Detection (Submodule)\n");
> > +#elif defined(SHA1_DC)
> > +	strbuf_addstr(buf, "SHA-1: Collision Detection\n");
> > +#endif
> > +
> > +#if defined(SHA256_OPENSSL)
> > +	strbuf_addstr(buf, "SHA-256: OpenSSL\n");
> > +#elif defined(SHA256_NETTLE)
> > +	strbuf_addstr(buf, "SHA-256: Nettle\n");
> > +#elif defined(SHA256_GCRYPT)
> > +	strbuf_addstr(buf, "SHA-256: gcrypt\n");
> > +#elif defined(SHA256_BLK)
> > +	strbuf_addstr(buf, "SHA-256: blk\n");
> > +#endif
> > +}
> 
> While I agree with the objective of the change, I am not sure how I
> feel about the implementation.  Given that
> 
>  - The code here, and probably the existing code paths that depend
>    on these SHA1_$WHOSE symbols, assume that only one of them is
>    defined;
> 
>  - The "git help --build-options" is not an end-user thing but more
>    is a developer thing.
> 
> The thing I am most worried about is that it is unclear how the
> order in which the SHA1_$WHOSE symbols are inspected here and
> elsewhere in the code are kept in sync.  What happens when, for
> example, SHA1_OPENSSL and SHA1_APPLE_UNSAFE are both defined?  The
> above code will report that we are using SHA1_OPENSSL, but hash.h
> would probably use SHA1_APPLE as it has its own if/elif/endif
> cascade.
> 
> Perhaps it does not matter, if the build infrastructure ensures that
> the build fails unless one and only one of SHA1_$WHOSE is defined.
> 
> But with the way how this part is written with an if/elif/endif
> cascade, it makes readers spend time wondering how the precedence
> order here is kept in sync throughout the system.  If I am not
> mistaken, the top-level Makefile has its own ifdef/else/if/endif*
> cascade.

Good point! Both hash.h and the Makefile have their own precedence
defined which makes this even more confusing to understand what we would
should use to keep things in sync.

> I imagine that making all of the above not if/elif/endif chain, but
> make them pretend as if they are independent and orthogonal choices,
> would make it simpler to understand and also it will help us catch a
> misconfiguration where more than one is defined, i.e.
> 
>         static void get_sha_impl(struct strbuf *buf)
>         {
>         #if defined(SHA1_OPENSSL)
>                 strbuf_addstr(buf, "SHA-1: OpenSSL\n");
>         #endif
>         #if defined(SHA1_BLK)
>                 strbuf_addstr(buf, "SHA-1: blk\n");
>         #endif
>         #if defined(SHA1_APPLE)
>         ...
> 
> 
> That way, we wouldn't force future devlopers who are plugging new
> implementations of SHA-256 wonder where is the right place in the
> existing if/elif/endif cascade their new one fits.  It also allows
> us to catch misconfigurations to define more then one of them at the
> same time, if such a thing becomes ever possible.

Keeping each of the options independent certainly keeps things more
simple and avoids having to also manage the precedence of each option
here. For most of these SHA related options we only expect one to be set
at a time anyway. I'll do this in the next version.

One exception though is that we do expect that when SHA1_DC is set,
either DC_SHA1_SUBMODULE or DC_SHA1_EXTERNAL may also be set. In this
scenario, maybe it would be fine for the printed build options to
include both. Another option would be to treat the DC_SHA1_* options
separately from the SHA1_* ones and have a separate prefix key. Maybe
something like `DC-SHA-1: {DC_SHA1_SUBMODULE,DC_SHA1_EXTERNAL}`.

I'm currently leaning towards the latter option here.

> Also, wouldn't it make more sense to just reuse the internal symbol
> for reporting, i.e.
> 
> 	strbuf_addstr(buf, "SHA-1: SHA1_OPENSSL\n");
> 
> instead of having to come up with "human readable" name here

Ya, using the internal symbol instead of a new human readable name is a
better idea. I'll update in the next version.

Thanks,
-Justin
