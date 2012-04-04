From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: displaying subtree merges
Date: Wed, 04 Apr 2012 18:36:10 +0200
Message-ID: <4F7C787A.6050905@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFTC4-0002dJ-8d
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 18:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab2DDQgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 12:36:19 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56972 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756905Ab2DDQgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 12:36:19 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SFTBw-0006ud-4i
	for git@vger.kernel.org; Wed, 04 Apr 2012 18:36:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194706>

Hi,
what is the best way to display merge commits of two branches with
separate roots?

systemd and udev projects have merged [1], by a subtree merge of
udev repo into systemd repo [2].

Displaying the commit shows:
% git show 19c5f19 --stat-count=10
commit 19c5f19d69bb5f520fa7213239490c55de06d99d (HEAD)
Merge: 3eff420 4db539b
Author: Kay Sievers <kay.sievers@vrfy.org>
Date:   Tue Apr 3 21:08:04 2012 +0200

    import udev repository

 src/udev/.gitignore  |   40 +
 src/udev/.vimrc      |    4 +
 src/udev/COPYING     |  339 +++
 src/udev/ChangeLog   | 6387 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/udev/INSTALL     |   44 +
 src/udev/Makefile.am |  712 ++++++
 src/udev/NEWS        | 1735 ++++++++++++++
 src/udev/README      |  101 +
 src/udev/TODO        |   22 +
 src/udev/autogen.sh  |   44 +
 ...
 209 files changed, 208701 insertions(+)

ie. only the change to the main repository, as if the everything was
added in this commit.

Also, --follow doesn't really follow:

% git log --oneline --follow -- src/udev/src/udevd.c
3e21478 move imported udev into place

[src/udev/src/udevd.c is the new path]

% git log --oneline --follow -- src/udevd.c
4309599 warn about deprecated RUN+="socket:" use
e64fae5 udevd: kill hanging event processes after 30 seconds
912541b tabs are as useful as a hole in the head
ad29a9f merge udev/, libudev/, systemd/ files in src/; move extras/ to src/
...

[src/udev/src/udevd.c is the original path]

Is there a way to follow the history also in the subtree?

Thanks,
Zbyszek

[1] http://lwn.net/Articles/490413/
[2] http://cgit.freedesktop.org/systemd/systemd/commit/src/udev?id=19c5f19
