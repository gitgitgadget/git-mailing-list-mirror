Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25A3A7328
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120165; cv=none; b=BBF9makYb5U3QFp27Lf4fGfRPz6GZ0SbXQmlzXlRBcTIWeI2C3PMaHE87ce3zQi0IPnp1Ns3+Z0b3nlNNS1jtlpg3/tcC6zRdvRBKtZKKZ5ytU4smvy0soTA3XGWU011eDQlDxF2icsxB9kO+2WAy+oKde9yCOVKW1Bj0ix8m8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120165; c=relaxed/simple;
	bh=vcQ3GyqbBvAt7/9111EgMaIOKcC7hztBM5S8suzL7vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1Sdw+MayWxZegKpu5y7Uq+p7ksup17nMc/iIZeHLfZAYZFVK1pylvKe9Y9H2uES4vsRDMrFShqdr6lv+DUxJ+KUlWLoGupsfe0sCelXmL34ugC02yE1gPKkERLjV8iK+4gbaNHoOv5/+4vO3BBkZuDnyDoswbr64nUs5Q8aH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATTL9awZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATTL9awZ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso18042736d6.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 14:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769120156; x=1769724956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8jTkkGEeEoydtyAnrN1bAvwR9ebVAAgOJ52Te+9O/U=;
        b=ATTL9awZRO+JCcGt6GXyRGawM5yFv4NZBJOMXfS3/mtL99zPrWJocgjpJ9t1/ZqkoD
         8pC7KJLhGfO+G/FqIMSnmWNcCLpZBo7RWssQISPP1XmXGqh4KxYSThL+tdRr5BTzLxWk
         gmIHzzFEPkJPE4p7lw3/vjDN4YP2zru7E2trySjHvhS9ezPqYKBLDpnHbBXIJmlRRJEB
         A/rYgKddfTgjUqoVZEjMFbxEenyS83ny3K9+7bXMxg8JB24c0EO15g+eUDJBoQH9r7aU
         zZJcO6Sn1G4IRsA4o/JLRl0z8ATT7TfjmwY5bpYL1DYd4ENeor4Kb+bBc4J0MdGSC93k
         g+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120156; x=1769724956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8jTkkGEeEoydtyAnrN1bAvwR9ebVAAgOJ52Te+9O/U=;
        b=G9X5qhbka1D/XWVJgWR4XlKC1Nm8uuUDCBAM8CdSHjSdbpw5LdyJ5Fn7+mx7ls2xZN
         kamKUy/DQLZHG0wynySwucgPcFuA1eT0GQUlT0T8cRWVEWXAQXhZe023fmHvtYkYik/+
         RkKV9qBvjJhMm7lwdUPgq+JXK07fJ1XzPwuePE5BlsH94ZKQ/QzVnb1cz6t3FN4vs0HB
         Nuu4VBOhFwUwoAAFIJRXjLiw0pkKmVaSLJhdsYwdpGXBIw6pFpJhnHChBkyWb3Kix2+B
         bPkN2UKyz0fU4u56UrcJrjv9J/dDY9wlmDVYm31a8+xzPavPmJCrTxcdH4EZ9q8J2rTU
         BHTQ==
X-Gm-Message-State: AOJu0YyDle32IlfKa9b/X3mEex5/hGd8K3kxXX3rsQKf3rPqD8HLHP+z
	QYAoZHn9ujNc3UGg05I4ujsu0nSazXXiJMFCEBXHkezR0qjvl95k5lU8
X-Gm-Gg: AZuq6aI2vbQRke56FRG27s7WJyVSfhqMC9+OxEp+Mh/ooLJsXa5hMvDO+pNPkLBNuM+
	xYDEld3hPId/N+q4oXNV5EvOq9Nj1oihD1hNNEuoKE9PZn98BJSQh0qFelUxIcx1YV4AnT27cLN
	mLUoKu9DwAj6+Ky+tKSd9Pgsr2VfvwEVJ8bdljaPTJ2z1BQhovE1SJdny5ZXXdIsi736K25W+hy
	0qntN/Dg2GeMVVFUHC6bTXKsS0C6x6GxRv1JqUYkvarmXnMWBjIBBlmYSmf51RNCNPxKxtAijuV
	IzUDOPHODp6O+ygNqR+q5tkterlZQ7E64ivL67bb4mY/58E9VmhE7tuK4K9NZhwr0fs6uZEvge8
	TiEAB+dr0I7udI02BuEo/9EYDLL1Qehm50pssPysrQCH2x4jf16ASm5GoKl8r8G2ifHcXt+6N3P
	0E5cCHIdN9fuPPsQJNaHK22VkPyY0hdXYxITRn0/ZO1dgCA3d/on0v64tUTQ==
X-Received: by 2002:a05:6214:3305:b0:890:5770:7f77 with SMTP id 6a1803df08f44-89482716c7emr43566486d6.28.1769120156409;
        Thu, 22 Jan 2026 14:15:56 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894918affe3sm3501416d6.26.2026.01.22.14.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 14:15:56 -0800 (PST)
Message-ID: <7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
Date: Thu, 22 Jan 2026 17:15:55 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] revision: add --maximal-only option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
 <xmqqikctl3vj.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqikctl3vj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/2026 4:44 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     My motivation for this feature is very similar to the bundle URI
>>     application. I can get around it by creating a tool that uses git
>>     rev-list --parents and then uses a hashset to collect the parent list
>>     and filter out any commits that ever appear as parents. It would be more
>>     efficient to use Git's native revision-walking feature.
> 
> How does this relate to "git merge-base --independent", or do they
> compute completely different things?

This is the same idea, where among the merge bases, the ones that are
"maximal" to that set are the --independent ones. 
 
The documentation for --independent even uses similar language here:

  In other words, among the commits given, list those which cannot
  be reached from any other.

Unfortunately, it also says "print a minimal subset" which in some
sense is correct by "it cannot be made smaller without losing
information" but we actually choose the maximal set there, not a
minimal set.

The merge-base --independent calculation is basically asking for
the maximal set among commits in the intersection of two (or more)
commit histories. One trick the merge-base calculation does is
that it first looks for the --boundary commits, and then reduces
from within that set. This avoid walking further into the history
than necessary.

You are presenting interesting overlaps of terminology and needs.
One thing that is different about 'git rev-list --maximal-only' with
a list of starting commits is that it wants the maximal set from
the _union_ of the histories, instead of the _intersection_ like
'git merge-base --independent' does.

There is potential for a performance improvement if we converted
the search to be like a merge-base algorithm and checked the
priority queue to see if all elements have the CHILD_VISITED flag.
I think the cost here is that we would need more new logic and
would lose some expressiveness of 'git rev-list'.

For example, one of the applications I mentioned will require a
range request including negative refs, such as

  git rev-list --maximal-only --stdin <<-\EOF
  refs/heads/branch1
  refs/heads/branch2
  ^refs/heads/main
  ^refs/heads/release
  EOF

And this would likely return the tips of the two branches, but
also will detect if one already reaches the other or if one of
'main' or 'release' reaches one or both of them, excluding it
from the maximal set.

Thanks,
-Stolee
