From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Tue, 20 Jan 2009 15:58:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201553200.5159@intel-tinevez-2-302>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net>
 <7vljt6q4cf.fsf@gitster.siamese.dyndns.org> <20090120040617.GB30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201126500.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901201133280.3586@pacific.mpi-cbg.de> <20090120142301.GC10688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 16:00:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPI5D-0001Qq-2C
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 16:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbZATO6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 09:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZATO6i
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 09:58:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:52949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752106AbZATO6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 09:58:37 -0500
Received: (qmail invoked by alias); 20 Jan 2009 14:58:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp060) with SMTP; 20 Jan 2009 15:58:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pGogldgdpRsRqDxPn3CQgA9RRX5VnJ2pi3QwSGe
	7aZDdXVgIiwG0L
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090120142301.GC10688@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106479>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Tue, Jan 20, 2009 at 11:36:08AM +0100, Johannes Schindelin wrote:
> 
> > > > Of course. But the problem is that rev-list is _already_ contaminated 
> > > > by --pretty=format:%Cred. Or do you mean, you really want rev-list to 
> > > > unconditionally output color in such a case?
> > > 
> > > No, rev-list is not contaminated with UI color options.  %Cred _always_ 
> > > outputs the color, even when the user turned off color explicitely, 
> > > using --no-color.
> > 
> > BTW I would find it very logical for rev-list not to output any color at 
> > all when %C(yellow) is specified, as your code respects the diff UI 
> > options, which are implicitly turned off for rev-list (as rev-list is no 
> > UI), just like the coloring of "commit <name>" is implicitly turned off 
> > for rev-list.
> 
> Now I'm confused. Should color in --pretty=format always be on, or
> should it respect color settings? You seem to be advocating both sides
> in the two paragraphs.

No, I am just very bad at relating my thoughts.

What I tried to say is "plumbing does not, and should not, change behavior 
depending on diff.color".

With %Cred, I was just lazy, and did not make a check if diff.color is 
true, which I regret now.

But then, its behavior still does not depend on diff.color when using 
plumbing.

It does not even depend on it when using porcelain :-)

> The behavior I would propose it along the lines of:
> 
>  - plumbing _always_ has color off
> 
>  - porcelain respects color.* config, --color, etc

Right, that'd be the sane behavior, even for %Cred.

Ciao,
Dscho
