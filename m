Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A702114
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 00:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749082378; cv=none; b=fESBWTKj7L9iMH1ixGX+TQdpwDAFU5VkO3kBsK4TntxWW3x19RLNTVmKA90b3cdPouKkhtqiYLkOld1KetwVsrqcng67EauHlDsWeJ7VUH8pVvX71Do2u8K8u/khQRGOMftBk/XY84sMN5upZ3FltH0zh6A+tikOOMu0zX4qDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749082378; c=relaxed/simple;
	bh=yocjyzsHG5T2Nbmq9iccFIn6FuBLRfPuZj+qADWtNW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNiALOJmKGeQzq4R1XtwAGghxHmuKnpZ9OXkdr51b6hOdDee6wpVC4lp5CFo6vjU/3uCFB/b049dJKqDuKcHW74KWn4dfd9q85Ri5Lfxwrogvm14BKkNKHfjftof0TIqGHVqQWJQTBAKxUJ4uFU5KmsfucKuTvrLrSp+mVWh3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=Ioq864CG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="Ioq864CG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ae05d224so11818615ad.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 17:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1749082376; x=1749687176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iolWB5tsomsdxTQYYUQBFYTMSxEVLtnMdDF1eL8gZk4=;
        b=Ioq864CGqkVKUYlblwSA85Rk4BRj3QUV6ukOTsqpmfGewptw9RiOeMwpMP/jj8NneI
         TA8JtTPBMNO7Az8wUcGYb3LQJRQIVlXeoCv9ZCM/QtW+hUDoojBhAHZAEBuBPMyUGG9W
         lW6ED2bYrX79r432FUukgpNtglewHOfXM6bgrATwZcjT73Bldc8ijjRo3sRtduzb/+y0
         fRgDa7e/P5QuXkZEbJsPJrie80qS+7HKxh/PjKshmM5xaRkIEeHjOFFrDFx5nHq89MxJ
         7bEAst4qU7uVojNqBy8bmGdnJ3GOElOGGltm8e/g5tqWcaPh5cRMM710faHCpQm9/BB8
         4LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749082376; x=1749687176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iolWB5tsomsdxTQYYUQBFYTMSxEVLtnMdDF1eL8gZk4=;
        b=X/gpvF1xYInEAx9jpZUMuAiF6tRzZ9zB6EDM4znSW58NWijYRQ9Md/gI6P2kt/kA/T
         39O75B6yBn6Arsy87j/o7m+1SvaMYe4LngN+n9SbHA+NkO6PIzqGsAaqZT2sI+8a3Knm
         7dcXvVbxN8gvCU7Bbt2qdBGTJZRiyrar0nf41RSkj+RwGeWdVp+GBOaR2nl3lM06gakn
         ufLuxQRFVv2TW2XO+SHxHiGaaA+Q+Y0yXOhTU39h8ZblB3YPJxlmDKw3zunsvvk5nvUO
         dwS3YhO9g/+NBd5O2niakKwphbImQT08QC3Jwjpy+fxTxSkxjm0ST1hJImR3FSybohQL
         Uphw==
X-Gm-Message-State: AOJu0YyQJYAviN8S/2QrWi4nCl068lFYCy2AgL/F6zu96bTfeGFTy1OQ
	17TfGqioCT3iN9B1rGqyKmb9uFdS2uRY9SnhdLvJZY6GWzuZwxynjykbZjh2Nbu2
X-Gm-Gg: ASbGncvg2mFjag+H+Wrl1FHFHKFcrorxkTLU3BwQCN4dR4goTmc7Qis05tgmMCCV4v7
	2h2weorbZEkrLguGx7hm1iwmHBO8FJO9JzJGRHqxN91tALz0WsVSrG8VF9GwRnEb5WQ3RG5TDeO
	IqrCWYeL4sb24aRX3+3kMwJecOTnT1hDefbMjI/QViFGk9Mt/NmB4yjolBeIgUtiqO+Vo9EM99P
	KpuptO1Yq9vbgKNugOIO16CvE1ftt4QfvFYxQ95NAB5ml+kHjMsAmsiwhUD6oejRmlpC45UEIUY
	tt58Ls8yuDB2SIXbCL0LPZtygoFA7I4Z/kHES0DL8JHRSyi5oZGMrAateuc6lgreeEBZdGcogtV
	KnypyJwT0o8a3qU7RpXkfvMS6CK8i+Zni4hE=
X-Google-Smtp-Source: AGHT+IG7wdrs6hMAqUzkC/Bg6tQxo9P/3L2CEVLiA1Qs0viJP2G6xMnnP0xHRHyDmG9KP+xvaPv/Ng==
X-Received: by 2002:a17:902:fc4b:b0:234:8eeb:cf8c with SMTP id d9443c01a7336-235f166ccbfmr21711275ad.20.1749082376391;
        Wed, 04 Jun 2025 17:12:56 -0700 (PDT)
Received: from [192.168.50.28] (syn-172-091-184-234.res.spectrum.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31331a0d233sm1208a91.43.2025.06.04.17.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 17:12:55 -0700 (PDT)
Message-ID: <2eb54073-20b3-465a-ad11-a2f22eb55930@github.com>
Date: Wed, 4 Jun 2025 17:12:54 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cat-file.c: add batch handling for submodules
To: Jeff King <peff@peff.net>,
 Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
 <980ab7f7ef56944df78530dcc9c79b54d1450806.1748890555.git.gitgitgadget@gmail.com>
 <20250604195455.GB1500045@coredump.intra.peff.net>
Content-Language: en-US
From: Victoria Dye <vdye@github.com>
In-Reply-To: <20250604195455.GB1500045@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jeff King wrote:
> On Mon, Jun 02, 2025 at 06:55:55PM +0000, Victoria Dye via GitGitGadget wrote:
> 
>> To disambiguate without needing to invoke a separate Git process (e.g.
>> 'ls-tree'), print the message "<oid> submodule" for such objects instead of
>> "<object> missing". In addition to the change from "missing" to "submodule",
>> the new message differs from the old in that it always prints the resolved
>> tree entry's OID, rather than the input object specification.
> 
> OK. I read over the discussion from last year, which I think mostly
> centered around this patch. I do still think in the long run it would be
> nice for cat-file to produce what output it _can_ for a missing object
> (e.g., the oid and mode).

One way to handle that could be changing the message to something like:

submodule SP <mode> SP <oid>

but...

> 
> But I think it is OK to punt on that for now. Because "<oid> missing"
> lines already exist, we'd probably need to put such behavior behind a
> new command-line option. So while "<oid> submodule" lines would be
> unnecessary in that hypothetical future world, we are not digging the
> hole any deeper, from a backwards-compatibility standpoint.
> 
> Although speaking of backwards compatibility, I guess older readers may
> be surprised that the old "missing" message becomes a "submodule" one.
> They may need to be updated if they were written carefully to bail on
> unknown input (and were happy seeing "missing" messages for submodules).
> So there may be some fallout, but it's not like the existing messages
> were particularly useful in the first place.

...I suspect that'd be even less compatible with existing automation around
'cat-file' than just swapping out "submodule" for "missing", and users can
theoretically infer that the mode is 160000 (S_IFGITLINK). That said, if at
some point in the future we support submodules with a different mode, then
an explicit value would be fairly useful.

Happy to change it or keep it the same, I have no strong preference either
way.

> 
>> Note that this implementation maintains a distinction between submodules
>> where the commit OID is not present in the repo, and submodules where the
>> commit OID *is* present; the former will now print "<object> submodule", but
>> the latter will still print the full object content.
> 
> Hmm, that is an interesting point. It feels kind of arbitrary, but I'm
> having trouble making a strong argument for one direction or the other.
> The way you've written it means that readers need to be prepared to
> parse _both_ the mode and "<oid> submodule" lines to find submodules.
> But maybe there's some value in finding out more information about
> submodule commits you do have in-repo.

This was pretty much my thought process on it. It was a somewhat arbitrary
choice, but what tipped me towards distinguishing the cases is that I'd
rather have information like size, content, etc. about a commit and not need
to use it, than need it but not have it available. That, and it does
maintain the existing treatment of self-referential submodules.
