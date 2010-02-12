From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 14:41:47 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-0EA861.14414712022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> <ron1-62D136.13570812022010@news.gmane.org> <7v1vgqksoz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 23:45:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng4GU-0007z6-1t
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757853Ab0BLWpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:45:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:33707 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757648Ab0BLWpI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:45:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng4G1-0007gC-LX
	for git@vger.kernel.org; Fri, 12 Feb 2010 23:45:05 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:45:05 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:45:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139761>

In article <7v1vgqksoz.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> >> Or if a series of commits seem to have gone bad:
> >> 
> >> git commit -a -m "Well, that didn't work."
> >> git branch failed-experiment
> >> git reset --hard origin/master # or other good state
> >> 
> >> You can of course replace the -a to commit with the needed "git add 
> >> <file>" 
> >> commands and leave off the -m to leave real messages about why it went bad 
> >> using $EDITOR.
> >
> > That would require a separate branch for every snapshot, no?  I want 
> > this to be lightweight.  It's not so much the creation of a zillion 
> > branches that bothers me, but having to come up with a new name every 
> > time would be a real hassle.
> 
> Perhaps "stash"?
> 
> Usually stash is used to store "diff between stash@{N}^1 and stash@{N}",
> and "stash pop" or "stash apply" are geared toward that usage.  But you
> can use it as a way to keep snapshots.  You would be interacting with
> the stash differently, though.  E.g.
> 
> 	git diff stash@{4}
> 	git diff origin/master stash@{2}
> 	git checkout stash -- Makefile

No, I don't really want to usurp the stash for this.  But I think a 
separate disjoint branch (with an empty root) will work.  I think I can 
use git checkout to move the files back and forth between the main 
branch and the snapshot branch without causing merge problems if the 
snapshot branch is disjoint.

rg
