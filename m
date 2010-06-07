From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Put quotes around branch names to prevent special
 characters from being interpreted by the shell.
Date: Mon, 7 Jun 2010 02:01:47 -0400
Message-ID: <20100607060147.GA20958@coredump.intra.peff.net>
References: <1275666800-31852-1-git-send-email-bmeyer@rim.com>
 <20100606215505.GB6993@coredump.intra.peff.net>
 <AANLkTinZc1jiBmTJRsJXDe7A4ZAe001zJIWILGKQ8YoA@mail.gmail.com>
 <AANLkTik7PV-2u24UF78U6rtuffw4XUGS1F4hD2_ElrZZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Benjamin C Meyer <bmeyer@rim.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 08:01:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLVPH-0000dJ-TQ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 08:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab0FGGBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 02:01:51 -0400
Received: from peff.net ([208.65.91.99]:49451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab0FGGBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 02:01:50 -0400
Received: (qmail 17948 invoked by uid 107); 7 Jun 2010 06:01:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Jun 2010 02:01:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jun 2010 02:01:47 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik7PV-2u24UF78U6rtuffw4XUGS1F4hD2_ElrZZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148575>

On Mon, Jun 07, 2010 at 05:48:11AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Mon, Jun 7, 2010 at 05:10, Jay Soffian <jaysoffian@gmail.com> wrot=
e:
> > BTW, quotemeta is technically intended for use with regular
> > expressions, isn't it?
>=20
> Yes, it's completely insecure to use it for shell interpolation.

It's intended for use with regexps, but I don't think it is insecure fo=
r
shell interpolation. According to perldoc, it quotes 'all characters no=
t
matching "/[A-Za-z_0-9]/"'. So it's excessive for shell quoting, but no=
t
insecure.

> In Perl it's best to use the list form of system() so that the comman=
d
> will escape things for you automatically.

Agreed, but it's not escaping things automatically. It simply skips the
shell invocation entirely.

-Peff
