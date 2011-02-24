From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/2] git-gui: fetch/prune all entry appears last
Date: Thu, 24 Feb 2011 00:09:28 +0000
Message-ID: <87bp22fg3r.fsf@fox.patthoyts.tk>
References: <20110212164344.GA19433@book.hvoigt.net>
	<AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
	<20110213134753.GC31986@book.hvoigt.net>
	<20110213135714.GE31986@book.hvoigt.net> <4D640227.9090206@web.de>
	<20110222193021.GB28519@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 01:09:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOm9-00014S-Jj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 01:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab1BXAJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 19:09:40 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:48507 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753629Ab1BXAJj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 19:09:39 -0500
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PsOm2-0001OW-2J; Thu, 24 Feb 2011 00:09:38 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PsOls-00044D-FX; Thu, 24 Feb 2011 00:09:28 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2AD5220918; Thu, 24 Feb 2011 00:09:28 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <20110222193021.GB28519@book.hvoigt.net> (Heiko Voigt's message
	of "Tue, 22 Feb 2011 20:30:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167752>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>The user might have got used to the order the remotes appeared previously.
>Lets add the all entry last so the all entry does not confuse previous
>users.
>
>Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>---
>
>On Tue, Feb 22, 2011 at 07:36:23PM +0100, Jens Lehmann wrote:
>> 2) I would rather like to see it at the *end* of the submenu, not at the
>>    beginning. Being used to always click on the first menu entry only
>>    to learn that the remote that used to be there got with something
>>    else is kind of surprising ;-)
>
>And this? Disclaimer: Also only superficially tested on OSX.
>
> lib/remote.tcl |   22 ++++++++++------------
> 1 files changed, 10 insertions(+), 12 deletions(-)
>
>diff --git a/lib/remote.tcl b/lib/remote.tcl
>index 18d3d06..5e4e7f4 100644
>--- a/lib/remote.tcl
>+++ b/lib/remote.tcl
>@@ -245,29 +245,27 @@ proc update_all_remotes_menu_entry {} {
> 	set prune_m $remote_m.prune
> 	if {$have_remote > 1} {
> 		make_sure_remote_submenues_exist $remote_m
>-		set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
>-		if {[$fetch_m entrycget $index -label] ne "All"} {
>+		if {[$fetch_m entrycget end -label] ne "All"} {
> 
>-			$fetch_m insert $index separator
>-			$fetch_m insert $index command \
>+			$fetch_m insert end separator
>+			$fetch_m insert end command \
> 				-label "All" \
> 				-command fetch_from_all
> 
>-			$prune_m insert $index separator
>-			$prune_m insert $index command \
>+			$prune_m insert end separator
>+			$prune_m insert end command \
> 				-label "All" \
> 				-command prune_from_all
> 		}
> 	} else {
> 		if {[winfo exists $fetch_m]} {
>-			set index [expr {[$fetch_m type 0] eq "tearoff" ? 1 : 0}]
>-			if {[$fetch_m type end] eq "separator"} {
>+			if {[$fetch_m entrycget end -label] eq "All"} {
> 
>-				delete_from_menu $fetch_m $index
>-				delete_from_menu $fetch_m $index
>+				delete_from_menu $fetch_m end
>+				delete_from_menu $fetch_m end
> 
>-				delete_from_menu $prune_m $index
>-				delete_from_menu $prune_m $index
>+				delete_from_menu $prune_m end
>+				delete_from_menu $prune_m end
> 			}
> 		}
> 	}

This is fine as well. Tested it on windows. Applied to master.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
