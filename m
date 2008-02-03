From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sun, 3 Feb 2008 23:25:47 +0100
Message-ID: <200802032325.47844.robin.rosenberg@dewire.com>
References: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br> <200802030201.10971.robin.rosenberg@dewire.com> <47A61A30.3000904@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnI3-0002zk-1I
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYBCWZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 17:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYBCWZq
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:25:46 -0500
Received: from [83.140.172.130] ([83.140.172.130]:4448 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbYBCWZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:25:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E651D800686;
	Sun,  3 Feb 2008 23:25:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gio7-WAC-6Wf; Sun,  3 Feb 2008 23:25:43 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 661CA800681;
	Sun,  3 Feb 2008 23:25:43 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47A61A30.3000904@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72412>

s=C3=B6ndagen den 3 februari 2008 skrev Roger C. Soares:
> Ok, so some more points for your consideration:
>=20
> . I saw this /* private */ notation on eclipse code and found it=20
> interesting.
It is.

> . I won't bother measuaring any single case to make sure it is not=20
> impacting performance under some circunstance, so resolving those=20
> warnings puts me in the safe area. On the other hand, I think it is a=
=20
> lot easier to tell if a patch is breaking encapsulation in a bad way=20
> just by reviewing it, which is something that is already done.=20
We do not have a large number of people reviewing our code at this stag=
e,
so I would not trust that at the moment.

> Especially if it has the private modifier commented out. Someone can=20
> even do a script to uncomment them and verify that it still builds=20
> without errors.
There is more to reviewing than just looking at the diffs.

> . The ui part isn't supposed to be reused by other projects, so I thi=
nk=20
> encapsulation there is less important than for jgit. But even so, the=
=20
> default modifier (or package-private) is good enough for encapsulatio=
n.=20
> Other projects shouldn't write code in the the same packages from jgi=
t,=20
> if they do so they know that they are using internal things and they =
can=20
> run into problems in the future.

I'm thinking more about internal encapsulation between the classes with=
in the=20
project. Many of the classes in the ui (and jgit) packages have little =
in=20
common other than that they contribute to the same overall goal (an Ecl=
ipse=20
plugin). I guess that is what happens when things get build a small pat=
ch at=20
a time. Obviously we could have more packages, but that might make thin=
gs=20
worse by forcing us to have more public methods and having a lot of one=
 and=20
two class packages feels wrong too (though it actually may be right). I=
 don't=20
think I'll look at that right now though.

-- robin
