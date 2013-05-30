From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Has anyone tried to implement git grep --blame?
Date: Thu, 30 May 2013 10:12:29 +0000 (UTC)
Message-ID: <loom.20130530T121036-210@post.gmane.org>
References: <CACBZZX5R=zaNBv4OGh30dxj+BAi26jDxDBO5pZTQ2QxGUB6WXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 12:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhzqr-0005dh-Va
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 12:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968061Ab3E3KMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 06:12:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:59196 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967701Ab3E3KMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 06:12:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Uhzqj-0005Yi-Jk
	for git@vger.kernel.org; Thu, 30 May 2013 12:12:49 +0200
Received: from epv99.neoplus.adsl.tpnet.pl ([83.20.63.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 May 2013 12:12:49 +0200
Received: from jnareb by epv99.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 May 2013 12:12:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.20.63.99 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.22 (KHTML, like Gecko) Ubuntu Chromium/25.0.1364.160 Chrome/25.0.1364.160 Safari/537.22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225953>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab <at> gmail.com> writes:

> This would be so much more convenient if git-grep supported it native=
ly:
>=20
> $ git grep -n 'if \(0\)' | perl -pe's/([^:]+):([^:]+).*/`git blame -L
> $2,$2 $1`/se'
> d18f76dc (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason 2010-08-17 09:24:38 =
+0000 2278)   if (0)
> 65648283 (David Brown 2007-12-25 19:56:29 -0800 433) if (0) {
>=20
> I.e. with all the coloring/pager interaction. Some Googling around
> reveals people piping things to git-blame like that, but has anyone
> made a stab at a smarter implementation (that would know to blame the
> whole file if it had lots of hits etc..).
>=20
> Don't know if I have time myself, but I'd be very pleased if someone
> hacked that up.

Errr... 'git blame -L' supports regexps as starting and ending point,
see git-blame(1) manpage:

    git blame -L '/^sub hello {/,/^}$/' foo

It does not color matching, though...
--=20
Jakub Nar=C4=99bski
