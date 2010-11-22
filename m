From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: fix browsers [Up To Parent] in sub-sub-directories.
Date: Mon, 22 Nov 2010 21:58:06 +0000
Message-ID: <87vd3pf2c1.fsf@fox.patthoyts.tk>
References: <1290199429-30421-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 03:17:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKiRn-0001FH-K9
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 03:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab0KWCRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 21:17:23 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58037 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863Ab0KWCRW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Nov 2010 21:17:22 -0500
Received: from [172.23.144.245] (helo=asmtp-out1.blueyonder.co.uk)
	by smtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PKiRS-0005js-QF; Tue, 23 Nov 2010 02:17:11 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PKeOl-00034F-79; Mon, 22 Nov 2010 21:58:07 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 8FFAD20880; Mon, 22 Nov 2010 21:58:06 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1290199429-30421-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Fri, 19 Nov 2010 21:43:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161923>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>browser_path used to end with a slash, so the regexp matches the empty string
>and therefore removes nothing.
>
>Fix this.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
>---
> git-gui/lib/browser.tcl |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/git-gui/lib/browser.tcl b/git-gui/lib/browser.tcl
>index c241572..a8c6223 100644
>--- a/git-gui/lib/browser.tcl
>+++ b/git-gui/lib/browser.tcl
>@@ -121,7 +121,7 @@ method _parent {} {
> 		if {$browser_stack eq {}} {
> 			regsub {:.*$} $browser_path {:} browser_path
> 		} else {
>-			regsub {/[^/]+$} $browser_path {} browser_path
>+			regsub {/[^/]+/$} $browser_path {/} browser_path
> 		}
> 		set browser_status [mc "Loading %s..." $browser_path]
> 		_ls $this [lindex $parent 0] [lindex $parent 1]

Thanks - applied to git-gui master.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
