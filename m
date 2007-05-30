From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Wed, 30 May 2007 14:25:17 +0200
Message-ID: <87k5uqqz0y.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
	<871wh0ww80.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org>
	<87r6ozs7q5.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705291412060.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 30 14:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtNF1-00028B-7P
	for gcvg-git@gmane.org; Wed, 30 May 2007 14:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbXE3MZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 08:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbXE3MZU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 08:25:20 -0400
Received: from mx.meyering.net ([82.230.74.64]:51547 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbXE3MZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 08:25:19 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9E1E555BA0; Wed, 30 May 2007 14:25:17 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0705291412060.26602@woody.linux-foundation.org> (Linus Torvalds's message of "Tue\, 29 May 2007 14\:19\:41 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48755>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 29 May 2007, Jim Meyering wrote:
>> >
>> > Maybe you have not noticed, but my argument has ben about EPIPE.
>>
>> Ha ha.  That's a good one.
>> The point was that even you must see that your
>> "[Jim's] WHOLE patch is crap" statement was wrong.
>
> Ehh. That's a rather edited version of what I said, isn't it?

No.  I'm glad to see that perhaps even you are surprised by your words.
The only editing was to capitalize WHOLE.  Here's what you wrote:

    > I think this patch is fundamentally WRONG. This fragment is just a prime
    > example of why the whole patch is crap. The old code was correct, and you
    > broke it.

Umm... are the above three lines the only part of my message you're
prepared to talk about?  You haven't addressed any of the interesting
(technical) parts.

> That's after I explicitly _quoted_ the part where you actively removed the
> code that said "EPIPE is right", and also after I had told you several
> times that you should consider EPIPE as a special case in your other part.
>
> In other words, yes, EVERY SINGLE HUNK of your patch was wrong, and I had
> told you exactly why.

And I told you why I think my patch was on the right track.
i.e., why it now appears to be fine to treat EPIPE like any other error.

It is interesting to see that you've elided all of my arguments rather
than make an attempt to rebut them.  I'm trying to keep my side of this
discussion professional, so I'll ignore parts of what you've written
below.

> How wrong does a patch have to be to be "crap"? Maybe I have higher
> standards than you do...

> And now you have trouble accepting that, even after you have sent out a
> fixed patch without the crap. Thanks for finally bothering to get the
> patch right, but I don't see why you have to try to make-believe that it
> was ever about anything but EPIPE.

My original patch was about ENOSPC and EIO.  EPIPE was mostly incidental.
I don't care about EPIPE, and think it deserves no special treatment.
You appear to be obsessed with it now, perhaps because SIGPIPE-ignoring
porcelain (now long gone) once caused trouble.

> So go back and read my emails.

Did you read mine?  I explained why EPIPE is no longer a problem for
git, even if you're using stock bash-2.05b or bash-3.0.

> You'll see that in every single one I made
> it very clear that EPIPE was special.

No.  You merely *said* it was special.
You haven't demonstrated that it's special enough (and still common
enough) to pollute all code that tests for file-close failure.  I hear
that it *used to be* common enough to merit such treatment.  Now, it is
a much harder case to make.  But from what I've seen, you haven't even
tried to do that much.  Hmm... or maybe you did try to make the case,
and came up short.  Is that why you are resorting to hyperbole, and ad
hominem arguments?

> From the very first one (where I
> didn't call your patch crap, btw: I said it was wrong, and that some
> errors are expected and good, and I explicitly told you about EPIPE).
>
> So what did you do? Instead of acknowledging that EPIPE was different, you
> actually *expanded* on that original patch, and made the other places
> where we _did_ handle EPIPE correctly, and made those places handle it
> _incorrectly_.
>
> And then you expect me to be _polite_ about it? Grow up. I was polite
> before you started explicitly doing the reverse of what I told you you
> should do. At that point, your patch went from "meant well, but the patch
> was wrong" to "That's just obviously crap".

Let's see...  I dared to post code contrary to your unsubstantiated claim,
and therefore you describe that code as "obviously crap".

Just because you are Linus doesn't mean you can decree that
"EPIPE must be ignored" and make everyone take it on faith.

Can you substantiate your claim that my proposed changes cause trouble
*in practice*?  So far, all I've heard is FUD, and all of my explanations
of why EPIPE no longer matters seem to have been ignored.
