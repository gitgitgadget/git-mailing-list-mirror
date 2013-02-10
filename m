From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 09/15] user-manual: Use 'git config --global user.*' for
 setup
Date: Sun, 10 Feb 2013 10:10:35 -0500
Message-ID: <b363f5b410098302a02af2d79b5b68ee79210be2.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZT-0000h4-2k
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab3BJPLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:30 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:36385 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759215Ab3BJPL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:28 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000GSIFIDJO80@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:27 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3A3F5879292; Sun,
 10 Feb 2013 10:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509061; bh=VvbN2icT7ghYr+bE16//mHhU8i2EPG+iHSqbC7vECEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=pb5QHkhdJHgRLq8qZi05U7lAq152IKUFANprfTe+pYhL5S4U9znGIEsLgom836+U/
 sj6VYXgTXB3+YO0ZAf/dAaNblIyeI9pp3Y5n6i6/BKrDsAKltT8fZnSgbNDQflWmZr
 3x3v1ifM13NmPCDUiIacuDdUAHbdlNHNj/sjTrFg=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215911>

From: "W. Trevor King" <wking@tremily.us>

A simple command line call is easier than spawning an editor,
especially for folks new to ideas like the "command line" and "text
editors".  This is also the approach suggested by 'git commit' if you
try and commit without having configured user.name or user.email.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 8bf37b3..e2e0c86 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -991,9 +991,16 @@ Developing with Git
 Telling Git your name
 ---------------------
 
-Before creating any commits, you should introduce yourself to Git.  The
-easiest way to do so is to make sure the following lines appear in a
-file named `.gitconfig` in your home directory:
+Before creating any commits, you should introduce yourself to Git.
+The easiest way to do so is to use linkgit:git-config[1]:
+
+------------------------------------------------
+$ git config --global user.name 'Your Name Comes Here'
+$ git config --global user.email 'you@yourdomain.example.com'
+------------------------------------------------
+
+Which will add the following stanza to a file named `.gitconfig` in
+your home directory:
 
 ------------------------------------------------
 [user]
@@ -1001,8 +1008,9 @@ file named `.gitconfig` in your home directory:
 	email = you@yourdomain.example.com
 ------------------------------------------------
 
-(See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
-details on the configuration file.)
+See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
+details on the configuration file.  The file is plain text, so you can
+also edit it with your favorite editor.
 
 
 [[creating-a-new-repository]]
-- 
1.8.1.336.g94702dd
