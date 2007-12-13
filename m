From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] parseopt: Add a gitcli(5) man page.
Date: Thu, 13 Dec 2007 12:04:08 +0100
Message-ID: <A78DF383-1BD5-4AED-9DE8-60B8E96E54B5@wincent.com>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <20071213102636.GD12398@artemis.madism.org> <20071213102724.GE12398@artemis.madism.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 12:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2lrs-0001gX-UD
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 12:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXLMLES convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2007 06:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXLMLES
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 06:04:18 -0500
Received: from wincent.com ([72.3.236.74]:46904 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbXLMLER convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 06:04:17 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDB49wg017023;
	Thu, 13 Dec 2007 05:04:10 -0600
In-Reply-To: <20071213102724.GE12398@artemis.madism.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68141>

El 13/12/2007, a las 11:27, Pierre Habouzit escribi=F3:

> This page should hold every information about the git ways to parse =20
> command
> lines, and best practices to be used for scripting.

Some feedback from a native English speaker follows...

> @@ -0,0 +1,104 @@
> +gitcli(5)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +gitcli - git command line interface and its usual conventions

"git command line interface and conventions" sounds better; the =20
"usual" is redundant.

Or did you mean "*usage* conventions"? If that is the case, "git =20
command line interface and usage" is better, but just "git command =20
line interface" is enough.

> +DESCRIPTION
> +-----------
> +This manual intends to describe best practice in how to use git =20
> CLI.  Here are
> +the rules that you should follow when you are scripting git:

Suggest "how to use the git CLI".

> + * it's preferred to use the non dashed form of git commands, which =
=20
> means that
> +   you should prefer `"git foo"` to `"git-foo"`.

"non-dashed", and in any case, this could be more concise. How about:

* the non-dashed form of git commands is preferred; use `"git foo"` =20
rather than
  `"git-foo"`

> + * splitting short option switches in separate atoms (prefer `"git =20
> foo -a -b"`
> +   to `"git foo -ab"`, the latter may not even work).

"*split* short option switches *into* separate atoms"

And the comma before "the latter may not even work" should be a semi-=20
colon.

> + * when a command line switch takes an argument, use the 'sticked' =20
> form, which
> +   means that you must prefer `"git foo -oArg"` to `"git foo -o =20
> Arg"` for short
> +   option switches, and `"git foo --long-opt=3DArg"` to `"git foo --=
=20
> long-opt Arg"`
> +   for long switches.

Again this could be more concise. Instead of:

	"which means that you must prefer .... to ..."

you could just say:

	"use ... instead of ..."

> +ENHANCED CLI
> +------------
> +From the git 1.5.4 series and further, git commands (not all of =20
> them at the
> +time of the writing though) come with an enhanced option parser =20
> with nice
> +facilities. Here is an exhaustive list of them

How about:

"From git 1.5.4 onwards, many git commands come with an enhanced =20
option parser..."

> +Magic Options
> +~~~~~~~~~~~~~
> +Commands which have the enhanced option parser activated all =20
> understand a
> +couple of magic command line switches:

"Commands which use the enhanced option parser all understand..."

> +
> +-h::
> +	gives a pretty printed usage of the command.

"pretty-printed"

> +--help-all::
> +	Some git commands takes options that are only used for plumbing or =
=20
> that
> +	are deprecated, and such options are hidden from the default =20
> usage. This
> +	switch gives the full list of options.

"Some git commands *take* options that are deprecated or used only =20
*by* plumbing"

And:

"such options are *not included in* the default usage" ("hidden from" =20
sounds awkward).

> +Negating options
> +~~~~~~~~~~~~~~~~
> +Another things to keep in mind is that long options can be negated.

"Another *thing*"

But you could replace the whole sentence with just:

"Long options can be negated."

> +Separating argument from the switch
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"Separating *the* argument from the switch"

Or if you prefer

"Separating *arguments* from the *switches*"

> +However, this is *NOT* possible for switches with an optionnal =20
> value, where the
> +'sticked' form must be used:

Typo: "optional"

>
Cheers,
Wincent
