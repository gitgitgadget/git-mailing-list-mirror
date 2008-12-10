From: Tim Olsen <tim@brooklynpenguin.com>
Subject: fatal output from git-show really wants a terminal
Date: Wed, 10 Dec 2008 11:01:49 -0500
Message-ID: <ghop5d$qud$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 17:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LARX5-0002SC-9Q
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 17:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbYLJQCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 11:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbYLJQCG
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 11:02:06 -0500
Received: from main.gmane.org ([80.91.229.2]:59444 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbYLJQCF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 11:02:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LARVc-000391-V4
	for git@vger.kernel.org; Wed, 10 Dec 2008 16:01:56 +0000
Received: from cyrus.limewire.com ([76.8.67.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:01:56 +0000
Received: from tim by cyrus.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 16:01:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cyrus.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102695>

It appears that when outputting a fatal error, git-show will choose
stdout over stderr if stdout is a terminal and stderr is not.  How do I
redirect the error but still allow stdout to be displayed?

~/git$ mkdir test

~/git$ cd test

~/git/test$ git init

~/git/test$ git show 12345

fatal: ambiguous argument '12345': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

~/git/test$ git show 12345 2> /dev/null

fatal: ambiguous argument '12345': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

~/git/test$ git show 12345 > /dev/null

fatal: ambiguous argument '12345': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

~/git/test$ git show 12345 > /dev/null 2> /dev/null

~/git/test$ git show 12345 > /tmp/out 2> /tmp/err

~/git/test$ cat /tmp/out

~/git/test$ cat /tmp/err

fatal: ambiguous argument '12345': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions
