Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87F1757E
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419456; cv=none; b=avmwQvKrfs2VHyNaLUktOzsw0MgilFk6yZuJxvrxLKUrPNU6gMNSeHo7q60ClprdA/SwJ3aeocKJRHLTgHi5MLp+oS3abxfSk/fJAyF/UwF96jl9c9uh8wWiJDPtsgySX/J+U5COGFeOUW2c0gtlAQ2ORngMOboXQjaNncHkCdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419456; c=relaxed/simple;
	bh=n5kD0JYZrbRSZdt1MOWIIXCu8BMJZz/wjhm6UbSsoT8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PWdoUivaRJ+2aBSVnpiekkxz+MvVvrIFb342Fn2LcLzvJcY6g1qQP5ru6auADRfKNKbWekHggkET9c7ge+OdtQ+Q1YrKEpadCxxGnx72Joo9mNUDq3eRQhFlP2jqKhno+AKheiS2pUNyCKluN0va4vE59JW6GBDoO84eJkF3KmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WJoqUEVV; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WJoqUEVV"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723419451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IyBld7qsiTe4zYyL6eUl2c8vtQvy1tndps5h21HZf0=;
	b=WJoqUEVVhBIcnX4ZKTplRowttRxdbZLvcbdb5pcFKSdQqZ8RYdspAmJcH6XJZbBLK7lRhu
	THSRCL3QCfQEa68CyS6IuUUL7hfEIAuh/zu2/7+DKhEEArflKbESpyFpCtPy0vPf/WQpvH
	A6589+7clwQoGJn0WVaaVLlZFKiU7/yf1ozQkGaof8OMM9zmYQUHrJ+C9rncqhY4AlEYBJ
	pXGnNeKIFieqTFGANq0HLt9V1iJqjJIIdzf1vZZ3M/CFZCj/4Yi8+KM1YvQsG4RVu0koCy
	cUuKV6YdSFOzwF2Q6tI8NcL2Lj/8BXR1QcQiPy5YWpMlbLR3vexeOTBOftqvNQ==
Date: Mon, 12 Aug 2024 01:37:30 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Josh Steadmon
 <steadmon@google.com>, git@vger.kernel.org, calvinwan@google.com,
 spectral@google.com, emilyshaffer@google.com, emrass@google.com,
 rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org,
 sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
In-Reply-To: <CAPig+cQnLkXdfokGBFdkkrZ3_nWrYGj3XyMRJ+0h5zrC5Kw0bw@mail.gmail.com>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com> <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <ee460e193b567b73e789ee77579f41c4@manjaro.org>
 <CAPig+cQnLkXdfokGBFdkkrZ3_nWrYGj3XyMRJ+0h5zrC5Kw0bw@mail.gmail.com>
Message-ID: <6b5b57147ce38099a57ecc4f256ef2b5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-12 01:33, Eric Sunshine wrote:
> On Sun, Aug 11, 2024 at 7:23 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-08-12 01:03, Eric Sunshine wrote:
>> > Josh addressed this point in the v2 cover letter by saying:
>> >
>> >     Known NEEDSWORK:
>> >     ...
>> >     * Bikeshed on the name
>> 
>> But didn't Junio already say that the v2 of this series will be merged
>> as-is? [1]  That's what actually made me surprised and confused.
>> 
>> [1] https://lore.kernel.org/git/xmqqfrrd9slb.fsf@gitster.g/
> 
> That only means that Junio placed the topic in his "seen" branch,
> however, no promises about ultimate acceptance are attached to topics
> in that branch. Quoting from Junio's "What's Cooking" emails (such as
> [*]):
> 
>     Commits prefixed with '-' are only in 'seen', and aren't
>     considered "accepted" at all and may be annotated with an URL to a
>     message that raises issues but they are no means exhaustive.  A
>     topic without enough support may be discarded after a long period
>     of no activity (of course they can be resubmit when new interests
>     arise).
> 
> [*]: https://lore.kernel.org/git/xmqqo762frkz.fsf@gitster.g/

Ah, good, thanks for the clarification.  It's all fine then, as far as
I'm concerned.
