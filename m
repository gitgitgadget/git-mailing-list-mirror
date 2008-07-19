From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Sat, 19 Jul 2008 13:44:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807191333550.19665@iabervon.org>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <7vk5fi67dx.fsf@gitster.siamese.dyndns.org> <200807191132.45648.johannes.sixt@telecom.at> <200807191549.56402.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 19 19:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKGUe-00061Z-3W
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 19:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360AbYGSRoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 13:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYGSRoQ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 13:44:16 -0400
Received: from iabervon.org ([66.92.72.58]:43979 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbYGSRoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 13:44:15 -0400
Received: (qmail 26803 invoked by uid 1000); 19 Jul 2008 17:44:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jul 2008 17:44:11 -0000
In-Reply-To: <200807191549.56402.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89117>

On Sat, 19 Jul 2008, Johannes Sixt wrote:

> On Samstag, 19. Juli 2008, Johannes Sixt wrote:
> > On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> > > Ok, but the surrounding code in this function look very suspicious.
> >
> > How about this then?
> >
> > -- snip --
> > builtin-clone: Rewrite guess_dir_name()
> >
> > The function has to do three small and independent tasks, but all of them
> > were crammed into a single loop. This rewrites the function entirely by
> > unrolling these tasks.
> 
> Sigh. I knew it, I knew it. If it had been that trivial, then Daniel had done
> it this way in the first place. :-(
> 
> This needs to be squashed in. It makes sure that we handle 'foo/.git';
> and .git was not stripped if we cloned from 'foo.git/'.

I actually got that from Johannes Schindelin, who added bundle support to 
my clone patch. I remember looking at his change, thinking it looked 
overly complicated, but finding that anything I tried to do to simplify it 
failed tests. If this gets through the test suite (lots of the tests other 
than the clone test try to do a wider variety of odd things than I expect 
users do in practice most of the time), then it's probably a better 
implementation.

	-Daniel
*This .sig left intentionally blank*
