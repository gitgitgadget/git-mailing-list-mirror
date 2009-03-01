From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix git format-patch --cc=<email> format
Date: Sat, 28 Feb 2009 20:01:16 -0500
Message-ID: <20090301010116.GA20255@coredump.intra.peff.net>
References: <1235824944-4967-1-git-send-email-bergwolf@gmail.com> <76718490902280815if1c3fa7o790112b410d52224@mail.gmail.com> <7vy6vqfp0p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, Peng Tao <bergwolf@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 02:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lda4x-0004xm-AB
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 02:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbZCABBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 20:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755088AbZCABBX
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 20:01:23 -0500
Received: from peff.net ([208.65.91.99]:34751 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753777AbZCABBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 20:01:22 -0500
Received: (qmail 28018 invoked by uid 107); 1 Mar 2009 01:01:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 28 Feb 2009 20:01:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Feb 2009 20:01:16 -0500
Content-Disposition: inline
In-Reply-To: <7vy6vqfp0p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111805>

On Sat, Feb 28, 2009 at 09:29:58AM -0800, Junio C Hamano wrote:

> >> If there are multiple --cc=3D<email> arguments, git format-patch w=
ill generate
> >> patches with cc lines like:
> >> =C2=A0Cc: <email>,
> >> =C2=A0 =C2=A0 =C2=A0<email>
> >> which git send-email fails to parse.
> >> git send-email only accept formats like:
> >> =C2=A0Cc: <email>
> >> =C2=A0Cc: <email>
> >> So change git format-patch to generate patches in a proper format.
> >
> > This is fixed in next, but we fixed send-email instead to handle th=
e
> > messages that format-patch generates, as they should be valid.
>=20
> Per RFC2822 3.6 (pp 19-20), "cc" is to appear at most once (same is t=
rue
> for "to" and "bcc").  I think fix to format-patch is necessary regard=
less
> of what send-email does.

Then isn't the current format-patch output (folding the cc over
multiple lines) correct, and the patch (outputting multiple cc headers)
wrong?

-Peff
