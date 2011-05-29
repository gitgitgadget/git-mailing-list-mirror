From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 19:30:32 +1000
Message-ID: <SNT124-W4764217DDF8E31B5155828C4780@phx.gbl>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>,<20110528230844.GA31498@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>, <gitster@pobox.com>,
	<artagnon@gmail.com>
To: <jrnieder@gmail.com>, <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 11:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQcKa-0006bo-Eo
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 11:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019Ab1E2Jaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 05:30:39 -0400
Received: from snt0-omc4-s12.snt0.hotmail.com ([65.55.90.215]:18935 "EHLO
	snt0-omc4-s12.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915Ab1E2Jai convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 05:30:38 -0400
Received: from SNT124-W47 ([65.55.90.200]) by snt0-omc4-s12.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 29 May 2011 02:30:33 -0700
X-Originating-IP: [114.77.220.50]
Importance: Normal
In-Reply-To: <20110528230844.GA31498@elie>
X-OriginalArrivalTime: 29 May 2011 09:30:33.0230 (UTC) FILETIME=[0EF01AE0:01CC1DE3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174685>


> Date: Sat, 28 May 2011 18:08:44 -0500
> From: jrnieder@gmail.com
> Martin von Zweigbergk wrote:
> > Teach git-rebase the --discard subcommand, which is similar to
> > --abort, but does not move back to the original branch. Suggest this
> > new subcommand to the user where we currently suggest to delete
> > $GIT_DIR/rebase-apply (or rebase-merge).
>
> Good idea.
>
> At first the name --discard made me think it was going to move back to
> the original branch and discard the reset of the patch series being
> rebased. Not sure what a better name would be, though.
>
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -238,6 +238,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
> [...]
> > +--discard::
> > + Abort the rebase operation without restoring the original branch.
>
> A reader without a complete mental model for what "git rebase" does
> could be very confused by this. One might think: does this mean that
> git has been scribbling over the original branch, and this switch
> almost completely cancels that but leaves the branch still
> scribbled-on?
>
> How about something like:
>
> --keep-head::
> When aborting a rebase, do not check out the original branch
> but leave the HEAD alone. This can be useful if you forgot
> about a conflicted or interactive rebase in progress and have
> been committing on top of one of the commits being replayed.
>
> ?
>
> Agh, "git rebase --abort --keep-head" feels a little too long to be
> memorable. Still, hope that helps.

How about "git rebase --stop"?

I think the word "stop" has the implication that you don't go
anywhere, but also that you abort doing whatever it is you were
(in this case, the rebase).

And as I said before, I don't like the idea of changing the
behaviour of already existing (and widely used) commands and
options; even if, as in my case, they're not always used correctly.


Tim.

() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  