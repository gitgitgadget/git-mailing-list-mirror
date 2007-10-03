From: Johan Herland <johan@herland.net>
Subject: [PATCH v2] INSTALL: Update section on external dependencies
Date: Wed, 03 Oct 2007 10:27:48 +0200
Message-ID: <200710031027.48999.johan@herland.net>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
 <7v1wcdjbq6.fsf@gitster.siamese.dyndns.org>
 <20071003074007.GA15339@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Reece Dunn <msclrhd@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 10:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iczae-0001Fv-II
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 10:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbXJCI2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 04:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbXJCI2M
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 04:28:12 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34722 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbXJCI2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 04:28:11 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JPB0060FU6YC000@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 10:28:10 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPB000GBU6D7NC0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 10:27:49 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPB00J3VU6DKRB0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 03 Oct 2007 10:27:49 +0200 (CEST)
In-reply-to: <20071003074007.GA15339@genesis.frugalware.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59806>

Includes:
- Mention dependency on "core" utilities, including coreutils, sed, cut, grep
- Mention dependency on cpio
- Fix up some whitespace and linebreaking issues

Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 03 October 2007, Miklos Vajna wrote:
> On Tue, Oct 02, 2007 at 05:14:25PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Are there other commands we rely on that may not be universally
> > installed?  I myself consider "cut" to be in the category, but
> > other than that I do not think of anything offhand.
> 
> when using git in a chroot, i obviously had coreutils/sed/grep installed
> and the only "extra" package i needed (besides the curl an openssl libs)
> was cpio

Ok, here's a more complete patch.

...Johan


 INSTALL |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/INSTALL b/INSTALL
index 289b046..244470f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -54,6 +54,8 @@ Issues of note:
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries:
 
+	- Common "core" utilities including coreutils, sed, cut, and grep.
+
 	- "zlib", the compression library. Git won't build without it.
 
 	- "openssl".  Unless you specify otherwise, you'll get the SHA1
@@ -63,22 +65,24 @@ Issues of note:
 	  that come with git (git includes the one from Mozilla, and has
 	  its own PowerPC and ARM optimized ones too - see the Makefile).
 
-	- "libcurl" and "curl" executable.  git-http-fetch and
-	  git-fetch use them.  If you do not use http
-	  transfer, you are probably OK if you do not have
-	  them.
+	- "libcurl" and "curl" executable.  git-http-fetch and git-fetch
+	  use them.  If you do not use http transfer, you are probably OK
+	  if you do not have them.
 
 	- expat library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional.
 
-        - "wish", the Tcl/Tk windowing shell is used in gitk to show the
-          history graphically, and in git-gui.
+	- "wish", the Tcl/Tk windowing shell is used in gitk to show the
+	  history graphically, and in git-gui.
 
-	- "ssh" is used to push and pull over the net
+	- "ssh" is used to push and pull over the net.
 
 	- "perl" and POSIX-compliant shells are needed to use most of
 	  the barebone Porcelainish scripts.
 
+	- "cpio" is used by git-merge for saving and restoring the index,
+	  and by git-clone when doing a local (possibly hardlinked) clone.
+
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
-- 
1.5.3.3.1144.gf10f2
