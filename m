From: David Kastrup <dak@gnu.org>
Subject: git-rewrite-history behaves quite contrary to documentation
Date: Thu, 09 Aug 2007 13:30:26 +0200
Message-ID: <86abt1j67h.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 13:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ6Dy-0005rb-DU
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 13:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765249AbXHILai (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 07:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765206AbXHILai
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 07:30:38 -0400
Received: from main.gmane.org ([80.91.229.2]:49128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765193AbXHILah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 07:30:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IJ6Dp-0006Na-6T
	for git@vger.kernel.org; Thu, 09 Aug 2007 13:30:33 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 13:30:33 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 13:30:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:81AVPNWxIpmm7uB0cbkAhMFsqY0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55442>


git-filter-branch --index-filter 'git-update-index --force-remove --remove -g bilder bilder3' master trunk
Rewrite a7a8f2fc263256c98ed5220e7467d34584c8c6ac (58/58)
Ref 'refs/heads/master' was rewritten
Ref 'refs/remotes/trunk' was rewritten

These refs were rewritten:
fatal: Not a git repository: '/rep/akspiele/.git-rewrite/t/../../.git'

The manual page, however, claims:


	   git-filter-branch [--env-filter <command>] [--tree-filter <command>]
			 [--index-filter <command>] [--parent-filter <command>]
			 [--msg-filter <command>] [--commit-filter <command>]
			 [--tag-name-filter <command>] [--subdirectory-filter <directory>]
			 [-d <directory>] <new-branch-name> [<rev-list options>...]

<new-branch-name> apparently is completely ignored: specifying a
non-existing branch will not work.

In the examples, it claims:

	   git filter-branch --index-filter 'git update-index --remove filename' newbranch
	Now, you will get the rewritten history saved in the branch
	newbranch (your current branch is left untouched).

This is again wrong: one needs to write "-g" at very least, or it will
not bother removing a file that is not present in the working dir.

Could someone please pass this on to Dscho?  He has me in his killfile.

-- 
David Kastrup
