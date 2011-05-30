From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH v3 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Mon, 30 May 2011 17:47:58 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1105301745580.23145@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu> <20110529044656.GA8881@brick.ozlabs.ibm.com> <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu> <alpine.DEB.2.02.1105292305390.23145@dr-wily.mit.edu>
 <m2sjrw9e21.fsf@igel.home> <alpine.DEB.2.02.1105301739290.23145@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Tim Guirgies <lt.infiltrator@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 30 23:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRAKD-0003ch-0X
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 23:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab1E3VsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 17:48:08 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:63644 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752655Ab1E3VsG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 17:48:06 -0400
X-AuditID: 1209190f-b7c4dae0000007bd-ae-4de41097fdbf
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A4.3D.01981.79014ED4; Mon, 30 May 2011 17:48:07 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p4ULm0Tk029266;
	Mon, 30 May 2011 17:48:00 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p4ULlwUa024090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2011 17:47:59 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1105301739290.23145@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYrdT150u8MTX4O9mA4uuK91MFiuuzmG2
	eHVVy2LNkcXsFv1LO9gcWD12zrrL7nHocAejx9xdfYwenzfJBbBEcdmkpOZklqUW6dslcGX8
	XbiFrWAuT8X8v5tZGhjvcXYxcnJICJhINH9cyQZhi0lcuLceyObiEBLYxyhx988GFghnA6NE
	y4fHUJk9TBK9G36ygLSwCGhLXN98D8xmE1CTmLthMnsXIweHiICqxPoLQiD1zAJzGSUmd/xm
	BKkRFoiVeP97ISuIzSngJDH77RYmkHpeAUeJr/syQMJCAo+ZJDqWmoLYogK6Epu7l4Jdxysg
	KHFy5hOwVcwC6hIHPl1khLC1Je7fbGObwCg4C0nZLCRls5CULWBkXsUom5JbpZubmJlTnJqs
	W5ycmJeXWqRropebWaKXmlK6iREU7pyS/DsYvx1UOsQowMGoxMObcPCxrxBrYllxZe4hRkkO
	JiVR3h7+J75CfEn5KZUZicUZ8UWlOanFhxglOJiVRHi/8QHleFMSK6tSi/JhUtIcLErivLMk
	1X2FBNITS1KzU1MLUotgsjIcHEoSvBNBhgoWpaanVqRl5pQgpJk4OEGG8wANDwKp4S0uSMwt
	zkyHyJ9iVJQS5z0PkhAASWSU5sH1wtLRK0ZxoFeEeQ+BVPEAUxlc9yugwUxAg3vfPQQZXJKI
	kJJqYPSNklHqOm5gK7aWX/eez4oKtsnxio+WZFtl3NWoUAm6/OPg0rkJwpseuR3el/uoInWH
	t2ft/cXn2UpmzQs4cvPqmswpln822rxbMbnu1Hof0Qlbb8y6Ne91zvYft14a1zXW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174781>

Now gitk can be configured to display author and commit dates in their
original timezone, by putting %z into datetimeformat in ~/.gitk.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 8e15572..6a4c8ed 100755
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
+		# setting TZ=3DUnknown=C2=B1NN:NN.
+		global env
+		if {[info exists env(TZ)]} {
+		    set savedTZ $env(TZ)
+		}
+		set zone [lindex $d 1]
+		set sign [string map {+ - - +} [string index $zone 0]]
+		set env(TZ) Unknown$sign[string range $zone 1 2]:[string range $zone=
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
