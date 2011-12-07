From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Wed, 7 Dec 2011 13:10:56 -0500
Message-ID: <20111207181056.GA6124@sigill.intra.peff.net>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
 <4ED8F9AE.8030605@lsrfire.ath.cx>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
 <20111207042431.GA10765@sigill.intra.peff.net>
 <4EDF99BA.3040006@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 19:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYLxS-0004Hl-JS
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 19:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276Ab1LGSLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 13:11:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42791
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757148Ab1LGSK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 13:10:59 -0500
Received: (qmail 18602 invoked by uid 107); 7 Dec 2011 18:17:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 13:17:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 13:10:56 -0500
Content-Disposition: inline
In-Reply-To: <4EDF99BA.3040006@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186478>

On Wed, Dec 07, 2011 at 05:52:10PM +0100, Ren=C3=A9 Scharfe wrote:

> > As a user, I would do:
> >=20
> >   git grep --threads=3D1 ...
> >=20
> > if I wanted a single-threaded process. Instead, we actually spawn a
> > sub-thread and do all of the locking, which has a measurable cost:
>=20
> Yes, the difference is measurable, and that's exactly how I like it t=
o
> be. :)  A user can turn off threading with --threads=3D0 or (more
> intuitively) --no-threads.  And we can quantify the overhead.

That seems acceptable to me if --threads is for speed-testing, but a
horrible interface if it is meant for end users who just want git to be
fast.

-Peff
