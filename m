From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of
 some adhocery
Date: Tue, 27 Jun 2006 01:00:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606270057260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
  <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com> 
 <Pine.LNX.4.63.0606270038200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-From: git-owner@vger.kernel.org Tue Jun 27 01:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv05e-0000TB-MB
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 01:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWFZXBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 19:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWFZXBE
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 19:01:04 -0400
Received: from mail.gmx.net ([213.165.64.21]:29069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933248AbWFZXA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 19:00:59 -0400
Received: (qmail invoked by alias); 26 Jun 2006 23:00:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 27 Jun 2006 01:00:58 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606261550p145b20a6gbe960e0abc16e8a4@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22689>

Hi,

On Tue, 27 Jun 2006, Martin Langhoff wrote:

> On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Tue, 27 Jun 2006, Martin Langhoff wrote:
> > 
> > > And it errors out with ignore-if-in-upstream:
> > >
> > >  $ ./git format-patch --ignore-if-in-upstream -o .patches origin master
> > >  fatal: Not a range.
> > 
> > Could you test with "origin..master" instead of "origin master"?
> 
> Funny you mention that! Now it works ;-) and it even produces the
> patches I would expect.

The funny thing is: I did something to account for the old syntax, but 
only if you specified _one_ ref, not _two_. It would be easy, but is it 
needed? (I.e. are your fingers so trained on it?)

> There is something strange though. I have a repo with ~150 pending 
> patches to push, of which git-cherry spots ~100 as already merged 
> upstream. So the old git-format-patch.sh would spit 50 patches, and the 
> initial C version would do 150.
> 
> Now this version gives me 50 patches, regardless of
> --ignore-if-in-upstream. Is that expected?

Hell, no! Something is really wrong there.

What does "git-rev-list their..my | wc" say?

> Also, if the two heads are identical, it still says 'Fatal: Not a
> range", but that isn't so important.

This is a consequence of my being too lazy to support the old "theirs 
mine" syntax (see above).

Ciao,
Dscho
