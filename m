From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Submit/Workflow question
Date: Sun, 29 Jul 2007 12:03:47 -0400
Message-ID: <20070729160347.GA26637@fieldses.org>
References: <85abtfw6d5.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 18:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFBFY-0000dF-Ny
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 18:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762701AbXG2QDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762667AbXG2QDt
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 12:03:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54879 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762840AbXG2QDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 12:03:48 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IFBFD-00072P-54; Sun, 29 Jul 2007 12:03:47 -0400
Content-Disposition: inline
In-Reply-To: <85abtfw6d5.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54119>

On Sun, Jul 29, 2007 at 05:56:54PM +0200, David Kastrup wrote:
> 
> Suppose that I have created a half-baked patch A suiting my personal
> needs and went on from there, having something like
> 
> ...->A->B->...
> 
> Now at some point of time I decide that really A should be made fit
> for submission.  Basically, I'd want to do
> git-reset --hard A
> [edit some]
> git-commit --amend -a
> git-format-patch HEAD~1
> 
> in order to arrive at a nice submittable patch.  However, I don't want
> to lose B and the following stuff, and the resulting HEAD should
> include the improved of A (it is fine if that needs additional steps,
> and it is fine if it is just HEAD that gets the fixed version, not B).
> 
> So how to do this?  Branch at A^, rebase on A,

Just branch on A.  Or actually I just check out A at this point (leaving
me not on any branch).

> fix the stuff, commit
> with --amend -a, rebase on master, rename the temporary branch to
> master (killing the old master), format and submit the patch?

I'm not completely sure I follow that sequence, but something like that
should work.  A similar approach:

	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#modifying-one-commit

I do something pretty close to what's described there, except I
generally just cut and paste SHA1's instead of making the temporary tag.

--b.
