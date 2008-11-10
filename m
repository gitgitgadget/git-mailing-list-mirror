From: Francis Galiegue <fg@one2team.net>
Subject: Re: [PATCH] very small cleanup: #undef a macro that isn't used anywhere else
Date: Mon, 10 Nov 2008 20:09:58 +0100
Organization: One2team
Message-ID: <200811102009.58332.fg@one2team.net>
References: <200811101928.27207.fg@one2team.net> <alpine.DEB.1.00.0811102008330.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 20:12:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzcAn-000647-Po
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 20:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbYKJTK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 14:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbYKJTK1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 14:10:27 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:48459 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbYKJTK0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 14:10:26 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-115-179.w90-20.abo.wanadoo.fr [90.20.190.179])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 56D3692C003;
	Mon, 10 Nov 2008 20:10:15 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0811102008330.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100545>

Le Monday 10 November 2008 20:09:21 Johannes Schindelin, vous avez =E9c=
rit=A0:
> Hi,
>
> On Mon, 10 Nov 2008, Francis Galiegue wrote:
> > In xdiff-interface.c, the FIRST_FEW_BYTES macro is defined, is neve=
r
> > used anwhere else, so we might as well undefine it after we're done=
 with
> > it.
>
> Would not the consequence be that we end up with a ton of #undefines =
all
> over the place, reducing readability incredibly?
>

Hmwell, this is a twofold argument, I guess...

* for: the macro is defined, not undefined: it means that potentially, =
it can=20
be used somewhere else in the file; but it isn't (in this case);
* against: macros defined in a C file only ever have scope in said file=
=20
(unless so mischievous Makefile cats two C files together before compil=
e and=20
file order is important -- but git doesn't do that), so why #undefine=20
anything?

Personally, I'm with the first argument. YMMV, of course.

--=20
fge
