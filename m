From: walt <w41ter@gmail.com>
Subject: Recent annoying problem with Linus's git repository?
Date: Sun, 11 Jan 2009 16:42:51 -0800
Message-ID: <alpine.LNX.2.00.0901111615500.4963@x9.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 01:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMAvH-0004eL-GS
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 01:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbZALAnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 19:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbZALAnL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 19:43:11 -0500
Received: from main.gmane.org ([80.91.229.2]:39200 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbZALAnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 19:43:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMAtU-00070s-7e
	for git@vger.kernel.org; Mon, 12 Jan 2009 00:43:04 +0000
Received: from adsl-69-234-212-7.dsl.irvnca.pacbell.net ([69.234.212.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 00:43:04 +0000
Received: from w41ter by adsl-69-234-212-7.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 00:43:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-212-7.dsl.irvnca.pacbell.net
User-Agent: Alpine 2.00 (LNX 1169 2008-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105262>

I've been tracking Junio's git.git and Linus's kernel.git for ages,
and just in the last two weeks or so I've been having a recurring
problem with the file "arch/arm/mach-integrator/clock.h" from Linus.

Any time I check out an old kernel version (e.g. during a bisect)
and then do a "checkout master" when I'm done fiddling, git thinks
my repository is "dirty".

This is the reason for my impurity:

# git status
# On branch master
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    arch/arm/mach-integrator/clock.h

It's always that same damned clock.h that remains in my working
directory after doing the "checkout master" but it shouldn't be
there -- it has indeed been deleted from branch master.

When I then do a "git reset --hard" I Am Purified! and no longer
considered dirty.  But why should that extra reset step be needed?

Only that one file is involved in this recurring annoyance.  Can
anyone figure out why, or at least reproduce the problem?

Thanks!
