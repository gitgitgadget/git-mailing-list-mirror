From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Thu, 31 May 2012 11:33:51 +0200
Message-ID: <87pq9k66f4.fsf@thomas.inf.ethz.ch>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
	<7vehq18c82.fsf@alter.siamese.dyndns.org>
	<20120531011911.GC5488@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Lanny Ripple <lanny@spotinfluence.com>, <git@vger.kernel.org>,
	Will Palmer <wmpalmer@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 11:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa1lz-0007cO-UV
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 11:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab2EaJdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 05:33:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:48160 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab2EaJdx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 05:33:53 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 11:33:51 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 31 May
 2012 11:33:51 +0200
In-Reply-To: <20120531011911.GC5488@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 30 May 2012 21:19:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198876>

Jeff King <peff@peff.net> writes:

> On Wed, May 30, 2012 at 04:45:33PM -0700, Junio C Hamano wrote:
>
>> Lanny Ripple <lanny@spotinfluence.com> writes:
>>=20
>> >   lanny;~> echo "R=C3=A9mi Leblond" | LANG=3DC LC_ALL=3DC sed -ne =
's/.*/GIT_AUTHOR_NAME=3D'\''&'\''/p'
>> >   GIT_AUTHOR_NAME=3D'R'=C3=A9mi Leblond
>>=20
>> So in C locale where each byte is supposed to be a single character,
>> that implementation of "sed" refuses to match a byte with high-bit
>> set when given a pattern '.'?
>>=20
>> That is a surprising breakage, I would have to say.
>
> It should not be too surprising, since we discussed it a few months a=
go:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/192218
>
> Thomas provided a gross but workable solution here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/192237
>
> and we also talked about eventually having a shell-quoting mechanism =
for
> pretty placeholders.  Then the discussion rambled into "this sed is
> horribly broken, and the user should get a better sed" territory. May=
be
> we need to revisit that decision, since this is now two bug reports.

Three actually, also counting Will Palmer (shruggar) who brought this u=
p
on #git-devel shortly before the thread above.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
