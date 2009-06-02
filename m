From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Show presense of stashed changes in bash prompt.
Date: Tue, 2 Jun 2009 08:29:15 -0700
Message-ID: <20090602152915.GK30527@spearce.org>
References: <20090602114325.GA3427@laptop> <7vzlcqfyli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Trstenjak <Daniel.Trstenjak@online.de>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBVvk-0008Gd-2d
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbZFBP3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbZFBP3O
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:29:14 -0400
Received: from george.spearce.org ([209.20.77.23]:50278 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbZFBP3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:29:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6D10D381FE; Tue,  2 Jun 2009 15:29:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzlcqfyli.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120520>

Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Trstenjak <Daniel.Trstenjak@online.de> writes:
> > Avoid the forgetting of stashed changes by showing
> > them in the bash prompt.
> >
> > If the presense is shown is configurable by setting
> > GIT_PS1_SHOW_STASH_STATE to a nonempty value.
> 
> Why am I getting this deja-vu feeling about this patch, I wonder...  Is
> this a re-roll of a previously posted patch?

I don't know... I had a similar deja-vu feeling when I read it.
 
> Shawn?

Initial NAK, see below for the nit.
 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 98b9cbe..ed0c463 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -40,6 +40,10 @@
> >  #       with the bash.showDirtyState variable, which defaults to true
> >  #       once GIT_PS1_SHOWDIRTYSTATE is enabled.
> >  #
> > +#       You can also see if currently something is stashed, by setting
> > +#       GIT_PS1_SHOW_STASH_STATE to a nonempty value. If something is stashed,
> > +#       then a '$' will be shown next to the branch name. 
> > +#

Can we call this GIT_PS1_SHOWSTASHSTATE to match the already present
GIT_PS1_SHOWDIRTYSTATE in at least style formatting?

The bike shed already sailed... GIT_PS1_SHOWDIRTYSTATE shipped in
1.6.3.  Lets keep the same style.

Otherwise it looks fine to me, when you resend you can add my
Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
