Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B61607AB
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297379; cv=none; b=jvkWGMcbFpLnVsgvJM6bVM+Xpxeu9dyJUujxaq0MWxNAEmhiaSh+lUp8FoEFM274DMPj3Ew8Hid3DYQnH3t1tOUZIcFPNRJB7g+YAtjUD8KqSkYFqrww1j8aGTJ3CWqY1/9fXybgpTOmq3YDVQrNFxowqIIxsYy+IoW/GZpdfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297379; c=relaxed/simple;
	bh=a798qrIj+upWIthzc0X2GD71ENn9+C8faCGLLqfx3D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1cRlMWW8paOCypjF91TLOpOcuKr5fYB7X04pzFMy8RaPydu1wrSeIhVk4ApJqnfoOEQLlOU1ZHYLG4nSY3sLnFnY7mciSyzeR0gJBn9Q2i//Kg6JoV7tv618Rgq1TuWtZsq3RgcQYTb2ccEULClzpZaD0t+FOhCI+c9smn49VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmTJr+PX; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmTJr+PX"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7183a3f3beaso1227786a34.1
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 09:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732297377; x=1732902177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNs+smomThMXOgmcxfIh1/mLBoAvfjrqQvwCkWy/BnU=;
        b=RmTJr+PXw8gA4+YXBvhymVI4zQAQwVX1vzba0zChRvd/panklGzeYkgLx1Sa8/sVoj
         QdFt6frs/Vw6ForodobeO/4pvHhi6swJqSAgNkYvY8rSwKXZBV4lTIJ2dAuM605dln9+
         imkjjReYK7tojkwRWYai3maHNPDPiG1UTPdWQmQDItRxZLE54repgv4fL0R1OV53Tgz1
         Qmlh9BdTk3ZbSs3KvnXixB1as78LLplTvcuOhNWv3SnGyrn53wlwMVLP4GDqm7jT/nVa
         TSgnMQev+NowanWXcwlX4uIMb6SNt7ScKlwtxq3UoQIb11WA9aaeO2pgG2Quma0KdSWX
         Kz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297377; x=1732902177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNs+smomThMXOgmcxfIh1/mLBoAvfjrqQvwCkWy/BnU=;
        b=qhwuNcO7UoBkUoDjZo625GIyqEBuQD15EsBN67Iey9d6miVW/3vi1C1o/F/F3MisMN
         uv6a335XAmBl87AhvWKF46fC174NCqLkID9csB4tiDFGImWXo6IGANpVARi14TBPkefj
         QRc6xCAtT6z9PC7ximxYYaQWh9s7TVxapXmk4GDDwopEU4AT6XZSAWTj8qQ2fIKQAtfH
         ezLP29fkAljcEYoMlPcQR0v7xxMN1A3S7rgObx2WSFrgpnVgGka+1XEUe55iQFP0UYZC
         tSmjKC8xf47EJZPJUrXCgHv0EL+QMUiwtUYIXzy6nsLMqEZIB/TqKJJHzRGgpdzzPAgw
         +rYQ==
X-Gm-Message-State: AOJu0YxE+ir5suWo2icacrpOBUtc7D4DuNF8DQqsPxxwg1JGhdwH7HNh
	cj4JspZlqOd1+qj4dRaEcTNj5SCNW0kZP/KonQNFfANlE7UnNCZPVa9crA==
X-Gm-Gg: ASbGncsapfY+90qZde/oLdfwaNRLOGkRGW5tMZbyT+76j+CAby94BcCs/BnX8hyLZKi
	OzDs2j0TFISpOvIMAu8laxikKVPv5BJEMMylBPDdGaSXPuuu/UxbfyV1UBq78GU5YB86qqQpnC4
	CJFwb/COnESBzONcC8yq05LP+TwZ5uRHtZL4QEzmHysj5Q7JzQgNfMctj0IWVsepyGX5EkbhX6X
	tqhqusgXD2TkbWpVB16HxzGzWthuJKL4344tLvNVF4=
X-Google-Smtp-Source: AGHT+IFEzmT/CW6JbiLrTVsPIbIU3uiAvC0QghRlHWhlUcQiudlv3bHsm3U0TPREGFIZ+kd+nN/EVQ==
X-Received: by 2002:a05:6830:2714:b0:710:fd8e:1727 with SMTP id 46e09a7af769-71c04b9fe6amr4623497a34.18.1732297377275;
        Fri, 22 Nov 2024 09:42:57 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0383ed3fsm504157a34.73.2024.11.22.09.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:42:56 -0800 (PST)
Date: Fri, 22 Nov 2024 11:41:06 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] fetch-pack: expose `fetch_pack_config_cb()`
Message-ID: <j36eguzz7vgd7j32csj4erjzfh6xi7zw7eijxuqesr3lp3cjlz@pk4lcbwi6bbx>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-5-jltobler@gmail.com>
 <xmqqa5dsc9nq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5dsc9nq.fsf@gitster.g>

On 24/11/22 10:57AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > With `fetch_pack_config_cb()`, fsck configuration gets populated to a
> > `fetch_pack_options`. Expose `fetch_pack_config_cb()`, to facilitate
> > formatted fsck message configuration generation. In a subsequent commit,
> > this is used to wire message configuration to `unbundle()` during bundle
> > fetches.
> 
> This is generally going in the right direction, but this particular
> iteration is highly disappointing for two reasons.
> 
>  - The callback calls git_default_config() at end.  Other callers
>    may not want it happen.  Think of the reason why a new caller may
>    want to use this callback (see the next item).
> 
>  - fetch_pack_config_cb() was perfectly good name back when it was
>    hidden inside fetch-pack.c, as a private internal implementation
>    detail, EVEN THOUGH it did not give its callers everything that
>    tries to configure the behaviour of fetch-pack.  It ONLY is about
>    how fsck behaviour is affected.  It must be renamed so that any
>    new caller can realize that it is configuring fsck checking
>    machinery and not general fetch-pack features.
> 
> So, I would suggest making at least two changes.
> 
>  - rename it to a more sensible name that includes "fsck" somewhere
>    (as it is about "fetch.fsck.*" configuration variables, "fetch"
>    should also stay in the name).  Let's tentatively call it foo().
> 
>  - stop calling git_default_config() from foo().  Instead, return
>    some special value foo() does not currently return, let's say -1
>    to signal that the key was something foo() was not interested in,
>    and write a thin replacement helper
> 
>     static int fetch_pack_config_cb(...)
>     {
> 	int st = foo(...);
> 	if (st < 0)
> 	    return git_default_config(var, value, ctx, cb);
> 	return st;
>     }
> 
>    and call that from fetch_pack_config().
> 
> No, "foo()" has neither "fetch" or "fsck" in it; I am not suggesting
> to use that as the final name ;-).
> 
> Thanks.

Thanks for the suggestions. I'll factor out the fsck configuration bit
as suggested and name it something like "fetch_pack_fsck_config()". The
new name should be more clear and this change will also ensure only the
desired fsck configuration is being parsed which makes more sense. :)

-Justin
