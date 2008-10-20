From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH, RFC] diff: add option to show context between close chunks
Date: Mon, 20 Oct 2008 16:32:37 +0200
Message-ID: <48FC9685.8030704@viscovery.net>
References: <48FB757B.9030105@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:49:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrvrA-0006wZ-Fm
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 16:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYJTOcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Oct 2008 10:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbYJTOcm
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 10:32:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23662 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYJTOcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 10:32:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KrvoD-00029M-Hq; Mon, 20 Oct 2008 16:32:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4DF616B7; Mon, 20 Oct 2008 16:32:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48FB757B.9030105@lsrfire.ath.cx>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98704>

Ren=E9 Scharfe schrieb:
> This patch adds a new diff option, --inter-chunk-context.  It can be
> used to show the context in gaps between chunks, thereby creating a
> big chunk out of two close chunks, in order to have an unbroken
> context, making reviews easier.
>=20
> With --inter-chunk-context=3D1, patches have the same number of lines
> as without the option, as only the chunk header is replaced by the
> context line it was shadowing.
>=20
> You can use commit b0b44bc7b26c8c4b4221a377ce6ba174b843cb8d in the
> git repo to try out this option; there's a chunk in transport.c
> which is just one line away from the next.  (I found this option
> helpful in reviewing my own patch before sending. :)
>=20
> I think it makes sense to make 1, or even 3, the default for this
> option for all commands that create patches intended for human
> consumption.  The patch keeps the default at 0, though.
>=20
> There are downsides, of course: values higher than 1 potentially make
> the resulting patch longer.  More context means a higher probability
> of (perhaps unnecessary) merge conflicts.
>=20
> Comments?

Why can't you just use -U6 instead instead of --inter-chunk-context=3D3=
? If
this is intended for human consumption anyway, then you can just as wel=
l
increase the overall number of context lines: You get extra context lin=
es
in the places where hunks are not fused, but this cannot be a disadvant=
age
for the targeted audience.

-- Hannes
