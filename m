Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F82F1FF1
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943759; cv=none; b=K2ihJJatV8v+Or+gE9/tVmChc+eXIk66KLXtVd90bR+tuBa+QS5cS2/+kY2eZdoT/m7nIi8mCAA8JeLu2Di44BVT7K2b+XpMYH6GtGsYlf8NHHbv5Kc8RzmNIpsSY18T+0UZHqYo0DBF8iUXcG6vBL4pXeiM/P5Q/5dV2IFxT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943759; c=relaxed/simple;
	bh=rKvJE7wXvrDEnhiYI8Lzcn1bLwY6TJ+bN8phMK+MnwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNlmst+zSE83gOgFDBIs8B0K6fc7cOyD4g37DgdoktEaJLtYKe83L+JSSzir4aQ9I+OU4QPVgI+jDOpgfIFtPSKgGvz+rVPBAlJs4uQINnr/LusT1jvPM4icUMK1vu8TEpIyBwgodMPax03fmTw2pc33nmsHXD+LvwNz79mInZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiMXE6fa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiMXE6fa"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490702fc7cso732924b3a.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750943758; x=1751548558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vm/FjLY0kqLABgsql6elA0TFZ8NN0rCbAFUcAio45c4=;
        b=SiMXE6faJFg4cmpj+Ck3m2xWeschKVkXtOLSRC68N/UxivpWu3X5Bw6e3ku7hogyxW
         Ahav3trsXFcFl+zbKmhYs5mhQNYeY/Hg3cdbnyiZkIGqQfQO/q4hPW/Hh/c1Moplz9Jp
         pYKcOrUfnafd1Ru5dG2xefDWJZ8YBOPCcB5PVVJd7Pug+UDw9qqgp5zA44/+8sH4Goe7
         rsmM2y3VV5mx/35i+a4HfKcmA4BVimBtnDouJ82Q8iDEDNJtS7IcdkB0H8VQ4JO5EeXo
         XZv2UdCw5Yth4pBm+CQVakAf1HkcolwwhS4AnSMqpxjLRSMCgainHbhsH3F3o8bk8af2
         okHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943758; x=1751548558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm/FjLY0kqLABgsql6elA0TFZ8NN0rCbAFUcAio45c4=;
        b=Dgea3F6FvPIhg3z93K6/jVDZGhFOTDi8+o4xMH5ovcLJvVnGoZLsa/tzgAgnnxw43Q
         eICd4bsKtiHgOccFhCg/fZlq+GIdp7gb6hUhORJ4FVtvWs0EebRyaPylXYwh1XUJx4mR
         aBox88drEVe5Q0IoipC7P9AgAyq2K5NUObBdoC+vBIprJWXkUbBdZ6VPczvqp+qTuNoY
         QMXO95mCsj2Ae/0cevqi3+Sx4V8GIJIP9NT/KegPAjQd0J6Wj2aOs2Wa23B1aPCnDG9A
         K6Pe3djvihUBcYB0LTqc1WfZ98nS40Kog+d8sYKpxY4FTmFAGvIKqWwydMULB4PN2U24
         3Rng==
X-Forwarded-Encrypted: i=1; AJvYcCXgz4uvC1un0e2IbkgNtkMh3Pq9dHi3pUbA0rS7X923yGKZpTNprDP/3zlKSe0nEXk61EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItKQkH3hUMAkajE92JrN+sD/rZxHazEx+vmCKlRAPN6x+0Xlx
	lChfi9U7R5qQ61uV8vt98yEhUAxt55Qam6BY7svhAyw9NLfAVRUW5XNb
X-Gm-Gg: ASbGncs+pD7e/EiyRUOP5JUe2AnQYmJ5Dznn0hLmP/s+wy5UlQzfQmDPrGKmvseTxOf
	DqL3/3LzNhJKZeXyMEOFq0NsSrd3aBcnuDHTran7owZafxSqEg0Rt0o1mDPFgKkOoqLJmlN7MYc
	vuO/+zlV9uwPu2k8sgVjBj/gLD54YwIG09cZmmSs1yrJT1EIldZRd+HYOspmTe8z3MtuXjkqJKL
	70qzXzg4u7v2C+dkP/AT/gzHPBjKrs8u5S9fbu1Vu9xGmdrDZbewERrclBrK6/CxZHqSBu3YYFB
	Cx1ZMKQ5gtgdAqmYKmZEa7UDRI84hpZkQChCGiyexeV75XUaOym/2UdiwpobH9uuBS1JZ69PKA5
	XZbdnDPR6qRTNHjRxr8hIrnc=
X-Google-Smtp-Source: AGHT+IExsSLw8aq61V1CLz8lt6tpzuM90EKdPaBonCJ8v+tBXAV+EuwFREzRbHk+uEHpPVCEXxjZOw==
X-Received: by 2002:a05:6a00:2354:b0:748:f41d:69d2 with SMTP id d2e1a72fcca58-74ae2f801cdmr4931649b3a.4.1750943757494;
        Thu, 26 Jun 2025 06:15:57 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c887261esm6961856b3a.156.2025.06.26.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:15:56 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:15:55 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
Message-ID: <qizh636elher65bsdzkiqohzyo23tmon7hxcl4jcuftculbtm6@nupmqjy3igja>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
 <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>

On Thu, Jun 26, 2025 at 01:52:47PM -0800, Phillip Wood wrote:
> On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> > From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> > 
> > A future change will start using sigaction to setup a SIGCHLD signal
> > handler.
> > 
> > The current code uses signal() which returns SIG_ERR (but doesn't
> > seem to set errno) so instruct sigaction() to do the same.
> 
> Why are we returning -1 below instead of SIG_ERR if we want the behavior to
> match?

By "match", I mean that in both cases we will get an error return value
and errno won't be set to EINVAL (which is what POSIX requires)

In our codebase since we ignore the return code anyway, it wouldn't make
a difference, either way.

signal() returns a pointer, and sigaction() returns and int, so you can
have the later be literally SIG_ERR, eventhough it will be ironically
equivalent it casted into an int.

Csrlo
