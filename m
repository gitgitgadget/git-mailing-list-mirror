From: Ingo Molnar <mingo@elte.hu>
Subject: Re: "git revert" feature suggestion: revert the last commit to a
	file
Date: Thu, 5 Feb 2009 22:00:18 +0100
Message-ID: <20090205210018.GB21500@elte.hu>
References: <20090205202104.GA11267@elte.hu> <7vvdrobobc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBMF-0004Au-BR
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZBEVAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 16:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZBEVAc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:00:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33022 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbZBEVAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 16:00:32 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LVBKh-00024e-V8
	from <mingo@elte.hu>; Thu, 05 Feb 2009 22:00:30 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id C5E863E21B0; Thu,  5 Feb 2009 22:00:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vvdrobobc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108619>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > So i have to do something like:
> >
> >    git revert $(git log -1 --pretty=format:"%h" kernel/softlockup.c)
> >
> > (tucked away in a tip-revert-file helper script.)
> >
> > But it would be so much nicer if i could do the intuitive:
> >
> >    git revert kernel/softlockup.c
> >
> > Or at least, to separate it from revision names cleanly, something like:
> >
> >    git revert -- kernel/softlockup.c
> 
> All three shares one issue.  Does the syntax offer you a way to give
> enough information so that you can confidently say that it will find the
> commit that touched the path most recently?  How is the "most recently"
> defined?
> 
> At least you can restate the first one to:
> 
>     git revert $(git log -1 --pretty=format:"%h" core/softlockup -- kernel/softlockup.c)
> 
> to limit to "the one that touched this file _on this topic_".

All in the current scope of the integration branch, sure. I.e. the same 
scope of commits that "git log kernel/softlockup.c" uses.

	Ingo
