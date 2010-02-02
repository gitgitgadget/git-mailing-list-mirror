From: Yann Dirson <ydirson@altern.org>
Subject: Suggestions for improvement when dealing with remote branch
 shuffling
Date: Tue, 2 Feb 2010 18:11:03 +0100
Message-ID: <20100202171103.GK2725@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 18:08:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcMEv-0000NI-Uk
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 18:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0BBRId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 12:08:33 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:49061 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab0BBRIc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 12:08:32 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 39C379400E1
	for <git@vger.kernel.org>; Tue,  2 Feb 2010 18:08:25 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 596FE9401B7
	for <git@vger.kernel.org>; Tue,  2 Feb 2010 18:08:23 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 008EF1F075; Tue,  2 Feb 2010 18:11:03 +0100 (CET)
Content-Disposition: inline
X-Mailer: MiniG Webmail
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138731>

* it looks like "git remote prune" on any remote may be a good candidate to be
included in "git gc" (although probably only for the candidate refs seeing their
last reflog entry removed)

* when a remote had a "foo/bar" ref in the past, still available locally as
"remotes/origin/foo/bar" because the user did not think about running "remote
prune origin", and a new remote branch named "foo" appears, fetch refuses to
update the local "remotes/origin/foo" ref, but does not give the reason to the
user. OTOH, another user reported fetch suggesting running "remote prune origin"
- but he may have had a slightly different history of fetch runs (seen in
1.6.5.1 msys). Probably this message should also be issued in the 1st case.
