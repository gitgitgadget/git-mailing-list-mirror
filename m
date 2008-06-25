From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Keep some git-* programs in $(bindir)
Date: Wed, 25 Jun 2008 00:17:47 -0400
Message-ID: <20080625041747.GC11793@spearce.org>
References: <alpine.DEB.1.00.0806241709330.9925@racer> <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMTU-0005rw-UJ
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbYFYESH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 00:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbYFYESG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:18:06 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38967 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYFYESF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 00:18:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBMS5-0005KA-9G; Wed, 25 Jun 2008 00:17:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B21120FBAE; Wed, 25 Jun 2008 00:17:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86215>

Junio C Hamano <gitster@pobox.com> wrote:
>  * =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 <n=
anako3@lavabit.com> writes:
>  > Doesn't "git archive --remote=3D<repo>" also execute git program o=
n a remote machine?
>=20
> diff --git a/Makefile b/Makefile
> index 929136b..742e7d3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1268,7 +1268,7 @@ install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
> -	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-archive$X=
 '$(DESTDIR_SQ)$(bindir_SQ)'

I think you mean git-upload-archive, given what daemon.c says.
Or line 34 of builtin-archive.c, which calls git-upload-archive
by way of git_connect().

--=20
Shawn.
