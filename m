From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sun, 22 Jul 2007 03:38:06 -0400
Message-ID: <20070722073806.GW32566@spearce.org>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com> <200707210951.00210.stimming@tuhh.de> <20070721080338.GT32566@spearce.org> <200707211433.29318.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 09:38:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICW1D-0003tD-G3
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 09:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760283AbXGVHiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 03:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760200AbXGVHiO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 03:38:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41218 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900AbXGVHiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 03:38:12 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICW11-0006o9-6U; Sun, 22 Jul 2007 03:38:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2148D20FBAE; Sun, 22 Jul 2007 03:38:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707211433.29318.stimming@tuhh.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53228>

Christian Stimming <stimming@tuhh.de> wrote:
> Subject: [PATCH] Initialize msgcat (gettext).
...
> diff --git a/git-gui.sh b/git-gui.sh
> index c5ff7c8..0c5ca46 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -108,6 +108,12 @@ if {$idx ne {}} {
>  }
>  unset -nocomplain oguirel idx fd
>  
> +## Internationalization (i18n) through msgcat and gettext. See
> +## http://www.gnu.org/software/gettext/manual/html_node/Tcl.html
> +package require msgcat
> +::msgcat::mcload [file join $oguilib msgs]
> +namespace import ::msgcat::mc
> +

Thanks.  We'll probably also want to modify the lib/class.tcl to
import ::msgcat::mc into the class namespace when it creates it.
I use that class thing throught most of git-gui, especially for
UI code.  About 50% of git-gui has been converted to use class,
the other 50% is just global and is still in git-gui.sh.  ;-)

-- 
Shawn.
