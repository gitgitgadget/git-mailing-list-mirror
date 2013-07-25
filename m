From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git and cyrillic branches
Date: Thu, 25 Jul 2013 18:28:51 +0400
Message-ID: <20130725182851.c17d3ed662434d1d91838949@domain007.com>
References: <922031374754788@web29h.yandex.ru>
	<20130725164522.f8841abf18742cc5f6e0fdbe@domain007.com>
	<992731374757601@web29h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>
To: =?KOI8-R?Q?=CB=D3=CF=D7=C9=D2=C1=CE?= <xowirun@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Jul 25 16:30:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2MYi-0002EU-Oy
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 16:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab3GYOaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 10:30:20 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:48111 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab3GYOaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 10:30:18 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6PEUEU4018918;
	Thu, 25 Jul 2013 18:30:15 +0400
X-Sieve: CMU Sieve 2.2
In-Reply-To: <992731374757601@web29h.yandex.ru>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231136>

On Thu, 25 Jul 2013 17:06:41 +0400
=CB=D3=CF=D7=C9=D2=C1=CE <xowirun@yandex.ru> wrote:

> >> =9Ahello! there is problem vith git and cyrillic (utf-8) names of
> >> =9Abranches. branch creates perfectly, but when i clone this remot=
e
> >> =9Abranch to local host, there are 2 bugs:
> >> =9A1) "git branch" doesnt show checked branch with asterisk (while=
 on
> >> =9Aremote server it does)
> >> =9A2) "git push" gives 2 errors: "fatal: BRANCH_NAME cannot be
> >> resolved to branch." and "fatal: The remote end hung up
> >> unexpectedly" thanks.
> >
> > Works for me across two Debian systems: both have Git 1.7.10.4; use=
r
> > accounts on both systems have LANG=3Den_US.UTF-8 configured in thei=
r
> > environment.
> >
> > Do both of your systems (local and remote) have an UTF-8-enabled (o=
r
> > encoding-agnostic, like "C") locale active?
>
> oh, yes indeed. i was pushing from mac to ubuntu, but ubuntu to
> ubuntu works fine. although #locale gives almost identical output, so
> it is something to work out. =D3=D0=C1=D3=C9=C2=CF =DA=C1 =D0=CF=CD=CF=
=DD=D8! 25.07.2013, 16:45,

I'm afraid, this might be not that simple: Git received certain tweaks
to work around certain problems Mac OS X has (as I understand it) with
handling UTF-8 on various filesystems it supports; in particular, see
commits 76759c7dff53e8c84e975b88cb8245587c14c7ba [1]
and b856ad623e4f686815986c0b9341dd1bfd791e71 [2] which were released as
part of v1.7.12.

So... I'm not sure, but I beleive these fixes might have been related t=
o
handling filenames in the work tree and the index only, not branches, a=
s
having branches with non-ASCII names is a weird idea to most
developers, I think.  So the question is: do you have Git >=3D 1.7.12 o=
n
your Mac OS X machine?  If so, do you still experience this problem (I
think that Macs do not have non-UTF-8 locales anyway, so this is
unlikely the root cause).

P.S.
Please don't top-post as this breaks discussion flow and hence sucks.

1. https://github.com/git/git/commit/76759c7
2. https://github.com/git/git/commit/b856ad6
