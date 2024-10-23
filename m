Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBA1CB51D
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694312; cv=none; b=SIXYv/jQ6edTeLfjK1WsC2fT8rGQgVnuOFjz97EtSGuEOrSmG7IV1ikRgG2wHr9U1CWRYTiV0UuXZritGCYgddd0qPvrXDlyCyDw3ehXaQObOpPKwyv5J6wNBdrC1zi3suXw3SEAuhQ88sQMhtsykEEEyN7171FMjFmtTiOWkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694312; c=relaxed/simple;
	bh=cDwqoO/hpnmht1FHNZCoijp2dYRPkquWCRbsjbVRaw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuBVdD55KkWRIOp6ZBYR/QJlqIfh64sT4xAhr1GLGc0MhhgpBalRFs/SJw1UVKPsH8Lbufv7NAVL0t7TwtdI9TTEIQh/AS2n3UjBYUVMO/Jtffy1WPYceJcY2KNH2wKeTdi58kJp1udGMcRdVewpx8Fr/fG9yjU01uYC5CtA/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=G1mwkgIE; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="G1mwkgIE"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 3cV8tuCz4xile3cV9tBM7R; Wed, 23 Oct 2024 15:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729694300; bh=J6CfMVNHSwE8ozyxd2TeNF9pj+LD+TeTX0f26TK/u0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=G1mwkgIE8xqpEdK85iiOx+SBiHWwpRqbtUx84Iq6q0JVm31Ak2rV6S0U7fBuKwKLj
	 b1jujb2zwSjErNGKmWC2QgHjOAl9uq1UWYKbq7TZb1m903dVSZZ3cUJTPqk3YYkBoJ
	 vc98eX79gtlcDUdPzv4R/8yD+IQIG822PMsXrB+WatrQ87JXVnQ6p2MIK1cmIsPiyr
	 acAxMgS2dMEn8QVzPz4YeNHLHaAmVDoam7SVJMIX1up6a+5NCIZzy6jgqFDKbiInRx
	 qv/EBQW6Jo/sMeRMkD85o4iu5jfgVxflpU4rCFaTlvLB4ieURAzThenM78dHOy6o3x
	 hY0dHHVmCD0UA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=VaJUP0p9 c=1 sm=1 tr=0 ts=67190a5c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VbVRBR47IsAMTv7IAQIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <c32a7dc3-cf9f-4d42-98da-80009f9df847@ramsayjones.plus.com>
Date: Wed, 23 Oct 2024 15:38:18 +0100
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
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <ZxjmTbATU7usHcqQ@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBVhpJWhb/WIp6msy+QRTCEU2EJ5/67lXr5bO9s6V++5OVtBthgjeUayDrq6VDTMNlT12Xj7fiTi3uKyCt0rbfkXXTGXjL2WDn7c2ljz0CE2U6YwJeoX
 z2ZuykptJNB4NT6YhNLVjCP3Zb8nKlTXKD6xL1jZBURrWki13VqSlauqdaXTAkIEskwkvNNeeRHvRDS1GXb94TqN0TvgThQElHo=



On 23/10/2024 13:04, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 11:56:42PM +0100, Ramsay Jones wrote:
>> On 20/10/2024 09:51, Eli Schwartz wrote:
>>> On 10/18/24 12:08 PM, Ramsay Jones wrote:
>> [snip] 

>> Patrick, how do you run the tests on cygwin?
> 
> I didn't have to do anything special here, so this is quite puzzling. In
> a fully-updated Cygwin installation:
> 
>     $ which meson
>     /usr/bin/meson
>     $ meson --version
>     1.3.2
>     $ python --version
>     3.9.16
>     $ mkdir build
>     $ meson setup ..
>     ... autoconfiguration logs ...
>     $ meson test 't000*'

Hmm, I could have sworn that this caused a complete rebuild for me
(even when having just built), hence the '--no-rebuild --print-errorlogs'
parameters to meson test. (Oh, maybe that was just 'meson test' - so
how do you run *all* tests with meson - rather than 'ninja test').

>     ninja: Entering directory `/home/Patrick Steinhardt/git/build'
>     [582/582] Linking target git-receive-pack.exe
>     1/9 t0005-signals           OK              4.17s
>     2/9 t0004-unwritable        OK              4.58s
>     3/9 t0002-gitfile           OK              6.95s
>     4/9 t0007-git-var           OK              8.15s
>     5/9 t0006-date              OK             15.42s
>     6/9 t0003-attributes        OK             26.84s
>     7/9 t0001-init              OK             29.09s
>     8/9 t0008-ignores           OK             57.17s
>     9/9 t0000-basic             OK             83.82s
> 
>     Ok:                 9
>     Expected Fail:      0
>     Fail:               0
>     Unexpected Pass:    0
>     Skipped:            0
>     Timeout:            0
> 
>     Full log written to /home/Patrick Steinhardt/git/build/meson-logs/testlog.txt
> 
> This is starting with a fresh repo, I executed `git clean -dfx`
> beforehand.

Hmm, I have far to many 'precious' files to use 'git clean'!
(perhaps I should clone the repo to get a totally clean slate).

> 
> Do any of the versions used maybe differ?

Ah, yes, I should have noted the versions:

  $ uname -a
  CYGWIN_NT-10.0-19045 satellite 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
  $ 

  $ which meson ninja python
  /usr/bin/meson
  /usr/bin/ninja
  /usr/bin/python
  $ 

  $ meson --version
  1.3.2
  $ 

  $ ninja --version
  1.12.0
  $ 

  $ python --version
  Python 3.9.18
  $ 

So, a slightly newer python - what versions of ninja and the cygwin
'.dll' are you using? (the latter is more likely to cause an issue).

BTW, I have been doing:

  $ meson setup .. -Dprefix=$HOME

so that it matches the default prefix from the Makefile (not that I
have attempted to actually install yet!;) ). Can the default be set
in the meson.build file (with command-line override, of course)?


ATB,
Ramsay Jones



