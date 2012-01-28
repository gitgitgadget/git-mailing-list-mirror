From: walt <w41ter@gmail.com>
Subject: Bisecting through the middle of a big merge?
Date: Fri, 27 Jan 2012 16:03:20 -0800
Message-ID: <jfve09$ih5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 01:04:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqvm1-0000jg-95
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 01:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552Ab2A1ADl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 19:03:41 -0500
Received: from lo.gmane.org ([80.91.229.12]:46945 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697Ab2A1ADk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 19:03:40 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rqvla-0000aS-TU
	for git@vger.kernel.org; Sat, 28 Jan 2012 01:03:38 +0100
Received: from adsl-69-234-196-147.dsl.irvnca.pacbell.net ([69.234.196.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 01:03:38 +0100
Received: from w41ter by adsl-69-234-196-147.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 01:03:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-196-147.dsl.irvnca.pacbell.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20120106 Thunderbird/9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189246>

My problem is that I lack a good mental model of what git does
when it commits a big merge, and so I get lost when I try to
bisect back through a merge.  (I'm a tester, not a developer.)

This specific recent example is causing me problems:

Merge: b3c9dd1 85a0f7b
Author: Linus Torvalds
Date:   Sun Jan 15 12:48:41 2012 -0800
    Merge branch 'for-3.3/drivers' of git://git.kernel.dk/linux-block

There are many individual commits from Tejun Heo et al included
in that one big commit from Linus.  Unfortunately for me, some of
those commits cause other problems that I'm not trying to bisect;
other problems that evidently get fixed by other commits in the
same big merge.

So I do 'git bisect skip' six or eight times until the 'false' bug
goes away, and that leaves me at the end of the bisect without finding
the individual commit that's causing my 'real' bug.

How do you experts handle this kind of problem?

Thanks for any clues.
