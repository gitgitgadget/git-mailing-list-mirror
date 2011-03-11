From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Fri, 11 Mar 2011 00:31:07 -0500
Message-ID: <20110311053107.GB16605@sigill.intra.peff.net>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu>
 <20110310225233.GH15828@sigill.intra.peff.net>
 <7vvczq1o4l.fsf@alter.siamese.dyndns.org>
 <20110311012318.GB15377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 06:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxuwU-0000Ex-W7
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 06:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043Ab1CKFbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Mar 2011 00:31:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58849
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab1CKFbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 00:31:09 -0500
Received: (qmail 2618 invoked by uid 107); 11 Mar 2011 05:31:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Mar 2011 00:31:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Mar 2011 00:31:07 -0500
Content-Disposition: inline
In-Reply-To: <20110311012318.GB15377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168882>

On Thu, Mar 10, 2011 at 08:23:18PM -0500, Jeff King wrote:

> I like the proposal for:
>=20
>   # Lines below this one will be removed.
>   diff --git ...
>=20
> which seems to have the best of both worlds, robust and easy for edit=
ors
> to recognize as a diff. For that matter, we could also do "# Lines be=
low
> this one..." for _all_ of the git-status template, but I don't think
> it's necessary. Those lines are already clearly marked with a delimit=
er,
> and I don't think anybody is complaining about them (and the "Lines
> below this one..." line adds just one more line of cruft).

Hmm, actually the proposal that G=C3=A1bor mentioned here:

  http://thread.gmane.org/gmane.comp.version-control.git/100525/focus=3D=
100655

was to mark the whole status template as "everything below this line is
uninteresting". And I was wrong that it would add one more line of
cruft; we already have a line saying "lines with '#' will be ignored",
so it would be replacing it.

I do still think I prefer the "#" as comment lines, though. Editors
understand that concept pretty well. For example, one thing that happen=
s
to me a lot is that I write a paragraph, then edit it, then ask the
editor to re-wrap it. Inevitably it buts against the "#" lines, and
those get re-wrapped, too. I could fix it, of course, but I don't bothe=
r
because the editor knows that the stuff on "#" lines should remain on
"#" lines. So as it is now, the git-status output gets scrambled, but I
don't have to care. With a special "# Lines below this one..." line, I
will have mangled it and get extra cruft in my commit message.

But I admit that this is one pretty bizarre personal anecdote and might
not affect anyone else.

-Peff
