From: Ingo Molnar <mingo@elte.hu>
Subject: error: Unable to append to .git/logs/refs/remotes/origin/master:
	Permission denied
Date: Tue, 28 Apr 2009 09:31:38 +0200
Message-ID: <20090428073138.GA9094@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 09:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyhnJ-0002iy-Bh
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 09:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902AbZD1Hbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 03:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZD1Hbu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 03:31:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:60412 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbZD1Hbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 03:31:50 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1Lyhn3-00048a-1K
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Tue, 28 Apr 2009 09:31:48 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id B0F233E2138; Tue, 28 Apr 2009 09:31:39 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0005]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117751>


I had a portion of a repo owned by root accidentally, and the next 
time i pulled as user mingo Git gave me this warning and suggestion:

 aldebaran:~/git> git pull
 error: Unable to append to .git/logs/refs/remotes/origin/master: Permission denied
 From e2:git
  ! 66996ec..95110d7  master     -> origin/master  (unable to update local ref)
  * [new tag]         v1.6.3-rc2 -> v1.6.3-rc2
 error: some local refs could not be updated; try running
  'git remote prune origin' to remove any old, conflicting branches

Obviousy Git cannot update the ref there so the failure is OK, but 
the git-remote advice it gives is confusing IMHO: the 'git remote 
prune origin' cannot fix anything. (and it is clear from the fetch 
permission failure that there's no chance to fix anything here.)

I suspect there are other, more typical failure modes where that 
advice is useful - just wanted to point out that it's confusing 
here.

	Ingo
