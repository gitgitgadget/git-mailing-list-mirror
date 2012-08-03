From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 3 Aug 2012 19:08:04 -0400
Message-ID: <20120803230804.GA14447@sigill.intra.peff.net>
References: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
 <1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7vr4rna8y4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxQyb-0003Y8-Gv
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 01:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab2HCXII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 19:08:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51052 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab2HCXIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 19:08:07 -0400
Received: (qmail 29623 invoked by uid 107); 3 Aug 2012 23:08:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 19:08:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 19:08:04 -0400
Content-Disposition: inline
In-Reply-To: <7vr4rna8y4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202869>

On Fri, Aug 03, 2012 at 03:48:19PM -0700, Junio C Hamano wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > Jeff King wrote:
> >
> > 	The seq command is GNU-ism, and is missing at least in older BSD
> > 	releases and their derivatives, not to mention antique
> > 	commercial Unixes.
> >
> > 	We already purged it in b3431bc (Don't use seq in tests, not
> > 	everyone has it, 2007-05-02), but a few new instances have crept
> > 	in. They went unnoticed because they are in scripts that are not
> > 	run by default.
> >
> > Replace them with test_seq that is implemented with a Perl snippet
> > (proposed by Jeff).  This is better than inlining this snippet
> > everywhere it's needed because it's easier to read and it's easier =
to
> > change the implementation (e.g. to C) if we ever decide to remove P=
erl
> > from the test suite.
> >
> > Note that test_seq is not a complete replacement for seq(1).  It ju=
st
> > has what we need now.
> >
> > There are also many places that do `for i in 1 2 3 ...` but I'm not=
 sure
> > if it's worth converting them to test_seq.  That would introduce ru=
nning
> > more processes of Perl.
> >
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > ---
>=20
> Thanks; Jeff, ack?

Yeah,

Acked-by: Jeff King <peff@peff.net>

> > +	"$PERL_PATH" -le 'print for "$ARGV[0]".."$ARGV[1]"' "$first" "$la=
st"
>=20
> I'd prefer not to have dq around $ARGV[]; is there a reason to have
> one around these?

I don't think they accomplish anything, and it is slightly easier to
read without them. I'm fine either way.

-Peff
