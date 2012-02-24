From: Romain Vimont =?ISO-8859-1?Q?=28=AEom=29?= <rom@rom1v.com>
Subject: Re: [BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 20:55:45 +0100
Message-ID: <1330113345.2727.3.camel@rom-laptop>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
	 <4F47E48D.4080501@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:56:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Fz-00052c-6w
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800Ab2BXT4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:56:38 -0500
Received: from rom1v.com ([78.236.177.60]:35061 "EHLO rom1v.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769Ab2BXT4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 14:56:37 -0500
Received: from [192.168.0.101] (unknown [192.168.0.127])
	by rom1v.com (Postfix) with ESMTPSA id 7555F10DA;
	Fri, 24 Feb 2012 20:46:06 +0100 (CET)
In-Reply-To: <4F47E48D.4080501@in.waw.pl>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191452>

Thank you for your answer.

After my message this morning, that's what I did: I commited with the
mock data then tag.

Tonight, I just tried something which do exactly what I wanted to do
this morning:

$ git checkout -b temp
$ git commit -a -m 'My config file with mock_data=3Dtrue'
$ git tag -a v0.1 -m v0.1
$ git checkout master
$ git branch -D temp

With these commands, the tag is associated to a commit which is not in
any branch.

Regards,
=C2=A9om

Le vendredi 24 f=C3=A9vrier 2012 =C3=A0 20:27 +0100, Zbigniew J=C4=99dr=
zejewski-Szmek a
=C3=A9crit :
> On 02/24/2012 11:24 AM, Romain Vimont (=C2=AEom) wrote:
> > $ git log --pretty=3Donline
> > 0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff This is the last commit
> > a4702c69c28484d357179166cf3b116764da20a4 This is a commit
> >
> > Now, I edit some files (for example in a config file "mock_data=3Dt=
rue"),
> > then I want to tag without commiting this change.
> >
> > $ git tag -a v0.1 -m 'My v0.1 with mock data'
>=20
> > And it shows the diff between a4702c69c28484d357179166cf3b116764da2=
0a4
> > and 0ef41513d0b6d0ad28f21d0ac1da7096ad1dc6ff (the two last commits)=
=2E
>=20
> Hi Romain,
> git tag attaches the tag to the last commit, 0ef41513 in your case.=20
> Dirty changes in your tree are ignored by the tag command. You would=20
> have to commit them first, and attach the tag to this new commit.
>=20
> zbyszek
>=20
