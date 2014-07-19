From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/4] completion: complete "unstuck" `git push
 --recurse-submodules`
Date: Sat, 19 Jul 2014 16:10:14 +0100
Message-ID: <20140719151014.GA26927@serenity.lan>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
 <a3317a7692675483f60ee10ff98e1e95a3dc4b5a.1405763157.git.john@keeping.me.uk>
 <53CA5876.40007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8WOf-0004Zo-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbaGSPRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:17:55 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:37649 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbaGSPRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:17:54 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jul 2014 11:17:54 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 62A0560654B;
	Sat, 19 Jul 2014 16:10:24 +0100 (BST)
X-Quarantine-ID: <DcBMMhx1RaMx>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DcBMMhx1RaMx; Sat, 19 Jul 2014 16:10:23 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id DB93D606545;
	Sat, 19 Jul 2014 16:10:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <53CA5876.40007@kdbg.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253882>

On Sat, Jul 19, 2014 at 01:37:26PM +0200, Johannes Sixt wrote:
> Am 19.07.2014 11:45, schrieb John Keeping:
> > Since the argument to `--recurse-submodules` is mandatory, it does not
> > need to be stuck to the option with `=`.
> > 
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  contrib/completion/git-completion.bash | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index d0b2895..06211a6 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1624,6 +1624,10 @@ __git_push_recurse_submodules="check on-demand"
> >  _git_push ()
> >  {
> >  	case "$prev" in
> > +	--recurse_submodules)
> 
> This would need a dash, not an underscore.

Thanks.  I'll wait to see if there are any more comments before
re-rolling.

> > +		__gitcomp "$__git_push_recurse_submodules"
> > +		return
> > +		;;
> >  	--repo)
> >  		__gitcomp_nl "$(__git_remotes)"
> >  		return
> > 
> 
