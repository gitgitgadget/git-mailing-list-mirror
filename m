From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH v4 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Mon, 30 May 2011 18:41:50 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1105301838300.23145@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <m3mxi4yco5.fsf@localhost.localdomain> <20110530061757.GC3723@Imperial-SD-Longsword> <201105300829.52619.jnareb@gmail.com> <alpine.DEB.2.02.1105301717520.23145@dr-wily.mit.edu>
 <m21uzfal5i.fsf@igel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tim Guirgies <lt.infiltrator@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:42:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRB9r-0000hq-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 00:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab1E3Wlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 18:41:55 -0400
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:46625 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754965Ab1E3Wly convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 18:41:54 -0400
X-AuditID: 12074424-b7bc6ae000005a77-a9-4de41d31cfef
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 69.6C.23159.13D14ED4; Mon, 30 May 2011 18:41:53 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p4UMfqnq024778;
	Mon, 30 May 2011 18:41:52 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p4UMfotE028962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2011 18:41:51 -0400 (EDT)
In-Reply-To: <m21uzfal5i.fsf@igel.home>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixCmqrWso+8TX4PBZFYuuK91MFiuuzmG2
	eHVVy2LNkcXsFv1LO9gcWD12zrrL7nHocAejx9xdfYwenzfJBbBEcdmkpOZklqUW6dslcGXs
	PXOPueAHb8XMV72sDYzd3F2MnBwSAiYSH2fPZ4ewxSQu3FvPBmILCexjlJj2Q6GLkQvI3sAo
	ceb+BWYIZw+TxJ4z/xlBqlgEtCUubV4L1s0moCYxd8NkMFtEQEuiZ+JEsEnMAv2MEk2v40Fs
	YYFYiZW397KA2JwC6hI75mwFq+cVcJQ4uvwdG8SCfiaJ6cfWsIIkRAV0JTZ3L2WDKBKUODnz
	CQvEUHWJA58uMkLY2hL3b7axTWAUnIWkbBaSsllIyhYwMq9ilE3JrdLNTczMKU5N1i1OTszL
	Sy3SNdfLzSzRS00p3cQICnh2F5UdjM2HlA4xCnAwKvHwphx87CvEmlhWXJl7iFGSg0lJlLdP
	+omvEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeb3xAOd6UxMqq1KJ8mJQ0B4uSOO88SXVfIYH0
	xJLU7NTUgtQimKwMB4eSBK+dDFCjYFFqempFWmZOCUKaiYMTZDgP0PA2kMW8xQWJucWZ6RD5
	U4yKUuK8ziDNAiCJjNI8uF5YQnrFKA70ijCvAUgVDzCZwXW/AhrMBDS4991DkMEliQgpqQbG
	6VPzb1TYGpfMutL1K67lzJGL2xQXK5mZKD9aNfOOqbL882UW3MmBx0N/NEd0TEw5VKt7Qsvn
	6p5/P5YbfP4ss72i1mUFk+eZQxN99F5V5bOsa6vpXcfQ7/Ow4HFam751XoKmTnam 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174786>

Now gitk can be configured to display author and commit dates in their
original timezone, by putting %z into datetimeformat in ~/.gitk.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
On Tue, 31 May 2011, Andreas Schwab wrote:
> POSIX defines the form TZ=3D"<-0430>+04:30" where <...> can contain a=
ny
> character from [a-zA-Z0-9+-].

Oh hey, it does!  Let=E2=80=99s use that then.

Anders

 gitk |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 8e15572..ca3aa54 100755
--- a/gitk
+++ b/gitk
@@ -11021,7 +11021,29 @@ proc prefsok {} {
 proc formatdate {d} {
     global datetimeformat
     if {$d ne {}} {
-	set d [clock format [lindex $d 0] -format $datetimeformat]
+	# If $datetimeformat includes a timezone, display in the
+	# timezone of the argument.  Otherwise, display in local time.
+	if {[string match {*%[zZ]*} $datetimeformat]} {
+	    if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $=
d 1] -format $datetimeformat]}]} {
+		# Tcl < 8.5 does not support -timezone.  Emulate it by
+		# setting TZ (e.g. TZ=3D<-0430>+04:30).
+		global env
+		if {[info exists env(TZ)]} {
+		    set savedTZ $env(TZ)
+		}
+		set zone [lindex $d 1]
+		set sign [string map {+ - - +} [string index $zone 0]]
+		set env(TZ) <$zone>$sign[string range $zone 1 2]:[string range $zone=
 3 4]
+		set d [clock format [lindex $d 0] -format $datetimeformat]
+		if {[info exists savedTZ]} {
+		    set env(TZ) $savedTZ
+		} else {
+		    unset env(TZ)
+		}
+	    }
+	} else {
+	    set d [clock format [lindex $d 0] -format $datetimeformat]
+	}
     }
     return $d
 }
--=20
1.7.5.3
