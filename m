Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799048821
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210344; cv=none; b=qvNP2H/1hKEIf2J0ytF6W/AeV8hHR+qqeSLiL62X1ktX33OuhkKQAkemwz17Z2x4v99bWPk4uE67erl9HxOH7oXhAOM3s2miB1j6Atf49y9onaH55LNTXbMShazzjdn7ZSAoslBMa2LEMNiDRLDGDlK92s8mPDHjsMLgracXuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210344; c=relaxed/simple;
	bh=1Ln4pU7QWBrJRF/5k5AjcwhPfJDHlrvazPI9JYMAUSc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=S0deqRo4+3oSCXMWlRtyQI+/U1OZMYyQvpr+8VQd3zvbGVS+CEbFWGoI+8lyUg2tssoYN9rcx+rm0I4RnJypXz1cMnUiPm/Q/jlpzZUtl2pNheVlEqYf0F5TWxiJvNJxZuAQWKoMee0hE2N0u2dvJf6cfmwMA3/1uaDlIpKDE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aFzW4HP1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aFzW4HP1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710210337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbgDnLQhPLalSUvdHLddLABUQ6I3vJaAbfsQjvDvR8k=;
	b=aFzW4HP1krdMC2gRTXSyWRSV4+BeLuOhmb7nT9ippiybzbBCrP6dmngCPmv41CXDzpTaeU
	s2k/1V/IDRMoS9koAWQ/qMlzOpZ/NVQ0h5s4h3sHGxj323G6TjYEpSq9BCvPXKn2tn4ybd
	TB9yftJkMn/Lh6T+3I4yN417gvcKGtvljCZPYwKl43o3Y1sgeLiUf9obJviSczfABTYp/o
	tzFM/1S+fCve2SoJAQU9a9Y9RRjFI7+C9a3kHKY6kNjjRJf8QjsNFDI5qaquNBK7RC5O4c
	srByFB9W2f3uw8HZ1FrDLy28XtQ/LgV3irDeE/5Ud27vYybjhv18MgAO1oUPdA==
Date: Tue, 12 Mar 2024 03:25:37 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ralph Seichter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, rsbecker@nexbridge.com, Ralph Seichter
 <github@seichter.de>
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <xmqqzfv4pmrn.fsf@gitster.g>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
 <pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
 <xmqqy1apudvv.fsf@gitster.g> <5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
 <xmqqr0ggsmmw.fsf@gitster.g> <dd818f1709834ca6cb9050fb4ad0f4ea@manjaro.org>
 <xmqqzfv4pmrn.fsf@gitster.g>
Message-ID: <5413ccb588807965c5e54d579db1d741@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-11 20:54, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>>>> Let me interject...  Perhaps also a tab character before the "#
>>>> comment",
>>>> instead of a space character.  That would result in even better
>>>> readability.
>>> Depends on your screen width ;-)
>> 
>> Ah, screens are pretty wide these days. :)
>> 
>>> If you were trying to tell me that SP or no SP is merely a personal
>>> preference with the comment, I think you succeeded in doing so.
>> 
>> Huh, that wasn't my intention.  IMHO, a space character between "#"
>> and the actual comment is pretty much mandatory.
> 
> Ah, OK, you were talking about the gap after the value before the
> "#" that introduces the comment, but I somehow mistook it as a
> comment about the whitespace after '#'.

Yes, that's what I was talking about.  I'm sorry if the way I wrote it
initially wasn't clear enough.

> The gap after the value, I do not have a strong opinion either way
> between SP and HT, except that I agree there should be something
> there for readability.

I'd vote for a space character after "#", because that's pretty much
the de facto standard.  I don't remember seeing tabs used there.

> Given that other places where we do insert comments, like in the log
> message editor during "git commit -e", we always give a single space
> after the comment character, I tend to agree that a space after '#'
> is pretty much mandatory.  It is a non starter to tell users that
> they should add their own SP at the beginning if they want to use
> such a common style, i.e.
> 
> 	git commit --comment=' here is my message' ;# BAD

I'd agree with that.  Requiring the users to include a leading space
would make things inconistent.

> With a simple rule like "Unless your message begins with '#', the
> message is prepended by '# ' (pound, followed by a SP), but when
> your message begins with '#', the string is used as is", those who
> want to use their own style can use whatever style they want, e.g.
> 
> 	git commit --comment='#I do not want SP there'
> 	git commit --comment='#^II want a HT there instead'
> 
> and that would be a much more preferrable design, i.e. making the
> common things easy, while leaving unusual things possible.

Agreed.  That would be nice.
