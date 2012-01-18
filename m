From: "Neal Kreitzinger" <neal@rsss.com>
Subject: post-update to stash after push to non-bare current branch
Date: Wed, 18 Jan 2012 11:53:47 -0600
Message-ID: <jf70vc$kol$1@dough.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:54:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnZi8-0000oE-06
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 18:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401Ab2ARRyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 12:54:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:35740 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932396Ab2ARRyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 12:54:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RnZhx-0000gh-6c
	for git@vger.kernel.org; Wed, 18 Jan 2012 18:54:01 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 18:54:01 +0100
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 18:54:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188751>

We use the worktree of git-repos as the webroot for virtual hosts assigned 
to ports so we can directly test changes to dev and test git-repos.  We have 
some developers who want to develop offline on laptops and push to these 
non-bare repos so they can test their changes.  My plan is to set 
receive.denyCurrentBranch = warn, and then use the post-update hook on the 
remote non-bare to do a stash of the worktree and index.  My assumption is 
that post-update hook only executes after a successful push.  Correct?  I 
only want to stash the non-bare remote work-tree and index after a 
successful push to it (effectively doing a git-reset --hard, but also 
keeping any changes to the worktree/index of the non-bare remote as a safety 
in case someone does directly make uncommitted changes on the non-bare 
remote.)

v/r,
neal 
