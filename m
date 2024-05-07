Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAA4F208
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057123; cv=none; b=OA/ecD9oOrJ7LbPlQKUNViGvexvpKxOYkpukl8N03xa5F1WgJBf5MwZRin1wk9BRH4v0iFEywoLC9qzUnQmGJBwme1NM1KLQ7usKHY9h+9wcPmNRBTgxAyhlc45WBhV47CcBglHIM+LHJcyv0WnfRnvQWhFcvCcYahHabiymcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057123; c=relaxed/simple;
	bh=lqNpLlkt167oj4vxAApt497t6v+uAhfDN48sK3tVTOg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QYlgRuYJ6mPD3BQ7VhCevrgeX/KwLP4WrN3a5n5EXfkvDAXaTWxwdK/G6lcl9NWobjR35E8Tz2o6ahDX0N49GUqNGVJapdJS24I2hSv8DpezS9Ls3GYBq0T5AcniFDJ8w4uhUjLbfiic6DAbDrWwsKovO1K/YOSoWSKwBIwsAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uDiJ4yLE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uDiJ4yLE"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1715057117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ocDoTvhuiqBqwLq8u7rWo2bUJa8nEVf9YOpg5s6yNo=;
	b=uDiJ4yLEprkrzrZewBri9UKAqNaMozWuIUc/ez4ewlOZ73P/oJMxZmc8wpUP2teePPTNNy
	00ZyWt3zdvkRLy/G+Nt2KZpSSCuHHTA+00K7IPCbOuLUL8Ztv6TE3Jtv0gzovSGTPtlKkx
	YsInXKoBF6GicETjjYuGiiTLNQi36HWP38odlAaY/C6LM9czhtzq0almGCeBASWlikAIFg
	XaKxaowyuHGmPdYIvHmAe37/Ez38ZEA1YRu8GvjRKick/VIT3NGXHhUh7x1mXuz6NwOyRX
	bqQXboJt4uGJoYvHf6O/I1oyxrKMyDP8bg36WJJ3KaLULFTvRI//3kgUKI/UPg==
Date: Tue, 07 May 2024 06:45:17 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Eric Sunshine
 <sunshine@sunshineco.com>, James Liu <james@jamesliu.io>,
 git@vger.kernel.org
Subject: Re: Re* Re* [PATCH v4 0/3] advice: add "all" option to disable all
 hints
In-Reply-To: <xmqqikzqwjyb.fsf@gitster.g>
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
 <ab604f4b73eab1d9aae4e2a20ba0630e@manjaro.org>
 <xmqqjzka7p2t.fsf_-_@gitster.g>
 <CAPig+cRZEQjwhnMYvQ_0BjvXaR=3x=LQeJHzFOxC+ZPyOy9yJQ@mail.gmail.com>
 <xmqqbk5m65i8.fsf@gitster.g> <xmqq4jbe64l9.fsf@gitster.g>
 <CAPig+cT-xk13jGEUmpT5QmwVYTxKNUZsu9xJ=Ph3h4AzKHg6pA@mail.gmail.com>
 <34d77e4d-6edb-99d0-7fc5-fea5224654c7@gmx.de>
 <xmqqbk5i3ncw.fsf_-_@gitster.g>
 <5665eef37193e8a6894f100a554bce4d@manjaro.org> <xmqqikzqwjyb.fsf@gitster.g>
Message-ID: <68570a52a2f316eca9444d82d36d7aaf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-07 02:21, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> See, the creation factor is described in the documentation as some 
>> fudge
>> factor, specified as a percentage.  Without going through the actual
>> source code in detail, a question that pops up in my mind is why do we
>> need to use 999 or 9999 as the new default value?  Shouldn't 99 or 100
>> be good enough instead, if it's a percentage?  I'd assume that the 
>> same
>> question might be asked by other Git users.
> 
> It is very much deliberate to choose a value beyond 100.  Setting
> the value to such a large value was designed to force somebody to
> ask that question: "what does the value mean?" [*], and in a sense
> it already has achieved one half of its objective ;-).

Ah, I see, it's also meant to provoke users' curiosity a bit. :)

> We never had an satisfactory update to the range-diff documentation
> when we discussed this parameter in the past.  It was stated that
> the unit to express the value for creation-factor was called
> "percent", but it seems that nobody had a good explanation that can
> be given to a layperson what that percent means (e.g., what is it
> relative to?  what it means to have that value at 100% as opposed to
> say 50%?).  Somebody should come up with an easy-to-understand
> explanation suitable for users after reading and digesting the
> overly technical "algorithm" section of the manual, and forcing
> ourselves to do a good job at it is the other half of its objective.

Yes, the whole percentage thing is a bit unclear.  I'm going through
the ALGORITHM section of the git-range-diff(1) man page, which could
also use some wording and formatting improvements.  I'll see to send
a patch that improves it a bit later.

> [Footnote]
> 
>  * Having more than 100 as a value that is measured in "percent" is
>    not unusual, by the way.  You can zoom into a picture at
>    magnification level of 400%, for example.

Of course.  For example, I use 120% as the default scaling in my web
browser, to compensate for the rather high value of the screen DPI.
