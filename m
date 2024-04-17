Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696585F861
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335398; cv=none; b=IDjWW0+2jcW9iR14wY40eToB253M8gotxh/1ohDMVaF4u5t6HhsrfAx5uDTYUQrP1CILScjumfQXcgVa4pyKQRyG/3ayIpa/X0WgnpUveAJacS9nn4wrC8APo7mZei+5IJQzkQgtqUFKUf3IeniLRuzoSQTX3AuUJqwvUUXfRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335398; c=relaxed/simple;
	bh=TlpXjDZEiHN/Fh0Q/3ehDA2+LMHgbyU7SMlcMQ+ad5E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j+xhxoHqHYfuI/dlU6UBjZZKV42pYQyeSRZIJ0iWaMpk4hS9e9GayYiz9+4bbIwjAFBAeh3+CQpAgmaaV15mYi0Btao4JEhZg/DJycdBl4a394SWvpx64jb4q1RIYQDiwOeDsR2IfSEWazFGex7xdtIxKSYfZ1XKewc4Sz1Jgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=KiWQp5GO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KiWQp5GO"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713335393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qY4brISG8jNLFsytEHlAp5QRAM4m3M3f/QrKPi3lAWo=;
	b=KiWQp5GOXLSXZrT/3qexsk1ChKZJYSoGf9nz4wowxzShFxuwmSHwrFbONbmTttnj4Hd54n
	GxgJvXAJoL6X/gRwNI+TGXVnBwjxKctY8OnlLreAkeuRvswsNzD/gfN33uM0mAyvuDoKEk
	WgeQykljhxeDvtODFMRJ6a2AFIte3dWkRDU0JaZHUh0x43Ehm31Kk4WpLOEfSB1kRvvYPi
	P7ZcUwXvzi4nB/JsqWfjNSpOII5BUKfYmUdymIRXHlmjPSgh4O0L41Ljm1Z/1frlZWuKuS
	do0wcE/TaYJBFG3BuczovjTu/hLKnyiuGM71VRDlDqL5PDzMKbbjgd7IO5jBug==
Date: Wed, 17 Apr 2024 08:29:53 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add
 a test to t4014
In-Reply-To: <CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <CAPig+cTEp799w2-VEACYThW0COyo0SJLRS_sr-PG=LX++Tompw@mail.gmail.com>
Message-ID: <8dd3bf56d595801e0f262329a0000ea4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:15, Eric Sunshine wrote:
> On Tue, Apr 16, 2024 at 11:33 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> format-patch: fix a bug in option exclusivity and add a test to t4014
> 
> Reviewers assume that a conscientious patch author will add tests when
> appropriate, so stating that you did so is unnecessary. Thus it's safe
> to omit "and add a test to t4014" without negatively impacting
> comprehension of the subject.
> 
>     format-patch: ensure --rfc and -k are mutually exclusive

Makes sense, but the previous authors obviously weren't diligent
enough to include such a test, which presumably made the fixed bug
remain undetected for so long, so I wanted to put some emphasis on
the addition of a test.

>> Fix a bug that allows --rfc and -k options to be specified together 
>> when
>> executing "git format-patch".  This bug was introduced back in the 
>> commit
>> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix 
>> sets"),
>> about eight months ago, but it has remained undetected so far, 
>> presumably
>> because of no associated test coverage.
> 
> Everything starting at "...about eight months" through the end of the
> paragraph could be easily dropped. Reviewers understand implicitly
> that the bug went undiscovered due to lack of test coverage.

I have no problems with dropping that part, but IMHO that's nitpicking.
Also, dropping it would delete some of the context that people might
find useful later.

>> Add a new test to the t4014 that covers the mutual exclusivity of the 
>> --rfc
>> and -k command-line options for "git format-patch", for future 
>> coverage.
> 
> Similarly, no need for this paragraph. As a conscientious patch
> author, reviewers assume that you added the test, so this paragraph
> adds no information. Also, the body of the patch provides this
> information clearly without it having to be stated here.

With all the respect, I think that having that paragraph is actually
good, because explaining it clearly provides good context for the
repository history and people reading it later.

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
>> diff --git a/builtin/log.c b/builtin/log.c
>> @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char 
>> **argv, const char *prefix)
>> -       if (rfc)
>> +       /* Also mark the subject prefix as modified, for later checks 
>> */
>> +       if (rfc) {
>>                 strbuf_insertstr(&sprefix, 0, "RFC ");
>> +               subject_prefix = 1;
>> +       }
> 
> I'm not sure that this new comment (/* Also mark... */) adds any value
> beyond what the code itself already says. It may actually be confusing
> with its current placement. Had you placed it immediately above the
> `stubject_prefix = 1` line, it would have been more understandable,
> but still probably unnecessary since anyone studying this code is
> going to have to understand the purpose of `subject_prefix` anyhow.

Setting such flags should actually be performed in a callback,
but in this case creating a callback isn't warranted, IMHO.  Thus,
that comment tries to explain why a flag is set out of place.
I have no objections against removing this comment, if you find
it doing more harm than good.

I didn't place it immediately above the relevant line because it
also applies to the adjacent block for the --resend option, and I
wanted to reduce the code churn that would result from placing it
immediately before the relevant line, and moving it a couple of
lines above just a couple of patches later.

> At any rate, I doubt that any of these review comments on their own is
> worth a reroll.

Well, I need to split the series anyway, so the v2 is pretty much
inevitable.
