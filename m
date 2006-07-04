From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 4 Jul 2006 10:23:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
 <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 10:23:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxgBr-0001Sh-Nd
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 10:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWGDIXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 04:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWGDIXM
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 04:23:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:34701 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932069AbWGDIXK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 04:23:10 -0400
Received: (qmail invoked by alias); 04 Jul 2006 08:23:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 04 Jul 2006 10:23:09 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23272>

Hi,

On Tue, 4 Jul 2006, Junio C Hamano wrote:

> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
> >> This is a good demonstration that merge-base may not give you
> >> minimal set for pathological cases.  If you want to be through
> >> you could traverse everything to make sure we do not say 'S' is
> >> relevant, but that is quite expensive, so I think there will
> >> always be artifacts of horizon effect like this no matter how
> >> you try to catch it (didn't I keep saying that already?).
> >
> > The problem is in mark_reachable_commits(); it is either superfluous
> > or it needs to parse_commit() those commits that haven't been parsed
> > yet that it needs to traverse.
> 
> Yes, you could traverse everything.  But that is not practical.
> We have known that the clean-up pass has this horizon effect,
> and it is a compromise.

We could introduce a time.maximumSkew variable, and just walk only 
that much further when traversing the commits.

So, if you do not trust your clients to have a proper ntp setup, just say 
"I trust my peers to be off at most 1 day". That would save lots vs 
traverse-everything.

Ciao,
Dscho
