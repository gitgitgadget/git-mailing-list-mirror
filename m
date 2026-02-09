Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1330AD10
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666298; cv=none; b=LuuwrSCM+a09zJui+4RyqycHPfghgGr41zvMEvU+zxyXf+DSFazwedIDlP+mX+f9W+bW77LqO8c2AlA5XN52SaV/UokI0G+f0HvLCN9EQBeBGf42Mt2BNBUOFtmzyZgi8Kn1MhAQpvuksq1tCIRYNauGGnuQtqGr+B9PEImfiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666298; c=relaxed/simple;
	bh=HGQ1lix13jFBbQMU4wIeHHL5GWl6+VtcVVrEE8SgE0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atov6DL2NfQ1XR1Z081OX8D2Zae7yoPe59Utd6U+yBMulkH7DecuWvUV2BIax99F0GFrYZC0+PCEktYYsoxatINisFoikV2BWEVo5OvwiAi30Gnzu+9JrrFQW2wdHfJ7pdws4RGD05vSViK36nkBOSmFhR4QSbK4ORsh1riSP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=NUyJ9R7K; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="NUyJ9R7K"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id pX8kvZqMC4vCcpX8lvqqvA; Mon, 09 Feb 2026 19:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1770666108; bh=gDsoP5/QnbMdXY3ku+lZYnCrQUfoHRjBogDWmyg31+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NUyJ9R7KbHbkMhZOQtfwwToYQrHU0t5pP9CAQd+7nfltpLfCSpG3V4CPPDneZws9d
	 p29GijjgSXNE3KvQGtpZAftYDh/5MWg1nsjXon+5fGM3xjAtCfzdGAVPiSJrSeNMAT
	 BF1VQvJOnnC+1paE9IcHTlzPEuQ9ydA0S6HBAOTyeUyOGeeGBYazOtBUYllPAiBZDn
	 8U7rpbKQoqOCY9PWy8tQv47UCnZSk+c70IudtGHsG7mO9F115Np9zF6eJpUQ9fzljj
	 +2hUk1pKfV9le5lRfwl+0Vtf0u9NrzbhEkO8EpujN6P08za+VY3TcUJagmBL9P9PAj
	 Eh0tgy+2Hxs+g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=KZZxshYD c=1 sm=1 tr=0 ts=698a387c
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=_wWHIzhCZQMUI-R4TOgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <c29e0c1d-337c-4411-8d52-07c9155e8abe@ramsayjones.plus.com>
Date: Mon, 9 Feb 2026 19:41:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Feb 2026, #03)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqq7bsob0wo.fsf@gitster.g> <aYmleK3kGqzLXyJe@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aYmleK3kGqzLXyJe@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPsZ4YlkP8+j9Xz2oHJJJhfXZQ7Q5b2H6JMpZdLaLdgf92HB1TZOoiz1Xwmjn08SW7QX2wrYg9hC7cD3m50Q3Hzca2f0X1ANDjrcHegfSpfZta+I3/KZ
 xVCZzxUnsPs1dqalFWRZ6GEcFSKqTioVlI2UfIrB+8fLYQxqgmzD5qCHSk01WDlQbNuNVQalRb0g9H7+NgA3XH1p79h3GDueLms=



On 09/02/2026 9:14 am, Patrick Steinhardt wrote:
> On Sat, Feb 07, 2026 at 03:15:51PM -0800, Junio C Hamano wrote:
[snip]
> 
>> * ps/meson-gitk-git-gui (2026-02-04) 1 commit
>>  - meson: wire up gitk and git-gui
>>
>>  Plumb gitk/git-gui build and install procedure in meson based
>>  builds.
>>
>>  Expecting a reroll.
>>  source: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
> 
> Probably makes more sense to say that this is waiting on a pull request
> of gitk, as the patch series itself doesn't need to change.
> 

So, I should probably wait until Junio pulls from Johannes Sixt, but as it stands
on the seen branch (@203d64cf67), I have warning against 'git-gui' on Linux (but
not cygwin). On Linux, I see:

  $ cat build/meson-logs/meson-log.txt
  ...
  Executing subproject git-gui

  Project name: git-gui
  Project version: undefined
  Program sh found: YES (/usr/bin/sh)
  Program tclsh found: YES (/usr/bin/tclsh)
  Program wish found: YES (/usr/bin/wish)
  Configuring GIT-GUI-BUILD-OPTIONS using configuration
  Program msgfmt found: YES (/usr/bin/msgfmt)
  Build targets in project: 694
  NOTICE: Future-deprecated features used:
   * 0.64.0: {'copy arg in configure_file'}
  Subproject git-gui finished.
  ...
  $ 

Note that on cygwin I don't get the warning and the number of build targets
is 693, rather than 694 (I don't know if that's relevant). Also the version
of meson on linux is 1.3.2, but on cygwin is 1.5.2 (so, I would have thought
that the deprecation warning would also appear on cygwin! ;) ).

The make and meson builds appear very similar, although some paths and version
numbers differ:

  $ diff build/subprojects/git-gui/git-gui git-gui/git-gui
  1c1
  < #!/usr/bin/sh
  ---
  > #!/bin/sh
  6c6
  < 	echo 'git-gui version 0.21.GITGUI'; \
  ---
  > 	echo 'git-gui version 0.21.0.257.g1a729'; \
  10c10
  <  exec '/usr/bin/wish' "$argv0" -- "$@"
  ---
  >  exec 'wish' "$argv0" -- "$@"
  12c12
  < set appvers {0.21.GITGUI}
  ---
  > set appvers {0.21.0.257.g1a729}
  378c378
  < set _shellpath {/usr/bin/sh}
  ---
  > set _shellpath {/bin/sh}
  $ 

Anyway, just an FYI.

Thanks.

ATB,
Ramsay Jones




