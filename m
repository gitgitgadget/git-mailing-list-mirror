From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 2/5] path.c: implement xdg_runtime_dir()
Date: Fri, 25 Mar 2016 13:55:10 -0400
Message-ID: <20160325175510.GA10563@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
 <1458728005-22555-2-git-send-email-huiyiqun@gmail.com>
 <20160325095923.GB8880@sigill.intra.peff.net>
 <CAKqreux8FHdJoKDishjQkbi9g1oUc265EUK4nOJ_sgeFivGSNA@mail.gmail.com>
 <xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>,
	Git List <git@vger.kernel.org>,
	Your friend <pickfire@riseup.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:55:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVxC-00075D-00
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbcCYRzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 13:55:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:38413 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753313AbcCYRzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:55:13 -0400
Received: (qmail 4251 invoked by uid 102); 25 Mar 2016 17:55:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 13:55:12 -0400
Received: (qmail 26094 invoked by uid 107); 25 Mar 2016 17:55:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 13:55:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 13:55:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpoui4huo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289916>

On Fri, Mar 25, 2016 at 09:55:59AM -0700, Junio C Hamano wrote:

> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>=20
> >> There's a lot of "what" here that the caller doesn't really care a=
bout,
> >> and which may go stale with respect to the implementation over tim=
e. Can
> >> we make something more succinct like:
> >>
> >>   /*
> >>    * Return a path suitable for writing run-time files related to =
git,
> >>    * or NULL if no such path can be established. The resulting str=
ing
> >>    * should be freed by the caller.
> >>    */
> >>
> >> ?
> >
> > That's clearer, but if I were the caller, I would worry about the
> > security of the path.
> > How about adding:
> >
> > The security of the path is ensured by file permission.
>=20
> Is "by file permission" descriptive enough?
>=20
> To protect /a/b/c/socket, what filesystem entities have the right
> permission bits set?  If the parent directory is writable by an
> attacker, the permission bits on 'socket' itself may not matter as
> the attacker can rename it away and create new one herself, for
> example.

I think that is discussed elsewhere, and referring to the xdg document
is enough. My main point is that the docstring about a function should
tell a potential caller what they need to know to use it, but if it get=
s
overly long, that information is lost in the noise.

-Peff
