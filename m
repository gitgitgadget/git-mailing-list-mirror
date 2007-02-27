From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Patch editing
Date: Tue, 27 Feb 2007 23:37:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272332440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
 <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271201400.6485@iabervon.org>
 <Pine.LNX.4.63.0702272106150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271651500.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAwp-00017a-6W
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXB0WhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbXB0WhS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:37:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:52441 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751965AbXB0WhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:37:17 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:37:15 -0000
X-Provags-ID: V01U2FsdGVkX1+Pwth6dkOPugIYtcp4Zm5oWi56XUF1m54F2kNxmF
	IQAQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271651500.6485@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40830>

Hi,

On Tue, 27 Feb 2007, Daniel Barkalow wrote:

> On Tue, 27 Feb 2007, Johannes Schindelin wrote:
> 
> > On Tue, 27 Feb 2007, Daniel Barkalow wrote:
> > 
> > > One nice thing about my method is that, if you've had to make a dozen 
> > > unrelated changes to get something to compile and run far enough to test 
> > > whether any of the changes are actually correct, you can be sure to get 
> > > that work preserved. I'd be a lot less comfortable preparing 
> > > intermediate states if I didn't have the final state securely tucked 
> > > away.
> > 
> > You _could_ still ensure that by looking in the reflog which was your old 
> > tip-of-branch, and git-diff with that.
> > 
> > But I agree. That is why I commit _everything_ before rearranging.
> 
> I think you're misunderstanding me; I want to use git's 
> archival/distribution functionality before I have a commit that I can put 
> a useful message on. This means that, at some point, I'm making real 
> commits, and I know what final state I want, but that final state involves 
> unrelated changes.
> 
> I think I usually come up with something like: 7 patches related to the 
> functionality I'm working on, 1 patch that fixes an old bug that became 
> important due to the change, and 2 patches which improve the debugging 
> infrastructure.

Same for me.

> And the actual sequence of intermediate states that my 
> code was in is something like: API written, stub implementations, some 
> code that suggests what should happen; program calling the API and 
> crashing; version that is written but buggy;

Still same for me.

> version that's buggy but verbose;

I don't commit that.

However, if I _do_, it _only_ contains the messages. And in that case 
rebase--interactive (this is the new working title for edit-patch-series) 
allows you to just kill these commits...

> version that's working but verbose.

Would be handled by (3way) cherry-pick.

> Am I unusual in being afraid of losing work in a state that contains 3 
> different half-features?

Not at all. I often do "git checkout -b temp && git commit -a -m temp && 
git checkout <oldname>".

Ciao,
Dscho
