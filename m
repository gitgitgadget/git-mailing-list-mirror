From: Jeff King <peff@peff.net>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc
 8.2.5
Date: Tue, 29 May 2012 18:01:13 -0400
Message-ID: <20120529220113.GC17598@sigill.intra.peff.net>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
 <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
 <7vzk8q3h5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 00:01:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZUTg-0000d7-U3
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 00:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab2E2WBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 18:01:16 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:35446
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab2E2WBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 18:01:16 -0400
Received: (qmail 29184 invoked by uid 107); 29 May 2012 22:01:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 May 2012 18:01:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2012 18:01:13 -0400
Content-Disposition: inline
In-Reply-To: <7vzk8q3h5c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198769>

On Tue, May 29, 2012 at 12:45:51PM -0700, Junio C Hamano wrote:

> > We could also keep the nice syntax and have some simple sed-based
> > pre-processor that converts the syntax to the older and more widely
> > supported version.
>=20
> No, let's not go there.  I do not see any reason to believe that
> such a sed script would do an equally good or better job as native
> AsciiDoc implementation to deal with inline-literals.  That means we
> would end up writing our documentation with a subset of newer
> AsciiDoc that the custom sed script can grok---which defeats the
> purpose of the whole exercise.

Very much agreed; that way lies madness.

> > Or we could just decide to break RHEL 5 and systems released at a
> > similar time, but that isn't what the patch suggested it was doing,=
 so
> > we should probably step back and ponder whether that's something we
> > want to do.
>=20
> Very true.  Jeff, how do we want to proceed?  For the upcoming
> release, I am inclined to say that we would revert 6cf378f (docs:
> stop using asciidoc no-inline-literal, 2012-04-26).  We would still
> need to double check the result, though. Documentation updates that
> came after it are written assuming "inline-literal" behaviour, and
> parts we may have "fixed" with the commit will format to their old
> rendition.

I'd really rather keep it; I won't repeat my arguments here, but I made
several in a reply to =C3=86var elsewhere in the thread. However, if we=
 do
revert it, then it would be really great if somebody comes up with
alternate solutions to fix the long list of bugs that were fixed by
6cf378f (they are all documented in the commit message). And it would b=
e
even greater if that somebody isn't me.

I think it would also be worth figuring out when a switch would be
appropriate.  Moving to inline literals is obviously the way forward
(it's way less error-prone, and eventually asciidoc may deprecate or
drop the backwards compatibility feature themselves). So it is simply a
matter of time in deciding when. If not now, then when?

-Peff
