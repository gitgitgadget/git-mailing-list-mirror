Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE76B662
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507841; cv=none; b=P9xgIZu2Ly8xbjDyMxAPmx+2GJeqH0PpBH5saack6W0yGOvGOyoOUxQp5+exeBipLpUs4Lc+bA0H3E9M+NnqQaQtmxAGgnMP3TlA5nf6XqO/k3fn7DTEnD/BkzlT2Bg6k48VPh5+4VxLAPr/BT8SVaR/ScChe8i+y6C6GqQXkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507841; c=relaxed/simple;
	bh=Eb8qXlY/Tk2DG+sn3xgZ62VYXTNr5Gfbh7ifxEeMypM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bQVAPs+LCI3SntNDGnTzIsjnlZS475JS4EC3lujlCmJKQAUnY+crtdkRrpCqlCJz9Q8IGTvxleRc8YdP1inC0Zt7mOx9Mj5x6QF+YBGLGvAcvUIk26RH7eJ6NZ172QBJirnz75ZdVcgcYLfg/slawA/fGk75serYcIarLscLacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IUwx0Bu8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IUwx0Bu8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716507837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLMOu7nptVDElI0grAONfELJj0O/1zNnS505Ww6T5vs=;
	b=IUwx0Bu8IH3FyhjhDvXBbVCNPkAEv5ZdWxt0KoBo5V4Ydo6ClhTNdEBpLGGgmPHJjbrV7w
	Gt0oWsMK+lbfyUj1d+PJhCWx7qbxvznbtIaqKUDK9Mp3Y0wkw8C+frqVPyPR34BEusPOTU
	Zo1jTab29KZtcDm9U7lwXv0QI7laTnxhoumf9t6LArDhglva8OBpHzsU0O0obF2mLSB/Mh
	i7JUrjhxm7+UNzIaP3/r5QAxD3hZpB4k/FQ7DbgWZh32dWcviq+ea1qw5K9NXQdc3+LCAS
	YkBBS9h9nXkIpPt/fLEYvbLRf1U+4iz5NpQA785t0eUmBrcomNborYfV1Um+TQ==
Date: Fri, 24 May 2024 01:43:57 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
In-Reply-To: <ba1c6fbac4424a4e2c68cb439f9918eb@manjaro.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
 <xmqqh6esffh1.fsf@gitster.g> <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
 <xmqqjzjky6eo.fsf@gitster.g> <261636d461e58ac8a16180c4cd6e0460@manjaro.org>
 <xmqq7cfkqger.fsf@gitster.g> <ba1c6fbac4424a4e2c68cb439f9918eb@manjaro.org>
Message-ID: <3391a15907a055c281106c4995fb8272@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-24 01:28, Dragan Simic wrote:
> On 2024-05-24 01:04, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>>> And for usability, perhaps giving a specific command would change
>>>> the default program a bare 'P' invokes for the rest of the session
>>>> until another specific command overrides.  Another usability hack
>>>> may be "[interactive] pipecommand = less -FX" configuration variable
>>>> gives the initial default for each session.
>>> 
>>> I think that would be way too complicated.
>> 
>> It is modelled after how "less" and "vi" remembers the last pattern
>> fed to their "/" command.  You once give, say, "/test_<ENTER>" to
>> find one instance of "test_", then "/<ENTER>" takes to the next
>> instance.
> 
> Huh, less(1) actually remembers nothing when the secure mode is
> turned on.  That's another thing I've collaborated with the author
> of less(1), to make it possible to remember the last search term
> when running less(1) in secure mode.
> 
>> As I expect our target audiences are used to such a behaviour, I do
>> not think I agree with your "way too complicated".
> 
> Hmm.  Where would that state be stored?

Ah, sorry, I misread your description a bit.  There's obviously no need
to store any state, because this additional feature doesn't break the
boundaries of a single session.

However, I'd suggest that we leave this additional feature aside for 
now,
until the upcoming pager-related changes and fixes settle down.
