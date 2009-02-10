From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
	an asterisk
Date: Tue, 10 Feb 2009 09:24:39 +0100
Message-ID: <20090210082439.GD1320@atjola.homenet>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com> <20090210075214.GC1320@atjola.homenet> <adf1fd3d0902100002k5d787e2ewe9012b42f943a6a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 09:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWnwv-0004VP-El
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 09:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbZBJIZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 03:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbZBJIZG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 03:25:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:57775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbZBJIZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 03:25:05 -0500
Received: (qmail invoked by alias); 10 Feb 2009 08:25:02 -0000
Received: from i577B8B51.versanet.de (EHLO atjola.local) [87.123.139.81]
  by mail.gmx.net (mp031) with SMTP; 10 Feb 2009 09:25:02 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+X4r4i1RmXkvNW4yUg4zVWMnR8vGGlabV2hc1/iQ
	WpbNZoMO/lbt9/
Content-Disposition: inline
In-Reply-To: <adf1fd3d0902100002k5d787e2ewe9012b42f943a6a3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109189>

On 2009.02.10 09:02:02 +0100, Santi B=E9jar wrote:
> 2009/2/10 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > On 2009.02.09 18:32:06 -0500, Jay Soffian wrote:
> >> Teach git branch -{r,a} how to interpret remote HEADs and highligh=
t the
> >> corresponding remote branch with an asterisk, instead of showing l=
iteral
> >> "<remote_name>/HEAD".
> >
> > Hm, what's the use case for having such a marker? And since only "g=
it
> > clone" sets up origin/HEAD, while "git remote add foo git://..." wo=
n't
> > create foo/HEAD,
>=20
> git remote add -f ... would create it.

No, it won't. Only "git remote add -m <name> ..." would. And there, you
have to pass a branchname yourself, "-m HEAD" doesn't do the trick. So
there you'd have a "the branch I have selected" instead of "the branch
the remote HEAD referenced". Making it quite different from what "git
clone" does.

But actually, that looks like a bug. The docs for -m say that it should
just override what <name>/HEAD is set to, not that it should be require=
d
to cause the <name>/HEAD creation. I'll try to look into that.

> > you would get that marker for origin only. Also, the
> > origin/HEAD symref isn't updated, so it doesn't tell you which bran=
ch
> > is "active" in the remote repository now, but which one was active =
when
> > you cloned the repo.
>=20
> Maybe there should be a way to update it afterwards.

That may not be the default for remotes added with -m though, as
otherwise the -m option to "git remote add" would become quite
pointless.

Bj=F6rn
