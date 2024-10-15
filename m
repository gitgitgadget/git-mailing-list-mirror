Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9D824A0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021903; cv=none; b=epn2MsoRfNHuwBU0IpXRf6lZJbALQpxJL5vG3MGqK/16W3WxAAm6R6bewwyZSDO4E/37Wytx01PtUW52oDmwwrbykkTGezprdWuH5aEnGgMyQ1RX8PU43cCu6GjU1mYXZHKJnM3DVAczNDx+ipFkYNuL7/l7GEuT+auxd6u2yhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021903; c=relaxed/simple;
	bh=R1xFZ+C2yzb68TIt4+LxBfK0MovvLwlGGn4jr7sTJwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjL3jBBVNhpbqUT/FttCKXc8/d60fw6DE7phgo4E9XOYBGVCgewrAqZ4DAmTb89iXgqQKCh/f7FjSXu7+jc4mrmWokYuoh57jXLW6hhdQ2+Qyh3ACjIg6QB29V7BNeuRYV0JHNMMxBzaMKWGuKcmVgLmBu1PYPYJulb3gqJLgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ylHXr5UD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ylHXr5UD"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3a97a6010so24032007b3.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729021901; x=1729626701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qf4LxzhCVOO5uE/v0UhCTkaC+dox5O0H7NGnhTxa2Y=;
        b=ylHXr5UDnp0QxyCpvGAD1QsZBg7YJtdGVBD645yIeJh9kIc6uhkrEaQ3+uNgVcjDrV
         NSNbmTnNuIzI7pLEoMkCGzlNrGlhUDdOPjxu/ZM9hqq9Hia+p6II6NcIFfzIeSckIGjg
         dWZ8hyRMo3RsW9HXujEccP6zG4aIuZ1FLylGLz7ENFUowVJOwvdLxYZ3dRmqe4S+HkLn
         BTDrQT/JKwwZ+NBpE6LvZ/dVN54HySDZC1RR7FzLsYTM8rMjQAxgwfJG/TW87QNMOPM8
         KDLt52ySGkagfsJ3kCHRLcJv90eJooHepHeZaKtGIPATzjLyrg1JXaTJaHNG8AqAA60Z
         oRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021901; x=1729626701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qf4LxzhCVOO5uE/v0UhCTkaC+dox5O0H7NGnhTxa2Y=;
        b=Iv43+4Hki34WwqCioK+iLwSP6EQDvAER8KAhMFjmvc2Kc9+9njcT4VyhFt3oycLiQw
         lF8ZoYCaPS3x8zIEg/QlnaobuN2f3H0zbZZN9LBRCC7TD0+BTA8ajf8ElVQ7adbFhFKw
         ZCVlgfgr6fn6KVilGc52ILzTmTHMDbhO+JIRCgtgLuYdiKg9cOhwT2h9c2m1B+xLGTNc
         1zDMjrrYErI/naSiAb3qDogODwzzgZ4DAB34IKsdusAZcYDGFdikOOAfrljzZjOID4++
         mcj2Q6vy6DtC+TCWG+rQ1l//mgSSRuM2w2tT4g13Awmt4mnFBOgcZjXKC/AB/yFzti6P
         j8FA==
X-Gm-Message-State: AOJu0Yy1bdCe/z8cYx2/IxLAnNuPyXONG4aDIBDrOH8bKqZRdXIqw/rX
	/NF6XM0midewpLE1JOX9+3ox8YTukbFiglw0XnZ2lmOJ4On/XrKmffgl42jH+mT8oXVa2RIpnz+
	T
X-Google-Smtp-Source: AGHT+IELECt7mEKQcgGjmKozgzHqX99i++qbg8J1k0A4PgfrqYKct3eboem3BBE3pFttBnURVglcrQ==
X-Received: by 2002:a05:690c:4c0d:b0:6d7:f32:735b with SMTP id 00721157ae682-6e3d4142699mr22720707b3.27.1729021901007;
        Tue, 15 Oct 2024 12:51:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae8664sm4102737b3.26.2024.10.15.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:51:40 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:51:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] pretty, builtin/mailinfo: don't rely on
 the_repository
Message-ID: <Zw7Hy12qHhd5BhGh@nand.local>
References: <20241015144935.4059-1-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015144935.4059-1-five231003@gmail.com>

On Tue, Oct 15, 2024 at 08:01:21PM +0530, Kousik Sanagavarapu wrote:
> Hi,
> Just a brief summary -
>
> 1/3 - the main changes are in environment.[ch] and repository.[ch], all
>       the others are just changes due to this change.
>
> 2/3 - the main changes are in pretty.[ch], all the other changes are due
>       to this change.
>
> 3/3 - This is pretty straight-forward.
>
> One may notice that there are more "the_repository" occurences now than
> before this change - which is good since it means that we have now made
> the respective dependencies explicit (these were previously implicit).
>
> The change in 1/3 is marked RFC since I was kind of skeptical about the
> "repo" check in the repo_*() functions being done at _that_ level.
> Since every other change in this series depends on this, I've marked all
> the other RFC as well.

I share the concern that others have raised in this thread about not
having the_repository when one of the affected commands is ran outside
of the repository.

I'll bring these patches into my tree, but let's hold off on queueing
them into 'seen' for now.

In the meantime, as a style suggestion, it might be nice to provide a
wrapper for function foo() -> repo_foo(), where the former still exists,
but is a wrapper for repo_foo(the_repository) like we have done in
other similar transitions.

Thanks,
Taylor
