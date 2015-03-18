From: Jeff King <peff@peff.net>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 17:07:06 -0400
Message-ID: <20150318210706.GB3376@peff.net>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <5509904A.2000606@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLBK-0007HG-FE
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbbCRVHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 17:07:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:34849 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755401AbbCRVHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 17:07:09 -0400
Received: (qmail 32674 invoked by uid 102); 18 Mar 2015 21:07:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 16:07:08 -0500
Received: (qmail 7024 invoked by uid 107); 18 Mar 2015 21:07:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 17:07:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 17:07:06 -0400
Content-Disposition: inline
In-Reply-To: <5509904A.2000606@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265758>

On Wed, Mar 18, 2015 at 03:48:42PM +0100, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD=
 =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 wrote:

> #ls .git/objects/17/*  | wc -l
> 30
>=20
> 30 * 256 =3D 7 680 > 6 700
>=20
> And now?  Do I have to run git gc --aggressive ?

No, aggressive just controls the time we spend on repacking. If the
guess is correct that the objects are kept because they are unreachable
but "recent", then shortening the prune expiration time would get rid o=
f
them. E.g., "git gc --prune=3D1.hour.ago".

That does not solve the underlying problem discussed elsewhere in the
thread, but it would make this particular instance of it go away. :)

-Peff
