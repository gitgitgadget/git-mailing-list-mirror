Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044882B5C0
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 22:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="o6pDYTGk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DE9D
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 15:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697150193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yd9etangezK5xKchOA/sLruYhzrtPa6KLPwHPuBWLYM=;
	b=o6pDYTGkru82i1ywW3nXLOmz6Q4Zdr6P3MZnx3PsChBm9YPq4ofq5CMHQ6rMUm1PFSLNkm
	1Z1OQKHgAmIqKdMwYBR1URglVqv10yugJ+pr/KrKpoB8tIv17wFYLk/TLjxxCTz0h7xo73
	Zfxz83PYPra1F+bGVfx9b8EEUofjX+Bikv50d60eKaaHGHaiktZmNfC86qfBK1sr/xr4Kv
	Kg//3hMswuO786sYm9HSM3NuXKmirDvGg9mtyy2iSiFqcIzQacDzaCTDi3WTbETvMveIkk
	dBLGLmqtTvKtlngD+cR5ufGkx1fUFUG7oKWL8uQB5Xj/l0Lv/McUFd9JI6o/Rw==
Date: Fri, 13 Oct 2023 00:36:33 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <c6cd3133573d5ade6d02b5da1051853a4b3885e1.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
 <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
 <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
 <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
 <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
 <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
 <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
 <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
 <e1e187ca3d970c18e1a11d51ff93b6cb212bcbaa.camel@scientia.org>
 <31b6f4a2b88cc3a2cfa908f82f4f2302@manjaro.org>
 <c6cd3133573d5ade6d02b5da1051853a4b3885e1.camel@scientia.org>
Message-ID: <60f1922b12a6ef304ffa36c334348e34@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-12 23:48, Christoph Anton Mitterer wrote:
> On Thu, 2023-10-12 at 23:15 +0200, Dragan Simic wrote:
>> 
>> Ah, I can finally see what are you talking about...  Thank you very 
>> much
>> for all the testing you've performed and for supplying this screen
>> recording!  I can confirm that my environment is also affected, but 
>> for
>> some reason I haven't observed it this way before.
> 
> Well... perhaps because it's not really "easy" to spot unless one
> carefully reads through the lines (which I guess, one does not that
> often in the terminal "history").
> 
> Have a look at my ticket at less, especially:
> https://github.com/gwsw/less/issues/445#issuecomment-1758887183

Great, thanks, it's full of very useful information.

> Where it was confirmed that the issue I describe might happen (and I
> guess is non-fixable?
> 
> The whole issue also contains an explanation on why scrolling doesn't
> work when -X is used (but --mouse is not) on VTE terminals (and maybe
> others, though not xterm).
> And it's basically not "fixable" but simply "by design".

It seems that "--redraw-on-quit" is a possible candidate for replacing 
"-X" in the set of default options for less(1), and also in other CLI 
utilities, but I still need to test it in detail.

>> Huh, that's really worrisome and I'm willing to help you with
>> debugging
>> and fixing this issue.  Please, let me perform some debugging and
>> digging around, and I'll come back to you with some further insights,
> 
> Well, my assumption (though I'm really not a terminal expert) would be
> that it's not fixable... because less would somehow make sure that
> everything it prints (in the alt screen buffer) is properly
> concatenated in the the regular one.

I did some work on terminal emulators, but I'm also not very much of an 
expert when it comes to terminal emulators.

> less upstream made some suggestions:
> https://github.com/gwsw/less/issues/445#issuecomment-1759986293
> 
> One would be to change the terminfo entry, which I guess is not really
> feasible as a general solution.
> 
> The other would be less’ --redraw-on-quit option.

I agree that the latter seems like a viable solution, but as I already 
wrote above, I need to test it first, together with doing some digging 
through the less(1) source code.

> Maybe that would be an even better solution for git?
> AFAICS, we could have -F, the VTE mouse scrolling out of the box, plus
> (via that option) the final screen buffer of less printed when exiting.

Exactly, but still needs testing and a detailed insight.

> Would give some context (what one did in the pager, where one was) on
> the regular screen buffer, but (presumably) avoid that mess up... and
> perhaps even prevent unneeded pages of output from the pager, if one
> scrolled down a lot, which maybe aren't even needed?

Yes, it seems to tick all the boxes.

> (Also note, that less` upstream calls `-X` "a risky flag" ;-) )

In general, "-X" seems to be more of a bandaid option.

>> Those people, just as anyone else, can use $PAGER or $GIT_PAGER to
>> configure the pagination the way they like it.  In the end, that's
>> also
>> what I do in my environment.
> 
> Sure... all I said, that (IMO) in the case of `-X` it's not like with
> `-R` but rater like with `-S`... i.e. neither mode has more right to be
> the default than the other.
