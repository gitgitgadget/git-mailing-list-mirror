From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 18:56:33 -0500
Message-ID: <20071128235633.GI7376@fieldses.org>
References: <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com> <Pine.LNX.4.64.0711282039430.27959@racer.site> <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com> <7vhcj63uhw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711282156520.27959@racer.site> <20071128223339.GF7376@fieldses.org> <20071128224717.GG7376@fieldses.org> <Pine.LNX.4.64.0711282309030.27959@racer.site> <7v1waa2bfi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:57:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWm7-0005vv-Nb
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbXK1X4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757821AbXK1X4n
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:56:43 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39420 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbXK1X4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:56:42 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IxWld-0000Hw-7N; Wed, 28 Nov 2007 18:56:33 -0500
Content-Disposition: inline
In-Reply-To: <7v1waa2bfi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66470>

On Wed, Nov 28, 2007 at 03:32:49PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So my rationale was: if we already have an existing framework to integrate 
> > remote changes with our current branch, why not just go ahead and use it?  
> > That's the reason BTW why I originally wanted a "rebase" merge stragegy.  
> > Even if it is not technically a merge.
> >
> > I really rather have no user-friendly support for fetch+rebase (and utter 
> > a friendly, but loud curse everytime I made a "git pull" by mistake) than 
> > yet another command.
> 
> I suspect that people who do not like the two modes of checkout will
> certainly not appreciate the overloading two behaviours to create
> different kind of histories and two different ways to continue when the
> integration do not go smoothly upon conflicts these two behaviours have.
> 
> However, I agree very much with an earlier comment made by Daniel about
> our UI being task oriented instead of being command oriented, and I
> actually consider it a good thing.  So it does not bother me too much
> that "git pull --rebase" has a quite different workflow from the regular
> "merge" kind of pull.
> 
> So let's queue "pull --rebase" and see what happens.

What I'm really most worried about isn't the commandline switch but the
config option--it makes the same commandlines silently behave in very
different ways.

I really don't want every tutorial that mentions "git pull" to have to
say "the following applies only if git.<current-branch>.rebase is
false".  And it'll be either that or risk having a lot of people saying
"I typed in exactly that commandline, but this happened....".

A default to "false" does at least require positive acknowledgement, but
if this is expected to be used by newbies, they're going to be told to
set that config before they understand the difference it makes.

--b.
