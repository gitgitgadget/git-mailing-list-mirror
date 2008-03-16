From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 19:11:48 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803161904360.19665@iabervon.org>
References: <frh8dg$t9j$1@ger.gmane.org> <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo> <7vwso2ieuu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803161716470.19665@iabervon.org> <7vwso2gwnf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803161812340.19665@iabervon.org> <7vzlsyfgjg.fsf@gitster.siamese.dyndns.org> <7vbq5eff3e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb21r-0006wF-Fh
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 00:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbYCPXLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 19:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754775AbYCPXLu
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 19:11:50 -0400
Received: from iabervon.org ([66.92.72.58]:35088 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbYCPXLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 19:11:50 -0400
Received: (qmail 16160 invoked by uid 1000); 16 Mar 2008 23:11:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2008 23:11:48 -0000
In-Reply-To: <7vbq5eff3e.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77401>

On Sun, 16 Mar 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> >
> >> Is "refs/*:refs/*" (mirror everything, including weird stuff) supposed to 
> >> be prohibited?
> >
> > No.  In fact "remote add --mirror" actively creates such.  See my other
> > message about design level issues.
> 
> I think something like this is needed.  It still has an independent issue
> that this is now called by "git remote show" or "git remote prune", and it
> will die with a nonsense "refusing to create" error message, though.
> 
> The error, as far as I can tell, is half about a misconfigured config
> (e.g. "fetch = refs/heads/*:refs/remotes/[]?/*") and half about screwy
> remote repository (e.g. a misnamed "[]?" branch on the remote end can try
> to update a broken "refs/remotes/origin/[]?" even the configuration is a
> perfectly valid "fetch = refs/heads/*:refs/remotes/origin/*").  It may
> make sense to reword the error message to "ignoring" from "refusing" and
> do just that without dying here.  I dunno.

Yeah, I think that's right. (And this patch is also right)

	-Daniel
*This .sig left intentionally blank*
