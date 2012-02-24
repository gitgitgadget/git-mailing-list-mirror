From: Jeff King <peff@peff.net>
Subject: Re: [BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 15:52:03 -0500
Message-ID: <20120224205203.GA21780@sigill.intra.peff.net>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
 <4F47E48D.4080501@in.waw.pl>
 <1330113345.2727.3.camel@rom-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org
To: Romain Vimont =?utf-8?B?KMKub20p?= <rom@rom1v.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S127q-0002wx-5x
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126Ab2BXUwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 15:52:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55993
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab2BXUwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:52:05 -0500
Received: (qmail 28635 invoked by uid 107); 24 Feb 2012 20:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 15:52:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 15:52:03 -0500
Content-Disposition: inline
In-Reply-To: <1330113345.2727.3.camel@rom-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191474>

On Fri, Feb 24, 2012 at 08:55:45PM +0100, Romain Vimont (=C2=AEom) wrot=
e:

> Tonight, I just tried something which do exactly what I wanted to do
> this morning:
>=20
> $ git checkout -b temp
> $ git commit -a -m 'My config file with mock_data=3Dtrue'
> $ git tag -a v0.1 -m v0.1
> $ git checkout master
> $ git branch -D temp

There is nothing at all wrong with the commands above, but you might be
interested to know that you can do it without the temporary branch:

  $ git commit -a -m 'My config...'
  $ git tag -m v0.1 v0.1
  $ git reset HEAD^

The final reset will rewind your branch tip and the index state to what
it was before the commit, but will leave the files in the working tree
untouched.

-Peff
