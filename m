From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 8 Apr 2013 13:31:43 -0500
Message-ID: <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
References: <1365320706-13539-1-git-send-email-felipe.contreras@gmail.com>
	<1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
	<20130408005155.GA24030@sigill.intra.peff.net>
	<CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
	<20130408023351.GA32558@sigill.intra.peff.net>
	<CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
	<7vtxngyl30.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGr9-0007Bo-MU
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935251Ab3DHSbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:31:46 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:33769 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934871Ab3DHSbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:31:45 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so5643740lab.20
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OvMEDDgHTIZq0LGGVhDhf7mM4ulQC83V2e0+ZUSyv2M=;
        b=WHk9DA3gXhk8ANmBT3zNWAWMsdhjWlFCewZpoB0SYqX46uSUqfGiMjIe8ACBaUKh+R
         WaJbL+t8KPK6nblTe4NfsUaGMLb0NpNnilA0kxOLX78RNYJuihObk00R4xT4+4lMfGKC
         1ww/CQI2TNHux2e6EBfX9G5F/sdlbDlt0bdvhKkaEelAZji0zHpVn1rgRa3Hn4Nl73fE
         gdXQWtFdanspChu5j2vlGm9zW+A3VhKdJ9BQTjTFq6YP3y0RESIlUSXPSFJzn5lcWFbP
         RHzc0maHe7eiMGl/E82BrCEVSaglMQC759HTMknOMTCV8AP5okIIjMtc09TXpCVVdNzV
         bnng==
X-Received: by 10.112.156.42 with SMTP id wb10mr12172744lbb.32.1365445903313;
 Mon, 08 Apr 2013 11:31:43 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 8 Apr 2013 11:31:43 -0700 (PDT)
In-Reply-To: <7vtxngyl30.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220484>

On Mon, Apr 8, 2013 at 12:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Apr 7, 2013 at 9:33 PM, Jeff King <peff@peff.net> wrote:
>>> On Sun, Apr 07, 2013 at 09:03:25PM -0500, Felipe Contreras wrote:
>>
>>>> And you think that is desirable? User-friendly?
>>>
>>> No, as you probably realized if you read the rest of my email. My point
>>> in bringing it up was to try to explain exactly what is going on in each
>>> case. Your commit message provided zero explanation of what the current
>>> problem is, nor why your fix is the right thing to do.
>>
>> I have explained this many times, I wonder why when the patch is close
>> to be merged does this become important, and not before.
>
> There are at least a few reasons I can think of off the top of my
> head.
>
> Reviewers have limited time allocated for each individual topic.  To
> an original patch with say 3 problems, the review may only point out
> issues in 2 and suggest a concrete improvement for only 1 and that
> is sufficient to suggest a reroll.  That is not being unhelpful by
> deliberately withholding 1 and half reviews in the initial round.

I'm not talking about the time it took to come up with the criticism
below, I'm talking about the comment regarding the commit message. If
the commit message did indeed provide *zero* explanation, that's
certainly something that should be immediately visible, no? It could
have been mentioned six months ago.

>>>> That's a comprehensive essay, unfortunately, it's not correct. The
>>>> exit status of the remote-helper is not important, it's the one of
>>>> fast-import that we really care about.
>>>
>>> Nowhere does it say that we should not check fast-import's exit value,
>>> and indeed, the patch does not replace that check at all. It comes
>>> immediately after. It replaces the WNOHANG check of the helper's exit
>>> code (i.e., check_command) with a synchronous check.
>>
>> Yeah, and in the process it's changing the design of transport-helper,
>> where the pipes are closed only at the very end.
>
> I agree that the disconnection here closes the pipes a lot earlier
> than we used to.  But I am not sure what the practical consequences
> of doing so are.  We know the fast-import process has successfully
> read everything from the helper (we called finish_command() on it).
> We expect at this point the helper is still running or successfully
> exited (the other alternative, the helper died with non-zero status,
> is an error check_command() patch wanted to detect).  But if we keep
> helper running, who will be communicating with it via these open
> pipes?  The process that is calling finish_command() on fast-import
> and disconnecting from the helper won't be, as read/write to the
> pipe, even if we do not disconnect from here, will result in errors
> if the helper has already exited at this point.

Nobody will send any further input, but in theory we could redirect
the pipe and send more commands. That's how it was designed.

And in fact, I'm thinking doing exactly that, so we can send another
command to fetch the foreign commit ids and append notes with them.

> What I am trying to get at is if "changing the design", which I
> agree is a change, is an improvement, or a backward incompatible
> possible breakage.

It's an improvement I guess, but it's "changing the design" only in
one part of the code, while the rest follows a different design.

--
Felipe Contreras
