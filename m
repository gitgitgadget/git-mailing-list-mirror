From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <jn.avila@free.fr>
Subject: Re: [PATCH] t9902: Instruct git-completion.bash about a test mode
Date: Thu, 24 Jan 2013 23:56:23 +0100
Message-ID: <201301242356.23512.jn.avila@free.fr>
References: <201301242220.09067.jn.avila@free.fr> <201301242304.16078.jn.avila@free.fr> <7vlibi8baq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 23:56:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyVj1-0004o2-M8
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 23:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab3AXW4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 17:56:30 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:42478 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756448Ab3AXW43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 17:56:29 -0500
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 2061A4B00CA;
	Thu, 24 Jan 2013 23:56:21 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc4jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vlibi8baq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214468>

Le jeudi 24 janvier 2013 23:29:33, Junio C Hamano a =C3=A9crit :
> "Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:
>=20
> > My rational was to be sure to put the environment variable out of t=
he=20
> > way once the script has been sourced. I can make two alternative=20
> > definitions of __git_list_all_commands () depending on the presence=
 of=20
> > $AUTHORIZED_CMD_LIST if you are worried about performance.
>=20
> Actually, it does not matter, as once __git_list_all_commands is
> run, its result is kept in a variable.
>=20
> So Peff's
>=20
>   if test -z "$FAKE_COMMAND_LIST"; then
>           __git_cmdlist() {
>                   git help -a | egrep '^  [a-zA-Z0-9]'
>           }
>   else
>           __git_cmdlist() {
>                   printf '%s' "$FAKE_COMMAND_LIST"
>           }
>   fi
>=20
> would be just as simple if not simpler, does the same thing, and is
> sufficient, I think.
>=20
> The t9902 test is only interested in making sure that the completion
> works, and we do not want "git help -a" that omits a subcommand from
> its output that is not built in your particular environment to get
> in the way, which will not be an issue with this approach.
>=20


Ah. I totally missed the point. I though that the requested change was
to intersect the list needed for the test with the one provided by the=20
standard completion.
