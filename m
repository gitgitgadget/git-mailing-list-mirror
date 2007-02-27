From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Patch editing
Date: Tue, 27 Feb 2007 17:07:11 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702271651500.6485@iabervon.org>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702270205540.6485@iabervon.org>
 <Pine.LNX.4.63.0702271247000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271201400.6485@iabervon.org>
 <Pine.LNX.4.63.0702272106150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:07:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMATe-00049A-ET
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbXB0WHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXB0WHO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:07:14 -0500
Received: from iabervon.org ([66.92.72.58]:2417 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbXB0WHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:07:13 -0500
Received: (qmail 9750 invoked by uid 1000); 27 Feb 2007 17:07:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Feb 2007 17:07:11 -0500
In-Reply-To: <Pine.LNX.4.63.0702272106150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40820>

On Tue, 27 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 27 Feb 2007, Daniel Barkalow wrote:
> 
> > One nice thing about my method is that, if you've had to make a dozen 
> > unrelated changes to get something to compile and run far enough to test 
> > whether any of the changes are actually correct, you can be sure to get 
> > that work preserved. I'd be a lot less comfortable preparing 
> > intermediate states if I didn't have the final state securely tucked 
> > away.
> 
> You _could_ still ensure that by looking in the reflog which was your old 
> tip-of-branch, and git-diff with that.
> 
> But I agree. That is why I commit _everything_ before rearranging.

I think you're misunderstanding me; I want to use git's 
archival/distribution functionality before I have a commit that I can put 
a useful message on. This means that, at some point, I'm making real 
commits, and I know what final state I want, but that final state involves 
unrelated changes.

I think I usually come up with something like: 7 patches related to the 
functionality I'm working on, 1 patch that fixes an old bug that became 
important due to the change, and 2 patches which improve the debugging 
infrastructure. And the actual sequence of intermediate states that my 
code was in is something like: API written, stub implementations, some 
code that suggests what should happen; program calling the API and 
crashing; version that is written but buggy; version that's buggy but 
verbose; version that's working but verbose. In refining the work, I drop 
or "if (DEFINED_TO_0_DEBUG)" the messages, split out the patches that 
support the new kinds of messages, and include only working versions of 
functions. And then I write commit messages that talk about the code and 
sign them.

Am I unusual in being afraid of losing work in a state that contains 3 
different half-features?

	-Daniel
*This .sig left intentionally blank*
