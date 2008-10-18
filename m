From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "checkout --track -b" broken? (with suggested fix)
Date: Fri, 17 Oct 2008 22:17:37 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810172119020.19665@iabervon.org>
References: <7vej2fohfr.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0810171113340.19665@iabervon.org> <7vskqug4fy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 04:19:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr1PH-0003jy-P6
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 04:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYJRCRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 22:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbYJRCRk
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 22:17:40 -0400
Received: from iabervon.org ([66.92.72.58]:54024 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560AbYJRCRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 22:17:39 -0400
Received: (qmail 5196 invoked by uid 1000); 18 Oct 2008 02:17:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Oct 2008 02:17:37 -0000
In-Reply-To: <7vskqug4fy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98515>

On Fri, 17 Oct 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 16 Oct 2008, Junio C Hamano wrote:
> >
> >> The patch to branch.c is a quick fix for this issue.  The resulting code
> >> passes all the tests, but I am not very proud of hardcoding the "HEAD" in
> >> the code.  There must be a better way to do this.
> >
> > I agree with the change to the test. I think it would be better to 
> > hard-code "refs/heads/" instead of "HEAD", and I feel like we must have a 
> > "is this ref name a branch?" function, if only because someone could stick 
> > "refs/tags/foo" in HEAD, and we should still say it's not something you 
> > could track, despite it being something different from "HEAD".
> 
> But you can track things under refs/remotes/, so...

Ah, true. Maybe hard-code "refs/". Or have an "is this ref name a branch?" 
function that's paying more attention than I am, and returns true from 
both local branches and (local copies of) remote branches.

	-Daniel
*This .sig left intentionally blank*
