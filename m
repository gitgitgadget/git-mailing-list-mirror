From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 21:46:20 +0100
Message-ID: <200704172146.33665.andyparkins@gmail.com>
References: <200704171041.46176.andyparkins@gmail.com> <200704172012.31280.andyparkins@gmail.com> <Pine.LNX.4.64.0704171229360.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:46:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduZh-0004ie-7Q
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031200AbXDQUqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031204AbXDQUqt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:46:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:20409 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031200AbXDQUqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:46:49 -0400
Received: by ug-out-1314.google.com with SMTP id 44so267658uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 13:46:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GiLHSPo/gIfCMbs/KSeSaaqgtONBXC0p5CZvkuXxlEk08Wf75i/naJgwHb5j3FOb2b1FhZhvYrY/rJ76whNPaTlGAK79iUiPUfH5SQAGp0w2bjWCMTk3IXm7gqxGfRElJ4fJ1rqr3gRlj4Vs+kwM2hvpEdXjiTHgLTe1k90icFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FEvbpotUwEgwUHz55pFOxvxO0w4W0plyndcDGXH7NUtL0f1inVDyfpGq8JOy4QpGU5Ep2rf29p5tbBkkAndFxMSbjkJm9y4qWFI8y8ru4F9D9MRJQQzpc932j9kezXQqzAbByG4uR4gierG6fA/QwsytY3JZZz+ImHJAuVSga+A=
Received: by 10.67.21.11 with SMTP id y11mr749745ugi.1176842807320;
        Tue, 17 Apr 2007 13:46:47 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id u1sm1694016uge.2007.04.17.13.46.45;
        Tue, 17 Apr 2007 13:46:46 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704171229360.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44821>

On Tuesday 2007, April 17, Linus Torvalds wrote:

> No, you haven't. You've "addressed" them by stating they don't
> matter. It doesn't "matter" that a diff won't actually apply to a
> checked-out tree, because you fix it up in another tool.

Okay.  I think this is a matter of perspective - my perspective is that 
if it supplies what svn/cvs supply then that would please the people 
who want it (of whom I am one); yours is obviously that if it isn't 
perfect, it's not worth doing.  That's a reasonable thing to demand, 
and I'm not going to try and argue you out of it.

> And it doesn't "matter" that switching branches will just result in
> the wrong keyword expansion, because you don't care about the
> keywords actually being "correct" - they are just random strings, and
> it apparently doesn't really have to "work" as far as you're
> concerned.

If you define "work" as "works like cvs/svn does", then I was fine with 
it.  I don't like it when my favourite VCS, that I want everyone to 
use, doesn't have an answer to "but does it do X?".

> And the "git grep" concern you just dismissed by stating that it
> should use the filesystem copy, never mind that this just means that
> a clean working tree gets different results from doing the same thing
> based on that same revision.

As I said at the time, I just picked one of the two options.  If you 
don't like that, pick the other option - collapse the keywords during 
the grep...

> And the reaon I'm shouting is that "it doesn't matter that it's a bit
> hacky" mentality is what gets you things like CVS in the end.
> Bit-for-bit results actually matter. Guarantees actually matter. And
> you should not be able to see a differece in the working tree just
> because you happened to be on a different branch before.

Bit-for-bit as in CRLF is untouched?  No?  Bit-for-bit as in you said 
you were okay with keyword-collapsing but not expansion?  You're just 
as willing to compromise as me, you've just drawn the line in a 
different place.

Incidentally: for future reference, I'll read what you write regardless 
of whether you shout it or not.

> You can try, but you are *ignoring* the things that I say. The end

I've tried very hard to respond to every point you've put to me; I've 
not selectively chopped out bits, and I've tried to give answers that 
make it work as you ask.  Now, none of those things were acceptable to 
you - which is fine - but I certinaly wasn't ignoring what you say - 
_disagreeing with_ is not the same as ignoring.

> If that's what it is, fine. But people on the list seem to actually
> *want* it. They must be educated what a *disaster* it would be to
> actually try to really support something like it in real life, and
> not just as a mental exercise.

People wanting something "wrong" so much is not a sign that they need 
educating, it's a sign that they need a solution.   In every other 
respect git has a solution for them; rather than explaining to them 
that what they want is stupid, I'd offer that it's more appropriate to 
offer something better in exchange.  So my keyword expansion idea is 
wrong - fine - where's the something better?  Writing custom scripts 
and makefiles for every project I ever run is /not/ "something better".

Anyway, it's late, and I'm tired - this has turned into a battle of 
wills, and I'm not that into battling.   Enough antihistamine has been 
poured on my itch that I no longer want to scratch it.  I'll send my 
most recent patch for the sake of history, and then abandon this 
project.

Thanks for your time on this, I appreciate your detailed responses, even 
if we don't agree.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
