From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Improve bash prompt to detect merge / rebase in progress
Date: Sun, 2 Sep 2007 01:35:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709020133540.28586@racer.site>
References: <11886421573285-git-send-email-robin.rosenberg@dewire.com>
 <7vir6us1ia.fsf@gitster.siamese.dyndns.org> <20070901222036.GH18160@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRdRh-0004z3-Sn
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 02:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbXIBAfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 20:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbXIBAfl
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 20:35:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:59795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932475AbXIBAfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 20:35:40 -0400
Received: (qmail invoked by alias); 02 Sep 2007 00:35:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 02 Sep 2007 02:35:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18K0BVhgQgKeDp4J6A1LlzBEsYEO9s07NbQEZZi7I
	LIQ/zRFH/wo5uo
X-X-Sender: gene099@racer.site
In-Reply-To: <20070901222036.GH18160@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57289>

Hi,

On Sat, 1 Sep 2007, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> > >
> > > +	local g="$(git rev-parse --git-dir 2>/dev/null)"
> > > +	if [ -n "$g" ]; then
> > > +		local r
> > > +		local b
> > > +		if [ -d "$g/../.dotest" ]
> > > +		then
> > > +			local b="$(git symbolic-ref HEAD 2>/dev/null)"
> > > +			r="|REBASEING"
> > 
> > I might be in the middle of resolving a conflicted "git am".
> 
> And there's no way to tell the difference either.

AFAICT git-am creates an "info" file in .dotest/.

And interactive rebase is detectable by the "interactive" file in 
.git/.dotest-merge/.

Ciao,
Dscho
