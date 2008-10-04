From: Ed Avis <eda@waniasset.com>
Subject: Build bug report: 'make check' needs sparse, but configure doesn't check it
Date: Sat, 4 Oct 2008 13:19:56 +0000 (UTC)
Message-ID: <loom.20081004T131652-828@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 15:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Km79J-0002Uq-KA
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 15:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYJDNZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 09:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbYJDNZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 09:25:09 -0400
Received: from main.gmane.org ([80.91.229.2]:33010 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbYJDNZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 09:25:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Km782-0006eP-Nf
	for git@vger.kernel.org; Sat, 04 Oct 2008 13:25:02 +0000
Received: from dsl-217-155-72-22.zen.co.uk ([217.155.72.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 13:25:02 +0000
Received: from eda by dsl-217-155-72-22.zen.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 13:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.155.72.22 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.2) Gecko/2008092318 Fedora/3.0.2-1.fc9 Firefox/3.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97469>

When you build git-1.6.0.2 and 'make check', it tries to run sparse and fails if
sparse is not there.  But the configure script does not check sparse is
installed.

I suggest that 'make check' skip the sparse tests if sparse is not there.  As I
understand it, they are really more for the developers to get a report of
possible errors in the source code and not to test that the built executables
work, so it would not be dangerous to just skip running those tests for ordinary
users who don't have the tool.

Alternatively, if running sparse is really important for a thorough 'make
check', the configure script should check for it and warn you to install it.

-- 
Ed Avis <ed@membled.com>
