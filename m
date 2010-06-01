From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/checkout: clarify description
Date: Tue, 1 Jun 2010 02:10:47 -0400
Message-ID: <20100601061046.GA7360@sigill.intra.peff.net>
References: <20100530084153.GA5447@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 08:10:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJKgj-0007B4-Oi
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 08:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0FAGKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 02:10:53 -0400
Received: from peff.net ([208.65.91.99]:42227 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab0FAGKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 02:10:52 -0400
Received: (qmail 24669 invoked by uid 107); 1 Jun 2010 06:10:55 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Jun 2010 02:10:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jun 2010 02:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20100530084153.GA5447@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148080>

On Sun, May 30, 2010 at 03:41:53AM -0500, Jonathan Nieder wrote:

> To the first-time reader, it may not be obvious that =E2=80=98git che=
ckout=E2=80=99
> has two modes, nor that if no branch is specified it will read
> from the index.

OK, I can see how we might not explain the modes well, but...

> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 4505eb6..99bd7f2 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -15,26 +15,32 @@ SYNOPSIS
> =20
>  DESCRIPTION
>  -----------
> +Retrieves files from the index or specified tree and writes them
> +to the working tree.
> =20
> -When <paths> are not given, this command switches branches by
> -updating the index, working tree, and HEAD to reflect the specified
> -branch.

How is this first paragraph helping? It seems to be describing just one
mode. You then go on to describe each mode in turn, which makes sense,
but this first paragraph just seems out of place. If you're going to sa=
y
anything, you should say "there are two different modes, one for X and
one for Y. The first mode is...".

> +'git checkout' [-b <new branch>] [<branch>]::
> =20
> +	When <paths> are not given, this command switches branches by
> +	updating the index, working tree, and HEAD to reflect the
> +	specified branch.

In 76cfadf, I split this into

  git checkout [<branch>]
  git checkout -b <new branch> [<start_point>]

I wonder if we should do the same here (the distinction is that
<start_point> is treated differently from <branch>, especially with
respect to creating a detached HEAD).

Also, does it make sense to say "When <paths> are not given"? The "this
command" presumably refers to the one directly above, which has no
<paths>. Might it be easier to understand if we say "in this form of th=
e
command" or something like that? Since we are now listing each form in
turn, the user can presumably figure out which form they are trying to
use.

-Peff
