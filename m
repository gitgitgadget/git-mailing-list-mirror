From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: fix multi selected file operation
Date: Sat, 15 Oct 2011 23:48:27 +0100
Message-ID: <87ehydhnwk.fsf@fox.patthoyts.tk>
References: <87cab38f99075f149a9abe7caf4ec139a0a48213.1318580310.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:48:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFD1u-0001hv-Sv
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab1JOWsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:48:30 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:33735 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914Ab1JOWs3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 18:48:29 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015224828.TLZO21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 23:48:28 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RFD1n-0006xj-VG; Sat, 15 Oct 2011 23:48:27 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 42A31207A7; Sat, 15 Oct 2011 23:48:27 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <87cab38f99075f149a9abe7caf4ec139a0a48213.1318580310.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Fri, 14 Oct 2011 10:19:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=dXLFLQziqoYA:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=NLJsFPLGyJZQVHClmqcA:9 a=CjuIK1q_8ugA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183683>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>The current path for what we see the diff is not in the list of selected
>paths. But when we add single paths (with Ctrl) to the set the current path
>would not be used when the action is performed.
>
>Fix this by explicitly putting the path into the list before we start
>showing the diff.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> git-gui.sh |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/git-gui.sh b/git-gui.sh
>index f897160..e5dd8bc 100755
>--- a/git-gui.sh
>+++ b/git-gui.sh
>@@ -2474,6 +2474,7 @@ proc toggle_or_diff {w x y} {
> 				[concat $after [list ui_ready]]
> 		}
> 	} else {
>+		set selected_paths($path) 1
> 		show_diff $path $w $lno
> 	}
> }

It is not clear what I should be looking for to test this. Can you
re-write the commit message to be more clear about what you are
fixing. Is this multiple unstaged files in the staging box? If so I
don't see what path display is changing.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
