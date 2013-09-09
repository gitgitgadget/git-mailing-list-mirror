From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 22:10:52 +0100
Message-ID: <20130909211052.GK2582@serenity.lan>
References: <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <vpqr4cy4g5q.fsf@anie.imag.fr>
 <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
 <20130909195231.GA14021@sigill.intra.peff.net>
 <20130909202435.GJ2582@serenity.lan>
 <20130909204415.GC14536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 23:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8js-00088J-34
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab3IIVLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:11:12 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:60053 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575Ab3IIVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 17:11:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 241F46064EF;
	Mon,  9 Sep 2013 22:11:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tp0WU7bJYG4b; Mon,  9 Sep 2013 22:11:07 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id D8AF06064EE;
	Mon,  9 Sep 2013 22:11:06 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C80E2161E4D5;
	Mon,  9 Sep 2013 22:11:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mANpsJ1otf9j; Mon,  9 Sep 2013 22:11:05 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BEDE0161E4BD;
	Mon,  9 Sep 2013 22:10:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130909204415.GC14536@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234376>

On Mon, Sep 09, 2013 at 04:44:16PM -0400, Jeff King wrote:
> On Mon, Sep 09, 2013 at 09:24:35PM +0100, John Keeping wrote:
> 
> > > I think that would address the concern I raised, because it does not
> > > create a roadblock to new users accomplishing their task. They can
> > > ignore the warning, or choose "merge" as the default to shut up the
> > > warning (and it is easy to choose that if you are confused, because it
> > > is what git is doing by default alongside the warning).
> > 
> > I think we need to make sure that we give instructions for how to go
> > back if the default hasn't done what you wanted.  Something like this:
> > 
> >     Your pull did not fast-forward, so Git has merged '$upstream' into
> >     your branch, which may not be correct for your project.  If you
> >     would rather rebase your changes, run
> > 
> >         git rebase
> > 
> >     See "pull.mode" in git-config(1) to suppress this message in the
> >     future.
> 
> Yes, that's a good point. I don't know if just "git rebase" is the right
> advice, though; it would depend on whether we were actually pulling from
> the upstream or not.
> 
> I wonder if we have sufficient information at the time of the warning to
> print out the actual "git rebase" invocation that would rebase as if
> they had run "pull --rebase". I think we may have to do a little
> refactoring around the base selection from the reflog (IIRC, git-pull
> does not even calculate it at all if you are not using --rebase).

We can probably do something like:

    opts=
    if git merge-base --is-ancestor "$orig_head" "$merge_head"
    then
        opts=$merge_head
    else
        opts="$orig_head --onto $merge_head"
    fi

so that "git rebase $opts" is the right thing.  Most users then get the
simple "git rebase $merge_head" variant.

> It is also depending on "git rebase" throwing away the merge commit we
> just created. Which I think should happen always if you have not
> configured anything (though perhaps we will eventually support a pull
> mode that does "rebase -p", you would not see this warning with that
> option anyway). But another option would be to simply tell them:
> 
>   git reset --keep HEAD^
>   git pull --rebase [X...]
> 
> where "[X...]" is the arguments they gave to rebase in the first place.
> That looks a little less friendly, though.

Yeah, I think we should keep it simple if possible.  In my experience
people are relatively happy to run a single "make things right" command
but less so if there's a sequence of steps to be performed.
