Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409A144D19
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047730; cv=none; b=opGmTfIe876Bi7SArzxWcUIu8niXls+K42/do+IK279xRyWuZB1gy03hXht9EfkV6b/OwTU/dmfaikApEWdaMjz7eRC4xVNfeA7pXm6UrxAxvP0bpsmTpnEyX6X06jp2EXXOVXjcZdPBjDxOdrIffDLs5mqd1W6O0wjCX8WMlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047730; c=relaxed/simple;
	bh=1lfUyoVL3nzncdXmsqc67iJyf6EBUp+7KarjAKSZKXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tnYcHCfJjNXwSiQVQVbMmnrKKJFvP1/HsIS+4nuf4YlwkK0SmpJpbR2jj9BwqwUPiHoQ09uHFtjbhyLwKpJJrEW8Cv0Q9fA+Vo+BMjuixBL7ab0AfzmXeuGD3CGtRwd4jOPl6FVqnRVyJJRS0TUtVLyaxal93ln1hNVZE0Qf/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oMI7zwwP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oMI7zwwP"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718047723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIKp8U7nvDGjmLnNmZNNNySRpl+VHz41euBSMTp3ggY=;
	b=oMI7zwwPoohQQzJ9i84AgBJe5JsDl2XNvSN99JLNrNhp/b/C4fvMerr9YJtqzwwGpK6sJe
	SQ3323JibMClBILn8uvAxIWtVnJFudEUY/tSiL1YuPpyeOlWyVWtBEr8cPViSjtlm8DwcW
	caHFPpk0BKPeJ7TLibxaA0RMIOdWPi+uzJNn4riSgv9d4VT9UBRrncyhE5ojhDsOl9opJM
	UNLB9nKy2cM586PaSscJ2XmFpgBy5sHdIOg4jP8NYYcZifg9ptf+0Sk07xIqELPSDy7e4K
	qETu/C5+aL0wDkfa00/kyqtjjPRnnQR8gRsyyDQ/naYEiCD2K5imNFOoTqBO+w==
Date: Mon, 10 Jun 2024 21:28:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Jeff King
 <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
 <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
Message-ID: <1a9f8385377d3aadfeb07ad62810b2df@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-06-10 16:09, Phillip Wood wrote:
> On 09/06/2024 08:44, Rubén Justo wrote:
>> On Sat, Jun 08, 2024 at 07:54:34AM +0200, Dragan Simic wrote:
>> 
>>> When "|xyz" is used instead, the version of the hunk with no coloring
>>> escape sequences should be piped to xyz.
>> 
>> That is a sane and conservative approach, and I'm not opposed.  
>> However,
>> giving the colorful version though a custom pager is a good thing to
>> have, I think, i.e: allowing a simple "head" without losing the
>> coloring.
>> 
>> Let's recap a bit.
>> 
>> Initially, this series aimed to enable sending chunks to the pager
>> during "add -p" sessions.
>> 
>> To reduce the blast radius of spawning a pager for each chunk, we
>> introduced a new command "P".
>> 
>> Junio suggested opening up the command to allow specifying a custom
>> pager, in the form of "P<program>".
>> 
>> The "P" command started to resemble a lot to the common pipe operator.
>> Thus, we shifted to "|<program>".
>> 
>> Some concerns were raised about controlling when to send coloring 
>> escape
>> sequences.
> 
> I'm still not really convinced that the escape sequences are a
> problem. As Peff has pointed out [1] this new command exists primarily
> to display the current hunk. I've asked for concrete examples of
> programs that it would be useful to run from "git add -p" where the
> escape codes are a problem [2,3]. Sadly the replies talked in generic
> terms about an imaginary program without any reference to displaying
> or processing a hunk from "git add -p". Without a clear use case for
> stripping the escape codes I think we should add a single command that
> pipes the colored output to a user specified program. We can make it
> clear in the documentation that the input to the user's command will
> contain escape sequences unless they pass "-c color.diff=false" when
> starting "git add -p". If it becomes clear that there is a use for the
> plain output we can add that at a later stage.

Regarding examples, just have a look at less(1), [4] which is probably
the most commonly used pager.  It requires "-R" to be specified as one
of its command-line parameters for the coloring escape sequences to be
processed properly.  The presence of "-R" is taken as granted these 
days,
but it hasn't always been the case.

If you want to see an example of the garbled output, as a result of the
coloring escape sequences not being processed correctly, just "cd" into
your favorite Git repository and run the following commands (assuming
you're using bash, if not, please adjust the first command):

   export GIT_PAGER='less'
   git log --patch

I hope that will make more clear why I'm "advocating" for three separate
new commands for "git add -p", i.e. "P", "|xyz" and ">xyz".

> [1] 
> https://lore.kernel.org/git/20240605090935.GF2345232@coredump.intra.peff.net
> [2] 
> https://lore.kernel.org/git/a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
> [3] 
> https://lore.kernel.org/git/1ae0715d-df76-4019-995e-f00f3506f2ac@gmail.com
[4] https://man.archlinux.org/man/less.1.en
