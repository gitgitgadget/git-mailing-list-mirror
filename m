From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Can't clone Linus tree
Date: Mon, 24 Jul 2006 11:55:58 +0200
Message-ID: <44C4992E.3070706@lsrfire.ath.cx>
References: <20060724080752.GA8716@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Jul 24 11:56:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4xAe-0001nh-Gg
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 11:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWGXJ4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 24 Jul 2006 05:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWGXJ4L
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 05:56:11 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:6857
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751111AbWGXJ4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:09 -0400
Received: from [10.0.1.3] (p508E7BBB.dip.t-dialin.net [80.142.123.187])
	by neapel230.server4you.de (Postfix) with ESMTP id 257B11801A;
	Mon, 24 Jul 2006 11:56:08 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Tomasz Torcz <zdzichu@irc.pl>
In-Reply-To: <20060724080752.GA8716@irc.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24136>

Tomasz Torcz schrieb:
>  Hi,
>=20
>  yesterdat I wanted to bisect my kernel problem, but failed at first =
step:
> cloning Linus' tree. Today I tried it on other system and also failed=
=2E
>=20
>  This is git-1.4.0 on Slackware, i586:
>=20
> %  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux-2.6.git linux-git
> fatal: packfile '/home/zdzichu/linux-git/.git/objects/pack/tmp-1jI4AH=
' SHA1 mismatch
> error: git-fetch-pack: unable to read from git-index-pack
> error: git-index-pack died with error code 128
> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux-2.6.git' failed.
>=20
>  And this is 1.4.0-1.fc5 on FC5, x86_64:
> % git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux-2.6.git linux-git
> fatal: packfile '/home/tomek/linux-git/.git/objects/pack/tmp-BxIcIC' =
SHA1 mismatch
> error: git-fetch-pack: unable to read from git-index-pack
> error: git-index-pack died with error code 128
> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torval=
ds/linux-2.6.git' failed.
>=20
>  Errors occur constantly since yesterday. They of course appear after
> downloading several megabytes of data, which is unpleasant on my 128k=
bps
> connection.

Same here with both the master and next branch of git.  rsync as
suggested by Johannes Weiner works.  You can change the protocol
back to git in .git/remotes/origin after cloning; pulling small
changes seems to work fine.

strace tells me that safe_read at pkt-line.c:111 gets only 305 of
the expected 996 bytes and then dies.  I have no idea how that
might happen. :-/

Pulling the git repository works using the git protocol, btw.

Ren=E9
