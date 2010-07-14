From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git-svn returning "Incomplete data: Delta source ended
	unexpectedly"
Date: Wed, 14 Jul 2010 21:09:40 +0000
Message-ID: <20100714210940.GA7803@dcvr.yhbt.net>
References: <AANLkTiljzOuaEToKscBxlc4qGilyNRiUtjoBxW1lJZlp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 23:09:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ9D9-00033h-6n
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 23:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab0GNVJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 17:09:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34310 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab0GNVJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 17:09:41 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A631F449;
	Wed, 14 Jul 2010 21:09:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTiljzOuaEToKscBxlc4qGilyNRiUtjoBxW1lJZlp@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151035>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> wrote:
> I run a SVN -> Git mirror which fetches & rebases with git-svn and
> pushes the result to GitHub:
>=20
>     http://github.com/avar/openstreetmap-mirror/blob/master/josm-mirr=
or.sh
>=20
> Something about what that script is doing corrupted the git-svn
> repository, likely due to a git-svn bug. Now when I do git svn fetch
> on 1.7.1:
>=20
>     $ git svn fetch
>     Incomplete data: Delta source ended unexpectedly at
> /usr/lib/git-core/git-svn line 5061

The geticons.pl file on the git side doesn't match what SVN expects
when doing a delta.

> I re-cloned the repository and started running my mirror again from
> that. But it would be nice if we could track this bug down.
>=20
> Here's a copy of the repository:
>=20
>     http://v.nix.is/~avar/josm.old.tar.gz
>=20
> Unpacking it and running git svn fetch will yield the same error on
> another box I have with 1.7.1.

Something went wrong with your mirror script (the way you're doing
externals is probably screwing it up, badly).

Compare the "git svn log" output of your in-progress repository
with the "svn log http://josm.openstreetmap.de/svn/trunk"

The revision numbers/commit messages don't sync up at all.

--=20
Eric Wong
