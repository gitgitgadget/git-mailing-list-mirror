Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81C1DFC6
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288746; cv=none; b=o74ZFvSeCQNyRa04o+k/TK9gBgPSAXgnyNsBLSsomXU7fvfIbItaEMozR6InYC3TtXk5TtkoiTQ/Zm0rHvkTub1XVcMIoi58AbZUiEVmMA5g4AS9UbJ9QYi8nOP17I25+nzKNbVBnUf3z+wIXv/zoBL3BY5K8psD+JMB8JgUaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288746; c=relaxed/simple;
	bh=J2SzcQBdv8vLiJ4ZxgN1uZAOmBHubbh2kmod8eD8UJo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UJYtW1Y0o/WQ0CLaR8q3oYeCJDAW+qlwEg40U4xYjjpE7mdgQ58v9lF8I4EdKTLpBPHiwjEd0VgSOJMfIaHNh4eDe6My+d0CvmVOfkAGtxtjoXzYA9nzwuxozuQCJv6PQLW7EdcSItwIWdkm0N+ljhgl5uqZ0PxDh0WEPBaccLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=h0fmE2HB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="h0fmE2HB"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708288734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iru0nlu5SNIlIG2yTzjp9K81U2TR15bk/VC7BA4Puyg=;
	b=h0fmE2HB7tKb5DdfRU4fGTcmOXDSUhLhHN9BGIu1GRk7TFNxbKMENuiBn4p/+L3mHAnjhe
	R66TJuKZ8VG/jQY+at5JxcVpHWSdq6Oz7EYe0XAZjcCoNH70qZO0H9kdWroDRF3H+Bhw+L
	5OLy5IPDoFctO6miU1/aPfarOM9wn6lpYpqsqpUQ6KYxSqZ/mYXwcU/NzyRrHmjuKVv1/D
	eB3+HdBxMdyKZ4NB4NM56W3XZxoGZG+JvixL7vH6eEVPsIXzI8YkF4KnQSG3Us6dYlnt5n
	bfUa9kI9z62rUv4p8+THJXM7ypPuIR9FEnWDupl2xtju+Vo20KgFm5PfIXR0DQ==
Date: Sun, 18 Feb 2024 21:38:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
Message-ID: <be91f3ad9305366c1385c2da4881537e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ruben,

On 2024-02-17 15:58, Rubén Justo wrote:
> On 16-feb-2024 04:32:10, Dragan Simic wrote:
>> Here's what I think the example from above should eventually look 
>> like:
>> 
>>      'git branch' (--set-upstream-to=<upstream> | -u <upstream>) 
>> [<name>]
>>      'git branch' --unset-upstream [<name>]
> 
> Well, my point was not about new terms in this series, but to see if 
> the
> idea of reusing an existing one might be of interest.

Good point, ensuring such consistency would be really good.

> I find it interesting to have common terms like "<commit>" "<path>",
> "<envvar>"...

... or "<branch>". :)

> This builds intuition in the user, making it easier to grasp the 
> meaning
> of a term, which refers to a similar /thing/, regardless of being used
> in different contexts.  And in turn, it can also help to better
> understand the context.

Agreed, consistency is good.

>      Side note:  My gut tells me that my patch 5aea3955bc (branch:
>      clarify <oldbranch> term, 2024-01-06) which was originated by a
>      report [1] of a user who found the documentation confusing, would
>      have been less likely to happen (the report and consequently my
>      patch) if "<branchname>" had been used instead of "<oldbranch>" in
>      the documentation.  Not because "<branchname>" is a better name,
>      but because it is already being used in other commands with a
>      clearer meaning of: "if not specified it defaults to the current
>      branch".  And because of that a user might have be able to fill 
> the
>      gaps in -m|-c.  Of course this is based on my intuition, which I
>      know is seriously biased.
> 
>      [1] 
> https://lore.kernel.org/git/pull.1613.git.git.1701303891791.gitgitgadget@gmail.com/

After thinking a bit more about the whole thing, I think that using
"<branch>" instead of "<name>" or "<branchname>" would be our best
choice.  It would be simple, direct and clear.

Regarding the branch copy and rename operations and their argument
names, perhaps the following would be a good choice:

     --copy [<branch>] <destination>
     --move [<branch>] <destination>

It would clearly reflect the nature of the performed operations, while
still using "<branch>" consistently, this time to refer to the source
branch.  Using "<destination>" to select the destination name should
be pretty much self-descriptive, if you agree.

Of course, I'll get back to this later in this message.

> And not only can it be of help to the user, but also to developers (or
> reviewers) when documenting new commands or options;  because there is
> no need to search for a, maybe new, name if there is one that is
> consolidated.
> 
> Perhaps, less names can also improve the lives of translators by making
> it easier to reuse some of the translations.

Perhaps.  That should be another example of the long-term benefits
achieved through improved consistency.

>>      'git branch' (-m | -M) [<old>] <new>
>>      'git branch' (-c | -C) [<old>] <new>
>>      'git branch' (-d | -D) [-r] <name>...
>>      'git branch' --edit-description [<name>]
> 
> So, to your proposal:  it does not make things worse, and it reuses
> terms that are already used elsewhere:
> 
> 	$ for a in '<new>' '<old>' '<name>'; do echo $a $(git grep
> --no-line-number -E "$a" v2.44.0-rc1 -- Documentation/git-*.txt | wc
> -l); done
> 	<new> 7
> 	<old> 7
> 	<name> 147
> 
> But based on the idea I've just described, IMHO the user might not
> easily find the similarities in <old> with <name>:

I agree after thinking about the whole thing a bit more.

> And it won't be easy either with <name> and other man pages.  For
> example we have:
> 
> 	$ git grep -E 'git checkout.*(new-)?branch' 
> Documentation/git-checkout.txt
> 	Documentation/git-checkout.txt:'git checkout' [-q] [-f] [-m] 
> [<branch>]
> 	Documentation/git-checkout.txt:'git checkout' [-q] [-f] [-m] --detach
> [<branch>]
> 	Documentation/git-checkout.txt:'git checkout' [-q] [-f] [-m]
> [[-b|-B|--orphan] <new-branch>] [<start-point>]
> 	Documentation/git-checkout.txt:'git checkout' [<branch>]::
> 	Documentation/git-checkout.txt:$ git checkout -b <branch> --track
> <remote>/<branch>
> 	Documentation/git-checkout.txt:'git checkout' -b|-B <new-branch>
> [<start-point>]::
> 	Documentation/git-checkout.txt:$ git checkout <branch>
> 	Documentation/git-checkout.txt:'git checkout' --detach [<branch>]::
> 	Documentation/git-checkout.txt:     "git branch" with "-f" followed
> by "git checkout" of that branch;
> 	Documentation/git-checkout.txt:$ git checkout -b <branch> --track
> <remote>/<branch>

I'd say this solidifies "<branch>" as, hopefully, our best choice,
as already proposed above.

> On the names chosen, the risk of bikesheeding is high and there is
> nothing wrong here, so it is way better to let you work.  You have 
> taken
> the initiative from Junios's response to my patch, so thank you for
> that.

I hope we'll eventually produce a great git-branch(1) man page together.
After that's completed, I have some more plans for improving git-branch,
by introducing some additional operations.

>> > We don't say that "--edit-description" defaults to the current branch;
>> > It is assumed.  Perhaps we can take advantage of that assumption in
>> > -m|-c too.
>> 
>> We don't say that yet, :)
> 
> Yeah, but maybe we can do it without writing it down :)

Maybe, :) but again, spending a few additional words to describe that
might actually be beneficial.  We'll see how it goes.
