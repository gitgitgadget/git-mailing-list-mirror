From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 4 Apr 2013 19:29:04 -0400
Message-ID: <20130404232903.GA27128@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
 <20130404210304.GA25811@sigill.intra.peff.net>
 <7vhajlgabi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 01:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNtbA-00046W-PV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765340Ab3DDX3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 19:29:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56516 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765285Ab3DDX3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 19:29:10 -0400
Received: (qmail 8230 invoked by uid 107); 4 Apr 2013 23:31:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 19:31:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 19:29:04 -0400
Content-Disposition: inline
In-Reply-To: <7vhajlgabi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220125>

On Thu, Apr 04, 2013 at 04:12:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Deleting across symlinks inside the repo can be brushed aside with "eh,
> > well, it is just another way to mention the same name in the
> > filesystem". But deleting anything outside of the repo seems actively
> > wrong.
> 
> Yup, you finally caught up ;-) IIRC, such an outside repository
> target was the case people realized that "git add" shouldn't see
> across symlinks.

It would help if you spelled it out rather than making me come to it
while arguing against you. ;P

> > Hmm. I think you have convinced me (or perhaps I have convinced myself)
> > that we should generally not be crossing symlink boundaries in
> > translating names between the filesystem and index. I still don't want
> > to work on it, though. :)
> 
> That is OK.  Just let's not etch a wrong behaviour in stone with
> that test.

So let's drop patch 3. Do we want instead to have an expect_failure
documenting the correct behavior?

-Peff
