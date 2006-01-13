From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: My first git success
Date: Fri, 13 Jan 2006 21:14:21 +0100
Message-ID: <20060113201421.GA25252@ebar091.ebar.dtu.dk>
References: <dq8epd$k28$1@sea.gmane.org> <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org> <86y81kvtvj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 13 20:17:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExUQH-0002hM-3C
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWAMTRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422837AbWAMTRO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:17:14 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:20927 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1422833AbWAMTRO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:17:14 -0500
Received: (qmail 25298 invoked by uid 5842); 13 Jan 2006 20:14:21 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <86y81kvtvj.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14638>

On Fri, Jan 13, 2006 at 10:57:04AM -0800, Randal L. Schwartz wrote:
> >>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> Linus> I still hope the exchanges will result in more docs, or at least other 
> Linus> lurkers on the list also learning a new trick or two..
> 
> I've also enjoyed a bit of success putting a website under git.  I started
> working on AJAX-ing some of the code, but I needed to do maintainence on the
> live site, so I've just simply done "git-checkout master" to work on that, and
> "git-checkout ajax; git-pull . master" when I want to continue work on the
> ajax upgrades.
> 
> However, before I bug-fix, I have to "snapshot" any working changes in the
> ajax branch or I would lose them on "git-checkout master", which gives me
> commits that look like "snapshot".  Am I doing that wrong?  Is there a better
> way to do parallel development of a "live vs upgrade" branch, and make commits
> only when I make progress?

I've been wondering this myself.  Perhaps the following way would work?

    git checkout ajax          # Work on the ajax branch.
    git diff HEAD >ajaxdiff
    git checkout -f master     # Work on the bug fix in master.
    git commit -a -m "Bug fix in master"
    git checkout ajax
    git apply ajaxdiff
    git commit -a -m "Finished commit in ajax"

This is untested, so it's only for inspiration.

Regards,

Peter
