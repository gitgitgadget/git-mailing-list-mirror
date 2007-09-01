From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sun, 2 Sep 2007 00:02:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709020002010.28586@racer.site>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com>
 <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 01:03:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRbzw-0001Z5-Ox
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 01:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757119AbXIAXDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbXIAXDV
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 19:03:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:36830 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755882AbXIAXDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 19:03:20 -0400
Received: (qmail invoked by alias); 01 Sep 2007 23:03:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 02 Sep 2007 01:03:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ce4ppjUsC1/OW7QLVK9hbYbKjmMlyTJi/Ujg8fG
	NQ0nWnSO0xhkc5
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir6us1ia.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57285>

Hi,

On Sat, 1 Sep 2007, Junio C Hamano wrote:

> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 5ed1821..1fef857 100755
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -64,12 +64,34 @@ __gitdir ()
> >  
> >  __git_ps1 ()
> >  {
> > -	local b="$(git symbolic-ref HEAD 2>/dev/null)"
> > -	if [ -n "$b" ]; then
> > +	local g="$(git rev-parse --git-dir 2>/dev/null)"
> > +	if [ -n "$g" ]; then
> > +		local r
> > +		local b
> > +		if [ -d "$g/../.dotest" ]
> > +		then
> > +			local b="$(git symbolic-ref HEAD 2>/dev/null)"
> > +			r="|REBASEING"
> 
> I might be in the middle of resolving a conflicted "git am".
> 
> But I love the idea.  We need to think about cleaning up our
> "state machine" mechanism to make this kind of thing easier to
> do.  We've had a few suggestions on the list in the past but
> they never passed the suggestion/speculation stage.

Like your git-explain?

I actually liked the idea.  Maybe we can get more people interested on 
that thing post 1.5.3...

Ciao,
Dscho
