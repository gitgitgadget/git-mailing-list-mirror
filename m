From: Joe Smith <unknown_kev_cat@hotmail.com>
Subject: Using git-replace to edit a commit message?
Date: Sun, 22 May 2011 22:11:39 +0000 (UTC)
Message-ID: <loom.20110523T001117-737@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 00:15:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOGvn-0004Y0-15
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 00:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab1EVWPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 18:15:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:55301 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755451Ab1EVWPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 18:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QOGvS-0004Nv-LM
	for git@vger.kernel.org; Mon, 23 May 2011 00:15:06 +0200
Received: from 76-243-42-111.lightspeed.cntmoh.sbcglobal.net ([76.243.42.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 May 2011 00:15:06 +0200
Received: from unknown_kev_cat by 76-243-42-111.lightspeed.cntmoh.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 May 2011 00:15:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.243.42.111 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.60 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174202>


A somewhat common question with Git is how to change a commit message of an
already created commit. 

When this question comes up, the most common case is an unpublished commit,
which can safely be corrected by re-writing history.

Occasionally the question is about a published commit. Sometimes even for
published repositories rewriting history is acceptable, but often it is not.
In that case the usual answer is either: there is nothing you can do without
rewriting history, or add a note to the commit.

Is that really true?

It occurs to me that the following procedure should work rather well for
this, as long as it is not a frequent occurrence.

Create a new commit object with the correct text (or correct author,
or correct committer), ensuring that the the listed tree and parent
SHA-1 hashes are correct (i.e. are the same those hashes in the commit
being "edited").

Then simply use git-replace to have all references to the "unedited"
commit instead use this new commit.

Is there some reason that will not work? If it would work, is there
some reason nobody ever seems to suggest it?
