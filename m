From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Obscure commit message formatting issue
Date: Sun, 11 Nov 2007 17:30:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711111706490.29952@iabervon.org>
References: <Pine.LNX.4.64.0711111559220.29952@iabervon.org>
 <7vprygbfwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 23:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrLK9-00048z-RT
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 23:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbXKKWaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 17:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbXKKWaW
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 17:30:22 -0500
Received: from iabervon.org ([66.92.72.58]:58591 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755520AbXKKWaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 17:30:22 -0500
Received: (qmail 28850 invoked by uid 1000); 11 Nov 2007 22:30:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2007 22:30:20 -0000
In-Reply-To: <7vprygbfwf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64528>

On Sun, 11 Nov 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > The current code drops extra blank lines between the first line of a 
> > commit message (the summary line) and the remainder.
> 
> The patch application side does even more.  It not just strips
> off the leading or trailing blank lines, but duplicate blank
> lines in the middle and trailing whitespaces at the end of each
> line.
> 
> I am of two minds about the formatting side.
> 
> The behaviour you found does not go far enough to correct all of
> the above whitespace breakage the application side will fix up
> on the generation side -- it only corrects one of them.  We
> might want to do more, instead of less that you seem to be
> implying to favor.

What I'm actually doing is working on a cover letter implementation. I'd 
like to use the same code that generates the subject line and message for 
patches to generate the cover letter text from some source material, if 
there is source material, but have "insert text here" markers if there is 
no pre-existing text. But the "insert text here" marker for a paragraph 
looks odd if it's a single line of vertical space, and it's annoying if 
the space is full of text that has to be removed, and it's again odd if 
the text isn't centered. So I want it to start with a blank line. But the 
current code can't generate a text like that.

Reversability isn't all that important to me in this case, although it 
seems to me to be generally desirable for rebase. For email that actually 
goes through people, I'd expect it to get further manipulated by humans, 
so it doesn't matter so much there, aside from being able to arrange the 
input so that you can get the intermediate form you want.

	-Daniel
*This .sig left intentionally blank*
