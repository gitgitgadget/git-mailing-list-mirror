From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/3] Let "stg help" be like "stg --help"
Date: Sun, 22 Oct 2006 15:05:21 +0200
Message-ID: <20061022130520.16449.70729.stgit@localhost>
References: <20061022130214.16449.41482.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:05:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbd1S-0001ZW-4b
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWJVNFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWJVNFZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:05:25 -0400
Received: from mxfep03.bredband.com ([195.54.107.76]:31683 "EHLO
	mxfep03.bredband.com") by vger.kernel.org with ESMTP
	id S1750860AbWJVNFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:05:23 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep03.bredband.com with ESMTP
          id <20061022130521.QWLW18511.mxfep03.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:05:21 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport.bredband.com with ESMTP; 22 Oct 2006 15:05:21 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 1C8394C010;
	Sun, 22 Oct 2006 15:05:21 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022130214.16449.41482.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29737>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

"stg --help" prints the list of commands, but "stg help" just prints
the usage message for the help command. This may be useful in theory,
but the distinction is probably lost on 95% of all users (and the
remaining 5% probably don't need to see the usage message for the help
command anyway, since they know how it works). So just make both
commands output the helpful command list.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/main.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index de35ca8..66128a3 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -226,8 +226,7 @@ def main():
                                   option_list =3D command.options)
             parser.print_help()
         else:
-            print 'usage: %s help <command>' % prog
-
+            print_help()
         sys.exit(0)
     if cmd in ['-v', '--version', 'version']:
         print 'Stacked GIT %s' % version
