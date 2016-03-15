From: Jeff King <peff@peff.net>
Subject: Re: [GSOC] Microproject "Move ~/.git-credential-cache to
 ~/.config/git"
Date: Mon, 14 Mar 2016 23:13:00 -0400
Message-ID: <20160315031259.GA20508@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <xmqqshztawwd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuwgxzVTAUdZPf9+ivXCdW8F2Ksafw7V0pbLAaRPwGX9Uw@mail.gmail.com>
 <xmqqwpp494vd.fsf@gitster.mtv.corp.google.com>
 <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 04:13:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1affPx-0006U8-GP
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 04:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbcCODNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 23:13:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:59542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753456AbcCODNE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 23:13:04 -0400
Received: (qmail 12811 invoked by uid 102); 15 Mar 2016 03:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Mar 2016 23:13:02 -0400
Received: (qmail 30528 invoked by uid 107); 15 Mar 2016 03:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Mar 2016 23:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2016 23:13:00 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuw0hafi-GwWD-UaGKwmG8xVK6ZJDcw2jpQXAAuK+XBZvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288831>

On Tue, Mar 15, 2016 at 09:32:21AM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> > You sound like you think it is better to check the location of the
> > existing socket,
>=20
> Yes, for the purpose of compatibility, it's the only choice, as I can=
 see.

I'm not sure the existing socket location matters, in the way that it
does for config. The socket is inherently ephemeral, and designed to go
away after a few minutes (and the program designed to run sanely when i=
t
does not exist).

So yes, when you switch from older git to newer git, you might
technically have a cache-daemon running that you _could_ contact, but
don't find it. But I don't think it's a big deal in practice, and not
worth designing around.

So I think it would be OK to just switch the default path to wherever
XDG recommends ephemeral stuff to go (which sounds like
$XDG_RUNTIME_DIR) and be done.

-Peff
