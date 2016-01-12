From: Jeff King <peff@peff.net>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 13:21:16 -0500
Message-ID: <20160112182115.GB9244@sigill.intra.peff.net>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20160112153239.GA8041@sigill.intra.peff.net>
 <87io2yekhp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Monnier <monnier@iro.umontreal.ca>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:21:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3ZK-0003BI-T7
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933829AbcALSVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:21:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:52372 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752417AbcALSVS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:21:18 -0500
Received: (qmail 10754 invoked by uid 102); 12 Jan 2016 18:21:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 13:21:18 -0500
Received: (qmail 16324 invoked by uid 107); 12 Jan 2016 18:21:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 13:21:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 13:21:16 -0500
Content-Disposition: inline
In-Reply-To: <87io2yekhp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283832>

On Tue, Jan 12, 2016 at 07:11:14PM +0100, Andreas Schwab wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And hopefully that explains why "000000" does not necessarily make a
> > good placeholder for "the empty thing". There are multiple empty things,
> > and it is not clear what:
> >
> >   git diff 0000000 1234abcd
> >
> > means. Is 0000000 a tree? A blob?
> 
> Perhaps there should be an easy syntax for an empty thing, something
> like 0^{tree} and 0^{blob}.  Not sure whether it is worth the effort,
> though.

I think I proposed a magic EMPTY_TREE token or something like that at
one point. It is slightly more convenient than trying to remember the
exact tree sha1, but I think in practice it doesn't save much effort
(outside of scripts, you can often use "--root" to accomplish the same
thing, depending on the command being run).

-Peff
