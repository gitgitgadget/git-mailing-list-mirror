From: Jeff King <peff@peff.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 16:36:31 -0500
Message-ID: <20100120213631.GB9107@coredump.intra.peff.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiEJ-0000A5-8d
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab0ATVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749Ab0ATVgg
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:36:36 -0500
Received: from peff.net ([208.65.91.99]:51556 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755Ab0ATVge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:36:34 -0500
Received: (qmail 10079 invoked by uid 107); 20 Jan 2010 21:41:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 20 Jan 2010 16:41:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jan 2010 16:36:31 -0500
Content-Disposition: inline
In-Reply-To: <7veilk1o3s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137586>

On Wed, Jan 20, 2010 at 01:08:07PM -0800, Junio C Hamano wrote:

> > No, but outputting the note as part of the log is the standard. So for
> > example, when you do a format-patch | apply cycle, format-patch will
> > insert the note as part of the commit message, and apply will *store*
> > the note text (including Note:\n) as part of the commit message of the
> > new commit.
> 
> Thanks; that was the kind of breakage report I was looking for (and wished
> to have heard a lot earlier).  Personally I find it is unexcusable that
> format-patch defaults to giving notes.

I agree. I noticed this while doing the "don't show in raw" feature
elsewhere in the thread and wanted to ask: which formats _should_ have
notes by default?

To be honest, I am not sure _any_ format should have it by default. If I
am running "git log" and my notes are filled with random automatically
generated bisection cruft, I don't want to see that cluttering my
output. Yes, all of our test notes are human-written annotations, but I
think we really don't know yet what sorts of things people will be
putting in them.

Long ago I proposed a set of notes namespaces to deal with this (so
automatic bisection cruft would go into its own notes namespace, and
human-readable ones would be in some default namespace), but I don't
know how much of that idea (if any) survived into the current
implementation.

> > I'm not complaining, I actually have this on a maybe-to-do list, but the
> > way the series went kept me from investing time.
> 
> Hmm, that hints there is a failure in the review and merge process.  Care
> to explain how we could have done better please?

Personally, I stopped paying attention simply because it was gigantic
and I am not all that interested in using the feature personally.

-Peff
