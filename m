Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E42B9A7
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653394; cv=none; b=I20xHyCyWx9rQDDLvC+C5mS+ter0tVM/5DjTJvql1QK558vmC6KgkXcC78pmF57FY9HK3f5zrYM7GXyeJBvrfrXuqbuA5org/WPpGIyfN+ye2RuZBXiN5fff0ytFBGBNxjVCyn1h7FefKJ919wCMvXTAHQuzy6FAcx8V/VG35uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653394; c=relaxed/simple;
	bh=5tuvkvZBsIAtIO/EjF8BLg4WBjctFtIByxBw4F8Oe+w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mzLPI/wZnVk+XpfcjlaiCeGafx2T2qt/93iOH3pplRiliZqKcH9tqPriyKs/nh3yKymMNxgSqcbNjrhoBRScXeamwlfKBwdIeVAO2xnoY3gVSpHLBb8bxR57SL0SJkODIPkJBaNMpPWPFSl06M4gsGhEQpENdpH+I4izmsfTE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UAjvyFPq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UAjvyFPq"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711653388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=To+BMFvP5DAPYll8HbNHAxYQofxDMVF0e0Mn07qk4sY=;
	b=UAjvyFPq/jeos9VqbCpoLoLzx7mme1DItYd+ZcG2zO8v2oB+Un/1CmR+3EQkWlr7t83iA9
	7TbVOp6LIvLUdPwTntiXEuXYvoiXhz9MzBHV38hGDFmig1WY8xwGiwFaSAjBNpJqY6hrjq
	bjw5nl6hd1oVYdKZA/bRAll9bkSz52IPl6SiMWga5oaOqz3oUjc+j1/ErAz/ddiwRwQxft
	e15S159E6c6rGuiDssKEEHXWMe+We3/htWTtdsjgi7NYIIsgGC77uWM9/meq6+5skDmwZa
	97/hV6yF4SCSsm5st+w/H2qMbqrr0ZF7IQ2B4hvPaN1hSDsxIRj2E4GOl0/Twg==
Date: Thu, 28 Mar 2024 20:16:28 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eugenio Bargiacchi <svalorzen@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
 <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
 <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
 <CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
Message-ID: <de182310842ea3ff04c171a271587ca1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-28 20:08, Eugenio Bargiacchi wrote:
> But then each can configure it specifically for their terminal, no? Or
> are you afraid that a user may use different terminals at the same
> time, so the same config would be applied, so it would not work? In
> any case, my suggestion was aiming mainly to avoid having to add
> multiple options while allowing to freely customize the separators,
> but if that will not work in general to clear, that makes sense as
> well.

Of course, users could pick the right escape sequences for their
terminals, but as you already noted, the same configurations could
end up being used on different terminals.  For example, even SSHing
into a machine using a different SSH client could lead to a mess.


> On Thu, 28 Mar 2024 at 20:04, Dragan Simic <dsimic@manjaro.org> wrote:
>> 
>> On 2024-03-28 20:01, Eugenio Bargiacchi wrote:
>> >> Here's a possible solution, or better said a new configuration option,
>> >> which I've been thinking about for a while...  When running "add -p",
>> >> displayed chunks can sometimes become confusing or a bit hard on the
>> >> eyes, but simply clearing the screen _before_ displaying any new step
>> >> (i.e. a new chunk, interactive help, etc.) could make it much easier
>> >> on the eyes.  It would be a new option, of course.
>> >
>> > In my head, an option to print an arbitrary string would be amazing,
>> > since then if wanted one can print a special character that clears the
>> > screen, or simply add some space, or something else.
>> 
>> Huh, letting the users handle screen clearing that way could be rather
>> problematic, because different terminals may do it differently.
>> 
>> > On Thu, 28 Mar 2024 at 19:29, Dragan Simic <dsimic@manjaro.org> wrote:
>> >>
>> >> On 2024-03-28 19:21, Junio C Hamano wrote:
>> >> > Dragan Simic <dsimic@manjaro.org> writes:
>> >> >
>> >> >> Here's a possible solution, or better said a new configuration option,
>> >> >> which I've been thinking about for a while...  When running "add -p",
>> >> >> displayed chunks can sometimes become confusing or a bit hard on the
>> >> >> eyes, but simply clearing the screen _before_ displaying any new step
>> >> >> (i.e. a new chunk, interactive help, etc.) could make it much easier
>> >> >> on the eyes.  It would be a new option, of course.
>> >> >
>> >> > Or your 'p' option can have a 'P' variant that clears before prints.
>> >> > I have this feeling that even those who want clearing of the screen,
>> >> > they do not want it always on, when many of their hunks are 7 lines
>> >> > long.
>> >>
>> >> That would be even better.  Though, would adding new short
>> >> command-line
>> >> option to git-add be frowned upon?
