Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480251C42
	for <git@vger.kernel.org>; Thu, 23 May 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505445; cv=none; b=igW8V55RL0d38pPASgPDu9PTrxjTg4K0nntsq5VZtAOx7veCSwl7EQBKCV9Dm0QH0VaKV6Bc1c1DpAThKGWx6ieI/eVX+uBPFn6gml1mDCaCBUtLWhI9QLuDRdIDzSbk5mSR9fc8WRmM50hUvWt5XQSI5eY1aSdO5WDFvQCte/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505445; c=relaxed/simple;
	bh=gvIZCLQq0bPevXY5AMh9vkQHNw107rA6BIcZ59WhSy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSelXbAGW9j2wK4h7VAjIzt2R1yb12pQg2inbsfAyEfZ0gUgTM0zTKa6a++MUFC+M7h5rbyb13EeGXURn6YA9/tdTU/JtHl+2wDaQH7+MDsJwSB3prnEOGu21NxL7Jg1GM67c+qeqoPmXVPOW4ilrFFl439O3LILJ/zHLb2G6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X9EgoMzU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X9EgoMzU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2F1B234C1;
	Thu, 23 May 2024 19:03:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gvIZCLQq0bPevXY5AMh9vkQHNw107rA6BIcZ59
	WhSy4=; b=X9EgoMzUDpHwMdi4Cmebveny8LXaK3iO4rxVE0bLaS1UtpJi4PvFh0
	hwFMORDelPgg5C8J/DlOhg18lmjdKTnjgpMRReoMsGf5GYUqlrbb/mGgyuZBWlz4
	d8Zso38j5iMpSVG/NuBMzQxjEengccu/LORVE/WqvRivDrC9y2XPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A8C9234C0;
	Thu, 23 May 2024 19:03:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2F14234BF;
	Thu, 23 May 2024 19:03:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Telka <marcel@telka.sk>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
In-Reply-To: <Zk_FiYd8uk-P5jIi@telcontar> (Marcel Telka's message of "Fri, 24
	May 2024 00:39:05 +0200")
References: <Zkdk7R9GIfsyQjkc@telcontar> <xmqqsey8tnny.fsf@gitster.g>
	<Zk-nswiCF-SnyxLE@telcontar>
	<CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>
	<Zk-5YCKSO32vPKDP@telcontar> <Zk_FiYd8uk-P5jIi@telcontar>
Date: Thu, 23 May 2024 16:03:54 -0700
Message-ID: <xmqqcypcqgf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAFEBCA4-1958-11EF-83F7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Marcel Telka <marcel@telka.sk> writes:

> Okay, I found the cause.  Bash on OpenIndiana is compiled with
> --enable-xpg-echo-default so escape sequencies are expanded by default.
>
>> OTOH, it seems that the fix is maybe not needed because it is solving a
>> non-problem.
>
> There is a problem, but definitely the justification in the commit
> message is not accurate because we do not care about POSIX here at all.
> Also maybe it would be better/simpler to use `echo -E` instead of
> `printf`, but I'm not sure here.

How "portable" is "echo -E"?  It apparently is not listd in [*], but
it should probably not matter as we are doing this in bash.

printf is a kosher way whose behaviour is pretty well standardized
especially with respect to "%s".  As I said that I was going to
merge it down to 'master' already, it is now part of 'master'.
Use of printf there may hopefully educate folks to think twice
before using 'echo' on unknown data.

By the way, it makes me feel funny that we are talking about "POSIX
portability" when reviewing a change like this:

         print_comp ()
         {
                local IFS=$'\n'
        -	echo "${COMPREPLY[*]}" > out
        +	printf '%s\n' "${COMPREPLY[*]}" > out
         }

With "${ARRAY[*]}", POSIX portability is totally out of the water
anyway, regardless of the echo/printf issue ;-).


[Reference]

* https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
