Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E871E501B
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874356; cv=none; b=Cgg7Sh4k9GE0w/vwxeHdS/yMwK6WNqubNBUal46kPY3LfXK8Ej+aGz8UGpbYBw9JhSfUCoAkMMrFEYy6zQ699v1AiXOcesKisYWdgRJGnTi/LFHotmbhYTXuJk8JNrKJECcu9NyFpvL2MRcB+XWq1dfsXxPTjOfHr8IH6l8NP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874356; c=relaxed/simple;
	bh=A6lb3v4advHrMGi1ouZL07j2S9imH+QbDldZGE155rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLKMHry563RUkv3kdJGY5fG8ywZn+kHZDI+04wB1BPJNtWx55u9BQZSiln0/C91QK6yWiK/xLDGumsr4tHgPt5eItf/xtCoR3bmfn35CReadeyyXxTO9s2Mas2UxiuG49UOCoaFOsd9Cn9IQFSnqV7Rv0eZ1fRm/g7j/um6XB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=c9FQwxE8; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="c9FQwxE8"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 4NI9tiLReQyRx4NIAtJD1g; Fri, 25 Oct 2024 17:36:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1729874164; bh=35R2qhPxzCT7HAXk3bIONeAhnbDniCirdqNAoILgpm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=c9FQwxE8ZQ5HjU9ilQ3Wz4AOpLDSLsk9jLDcb8OK4VWmpLt4SiJKVfK7VPIKknBwD
	 +4B1pzzEs+V8mCale5MuQ/5pQSyAnr30hdlu/DnS1a7O44MJ/EObiZQmGRdbRrvQNM
	 MTtEnKbb62HHRub8AvL7uR62tNzSzc2pge9GDqLP7cAhb4Ve/3Abws8xXMaOzXSWZp
	 CGZKX9k/jCgYqgA+YLywpxKiNVG6XPkBTLv3vlixH6PF99EChPIzq8qm4d0QOElQYK
	 +zTiI2DSLKX5qJkQycouWVe1GKB7YWwkR8PORD84HTJaNcFZC8GWq4wTjQruGAaiuz
	 rP3O47ACaY64w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XaAqz555 c=1 sm=1 tr=0 ts=671bc8f4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=Wmu4HWGzV4stCVdrErIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <48a506c1-67a8-4ac1-9a2c-392125bb0944@ramsayjones.plus.com>
Date: Fri, 25 Oct 2024 17:36:00 +0100
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
 <787ef076-ba72-4a0d-bfd9-1f79de4f4039@ramsayjones.plus.com>
 <Zxsqr3X4FAWfy0HP@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Zxsqr3X4FAWfy0HP@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOLwSSCDRCvlY39jBizLY3ESUT7a3tOFU10E5u0KXeGUpuQ2sI4Vf0GwGxkEAcQrgRfvRcPXNb3Jq19CaEQCwtkkykB32Pa8OJM8s5j/1zYMkrMC8q1D
 lp8dzokwdNXFaxWa3up74zkxZd1zUfsfNuqEjljCBnIs8yJ5WmUUv6BJYfCAx1omBW89gzdEyMOErvmkv7tEDH+1y6TM1rh1ElM=



On 25/10/2024 06:20, Patrick Steinhardt wrote:
> On Thu, Oct 24, 2024 at 06:34:24PM +0100, Ramsay Jones wrote:
>> On 24/10/2024 08:19, Patrick Steinhardt wrote:
>> Having a quick squint at the failure, it '# failed 1 among 397 test(s)'
>> which was 'not ok 391 - correct handling of backslashes', which is the
>> only test marked with a '!CYGWIN' prerequisite! ;) So it seems that I
>> am doing something wrong, which results in the prerequisite not being
>> set.
> 
> The CYGWIN prerequisite is set depending on whether or not `uname -s`
> contains "*CYGWIN*". Does your system maybe pick up the wrong uname(1)
> binary somehow?


Yep, I suspected that I knew what the problem was, I just had not looked
to see if my hunch was correct yet! :) And indeed:

  $ pwd
  /home/ramsay/git
  $ ls -l uname*
  -rw-r--r-- 1 ramsay None  11K Jun 28  2019 uname.c
  -rwxr-xr-x 1 ramsay None 167K Jun 28  2019 uname.exe*
  $ ./uname -s
  Windows
  $ ./uname -a
  Windows satellite 10.0 19045() AMD-64 Windows 10 Home
  $ uname -a
  CYGWIN_NT-10.0-19045 satellite 3.5.4-1.x86_64 2024-08-25 16:52 UTC x86_64 Cygwin
  $

As you can see, many many moons ago (28 Jun 2019 was just the last time
it was updated/built - I suspect it was first written in 2006), I had
written my own version of uname. If memory serves, it was actually for
the 'msys' version, not cygwin! ;)

Anyway, when the test executes my PATH starts:

    /home/ramsay/git/build/bin-wrappers:/home/ramsay/git:/usr/bin ...

It is not immediately obvious why '/home/ramsay/git' is in there, but
if I move my uname out of the way:

  $ mv uname* ../src
  $ ls -l uname*
  ls: cannot access 'uname*': No such file or directory
  $ 

then everything works:

  $ cd build
  $ meson test 't000*'
  ninja: Entering directory `/home/ramsay/git/build'
  ninja: no work to do.
  1/9 t0002-gitfile           OK             10.28s
  2/9 t0004-unwritable        OK              6.70s
  3/9 t0005-signals           OK              6.13s
  4/9 t0003-attributes        OK             52.56s
  5/9 t0006-date              OK             30.16s
  6/9 t0001-init              OK             60.24s
  7/9 t0007-git-var           OK             12.93s
  8/9 t0008-ignores           OK             106.42s
  9/9 t0000-basic             OK             192.99s
  
  Ok:                 9
  Expected Fail:      0
  Fail:               0
  Unexpected Pass:    0
  Skipped:            0
  Timeout:            0
  
  Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
  $

So, I just need to build the v4 version and test again (at some point
I have to do a full (6 hour+) test run on cygwin!).

Thanks!

ATB,
Ramsay Jones

 
