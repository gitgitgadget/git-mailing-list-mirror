Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE7B1FAEE1
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791459; cv=none; b=QPRuKTv5R1PYJMka99+io8Y+Y6SsJBvJ5S2PNIrR5q4ItD/3v1XTsPhRuWuKxAPhsAr3vY9nYioY7joG7gtPdx0e9fAz49FyFkqxfk/o4m/dLNdqb3jC/aZ2WInt4fUC/dDeWE4fmverUq1MBEde5W6PjYRJvlZivtIJ5QKUOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791459; c=relaxed/simple;
	bh=TVdMOoKAu2iA/aNGUyD37X8+tR9vXPbjEAOivJsUjrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBsmLQi7yy4ErYD7ZKaawRqLb42rtGjcwcP0Q0mllLW3J+jImXIqjX8dd1SIjnOXVVgiW+jyHTCz6Ym1AXdNA8ZYjvneS3sHBenWiZrVn7uw/VfuvFRnvmoht56V5paRMYWuyQE/j7pcnblUqvo44liiSBJm3m8/sJeCFtwMS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=IFNmU7U1; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="IFNmU7U1"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 41j6tpejj5TbI41j8t0lib; Thu, 24 Oct 2024 18:34:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729791267; bh=weeJZ+MrWLqHcLaPq7oEhBWD/I+Almbm8JyeuYdQUAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IFNmU7U1RYcTagt6o428UPd9lxswM1YzX20bHi/gE2kZsNwZYveBVwAZt0u8oXK97
	 NkwXo8M2LpOM2EfWkWmXE24L8JqNYmBNWaByiCVB0wIsK1IHyGubxCKiCKMlCvnrP6
	 yhOTiDJAtlPkXHQqgoJGaf4gJuZcDP9UNIr2yx6/LUN5Xop7DVY8f/PN610g2ROhVm
	 RU6UJkxpY0s4ng/uqiZEeWqU31kdw4VAaIrf0cXXJ6/DnDH+4w0isqbQ6bZy/HNRdw
	 6qNJgPPswM2V2QdYAE1ODQUxJyP7N4H6rZXbSGpz7TDgSjoYT797FnENaQJajZ2HA7
	 2JiYY/37QFfOg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=K5mBHDWI c=1 sm=1 tr=0 ts=671a8523
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=-fzjhilvVhDpR0Dt7r4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <787ef076-ba72-4a0d-bfd9-1f79de4f4039@ramsayjones.plus.com>
Date: Thu, 24 Oct 2024 18:34:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
 <ZxjmTbATU7usHcqQ@pks.im>
 <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
 <Zxn1HWg7KxZwBy9h@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Zxn1HWg7KxZwBy9h@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOjZvwmkDjyBNwayMJnh8jM3CspyS3T7PgKS5SNny7aI4ltq/XPco+xb/pjwnTkv+8xoZczmgZdOCL8jjQP8f9jLmmPPAyodVhNlvmNziALSZdaNodgr
 MjHPI23ICDq8/4zqogSqwRT85fslRMbqDuAUxERgKuJWGtakT1OVTQBqZN2QPZxnA1OQb+jBXjRv2MMf2yCF2Q7HM+0Vg/7j3R8=



On 24/10/2024 08:19, Patrick Steinhardt wrote:
> On Wed, Oct 23, 2024 at 03:38:18PM +0100, Ramsay Jones wrote:
>>> Do any of the versions used maybe differ?
[snip]
> Oh, wait! I can see that there's a "python3" 3.9.18 available as a
> testing version. I don't quite understand how this works though, because
> when I install it I still have Python 3.9.16. Seems like there are two
> Python packages: "python3", which has the 3.9.18 test version, and then
> there's "python39", which only has 3.9.16. The first one just seems to
> be a meta package, so it doesn't contain anything.
> 
> So... where did you get Python 3.9.18 from? You mentioned that it also
> hogs all CPU, so could it be that this is basically a broken Python
> installation?

Hmm I have no idea how my python installation got messed up (I never try
to install TEST packages, but I do just install anything that is in the
'pending' page without even thinking!).

Last night I remembered that when installing something recently on windows
it also (without even asking) installed a windows python as well, but that
is hidden due to my path ...

  $ /cygdrive/c/Users/ramsay/AppData/Local/Programs/Python/Python312/python --version
  Python 3.12.4
  $

My current python packages (which include many obsolete python2 packages)
looks like:

  $ cygcheck -c python
  Cygwin Package Information
  Package              Version    Status
  python               3.0.0-1        OK
  $ cygcheck -c python3
  Cygwin Package Information
  Package              Version    Status
  python3              3.9.18-1       OK
  $ which python python3
  /usr/bin/python
  /usr/bin/python3
  $ python --version
  Python 3.9.18
  $ python3 --version
  Python 3.9.18
  $

Go away and wrangle with setup.exe ...

  $ python --version
  Python 3.9.16
  $ python3 --version
  Python 3.9.16
  $ which python python3
  /usr/bin/python
  /usr/bin/python3
  $ cd git
  $ mkdir build
  $ cd build
  $ meson setup .. -Dprefix=$HOME
  ...
  git v2.47.GIT
  
    User defined options
      prefix: /home/ramsay
  
  Found ninja-1.12.0 at /usr/bin/ninja
  $ ninja
  [699/699] Linking target t/helper/test-tool.exe
  $ meson test 't000*'
  ninja: Entering directory `/home/ramsay/git/build'
  ninja: no work to do.
  1/9 t0002-gitfile           OK             10.52s
  2/9 t0004-unwritable        OK              6.78s
  3/9 t0005-signals           OK              5.96s
  4/9 t0003-attributes        OK             54.40s
  5/9 t0006-date              OK             31.39s
  6/9 t0001-init              OK             61.68s
  7/9 t0007-git-var           OK             12.93s
  8/9 t0008-ignores           FAIL           106.29s   exit status 1
  >>> PATH='/home/ramsay/git:/usr/bin:/usr/bin:/usr/bin:/usr/bin:/home/ramsay/bin:/usr/bin:/usr/bin:/home/ramsay/bin:/home/ramsay/bin:/usr/local/bin:/usr/bin:/cygdrive/c/WINDOWS/system32:/cygdrive/c/WINDOWS:/cygdrive/c/WINDOWS/System32/Wbem:/cygdrive/c/WINDOWS/System32/WindowsPowerShell/v1.0:/cygdrive/c/WINDOWS/System32/OpenSSH:/cygdrive/c/Users/ramsay/AppData/Local/Programs/Python/Python312/Scripts:/cygdrive/c/Users/ramsay/AppData/Local/Programs/Python/Python312:/cygdrive/c/Users/ramsay/AppData/Local/Programs/Python/Launcher:/cygdrive/c/Users/ramsay/AppData/Local/Microsoft/WindowsApps:/usr/lib/lapack' MALLOC_PERTURB_=105 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 GIT_BUILD_DIR=/home/ramsay/git/build /usr/bin/sh t0008-ignores.sh
  
  9/9 t0000-basic             OK             193.52s
  
  Ok:                 8
  Expected Fail:      0
  Fail:               1
  Unexpected Pass:    0
  Skipped:            0
  Timeout:            0
  
  Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
  $
 
So, a big improvement! :)

Having a quick squint at the failure, it '# failed 1 among 397 test(s)'
which was 'not ok 391 - correct handling of backslashes', which is the
only test marked with a '!CYGWIN' prerequisite! ;) So it seems that I
am doing something wrong, which results in the prerequisite not being
set.

I haven't debugged that yet, but I wanted to note the above improvement
having 'fixed' my python installation. (It doesn't look good for the
TEST package! :) ).

Thanks!

ATB,
Ramsay Jones
 `

