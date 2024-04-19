Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B6387
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487530; cv=none; b=tuwu5ZE8pDN/nvPdlJtY3KION4gHosS70RkcbNQPwES/RUu4pWRlEcc33ZjelotRba4Ps0SkjGFNgSVCkkzw5yM31uX9jjaWGspChYo1dJ2+eTLYnFIrXkJBxSfGzkN8Z8zIkZkzfrQg+yXprm9Td3P1Kf21f5qYjyZU/1oqBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487530; c=relaxed/simple;
	bh=qfB31l1U7r3asi8fFwX0fkY9vskS5G7PCVmmyCzEcK0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JGa9K6QBIhIsR+Lnoiw+p64swGaMlFVM6l6KrJ5AcFnsduSQyFq3AuKMpTCghqLNFEjj3k1RNDTGPx1k5wnUgTuPrEz/LzDnaQRsrLWIwN/KKyBNGEeXyqkEUc3Ud325vKG8kq31kpM4TH914pNOTqal7YC4zzGIAF3ZRxr+nCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ylw6JBFA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ylw6JBFA"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713487525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fAOmk5S8aZ9UNT+L1MjKRD3C8PD5yWfM+LtYL9Sa+Y=;
	b=Ylw6JBFAy+rKr4B3mA2putiydE747ohtnv2AdtefI6LGcZD+AeS5jQZsGJCBFTHheOUSTM
	6z/ZpP0c2DvsG8mHVwBOvX8tC0zLyFh7Hdytt/bMMSRgvZLz37d+lK2REyf3nqz/z1Z0q5
	DEPj1gg1+8wFxojNfv/5gDyB46P3Yk69SWNtPBHRNp6rT/DbbO53G5ejY/z0H5DhY764Nu
	s6xR72gWma7EzMavDfWGz0HYSLxJmGjtykgG4JF0Gkd2v5vh4WYQmoFkIJINpWjMToS3cC
	J6FTjClXm6MSkxVUrAZoGUcgzV+hLoydFLqcURAYY+NXqRTvINsaQ0+3P0/NkA==
Date: Fri, 19 Apr 2024 02:45:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood
 <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <xmqq7cgwau1v.fsf@gitster.g> <c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
 <xmqqle5b66sr.fsf@gitster.g> <19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
 <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org> <xmqq5xwepafi.fsf@gitster.g>
 <CAPig+cT9A9N=zGZDXuB+c17L8hZ-h5zvZgD5W-8VYqiM9QaBew@mail.gmail.com>
Message-ID: <a24045ae382f91fed6a499d93690e31f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-04-19 02:15, Eric Sunshine wrote:
> On Thu, Apr 18, 2024 at 6:34 PM Junio C Hamano <gitster@pobox.com> 
> wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> > How about introducing "--label=<string>" as the new option,...
>> 
>> I still think --rfc=WIP is a lot more natural and easier to
>> understand, and it is just the matter of how you introduce it.
>> I'll show you how in a separate patch later.
>> 
>> The problem I see with an overly generic word like "label" is that
>> it would mislead readers to say "--label=important" and expect it to
>> appear on an extra e-mail header, not as a part of "Subject:".
>> 
>> But we can do this to get the ball rolling, without bikeshedding
>> what option name to use.  Until we find a good name, users can
>> use --rfc=WIP and when we do find a good name, it can be added
>> as a synonym, possibly deprecating --rfc, and if we never agree
>> on a good name, that is fine as well.
> 
> I remain skeptical that adding such an option is necessary, even
> though I made a similar suggestion earlier in this discussion as an
> alternative to `--resend`. I'm especially skeptical since the existing
> `--subject-prefix` covers this use-case already (i.e.
> `--subject-prefix="RESEND PATCH"`). It's dead simple to use and
> doesn't require any magical incantations with corresponding complex
> implementation such as the proposed `--label=RESEND$` which renders as
> "[PATCH RESEND]" instead of "[RESEND PATCH]"; `--subject-prefix`
> already handles this without any need for magic.
> 
> I do understand and am sympathetic to the desire to reduce the typing
> load (hence, the original `--resend` proposal), but I have difficulty
> believing that `git format-patch` is so commonly used throughout the
> day that the time saved by typing `--resend` over
> `--subject-prefix="RESEND PATCH"` warrants the extra implementation,
> documentation, and testing baggage. Likewise, I don't see the value in
> `--label=WIP` (or `--rfc=WIP` or whatever) over the existing more
> general `--subject-prefix`.

An additional reason, IMHO, for having "--rfc", "--rfc=<string>"
or "--resend" is to reuse what's already configured through the
"format.subjectPrefix" configuration option.  In the sense of not
redefining what's already configured in ~/.gitconfig (in this case,
"PATCH" or "PATCH lib", for example), by specifying an additional
command-line option.

If some user configures different values for "format.subjectPrefix"
in different local repositories, such as when working on different
subsystems, it becomes rather easy to get lost in all those prefixes,
if the user needs to remember and type them entirely while using
"--subject-prefix=<string>" to add more "labels" to a prefix.

I hope it makes sense the way I wrote it above.

> If reducing the typing load is the primary concern, then a very simple
> middle-ground would be to give `--subject-prefix` a short alias (i.e.
> `-S`). It's true that `-S "RESEND PATCH"` doesn't reduce the typing
> load as much as `--resend` does over `--subject-prefix="RESEND
> PATCH"`, but it seems a reasonable alternative which doesn't
> significantly increase implementation, documentation, and testing
> costs.

I'd support the addition of a short alias for the already existing
"--subject-prefix" option.
