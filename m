From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/2] git-gui: fetch/prune all entry only for more than one entry
Date: Thu, 24 Feb 2011 00:02:10 +0000
Message-ID: <87fwrefgfx.fsf@fox.patthoyts.tk>
References: <20110212164344.GA19433@book.hvoigt.net>
	<AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
	<20110213134753.GC31986@book.hvoigt.net>
	<20110213135714.GE31986@book.hvoigt.net> <4D640227.9090206@web.de>
	<20110222192835.GA28519@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:02:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOfD-0005rL-Gi
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1BXACb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:02:31 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:49882 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753177Ab1BXACa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 19:02:30 -0500
Received: from [172.23.170.141] (helo=anti-virus02-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PsOf6-0002EK-Ox; Thu, 24 Feb 2011 00:02:28 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PsOep-0005Ds-Lx; Thu, 24 Feb 2011 00:02:11 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 016C32003F; Thu, 24 Feb 2011 00:02:10 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110222192835.GA28519@book.hvoigt.net> (Heiko Voigt's message
	of "Tue, 22 Feb 2011 20:28:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167750>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>In case there is only one remote a fetch/prune all entry
>is redundant.
>
>Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>---
>
>On Tue, Feb 22, 2011 at 07:36:23PM +0100, Jens Lehmann wrote:
>> 1) It would be nice if the new menu entry would only appear when there
>>    is more than one remote to fetch from.
>
>How about this? Disclaimer: Only superficially tested on OSX.
>
> lib/remote.tcl |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/lib/remote.tcl b/lib/remote.tcl
>index 42d2061..18d3d06 100644
>--- a/lib/remote.tcl
>+++ b/lib/remote.tcl
>@@ -237,13 +237,13 @@ proc update_all_remotes_menu_entry {} {
> 
> 	set have_remote 0
> 	foreach r $all_remotes {
>-		set have_remote 1
>+		incr have_remote
> 	}
> 
> 	set remote_m .mbar.remote
> 	set fetch_m $remote_m.fetch
> 	set prune_m $remote_m.prune
>-	if {$have_remote} {
>+	if {$have_remote > 1} {
> 		make_sure_remote_submenues_exist $remote_m
> 		set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
> 		if {[$fetch_m entrycget $index -label] ne "All"} {

This is fine - applied and checked it on Windows.
I'll add a Suggested-by from Jens as this was a response to his request.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
