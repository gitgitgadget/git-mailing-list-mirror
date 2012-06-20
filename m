From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: git-push error handling
Date: Wed, 20 Jun 2012 14:43:04 -0500
Message-ID: <jrt949$o3g$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 21:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQoI-0003g5-9z
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757891Ab2FTTnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:43:23 -0400
Received: from plane.gmane.org ([80.91.229.3]:37930 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab2FTTnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:43:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ShQoA-0003Sd-6h
	for git@vger.kernel.org; Wed, 20 Jun 2012 21:43:18 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 21:43:18 +0200
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 21:43:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200344>

Does git push always return an error to "if [ $? -ne 0 ]" when the push 
fails?  Is this sufficient to verify your git-push worked?  I'm being 
asked to advise on commands to 'verify the canonical repo is in good 
working order' immediately before a push and immediately after a push 
(for total automation).  I'm used to doing pushes manually.  I think 
git-push itself will tell you if there's a problem, and there's no need 
for 'before' and 'after' checks.  Correct?

Very Limited Scope of Context:
We don't do anything special in the push.  We are just fast-forwarding 
the master branch and there is only one branch (master).  (The 
powers-that-be are doing their own change control (ie, file locking) and 
only care to copy files to the worktree of master, git-add, git-commit, 
and git-push to canonical.)  They have created a change control menu 
that only uses git to 'check out' source and to 'commit source' 
automatically via scripts.  They are doing the merges manually and not 
using git for that so there is no 'merging of master' going on as far as 
git is concerned.  They're basically using git to replace cvs in their 
legacy change control so they don't wish to use any git functionality 
like branches, merges, etc, at this time.  I think they are just using 
git checkout, git add, git commit, to say they have put the changes into 
a 'change control repository'.

v/r,
neal
