Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AB2BAE7
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660776; cv=none; b=AjruYfx7VUkI71mmmVhMSumypIpmOWjROlDrVHMbqx4suPpoYAQEJ4lZKDN02OJPk8ZlzxDxT3V26sU5CzJ9yegk1rKjPmHjwo/3EPhQlRLEdpIWhmitdLDg58nb982M6Rujq2cWlrUl8D8NWEFHVlblS3qhWIyqA5Jir3/uq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660776; c=relaxed/simple;
	bh=ea37D0qmwoxxG9oxfK94VhlZJODKicLBlaLKYL0WDyw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=I0AooWxE3U2QdUROqG/sw92Ju4i5D3eGDZ+4Toejyhm/iWNy0e0MV2cb4H4mDhYfcLpxyNCD8duhQZMP0aI2ZxXP0Kh37MRC2OptdHySIULc7KT71hiyKERKbvgy3jE6pBMKj1hHKfPJ+sWZGM2NYlFEb20TtP00NIqa3rIIczw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xGjM4wVx; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xGjM4wVx"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711660766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YC7Zk247u6w+GiiS8eaygJ2kAnHp6tShcopMIEdg2nU=;
	b=xGjM4wVx6Uy2NWBmphXiL/rX1ShY1WUATyRtjSUnbG/ux3AlW4klQ/jiZs3mqINBsWH3WA
	zhegGKJ0hYcKjIs03+FzzLnJvu2BlBDPgdyUHfIahWw92PipfDfw8yKahaEo8rxFfhwcV1
	RqSMaljNMr+FUwpkEeTR9iV6e8qxL4A9nNbx+MJ7ZCGKZOD+3ekaQ7nl30cbY+01wnrQAb
	FNQ2//EqjyfLf89gb4tQyQdDcoer2Gc+/FQiO70B7/6T+8GqvX1eef2y8Lx08ulqfZMUIc
	vJSsyKdxj68x2gWAIh2DmlSKUFrZNiehynjtoqu0eOGZEl08ANyoI9ofLRG71g==
Date: Thu, 28 Mar 2024 22:19:24 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eugenio Bargiacchi <svalorzen@gmail.com>, git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <xmqqr0fut7di.fsf@gitster.g>
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
 <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
 <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
 <CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
 <de182310842ea3ff04c171a271587ca1@manjaro.org> <xmqqr0fut7di.fsf@gitster.g>
Message-ID: <fc4ede3ecffd33811adca702493c8763@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-28 21:43, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Of course, users could pick the right escape sequences for their
>> terminals, but as you already noted, the same configurations could
>> end up being used on different terminals.  For example, even SSHing
>> into a machine using a different SSH client could lead to a mess.
> 
> There is a separate discussion of conditional configuration based on
> environment variable settings, e.g.
> 
>     [includeIf "env:TERM:vt100"]
> 	path = ~/.git-config-bits/vt100
> 
> where the named file might have
> 
>     [prompt] prefix = "\033[H\033[J"
> 
> so it is certainly doable.
> 
> It is a different story if doing so is sensible, of course.

Quite frankly, I think that would be like opening a can of worms.
In other words, if we end up implementing support for the "add -P"
prefix, allowing the users to do whatever they want with the prefixes
would surely be fine, but only if we implement "add -P" at the same
time, to already provide a reliable and simple way for clearing the
screen.
