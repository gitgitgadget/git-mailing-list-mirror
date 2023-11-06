Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5721138E
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SlWytiY8"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5629AB8
	for <git@vger.kernel.org>; Sun,  5 Nov 2023 19:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1699242475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVRapG3Mz5l5U+2zhJ5XNLyhI6rYXot1AlP5gPlzbq8=;
	b=SlWytiY8k9HqwEOinoj5lXDoyWCAXkMUFJ8vRsacI3tiRQmgFu3XywguStnHwLYt+iTpll
	vuvVsFaY0pa5nDbGM2Yb+NEG0P6YEmWu7paWATYfAngKTsJq+Hd19G24vgBUqejUWTBUC4
	cR2ubE9Eb9aFmkMBDpyLgke2M+nxIBUDkOd2Edc7ZWC54DpxgiMrmyP8X3j901z++i9wOH
	llSXR6IrMhIs1r4UFqZa9pRh1j0rPjTGsA8mK6OHqFjyJ9weDJcRLiIxCAXTQsMRSMphIU
	/5tweSFCRaw6DQBuKG3ndhxrQDTy4ZxE7IYPN41L5Qh7njdUV4dreSpG1WZ32g==
Date: Mon, 06 Nov 2023 04:47:54 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Thomas Guyot <tguyot@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Christoph
 Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <20231012000416.GA520855@coredump.intra.peff.net>
 <xmqqh6mwipqi.fsf@gitster.g> <3946c06e90604a92ad0dddf787729668@manjaro.org>
 <xmqqr0lzhkzk.fsf@gitster.g> <a831af51b6fb46b5d6fcd9768a7fb52d@manjaro.org>
 <cfbe174f-23ac-4a35-8db4-66bdfdfdc14e@gmail.com>
 <8022dae27797bf1e1770f099ed37f5d3@manjaro.org>
 <d54eedf0-7825-44f5-908c-a51541345872@gmail.com>
 <79cf1bf35ba6c9348735685b01e0f2f9@manjaro.org>
Message-ID: <5752129cbefe064a10e57e1b628e516c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-11-02 15:19, Dragan Simic wrote:
> On 2023-11-02 14:19, Thomas Guyot wrote:
>> On 2023-11-02 02:48, Dragan Simic wrote:
>>> We've basically reached some kind of an agreement about the need for 
>>> a
>>> good solution, which turned out to be rather complex as a result of
>>> being quite universal and extensible, which was required for it to,
>>> hopefully, be accepted into less(1).  Also, the author of less(1) 
>>> seems
>>> to be quite busy with some other things, and he prefers to implement 
>>> new
>>> features himself.
>>> 
>>> We've also agreed on another new feature for less(1), hopefully, 
>>> which
>>> isn't exactly related, but should be quite useful.  It's about the
>>> secure mode for less(1).
>> 
>> Feel free to cc me on your next correspondence. If there are mailing
>> lists archives for the thread I'll fetch them as needed. We have at
>> least one working term/switch combination, which IMO is a better start
>> than nothing :)
> 
> Please test the "--redraw-on-quit" option, AFAICT that's all we need
> (plus the already mentioned other improvements to less(1), to avoid
> the version-dependent workarounds), and the distributions will
> eventually catch up with the newer versions of less(1).  If the whole
> thing has worked for decades as-is, it can continue working that way
> for a year or two until the packages get updated.
> 
> There's actually no two-way mailing list for less(1), the entire
> project is pretty much a one-man show, so to speak.  There's a GitHub
> page that allows issues to be submitted, but I didn't use that, so I
> exchanged a few private email messages instead with the author.  I've
> already summed up the important parts of those messages.

Good news! :)  The author of less(1) has implemented a couple of new 
features that should resolve our issues with the pagination.  The 
improvements for the secure mode of less(1) have also been implemented.  
I'll test all that in detail, and I'll move forward with implementing 
the required changes in Git.

It seems that a new version of less(1) may also be released rather soon, 
so we might be on a good way to have these longstanding issues resolved 
in the upcoming releases of Git and less(1).  It will take time for the 
Linux distributions to catch up with their package versions, but also 
the rolling-release distributions will get the new versions with no 
delays.
