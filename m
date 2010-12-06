From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Fix use of renamed tag.
Date: Mon, 06 Dec 2010 21:20:46 +0000
Message-ID: <87ipz6y4wh.fsf@fox.patthoyts.tk>
References: <c24527d4bb9cdc1f72f27c2154d0320ee5579fa1.1291018765.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 22:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiV2-0006Qg-KA
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0LFVV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:21:27 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:47130 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab0LFVV1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 16:21:27 -0500
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PPiUt-0008AS-RR; Mon, 06 Dec 2010 21:21:24 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PPiUJ-0006hh-Is; Mon, 06 Dec 2010 21:20:47 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E5575218F6; Mon,  6 Dec 2010 21:20:46 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <c24527d4bb9cdc1f72f27c2154d0320ee5579fa1.1291018765.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Mon, 29 Nov 2010 09:21:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163024>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>The d======= was renamed to d= in 4590307.
>
>Fix this.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/diff.tcl |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/lib/diff.tcl b/lib/diff.tcl
>index 8fea947..7b1fddf 100644
>--- a/lib/diff.tcl
>+++ b/lib/diff.tcl
>@@ -122,22 +122,22 @@ proc show_unmerged_diff {cont_info} {
> 	if {$merge_stages(2) eq {}} {
> 		set is_conflict_diff 1
> 		lappend current_diff_queue \
>-			[list [mc "LOCAL: deleted\nREMOTE:\n"] d======= \
>+			[list [mc "LOCAL: deleted\nREMOTE:\n"] d= \
> 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
> 	} elseif {$merge_stages(3) eq {}} {
> 		set is_conflict_diff 1
> 		lappend current_diff_queue \
>-			[list [mc "REMOTE: deleted\nLOCAL:\n"] d======= \
>+			[list [mc "REMOTE: deleted\nLOCAL:\n"] d= \
> 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
> 	} elseif {[lindex $merge_stages(1) 0] eq {120000}
> 		|| [lindex $merge_stages(2) 0] eq {120000}
> 		|| [lindex $merge_stages(3) 0] eq {120000}} {
> 		set is_conflict_diff 1
> 		lappend current_diff_queue \
>-			[list [mc "LOCAL:\n"] d======= \
>+			[list [mc "LOCAL:\n"] d= \
> 			    [list ":1:$current_diff_path" ":2:$current_diff_path"]]
> 		lappend current_diff_queue \
>-			[list [mc "REMOTE:\n"] d======= \
>+			[list [mc "REMOTE:\n"] d= \
> 			    [list ":1:$current_diff_path" ":3:$current_diff_path"]]
> 	} else {
> 		start_show_diff $cont_info

Looks correct. Thank you.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
