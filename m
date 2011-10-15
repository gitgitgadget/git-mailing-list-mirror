From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 3/4] git-gui: only except numbers in the goto-line input
Date: Sat, 15 Oct 2011 23:17:08 +0100
Message-ID: <87fwitkihn.fsf@fox.patthoyts.tk>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
	<1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Fries <David@Fries.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCXb-0000o7-U4
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab1JOWRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:17:12 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:2143 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061Ab1JOWRL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 18:17:11 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015221709.QPF8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 23:17:09 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFCXV-0007Fv-Js; Sat, 15 Oct 2011 23:17:09 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id A1C5B207A7; Sat, 15 Oct 2011 23:17:08 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <fbfb3f3ba4db190f8956eea4f78419a1b81573a6.1318513492.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 13 Oct 2011 15:48:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=HG31sXIWwdUA:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=71nCbyPedv0p8z7tY4UA:9 a=aRu4vZfDuHvoHXD7yw0A:7 a=CjuIK1q_8ugA:10 a=psFEWSvwNxIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183678>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/line.tcl |   16 ++++++++++++++--
> 1 files changed, 14 insertions(+), 2 deletions(-)
>
>diff --git a/lib/line.tcl b/lib/line.tcl
>index 692485a..70785e1 100644
>--- a/lib/line.tcl
>+++ b/lib/line.tcl
>@@ -15,7 +15,11 @@ constructor new {i_w i_text args} {
> 
> 	${NS}::frame  $w
> 	${NS}::label  $w.l       -text [mc "Goto Line:"]
>-	entry  $w.ent -textvariable ${__this}::linenum -background lightgreen
>+	entry  $w.ent \
>+		-textvariable ${__this}::linenum \
>+		-background lightgreen \
>+		-validate key \
>+		-validatecommand [cb _validate %P]
> 	${NS}::button $w.bn      -text [mc Go] -command [cb _incrgoto]
> 
> 	pack   $w.l   -side left
>@@ -26,7 +30,7 @@ constructor new {i_w i_text args} {
> 	grid remove $w
> 
> 	bind $w.ent <Return> [cb _incrgoto]
>-	bind $w.ent <Escape> [list linebar::hide $this]
>+	bind $w.ent <Escape> [cb hide]
> 
> 	bind $w <Destroy> [list delete_this $this]
> 	return $this
>@@ -55,6 +59,14 @@ method editor {} {
> 	return $w.ent
> }
> 
>+method _validate {P} {
>+	# only accept numbers as input
>+	if {[regexp {\d*} $P]} {
>+		return 1
>+	}
>+	return 0
>+}
>+
> method _incrgoto {} {
> 	if {$linenum ne {}} {
> 		$ctext see $linenum.0

This one doesn't actually work when I try it it accepts alphanumeric
input. However, replacing the validate body with
  string is integer $P
fixes it to operate as intended so I'll replace it with this.
Looks like it needs theming too but that can be a separate patch.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
