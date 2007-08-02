From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git clone error
Date: Thu, 2 Aug 2007 18:08:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021806510.14781@racer.site>
References: <C2D74FA8.2C06%denbuen@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Thu Aug 02 19:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGeAx-0003da-Ae
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 19:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968AbXHBRJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 13:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbXHBRJX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 13:09:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:51078 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751862AbXHBRJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 13:09:23 -0400
Received: (qmail invoked by alias); 02 Aug 2007 17:09:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 02 Aug 2007 19:09:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+4AzouVAe4l8DlkEoRgqYogvFyl7EawJ5it2iTc5
	pAuKIFlq6yey/f
X-X-Sender: gene099@racer.site
In-Reply-To: <C2D74FA8.2C06%denbuen@sandia.gov>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54572>

Hi,

On Thu, 2 Aug 2007, Denis Bueno wrote:

> On 08/01/2007 15:12, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> wrote:
> >> How difficult would it be to create a new git repo which is exactly the same
> >> minus the initial condor-uninstall.sh commit?  That is, just to pretend the
> >> initial import of condor-uninstall.sh never existed, and use the second
> >> commit of the old repo the first commit of the new, and preserve the rest of
> >> the history of the entire repo?
> > 
> > That would be even easier.  Just graft "nothingness" as parent of the
> > second commit:
> > 
> > $ git rev-parse <second-commit> >> .git/info/grafts
> 
> I must be misunderstanding:
> 
>     scripts[] > git fsck --full
>     error: b28b949a1a3c8eb37ca6eefd024508fa8b253429: object corrupt or
> missing
>     missing blob b28b949a1a3c8eb37ca6eefd024508fa8b253429
> 
>     # b2... should fill in your <second-commit>?

Ah no.  Linus diagnosed that this blob is your condor-uninstall script in 
your initial commit.  You should be able to get at it by calling "git log 
--root" and taking the last commit.  Just to make sure, "git show 
<first-commit>:bla/condor-uninstall.sh" should fail miserably, mentioning 
a corrupt blob.

The second commit I was referring to is the second last commit in the "git 
log --root" output.

Hth,
Dscho
