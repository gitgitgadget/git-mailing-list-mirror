From: Jeff King <peff@peff.net>
Subject: Re: t7061: comments and one failure
Date: Sat, 5 Jan 2013 06:24:33 -0500
Message-ID: <20130105112432.GA14666@sigill.intra.peff.net>
References: <50E8096C.7000501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: apelisse@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 05 12:25:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrRsA-0001YB-JI
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 12:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab3AELYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 06:24:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43595 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab3AELYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 06:24:47 -0500
Received: (qmail 26222 invoked by uid 107); 5 Jan 2013 11:25:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 06:25:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 06:24:33 -0500
Content-Disposition: inline
In-Reply-To: <50E8096C.7000501@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212686>

On Sat, Jan 05, 2013 at 12:07:24PM +0100, Torsten B=C3=B6gershausen wro=
te:

> TC 9 is failing (Mac OS X 10.6),

Yeah, I can reproduce the problem here on my OS X test box. It seems to
be related to core.ignorecase. If you put

  git config core.ignorecase false

at the top of t7061, it passes on OS X. Likewise, if you set it to true=
,
it will start failing on Linux.

So it looks like a real bug, not a test-portability issue.

> Looking into the code, there are 2 questions:
>=20
> 1) echo "ignored" >.gitignore &&
>   We don't need the quoting of a simple string which does not have sp=
ace in it.

No, but it does not hurt anything.

> 2)  : >untracked/ignored &&
> Do we need the colon here?

No, but it does not hurt anything.

-Peff
