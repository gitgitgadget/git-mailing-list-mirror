From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: warning merge message
Date: Sat, 23 Dec 2006 01:05:01 +0100
Message-ID: <200612230105.01408.Josef.Weidendorfer@gmx.de>
References: <867728.44872.qm@web31814.mail.mud.yahoo.com> <200612222349.54363.Josef.Weidendorfer@gmx.de> <7vy7ozv8lz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 01:05:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxuO9-00076Y-KD
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 01:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbWLWAFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 19:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbWLWAFN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 19:05:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:52731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753291AbWLWAFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 19:05:11 -0500
Received: (qmail invoked by alias); 23 Dec 2006 00:05:10 -0000
Received: from p5496B9D3.dip0.t-ipconnect.de (EHLO noname) [84.150.185.211]
  by mail.gmx.net (mp028) with SMTP; 23 Dec 2006 01:05:10 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.5
In-Reply-To: <7vy7ozv8lz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35250>

On Saturday 23 December 2006 00:00, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > In a previous discussion, you talked about switching to
> > the new behavior (ie. getting rid of this "first set of
> > branches" rule) when there is at least one branch.*.merge
> > setting in the config file.
> >
> > Unfortunately I can not see an easy way to check this with
> > repo-config, as there is no wildcard support for keys
> > (Ok, I can do a list of keys and grep).
> 
> I think --get-regexp is what you want -- see my "patch for
> discussion".

I see. I just read the thread.

The git mailing list is already quite high volume ;-)
Around 150+ new postings a day.
I think I first should browse through any new threads before
answering any mail.
 
> > I think it is better to provide an option
> > "pull.do-not-follow-the-first-set-of-branches-rule".
> > And we should make this the default after init-db or clone.
> 
> Yes, but the problem is that old timers do make new clones.

Yes, they do.
But this is not breaking existing repositories.

If you collect such incompatibilities for the 1.5.0 release
notes and provide the workaround ("remove that pull.do-not ..."
option) to get back the old behavior, it should be fine.

I can imagine that we want to add branch.*.remote/merge lines
with "git checkout -b XXX remotes/YYY". Of course this should
only be done if the pull.do-not is set. Relying on existance
branch.*.merge lines seems fragile for me.

What about putting this option into the config template instead of
setting it in clone?
If somebody always wants the old behavior, he should provide a template
with this option not set.

> pull.i-like-the-first-set-of-branches in ~/.gitconfig is the
> only thing I can think of but that is too ugly and is already on
> the slippery slope of user.expert configuration which I do not
> think we want.

I agree.

Josef
