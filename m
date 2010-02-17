From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Git svn fetches entire trunk on tags (change from 1.6.5.2 to
	1.7.0)
Date: Wed, 17 Feb 2010 15:23:42 -0800
Message-ID: <20100217232342.GA29610@dcvr.yhbt.net>
References: <94a51d821002161717q4dd116f9tebff3a2475446a8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 00:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhtFE-00041P-AA
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 00:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843Ab0BQXXn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 18:23:43 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60569 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755375Ab0BQXXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 18:23:42 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AC01F4EF;
	Wed, 17 Feb 2010 23:23:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a51d821002161717q4dd116f9tebff3a2475446a8e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140270>

Robert Zeh <robert.allan.zeh@gmail.com> wrote:
> Since upgrading from 1.6.5.2 to 1.7.0 I've noticed a change in how
> git=A0svn=A0fetches from the Subversion repository on tags.=A0=A0Of c=
ourse,
> for the repo I'm working with there are many more tags then branches.
> 1.6.5.2 gives me=A0the following on a tag:
>=20
>=20
> r333 =3D b15f3f20710a1e282fb6ff62c13fad64376ad2b4 (refs/remotes/trunk=
)
> Found possible branch point:http://bt011us013s/prod_repos/trunk
> =3D>http://bt011us013s/prod_repos/tags/3.09.1255, 333
> Found branch parent: (refs/remotes/tags/3.09.1255)
> b15f3f20710a1e282fb6ff62c13fad64376ad2b4
> Following parent with=A0do_switch
> Successfully followed parent
>=20
> r334 =3D 77d132d69bc333e7c988a4f3af9d48a98dadf0d4 (refs/remotes/tags/=
3.09.1255)
>=20
> With 1.7.0:
> r333 =3D b15f3f20710a1e282fb6ff62c13fad64376ad2b4 (refs/remotes/trunk=
)
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0A=A0=A0=A0=A0=A0=A0=A0Enterprise/Header.txt
> =A0=A0=A0=A0=A0=A0=A0=A0....
>=20
> r334 =3D 2c0e6dd89e81e7d18288e135f40f193b2ff22018 (refs/remotes/tags/=
3.09.1255)
>=20
> The SHA1s are also different.
>=20
> It would be nice if the entire branch wasn't fetched.

Hi Robert,

There was a rather large amount of changes between 1.6.5.2 so some
regressions could've slipped in.  A bisection would definitely help
us track down the cause.

Does the repository you're using svn:mergeinfo use by any chance?

--=20
Eric Wong
