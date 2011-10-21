From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: span widgets over the full file output area in the blame view
Date: Fri, 21 Oct 2011 22:41:43 +0100
Message-ID: <87mxcu3tuw.fsf@fox.patthoyts.tk>
References: <16d7f36e4d24d8816035f934836395e5f854f1d3.1319138993.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 21 23:41:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHMqc-0000SU-JJ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 23:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab1JUVlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 17:41:46 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:32533 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752853Ab1JUVlp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 17:41:45 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111021214144.XNAJ8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 21 Oct 2011 22:41:44 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RHMqW-0003Dq-6e; Fri, 21 Oct 2011 22:41:44 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 9E78B21CC8; Fri, 21 Oct 2011 22:41:43 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <16d7f36e4d24d8816035f934836395e5f854f1d3.1319138993.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 20 Oct 2011 21:30:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=-_pUpEVqvcEA:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=s_7lOklFtrEEBYusOxYA:9 a=XhhgxsrltlIuWNy_eggA:7 a=CjuIK1q_8ugA:10 a=psFEWSvwNxIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184088>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/blame.tcl |    9 ++++++---
> 1 files changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/lib/blame.tcl b/lib/blame.tcl
>index 49eae19..b031e66 100644
>--- a/lib/blame.tcl
>+++ b/lib/blame.tcl
>@@ -219,7 +219,8 @@ constructor new {i_commit i_path i_jump} {
> 	eval grid $w_columns $w.file_pane.out.sby -sticky nsew
> 	grid conf \
> 		$w.file_pane.out.sbx \
>-		-column [expr {[llength $w_columns] - 1}] \
>+		-column 0 \
>+		-columnspan [expr {[llength $w_columns] + 1}] \
> 		-sticky we
> 	grid columnconfigure \
> 		$w.file_pane.out \
>@@ -229,12 +230,14 @@ constructor new {i_commit i_path i_jump} {
> 
> 	set finder [::searchbar::new \
> 		$w.file_pane.out.ff $w_file \
>-		-column [expr {[llength $w_columns] - 1}] \
>+		-column 0 \
>+		-columnspan [expr {[llength $w_columns] + 1}] \
> 		]
> 
> 	set gotoline [::linebar::new \
> 		$w.file_pane.out.lf $w_file \
>-		-column [expr {[llength $w_columns] - 1}] \
>+		-column 0 \
>+		-columnspan [expr {[llength $w_columns] + 1}] \
> 		]
> 
> 	set w_cviewer $w.file_pane.cm.t

Looks good. Applied.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
