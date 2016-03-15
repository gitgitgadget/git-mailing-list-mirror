From: Jeff King <peff@peff.net>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to
 ~/.config/git"
Date: Tue, 15 Mar 2016 15:21:54 -0400
Message-ID: <20160315192154.GA30693@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
 <xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
 <20160315031259.GA20508@sigill.intra.peff.net>
 <CAKqreuwv+RRziS-NcaLYZYUN0_KrfgZSe6wp0wGBza4q3_x8RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:22:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuXb-0001Tj-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933103AbcCOTV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 15:21:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:60016 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932665AbcCOTV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:21:58 -0400
Received: (qmail 5791 invoked by uid 102); 15 Mar 2016 19:21:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 15:21:57 -0400
Received: (qmail 5109 invoked by uid 107); 15 Mar 2016 19:22:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Mar 2016 15:22:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2016 15:21:54 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuwv+RRziS-NcaLYZYUN0_KrfgZSe6wp0wGBza4q3_x8RA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288896>

On Tue, Mar 15, 2016 at 05:48:18AM +0000, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> On Tue, Mar 15, 2016, 11:13 AM Jeff King <peff@peff.net> wrote:
> > The socket is inherently ephemeral, and designed to go
> > away after a few minutes (and the program designed to run sanely wh=
en it
> > does not exist).
>=20
> I agree.
>=20
> > So yes, when you switch from older git to newer git, you might
> > technically have a cache-daemon running that you _could_ contact, b=
ut
> > don't find it. But I don't think it's a big deal in practice, and n=
ot
> > worth designing around
>=20
> Yes, it's OK with git itself. What I worry about is that this change =
break
> some third-party tools. Does it matter?

I don't think so. I suppose one could have a script that tests for the
existence of the socket or something. But then, I don't think "use the
old directory if it exists" really solves that. Such a script would wor=
k
on people who had already run the old version of credential-cache, and
break on new ones.

-Peff
