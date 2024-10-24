Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7842C9A
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734234; cv=none; b=iAOHPSkWnvuT2tcfoyQo9IAaeMTQQEGIAxGt92GlmF7ptOJyTrSV4PB3dhPPL4QVRUgFXkUsRpbam0pzmysrwoP0yM4wQ5dejDFwLTUDJWZcBNqxxHm5tsu9/tHtmuYXvIZ+MeB2Vy9LNNcgmITDD2iHxk5QOlYYivgHN8eKVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734234; c=relaxed/simple;
	bh=fhL2PH4jVVQ92EvAbhMfBdcpAi9OL+P8hupTNJa+qjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByeWkZt4kLTFxxLwksQbyfvWqkbvMmvnfHPse6HwCOn/ooAc7Gx3sGa214ykAgcF2gjUhQ+HrVd7Vq1hgm0o11a13Ng4NQq7rmQOsKuTPWG5H7ZKN8/XXkGYzXwvXpDv5W7r2jKYiqKB7M2OJVhsCmkV0q0gqfS1JaZkolzLxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=XVq+sBvt; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="XVq+sBvt"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 3mt2tmuVsvENU3mt4tFu5Q; Thu, 24 Oct 2024 02:43:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729734222; bh=wnC47Dq5Bbss0AV9j1THRRIyHrtQxhwirXHlMLrP1w0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XVq+sBvt4us4i/Ffh7ZYVbpULfBhFdSrhTDweAqrfaEF7v5LkImT4/S0lsSxig4k0
	 LyiYe1l3LHLm4ecF8S2YDJczAd3r3WHzLfIDc/4h8RE8FWIMfEZyuRGYPxdIJnHLUj
	 4pcN99KZDQpfp4J7JhlXC7ivIl6Lh/v5xnEnnkO6jHSgcKc0NCuku4BYPdp0sp4xvM
	 UmB0o8LbbMoBTAGsD87zyd8kbPs1m/6ooHVJKQg/9i3KvSlJ3CCzVG+0mkg11eqC0n
	 zGhcf0AvV7mW1dDnpAof0Ss0zNlrHC7RHsbmYW2ujTVIRGxihAtx0nhU0AyItCySzU
	 4eD4W4+dzGRWQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T9svTOKQ c=1 sm=1 tr=0 ts=6719a64e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=KwCzb0IITaSoCp1fxiUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <b1ab6c1a-54ce-4adb-8977-ef376fdb48f1@ramsayjones.plus.com>
Date: Thu, 24 Oct 2024 02:43:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
To: Eli Schwartz <eschwartz@gentoo.org>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
 <6883a8d4-7e2e-4988-b57f-89b7c0aacadc@gentoo.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <6883a8d4-7e2e-4988-b57f-89b7c0aacadc@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKd0jFyKQ2tzGI+LPPLEEbMXxaLB9F/+8Ft/XFteglANp/IHfSWzHsCabFsYOonHROZtcuSJ8gO+zTwpfF4LkGJNlh1iLvNZHe5I9/rFuJzV1qJHA7cC
 mHuSkmK8E14V7HDuQKOIEnZ6ga/ki2e7TxbEcEgssPsCI3dlCIlkiOH8mxK7ft6jKLg+L0pNcpejWH/6HSFyvzWKSH6JNEI8kxk=



On 23/10/2024 16:58, Eli Schwartz wrote:
> On 10/23/24 10:38 AM, Ramsay Jones wrote:
>> Hmm, I could have sworn that this caused a complete rebuild for me
>> (even when having just built), hence the '--no-rebuild --print-errorlogs'
>> parameters to meson test. (Oh, maybe that was just 'meson test' - so
>> how do you run *all* tests with meson - rather than 'ninja test').
> 
> 
> "meson test" without --no-rebuild will first run "ninja" to verify that
> everything has been built, and build it if it hasn't been. When passing
> specific test names, it will filter for dependencies of that specific
> testcase, and only ensure *those* are up to date. Assuming those
> dependencies are accurate, of course. :D

Heh, yes, I just tried it tonight, and it did just as you describe:

  $ meson test
  ninja: Entering directory `/home/ramsay/new-git/build'
  ninja: no work to do.
  $ 

> What do you mean by "complete rebuild"? Do you mean all binaries that
> were already built and up to date get marked stale and recreated?

My bad, I was a little loose in my language. Whatever it was that I typed
(and I obviously can't remember what it was!), resulted in meson going
through the configuration step again followed by compilation/linking of
all binaries (or at least, that's what it looked like).

>> BTW, I have been doing:
>>
>>   $ meson setup .. -Dprefix=$HOME
>>
>> so that it matches the default prefix from the Makefile (not that I
>> have attempted to actually install yet!;) ). Can the default be set
>> in the meson.build file (with command-line override, of course)?
> 
> 
> project('git', 'c',
>   meson_version: '>=1.3.0',
>   # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
>   # on MSVC. So we instead fall back to C11 there.
>   default_options: ['c_std=gnu99,c11'],

Ah yes, this seems to work:

  $ git diff
  diff --git a/meson.build b/meson.build
  index 7c7a59d7fb..23b6f0baa2 100644
  --- a/meson.build
  +++ b/meson.build
  @@ -2,7 +2,7 @@ project('git', 'c',
     meson_version: '>=1.3.0',
     # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
     # on MSVC. So we instead fall back to C11 there.
  -  default_options: ['c_std=gnu99,c11'],
  +  default_options: ['c_std=gnu99,c11', 'prefix=$HOME'],
     version: 'v2.47.GIT',
   )
 
  $ 
  $ meson setup .. --reconfigure
  ...
    User defined options
      prefix: /home/ramsay

  Found ninja-1.12.0 at /usr/bin/ninja
  Cleaning... 0 files.
  $ 

Using the command-line to override also works:

  $ meson setup .. --reconfigure -Dprefix=/usr/local
  ...

    User defined options
      prefix: /usr/local

  Found ninja-1.12.0 at /usr/bin/ninja
  Cleaning... 0 files.
  $ 

> You can pass any command-line options in as default_options, including
> prefix. Defaulting to $HOME is somewhat unconventional regardless of
> whether it's done in a Makefile or a configure.ac or a meson.build or a
> CMakeLists.txt, but given the Makefile does indeed do that I suppose
> it's not incredibly bizarre to do it in meson.build as well. :)

I don't have any strong feelings either way, it's just that people are
used to doing a 'make install' and having the git build installed in
their home directory (including me). But it is not a huge effort to
add the '-Dprefix=$HOME', it simply needs to be documented.

I think I need to go away and RTFM at this point and not annoy you (and
others) with such noob questions! :)

[For me ATM, meson works fine on Linux, but it simply doesn't work at all
on cygwin as far as the tests are concerned (and I haven't tried installing
yet). Patrick is not seeing any problems, so I would like to understand
why we have such different results.]

Thanks!

ATB,
Ramsay Jones


