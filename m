From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] gitk: Use check-buttons' -text property instead of separate
 labels
Date: Thu, 18 Dec 2008 11:41:36 +0100
Message-ID: <494A28E0.2010009@viscovery.net>
References: <200812022142.16095.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 11:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDGLU-00077w-6A
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 11:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbYLRKlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 05:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbYLRKls
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 05:41:48 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40597 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYLRKlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 05:41:47 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LDGK0-0000zW-Tg; Thu, 18 Dec 2008 11:41:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A56766EF; Thu, 18 Dec 2008 11:41:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <200812022142.16095.j6t@kdbg.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103451>

Johannes Sixt schrieb:
> Previously the check-buttons' labels in the Preferences were separate
> widgets. This had the disadvantage that in order to toggle the check-button
> with the mouse the check-box had to be clicked. With this change the
> check-box can also be toggled by clicking the label.

Did you consider this patch?

-- Hannes

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  gitk |   30 ++++++++++--------------------
>  1 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 64a873d..ee1941c 100755
> --- a/gitk
> +++ b/gitk
> @@ -10079,15 +10079,11 @@ proc doprefs {} {
>  	-font optionfont
>      spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
>      grid x $top.maxpctl $top.maxpct -sticky w
> -    frame $top.showlocal
> -    label $top.showlocal.l -text [mc "Show local changes"] -font optionfont
> -    checkbutton $top.showlocal.b -variable showlocalchanges
> -    pack $top.showlocal.b $top.showlocal.l -side left
> +    checkbutton $top.showlocal -text [mc "Show local changes"] \
> +	-font optionfont -variable showlocalchanges
>      grid x $top.showlocal -sticky w
> -    frame $top.autoselect
> -    label $top.autoselect.l -text [mc "Auto-select SHA1"] -font optionfont
> -    checkbutton $top.autoselect.b -variable autoselect
> -    pack $top.autoselect.b $top.autoselect.l -side left
> +    checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
> +	-font optionfont -variable autoselect
>      grid x $top.autoselect -sticky w
>  
>      label $top.ddisp -text [mc "Diff display options"]
> @@ -10095,20 +10091,14 @@ proc doprefs {} {
>      label $top.tabstopl -text [mc "Tab spacing"] -font optionfont
>      spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
>      grid x $top.tabstopl $top.tabstop -sticky w
> -    frame $top.ntag
> -    label $top.ntag.l -text [mc "Display nearby tags"] -font optionfont
> -    checkbutton $top.ntag.b -variable showneartags
> -    pack $top.ntag.b $top.ntag.l -side left
> +    checkbutton $top.ntag -text [mc "Display nearby tags"] \
> +	-font optionfont -variable showneartags
>      grid x $top.ntag -sticky w
> -    frame $top.ldiff
> -    label $top.ldiff.l -text [mc "Limit diffs to listed paths"] -font optionfont
> -    checkbutton $top.ldiff.b -variable limitdiffs
> -    pack $top.ldiff.b $top.ldiff.l -side left
> +    checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
> +	-font optionfont -variable limitdiffs
>      grid x $top.ldiff -sticky w
> -    frame $top.lattr
> -    label $top.lattr.l -text [mc "Support per-file encodings"] -font optionfont
> -    checkbutton $top.lattr.b -variable perfile_attrs
> -    pack $top.lattr.b $top.lattr.l -side left
> +    checkbutton $top.lattr -text [mc "Support per-file encodings"] \
> +	-font optionfont -variable perfile_attrs
>      grid x $top.lattr -sticky w
>  
>      entry $top.extdifft -textvariable extdifftool


-- 
DI Johannes Sixt
Leiter Softwareentwicklung
Viscovery Software GmbH
Landstrasse 11
A-4020 Linz, Austria

T: +43-1-532 0570-51
M: +43-676-8494 9571
F: +43-1-532 0570-33
j.sixt@viscovery.net
www.viscovery.net

t u r n   y o u r   d a t a   i n t o   r e a l   v a l u e !
