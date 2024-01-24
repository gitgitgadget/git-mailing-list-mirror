Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AF17591
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073261; cv=none; b=EaVorPSr8qpv12ZniY9wG7jxh2zRT83MlNMw/FWBVFJmnevkTzFwjP2XMRFSdBtRLaFQ7pbgUufAWqazUDR2BLw0lQ+1bG0ZNl9bkXHH0MPet8XIbvX0fPT9k2DVcZmsKsQA6KWXd1Ok8q8RFf1dWjGAA5XSRzCyQIgEq935bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073261; c=relaxed/simple;
	bh=3UFhJ3ZLK0bmltOsf2k36W/XlkbVF9y2T+8hpVtaxSM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ANzVVc5PpQ960uMC84GYaU/+6+JrKpTjOl/Wgd+90pWAZlxc12g/Q/A9IrzHj+sIwZW8CtiDY6VnTjas94qT/wU62zEmD7hBGnhmQVKjaIo+HsZ0/B/V61Z9lfONkXSPH+f8gy6eHUqAbvkL0PXx0a59wSZE8fO0w9/Ix/XgWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uaekdKzw; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uaekdKzw"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706073249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpxzwq4p/4rWgzDMzmIGFbB0ksLm528f7wwkf8vW46s=;
	b=uaekdKzwIDie37Lzau9EXSPk3GwY8ts/M3F+9FQWPaeEpoTiAVEBRxQv4wozopyWXTqs7R
	W5sA/rnnpQG2gFBaLZ/KuICD8w6JKvKjt0pRkao/zcCVj5S5yappP2ftjB3RjvnHdujKyR
	qFpcuMe9J8DQYNzGopOlc0/l1qSZLGWSnsUNuoyf8QP9QVk06kMJQQR0x5H5BZ6lQ3uTWL
	HNSM2tp81v+O160RKAsTTzfMkgW4SL/2fQzBBU5DXoDOQQ5R7geNs9T7/BdmcdONZp1X3h
	BRgwL+i28wn0c5hUH3grfQ0gznzBRL57etDJe6bnL7F811MblK07W3xWGUbppg==
Date: Wed, 24 Jan 2024 06:14:09 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <CABPp-BGfPXKtdHaz0u5273AwUfBnYRKfMa2VHPFohv5fOtwJtg@mail.gmail.com>
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com>
 <f5b9a57b6e2b513f1d79a93c6f0ccf45@manjaro.org>
 <CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com>
 <45bfda3a350b4040a28a25993a2b22e0@manjaro.org>
 <CABPp-BGfPXKtdHaz0u5273AwUfBnYRKfMa2VHPFohv5fOtwJtg@mail.gmail.com>
Message-ID: <0db21f3b8068e5df3fe2e84b1c6aea9b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Elijah,

On 2024-01-24 05:15, Elijah Newren wrote:
> On Wed, Jan 17, 2024 at 1:30 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-01-11 17:57, Elijah Newren wrote:
>>> On Wed, Jan 10, 2024 at 9:39 PM Dragan Simic <dsimic@manjaro.org> 
>>> wrote:
>> and refrain myself
>> from expressing my opinions in this thread.
> 
> ...but that's not what my advice was.  My advice was that you'd be
> more persuasive if you expressed your opinions differently.  Some
> possible examples:
> 
>   * Stating that you are worried about the codebase becoming more
> complicated or more fragmented (without dismissing the points Taylor
> raised)
>   * Arguing that you believe various points others raised aren't as
> much of an advantage as they perceive, or even potentially aren't even
> an advantage at all, not by mere assertion but by providing additional
> details on the topic (statistics, anecdotes, war stories,
> counter-examples, old commit messages, etc.) that back up your point
>   * Stating that you don't understand why others think that advantages
> they state are as significant as they pose and ask for clarification.
> 
> I think there's potentially some good points behind your positions,
> and I don't want to discourage them.  I want to encourage lively,
> friendly debate so that we can have the best information possible when
> decisions are made.

Oh, I once again totally agree!  I really love the way you expressed it,
which I'm once again thankful for.

I always support making improvements and major changes, introducing
new technologies, augmenting or even replacing old technologies, etc.
In the end, that's how progress is made, but such major changes also
need to be performed very carefully, in a controlled way that provides
a backup plan, and based on solid facts and past experiences.

In this specific case, please be aware that my health wasn't in great
shape, because I was (and still am) recovering from some nasty flu,
which has also effectively diminished my mental capacities.  That's
the primary reason why I provided only terse comments, without backing
them up with more specific details.  That's not the way I usually
operate, and I apologize for that.
