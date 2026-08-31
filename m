Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878B3AAF57
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202779; cv=none; b=CPfVrazjccSIUAu5AqkhAmqFPGYgEcfbhB+AHwn6Oa7Gq3lkFEERDYQeXss5qfpbFFImfyZGO7++U7aWto7hJbGgEIWCHLACn1hJSH5js3SEV6sKp2XTLf3udq+ZwcYW3AX7D3RqbXcIIyS/6/y9HOpQkHX0o4OgJBDsVmzhcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202779; c=relaxed/simple;
	bh=k9lc3jE9dCCwyOCJ94vBMLffe0ow/fDBwuBVoqov8XE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lPbZALeALyf1D+OkgQZprBZLFyZXL8NeWC4Wemgrd+b51LJXA6zP9xMt0jjpMGjQKhYJDrjfEb7hLWejB4+IOViITPuIJbec7YfMD1lJQwy5yV6nptOiPkHSFKq3G6zAS9TAHNSGbWJeDjguvOZCxKrahjwXee6jstwtMjvSdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VXSvYGNr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MfTVWlsO; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXSvYGNr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MfTVWlsO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69BA07A01DF;
	Mon, 31 Aug 2026 14:59:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 14:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788202776; x=1788289176; bh=iuB/reAeed
	WLRoIptdYKB8M0qOXggWn8PNuP3t8ikr8=; b=VXSvYGNrGEEjsBuRcdKoTTOsrl
	g77Q3ZRrthB8JMaOiPsxi/tUHBBMfPBYxu3VAPfpJpY0xBWIw0xBcm6PmyMgFn43
	vHRRn5AvEQG+uXCMnQ2ZwATSqkkfxp1A+wujfQQRDlw8Xp6zF33g65wPYxOEA145
	SfWjj0ZFq1H3f+ujW6r4b80koUGC9OGdAgvtnjj7Js/Rj8wFSHwbpbKhKKOLtE3A
	rMIkOOQTy0T3VmGaAXj8E+l3ZMI5PRrYy/RAvDDxJ3hq+uHDy20d2XH3oPr42d8H
	DDhq7HPoDY0q19u2eiZZIOaf8CwFpPsO4ZF6l3fn2T5BmKTxvY9AfvZ7aOUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788202776; x=1788289176; bh=iuB/reAeedWLRoIptdYKB8M0qOXggWn8PNu
	P3t8ikr8=; b=MfTVWlsOE1rhukQYqw92Y7m4uQZTbHIrWGl+jCNhjq6qopomxst
	QHDQvV9BNrXNXvtRTxztTPhLHsbvI7F1NzBJXg4CFTDOlEAZj414aweXjvQ5I8CU
	36KbiJIJXVAT1W+WSxY4wCsshLNgZaH/m4UHHueO2hb/2Pd56hp5lIyWbRHHdsk0
	yreZvl5Le8Wsdx/NPL9cn7B3o3H6rssAWfd5IHcQdDi2K8M3uPTg8agh9WpZuEGa
	MxhCL/CeQ4mgEK1knore0TFt8OI/y2rkJsI9rcThk7oRr0a1cWk3vfFAxS47PJ4R
	yuY+vX1S9BLK97JUjbZRChGiBHBZ6OYajIA==
X-ME-Sender: <xms:GM-VavSp9wU1ZstmZDXErTyPWrZWvg1Fwt0fmnCNDjqo7u_7ozMJ8Q>
    <xme:GM-Vanp7QW0Wcn4UL921TcXj6fG-YPM2jezwIgJZvjQogTcRMUPPPgnNiF4GOrh-u
    iBkZr0BIf_kPSoiyW6bnGIMRcAxychxllbKdcw5pXpXRt60_xFDGgo>
X-ME-Received: <xmr:GM-VatLBW510snmgLyPacOPR4JMpvWImprsaR27R46ON-srxzStc73o3ScouewqJR0XZtXl6tRRioEGZRFJ2H67cIVd-Eg6eEQ>
X-ME-Proxy-Cause: dmFkZTGN+XoKdlc4EQKMygtXOhFm8njOc+fbP8XO7+n/UDv3Xcc6fxReOPjPtTcDJii9dj
    mz0DwHZv0TYXCOFgvj/gzPJY22VruQS+/etavM7ssImVIgz7D/fzADE0bXvFcDYF7YIdg+
    M4JgVu83LgEfCFwQ9KYVp4L1KO5voE3hpkCrfa9rM9H9HDgoTKaBHW6SN79nOxI18uTYr9
    gA2o7JFlT9vVVLgl7ohRCTpcXSltY3NHZWMdlNmmVnhif8Uw/zLLZgp44QgNHaZ/5J6CWX
    l9dj6ibA1aVLaclYWNk4rcixkyA5+eyGjgpsmPlTABzxCE5tIDPnJVEhxGad1mkshNRTYO
    YyKTtEwKvS++vc6lA18F8vH4TZ1yyaXlibe7jV0L0mEcpMlbKygCNUh5YbKM9bmdjl0l3T
    BItyxhXTnfJOjUTZ+nGTg1r06i37hzl5Fhf2Zr7dyAkKMgzkYnprgm+UuH5h26IShl5HTu
    Ueawe0/gEyYXmg2bOLgCcrcbE+iK4T2JfsMqiizwhrw7AvXzy9uUre8FLW+oM0l+mr2Raa
    XIF23ou1Y/8SBPdFX6ho6KHHbTt3GYPr+vT4XMEgr1fBXZH6pYSiomf/zsAqfssCjFvkIt
    0H+fH5UksD3vjNLLhG0Ipd+uI0kvAOMwp096OLyb5GAccmfFsflfJqWSgp1A
X-ME-Proxy: <xmx:GM-Vaqpcbb-JnIstxNeaHfAlb1CCEWmX3F5TJbqmaeYNjBBdM68SBQ>
    <xmx:GM-ValztntA_ODhT16dwTt9dCN-QzIcsftyvwtj68gnK-ypELOA8Lw>
    <xmx:GM-VauMRuDkQZ85LjKn9-QPUtOV1gAkDMvXreVr_ohAz6aGXC01hMw>
    <xmx:GM-Vaq7X7qBhV8nNUiHQbdg_PQWcxuXVz4gb-e6U_ramNBgUIO0Sbw>
    <xmx:GM-VardYAImw5Sqk3zlmsOBAzZ4oXt_F_zk9h8B_cEUC3OrM9qrlt4Q8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 14:59:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,  Johannes Sixt
 <j6t@kdbg.org>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
In-Reply-To: <4f4129df-681f-4e99-8b1f-8bb96e206a2d@kdbg.org> (Johannes Sixt's
	message of "Sat, 15 Aug 2026 15:44:44 +0200")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
	<9de4ea7fc1d250e8e9dfae386424451242cb3daa.1786521173.git.gitgitgadget@gmail.com>
	<4f4129df-681f-4e99-8b1f-8bb96e206a2d@kdbg.org>
Date: Mon, 31 Aug 2026 11:59:34 -0700
Message-ID: <xmqqbjaiw1yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 12.08.26 um 09:52 schrieb Johannes Schindelin via GitGitGadget:
>> diff --git a/config.mak.uname b/config.mak.uname
>> index 21f53e3f7e..3a90995587 100644
>> --- a/config.mak.uname
>> +++ b/config.mak.uname
>> @@ -465,14 +465,8 @@ ifeq ($(uname_S),Windows)
>>  	GIT_VERSION := $(GIT_VERSION).MSVC
>>  	pathsep = ;
>>  	# Assume that this is built in Git for Windows' SDK
>> -        ifeq (MINGW32,$(MSYSTEM))
>> -		prefix = /mingw32
>> -        else
>> -                ifeq (CLANGARM64,$(MSYSTEM))
>> -			prefix = /clangarm64
>> -                else
>> -			prefix = /mingw64
>> -                endif
>> +        ifneq (,$(MSYSTEM))
>> +		prefix = $(MINGW_PREFIX)
>>          endif
>>  	# Prepend MSVC 64-bit tool-chain to PATH.
>>  	#
>> @@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
>>  		BASIC_LDFLAGS += -Wl,--dynamicbase
>>          endif
>>          ifneq (,$(MSYSTEM))
>> +                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)))
>> +			# Override if empty or does not start with a slash
>> +			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
>> +                endif
>>  		prefix = $(MINGW_PREFIX)
>>  		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
>>  		BASIC_LDFLAGS += -Wl,--pic-executable
>
> At this point, MINGW_PREFIX is only used to set prefix.
>
> Only in 12/12 is the variable (and ENSURE_MSYSTEM_IS_SET) used to drive
> C code. Therefore, it seems that the following hunks concerning the
> CMake and meson build systems do not belong in this patch, yet, but only
> in 12/12.

Haven't heard anything on this topic for a few weeks.  Can we
conclude it anytime soon?  I do not like too many topics that are
almost there hanging around only because they miss the finishing
touches.

Thanks.
