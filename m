From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5705: Use the correct file:// URL
Date: Thu, 13 Nov 2014 04:17:24 -0500
Message-ID: <20141113091724.GB8329@peff.net>
References: <54645F67.30008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 10:17:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoqWy-0007Ov-SR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 10:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbaKMJR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 04:17:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:39792 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753629AbaKMJR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 04:17:26 -0500
Received: (qmail 18159 invoked by uid 102); 13 Nov 2014 09:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 03:17:27 -0600
Received: (qmail 21968 invoked by uid 107); 13 Nov 2014 09:17:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 04:17:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 04:17:24 -0500
Content-Disposition: inline
In-Reply-To: <54645F67.30008@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 08:36:07AM +0100, Torsten B=C3=B6gershausen wro=
te:

> A URL like file;//. is (no longer) supported by Git:
> Typically there is no host, and RFC1738 says that file:///<path>
> should be used.
>=20
> Update t5705 to use a working URL.

Interesting. This looks like it was unintentionally lost in c59ab2e
(connect.c: refactor url parsing, 2013-11-28). Given RFC1738, and that
this is the first notice of it (and that it is not even a real use case=
,
but something questionable in the test script), it's probably OK to
declare the syntax dead and not treat it like a regression.

-Peff
