From: Jeff King <peff@peff.net>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Fri, 31 Aug 2012 17:43:12 -0400
Message-ID: <20120831214312.GB3008@sigill.intra.peff.net>
References: <503E3CFE.1080603@sigmadesigns.com>
 <7vd329wpt0.fsf@alter.siamese.dyndns.org>
 <nngligvdk0q.fsf@transit.us.cray.com>
 <m2a9xblyqp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: dag@cray.com, Junio C Hamano <gitster@pobox.com>,
	Emmanuel Michon <emmanuel_michon@sigmadesigns.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Z06-0008Qc-5M
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 23:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab2HaVnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 17:43:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50499 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892Ab2HaVnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 17:43:14 -0400
Received: (qmail 22244 invoked by uid 107); 31 Aug 2012 21:43:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 31 Aug 2012 17:43:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2012 17:43:12 -0400
Content-Disposition: inline
In-Reply-To: <m2a9xblyqp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204611>

On Fri, Aug 31, 2012 at 08:09:34PM +0200, Andreas Schwab wrote:

> <dag@cray.com> writes:
> 
> > Is "status" considered a plumbing layer command?  Because I have often
> > wondered why it does not use the pager by default.  I pipe it through
> > less all the time and it's kind of annoying that it works differently
> > than everything else.
> 
> I would be pretty annoyed if git status would page by default.

This one has been debated for a while. People used to complain that it
did not page, and then we turned on the pager, and then people
complained that it did page. I wrote 4e10738 (Allow per-command pager
config, 2008-07-03) to help settle it, and now you can do:

  git config pager.status true

if you really want it. As of 9bad723 (allow command-specific pagers in
pager.<cmd>, 2010-11-17), you can even set it to an arbitrary pager for
each git command.

With all those options, it's amazing that we can still have threads
about what should page. :)

-Peff
