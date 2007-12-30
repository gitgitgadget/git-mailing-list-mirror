From: Florian Weimer <fw@deneb.enyo.de>
Subject: git-svn in 1.5.4~rc2 somewhat broken?
Date: Sun, 30 Dec 2007 14:09:28 +0100
Message-ID: <87wsqw49dj.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 14:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8xvR-0001pa-QR
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 14:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbXL3NJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 08:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbXL3NJc
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 08:09:32 -0500
Received: from mail.enyo.de ([212.9.189.167]:1443 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017AbXL3NJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 08:09:32 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1J8xuz-0004ZQ-Na
	for git@vger.kernel.org; Sun, 30 Dec 2007 14:09:29 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1J8xuy-0005OT-Ge
	for git@vger.kernel.org; Sun, 30 Dec 2007 14:09:28 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69359>

I just tried to run "git svn fetch" on a clone of a Subversion
repository that used to work fine with 1.5.3.  After trying to fix some
things up (sorry, scrollback buffer is not deep enough), it now reports
an index mismatch:

Index mismatch: efcc3165fb64519ff1784903112d725c8682d5d2 != b3e7f07b5e4b79f682718fe6a31107d74ca35ce6

And it finally bails out with:

Last fetched revision of refs/remotes/git-svn was r45313, but we are about to fetch: r851!

This doesn't make sense because all paths (both log messages and
.git/config) refer to:

  http://llvm.org/svn/llvm-project/llvm/trunk

And this repository certainly contains revisions after r851.

With other repositories, it also peforms an index rebuild, but succeeds.
