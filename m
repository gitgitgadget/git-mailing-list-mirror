From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Tue, 20 Jan 2009 09:23:01 -0500
Message-ID: <20090120142301.GC10688@sigill.intra.peff.net>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net> <7vljt6q4cf.fsf@gitster.siamese.dyndns.org> <20090120040617.GB30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201126500.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901201133280.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 15:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPHWz-0008Pr-Hc
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 15:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbZATOXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 09:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756673AbZATOXI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 09:23:08 -0500
Received: from peff.net ([208.65.91.99]:59226 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbZATOXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 09:23:07 -0500
Received: (qmail 1895 invoked by uid 107); 20 Jan 2009 14:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 20 Jan 2009 09:23:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 09:23:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901201133280.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106476>

On Tue, Jan 20, 2009 at 11:36:08AM +0100, Johannes Schindelin wrote:

> > > Of course. But the problem is that rev-list is _already_ contaminated 
> > > by --pretty=format:%Cred. Or do you mean, you really want rev-list to 
> > > unconditionally output color in such a case?
> > 
> > No, rev-list is not contaminated with UI color options.  %Cred _always_ 
> > outputs the color, even when the user turned off color explicitely, 
> > using --no-color.
> 
> BTW I would find it very logical for rev-list not to output any color at 
> all when %C(yellow) is specified, as your code respects the diff UI 
> options, which are implicitly turned off for rev-list (as rev-list is no 
> UI), just like the coloring of "commit <name>" is implicitly turned off 
> for rev-list.

Now I'm confused. Should color in --pretty=format always be on, or
should it respect color settings? You seem to be advocating both sides
in the two paragraphs.

The behavior I would propose it along the lines of:

 - plumbing _always_ has color off

 - porcelain respects color.* config, --color, etc

-Peff
