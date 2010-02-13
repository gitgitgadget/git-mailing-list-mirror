From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 06:25:57 -0500
Message-ID: <20100213112557.GA5165@coredump.intra.peff.net>
References: <4B768807.3030003@gmail.com>
 <20100213112342.GA1299@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:26:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgG8O-0005Nj-JS
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0BMLZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 06:25:56 -0500
Received: from peff.net ([208.65.91.99]:52983 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab0BMLZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 06:25:55 -0500
Received: (qmail 13505 invoked by uid 107); 13 Feb 2010 11:26:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 13 Feb 2010 06:26:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2010 06:25:57 -0500
Content-Disposition: inline
In-Reply-To: <20100213112342.GA1299@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139785>

On Sat, Feb 13, 2010 at 06:23:43AM -0500, Jeff King wrote:

> On Sat, Feb 13, 2010 at 12:07:51PM +0100, Bj=C3=B6rn Gustavsson wrote=
:
>=20
> > diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> > index cd43c34..4eb7c7c 100755
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > @@ -1439,6 +1439,8 @@ sub patch_update_file {
> >  					 !defined $hunk[$ix]{USE});
> >  			}
> >  		}
> > +	} continue {
> > +		print "\n" x 4, '=3D' x 72, "\n";
> >  	}
> > =20
> >  	@hunk =3D coalesce_overlapping_hunks(@hunk);
>=20
> Wow, I find this terrifically ugly. I guess you don't use

Side note. Even if we did want to do something like this, your
implementation is probably not the right way. It will print the huge
"=3D=3D=3D" separator even after the last hunk. You would want to keep =
a
"$shown_any" variable and output the separator before showing a hunk
instead.

-Peff
