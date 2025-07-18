Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527046B8
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798213; cv=none; b=Z5us0hrl6g/2jZOBfuysEcj4Pkej2A8DzCJGsBn5HU9S+68cJJNLtMolTFBRytJZilTe06oQ9S1Nz0x3HArWWAEoX4LEfXkttyEJ3jtU7+Zz9ZOX5zR3wgR7KVXQFVUraTKKNSn4nTDjjukRYSVkpaKXQ8dhw2sR3n9RVENEGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798213; c=relaxed/simple;
	bh=gxwkVfVaw2FzY+nGsCqWXTFt41dPU9w6gSHdsku0Qgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbdWSASSokjlzIThSzQuGui1iLBF/Wp2X0XSvA2dj5nZyUL++KDYdeKqmFkTFGwg0e0LrrAY1865aOL+d/T/NwjP4AjYgT6g+Gc/o6bofz2jswn27rpVF4SJLLPx/ZHCVWJQozXpPeYDd1lZOTjC4it24CgqXbur7dHJ9s82n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QZEMb3Pz; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QZEMb3Pz"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-711d4689084so14147167b3.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752798211; x=1753403011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQzHikgZhXeHl7Yz8hXX8NLZX+e3eQAjd/3rMrKuugY=;
        b=QZEMb3PzaJMiO4sMG40XzCA1x9tUx54fe4//Xj5p9Lz/5FDBPvCQlaRjrIGqPjiyVc
         pbjmsUvl11D0DBWAGubPUdSZJ/rTTtxJRYgmIgldWH6ZJrTeHa06bre1GnAeJ4MMG01T
         JL7dZZb6B1hKgfiEkGZEUP24VUcW4fvlg0gY94ybpEy9+GkrqkaDCwfDFa8FqjvsYSGP
         6UIzNGCJPHZ2nb+eP1bi5XvyAm8J4MdSzAHV4hlYlP3vChfzYwekH0ncUnY3hNuc0E2p
         dPvTCT+xjgWoZQMC9ry/8K4pGfHhzbGU+rwd7zCbbRzXeF2QHSaOhsMSvmvfE8qjux0B
         ZpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752798211; x=1753403011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQzHikgZhXeHl7Yz8hXX8NLZX+e3eQAjd/3rMrKuugY=;
        b=gc1JUqrCXyiq43Jav+pSDIIxcxnJNDQIeg/94p4O/PuT7VKK1Kf/sSUOWZHo+SbsBz
         PW2H2XJVw+lcpP1KJi+SKlxTPZjYNtX41bsd3IAy440WA4VjN8XTBM4YSsWGM6TTUfX9
         mAP+V1hJ3oLwhoKxdK+vag6414kLIvAkQo3OWNEHklYWcdImzEB3XTVqu3aNTtq3W1tU
         yAXNuhuT2/rcq1VZv59uX71Xc4lYyJDkmtJ7vTepVmEeSQXPzua9eVpVaPn75NGsiqDT
         ljFRFAI2wdUq38zgz+b3rc0jTETeyqwF7nA+HwhkpWaeOSF44zLPzR9Aw5hAIrHPAlee
         FGyw==
X-Forwarded-Encrypted: i=1; AJvYcCW45QUSFU4/zhi0WZdG4j7KjgAEvi8PDZcGTYuA2tnX/+xk8pLBFNWZUB9B6P+dzsM4qvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNypCBYj6MKfLRTCK6Gw4N0CmPiIz+eeUjMi4cZ4LezRvoNXML
	4UbVBxBhi96gA4dJNZBb7B5I3bN+x2oRnqZ2VeeL/h2pewiRyZjdOJAQ/jSPdi+TYK/rYn+uTwT
	atun5gtY=
X-Gm-Gg: ASbGncsrdANBuzObJqi1zhrgzf1kF2SwlacyTZlCx/ljHnT+FjxXhUmoPD82nfihPs+
	2ak2WeKNQ+bBl2126ZNJY3N9XB5I6P/4arE/dqbgyACC+zlV7D+6K6Kuf8IHlXeXc+aknYiK1sv
	h+PBfxhwEQHvZ71Shj+UKzRUIuIsQpVFeOPt0HM4zpRDWoKL3Fmj55Fjh3elIW9oZg7UWGh50Yl
	+pALSAmf4Qv8BKswPDL1Ze5MHw2NjL0n+BTMqVfGUZZ/Tf5ykDPwyp26z1PhD5O9BwakmsVYy1r
	+cs74wyoRFHA3MZvjaO8lTpVXHAe9W6Tu2EyQTJc6EqtFKzRPzNwIvX7u3c05xxo5jt8nnt6acr
	InUprikU2AVyklYF5Up7ZohsjBHZQD2V8atUn+au+Vbr/zDWGxpYCJiEjjK97aWtjcNa+IZA5CX
	K+buii
X-Google-Smtp-Source: AGHT+IHEFi055DBr1cA/t1uojZSas45dUCR3hUUN3fBG4ftJWVNKWQS0mzjilJNs8k8SUV1Toak7LA==
X-Received: by 2002:a05:690c:4b90:b0:70e:86a:ae1e with SMTP id 00721157ae682-7183504246bmr130738747b3.22.1752798211096;
        Thu, 17 Jul 2025 17:23:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71953132229sm816407b3.28.2025.07.17.17.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:23:30 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:23:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
Message-ID: <aHmUAbd8DlDbVO1i@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <aHl9YLc823uWwgIp@nand.local>
 <aHmDiqsBsDJJ6m8C@fruit.crustytoothpaste.net>
 <CABPp-BFqruHDF5He=iqrUe9sYJ3XdXBcthY8i_eKMXS9tAa0oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFqruHDF5He=iqrUe9sYJ3XdXBcthY8i_eKMXS9tAa0oA@mail.gmail.com>

On Thu, Jul 17, 2025 at 04:37:24PM -0700, Elijah Newren wrote:
> > However, I'm not dead set against casting in Rust if that's what
> > everyone else wants instead.
>
> In general, I too would prefer to do the casting on the C side; after
> all, part of the reason for Rust is the language safety, which we
> compromise if we force it into using ambiguously sized variables.
>
> However, I think it might be somewhat case-dependent...
>
> Here, we have C calling into APIs that will be defined and implemented
> in Rust.  Further along the road of adopting Rust in more places, we
> may have future cases where we have Rust calling into APIs defined and
> implemented in C.  I'm wondering if in such a world the rule of thumb
> that makes the most sense would be to have a
> caller-must-cast-as-necessary guideline, rather than specifying the
> casting side by language.

Yeah, I think having some sort of general guidance here spelled out in
CodingGuidelines would be helpful. I don't think that it needs to
prescribe a specific rule, but having some of what you and brian wrote
above captured more permanently would give contributors more information
about why they may want to place the casts on one side versus the other.

Thanks,
Taylor
