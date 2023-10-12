Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFB9CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 05:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjJLFqt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377353AbjJLFq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 01:46:28 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E26195
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 22:46:12 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697089570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ci5dchkYGJ10XYSAuOy7gCwkFkd7XI4Tm0oBe7c5vsk=;
        b=YV+kPYVvZWDwimz3xZCkpD1Q0scHgvrg6c3PjKMlFlME3gvUscvFdSWqTdQurxdyilDI38
        UZtJ4R0wTy+dPd0679Al+9XFndUbEDloWjJBFERe12HkVER3y0hOahSOCtrQrYhQBFaurN
        XIiInPy6Uk8azTWyn4/weEpBRe1KQPjfUiVzRPm7G5gu63LeqqE2vMaDyM0YbYiN9KHf51
        EVcQmGwAv3UoaCfjjtxdYYspoXIsNKtsSOC8iF46QYrvfsvJZnB8BzPFF7NG5EMMqqgj8e
        T5qNQzwLwiHf/j8qwCw1gn19csr+bP0EgKWPi7Lea3+dyRIThpWQt6sUjIJdjg==
Date:   Thu, 12 Oct 2023 07:46:10 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
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
Message-ID: <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 03:39, Christoph Anton Mitterer wrote:
> On Thu, 2023-10-12 at 02:31 +0200, Dragan Simic wrote:
>> 
>> Makes sense, but please see also my other reply on the list.  To sum
>> it
>> up, we can have either the current behavior, the inconsistent
>> behavior,
>> or an even more annoying behavior.  I believe that the current
>> behavior
>> is the best choice among these three options.
> 
> Well as I've said... I don't demand that it's changed, but I simply
> think it's a wrong assumption that it's in any way better or worse.
> 
> Leaving back partial output, or when scrolling up&down completely
> messed up output, is surely not per se more annoying or a bigger
> problem than leaving back no output at all in one case (when it doesn't
> fit on one screen) or leaving back output (when it fits).

Let me repeat that the messed up output you're experiencing isn't normal 
and has nothing to do with the arguments passed to less(1).  That's a 
separate issue of the terminal emulator(s) you're using, or in issue of 
your specific environment, and should be debugged and addressed as a 
separate issue.

To me, having inconsistent displaying of the short and long outputs is 
simply not acceptable.

>> Yes, I'm sure, because I'd be fixing that already if that were the
>> case
>> in my environment. :)  I use Xfce and its default terminal emulator,
>> though, and I don't know what it's like in other desktop environments
>> and their terminal emulators.
> 
> I just tried it with xfce4-terminal 1.1.0 (which AFAICS is the most
> recent version) in Debian, and unless they break anything with custom
> patches, or you distro fixes anything with custom patches... I'd say
> you must suffer from the same issue and probably just try something
> different.

Let me repeat that I don't see those issues, and actually, IIRC, have 
never seen them in my 25+ years of using various Linux distributions.  
If I've ever seen that, it would've already motivated me to have it 
debugged and fixed.

Perhaps something is wrong with your specific environment, because I see 
no other reason for this issue.

> Since Debian's less is pretty outdated, I've even compiled a quite
> recent less 643 (there's not even a tarball yet for 644, only a git
> tag).
> 
> A made a screen recording... it's not 8K ;-) but I guess you can see
> what I do:
> https://youtu.be/KMs3sLk9nXY

For some reason, I can see it with 360p as the highest available 
resolution, so I really can't read what's displayed on the recorded 
screen.  Strange.  Could you, please, upload the video in higher 
resolution, perhaps to a file sharing service such as 
https://easyupload.io/ ?
