Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E221E9916
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437353; cv=none; b=Y1C1fd4qN2nzom9HDd6KctdgrDmMcmHaE7zX0+28CiVX0cU1AmyInJwab2TmIOVJTPcmBDBxJ78ZFTK9uEltNbdOnVs+z8vkldG9vHezq9L4h7cj2/2g1oVsxeD8nmgXv1f/bH5lDTPtsDqa9rFBeRJLRWgRH3PmucZIOVQgsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437353; c=relaxed/simple;
	bh=p08vIeXiY+FOkLsBQB1jd5O6lE6K2vrJBuJeycIbyZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewhOApL4GTl78FwgEOCYIqprJGWqGsyadgSSTzXJSXrGQU/cJMApRVDskGKtovbkYH8sMXlJweeua1E4N5ApDV0miOmrp92fSRCEYne630U9cZdC767GkrQPvq/BAowdmV/byuohn7bUwbfvkVi5y0GVGANmYrpRKgROkAl10H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=m07yUgMg; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="m07yUgMg"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id v5Y7ty0hWbpaNv5YAtls43; Thu, 20 Mar 2025 02:22:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742437347; bh=Yx5vXCG5fY4hyvHEj68Su39jjDKXgVNmon226Wgy2pw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m07yUgMgBOGp0+jKUBYAEAagu64QODSAF2vTZ2JOsvJ5YvOMicFCKCPxXznGvfYgv
	 mtuEJzeG1IRs+zcdDyWdkr9aUCI9H6P6yQvSFnn+T6uliuph/+hO5YJJ6NxcOjOCeD
	 k/oC1F7AiTrZmx2LuE9/EUUy+txLteM+1xbjejn1Q6FqSvHKZ2YAAfeKSYaCEWc3mY
	 O/KKtW7gUTqT7L2d0ybabXK8YTxWW35W/r6TrZy4uDebICAGWEgaCdT46GJveu1TGM
	 z88Yc0JaSFBW3EcdentvsIiAellF4siaoxkG5Nbk06TkEBJuuuCJGzOc+qViVKUD6k
	 PzJP1rl3rGXjA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67db7be3
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ukH1R-b_AAAA:8 a=fpz1Bs6srK12yVTP3iUA:9 a=QEXdDO2ut3YA:10
 a=zUGFzhdS3I8ccRoxxLmr:22
X-AUTH: ramsayjones@:2500
Message-ID: <77f8930d-dcfe-4612-b10d-1904e7530f38@ramsayjones.plus.com>
Date: Thu, 20 Mar 2025 02:22:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] meson.build: only set build variables for
 non-default values
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, GIT Mailing-list
 <git@vger.kernel.org>, Adam Dinwoodie <git@dinwoodie.org>
References: <5d0112ae-98b5-46f2-91ad-35ed11358c3e@ramsayjones.plus.com>
 <Z9rIQlUtutWPiPgD@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Z9rIQlUtutWPiPgD@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDLr0tpCFz1Kwqyy0O+QSFNpd6Xs3vQn6Bo+YhYX6HGzNeAbp2PdGhgGZos9N78yPkrd7Cr5aS0xtvO3arBOZ3YcAgVP2Cce3E+D9U7GdVOdtdjoBzqc
 VS/kcq0Kcvk6ZIdYKczBUDuFBevfxY5G4Bc92QYP3v3RFZ/qZsdmwj7RFvgBdPdRzMmW+39uRc7IJkhZY+jvlTc2BF20rGHNSuY=



On 19/03/2025 13:36, Patrick Steinhardt wrote:
> On Sat, Mar 15, 2025 at 02:46:59AM +0000, Ramsay Jones wrote:
>>
>> Some preprocessor -Defines have defaults sets in the source code when
>> they have not been provided to the C compiler. In this case, there is
>> no need to pass them on the command-line, unless the build requires a
>> non-standard value.
>>
>> The build variables for DEFAULT_EDITOR, DEFAULT_HELP_FORMAT along with
>> DEFAULT_PAGER have appropriate defaults ('vi', 'man' and 'less') set in
>> the code. Add the preprocessor -Defines to the 'libgit_c_args' only if
>> the values set with the corresponding 'options' are different to these
>> standard values.
> 
> Hm. Does this really change anything though? The behaviour before and
> after this patch are exactly the same as far as I understand, and by
> explicitly handling the defaults we basically have to hard-code more
> assumptions. So in the current form I don't see that this patch adds
> much.

Hmm, I suppose it kinda depends on how you view it! :)

I have been looking at how the three build systems (well, mainly make
and meson) differ in various ways, in order to try and determine if
there are any significant differences and (most important) bugs.
Reducing the differences allows me to more clearly identify the bugs. ;)

In this case, the original author(s) had clearly intended that the
default values were included in the code, with the ability to override
the values from the command-line/environment only for 'non-standard' or
platform-specific uses. For example, on Windows and MINGW the
DEFAULT_HELP_FORMAT is html, which is specified in the 'config.mak.uname'
file. (I don't see this override in the meson build).

Also, the documentation (see git-var.adoc) has a statement of the compiled
in choice for the default pager and default editor, *only* if they are *not*
the standard values. I have a note, from several months ago, that says the
meson build does not pass the 'git-default-pager' and 'git-default-editor'
attributes to asciidoc. The make build only sets those attributes if the
DEFAULT_PAGER and DEFAULT_EDITOR variables are *defined* (and they should
*not* be defined to the 'standard' values or the docs would not read well).
(see git-var.adoc lines 49-51 and 67-69, Documentation/Makefile lines 239-242
and 244-247).

Also, I believe (ie I need to check) that the make build relies on the main
Makefile export-ing DEFAULT_EDITOR and DEFAULT_PAGER (see line #2923) to
make that work.

I haven't looked into all of that yet (it's one of the part #2 un-written
patches), and I don't yet know how those values get 'transmitted' to the
docs meson.build file.

Also, although I have found some meson documentation (https://mesonbuild.com/),
I haven't had the time to actually study it, so I have just used search to
try and get some answers (it seems my search-fu leaves a lot to be desired).
I was half expecting you to say something like 'hey, you don't do it like
that ... do this instead ...'. ;)

[I tried searching for a option 'is_defined()' or 'is_default()' method or
similar, but didn't find anything].

So, yes I think this patch has value. :)

ATB,
Ramsay Jones



