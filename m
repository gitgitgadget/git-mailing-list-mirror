Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1082599
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171780; cv=none; b=ljP37h/BePR58Yk/QAI/PWp22UUq6Fo1uuzBq/B9mnXc3HcuZ0SN9XA1a/dwx39yZLOO8YJqhy9dKBVTs7yZyNz+Knju/3XXT2OCK8HX00nROZxEEs1uIOCkhESf0XkyXXtY+h0mq6gOPcWLghBlN+PoOf3p7+HGOaQK7pPIQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171780; c=relaxed/simple;
	bh=OLs/VG6ep2niA2AXUTxYK/YaKUAUhIrBtT9rw6PvM34=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=T6VBuqNwuzA5ekj+hQ2PIzxN6Pzx4CdjXXUbEBLkWrso3gQStsNvoVAete8z+uBWMZeei4jhPjg6nZ2DO3Bgoy6tExjMwN/OwMw7ZSYgYYgrP+YOn1ojg+P9hNTr571r3vZzgH5gAWNAqWEyiIusNHC/M7pk9XKbuwU7jUGIbTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qFJQbiI3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qFJQbiI3"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709171773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAH6s5thw0UTjamCrC7H9ebf4jkKHgFJghz+4/Ww3BQ=;
	b=qFJQbiI37CMWXIMY2Tx9SqyKHR+oFG4k622zFNHeVSrnXSbY3gNDO1Ol4is1L7FAkOEWZY
	1heOSD8wPWUcGD02ASUhJT5tNB+w+MhMbSe0ny+pe8hDUwf4ceGbhNmYJiMiLSnc9qcubi
	jxh6pT6OBZpR+FbuNesC1dsdEMK/63kNr6SvEYDwAkdJD+vLvZ6eb8q1Rp6/AxuHjV5agL
	vxlTumt4DHCrJl4m0kY8JIxNPjeg3NaLir+ITbHOuTBdklSSgMWBjHlrkouZiioiE8/piX
	QmI8MfZ7dSEXVcXqpgosxDFG2NafTp4t1s3o2xYB9HJC9sYQ28ERDkTyvGYcUg==
Date: Thu, 29 Feb 2024 02:56:13 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH] branch: adjust documentation
In-Reply-To: <xmqqttlsld4t.fsf@gitster.g>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
 <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
 <c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
 <be91f3ad9305366c1385c2da4881537e@manjaro.org> <xmqq8r3g8caz.fsf@gitster.g>
 <35738a93f5cbace5b3235ce614b7afbf@manjaro.org> <xmqqttm3ouxy.fsf@gitster.g>
 <16c1f883-881f-4f8c-95b2-22fb4825b733@gmail.com>
 <96f1afa6-f4ac-4593-9bf4-72dafe3cab85@gmail.com>
 <b6d22f5a66de49efc623eceddbdc6faf@manjaro.org>
 <d1f928b98238a60a96bee0d3f410deef@manjaro.org> <xmqqttlsld4t.fsf@gitster.g>
Message-ID: <2c4ade0e3403f9b346e088b894d722c4@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-28 18:20, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
>> Just checking, do you see the changes that Ruben proposed in this 
>> patch
>> fit for our starting point in the git-branch documentation rewrite?

First of all, I _really_ appreciate your highly detailed feedback.
Thank you very much for taking the time to write it all down!

> The synopsis part may, but with reservations.  I know you two are
> aiming to make this in many small incremental steps, but even then
> I'd have to say the way these placeholder words will be used in the
> text part (both DESCRIPTION and OPTIONS) will be so different from
> the final shape envisioned [*1*], the wording that may fit well within
> the current text might not be the best fit in the final text.

Please, let me remind you that I've already agreed upon doing it all
in one fell swoop, which may consist of multiple patches in a series,
but applied as a whole.

> The current description section talks about option and its arguments
> without showing the syntax, making it unnecessary to be extra
> verbose.  For example, we see something like this:
> 
>     With a `-m` or `-M` option, <oldbranch> will be renamed to
>     <newbranch>.  If <oldbranch> had a corresponding reflog, it is
>     renamed to match ...
> 
> But in the final shape of the documentation, I would like to see the
> description section not talk about these arguments, and would read
> more like
> 
>     When given `-m` or `-M` options, the command renames an existing
>     branch to a different name.
> 
> among short descriptions made at the conceptual level on other modes
> like "listing" mode, "delete" mode, etc. [*3*]

I agree on that being the final outcome, because the descriptions
of arguments actually belong to the envisioned "OPTIONS" section,
as part of the command descriptions.

> And the option description would become something like [*]:
> 
>     -m [<one>] <two>::
> 	Renames the branch <one> (the current branch is used when
> 	not given) to a new name <two>, together with its reflog and
> 	configuration settings for the branch. ...
> 
>     Side note: <one> and <two> are meta-placeholders for the purpose
>     of this document; Ruben's patch proposes to call them <branch>
>     and <new-branch>.
> 
> Now in such a context, <one> and <two> placeholders having actually
> the word "branch" in it would sound redundant and awkward to read,
> Even though the choice of words Ruben made in the patch under
> discussion may work well in the current document structure.  I
> suspect these words will have to be chosen again when we start
> making the real organizational changes to the description and
> options sections.

Well, perhaps it's the best to revisit the argument naming later.

> In other words, I do not think that the patch makes an effective
> "one good step in the right direction".  At least, I couldn't see
> how the wording for placeholders the patch proposes to use would be
> helpful in deciding the placeholders used in the final version.

I see, thanks for the clarification.

> [Footnotes]
> 
>  *1* Do we share the vision on how the final version should look
>      like?  Here I am assuming "the final shape envisioned" is along
>      the lines of [*2*], i.e.
> 
>      (1) trim descriptions to just enumerate different modes of
>          operations with explanation on what they do at the
>          conceptual level;

Yes, that's also how I see it.  The "DESCRIPTION" sections should
end up describing only the available different modes.

>      (2) make each entry in the options section self contained, by
>          showing the option with their <argument>s, referring to
>          them in the explanation text;

Agreed once again.  The "OPTIONS" section should end up describing
the available options, together with their respective arguments, in
a way that doesn't require the reader to jump to other places in the
document to fully understand each of the options.

>      (3) remove non-option <argument> from the options list.

Yes, that goes along with the descriptions being self-contained.

>  *2* https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/

Sure, I already went through your message linked above, which already
described it quite well.

>  *3* Because "git branch" does so many things, the DESCRIPTION
>      section should first say the purpose of the section is to serve
>      as brief catalog of features to help readers to find the entry
>      in the option section to jump to quickly.  Something like:

Yup, as I already explained it above.  To reiterate, the purpose of
the "DESCRIPTION" section is to let the reader know what git-branch
can do, in form of easily readable prose.

>      The "git branch" command works in many modes (see SYNOPSIS
>      above).  By default the command works in the "list" option (the
>      `--list` option explicitly asks for this mode).
> 
>      will be at the beginning of the section.  The first four
>      paragraphs in the current DESCRIPTION section is about this
>      list mode.  The first three of them should probably be moved to
>      the OPTIONS section under `--list`.  The fourth paragraph
>      should be split and described in the entries of individual
>      options it talks about in the OPTIONS section.

Agreed, once again. :)  Most of the prose currently found in the
"DESCRIPTION" section should actually be moved to the various command
descriptions in the envisioned future "OPTIONS" section.
