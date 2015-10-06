From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [BUG?] parallel make interdepencies
Date: Tue, 06 Oct 2015 15:13:05 +0200
Organization: gmx
Message-ID: <e76ba2a01053392526a499ec9bff0d37@dscho.org>
References: <56138273.6010204@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 06 15:13:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjS3R-0001Ie-64
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 15:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbbJFNNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 09:13:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:65224 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbbJFNNK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 09:13:10 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LpKY5-1aExWR0AMP-00fCed; Tue, 06 Oct 2015 15:13:06
 +0200
In-Reply-To: <56138273.6010204@drmicha.warpmail.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:PpYjvOjTAlyavtdQztziXJ+xF1JBESOlCg4NmiSgXBZY6kFOxIV
 tLAZpi8LOeqcjEYC3LIwb8OG8sLZTdhf25jj8Xj+h+e0ygQfZn8iP0boCseY0p7HzVt6CtP
 vGFhKWSYGul5LW26nrUQb0Ykov0dPfNkCF6fLNCHjXVEJTYWkl5GSobvW8fk6j6aLKQHliV
 mO+Wd6FKgyv2s5pRS1cww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wooT5vNDo0M=:sYJA/FS8DnhzuOVESyX+VY
 y7mbW759Q+Jik1W9lBFCJvD5fcEcXDHy+RYZiLoVsw+wEJX02+6ZXpzpOLT5Vsx23jY2QJXe3
 2Ild7XfoPdmxM6tGeFiK+5j2Y8NolBQvmhs/jqHorVW44OPmeC+DClSlT7TlVkdUwAlHNvw+j
 TEDHWO/wfHfo+xYCCnylFCgrKtsz8z8BnNOtqbI9Ckzc/vEJHn2KqRzN5ydZNmywVtmc0qZ4a
 ARVfFdjAMY8Nxvetq2Z7JqkPoRZIhnWowFdjYcLVGU15W/KF7BavAWl2KR7qFcFSpcjEUlMzb
 b5hqjBeAJ056e2B8C+tB3lz1hP0/5i0AMNZqpwd3B5Ze1eaAsoXKClxWw1oNBRHA67NkMYXhw
 LGHl9rsy84CcYdNNZTrcb0bRTxWozJbr/iDAE2zpyEey+zBBqPIxNLGZQlruZDuU7xiSGVYG0
 gOOfCjxfgozHfdWhjsHuAJzBTmxR1MeZLFrlYlFOOmIsk3GYVhwbXX0LmwU7LuTs4oGuWlNK1
 mFrtTIlHk9uzHLFl75QP3bZwWhNT16eqELr9u3evvs5LXKmi5bM8Q0RpjD68oBEcpzkK3WuO8
 dyXrcWmdO6Av7NzJRnBz0NlJp5hIz5s4+GahF+YxA/RLMvINy+7nb1MHqLx5ds5aiQzR8JCeg
 EFXWqRUG2bdttRfmxlcD5G1g3X+VN6I7WDxURBKyJEYoAfJZqj0upz5S+DXQLSzpVXnKorLvz
 oXoNN8wQwDcRJZiLQWVm3lVBqR+VTSjydSf9ErozYfAXNVmfqbofiEjEeDcfqnDk9h8C38vO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279133>

Hi Michael,

On 2015-10-06 10:12, Michael J Gruber wrote:
> "make -j3" just errored out on me, a follow-up "make" succeeded". Thi=
s
> looks like an interdependency issue, but I don't know how to track it=
:
>=20
>     GEN git-web--browse
>     GEN git-add--interactive
>     GEN git-difftool
> mv: der Aufruf von stat f=C3=BCr =E2=80=9Eperl.mak=E2=80=9C ist nicht=
 m=C3=B6glich: Datei oder
> Verzeichnis nicht gefunden
>=20
> (cannot stat "perl.mak")

This one sounds awfully familiar. Although I only encountered this if I=
 specified `make -j15 clean all`, i.e. *both* "clean" and "all"...

Ciao,
Dscho
