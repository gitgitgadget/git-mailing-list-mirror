From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 16:23:35 -0400
Message-ID: <20110329202335.GA5997@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <20110329143547.GB10771@sigill.intra.peff.net>
 <20110329190138.GA23599@sigill.intra.peff.net>
 <4D923792.9010101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fS3-00058E-Tz
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1C2UXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:23:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47977
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab1C2UXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:23:37 -0400
Received: (qmail 32493 invoked by uid 107); 29 Mar 2011 20:24:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:24:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:23:35 -0400
Content-Disposition: inline
In-Reply-To: <4D923792.9010101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170317>

On Tue, Mar 29, 2011 at 09:48:34PM +0200, Michael J Gruber wrote:

> >> This issue is not introduced by your patch, but maybe it is a good
> >> opportunity to refactor this to use expand_notes_ref from notes.c?
> > 
> > Oops, I just realized this is in builtin/notes.c in master. I had
> > already written a patch for another topic that made it globally
> > accessible. :)
> 
> Yeah, I (figured and) factored it out myself meanwhile, and rebased. I'm
> wondering though where we are going. Junio seems to be in a mood for
> major changes to the notes ui, so maybe I should hold on until we
> decided about a ui restructuring.

I have a series I'll send in a few minutes. It _would_ be a lot cleaner
if we just dropped --show-notes and company entirely, but I think that
is perhaps too aggressive, even for such a young feature.

> I think, though, that any notes ui revamp is correlated with our
> (stalled?) discussions about the layout of refs/. It affects not only
> the default notes ref ("commits" for all notes?) but also the question
> what a standard notes ref is, and where to store (and how to specify)
> upstream notes refs.

Yeah, I think those are open questions. But we can probably get away
with at least this option refactoring without having to answer them.

-Peff
