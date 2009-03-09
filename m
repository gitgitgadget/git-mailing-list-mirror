From: Cap Petschulat <cap@naviasystems.com>
Subject: filter-branch --subdirectory-filter prematurely truncating history?
Date: Mon, 9 Mar 2009 23:08:12 +0000 (UTC)
Message-ID: <loom.20090309T230424-857@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:11:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgodD-00086q-LO
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbZCIXKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZCIXKG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:10:06 -0400
Received: from main.gmane.org ([80.91.229.2]:43532 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbZCIXKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:10:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Lgobj-0007QN-2d
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:10:03 +0000
Received: from 69-92-193-253.cpe.cableone.net ([69.92.193.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 23:10:03 +0000
Received: from cap by 69-92-193-253.cpe.cableone.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 23:10:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.92.193.253 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081216 Ubuntu/8.04 (hardy) Firefox/2.0.0.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112752>

I'd like to spin a subdirectory of an existing git repo off in to its
own repo while preserving history. From what I've read, I should be
able to do this with a fresh clone followed by git filter-branch
--subdirectory-filter MYSUBDIR, assuming I don't care about other
branches or tags. This runs, and when it's done, I have a repo that
contains the subdir's contents as its root. So far so good.

I would expect to see the subdir's full history when I run git log,
but instead it cuts off prematurely, showing the first commit to be
some relatively recent minor change I'll call FOO. In gitk, I can see
that history prior to FOO is still around, but FOO has no parents, and
the commit before FOO has no children. In the original repo, FOO's
parent was the merge of a branch which no longer exists, if this
matters.

Am I expecting filter-branch to do something unreasonable? Is there an
easy way to reconnect the orphaned history? Am I using the wrong tool
for the job?
