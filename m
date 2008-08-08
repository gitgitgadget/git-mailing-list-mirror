From: Jeff King <peff@peff.net>
Subject: Re: git diff/log --check exitcode and PAGER environment variable
Date: Fri, 8 Aug 2008 09:17:59 -0400
Message-ID: <20080808131759.GA19705@sigill.intra.peff.net>
References: <489C145B.5090400@sneakemail.com> <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Valdemar =?utf-8?B?TcO4cmNoIChMaXN0cyk=?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 15:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRRs2-0006A2-Pk
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 15:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbYHHNSE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 09:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYHHNSE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 09:18:04 -0400
Received: from peff.net ([208.65.91.99]:1933 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYHHNSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 09:18:03 -0400
Received: (qmail 19983 invoked by uid 111); 8 Aug 2008 13:18:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 08 Aug 2008 09:18:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Aug 2008 09:18:00 -0400
Content-Disposition: inline
In-Reply-To: <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91662>

On Fri, Aug 08, 2008 at 02:44:37AM -0700, Junio C Hamano wrote:

> "Peter Valdemar M=C3=B8rch (Lists)"  <4ux6as402@sneakemail.com> write=
s:
>=20
> > There is this old thread:
> > "[PATCH 1/5] "diff --check" should affect exit status"
> > http://thread.gmane.org/gmane.comp.version-control.git/68145/focus=3D=
68148
> > which seemed not to reach a conclusion.
>=20
> Conclusion was (1) if you really care about the exit code, do not use
> pager; (2) after 1.6.0 we will swap the child/parent between git and =
pager
> to expose exit code from us, but not before.
>=20
> Or am I mistaken?

Yes, all of his testing with "git diff" is hampered by the pager hiding
the exit code. And that is dealt with by the patches in next (and I
tested his examples with 'next', and they work fine).

But that still leaves the part about "git log" not changing its exit
code. I don't think it has ever been designed to, and I'm not even sure
what the semantics would be (exit code !=3D 0 if any logged commit has =
a
whitespace problem? That seems the most logical, and it might be useful
for limited ranges).

-Peff
