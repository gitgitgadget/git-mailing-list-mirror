Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85256B89
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014043; cv=none; b=KJJlajngtIKf5uXDQnTjNJFix85xAkUTJLjOMzvffCKilxOylreO99/S0JIskTK2IVpHMkwXLxTNrZwVLsje6sHgF6m3Frm8chNz+a1s9cyg20rFmXAIkshTPKexolSqeyRWP77sz2kD60PY/ZXn6cqlSZdM+gSDgCoQVYGtneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014043; c=relaxed/simple;
	bh=ls7jZ8iJLo1UVY3eMrM65diNvx/ozqScscUuJO7C4hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOmG9hg0czSovRL+1XG9XSnPbdFesNi5hWN7ODXRBEvca2ttAo3la4fzoQ46I231eTboMU2DzBPUCDpVFE4Y+B/uZi/jx/cs8NAQBRnc2JYZQxb1EaOI/hJXCLlYK5g7rDlKFu4UgmYVrF4c+sYJ7FPhDNPmumh+UfD76uYk+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DalmVtl+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DalmVtl+"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c35c4d8878so1900338b6e.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 16:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712014041; x=1712618841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ls7jZ8iJLo1UVY3eMrM65diNvx/ozqScscUuJO7C4hM=;
        b=DalmVtl+My3ZqKIIruMfZfGaKiZAyLiJjnF/3cMLToQ5+r6VQ7dk4hT4g9qUEdw23K
         V98CZtBS4sZWzdf1GT93D+pPhS5DCwESuKhbuZFO+VOw9MVld9uuGA89JVh74CMkwV9+
         dygtjky1497e71UCo3J5THYCxmhIvbnE6lCkJSSLOQPgmyCA7k+xqC3uHbEQ5uSLbNsc
         g4vyxM/msf2pWL7XaNXLXKvDnTQif/MwArTAa5B7tXBh2X15zCjVNLbZLtWFOKmlzPPy
         UqKC7Jw3RpmBb54bmvXpjmXMib2EZAHdc13xK/c5jGVU6r9UN9qaF9TlxdrEVKF966DK
         n0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014041; x=1712618841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls7jZ8iJLo1UVY3eMrM65diNvx/ozqScscUuJO7C4hM=;
        b=M5k1eUAKGRmWA2zrMNGu6Z53ySl1BRn75rEhpnJIwq8zxZVJoZsviYjpt0QAm63ZXP
         Ylyl/NNUKWYt48SFbgoYUvSy+ZmiSdo6QAoo/RrX0C76jmcJvJjzIYAnAJ/yUyGnLRBw
         C7T9a0KkRRm/owieUJVM56zC8Vz8UXPSGIGTaFdIIWBU5BRkbIH7Js1UiYPHprm3iOPQ
         WD03Z3usq5FcyNhZjeQxislOFOmLyDpl1MZn4dBO0IrPWkW/w1xMfcUXIO8BmNNzt8Az
         IZ49/yosg5SwA7FrosB3RkxibrffZOriI3duK+cJgY80RjJhku3idvWNEE/myNnR1NSU
         xH6w==
X-Gm-Message-State: AOJu0YyoJw1W8BnPPxxVgqdmMndt7I1vKbUgc3ZV4kv17M8REW07LIfg
	67n7lP9CnEf2QLOPz6wUK0OvI1Q529pcbHJC9g0XgiVUtvEZKFwDMiCiCtH8loU=
X-Google-Smtp-Source: AGHT+IEreN0Z7rZMstQWXJIs1AWHUqS4OXhwMmgfzy8SYU3hTG8oyOrZ+8VT9E95XLO+kR7shWpIkA==
X-Received: by 2002:a05:6808:23c8:b0:3c3:eed1:adde with SMTP id bq8-20020a05680823c800b003c3eed1addemr13531817oib.14.1712014041464;
        Mon, 01 Apr 2024 16:27:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v4-20020a05620a090400b0078be9e0f9adsm574452qkv.43.2024.04.01.16.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 16:27:21 -0700 (PDT)
Date: Mon, 1 Apr 2024 19:27:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #01; Mon, 1)
Message-ID: <ZgtC1+26c67PBOH7@nand.local>
References: <xmqq4jckaoid.fsf@gitster.g>
 <Zgskgeg6kXJsb3/c@nand.local>
 <xmqq7chg91ma.fsf@gitster.g>
 <xmqqmsqc7kby.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsqc7kby.fsf@gitster.g>

On Mon, Apr 01, 2024 at 04:08:01PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> >>> * tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
> >>> ...
> >> Thanks updating the description. I am waiting to reroll until after it
> >> has received a little bit of review on the technical front.
> >
> > In the meantime I've dropped it as it interacts with tb/midx-write
> > and Eric's khash-to-khashl update.
>
> I think I got merge-fix for integrating this topic with the rest, so
> I'll be resurrecting it and queuing it to 'seen' again.

Thanks. I'll look at what has settled by the time it is ready to be
rerolled and rebase it forward appropriately to try and make your life a
little easier ;-).

Thanks,
Taylor
