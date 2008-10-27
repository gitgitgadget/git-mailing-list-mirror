From: Hannu Koivisto <azure@iki.fi>
Subject: Gitk/Cygwin bug: phony local changes
Date: Mon, 27 Oct 2008 17:22:52 +0200
Organization: NOYB
Message-ID: <83bpx62hbn.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 16:24:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuTx7-0005xU-GO
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 16:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYJ0PXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYJ0PXG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 11:23:06 -0400
Received: from main.gmane.org ([80.91.229.2]:57485 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbYJ0PXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 11:23:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KuTvo-0002cF-1c
	for git@vger.kernel.org; Mon, 27 Oct 2008 15:23:00 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 15:23:00 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 15:23:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:MomSZ9ttUQsYtPrNRbOVLERjVq4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99238>

Greetings,

git clone git://git.kernel.org/pub/scm/git/git.git
cd git
gitk

with Cygwin build of git version 1.6.0.3.523.g304d0 in Windows XP
SP2 with Cygwin dll version 1.5.24 results to gitk showing "Local
uncommitted changes, not checked in to index" entry in the history
tree and if I select that entry, it seems to indicate that all
files have changed but without any actual content changes.

git status doesn't show any changes.

If I run git diff (which displays no changes) or git reset and then
run gitk again, there is no longer that "Local uncommitted
changes..." entry.

Since it was suggested on #irc, I tried "git config --global
core.trustctime false" but that didn't help, which I suppose was
expected since the documentation talks about differences between
the index and the working copy and I haven't added anything to the
index.

I can reproduce this problem with another (private) repository as
well.

-- 
Hannu
