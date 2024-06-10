Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9410A22
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053335; cv=none; b=dQk7FmVjTZS8MA71nP+eSbwBOF19yjonmLm002cMQgXkWzfMlz04iOg1sbtgyUKTjmzIwmnyK2877lB+QlzqY0IDqj7URIBzWZc0nDZG4Uft9ZBMV9vgvpMtmFsDfA42dlbeA4ZTj5zM1ix7I6H7vTOcTlXIQjxTvm15RlRqDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053335; c=relaxed/simple;
	bh=6ZF+JGJU5YwC133+J0RVG59OLESz/DTwV6/4RNBSrvA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WA6+5+kgre1UI5DxBGnFJJgpJYkb/YUbo+E3bq9ipHStpIPLYtXzJviE2meSORmjO3GQmxXmRO23oGEFpk2fQZqkavAw/ShEODGGxF/5G+H+PWxSQCjYUSgC/ikYUO89kYZQXipMr0WpT266X4ZnA9Z0Yuj44i6Hm2/E+nC9rNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gddECe7K; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gddECe7K"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718053328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+vAxW18HswTOo7hLXGDIL3LlBnrgGiBpIy29b+Ffjs=;
	b=gddECe7KxwPNeD2xov6lIBxKKMZc9dnhhoV+8ECgcMM15yKdn2pIq73gR2R8K/Q3TdvR7F
	95dYr8uZaB+zyxfBBi09uuziVDQSLGiri0lucTw2vEHMcNT5iWzDeiujH6DiHs/Hhs9gIM
	njmkmQi02JZw7U/LX8M2Z3UC9qhDZHpLPz/QAHs70YrUz6SseVFZdtXM37gHMHiBqhcCVX
	KCTMVq5o/z+3bOxdAWQv/2JzLsTcNSGcKyXeaVt8hkXrx9dkGHdh9fdTOEzB40yp3Aq5PI
	WGQTWS10occBlr2wwmV8Ic7k4oziXR8m+UxUyKJ/9rG26e7A1zD2AdophLw/EQ==
Date: Mon, 10 Jun 2024 23:02:08 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <c4f54fdb-bf89-405b-a48a-acb58088557c@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
 <7937845d7cb7ae0179c4922ed154c5c7@manjaro.org>
 <c4f54fdb-bf89-405b-a48a-acb58088557c@gmail.com>
Message-ID: <3268c498c9ee60803384db6db2d0e94b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello all,

On 2024-06-10 21:09, Rubén Justo wrote:
> On Sun, Jun 09, 2024 at 09:57:20AM +0200, Dragan Simic wrote:
>> On 2024-06-09 09:44, Rubén Justo wrote:
>> > Some concerns were raised about controlling when to send coloring escape
>> > sequences.  Several ideas were discussed to address this, including
>> > introducing a new command ">", a modifier for "|": "||", and others.
>> > Alternatively, we could leave it up to the user to filter as needed.
>> > Or, simply, do not send escape codes at all.
>> >
>> > So, looking back at the ideas discussed in the thread, perhaps a
>> > reasonable next step might be to reintroduce the 'P<program>' command
>> > and let '|<program>' be the way to send raw, uncolored, chunks.
>> 
>> Actually, it would be better to re-introduce the "P" option, without
>> any parameters, which would display the current hunk through the
>> already configured pager
> 
> I'm sorry, but why limit the "P" command now?

I'll explain below, and provide an alternate approach.

> I understand the caution expressed in another message of this thread
> about playing it safe, but I think the user won't be surprised if we
> respect here the "color.diff" setting, just like we do with "p", and
> ...

Let me provide a quotation from git-config(1):

   color.diff
            Whether to use ANSI escape sequences to add color to
            patches. If this is set to always, git-diff(1), git-log(1),
            and git-show(1) will use color for all patches. If it
            is set to true or auto, those commands will only use color
            when output is to the terminal. If unset, then the value
            of color.ui is used (auto by default).

The key takeaway there is "when output is to the terminal", but when
you think about it, the description is a bit vague, because the output
to the terminal is also piped through the default pager when running
git-log(1), for example.  Perhaps the more accurate wording could be
"when the known destination of the output is the terminal", but that
might also be a bit confusing.

Thus, if we want to honor the "color.diff" setting, which I think we
should, then we can do everything with only one new command for "git
add -p", which would be "P<program>".  It would be seen as just another
"channel" for the "output to the terminal" category, and it would honor
"color.diff" just like git-log(1) does, for example, both when received
as "P" and as "Pxyz" from the user.

As a result, there would be no way to pipe a hunk to "xyz" with the
coloring escape sequences removed, unless "color.diff" is set to false.
That would be the most consistent approach, because "P<program>" would
be just another "channel" to reaching the terminal with the output.

Also, we'd need to update the documentation for "color.diff" to include
a description of the new "git add -p" command.

>> and let "|<program>" be the new option
>> that pipes hunks _without_ coloring escape sequences to "<program>".
> 
> ... we'll offer the command "|" to allow the user to process the raw
> chunk.

Sorry, but now I have to ask why do we want that?  If the goal is to
open the hunk in an editor, there's already a command in "git add -p"
for that purpose.
