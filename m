From: Ingo Molnar <mingo@elte.hu>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
	file
Date: Thu, 5 Feb 2009 22:00:55 +0100
Message-ID: <20090205210055.GC21500@elte.hu>
References: <20090205202104.GA11267@elte.hu> <7vvdrobobc.fsf@gitster.siamese.dyndns.org> <498B51E8.8030801@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBMl-0004KW-JP
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbZBEVBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 16:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZBEVBD
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:01:03 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53453 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbZBEVBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:01:02 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LVBLI-00018p-SE
	from <mingo@elte.hu>; Thu, 05 Feb 2009 22:01:01 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 0FCC23E21B0; Thu,  5 Feb 2009 22:00:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <498B51E8.8030801@xenotime.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108621>


* Randy Dunlap <rdunlap@xenotime.net> wrote:

> Junio C Hamano wrote:
> > Ingo Molnar <mingo@elte.hu> writes:
> > 
> >> So i have to do something like:
> >>
> >>    git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)
> >>
> >> (tucked away in a tip-revert-file helper script.)
> >>
> >> But it would be so much nicer if i could do the intuitive:
> >>
> >>    git revert kernel/softlockup.c
> >>
> >> Or at least, to separate it from revision names cleanly, something like:
> >>
> >>    git revert -- kernel/softlockup.c
> > 
> > All three shares one issue.  Does the syntax offer you a way to give
> > enough information so that you can confidently say that it will find the
> > commit that touched the path most recently?  How is the "most recently"
> > defined?
> > 
> > At least you can restate the first one to:
> > 
> >     git revert $(git log -1 --pretty=format:"%h" core/softlockup -- kernel/softlockup.c)
> > 
> > to limit to "the one that touched this file _on this topic_".
> > 
> >> Would something like this be possible in generic Git? It would sure be a 
> >> nice little touch that i would make use of frequently.
> >>
> >> Or is it a bad idea perhaps? Or have i, out of sheer ignorance, failed to 
> >> discover some nice little shortcut that can give me all of this already?
> > 
> > The closest I can think of is
> > 
> > 	git revert ':/the title of the commit'
> > 
> > but it shares the exact same issue of "how would I limit the search space
> > to make sure it finds the right commit".
> 
> And it should revert whatever commit is the last/most recent to the 
> currently used file, i.e., not always revert the same commit.

i'm not sure i understand, what do you mean precisely?

	Ingo
