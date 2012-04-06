From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 6 Apr 2012 15:38:24 +0400
Message-ID: <CAHkcotjrVqvYnAV5U7gPngbW0saghAv8vZB3jh=dOKLPmYdJrQ@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<20120405131301.GB10293@sigill.intra.peff.net>
	<vpqwr5uceis.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 06 13:38:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG7Us-0008IE-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 13:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283Ab2DFLi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 07:38:26 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:53825 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab2DFLiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 07:38:25 -0400
Received: by dake40 with SMTP id e40so2694702dak.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 04:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cmu2UnLRVv5DMKMhPoBouS4UkVMKvBFdudYmwtrhAHw=;
        b=lNr3GfTwcDWYLiqwFn1kueka1XrGLRNOrAc0QKyTVJjZwBcebfwIAq5X5IYInKZ86n
         Gtk5R3FB1vuSLxHQfz2yKnTOVRPhqkCc+JIx4tTEKauGwhFOxB2IMfsixz1jgBb9OWcn
         3FWmc5UuiSahHm0Jh9TYoEf6Wlu9JLpjaHjWwMHwI47U3c+trlfWuGEnsJMrGYu0Mcrd
         pcvRSkAVJXC/eirobTu0CbLoOHmtcMGY/MMfMU6DsRWgyNvUBSCclZXMWPLvZiHyWohv
         iXFC44fI0uh6YWQJYS9ADh3HTBALBMbzjYyJvCHzK9oW4N+xEseAnGJXIHbfKFADB4Wq
         B1/Q==
Received: by 10.68.202.167 with SMTP id kj7mr15391445pbc.9.1333712304677; Fri,
 06 Apr 2012 04:38:24 -0700 (PDT)
Received: by 10.143.66.9 with HTTP; Fri, 6 Apr 2012 04:38:24 -0700 (PDT)
In-Reply-To: <vpqwr5uceis.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194866>

On Thu, Apr 5, 2012 at 8:46 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> I can hardly imagine someone knowing what "git pull" does, and
> _surprised_ to see that "git push" sends commits to the same place.

It seems you assume that people use in a _centralized_ workflow.
In this case, 'upstream' does largely the right thing, so no one
will be surprised.

However, many of those who got used to a distributed workflow will find
that surprising, because when they created a new branch that meant it
to push as a _new_ branch. So other people could take a look, or they
may need the maintainer ACK to push anything to 'master'. Also they may
have a policy nothing should be fast-forwarded to master, but only to
be merged with a merge commit.

And then it is more natural for people to think in terms of names that
are immediately obvious to anyone, while 'upstream' behavior depends on
the state that is not immediately obvious. You may start a new topic
branch based on 'master' or some the latest release to have a more
stable base. And 'upstream' will work differently in this case. If you
know about 'tracking' then it may be obvious to you, but it is not so
obvious to those who only start to use git for short time...


>
> And I still have my concern with real beginners: what advice would you
> give to a user whose "git push" is denied because of non-fast forward. I
> raised this concern already:

Don't use a central workflow, because it sucks :)

Seriously, why do you care about beginners who use a centralized workflow
and not beginners who have to use with existing projects that use more or
less distributed workflow, where pushing to 'master' is more likely to be
the wrong thing to do than otherwise... And when push is denied, they may
ask someone whether they are doing something wrong. In case when master
is fast-forwarded silently, they are not likely to notice that they did
something wrong, and the fact that happens only sometimes (depending on
some "tracking" feature which they have not heard) is not very helpful.


Dmitry
