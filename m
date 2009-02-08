From: Jeff King <peff@peff.net>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Sun, 8 Feb 2009 06:18:39 -0500
Message-ID: <20090208111838.GD14359@coredump.intra.peff.net>
References: <20090207162754.5fb8b63f@perceptron> <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com> <20090208011802.2b7b9e74@perceptron> <7v1vu91d00.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7hp-00036I-CG
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbZBHLSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbZBHLSm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:18:42 -0500
Received: from peff.net ([208.65.91.99]:36116 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbZBHLSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:18:42 -0500
Received: (qmail 27006 invoked by uid 107); 8 Feb 2009 11:18:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 06:18:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 06:18:39 -0500
Content-Disposition: inline
In-Reply-To: <7v1vu91d00.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108962>

On Sun, Feb 08, 2009 at 01:42:07AM -0800, Junio C Hamano wrote:

> I think forbidding the removal of the current branch falls into the same
> category as forbidding the updating of the current branch.  It is what you
> would want to avoid in many workflows, and receive.denyDeleteCurrent that
> defaults to refuse may eventually be a good way to do this, but we need a
> transition plan for that escape hatch.  Most people may not see why they
> would want to do such a thing, and many people may perceive that in *their
> own* workflow such an operation can only be a mistake, but that is not a
> good enough reason to suddenly start forbidding something other people
> were allowed to do so far.

I thought of that, too, but note that receive.denyDeleteCurrent is about
preventing mistakes in a _non-bare_ repo. But deleting the HEAD branch
is also annoying in a bare repo (but not _as_ annoying; the real impact
is that cloners get a "could not checkout" message, but you don't have
the weird index-and-HEAD don't sync issue that non-bare repos get).
Should such a safety valve apply to both?

-Peff
