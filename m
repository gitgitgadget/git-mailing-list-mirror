From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCHv2 2/2] parse-options: simplify usage argh handling
Date: Sat, 06 Jun 2009 12:30:19 +0200
Message-ID: <4A2A453B.7060202@lsrfire.ath.cx>
References: <4A26DBA3.90604@lsrfire.ath.cx> <1244159037-9292-1-git-send-email-bebarino@gmail.com> <1244159037-9292-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 12:36:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCtG6-0000Ny-82
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 12:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbZFFKa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 06:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbZFFKa1
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 06:30:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:38252 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZFFKa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 06:30:26 -0400
Received: from [10.0.1.101] (p57B7E4B1.dip.t-dialin.net [87.183.228.177])
	by india601.server4you.de (Postfix) with ESMTPSA id 99F5A2F818A;
	Sat,  6 Jun 2009 12:30:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1244159037-9292-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120907>

Stephen Boyd schrieb:
> Simplify the argh printing by simply calling usage_argh() if the opti=
on
> can take an argument. Update macros defined in parse-options.h to set
> the PARSE_OPT_NOARG flag.
>=20
> The only other user of custom non-argument taking options is git-appl=
y
> (in this case OPTION_BOOLEAN for deprecated options). Update it to se=
t
> the PARSE_OPT_NOARG flag.
>=20
> Thanks to Ren=C3=A9 Scharfe for the suggestion and starter patch.
>=20
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>=20
> Ren=C3=A9, feel free to signoff if you like.
>=20
>  builtin-apply.c |    6 ++++--
>  parse-options.c |   33 ++++-----------------------------
>  parse-options.h |   20 +++++++++++++-------
>  3 files changed, 21 insertions(+), 38 deletions(-)

Looks good, thanks.  The output of this command:

	$ for c in ./git-*; do $c --help-all </dev/null; done

didn't change, except for git-send-email reporting a different temporar=
y
file name (unrelated to this patch, of course).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
