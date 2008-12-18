From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] gitk: Ensure that "Reset branch" menu entry is enabled
Date: Thu, 18 Dec 2008 11:42:30 +0100
Message-ID: <494A2916.6010405@viscovery.net>
References: <1228308200-28693-1-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 11:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDGMC-0007N3-6I
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 11:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbYLRKmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 05:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYLRKmd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 05:42:33 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45917 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYLRKmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 05:42:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LDGKs-0006GC-Le; Thu, 18 Dec 2008 11:42:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 74D016EF; Thu, 18 Dec 2008 11:42:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1228308200-28693-1-git-send-email-j6t@kdbg.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103452>

Johannes Sixt schrieb:
> Consider this sequence of events:
> 
> 1. Detach HEAD and fire up gitk
> 2. Call the context menu on some commit. Notice that the last menu entry
>    says "Detached HEAD: can't reset" and it is disabled.
> 3. Now checkout some regular branch (e.g. 'master') using the context menu.
> 4. Call the context menu again on some commit.
> 
> Previously, at this point the last menu entry said "Reset master branch
> to here", but it was still disabled. With this fix it is now enabled again.

Did you consider this patch?

-- Hannes

> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  gitk |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitk b/gitk
> index f7f1776..6c4022a 100755
> --- a/gitk
> +++ b/gitk
> @@ -7950,7 +7950,7 @@ proc rowmenu {x y id} {
>      if {$id ne $nullid && $id ne $nullid2} {
>  	set menu $rowctxmenu
>  	if {$mainhead ne {}} {
> -	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead]
> +	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead] -state normal
>  	} else {
>  	    $menu entryconfigure 7 -label [mc "Detached head: can't reset" $mainhead] -state disabled
>  	}
