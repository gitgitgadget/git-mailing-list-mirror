From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Fwd: git cvsimport implications
Date: Fri, 17 May 2013 07:50:42 -0400
Message-ID: <CACPiFCLqtSy_=1yw6mGWFhNOi=M1rrPNbD6=qpo4FOO_QywCgg@mail.gmail.com>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
 <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
 <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu>
 <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com> <5195F3EB.8000308@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 17 13:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdJBm-0007Hs-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 13:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab3EQLvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 07:51:05 -0400
Received: from mail-qa0-f54.google.com ([209.85.216.54]:50941 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099Ab3EQLvE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 07:51:04 -0400
Received: by mail-qa0-f54.google.com with SMTP id hu16so323229qab.6
        for <git@vger.kernel.org>; Fri, 17 May 2013 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CIrZ0nHx0Jt/uBjlogOfF5vG/A2Iiu9VTn2oDyUOmj0=;
        b=KwOOr7WWL1dGdMsZ7Vu0KKWq6/A41uakMaJMqUotDO58tFFMzMiaRuaILSFAxpRSYv
         8D/T8G4OhmEgpOjIgtbxYO1FCO/3NCkZFd/PlpdzLbrwnd6x8H37EisNknYiGxUR2BoA
         Up3Dk8g1dwbiYZgMhKxoVIwQrMQF3kTgTBrX62bBvnBR4p6IPNlXntYUHy4MsjDHqGq/
         ex5xHJry+wzNT75vbvMSpuwLNjF3ftDnASATTsRJ7T+xZxdKSEqEOrorz/Yv3BofsAtq
         3OEX9YHOPdzZca3PMd++j7DEUjNLSpRmGaMibuPSfJxOvc4FzhxYdZLuyNJ+2lNySkNm
         rAFw==
X-Received: by 10.224.188.134 with SMTP id da6mr36621691qab.69.1368791462528;
 Fri, 17 May 2013 04:51:02 -0700 (PDT)
Received: by 10.49.96.201 with HTTP; Fri, 17 May 2013 04:50:42 -0700 (PDT)
In-Reply-To: <5195F3EB.8000308@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224683>

On Fri, May 17, 2013 at 5:10 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> For one-time imports, the fix is to use a tool that is not broken, like
> cvs2git.

As one of the earlier maintainers of cvsimport, I do believe that
cvs2git is less broken, for one-shot imports, than cvsimport. Users
looking for a one-shot import should not use cvsimport as there are
better options there. Myself, I have used parsecvs (long ago, so
perhaps it isn't the best of the crop nowadays).

TBH, I am puzzled and amused at all the chest-thumping about cvs
importers. Yeah, yours is a bit better or saner, but we all wade in
the muddle of essentially broken data. So "is not broken" is rather
misleading when talking to end users. It carries so many caveats about
whether it'll work on the users' particular repo that it is not a
generally truthful statement.

I am very glad to hear it is better than cvsimport, and even more glad
to hear its limitations are better understood and documented. It has
had a testsuite for the longest of times!

And very likely has the best chance of success across the available
importers :-)

Oh, and why is cvsimport so vague? Because it is just driven by cvsps.
It creates a repo based on what cvsps understands from the CVS data.

At the time, I looked into trying to use cvs2svn (precursor to
cvs2git) as the "CVS read" side of cvsimport, but it did not support
incremental imports at all, and it took forever to run.

It was a time when git was new and people were dipping their toes in
the pool, and some developers were pining to use git on projects that
used CVS (like we use git-svn now). Incremental imports were a must.

One of the nice features of cvsimport is that it can do incrementals
on a repo imported with another tool. That earns it a place under the
sun. If it didn't have that, I'd be voting for removal (after a review
that the replacement *is* actually better ;-) across a number of test
repos).

cheers,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
