From: Jeff King <peff@peff.net>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 13:20:03 -0500
Message-ID: <20160112182002.GA9244@sigill.intra.peff.net>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20160112153239.GA8041@sigill.intra.peff.net>
 <jwvr3hmwz1n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3YC-0002P3-PO
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbcALSUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:20:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:52366 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752211AbcALSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:20:05 -0500
Received: (qmail 10708 invoked by uid 102); 12 Jan 2016 18:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 13:20:05 -0500
Received: (qmail 16289 invoked by uid 107); 12 Jan 2016 18:20:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 13:20:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 13:20:03 -0500
Content-Disposition: inline
In-Reply-To: <jwvr3hmwz1n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283831>

On Tue, Jan 12, 2016 at 11:26:24AM -0500, Stefan Monnier wrote:

> > And hopefully that explains why "000000" does not necessarily make a
> > good placeholder for "the empty thing". There are multiple empty things,
> > and it is not clear what:
> 
> >   git diff 0000000 1234abcd
> 
> > means. Is 0000000 a tree? A blob?
> 
> Well, Git is the one who uses 000000 to refer to an empty thing, but
> indeed it seems like it does inconsistently: it's sometimes used as the
> "empty blob" and sometimes as an "empty tree".

Yes. You can think of it kind of like a NULL pointer; it just means
"nothing". So its meaning is context-dependent. The problem is if we
expect to feed it back to git in a place where the context isn't
obvious.

-Peff
