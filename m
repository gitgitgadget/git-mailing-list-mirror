From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] gitk: Allow displaying time zones from author and commit
 timestamps
Date: Mon, 12 May 2014 07:25:58 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1405120722570.44324@all-night-tool.MIT.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Tim Guirgies <lt.infiltrator@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 12 13:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjoRs-0005ti-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 13:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbaELLbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 07:31:07 -0400
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:64194 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752AbaELLbG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 07:31:06 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 May 2014 07:31:06 EDT
X-AuditID: 12074423-f79916d000000c54-68-5370afcb513c
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.74.03156.BCFA0735; Mon, 12 May 2014 07:26:03 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id s4CBQ2sW024419;
	Mon, 12 May 2014 07:26:02 -0400
Received: from localhost (all-night-tool.mit.edu [18.9.64.12])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s4CBPx3v028088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 May 2014 07:26:00 -0400
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixG6nont6fUGwwfStNhZdV7qZLFZcncNs
	8eqqlsWaI4vZLfqXdrA5sHrsnHWX3ePQ4Q5Gj7m7+hg9Pm+SC2CJ4rJJSc3JLEst0rdL4Mr4
	v38Ga8Fanor2/w9YGxgPcXYxcnJICJhIbF/4kRnCFpO4cG89WxcjF4eQwGwmia9rmpghnI2M
	Et9X7GUFqRIS2M0kcXVjGYjNIqAtsaV1OTuIzSagJjF3w2Qgm4NDREBVYv0FIZAws8AURonL
	7+xAbGGBMIn7r1eBjeEV8JBomLGECcQWFdCV2Ny9lA0iLihxcuYTFoheLYnl07exTGDkm4Uk
	NQtJagEj0ypG2ZTcKt3cxMyc4tRk3eLkxLy81CJdM73czBK91JTSTYzgYHRR3sH456DSIUYB
	DkYlHl4P5oJgIdbEsuLK3EOMkhxMSqK8RcuAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4T04E
	yvGmJFZWpRblw6SkOViUxHnfWlsFCwmkJ5akZqemFqQWwWRlODiUJHg/rQNqFCxKTU+tSMvM
	KUFIM3FwggznARq+C6SGt7ggMbc4Mx0if4pRUUqcVwckIQCSyCjNg+uFJYtXjOJArwjz3gWp
	4gEmGrjuV0CDmYAGW0nngwwuSURISTUwav77ujHQNfXa5a0nNZtfLGq91vFb9ZhlyqIFf3j0
	9y3ce2uun2bb7MUbzTqPnpSTmGLfmP43riEy5JeYtHnLNdvW6znHP4qqLKiWas458/kRj/UX
	nfOz/iR8ZP4haxFzUPXwhY5dV19ZxitbtPuUqN9dbBb2/3RI1uXtJ3fEv3qg0V2Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248699>

Now gitk can be configured to display author and commit dates in their
original timezone, by putting %z into datetimeformat in ~/.gitk.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
Re-sending from 2011:
http://thread.gmane.org/gmane.comp.version-control.git/165286/focus=174786

 gitk | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 90764e8..b4712cd 100755
--- a/gitk
+++ b/gitk
@@ -11575,7 +11575,29 @@ proc prefsok {} {
 proc formatdate {d} {
     global datetimeformat
     if {$d ne {}} {
-	set d [clock format [lindex $d 0] -format $datetimeformat]
+	# If $datetimeformat includes a timezone, display in the
+	# timezone of the argument.  Otherwise, display in local time.
+	if {[string match {*%[zZ]*} $datetimeformat]} {
+	    if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $d 1] -format $datetimeformat]}]} {
+		# Tcl < 8.5 does not support -timezone.  Emulate it by
+		# setting TZ (e.g. TZ=<-0430>+04:30).
+		global env
+		if {[info exists env(TZ)]} {
+		    set savedTZ $env(TZ)
+		}
+		set zone [lindex $d 1]
+		set sign [string map {+ - - +} [string index $zone 0]]
+		set env(TZ) <$zone>$sign[string range $zone 1 2]:[string range $zone 3 4]
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
-- 
2.0.0.rc3
