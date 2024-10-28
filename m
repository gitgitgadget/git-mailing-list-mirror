Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC91E0DB6
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151280; cv=none; b=m8RRF3wt71ZQlch2Nwtq5fPIZlqdBRORvEZH481mw/vfBdAROliiiYpHm0kUHsK2fdVPJWE3mydB1M1GZbFuG084LDt1DIBh8T9F3j/4Y+/ETaxjRWiwwrxoxWktG4bktaCffWUn2LpFMMTcSGyodjh2Jk39Bz+T7L2lb3yqNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151280; c=relaxed/simple;
	bh=rhB9/F/iUSMIwrx5BqYHWVIrK1UthxQ8K0KQLG5V+Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYD/AnJ6KrIAAS8vl76Ldl1ia33F+0mP/d/6BfSaeCLfXjU50c8ugqJ5rG2hnsORIReSx1UCSzliJJy/QlSSCNa3J6ZtbUTuGyfgudgbd9nIjaUsUX5tUfRsffMlqkY4L7Y/4zO1vDY4EIDj2lKsr9jVktBikaqp+R1UpI/42nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=L0KJRyKb; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="L0KJRyKb"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 5XNZtqVE7QyRx5XNbtK6ow; Mon, 28 Oct 2024 21:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1730151268; bh=RWJUIF0dw1hX/QV/fq8xNx6ojaHec8RuWntgDUg/eJI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L0KJRyKbr3+bt/e/AMUYlZZblS24mA2/NlEYiEOu1UuCCJZmJmQSKAIpM4WRzl3UF
	 nh7BJocokbiAnyc1HHKgn4+PBaMZuxEqQfeyNO5wmTmLi193nUBZmMVpjwb9rKwJ77
	 a3Vk7c3K3B16icB6KsGZkhqRwu1m3X7NQiOIn6L89f09moa9YDKXOgO9fGVK02dMzV
	 M+DYRA/TxdDHJ/4JxkGxYw8gItF1jfTttGSYguduMTwJ5p3WLilEa3NCx9gpCKRLFK
	 ZWHJb8leZJFrfazqV5/Eom8mGXurg/Vog04f1dNGKN3H3qkjNe8Xx6jptKKSRV/dzQ
	 OL9TyULk66rXw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XaAqz555 c=1 sm=1 tr=0 ts=67200364
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VI6--C4H1AsZNSsnjRUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <bd6fe5c4-9c4c-4399-b44d-a57560c04d3e@ramsayjones.plus.com>
Date: Mon, 28 Oct 2024 21:34:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729771605.git.ps@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <cover.1729771605.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMcHVLaoxmO2Fn2hNOpowF44qfOu71umfWT1QwxWBfSrRHBllYlSKa+xgYW+mmWzxwAYxHBjQSgpSnboYQ7ZwRMsvBlIc6+DU3c0fk03KXdRN2ZlgoSQ
 I9BYYUV0S8uQdBkkIFK+gxeIy5efRBTd38/djytfnZJb4hARTuTMmfmFPrgtZEn4vbcWu926X2Fh4GNCFLkfBzBo5uAxWxb5roo=



On 24/10/2024 13:39, Patrick Steinhardt wrote:
> Hi,
> 
> this is the fourth version of my patch series that modernizes our build
> system. It refactors various parts of it to make it possible to perform
> out-of-tree builds in theory and then wires up Meson.

As Promised, I have tested this version on Linux and Cygwin (not full test
on patches 1-18). When built on top of fd3785337b (The third batch) with
the two branches merged (as indicated below) Linux (build+test) and cygwin
(just build) work as expected.

> Changes compared to v3:
> 
>   - Various typo fixes.
> 
>   - Our Makefile now detects unsubstituted build options in the newly-
>     introduced "GIT-BUILD-OPTIONS.in" template.
> 
>   - I've wired up support for building and installing manpages. This was
>     the last important bit missing to get a fully functioning Git
>     installation. We generate the same set of manpages that our Makefile
>     would and also render a subset of the HTML pages we generate. Not
>     wired up are our technical docs, but doing those shouldn't be all
>     that involved.
> 
>     Documentation is not built by default, but can be enabled by passing
>     any combination of `-Ddocs=html,man`.

I haven't tried this (yet).

>   - I've dropped the target names for `custom_target()` invocations.
>     Those are auto-derived from the first output anyway, so they only
>     add unnecessary noise.
> 
>   - The last patch is a compatibility patch for "seen". There are a
>     couple of topics that interact with this series, and I didn't want
>     to make all of them a strict dependency. So I've decided to just
>     create a fixup-style commit that does the necessary changes in order
>     to work with "seen". Like this, you can test without "seen" by
>     simply dropping that last commit, and you can test with "seen" by
>     merging it into this topic.

I couldn't try this patch because (at the time) the 'seen' branch
didn't build. :(

>     @Taylor: I didn't really have a better idea than this. There are
>     six additional topics that this branch interacts with, and building
>     the branch with eight dependencies in total didn't feel sensible.
>     Ideally, the topic branch itself shouldn't have the last commit, but
>     once it gets merged into 'seen' we should have it. Let me know in
>     case you have a better idea though.
> 
> This topic is built on top of fd3785337b (The third batch, 2024-10-22)
> with the following two branches merged into it:
> 
>   - ps/upgrade-clar at 30bf9f0aaa (cmake: set up proper dependencies for
>     generated clar headers, 2024-10-21). This is currently in 'seen'.
> 
>   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
>     FreeBSD, 2024-10-16). This has been merged to 'next'.

As indicated above, this worked just fine.

Now that 'seen' builds again [92855bf61d ("Merge branch 'ps/build' into seen",
2024-10-27)], I tested meson on Linux and Cygwin (build and *full* test this
time).

On Linux, the result looks like:

  $ tail meson-logs/testlog.txt
  Summary of Failures:
  
   117/1035 t1017-cat-file-remote-object-info              FAIL            0.01s   exit status 2
  
  Ok:                 1034
  Expected Fail:      0   
  Fail:               1   
  Unexpected Pass:    0   
  Skipped:            0   
  Timeout:            0   
  $ 
  
It looks like a branch has been removed from 'seen'. :) (ie the t1017* test
file does not exist).

On cygwin, the result looks like:

  $ tail -11 meson-logs/testlog.txt
  Summary of Failures:
  
    23/1035 t-reftable-stack                               TIMEOUT        30.26s   killed by signal 15 SIGTERM
   114/1035 t1017-cat-file-remote-object-info              FAIL            0.13s   exit status 127
  
  Ok:                 1033
  Expected Fail:      0   
  Fail:               1   
  Unexpected Pass:    0   
  Skipped:            0   
  Timeout:            1   
  $ 

The t-reftable-stack unit test took just over 75s on the v2.27.0 test run.
I haven't looked into it yet, but plenty of other tests run for longer than
the 30s, so I don't know why that test seems to be different.

Also, it is worth noting that the test ran for 2hr50min. Usually I have to
wait 6hr approx. for 'make test' to finish because I don't like to use any
'-j' parameters (You can't do anything else on the machine while it is
cooking the cpu!). :)

Thanks!

ATB,
Ramsay Jones


