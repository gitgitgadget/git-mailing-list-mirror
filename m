From: Jeff King <peff@peff.net>
Subject: Re: Improving the git remote command
Date: Tue, 26 Aug 2014 08:40:27 -0400
Message-ID: <20140826124027.GE29180@peff.net>
References: <53FC537C.4080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UsOpbXk=?= Hubscher <hubscher.remy@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMG36-0006vw-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbaHZMk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2014 08:40:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:59168 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754540AbaHZMk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:40:28 -0400
Received: (qmail 16874 invoked by uid 102); 26 Aug 2014 12:40:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 07:40:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 08:40:27 -0400
Content-Disposition: inline
In-Reply-To: <53FC537C.4080206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255897>

On Tue, Aug 26, 2014 at 11:29:32AM +0200, R=C3=A9my Hubscher wrote:

> I'd like to add a list parameter to the `git remote` command.
>=20
> We already have:
> =20
>  - `git remote add`
>  - `git remote rename`
>  - `git remote delete`
>=20
> I often write `git remote list` before finaly using `git remote -v` b=
ut
> it isn't intuitive.

Right now the list operation is done by giving no arguments at all. Thi=
s
is a bit unlike other parts of git, which would usually define "git
remote list" and then say that if no command is given, "list" is the
default.

But...

> I am proposing to add `git remote list` as a shortcut for `git remote=
 -v`

This is somewhat different. I would have expected "git remote list" to
do the same thing as "git remote" (i.e., list without "-v"). I guess it
does not have to, though.

Perhaps "-v" should have been the default all along.  I do not use "git
remote" myself, so I don't know if "-v" is what most people use. But
changing the output of "git remote" now is probably a bad thing (I
expect some people may depend on parsing it to get the list of remotes;
they should probably use the git-config plumbing to do the same thing,
but it's actually rather tricky to do it that way).

-Peff
