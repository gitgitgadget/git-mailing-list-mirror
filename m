From: Romain Vimont =?ISO-8859-1?Q?=28=AEom=29?= <rom@rom1v.com>
Subject: Re: [Not A BugReport] git tag -a / git show
Date: Fri, 24 Feb 2012 20:58:48 +0100
Message-ID: <1330113528.2727.5.camel@rom-laptop>
References: <b05f03b381140ca57a7d03a934f605bd@rom1v.com>
	 <7vsji0yprw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11Iu-0006lg-D4
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab2BXT7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:59:40 -0500
Received: from rom1v.com ([78.236.177.60]:35063 "EHLO rom1v.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab2BXT7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 14:59:39 -0500
Received: from [192.168.0.101] (unknown [192.168.0.127])
	by rom1v.com (Postfix) with ESMTPSA id B5E991BCC;
	Fri, 24 Feb 2012 20:49:08 +0100 (CET)
In-Reply-To: <7vsji0yprw.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191453>

Thank you for the details.

> *1* technically, tag can apply to any type of object, but it is most
common to apply to a commit.

To what other type of object can you apply a tag ?

Good evening.

Le vendredi 24 f=C3=A9vrier 2012 =C3=A0 11:50 -0800, Junio C Hamano a =C3=
=A9crit :
> "Romain Vimont (=C2=AEom)" <rom@rom1v.com> writes:
>=20
> > Now, I edit some files (for example in a config file
> > "mock_data=3Dtrue"), then I want to tag without commiting this chan=
ge.
>=20
> Tag applies to an existing commit [*1*].  Your change in the working =
tree
> is purely ephemeral until it is committed.
>=20
> In other words, you don't "tag without committing".
>=20
> > $ git tag -a v0.1 -m 'My v0.1 with mock data'
>=20
> By omitting the [<head>] part from your command line for a command wh=
ose
> usage is:
>=20
>   usage: git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagna=
me> [<head>]
>=20
> you asked <head> to default to HEAD, the most recent commit, so the t=
ag
> points at your 0ef41513d0b6 (This is the last commit).  The tag messa=
ge
> should say "My v0.1" without anything else.
>=20
> And show naturally shows the patch to bring its parent to that tagged
> commit.
>=20
> If you wanted to keep your mainline pristine without mock data, and w=
ant
> to have a playpen that uses mock data, a way to do so is to use a sep=
arate
> branch, e.g.
>=20
>         $ git checkout -b playpen
>=20
> Now, you are on your 'playpen' branch that was forked from the tip of
> whatever branch you were on, perhaps 'master'.  Then commit that stat=
e
> with whatever change that is specific to the playpen you want to keep=
 out
> of the mainline:
>=20
> 	$ edit config.txt ;# set mock_data=3Dtrue
>         $ git commit -a -m 'With mock data'
>=20
> You can optionally tag the resulting commit if you want to.  You are =
still
> on the 'playpen' branch, so you probably would want to come back to t=
he
> previous branch after you are done.
>=20
>=20
> [Footnote]
>=20
> *1* technically, tag can apply to any type of object, but it is most
> common to apply to a commit.
>=20
