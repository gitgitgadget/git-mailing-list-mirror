Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE84CCDDB
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011130; cv=none; b=kXKHxrNVylPQqxqa6tJn9Gs7VbF2Fmvd+WG5abt1lUDaUYrbhS2gi3wXTliubY9lg/fIw96BHBITizrXYnooQGUf1j6R99fpwl6GsIH3UGyQ8gKacb9J3TjWvLhH7kb0EXbN2ZfQ3OkAKHU3UXIGl7SBr1y+v5LI0EtEgs2mgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011130; c=relaxed/simple;
	bh=hheWarb6dUFHmeUHupzbtETxNn7AGorYNg0IgavSeoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SjwXyiJSnh12v1nU8K1R4o4Qh4YpMM7Z/AHicvYneFCmSsyVGX+h7rnSnLmTFdKOanDaGES4flxOgDwik1RzbrC2YpOXgCRWLaOMMuSg9BrEeX+Tyq5c9Hm8WS5ABRjwbFOyYyAENjZ19gvLXCNo0GQK83Qi+5Z2YyJTb8IG/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cUwuyrSz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZTs6cCTj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cUwuyrSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZTs6cCTj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64694140018B;
	Mon, 21 Sep 2026 13:18:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 13:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790011128; x=1790097528; bh=dPdD57Hg0G
	cyK2zWC70iMgRJOlwcMT6KoQIoqnGh34w=; b=cUwuyrSzWVvCf343vo0CVs7jXO
	7pSMR1FPV5SKc02CqIXhuT4YXnhJrAAbP1XzDuZyNRPZ1cXm12da6J4ySLHGq8QP
	wwfyeHCvDX0KZTLd36d1+RaC1gJo7zPvTF4NBIqiEp+AWH3bSKhwfD9vLaNmSrQj
	9QyDAibpgG+aWt7IJcSj0JmpHbPdfh63MCuZckQbMWdXHbTbBWAQmFu9vFw2fPmp
	dFCWZwsoWnYzZcVJ1OPloooNB1/+/imJH0als2hxNX5olTx9xwki8lZz10kvyws+
	qtX7SUTjM4iSvfmRWs9P44CWI4KcOzHmcu7iAyP6iUYkFIRskzksTn8Ak1RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790011128; x=1790097528; bh=dPdD57Hg0GcyK2zWC70iMgRJOlwcMT6KoQI
	oqnGh34w=; b=ZTs6cCTjGrR0/0OmzextDBpFJ33pWX3733N8xxu0S8HB0hXTH4A
	LGPWyA3nUyHsE30k2x8QVW2PlkckrPeJ1Gd649+UmxXkGkZ3oGSplst8WOm/02en
	QWdE/YnrX9COSpeCjbJFJQrkmzpKis0qpsDGSa2tkkHxYEMaegBXv932kFg71QSt
	frlw5qvI/bqV8Q8xy9wD99lIAsvhUsdr2hbBG15IsG7+dU8j/NF9iL/uaLZ1FR+e
	AXPbxe3BPLc+rtP3nTWeVc0VpwQ9lXOkeiCwOzeRIz0fZK9Z95oGszXMlClSJuN2
	hIhLAC7tv2bnIiq2wbmi4ITp0HFbj/smujQ==
X-ME-Sender: <xms:-GaxanGrK2rPmahoPNT0F24cszBmYsY1cpBsbHLPyQEW66y5JR2QWQ>
    <xme:-GaxaoDGPHIEwwdVHGCqNMsF5P4PLIsnBgkPYABHVre5XgFhtUHVxYjGfti2w6aNj
    D7AVyd2rHgH643kI4CvJSTbYanFuXDNVSW2RV6hYGZdE5QXlTODkZ8>
X-ME-Received: <xmr:-Gaxai_f-oQ9_B2EXTzWvKsvwPNmvQDFcu60soioWOw1s_41t_yGnwjgnC_cyuXYJJDuKMlIdG6-HSge4nRU3MtYRXNG7XRiGa-a>
X-ME-Proxy-Cause: dmFkZTETtS8mDTPBLcLaWxfaMWvN3ZYG9wf4FFXRKcIOaPsX9FejECu0/Z7Us9YDSLwKnf
    5ofy9NPU2PT5ITqMQOUjCLJizaP41HgR9Xh5a4chblwtsyOTvX9ErpPshSs8UC95+UkIiL
    NurRxt30ZwXE/RBEw01yas3M9Ggp2VvB1f90elZEtVXhUgqgfavCBwbD7kbOIPmR/9QLgr
    UIT/JTVYFbJAHvCl0NL65zP2jsnKv3G8lQ1gRzOFaVyTZcuob2jBvAC693QA2ORpvHo9WF
    J7dHUlxmp9hVnTZPLENhQKq7dF6WyIlFumu21/aEEe/o0rtcVYa7JR7MhnK2CdaE28n0bR
    RMN+pCxA2BkJILFM4E19Lkrbf18YWm+WBKLAtcvAx8H2adKpIZ0SaYl9mvpMMZMxWh5DDZ
    oNBzGUJvttEKBv0IOGimm+59BdkB5ja0HBT0qmgOj23b2QOClrV3p+VvalBeGv8XRefuAL
    hKupTfSpTTgY/IKs5WFJij02bVEVSTVv1bnCtisK2fNwqxdfvJMHjdburH1C/oZne4t5GW
    N1yBMMOymKt9V0njWtlc0aWpjF+07qsejzZa29Lx4aCDo5+GL4sk/da7mvU2Rup0XoV5/I
    KEmrDAmeyn5wzo29PF4WNZNi9WQMQYhFDUVUrw6qpjF+ADQAvDYT1MWCqVIA
X-ME-Proxy: <xmx:-GaxasCwlmjXma5YGn4alg0ghqSX1LxNzvTlcsHpteExuy1u5czQpA>
    <xmx:-GaxavSQa8JJRT0TTyUK4eQ5C4rDoQBW-xEH9_DofDSRKTk5c5_6Mw>
    <xmx:-GaxarsOKDQTZQRY7y-rkZdKALdER4Vu_ASJiqZ5Ss-2hNo1lNFpYw>
    <xmx:-Gaxaj2-tv4JMPr91lS4CR86BVGYKAZGP4SYk_W4tKbLUDicJnuUuQ>
    <xmx:-GaxajAJq4V1nN3ZHzvONTViUe2NrSlk7PZLWLGnWoaunjeJ0MsYgsxe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:18:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yongqiang Tian <yqtian668@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes Sixt
 <j6t@kdbg.org>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] compat/winansi: fix die_lasterr() argument formatting
In-Reply-To: <20260921062114.14450-1-yqtian668@gmail.com> (Yongqiang Tian's
	message of "Mon, 21 Sep 2026 16:20:53 +1000")
References: <20260916042312.35891-1-yqtian668@gmail.com>
	<20260921062114.14450-1-yqtian668@gmail.com>
Date: Mon, 21 Sep 2026 10:18:46 -0700
Message-ID: <xmqqwlsemsjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yongqiang Tian <yqtian668@gmail.com> writes:

> During WinANSI initialization, duplicate_handle() reports the handle
> when DuplicateHandle() fails. die_lasterr() collects the formatting
> arguments in a va_list, but passes that va_list to die_errno() as an
> ordinary variadic argument. die_errno() consequently formats part of
> the va_list representation instead of the supplied handle, producing
> an incorrect fatal message.

Interesting.

It's a shame that nobody noticed the broken calling sequence since
the bogosity was first introduced into the codebase at eac14f8909
(Win32: Thread-safe windows console output, 2012-01-14).

> The helper also converts GetLastError() to errno, losing the exact
> Windows error code.
>
> Remove die_lasterr() and report GetLastError() directly at its four
> call sites, following the existing Windows diagnostic style. This
> passes the handle to the formatter correctly and preserves the Windows
> error code. Keep the existing %li representation of the handle.

OK.

> With MinGW GCC 13, compat/winansi.o builds with DEVELOPER=1 and the
> complete git.exe builds and links.

I am puzzled here.  What's the relevance of these two lines?

Are you telling us that how you have built and tested the patch?
Unless the set-up to test this change needs some special care, we
usually do not write such a thing in our proposed log message.

> Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
> ---
>
> Changes since v1:
> - replace die_lasterr() with direct die() calls;
> - preserve exact GetLastError() values instead of mapping them to errno;
> - follow the existing Windows diagnostic style and retain %li for the
>   handle;

Good collaboration.  If I were doing this commit, judging from the
discussion on v1 iteration, I would probably have added a Helped-by:
to credit j6t, though.

> - verify compat/winansi.o with DEVELOPER=1 and build and link the
>   complete git.exe with MinGW GCC 13.

Is that a change, meaning v1 was sent without building, linking and
testing?  Improving on that is a very welcome thing ;-).

>  compat/winansi.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)

Nice.

> -static void die_lasterr(const char *fmt, ...)
> -{
> -	va_list params;
> -	va_start(params, fmt);
> -	errno = err_win_to_posix(GetLastError());
> -	die_errno(fmt, params);
> -	va_end(params);
> -}

Very good to see this go.
