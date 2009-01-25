From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 15:17:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251509550.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <200901242347.23187.trast@student.ethz.ch> <alpine.DEB.1.00.0901250303150.14855@racer> <alpine.DEB.1.00.0901250324320.14855@racer> <glhqdi$tec$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-38952180-1232893032=:14855"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 15:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR5oa-0003pF-Bs
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 15:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZAYOQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 09:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754242AbZAYOQs
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 09:16:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:46335 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753124AbZAYOQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 09:16:48 -0500
Received: (qmail invoked by alias); 25 Jan 2009 14:16:41 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp040) with SMTP; 25 Jan 2009 15:16:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MNRhufPsMSaYCWgnB80M75NS1q537PD2heYgm70
	jADrpM4sH0MSf+
X-X-Sender: gene099@racer
In-Reply-To: <glhqdi$tec$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107061>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-38952180-1232893032=:14855
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

[please do not forget to Cc: me; today is a slow day, so I did not miss 
 your mail, but that is definitely not true on other days.]

On Sun, 25 Jan 2009, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> >> Hmm.  You're right, that is not really intuitive.  How about
> >> 
> >>       merge (B) A # Merge...
> >> 
> >> instead?
> > 
> > Or even better:
> > 
> >         merge B parent A' # Merge...
> 
> merge B with A' # Merge... 

No, that does not catch the meaning.

B is the _original_ merge commit.  So it actually knows what parents it 
has, but we want to give the user the freedom to change those parents.

The first parent is easy: this will be HEAD at that stage.

The other parents will be relatively easy: just replace A' by something 
else.

_However_ now that the merge commit B will be _redone_, we _still_ want to 
be able to refer to it later in the rebase script.  Therefore, rebase has 
to know that we _redid_ B at this stage.

Another idea:

	merge B Merge bla/blub
	parent A' bla/blub

Hmm?

Ciao,
Dscho

--8323329-38952180-1232893032=:14855--
