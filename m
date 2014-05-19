From: Jeff King <peff@peff.net>
Subject: Re: Any difference to unstage files using "git checkout" and "git rm"
Date: Mon, 19 May 2014 12:45:27 -0400
Message-ID: <20140519164526.GA27176@sigill.intra.peff.net>
References: <6833494.47nikG189t@linux-wzza.site>
 <2484900.5bGOI3HfEm@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 18:45:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQhD-0007s9-8q
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbaESQpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 12:45:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:55105 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754384AbaESQp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:45:29 -0400
Received: (qmail 27881 invoked by uid 102); 19 May 2014 16:45:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 May 2014 11:45:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 May 2014 12:45:27 -0400
Content-Disposition: inline
In-Reply-To: <2484900.5bGOI3HfEm@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249597>

On Mon, May 19, 2014 at 09:27:47PM +0630, Arup Rakshit wrote:

> > Is there any difference between the below 2 commands ? I didn't see
> > anything.
> >=20
> > git rm --cached  -- <file1> .. <fileN>
> > git checkout  -- <file1> .. <fileN>
>=20
> Please Ignore the previous.

Too late. :)

> I apologize to rewriting and increase the load of this mailing list. =
I=20
> actually wanted to ask the below=20
>=20
> git rm -- cached  -- <file1> .. <fileN>
> git reset HEAD  <file1> .. <fileN>=EF=BB=BF

OK, this is a more sensible comparison.

The first command will remove the entries from the index entirely, and
the second one will return them to their state in HEAD. So _if_ the
existing commit in HEAD did not have the files at all, the two are
identical.

But if the files were committed previously, then the second command wil=
l
return them to that state, not remove them entirely.

Does that make sense?

-Peff
