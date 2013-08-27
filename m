From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: right half window is paned
Date: Tue, 27 Aug 2013 10:32:48 +0100
Message-ID: <878uznqy0v.fsf@fox.patthoyts.tk>
References: <20130821032913.GA6092@wheezy.local>
	<20130821033822.GB6156@wheezy.local>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 11:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEFjP-00077v-3w
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 11:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab3H0Jib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 05:38:31 -0400
Received: from know-smtprelay-omc-3.server.virginmedia.net ([80.0.253.67]:35104
	"EHLO know-smtprelay-omc-3.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab3H0Jia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 05:38:30 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2013 05:37:42 EDT
Received: from fox.patthoyts.tk ([94.171.229.22])
	by know-smtprelay-3-imp with bizsmtp
	id HlYo1m00M0VeUS601lYo57; Tue, 27 Aug 2013 10:32:49 +0100
X-Originating-IP: [94.171.229.22]
X-Spam: 0
X-Authority: v=2.0 cv=LIo+2+q9 c=1 sm=1 a=qXJDgLqI18Q8M6O+O33hhA==:17
 a=F0HhOJWMmYsA:10 a=d4B-q0BNRzYA:10 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10
 a=FP58Ms26AAAA:8 a=aIad3F3rmXoA:10 a=xwstyAmMAAAA:8 a=Rf460ibiAAAA:8
 a=pVKYm2HTLutxoYDc6wYA:9 a=CjuIK1q_8ugA:10 a=VtOIwHTqQ30A:10
 a=qXJDgLqI18Q8M6O+O33hhA==:117
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id BF4D8214F0; Tue, 27 Aug 2013 10:32:48 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <20130821033822.GB6156@wheezy.local> (Max Kirillov's message of
	"Wed, 21 Aug 2013 06:38:40 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233081>

Max Kirillov <max@max630.net> writes:

>For long descriptions it would be nice to be able to resize
>the comment text field.
>
>Signed-off-by: Max Kirillov <max@max630.net>
>---
> git-gui/git-gui.sh | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
>
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index 89f636f..e2e710e 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -3196,13 +3196,19 @@ unset i
> 
> # -- Diff and Commit Area
> #
>-${NS}::frame .vpane.lower -height 300 -width 400
>+${NS}::panedwindow .vpane.lower -orient vertical
> ${NS}::frame .vpane.lower.commarea
>-${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1
>-pack .vpane.lower.diff -fill both -expand 1
>-pack .vpane.lower.commarea -side bottom -fill x
>+${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height 500
>+.vpane.lower add .vpane.lower.diff
>+.vpane.lower add .vpane.lower.commarea
> .vpane add .vpane.lower
>-if {!$use_ttk} {.vpane paneconfigure .vpane.lower -sticky nsew}
>+if {$use_ttk} {
>+	.vpane.lower pane .vpane.lower.diff -weight 1
>+	.vpane.lower pane .vpane.lower.commarea -weight 0
>+} else {
>+	.vpane.lower paneconfigure .vpane.lower.diff -stretch always
>+	.vpane.lower paneconfigure .vpane.lower.commarea -stretch never
>+}
> 
> # -- Commit Area Buttons
> #

Also fine and applied. Thank you.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
