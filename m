Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238852;
	b=C81rTqDy8Tatzvo1h2RXRED77kXJe/+7UUMpL7kri/5YSzQaxvg5q4HkFXoK7iSHiPEH
	 yBOi/ycZfMB1Ytnz/btdvRR4Lwt/bnubHXpRNMAm+S2nKxHMqH1Y3yOiL17SDhDDNLxo2
	 D0OG7GIOx8QJc/N+3LK/72vno/sEUQpViImdxXuYe3ndNx84uPGFEpmTdI1sQwXoFcaZd
	 Hi8jOg4MeQfUq+yBb1PQ4vFOGacxt/DLR5Vu5OEcHAYNdJ5qTuoONX8RnIWPCGGbE6YS3
	 puU5to+ky4GnOcsA8cuJKD5wWTReYj8bOCZJy9GzdQJjAf85s1vJVDVwgsgc0PhnsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238852;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=KFN5Prn5eX1AkVPD8Z0Oty6/ADThDl9RGxKX0bk1mWc=;
	b=b93L6qT1iXgunfOngzoxyq3ZIkHuK0BM8554OF2WAshQwOzK75nJvJHMxrcD48xare+f
	 tGQYvzYkWLbyXkYwwUKtMNQWEt2nn3k5YIuA/wxDu9DFCsNLwJhevR0D7hct9snCmcQGY
	 3eQRklgtCk+2ZUjUGpen/cKt343qpmqE0OrLXnNDSjKfjC+bkd4Djuc091fKAcwiccrIK
	 Zz16f6WJBY9Zsn3NXfU2eoV/inA31HC2OYlJHK6fKoaz+8X/v+M3VPoOUSGHih1DV2NbK
	 z0aJxmT7ST28GI2mZIS0V2U5irkHE47b0r0DKL5i3LBoWvTCJnsQcDPwmA4QWzoQ/6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iotcl.com;
	spf=fail smtp.mailfrom=iotcl.com;
	dkim=pass header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=Yuy97kYO;
	arc=none smtp.remote-ip=95.215.58.27
Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9A606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iotcl.com header.i=@iotcl.com header.a=rsa-sha256 header.s=key1 header.b=Yuy97kYO
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lmWsJdnENItIeSSl9KiUsXs8wgPYOOwp2y5qPzNMteA=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794238848; v=1; x=1794843648;
 b=Yuy97kYOrCSw15a+r7ImzM1tEGGg98QfieW5tbwXXku8l9kl64INpcdbJ5gcZwZKcFp8hTbt
 CZQZp3wiEeBjSUQeyVAn7th4riL/qh4b48ua2KK3VM5PM0rPs624QvMOL30qOtJGRpqfhhrGxYN
 SWaE36KiwRFDVnemTJMJ/OCc=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 4178bb5b91399b13;
	Mon, 09 Nov 2026 15:40:34 +0000
X-Mizu-Trace-ID: 4178bb5b91399b13
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Mirko Faina <mroik@delayed.space>, Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH] bash-completions: add --[no-]graph-indent
In-Reply-To: <aujlNwM6X3BLz22V@exploit>
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
 <DMHD8RCO7V74.2BK7C9T4HNLHO@gmail.com> <aujlNwM6X3BLz22V@exploit>
Date: Mon, 09 Nov 2026 16:40:27 +0100
Message-ID: <87zevixbbo.fsf@dev.null.iotcl.com.invalid>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Thu, Oct 29, 2026 at 01:45:15PM +0000, Pablo Sabater wrote:
>> I didn't know about this so I completely forgot to add it, however from
>> what I read, this is the __git_log_common_options and I'm not sure if
>> this is a "common" opt, as I don't even see --graph here.
>> 
>> I searched where --graph is, and it's here:
>> 
>> l 2383-2409 'git-completion.bash'
>> 
>> 	__gitcomp "
>> [more opts]
>> 		--graph
>> [more opts]
>> 		$merge
>> 		$__git_diff_common_options
>> 		"
>> 	return
>> 	;;
>> 
>> I think it would fit better here (not sure, I just quickly skimmed the
>> file).
>
> Yes, you're right. I was on automatic mode when choosing where to place
> it and defaulted to the place where I put an option of mine that worked
> for log. Since this is specific to "git log" I'll place it where you
> suggested.
>
>> Also, I missed this for the --graph-lane-limit option so maybe it should
>> be added too?
>
> Not familiar with the option but will look into it, might as well add
> it.
>
>> My main doubt is, both these options proposed (yours and
>> --graph-lane-limit) are --graph dependent, which means if someone
>> autocompletes them but doesn't use --graph, they will get an error
>> saying that --graph is needed. I'd say we do what other --graph
>> dependent options do, but AFAIK these two are the only ones.
>> 
>> From Toon's Git Merge talk, more options for --graph option will be
>> developed so we should maybe think about how to do it in a way that 
>> doesn't autocomplete if it's going to error? (maybe that does exist,
>> given the multiple options that depend on other options)
>
> From what I can tell the only reason we options through bash-completions
> is because these options are not handled by the parse-options.h
> machinery. Ideally we'd want to port these options to that? I'm assuming
> the reason it wasn't was because of the common options.
>
> With the parse-options.h machinery you can't tell which option depends
> on which other, so it just shows every option available for a command
> when autocompleting. I'm not sure it's worth it to implement such a
> feature with bash-completions when the parse-options.h machinery
> doesn't.

Yes, I agree. It would be cool if parse-options.h would be smarter in
this regard, but for now that's not the case, and I'm fine with that.
I'm pretty sure (although I cannot think of any right now) there are
other options (for other commands) that only work if combined.

I appreciate thinking about this, but that's something for the future.

> Thank you for the review, will reroll.
> Mirko Faina

-- 
Laters,
Toon
