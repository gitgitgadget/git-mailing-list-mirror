From: Tad.Mannes@sita.aero
Subject: synchronization with Subversion
Date: Tue, 7 Aug 2012 16:28:17 -0400
Message-ID: <OFD8B086DC.EB0E996E-ON85257A53.00705446-85257A53.00707425@sita.aero>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 22:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyqOB-0007Xq-Gi
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 22:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab2HGU2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 16:28:22 -0400
Received: from mx4.sita.aero ([57.250.243.9]:51535 "EHLO mx4.sita.aero"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756365Ab2HGU2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 16:28:21 -0400
Received: from atldms02.corp.sita.aero ([57.6.6.41])
	by mx4.sita.aero  with ESMTP id q77KSKwH022740
	for <git@vger.kernel.org>; Tue, 7 Aug 2012 20:28:21 GMT
X-KeepSent: D8B086DC:EB0E996E-85257A53:00705446;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.2 August 04, 2010
X-MIMETrack: Serialize by Router on ATLDMS02/MAIL/SITA/WW(Release 8.5.2FP1 HF35|January
 11, 2011) at 07/08/2012 04:28:20 PM,
	Serialize complete at 07/08/2012 04:28:21 PM,
	Serialize by Router on ATLDMS02/MAIL/SITA/WW(Release 8.5.2FP1 HF35|January
 11, 2011) at 07/08/2012 04:28:21 PM
X-Scanned-By: MIMEDefang 2.64 on 57.250.243.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203044>

Greetings,

we maintain a "central/main" git repository which our developers clone 
from.  We want to synchronize this "central" git repository with 
Subversion.  I know this is not the recommended way to do this, but this 
was the choice that was made.  The "central" git repository was originally 
cloned from Subversion as that was our migration path to git.

Currently I can't get the synchronization to work again after another 
sprint.  I get the following error message:
Unable to determine upstream SVN information from HEAD history.
Perhaps the repository is empty. at /usr/libexec/git-core/git-svn line 
525.
This synchronization has worked a number of times, but now it always fails 
with the above error.

I have read that it's best to have a linear commit history when 
synchronizing to Subversion, and I've read that "git rebase" is the way to 
accomplish this.  I've attempted this, but I run into two problems trying 
to do this:

1. Any files/directories which get moved/renamed cause the rebase to stop 
and I have to tell git to skip the commit, though it appears to me that 
the move/rename actually worked.  I am confused by this behavior, and 
don't understand why it happens at all.

2. There are a number of conflicts which occur during the rebase.  This 
also confuses me.  I think I understand why they happen, but I'm not clear 
about how to handle them.  Our code base goes back many years and contains 
a huge number of commits (originally in CVS, then migrated to Subversion 
and Git).  It isn't obvious what impact the conflict resolution would 
have.  My suspicion, is that it will breed even more conflicts as the 
rebase continues from that point.

As you might have guessed, Subversion is the corporate mandated 
repository, which is why we are attempting to maintain the 
synchronization.  We have a "central" git repository as we want to have 
more control over which changes are accepted.

I'm hoping for some suggestions for dealing with this.  Any takers?

Thnks/Brgds             --Tad
--- 
Tad K. Mannes
Senior Developer
SITA - Societe Internationale de Telecommunications Aeronautiques
