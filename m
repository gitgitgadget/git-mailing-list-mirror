From: Jeff King <peff@peff.net>
Subject: Re: Suggestion on git-push --porcelain
Date: Tue, 9 Feb 2010 23:54:46 -0500
Message-ID: <20100210045446.GC28526@coredump.intra.peff.net>
References: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
 <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Larry D'Anna <larry@elder-gods.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 05:54:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf4bE-0004Xu-VD
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 05:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab0BJEyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 23:54:45 -0500
Received: from peff.net ([208.65.91.99]:59305 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0BJEyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 23:54:45 -0500
Received: (qmail 29897 invoked by uid 107); 10 Feb 2010 04:54:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 23:54:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 23:54:46 -0500
Content-Disposition: inline
In-Reply-To: <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139484>

On Tue, Feb 09, 2010 at 06:57:46PM -0800, Junio C Hamano wrote:

> Tay Ray Chuan <rctay89@gmail.com> writes:
> 
> >   $ git push --porcelain
> >   PORCELAIN To git://foo.com/git/myrepo.git
> >   PORCELAIN uptodate refs/heads/baz:refs/heads/baz 1234ab ba4321
> >   PORCELAIN nonff refs/heads/bar:refs/heads/bar 2345cd 3456de
> >
> > This is an "positive" approach, in the sense that we don't remove
> > anything from the current output; we just add more printf("PORCELAIN")
> > lines to wherever is appropriate.
> 
> Sorry, but I don't see what that would solve.  For example, we used not to
> give the destination to the standard output stream, but that line carries
> a necessary information and Larry's series corrects that.

I think he is trying to future-proof any additional output that push (or
remote helpers) produce. I don't think it is really worth it, though.
All of that should be going to stderr, and thus would be, at worst,
noise on the terminal. I don't think it is that hard or error-prone a
rule to send such cruft to stderr.

-Peff
