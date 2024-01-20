Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2410785
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764729; cv=none; b=c/MlARClUMShAona1cz1Fg9Cp/oKRC5Pej1tAiNO2uAxP78TrrTF6hUV+00vniPgr52W8ghUfzUl4aDerBLFUtzqMkB8sBr39SC1CdjZyxsRvTsr+pnGAFmUJQYtSynels5jyMTtCfQJOYCDpqvjPF0ygGIIkPOq2807TbDB8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764729; c=relaxed/simple;
	bh=KPzU3mBfH+1SNiS7LA/XeymrQFuhTKN2Dci+WmI0jWE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=kL+x4BxF9ggIqF8MJMyu3467giyU0XcG+ssbUZHuIIwz7TCrpVfvAVuUHZzXsZXtb38Jb0I5t6Pyce9OVLX3sKVRVkqXjyFZYo5WjZdRvZ/fURJfCCcwsJSbKe8RJ7Uqzns+ksKQm/Xr3iZUHn2SOMh9LWgLXkTy9LUo+TmUTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=szE94Ikw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="szE94Ikw"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705764717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACpGs/slwSoXklwdfu1fwGJDYdGZ6xnYJWIfsqguhAQ=;
	b=szE94IkwW5hrdPTUAjdK2eB/XuZrg+Mkhc/MqDuNdI93gZwAofm2EUihScEu9xuTFJL6nE
	g8MkVBjtXEz3Us982b7LJVWqQbPgEk2NGJadLbxMKmaheCChjRAV31i1wDM/hsnIqAZynE
	scLqw4vNjAb76QwMoFq+m66mXslNMpuLbqN3jxYm5sGqVr4c36toKInF98LL9tOKGRNrpb
	4ChK7Tc+Ae7XslBG+CUKeWTbakwldKuU3Xz7vCLJsTRJgip1igBpJJqTFrKHMatytzLf2D
	HMxJ5XAQoB6/7jJVXdAZoyWyG3Rzr9yN7KvG08J7rU8crdEWMLgt6tL8SKhBqQ==
Date: Sat, 20 Jan 2024 16:31:56 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <6a27be56-9d52-46bf-8136-5f1c42379fd1@gmail.com>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org> <xmqqil41duov.fsf@gitster.g>
 <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
 <20240111080429.GG48154@coredump.intra.peff.net>
 <5f322b3e6053c27dda58ef1c1f025d11@manjaro.org> <xmqqil3qsdkv.fsf@gitster.g>
 <bfded0571f133ffc1612fcbca1811a43@manjaro.org> <xmqqwms6pf72.fsf@gitster.g>
 <dd82bef87fd82f7c4bf7cbff5f873141@manjaro.org>
 <6a27be56-9d52-46bf-8136-5f1c42379fd1@gmail.com>
Message-ID: <88e5dd52ad959577fdc522b6f0f72509@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-20 12:31, Rubén Justo wrote:
> On 18-ene-2024 21:50:23, Dragan Simic wrote:
>> On 2024-01-18 21:19, Junio C Hamano wrote:
>> > Dragan Simic <dsimic@manjaro.org> writes:
>> > > On 2024-01-18 19:26, Junio C Hamano wrote:
>> > > > Dragan Simic <dsimic@manjaro.org> writes:
>> > > >
>> > > > > Perhaps having both options available could be a good thing.
>> > > > > Though,
>> > > > > adding quite a few knobs may end up confusing the users, so
>> > > > > we should
>> > > > > make sure to document it well.
>> > > >
>> > > > I agree there is a need for documentation, but we are not increasing
>> > > > the number of knobs, are we?
>> > >
>> > > Perhaps there would be one more knob if we end up deciding to
>> > > implement
>> > > support for both approaches, as previously discussed.
>> >
>> > But that would be just one knob (which I personally do not quite see
>> > the need for), not "quite a few knobs" as you said, no?
>> 
>> I'm sorry for being imprecise.
> 
> Hi Dragan

Hello Rubén!

> My original motivation for starting this series has been fulfilled:
> Give the user an option to tell us not to include the disabling
> instructions alongside the advice.

I like the whole idea, because if someone finds some hint usable and
decides to keep it displayed, displaying the additional hint about
disabling the primary hint (i.e. the advice) simply becomes redundant.

> The current consensus is: if the user explicitly enables visibility for
> an advice, we can stop including the instructions on how to disable its
> visibility.

Totally agreed, simple and effective.

> As reference, in this thread two "global" options have been reviewed:
> 
>  - To take the disabling instructions as an advice in itself and as
>    such, as with the rest, we can have a knob to disable it.  Affecting
>    all advice messages.
> 
>  - A new knob to allow the user to set the default visibility for those
>    advice messages without an explicit visibility set.  And so we can
>    take on globally what we now take on locally;  if there is not an
>    explicit visibility value but there is an explicit "default" value,
>    we can stop showing the instruction on how to disable it.
> 
>> Regarding the need for that additional "global" knob, I think it can't
>> hurt.  Some people might even find it quite useful
> 
> I don't quite understand what "global" knob you are referring to.  But 
> I
> share with you the feeling that a "global" knob might be useful.

The additional "global knob", at least the way I see it, would enable 
all
advice messages, overriding all other configuration options that may be
present.  It would be like a "big switch" that makes all advices 
displayed,
for the case in which someone decides to get rid of the hint that used 
to
be useful to them so the advice was disabled, but the hint is no longer
found to be useful to them.  In such cases, having no advice displayed
would mean that the user is unable to know easily what knob disables the
no-longer-favored hint.

The reason for "forcing" all advices to be displayed would be to allow
the advices to be displayed without the need to "fish" for the right 
knob
to be turned in the configuration file.  Though, it wouldn't be perfect
from the usability standpoint, because recreating the right conditions
for displaying some hint and the associated advice may rather easily be
practically infeasible, as already discussed in this thread.

Of course, going through the man pages to find the right knob is always
the best option for those who have the time, but having a "global knob",
to help the users a bit, if possible, in general shouldn't hurt.

I hope it all makes more sense now.  Please, let me know if further
clarification is required.

Additionally, the way I envisioned it could also be combined with the
first option for the "global knob" that you listed above, as an 
additional
option for it to "force" the advices to be displayed, in addition to the
ability to disable all advices.

> The current iteration for this series looks like it will be merged to
> 'next' soon.  In my opinion, it is a good stop for this series, and
> maybe we can explore that 'global' knob in a new one.

I agree, the "global knob" can be added later, if we decide so.

> Thank you for your interest in making this series better.

Thank you for your work on the patches!
