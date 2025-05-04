Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2567290F
	for <git@vger.kernel.org>; Sun,  4 May 2025 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746385513; cv=none; b=MEzwW2lzm5FdJvoEwbxqKair1NwNQn2TT63Qx8vBO9V21WxWWMEhdIu2NxbDGHLsc5hpa17mYe6X/DzJbwF6fOjxpU4cXbpXeMMRHJW39zTQAaeexriPKsVBUH35uXqBczv/WAov181FPBTikKQ1BMR057TUDCLV4XPpbDiQzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746385513; c=relaxed/simple;
	bh=4PZo69I9X11roAu5fvkf4Zf9v0DevVCxxQyg/M0Ky+s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EuXvscGTD1ooRAvzuWsNzb30IKZoSwTd24jjHqGr9cuKXO5/iIruqA265TrnUL7EE+rPVswNf1Gcwt0Si/PA6m2K/wqX650kricu864y0XVQGtF91j7HuoliO/dtx/Rcm7U/BoO7iip6IaXMRj7rpMnwyZwDMLwRiB7OPzqCmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=gswgwrIM; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="gswgwrIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1746385502; x=1746990302; i=tboegi@web.de;
	bh=9GjnyyzBzc114ym+caKE8XCYlV/BOrqojmzcjkXCDqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gswgwrIM0V6rl9VahO+U5xcz7aBDGFZfIp6oKklSxLFeW9ssKEREaNZqw+K/19Q+
	 5aM802baxljRSUiEjdQYjtqi4SZdne1MvGCSu/pYXU2fPVrcbsavtAaJGdN0XeYoF
	 RD7hqtGUR9xlgFzRyUNuVb7OHAGaltldvN9M6mxf4fapNq3TUiz6UoVV2HwGHWdjx
	 prJVgcfZg6cH1nlkIyrckYbkpKclrDiASgyiuUXOik8GigSBvEM3l0utiFhHydK5n
	 TYFDwt/72o3g5IJKXIMnoTL81FLSuN6w/WvPWqoQ1jeQg7hxCG9ZpgBUFRaFJ9uVt
	 DG6byxl/84JyGhewDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.142.129.212] ([185.209.196.217]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Lg-1u5adE2QFS-003QSn for
 <git@vger.kernel.org>; Sun, 04 May 2025 21:05:02 +0200
Message-ID: <7efc9c9c-8187-4e10-bf9d-1cbb6aeac124@web.de>
Date: Sun, 4 May 2025 21:04:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Problems with 82e79c63642c, NOT_CONSTANT with sigfillset()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:shfTHH6aBEBKwe610PKBDoR/hiA0WItIFTMTSLZ4OM62kJAKiex
 1Yw+GH2I+Z9sDucliDYRVlPg9AScz6ACnRsp5OZI0ADbib7VFnnd3orz5unz9sDJw8KwAum
 Dzb94pXmX8Z8x3/OQqP7SL6T7RKH+aBi8yFBu4908VeaGWnkA9y38duQs78ePVqa8f7pUlK
 Qog+eOcYTXMf8jX6Fzu5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s9JZoGcro8c=;pUTlPnTyQ6u2aBzXzQSH4uYvgWB
 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
 xkXuWBgVdzs1n2pO6RNdxU=

There is a problem with the somewhat new
commit 82e79c63642c introducing NOT_CONSTANT with sigfillset():

Compiling on older (?) MacOs machine leads to this:
     Undefined symbols for architecture x86_64:
       "_false_but_the_compiler_does_not_know_it_", referenced from:
           _start_command in libgit.a(run-command.o)

What is the best thing to avoid this ?

The introduced "false_but_the_compiler_does_not_know_it" triggers here
because there is a proper prototype in signal.h and then a
#define sigfillset() ...
further down in the file, which can never fail.

a) Define a sigfillset_or_die_if_needed macro,
   which does what we have today, and is simply defined
   as sigfillset() without any error checking for MacOs(some version)
b) Revert the commit (and fix the conflicts)
c) Anything better ?

I have a raw patch for b), not fully cooked, as the commit message
is the hardest part. Before sending that out:
Are the thoughts about a better solution ?




