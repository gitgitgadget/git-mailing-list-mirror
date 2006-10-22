From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/3] When no command was given, print usage message
Date: Sun, 22 Oct 2006 15:05:26 +0200
Message-ID: <20061022130526.16449.81113.stgit@localhost>
References: <20061022130214.16449.41482.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:05:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbd1S-0001ZW-Ml
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWJVNF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWJVNF3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:05:29 -0400
Received: from mxfep03.bredband.com ([195.54.107.76]:58051 "EHLO
	mxfep03.bredband.com") by vger.kernel.org with ESMTP
	id S1751797AbWJVNF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:05:28 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep03.bredband.com with ESMTP
          id <20061022130526.QWMH18511.mxfep03.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:05:26 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport.bredband.com with ESMTP; 22 Oct 2006 15:05:26 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 66ACB4C010;
	Sun, 22 Oct 2006 15:05:26 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022130214.16449.41482.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29735>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

It's just silly to say "Unknown command" when the user didn't give a
command. Better to tell her to use a command.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/main.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index 66128a3..02d1eb1 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -198,7 +198,7 @@ def main():
     prog =3D os.path.basename(sys.argv[0])
=20
     if len(sys.argv) < 2:
-        print >> sys.stderr, 'Unknown command'
+        print >> sys.stderr, 'usage: %s <command>' % prog
         print >> sys.stderr, \
               '  Try "%s --help" for a list of supported commands' % prog
         sys.exit(1)
