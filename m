From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5000: skip ZIP tets when unzip is absent
Date: Sat, 12 May 2007 17:39:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705121735580.4167@racer.site>
References: <Pine.LNX.4.64.0705101246430.4167@racer.site>
 <7vps58ieuw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 17:39:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmth6-0002dG-Ga
	for gcvg-git@gmane.org; Sat, 12 May 2007 17:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbXELPjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 11:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbXELPjV
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 11:39:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:60654 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754698AbXELPjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 11:39:20 -0400
Received: (qmail invoked by alias); 12 May 2007 15:39:19 -0000
Received: from R0a8c.r.pppool.de (EHLO noname) [89.54.10.140]
  by mail.gmx.net (mp020) with SMTP; 12 May 2007 17:39:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1809/IA8uw0W3mqiPHfeHcBVcZoCZIvVLc82ik0n2
	ee4ciHYvCHPMkn
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps58ieuw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47054>

Hi,

On Thu, 10 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >
> > ---
> >
> >  t/t5000-tar-tree.sh |    7 +++++++
> >  1 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index e223c07..1580592 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -108,6 +108,13 @@ test_expect_success \
> >      'git-archive --format=zip' \
> >      'git-archive --format=zip HEAD >d.zip'
> >  
> > +unzip -v 2>/dev/null
> > +if [ $? -ne 10 ]; then
> > +	echo "Skipping ZIP tests, because unzip was not found"
> > +	test_done
> > +	exit
> > +fi
> > +
> 
> Are you sure about this?

No longer.

At least one unzip version I tested returned exit code 10 when correctly 
showing the usage (IIRC). However, another one has exit code 0!

Also, it should not hardcode "unzip", but instead use "$UNZIP".

So, please ignore this patch. I try to do it properly.

Ciao,
Dscho
