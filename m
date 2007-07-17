From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:48:38 +0200
Message-ID: <469CF2E6.1020104@lsrfire.ath.cx>
References: <469CE836.6010508@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Amit Walambe <awalambe@arcom.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqEI-0007Sq-QI
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbXGQQsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 12:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756704AbXGQQsu
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:48:50 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59466
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755711AbXGQQsu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 12:48:50 -0400
Received: from [10.0.1.201] (p508ED04D.dip.t-dialin.net [80.142.208.77])
	by neapel230.server4you.de (Postfix) with ESMTP id 157958B008;
	Tue, 17 Jul 2007 18:48:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <469CE836.6010508@arcom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52775>

Amit Walambe schrieb:
> Hi!
> I was trying to do a git bisect on 2.6.22-git6 and 2.6.22-git8. For
> which I get following error :
> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
> Bad rev input: v2.6.22-git6
>=20
> The repository is obtained by :
> root@amit:/usr/src # git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 linu=
x-git
>=20
> I am running following git version on Debian Sid, updated today.
> # git --version
> git version 0.99.8.GIT
> '# dpkg -l | grep git' shows ' git-core 1:1.5.2.3-1'
>=20
> I tried searching man-pages/documentation/website but couldn't find a=
ny
> references to git bisect on -git kernels. I would be grateful if anyo=
ne
> can help me find what's going wrong.

The -git snapshots are made automatically by kernel.org, and their name
is not included in the git repository.  You could create tags for them
like this:

 git tag v2.6.22-git6 8f41958bdd577731f7411c9605cfaa9db6766809
 git tag v2.6.22-git8 a5fcaa210626a79465321e344c91a6a7dc3881fa

=2E.. and afterwards you can use those revision names with bisect (or
other git commands).  I've got the commit IDs (i.e. those mysterious 40
hex digits above) from the first line of the changelogs; their URLs are=
:

 http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git6.lo=
g
 http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git8.lo=
g

Ren=E9
