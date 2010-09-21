From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH 1/3] tests: Prepare --textconv tests for correctly-failing conversion program
Date: Tue, 21 Sep 2010 22:39:50 +0400
Message-ID: <20100921183950.GA4390@landau.phys.spbu.ru>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <000c991c7a0673e26ee3ecc19ea3c8a7b437fecf.1284830388.git.kirr@landau.phys.spbu.ru> <vpq8w2yvonu.fsf@bauges.imag.fr> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <cover.1284830388.git.kirr@landau.phys.spbu.ru> <26d0544dac2515e76bee0608881cfd8c23bf1ebf.1284830388.git.kirr@landau.phys.spbu.ru> <vpqiq22vp72.fsf@bauges.imag.fr> <20100920203501.GB23533@landau.phys.spbu.ru> <vpq1v8o9lg8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl?ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 21 20:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy7lD-0001wE-0o
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 20:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab0IUSjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 14:39:54 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:52773 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab0IUSjx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 14:39:53 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 8B218FF6FD; Tue, 21 Sep 2010 22:39:50 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <vpq1v8o9lg8.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156739>

On Mon, Sep 20, 2010 at 11:03:35PM +0200, Matthieu Moy wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
> 
> > Matthieu, Jeff, Junio, thanks for your review and input.
> >
> > Comments below inline...
> 
> You've replied to several messages in one. That's OK here since the
> content of your message is essentially uncontroversial, but I'd
> suggest keeping separate threads for separate patches for next time.
> (for example, my reply below looks strange since I'm commenting on
> PATCH 2/3 in a message titled PATCH 1/3 ...). No big deal.

I knew someone will say this :)

But let's try to think about it from a bit different point of view - we
had 3 patches, and description for at least two of them were intermixed.
In this situation the series is better considered as a whole, and if we
consider each patch git branch, what would you do if you need to get
cumulative result of all the branches?

Yes, merge them - so did I. And the reply actually had all the
references to parent messages in it's In-Reply-To header. It's just that
usually MUA's don't show merges graphically (please correct me if I'm
wrong), but otherwise isn't it ok?

I agree, subject should be better corrected somehow, but main idea still
stays valid!

Clearly I did lots of giting recently, so I project it's concepts on
the world :)


> >> > Subject: Re: [PATCH 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
> >>
> >> We try to keep the subject lines short (<80 chars, and as much as
> >> possible less so that "git log --oneline" be pretty).
> >>
> >> How about
> >>
> >> blame,cat-file: add failing tests for --textconv on symlinks
> >
> > I'd like to shorten it, but "add failing tests" is not as descriptive as
> > "Demonstrate --textconv misbehaves in such-and-such way",
> 
> Right, but your "such-and-such way" is not really precise either. One
> cannot know whether it's running, but the wrong way, whether it's
> running and should not, etc. The subject line is here to be a summary,
> you don't need details. And I actually find "add failing tests" more
> precise than "demonstrate that ... is behaving wrongly".

Hmm, maybe my wording is not that good, but to me "Demonstrate
--textconv misbehaves ..." is closer to being more descriptive than "add
failing tests".

This is maybe just a matter of preferences, so I'm ok with either way.

> > and I can't come up with a shorter subject without making it more
> > cryptic. And btw, I've looked at log --oneline output, and
> > (surprise, surprise)
> >
> > 479a56 4fccc04 etc ...
> 
> I don't understand what you mean. After applying your patches, I get:
> 
> 6998f9a RFC: blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
> 025aaac blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
> 3646401 tests: Prepare --textconv tests for correctly-failing conversion program
> 
> which do not fit on a 80-columns terminal.

I meant do git log on those sha's, but late at night I've ommitted one
letter. Here you go:

$ git log -1 --oneline a479a56
a479a56 Documentation/Makefile: allow man.base.url.for.relative.link to be set from Make
$ git log -1 --oneline 4fccc04
4fccc04 Documentation: remove stray backslashes from "Fighting regressions" article


That's 88 & 83 characters. I mean to say maybe it's not that big deal to
sacrifice understandability for 80 chars, especially when git log output
is paged, usually through less -S.

That said I also try to keep subjects short when possible.

> > So if that's not a major obstacle, I'd leave it as is.
> 
> I don't consider it "major" (but other may have different opinions)
> though.

So what would be conclusion here?

> >> These days, it's recommanded to put this kind of code within the
> >> test_expect_success/test_expect_failure.
> >
> > I see, thanks.
> >
> > I've moved other >expected preparation inside test_expect_*, but this
> > expect is special in that it is used in subsequent two tests. So I'd
> > leave this one outside.
> >
> > And btw, I've originally copied in-style what was already there in t8006
> > and t8007 which date to Jun 2010.
> 
> Yes, the guideline is new, and not widely applied (yet).
> 
> > Ah, yes, thanks. I forgot ':/text' means `commit which log is text' -
> 
> A patch to update the comment above follows.

thanks

> > Thanks again to everyone.
> 
> That "everyone" includes you ;-). Thanks for the patch, good job both
> for testing and for the actual fix!

Come on, Matthieu, it's just one small correction :)

Thanks,
Kirill
