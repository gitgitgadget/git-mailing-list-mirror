From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/5] Fix msvc build
Date: Thu, 31 Jan 2013 18:26:46 +0000
Message-ID: <510AB766.4030806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:38:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z21-0006x1-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3AaSiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:38:18 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48827 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752877Ab3AaSiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:38:17 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 578DC18C710;
	Thu, 31 Jan 2013 18:38:15 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 95F8E18C6FA;	Thu, 31 Jan 2013 18:38:14 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu, 31 Jan 2013 18:38:12 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215142>


As I mentioned recently, while discussing a cygwin specific patch
(see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
MSVC build is broken for me.

The first 4 patches fix the MSVC build for me. The final patch is
not really related to fixing the build, but it removed some make
warnings which were quite irritating ...

Note that I used the Makefile, with the Visual C++ 2008 command
line compiler on Windows XP (SP3), to build a vanilla git on MinGW.
I'm not subscribed to the msysgit mailing list, nor do I follow the
msysgit fork of git, so these patches may conflict with commits in
their repository.

HTH

ATB,
Ramsay Jones

Ramsay Jones (5):
  msvc: Fix compilation errors caused by poll.h emulation
  msvc: git-daemon: Fix linker "unresolved external" errors
  msvc: Fix build by adding missing symbol defines
  msvc: test-svn-fe: Fix linker "unresolved external" error
  msvc: avoid collisions between "tags" and "TAGS"

 compat/msvc.h                     | 2 ++
 compat/vcbuild/include/sys/poll.h | 1 -
 compat/vcbuild/include/unistd.h   | 3 +++
 config.mak.uname                  | 4 +++-
 git-compat-util.h                 | 3 +++
 test-svn-fe.c                     | 2 +-
 6 files changed, 12 insertions(+), 3 deletions(-)
 delete mode 100644 compat/vcbuild/include/sys/poll.h

-- 
1.8.1
