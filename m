From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH v2 3/3] gitk: Allow displaying time zones from author and
 commit timestamps
Date: Sun, 29 May 2011 23:06:34 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1105292305390.23145@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu> <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu> <20110529044656.GA8881@brick.ozlabs.ibm.com> <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 30 05:11:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQstK-0003AN-Dp
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 05:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab1E3DLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 23:11:37 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:55173 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929Ab1E3DLh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 23:11:37 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 May 2011 23:11:36 EDT
X-AuditID: 12074422-b7b0eae000007f48-78-4de309be232c
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 47.C5.32584.EB903ED4; Sun, 29 May 2011 23:06:38 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p4U36ZH7008061;
	Sun, 29 May 2011 23:06:35 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p4U36Yb5025622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 29 May 2011 23:06:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1105291740410.23145@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixG6nrruP87Gvwc23ihZdV7qZLNYcWczu
	wOQxd1cfo8fnTXIBTFFcNimpOZllqUX6dglcGVte7WYpWMNd8eRTG3sDYzdnFyMnh4SAicTk
	xj5WCFtM4sK99WxdjFwcQgL7GCU6vu6GcjYwSkw6cYQRwtnDJLFrwlM2kBYWAW2JpUfeMILY
	bAJqEnM3TGbvYuTgEBFQlVh/QQgkzCwgLrFp+RsmEFtYIFbiyOsbTCAlnAJOEpu2S4GEeQUc
	JfbPv8EOMf4Wo8TD5wfBLhIV0JXY3L2UDaJIUOLkzCcsEDPVJQ58usgIYWtL3L/ZxjaBUXAW
	krJZSMpmISlbwMi8ilE2JbdKNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQTIzh8XZR2MP48
	qHSIUYCDUYmH17joka8Qa2JZcWXuIUZJDiYlUd4Gjse+QnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR41X8BlfOmJFZWpRblw6SkOViUxHnnSKr7CgmkJ5akZqemFqQWwWRlODiUJHhPggwVLEpN
	T61Iy8wpQUgzcXCCDOcBGt4EUsNbXJCYW5yZDpE/xagoJc7LCEwQQgIgiYzSPLheWHp5xSgO
	9Iow7w+Qdh5gaoLrfgU0mAlocO+7hyCDSxIRUlINjBotpwSuTpM71MF4W0DhkPOc1JVBC3zK
	72TNb+AtOhSy+Wn37UO8Bw2vF6iGZMSfNvyqoOyW2xx0c8Uav8M3Gg4vEDjzZs3MixXmOosi
	o1/eeLrxm57UpXqOBdt9uNduW730ucT57Z+mSKc3GLi/D3r5arP4wfonomvaOg79 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174714>

Now gitk can be configured to display author and commit dates in their
original timezone, by putting %z into datetimeformat in ~/.gitk.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 8e15572..c77771e 100755
--- a/gitk
+++ b/gitk
@@ -11021,7 +11021,23 @@ proc prefsok {} {
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
+		# setting TZ=3DUnknown=C2=B1NNNN.
+		global env
+		catch {set savedTZ $env(TZ)}
+		set zone [lindex $d 1]
+		set sign [string map {+ - - +} [string index $zone 0]]
+		set env(TZ) Unknown$sign[string range $zone 1 2]:[string range $zone=
 3 4]
+		set d [clock format [lindex $d 0] -format $datetimeformat]
+		if {[catch {set env(TZ) $savedTZ}]} {unset env(TZ)}
+	    }
+	} else {
+	    set d [clock format [lindex $d 0] -format $datetimeformat]
+	}
     }
     return $d
 }
--=20
1.7.5.3
