Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0786F314
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010588; cv=none; b=FrVlxPHOlQAbQ9C+vRTSSmvePsKnCpKVIyZU2QiEYc5SNjlzNBdCf/wTJpCEf5Cz4uSL8dkLjFr+rucB8hniMmAz/z4agX3gW2chad2BnRai6mrUjzGTcjbm2siVlVO1/OSt8ulK9GroRXxB1I4+LkQohE3zwl4DTF4YK8+yhgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010588; c=relaxed/simple;
	bh=HTOt2VpdOH6v9acPoBR+8uYhA9bRaRAKO6rWo25NQxs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=m9wgYOtIAz9wVJJEaO17P0+HtQKvUT+Kewk2+BGLo9ZXdlErZ0TAQEHADzwuajiSVONcyzjh0ResOGYAqaji3UF7PVI142VNGEaexWwXSMxTbtdWo7fcBJdYfHKSQDNgxf0H/JyiNDOD2j9ieH2RH8K6/Km4VPK/Awpac+ksyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=u2zcleXl; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="u2zcleXl"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718010578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ3vXTOKw1kyKzDeLyOjqBe7h06YteCkCQ6xcV13yj4=;
	b=u2zcleXluYmSKSWVl1xYLq7yuVgJv4xmDM2F5TNJe1rif4rZ0JiITM5DblWwXN8FpFGx4A
	YaSty+SKOVSo7hhZg6jX/gtm1J5/+18OlWDmJoreQmq7cbKadZoO6m5Psww347kxwFwFbz
	VUfkXnAESI14KamSc4iCUXS6jRECHJn9HKzq7bFmgtFC5+fBo9WzTS7o1bl2XrqmITdeuj
	PCA/KXJg4SvEZfVfJyWVgbPehbljb0T0983hGbcFKl/D1Y6dzbklNQdSCITw2VXzWbsYjd
	Wrt02XJxOXhm/jPdudf3ruT41xL/IP3zZbLEy2OAmlUBSTbJg/qVJxDawMcINQ==
Date: Mon, 10 Jun 2024 11:09:37 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <1ae0715d-df76-4019-995e-f00f3506f2ac@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <a2a59f5e-fd55-41d3-8472-b99256e1f428@gmail.com>
 <d092f5bb1d3bc7b7a821000a3cad8a1e@manjaro.org>
 <1ae0715d-df76-4019-995e-f00f3506f2ac@gmail.com>
Message-ID: <bed3ddc6e330c67fb127c045ee4530ba@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-06-10 10:27, Phillip Wood wrote:
> On 09/06/2024 18:20, Dragan Simic wrote:
>> On 2024-06-09 16:29, phillip.wood123@gmail.com wrote:
>> 
>>> Having read the message you referenced I'm struggling to understand
>>> the use-case for stripping escape codes - what do you want to do with
>>> the hunk that means you want to remove the color?
>> 
>> Let me recap, please.
>> [...]
>> I hope this makes the whole thing more clear.
> 
> It is very clear _how_ you think it should work and I agree that makes
> sense in the context of a generic shell pipeline. What's not clear to
> me is _why_ that is useful in the context of displaying hunks in "git
> add -p". The purpose of "git add -p" is to allow the user to
> interactively stage individual hunks. The "|" command allows the user
> to display the hunk in a way that helps them decide whether to stage
> that particular hunk. Are you able to give a specific example of a
> command that would help you decide whether to stage a particular hunk
> where you would not want to keep the escape codes?

Well, it isn't about not _wanting_ to keep the coloring escape
sequences, but about the _need_ to play it safe, so to speak.
In other words, we can't know that a random "xyz", as in "|xyz",
can actually handle the coloring escape sequences, so we need
to be on the safe side and protect the users from being hit by
garbled outputs.

That's why it would be the best to have "P", "|xyz" and ">xyz"
as the different "git add -p" options (piped to the configured
pager with preserved escape sequences, piped to "xyz" with
stripped escape sequences, and piped to "xyz" with preserved
escape sequences, respectively), as I proposed earlier.
