From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Sun, 15 Mar 2009 19:16:16 +0000
Message-ID: <efe2b6d70903151216q4a8881e5t797cf5d3bebc5697@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
	 <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
	 <43d8ce650903112345x3d40b70ap7e4c0f8c7d0b6069@mail.gmail.com>
	 <alpine.DEB.1.00.0903121154560.10279@pacific.mpi-cbg.de>
	 <d9c1caea0903121102y5452603fua0e7a1b82e121b01@mail.gmail.com>
	 <efe2b6d70903130549m63ae9bdeg1cd3f24a43b3e66f@mail.gmail.com>
	 <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Tapsell <johnflux@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>
To: Steven Tweed <orthochronous@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LivqI-0006KJ-FT
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 20:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZCOTQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbZCOTQU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 15:16:20 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:33120 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZCOTQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 15:16:20 -0400
Received: by bwz23 with SMTP id 23so715745bwz.37
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7pcod1V58c7Z88P2fzrAYT4J1iF6NrKrzv5PIForB3g=;
        b=eb740fRlHVtldlMFfnjN5cecCy5HlBgtdZ/ZdEeoolY1S02cjl/rwNOal4RxBkGACy
         t+FpLUfNNsLBRrGn4pqOPLaUsNcP8YU2U2wI0vIuQnE+DEOG2vQ9BTUIq2O9fCcg9COQ
         Dg0uvEPe3uhQDj7HZRJnh3QqgrxB6Y6Unlp3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ISZx9ZuYpUfFA4uZhdWT7wbYnDYidGEsOxnyM5uvKuqHiKagOtdVE6LZNPdhoUzy/6
         rM1OkzMocIbFS+tAIuwEMbRXuz1yAHFEBVnaDYYTl1zo5ukJ+o1Dl3+5xxpLQ2VMPZXm
         66aemSQHqtyxMpR0bLuvax1Q5KSH/2rxzu4LM=
Received: by 10.204.65.1 with SMTP id g1mr1293331bki.57.1237144576661; Sun, 15 
	Mar 2009 12:16:16 -0700 (PDT)
In-Reply-To: <d9c1caea0903130819u770686b1w867f074ffef8fabf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113294>

On Fri, Mar 13, 2009 at 3:19 PM, Steven Tweed <orthochronous@gmail.com> wrote:

> Underflow when using probabilities and lack of precision (rather than
> overflow) when using negated logarithms are well known problems in the
> kind of probabilistic object tracking, inference in graphical networks
> and object identification processes I work with (in computer vision).
> I there may well be other areas of Bayesian decision theory where this
> doesn't happen, and indeed a _very_ quick scan through your document
> suggests that you're adding to tallying information on each timestep
> and recalcuating the entire model from those tallys, which is one of
> the few cases where you can't really do rescaling. I'll try and have a
> more detailled read over the weekend.

That is useful information, thanks.

It is not obvious how to perform this algorithm incrementally, because
of the need to
marginalise out the fault rate. As I understand it, marginalisation
has to be done after you
have incorporated all your information into the model, which means we
can't use the
usual bayesian updating.

> On Fri, Mar 13, 2009 at 12:49 PM, Ealdwulf Wuffinga
> <ealdwulf@googlemail.com> wrote:
>> One issue in BBChop which should be easy to fix, is that I use a dumb
>> way of calculating Beta functions. These
>> are ratios of factorials, so the subexpressions get stupidly big very
>> quickly. But I don't think that is the only problem.
>
> Yes, "Numerical Recipes" seems to suggest that computing with
> log-factorials and exponentiating works reasonably, although I've
> never tried it and NR does occasionally get things completely wrong...

I have implemented this and it does indeed allow the program to work
in more cases
without underflow, with ordinary floating point. However, I think the
underflow can still occur
in plausible use cases.

The problem is still the Beta function. In bbchop it is always passed
D and T where D is
the sum of the number of detecting observations in some of the
revisions, and T is the
same for nondetecting observations. Beta(x,y) underflows a python float
if both x and y are > ~550, and also in other cases when one is
smaller and the other,
larger. BBChop never looks again at a revision if the bug has been
observed there, but if
there are a large number of revisions, it might look at enough of them
to cause a problem.

Obviously no-one is going to manually do hundreds of observations, but
 I want BBChop
to work in the case where someone runs it on a machine in the corner
for a few days,
or even weeks,  to track down a bug which occurs too infrequently to
bisect manually.

Which means I'm still stuck with mpmath, or some equivalent.

Ealdwulf
