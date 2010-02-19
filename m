From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Fri, 19 Feb 2010 03:34:41 -0500
Message-ID: <20100219083440.GC13691@coredump.intra.peff.net>
References: <20100219065010.GA22258@progeny.tock>
 <20100219072331.GG29916@progeny.tock>
 <20100219080819.GA13691@coredump.intra.peff.net>
 <20100219081947.GA12975@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiOK1-0007zu-83
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab0BSIeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 03:34:44 -0500
Received: from peff.net ([208.65.91.99]:33869 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab0BSIen (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:34:43 -0500
Received: (qmail 13584 invoked by uid 107); 19 Feb 2010 08:34:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 19 Feb 2010 03:34:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2010 03:34:41 -0500
Content-Disposition: inline
In-Reply-To: <20100219081947.GA12975@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140436>

On Fri, Feb 19, 2010 at 02:19:47AM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
>=20
> > Solaris 8 and 9 seem to be lacking it. Solaris 10 does have it. AIX=
 5.2
> > and 6.1 both have it.
> >=20
> > So it would mean some platforms couldn't run all tests. That is pro=
bably
> > good enough, given that most of our terminal-related bugs have not =
been
> > platform-specific problems.
>=20
> Hmm, how about /dev/ptmx?  (One can check by replacing posix_openpt(.=
=2E.)
> with open("/dev/ptmx", ...) in the test-terminal.c I sent.)

Solaris 8 does have /dev/ptmx. Sorry, I wasn't able to test it, as my
sol8 box is very vanilla right now, and I can't actually compile git on
it (it doesn't even have gmake). :)

Maybe Brandon (cc'd) can try it.

> No, not opposed.  Just lazy and not so interested in working on it.
> I do not want to just take the implementation you provided because I
> want to test the scripted git commands, too, though I haven=E2=80=99t=
 gotten
> around to that.

Ah, right, I forgot about scripts. That makes things a little uglier,
but it should theoretically be possible.

-Peff
