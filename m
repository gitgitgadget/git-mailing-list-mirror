Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046D8CDB465
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 00:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376656AbjJLAbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 20:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376605AbjJLAbn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 20:31:43 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5272E9D
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 17:31:41 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697070699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=owAoQhOp164183mGtP1GUZAOFfTpbV6gVHh9t1Gp1SU=;
        b=JkfWqd0ykATTJQrFhRnXgtcDR3ZmWqaEo1I1puK9+dtBdEaGtVF2bp+7SiQRoGvAt5+ybF
        /WxR7XfpkjbwFhsH7v7pS7wsPDC6AyqH9Dj1kt7onAPUNGH4s4BTS88dpPBb8gq9oOwsM1
        gHd3mc0jMKJYX3agjelZsmR0P2nj+WCcn9C2+vNlszHzwNNJ3tVg/z1OFSd/0dl/Rnlwe4
        x8M0n1o60L6nv1WOHaVNweRZFcfOwo/kbb2UcWLZeHRg+8mktpNwtSkS0FFTW0skWZoICD
        jnTKO4ZJ8HFv/gAFen2e+Y0WzdVRadVBN6XkaIClx+K2oTekA4tGXYnKLzQ2XA==
Date:   Thu, 12 Oct 2023 02:31:39 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
 <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
 <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
 <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
 <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
Message-ID: <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 02:22, Christoph Anton Mitterer wrote:
> On Thu, 2023-10-12 at 02:06 +0200, Dragan Simic wrote:
>> There's also scrollback in the terminal, which can be used to show
>> more
>> of the contents that was displayed before exiting the pager.
> 
> Sure.
> 
>> > Everything that would have come after that is of course not
>> > visible.
>> > The place where I exited may be some "well defined" border, like
>> > the
>> > end of a commit... or anywhere it the middle of a patch (making the
>> > left over remains on the terminal perhaps even ambiguous).
>> 
>> If you didn't select some line or page to be displayed, by scrolling
>> within the pager, it obviously isn't going to be displayed, which is
>> the
>> whole point of using a pager instead of "spitting" the whole contents
>> out at once.
> 
> It's also clear that it's one point of a pager :-)
> 
> But that doesn't change that it's rather a user decision, whether or
> not it makes sense to leave that, what's already been shown by the
> pager, on the terminal after exiting the pager or not.
> 
> I don't think people always select the lines in the pager to some
> reasonable border (e.g. end of a commit, end of a hunk, whatever).
> So it's likely that after leaving the pager, the terminal's scrollback
> buffer will contain something that is not complete and may thus be
> ambiguous.

Makes sense, but please see also my other reply on the list.  To sum it 
up, we can have either the current behavior, the inconsistent behavior, 
or an even more annoying behavior.  I believe that the current behavior 
is the best choice among these three options.

>> That sounds like some issue with your terminal or terminal emulator,
>> which should be debugged and fixed separately.  Such misbehavior
>> isn't
>> supposed to happen at all.
> 
> Are you sure about that?
> 
> Well it happens at least in gnome-terminal, xterm and (KDE) konsole.

Yes, I'm sure, because I'd be fixing that already if that were the case 
in my environment. :)  I use Xfce and its default terminal emulator, 
though, and I don't know what it's like in other desktop environments 
and their terminal emulators.

>> I see.  Actually, removing "-S" was a good decision, IMHO, because
>> chopping long lines isn't something that a sane set of defaults
>> should
>> do.  Many users would probably be confused with the need to use the
>> right arrow to see long lines in their entirety.
> 
> Sure.
> 
> And having -F is IMO a good default (that virtually everyone would
> want), too.
> 
> With respect to -X, I'm less sure whether it's that clear.

Please see my other response, which explains why having "-FX" is 
actually a good thing.
