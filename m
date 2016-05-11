From: Jeff King <peff@peff.net>
Subject: Re: t5551 hangs ?
Date: Wed, 11 May 2016 13:31:31 -0400
Message-ID: <20160511173130.GA29731@sigill.intra.peff.net>
References: <cover.1462774709.git.johannes.schindelin@gmx.de>
 <cover.1462863934.git.johannes.schindelin@gmx.de>
 <ff8cbab7e62211b13835e520d402fbd89b90849e.1462863934.git.johannes.schindelin@gmx.de>
 <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed May 11 19:31:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Xz1-0002WI-4O
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 19:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbcEKRbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 13:31:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:38143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751805AbcEKRbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 13:31:34 -0400
Received: (qmail 25408 invoked by uid 102); 11 May 2016 17:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 13:31:33 -0400
Received: (qmail 2301 invoked by uid 107); 11 May 2016 17:31:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 May 2016 13:31:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2016 13:31:31 -0400
Content-Disposition: inline
In-Reply-To: <db56fae5-799a-29af-3a0f-a7b5c671063a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294355>

On Wed, May 11, 2016 at 07:13:56PM +0200, Torsten B=C3=B6gershausen wro=
te:

> On 10.05.16 09:08, Johannes Schindelin wrote:
> - I'm not sure, if this is the right thread to report on -
>=20
> It seems as if t5551 is hanging ?
> This is the last line from the log:
> ok 25 - large fetch-pack requests can be split across POSTs

Are you running the tests with "--long" or GIT_TEST_LONG in the
environment? The next line should show it skipping test 26 unless one o=
f
those is set.

If you are, can you confirm that it's actually hanging, and not just
slow? On my system, test 26 takes about a minute to run (which is why w=
e
don't do it by default).

> I have 7 such processes running:
> /trash directory.t5551-http-fetch-smart/httpd -f
> /Users/tb/projects/git/git.pu/t/lib-httpd/apache.conf -DDarwin -c Lis=
ten
> 127.0.0.1:5551 -k start

That's normal while the test is running; apache pre-forks a bunch of
worker threads.

-Peff
