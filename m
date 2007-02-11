From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 00:59:17 +0100
Organization: Dewire
Message-ID: <200702120059.17676.robin.rosenberg.lists@dewire.com>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200702120041.27419.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOaL-0005Vp-M9
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbXBKX6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Feb 2007 18:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932937AbXBKX6T
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:58:19 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20707 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932936AbXBKX6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Feb 2007 18:58:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5056D803394;
	Mon, 12 Feb 2007 00:53:27 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14965-07; Mon, 12 Feb 2007 00:53:27 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id EE98D80338F;
	Mon, 12 Feb 2007 00:53:24 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <200702120041.27419.bruno@clisp.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39340>

m=E5ndag 12 februari 2007 00:41 skrev Bruno Haible:
> Hello Johannes,
>=20
> Thanks for the helpful answer.
>=20
> > Yes, because there were only 147 commits which changed the file. Bu=
t git=20
> > looked at all commits to find that.
>=20
> Ouch.
>=20
> > Basically, we don't do file versions. File versions do not make sen=
se,=20
> > since they strip away the context.
>=20
> Is there some other concept or command that git offers? I'm in the si=
tuation
> where I know that 'tr' in coreutils version 5.2.1 had a certain bug a=
nd
> version 6.4 does not have the bug, and I want to review all commits t=
hat
> are relevant to this. I know that the only changes in tr.c are releva=
nt
> for this, and I'm interested in a display of the minimum amount of re=
levant
> commit messages. If "git log" is not the right command for this quest=
ion,
> which command is it?

Since you know that you are not interested in the whole history, you ca=
n limit your scan.

git log COREUTILS-5_2_1..COREUTILS-6_4 src/tr.c

> > > 2) Why so much system CPU time, but only on MacOS X?
> >=20
> > Probably the mmap() problem. Does it go away when you use git 1.5.0=
-rc4?
>=20
> No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4=
 for
> this command:
>   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 1=
2 system)
>   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 1=
9 system)

Could the UTF-8 stuff have anything to do with this?

-- robin
