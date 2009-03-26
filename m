From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] init: support --import to add all files and commit
	right after init
Date: Thu, 26 Mar 2009 05:57:16 -0400
Message-ID: <20090326095716.GD14292@coredump.intra.peff.net>
References: <1238060943-4694-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:59:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmMb-0003VS-PF
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937AbZCZJ5a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757721AbZCZJ5a
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:57:30 -0400
Received: from peff.net ([208.65.91.99]:60007 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757886AbZCZJ53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:57:29 -0400
Received: (qmail 13270 invoked by uid 107); 26 Mar 2009 09:57:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Mar 2009 05:57:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2009 05:57:16 -0400
Content-Disposition: inline
In-Reply-To: <1238060943-4694-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114764>

On Thu, Mar 26, 2009 at 08:49:03PM +1100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> This is equivalent to "git init;git add .;git commit -q -m blah".
> I find myself doing that too many times, hence this shortcut.

This version looks OK to me, but I have a few comments:

>  Hopefully I don't make any mistake this time. -m will not take any a=
rgument
>  for two reasons:
>=20
>   - optional argument for short options does not appear anywhere in g=
it AFAIK.
>     let's not make parse-opt migration more difficult with -mfoo or -=
m=3Dfoo

shortlog's -w has optional arguments (and is the option that spawned th=
e
discussion that led to Pierre writing the gitcli(7) text, IIRC). So
parse-options does handle it, but you _cannot_ say "-m foo" anymore.

> +-m::
> +--import[=3D<message>]::

Nit: -m made sense when it specified a message. But now that it doesn't
take a message, maybe "-i" would be more appropriate?

> +If `-m` is used or no message is given to `--import`, "Initial commi=
t" will be used.

Style nit: long line.

-Peff
