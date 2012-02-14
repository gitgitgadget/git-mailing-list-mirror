From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 17:07:32 -0500
Message-ID: <20120214220732.GB24802@sigill.intra.peff.net>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <20120214211402.GC23291@sigill.intra.peff.net>
 <CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQXH-0003e5-Sw
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761251Ab2BNWHi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:07:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35960
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760886Ab2BNWHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:07:36 -0500
Received: (qmail 12641 invoked by uid 107); 14 Feb 2012 22:14:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 17:14:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 17:07:32 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190773>

On Tue, Feb 14, 2012 at 11:52:11PM +0200, Felipe Contreras wrote:

> On Tue, Feb 14, 2012 at 11:14 PM, Jeff King <peff@peff.net> wrote:
> > My general review process is (in this order):
> >
> > =C2=A01. Figure out why a change is needed. This should be explaine=
d in the
> > =C2=A0 =C2=A0 commit message. And no, just adding tests is not assu=
med to be
> > =C2=A0 =C2=A0 needed. =C2=A0Why did the old tests not cover this ca=
se?
>=20
> As I already mentioned more than once; the first patch is not related
> to any fix.

Really? I didn't see it mentioned in your commit message, which
consisted entirely of:

  t: mailmap: add 'git blame -e' tests

Yes, I know you mentioned it elsewhere in the thread. But review should
happen on what is actually in the posted patch. That is what reviewers
are guaranteed to have read, and it is what people reading "git log" in
a year will see. If there was other discussion or context that led to
the patch, it's helpful in both cases to summarize it.

> >     The answer can
> > =C2=A0 =C2=A0 be a simple "nobody bothered to write them", and that=
's OK.
>=20
>  That can be derived from the word "add". You can't add something tha=
t
> is already there.

Are there already git-blame tests, but not "blame -e" tests? If there
are already "blame" tests, why do we additionally need "blame -e" tests=
?

I can guess, or I can do my own digging in the history to find out, but
that makes review a lot more painful. You already did the digging and
came to understand the problem when you made your patch. Why not just
share it?

> >     But
> > =C2=A0 =C2=A0 some description of the current state can help review=
ers understand
> > =C2=A0 =C2=A0 the rationale (e.g., "we tested with shortlog, but no=
t mailmap, and
> > =C2=A0 =C2=A0 certain code paths are only exposed through mailmap")=
=2E
>=20
> You are assuming too much. That's not the purpose, that's why I didn'=
t menti

Sorry, that should have been s/mailmap/blame/ above. But if I am making
wrong assumptions about the rationale, then isn't that a sign that the
commit message is insufficient?

> > =C2=A02. Figure out what the change should be doing.
>=20
> t: mailmap: add 'git blame -e' tests
>=20
> That's what the change should be doing; nothing more, nothing less.

Yes, I think you did describe the "what", which in this case is very
simple. But as I mentioned before, it is not just knowing the "what" bu=
t
evaluating that the "what" meets the "why" from step 1.

> I wonder why you have to assume the worst. When I see a commit messag=
e
> like that, I assume that there were no previous tests for that (thus
> the word 'add'), and that's all I need to know.

I don't necessarily assume the worst. If I were the maintainer, I might
even have taken your patch as-is, as it's pretty simple. But I found a
description like the one Jonathan included to be _much_ easier to
review. Whether yours was above a minimum threshold or not, I think it'=
s
worth striving to be better.

-Peff
