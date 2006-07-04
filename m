From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 4 Jul 2006 13:35:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607041334070.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net>
 <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsllhhcxr.fsf@assigned-by-dhcp.cox.net> <e8dim7$8cm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:35:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxjBg-00065B-Nl
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWGDLfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGDLfH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:35:07 -0400
Received: from mail.gmx.de ([213.165.64.21]:8160 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932209AbWGDLfG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:35:06 -0400
Received: (qmail invoked by alias); 04 Jul 2006 11:35:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 04 Jul 2006 13:35:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e8dim7$8cm$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23289>

Hi,

On Tue, 4 Jul 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> 
> > The problem ALASCM's example demonstrates does rely on clock
> > skews.  The timestamps used in the example looked like this:
> > 
> > 
> >    1   1
> >   /  \/  \
> >  4  -1   4
> >  |   |   |
> >  3  -2   3
> >  |   |   |
> >  2  -3   2
> >    \ |  /
> >      0
> > 
> > The crucial clock skew the case relies on is that the tip of the
> > middle branch (-1) is older than the common commit (0).  But the
> > topmost commits with timestamp 1 could be with timestamp 5 to
> > correct the clock skew and still make the example "fail".
> > 
> >    5   5
> >   /  \/  \
> >  4  -1   4
> >  |   |   |
> >  3  -2   3
> >  |   |   |
> >  2  -3   2
> >    \ |  /
> >      0
> 
> So would putting timestamp for merge be MAX(now, parents timestamps)
> solve the problem?

If there is an evil committer, the parents could have bogus timestamps, 
too. But then, I would not pull from such an evil person...

Ciao,
Dscho
