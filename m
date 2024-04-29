Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC65F1779BD
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428276; cv=none; b=YbIkTWnuCqQ+ICcMBwKQrf8UzaKv2d/KfPtkSVCqOhY4u5mgiRBdKhRPKElqCZMxyEKIAf4eGKmsfW2gVpmbP7Nv/t44jpwUbNTkfxQb+w8Au2Vy2Ni2bg87H5QaSbpH2NU0VY4AnPqY/ooyy4t0lHD1S4IjJzrGy51AHi0OL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428276; c=relaxed/simple;
	bh=6iVf6PB/f43fxs7jX5UK5l82zxf1a5zlRyKRH0zRvwQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To; b=XcXViXulh4brwYaEFIYLbQoO+pc42A2lOLI3yvbYf6Ee7E8+LN9v2X/6TikxlggTcn8ZzChvUh4sSH7mzwkhsmsQjC8YAvhQ/hmjFjNmFSSyrv9v9vpZ+3FBBLs3MV6TDVUw6RqR6txGA2bYwPtHawxNTmHARqiACSeEdW+QpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cigyuTVz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cigyuTVz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e65b29f703so44314975ad.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714428274; x=1715033074; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1WlDEIYNrPrFnC/v4phSFpgGfxcTc/jQjyOPAXKRDw=;
        b=cigyuTVzhBiZ+IzU+9hRfrZnb50df6/5gMsmMQc6BjhYoKEzzuDM4gqOiMJkDaLkIj
         UqsYqT9g26qHDl0J2hOzf8QoV52R03wMb1Ffrwl9WKNBCgih78lyRDdt6MILoV+HePDv
         kJtabj1IKGDQkPV+JrbTTiRev1WnntyANGlaooJ5Nc860tK4ez9HuOGgY62q6WRClrUW
         9aPr41sHkIn/acDzXUsddziMcmRXuSRBOlqcGG/o+EWMkOnsNM3hA2vA6J/FmiDVHJgL
         O1g0MQ9ar5wvlVEbr0aZRmTepxsJmrchga83IcliZDIHwLfF4w1zYC0dRbfxhHegv3Eb
         mUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428274; x=1715033074;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1WlDEIYNrPrFnC/v4phSFpgGfxcTc/jQjyOPAXKRDw=;
        b=DKV/n2tH0e5zUz98ONfoE9LRJR5J2diRgDPvrTf+DUpmvqTnprA4HrBLGCsR1nNYld
         Wwa+L8RVmpFamY2dr/3WhfxMFkNVd75QUnF0lcfRWwrLlBH2z8RxjAFy26oObfXYUIha
         ySeJsI+PSLZjDkybhIWX0/yPm1MtuQsWbbZTKgC09gb9q+jMNbORJlmyoHhmZ0Rfn+jZ
         VgAbkPrKgoLVzH+WoVQoKhWSJRlEzGGothsiSniBcxo3tFvrbcTgQLcLJIU6p35bSkkD
         55iMohrfMqVcIY6x7VKNRk3G1d+2qRN3P7hz9dH4bF77JX72aGHxiGQBUWVykN0e17H2
         JJ2Q==
X-Gm-Message-State: AOJu0Yx+dEkm3Kl2mq5i4w5NjSL7v0HyOTnGJpc94nm/PNjucMz7XZlm
	flHvdX5kP9ZgtNbdNExRJBHFWeEVGnjgxuwnCiBVjA6JJJ3v2mIwNNr4xQ==
X-Google-Smtp-Source: AGHT+IHSawqCOumUEWEODaqj5JU4OkQIALNgrR9D60j34AbChb91r+XbRRwxiKSOUJtaXR4oTTvWow==
X-Received: by 2002:a17:902:70c8:b0:1eb:54b7:2724 with SMTP id l8-20020a17090270c800b001eb54b72724mr6681902plt.64.1714428273999;
        Mon, 29 Apr 2024 15:04:33 -0700 (PDT)
Received: from localhost ([138.117.155.58])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b001e3cee88212sm7956520plh.230.2024.04.29.15.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:04:33 -0700 (PDT)
Date: Mon, 29 Apr 2024 19:04:40 -0300
Message-ID: <e7f49f373b2a3b51785d369e1f504825@gmail.com>
From: Matheus Afonso Martins Moreira <matheus.a.m.moreira@gmail.com>
To: tboegi@web.de
Cc: git@vger.kernel.org
Subject: Reply to community feedback
In-Reply-To: <20240429205351.GA27257@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>

Thank you for your feedback.

> are there any plans to integrate the parser into connect.c and fetch ?

Yes.

That was my intention but I was not confident enough to touch connect.c
before getting feedback from the community, since it's critical code
and it is my first contribution.

I do want to merge all URL parsing in git into this one function though,
thereby creating a "single point of truth". This is so that if the algorithm
is modified the changes are visible to the URL parser builtin as well.

> Speaking as a person, who manage to break the parsing of URLs once,
> with the good intention to improve things, I need to learn that
> test cases are important.

Absolutely agree.

When adding test cases, I looked at the possibilities enumerated in urls.txt
and generated test cases based on those. I also looked at the urlmatch.h
test cases. However...

> Some work can be seen in t5601-clone.sh

... I did not think to check those.

> Especially, when dealing with literal IPv6 addresses,
> the ones with [] and the simplified ssh syntax 'myhost:src'
> are interesting to test.

You're right about that. I shall prepare an updated v2 patchset
with more test cases, and also any other changes/improvements
requested by maintainers.

> And some features using the [] syntax to embedd a port number
> inside the simplified ssh syntax had not been documented,
> but used in practise, and are now part of the test suite.
> See "[myhost:123]:src" in t5601

Indeed, I did not read anything of the sort when I checked it.
Would you like me to commit a note to this effect to urls.txt ?

> Or is this new tool just a helper, to verify "good" URL's,
> and not accepting our legacy parser quirks ?

It is my intention that this builtin be able to accept, parse
and decompose all types of URLs that git itself can accept.

> Then we still should see some IPv6 tests ?

I will add them!

> Or may be not, as we prefer hostnames these days ?

I would have to defer that choice to someone more experienced
with the codebase. Please advise on how to proceed.

> The RFC 1738 uses the term "scheme" here, and using the very generic
> term "protocol" may lead to name clashes later.
> Would something like "git_scheme" or so be better ?

Scheme does seem like a better word if it's the terminology used by RFCs.
I can change that in a new version if necessary.
That code is based on the existing connect.c parsing code though.

> I think that the "///" version is superflous, it should already
> be covered by the "//" version

I thought it was a good idea because of existing precedent:
my first approach to creating the test cases was to copy the
ones from t0110-urlmatch-normalization.sh which did have many
cases such as those. Then as I developed the code I came to
believe that it was not necessary: I call url_normalize
in the url_parse function and url_normalize is already being
tested. I think I just forgot to delete those lines.

Reading that file over once again, it does have IPv6 address
test cases. So I should probably go over it again.

Thanks again for the feedback,

  Matheus
