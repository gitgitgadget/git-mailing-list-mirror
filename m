From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Wed, 8 Aug 2007 21:31:30 +0200
Message-ID: <20070808193130.GC27470@xp.machine.xx>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:31:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrFm-0000Gw-Kc
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760179AbXHHTbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760718AbXHHTbb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:31:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:33991 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757669AbXHHTba (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:31:30 -0400
Received: (qmail invoked by alias); 08 Aug 2007 19:31:28 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp058) with SMTP; 08 Aug 2007 21:31:28 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+M+e8YL1WMDTupv5lmp+0X+aD7tUnrdpthQHSZ1H
	VTYxlAPh++GrHW
Mail-Followup-To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>,
	Git Mailing List <git@vger.kernel.org>, paulus@samba.org
Content-Disposition: inline
In-Reply-To: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55341>

On Wed, Aug 08, 2007 at 02:33:48PM -0400, Alexandre Bourget wrote:
> ---
> Adds a context menu for commits, so that a 'rebase' can be done.
> 
> Optionally, it will ask if you want to 'stash' current work before doing so.
> 
> TODO: better error handling.
> 
[...long patch ...]
> +    # TODO: error handling.
> +    exec git rebase $id
> +
> +    if {$confirm_ok} {
> +	exec git stash apply stash@{0}

'git stash apply' could fail with merge conflicts ...

> +	exec git stash clear

and here you are throwing the stash away!

> +    }
> +
> +    notbusy rebasehead
> +    updatecommits
> +}

-Peter
