From: Francis Galiegue <fg@one2team.net>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Mon, 10 Nov 2008 08:57:10 +0100
Organization: One2team
Message-ID: <200811100857.10802.fg@one2team.net>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:58:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzRfc-00083b-2C
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 08:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYKJH5d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 02:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbYKJH5d
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 02:57:33 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:42663 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbYKJH5c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 02:57:32 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-83-86.w90-20.abo.wanadoo.fr [90.20.70.86])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 03F7B92C003;
	Mon, 10 Nov 2008 08:57:27 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100497>

Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =E9crit=A0:
[...]
> +	my @recipients =3D split(/\s*,\s*/, $match);

This is where it gets complicated, for the "hey, I am" <some@one> case.=
=2E.

But then there is a solution: use a negative lookahead for the split re=
gex.

I thought about splitting against /\s*,\s*(?![^"]+(?:\"[^*]*)*)"/.

A negative lookbehind would have been clearer to write, but perl doesn'=
t=20
support arbitrary length negative lookbehinds, except by using a very, =
very=20
arcane construct.


--=20
fge
