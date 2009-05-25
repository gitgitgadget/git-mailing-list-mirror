From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] am: do not do any reset on --abort
Date: Mon, 25 May 2009 12:00:20 -0400
Message-ID: <20090525160020.GA5449@coredump.intra.peff.net>
References: <20090525104308.GA26775@coredump.intra.peff.net> <alpine.DEB.1.00.0905251348050.4288@intel-tinevez-2-302> <20090525120019.GA1740@coredump.intra.peff.net> <4A1A8C6C.5020009@viscovery.net> <32541b130905250854v981277oe093ee4990726a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 18:00:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8cbN-0004mg-RL
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 18:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbZEYQAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752744AbZEYQAX
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 12:00:23 -0400
Received: from peff.net ([208.65.91.99]:43657 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbZEYQAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 12:00:22 -0400
Received: (qmail 5064 invoked by uid 107); 25 May 2009 16:00:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 12:00:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 12:00:20 -0400
Content-Disposition: inline
In-Reply-To: <32541b130905250854v981277oe093ee4990726a2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119939>

On Mon, May 25, 2009 at 11:54:36AM -0400, Avery Pennarun wrote:

> On Mon, May 25, 2009 at 8:17 AM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
> > =C2=A0 $ git am --abort
> > =C2=A0 OUTCH! other-branch was reset!
>=20
> If *that's* your problem, then presumably you could avoid it just by
> checking whether the right branch corresponds to HEAD before doing a
> reset.

But that only covers one problem. How about you forgot that you had a
failed am in progress, waited hours or days, made some commits on the
same branch, tried to am a series, got the "in progress" message and
then did an "--abort"?

And yes, I have done that.

In both examples, an alternative method for dealing with this is to try
to alert the user that we are in the middle of an am when doing
potentially suspicious things (like switching branches or making commit=
s
outside of "git am --resolved"). I don't know how well that would work
in practice.

-Peff
