From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Fix semi-working shortcuts for unstage and revert
Date: Mon, 17 Sep 2012 11:47:01 +0100
Message-ID: <87haqxj596.fsf@fox.patthoyts.tk>
References: <1347665801-22634-1-git-send-email-vi0oss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bert.wesarg@googlemail.com
To: vi0oss@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 17 12:47:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDYru-0000jm-99
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 12:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065Ab2IQKrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 06:47:49 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:7806 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755048Ab2IQKrs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 06:47:48 -0400
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.3])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120917104747.XNGT1732.mtaout02-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Mon, 17 Sep 2012 11:47:47 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1TDYr0-00035H-Cr; Mon, 17 Sep 2012 11:47:02 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 83C4722D8F; Mon, 17 Sep 2012 11:47:01 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1347665801-22634-1-git-send-email-vi0oss@gmail.com>
	(vi0oss@gmail.com's message of "Sat, 15 Sep 2012 02:36:41 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=GaEGOwq9FwezmTggA+b6yC6zDZF2HYaK6RN/tSqdnVA= c=1 sm=0 a=O9HYxzjLEG8A:10 a=U-3pZBPxRUYA:10 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=Ja7G19IsQW6iLtDtJ-8A:9 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205671>

vi0oss@gmail.com writes:

>From: Vitaly _Vi Shukela <vi0oss@gmail.com>
>
>Make Ctrl+U for unstaging and Ctrl+J for reverting selection behave
>more like Ctrl+T for adding.
>
>They were working only when one area was focused (diff or commit message),
>now they should work everywhere.
>
>Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
>---
>Sending the patch the third time (haven't got any replies to previous two attempts).
>
> git-gui/git-gui.sh |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index ba4e5c1..6618016 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -3710,6 +3710,8 @@ bind $ui_diff <$M1B-Key-v> {break}
> bind $ui_diff <$M1B-Key-V> {break}
> bind $ui_diff <$M1B-Key-a> {%W tag add sel 0.0 end;break}
> bind $ui_diff <$M1B-Key-A> {%W tag add sel 0.0 end;break}
>+bind $ui_diff <$M1B-Key-j> {do_revert_selection;break}
>+bind $ui_diff <$M1B-Key-J> {do_revert_selection;break}
> bind $ui_diff <Key-Up>     {catch {%W yview scroll -1 units};break}
> bind $ui_diff <Key-Down>   {catch {%W yview scroll  1 units};break}
> bind $ui_diff <Key-Left>   {catch {%W xview scroll -1 units};break}
>@@ -3742,6 +3744,8 @@ bind .   <$M1B-Key-s> do_signoff
> bind .   <$M1B-Key-S> do_signoff
> bind .   <$M1B-Key-t> do_add_selection
> bind .   <$M1B-Key-T> do_add_selection
>+bind .   <$M1B-Key-u> do_unstage_selection
>+bind .   <$M1B-Key-U> do_unstage_selection
> bind .   <$M1B-Key-j> do_revert_selection
> bind .   <$M1B-Key-J> do_revert_selection
> bind .   <$M1B-Key-i> do_add_all

Looks good to me. Applied.

Thank you. 

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
