From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: error: refs/remotes/origin/HEAD points nowhere!
Date: Thu, 6 Mar 2008 09:50:44 +0200
Message-ID: <200803060950.44873.tlikonen@iki.fi>
References: <200803051338.44938.tlikonen@iki.fi> <7v7iggn9ts.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 08:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXAtL-0004FO-By
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 08:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbYCFHut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 02:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbYCFHut
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 02:50:49 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:60619 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750940AbYCFHut (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 02:50:49 -0500
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96002BEF0C for git@vger.kernel.org; Thu, 6 Mar 2008 08:50:47 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <7v7iggn9ts.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76352>

Junio C Hamano kirjoitti:

> Teemu Likonen <tlikonen@iki.fi> writes:
> > After a while I start tracking some other remote repository. I do
> > this:
> >
> >   git remote add ng git://project-ng/project.git
> >
> > Then I do "git fetch ng" and probably also "git checkout --track -b
> > master-ng ng/master". Then I find the old "origin" useless to me so
> > I remove it with "git remote rm origin".
> >
> > It seems that refs/remotes/origin/HEAD is still left in my
> > repository and hence I keep getting these annoying error messages
> > all the time.
> >
> > Well, I know how to delete this file, but I believe that git should
> > have deleted it when I called "git remote rm origin". Am I right?
>
> Good analysis.  I would say "git remote rm" should have removed
> it and it would be a bug if it didn't.

Yes, "git remote rm <remote>" certainly doesn't remove the 
refs/remotes/<remote>/HEAD file. I can reproduce this bug anytime with 
current 'master' branch from git://git.kernel.org/pub/scm/git/git.git
