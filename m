Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD8202F7D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267731; cv=none; b=sSKBpCem/MamGxXVRY0iy0n7PAAF0xvhGFAMdl2oLrTef7xuyMxlrZEtLifyEzvOFp87vMGYZkwVMEbMP0Ge+Df313HEzU2epwJuzMZo/KXMW619Gkk4S+D+SE+CQ5zfC5mtO8ePlmpLZPaJVb9vmK4fqRYYmVZbLXVS9WLANaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267731; c=relaxed/simple;
	bh=v6tsWsbVZhXwjyNVxn4XLQq5ZXbHLbxUR3x+DfV1scQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLYoxs/AshC65TEUilEmCjnnegltA7I6qaU65GI1yCHu+1p0V1Uz2u4aLde9u12ks0DTIcTs5FqROzLtHWlIHM3T4QqaLFWULS9OzGvstVbXq50Cd+KpgkoJJckluRtxmxT7vn7iOF38BP518SEuRnir5I/AYEqCASnMz9qtQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=JwGW+BRG; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="JwGW+BRG"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1pWrtadXTvENU1pWttE2i4; Fri, 18 Oct 2024 17:08:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729267725; bh=tNf1qFLR7BhvhtfDisf3cWhYHLIznb2NTNkENvYUWZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JwGW+BRGbgjbmhapA0MHo7WGOGstKnsQdjQRskYqmOnPh1ka1ou6QDXVh9wMK//Rx
	 EusxFmA03E9dYYaivMdrjCIBcbANaV0QgiqFuiKDi0buFX3oj0K4VfciShWZxcVlHQ
	 G01fP9LWUoS4geZnleP+lmYbLSGXNCKXJ/O3tg68a6awCdu6ZNuV6erjfKV946/lqU
	 oes6iNXsx8b7MIfxNvz4Dv0bFbsBZuuHycsT+Kmha4dZYYqUocDWnvHlDb9ZOAkCwS
	 AEp9wKYGiFGTuaEGL3doqtVPYmovIK5u3MChH6vDEl6gKYIaqFgVA5OkTXw2JeOmv/
	 7XkRWAhpnm7tA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T9svTOKQ c=1 sm=1 tr=0 ts=6712880d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=P3QaAUlGTxtmQc9QaUIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
Date: Fri, 18 Oct 2024 17:08:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1729254070.git.ps@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <cover.1729254070.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfERyYFAe2mxH7Y3RnVDns8B8wYC0PEBHQu8RrfBAY8kt5qe7d3Dv0BB61JQ2wQ9jY1lYV0KYhcKGawFvQe4wqBfxEsvHygdRiXvfgJ0mmkOIk5wE+tG2
 Tfj8TgacJUuwk5VFhtbGkZpS+PVFI1PlkzF7GFdVTEAMKiF61vvPNpBEkCVmkK0W5i7OZfLcwDJT1vTQZ7TAAS0vf5ajN8htDmw=



On 18/10/2024 13:23, Patrick Steinhardt wrote:
> Hi,
> 
> this is the third version of my patch series that aims to modernize our
> build system infrastructure. It refactors our existing build infra to be
> ready for out-of-tree builds and then wires up Meson.
> 
> Changes compared to v2:
> 
>   - I have split out semi-related changes like the platform
>     compatibility fixes into separate series. More on that further down
>     below, where I explain the current base.
> 
>   - I have polished the CMake-related changes I've been doing as prereqs
>     while refactoring our build system. Some of the changes weren't
>     tested before, but now CMake works as expected.

Just curious, does the cmake build system work on Linux now?

(cmake is another system that I don't really know, except in a
'monkey-see monkey-do' kinda way)

> 
>   - Fixed up some dependencies in our Makefile, as I didn't amend them
>     to depend on the new generator scripts.
> 
>   - I have extracted some more scripts to massage our Perl library code,
>     shells cripts and gitweb.cgi such that they can be used by Make,
>     CMake and Meson. This also fixes generation of "gitweb.cgi" on
>     Meson as reported by Ramsay.

I haven't had time to test this yet (I haven't even properly read the
patches), but from a quick squint, this looks similar to my attempts
to do the same thing the other night (minus the cmake stuff, of course).

However, I didn't notice anything in the commit message about changing
the format of the GITWEB-BUILD-OPTIONS file, which already exists before
that commit. I did the same, btw, but it seems that file was only used to
'notice' when the configuration changed to enable the re-build of gitweb.cgi.
In which case, the change in format (rather than content) was not an issue.

> 
>   - I have fixed the cyclic dependency in our Makefile that I have
>     introduced with v2.
> 
>   - I have addressed some feedback regarding "build-systems.txt".
> 
>   - I have made things work with OpenBSD 7.6.
> 
>   - Things now work on Cygwin and MinGW64 as expected, no more test
>     failures except for t9700, which also fails with our Makefile.

This caused me some concern for a little while, since I don't recall
that the t9700 test has ever failed for me on cygwin. I have the test
output files for all versions of git (each rc and rel) from v2.12.0-rc0
(5th Feb 2017) to today (all 143 of them) and none of them show that
test failing. (I remove files from that directory on occasion when it
takes up too much disk space).

However, you qualify that statement in the commit message to make clear
that it works on cygwin, but fails on other windows 'targets'. phew! :)

>   - I have improved how we set up the required tooling on Windows such
>     that we detect Git for Windows-provided tools as we do with CMake.
>     Like this, VS Code can now trivially import the Meson project and
>     configure it. Furthermore, generation of the Visual Studio solution
>     is trivial as well. So overall, things work fine now on all the
>     important Windows environments that I'm aware of.
> 
>   - Several smaller fixes all over the place.
> 
> I've included a range-diff, but it's quite crowded overall.
> 
> In general I think that this is in a pretty good shape now. I have
> tested things on NixOS, macOS 10.15, OpenBSD 7.6, FreeBSD 14.1, Windows
> 10 with MSVC, VS Code, MinGW and Cygwin, and things are generally smooth
> and just work. I'm sure there's still going to be weirdnesses on some
> platforms regardless of that.

I had a very quick attempt on cygwin the other night, and it behaved
differently at the 'ninja test' stage. It printed something like
'[0/1] all tests' and then seemed to do nothing, except 'python3.9'
was hovering up all cycles (well over 75% anyway) with no indication
of any progress. This was nothing like the behaviour on Linux (which
also looked a bit strange, but at least showed progress on each test
as it ran).

I ^C-ed it, since I didn't want to wait 6 hours before it (hopefully)
finished running.

Thanks!

ATB,
Ramsay Jones


