From: Mike Hommey <mh@glandium.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 10:18:55 +0100
Organization: glandium.org
Message-ID: <20080223091855.GA18942@glandium.org>
References: <200802221837.37680.chase.venters@clientec.com> <alpine.LNX.1.00.0802222249480.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chase Venters <chase.venters@clientec.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 10:19:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSqXg-0000qK-TK
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 10:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbYBWJSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 04:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYBWJSx
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 04:18:53 -0500
Received: from vuizook.err.no ([85.19.215.103]:47644 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758941AbYBWJSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 04:18:25 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JSqWN-0002r1-Bx; Sat, 23 Feb 2008 10:18:21 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JSqX1-0005U8-Cb; Sat, 23 Feb 2008 10:18:55 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0802222249480.19024@iabervon.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74809>

On Fri, Feb 22, 2008 at 11:10:48PM -0500, Daniel Barkalow wrote:
> I find that the sequence of changes I make is pretty much unrelated to the 
> sequence of changes that end up in the project's history, because my 
> changes as I make them involve writing a lot of stubs (so I can build) and 
> then filling them out. It's beneficial to have version control on this so 
> that, if I screw up filling out a stub, I can get back to where I was.
> 
> Having made a complete series, I then generate a new series of commits, 
> each of which does one thing, without any bugs that I've resolved, such 
> that the net result is the end of the messy history, except with any 
> debugging or useless stuff skipped. It's this series that gets merged into 
> the project history, and I discard the other history.
> 
> The real trick is that the early patches in a lot of series often refactor 
> existing code in ways that are generally good and necessary for your 
> eventual outcome, but which you'd never think of until you've written more 
> of the series. Generating a new commit sequence is necessary to end up 
> with a history where it looks from the start like you know where you're 
> going and have everything done that needs to be done when you get to the 
> point of needing it. Furthermore, you want to be able to test these 
> commits in isolation, without the distraction of the changes that actually 
> prompted them, which means that you want to have your working tree is a 
> state that you never actually had it in as you were developing the end 
> result.
> 
> This means that you'll usually want to rewrite commits for any series that 
> isn't a single obvious patch, so it's not a big deal to commit any time 
> you want to work on some different branch.

I do that so much that I have this alias:
        reorder = !sh -c 'git rebase -i --onto $0 $0 $1'

... and actually pass it only one argument most of the time.

Mike
