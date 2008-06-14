From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT RFC] Commit behaviour
Date: Sat, 14 Jun 2008 11:08:17 +0200
Message-ID: <200806141108.17854.robin.rosenberg@dewire.com>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com> <4852EFBF.6000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 11:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7RoW-00053N-Fv
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 11:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbYFNJLk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 05:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbYFNJLk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 05:11:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13343 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754299AbYFNJLj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jun 2008 05:11:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 04CA91447775;
	Sat, 14 Jun 2008 11:11:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0b-t3oFDhfM4; Sat, 14 Jun 2008 11:11:37 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 62B868006B7;
	Sat, 14 Jun 2008 11:11:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4852EFBF.6000406@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84994>

l=C3=B6rdagen den 14 juni 2008 00.07.59 skrev Marek Zawirski:
> Robin Rosenberg wrote:
> > I got annoyed about having change my selection to a project to be a=
ble
> > to commit. This tentative feature allows me to hit the commit butto=
n
> > when any resource is selected and figure out which resources have b=
een
> > modified. This makes it much easier to commit. Only the toolbar com=
mit
> > is affected for now.
>=20
> That's a nice idea! I also thought about that one day, as such featur=
e=20
> already exists in (e.g.) Subclipse that I was used to.
>=20
> >=20
> > Another twist would be to list all changed resources, but only enab=
le
> > the selected ones, or only the ones in in the same projects as the =
selected
> > resources. Comments?
>=20
> I think that only selected && changed ones should be listed. When use=
r=20
> selects explicitly some resources, he/she is probably interested only=
 in=20
> these ones. And he/she probably did it for easier selection than from=
=20
> list of all changed resources, isn't it?

Selection is often implicit, i.e. if you link editor and selection, whi=
ch I do, the selection
change every time you switch editor.=20

> > Code is not efficient either. This is question about the user inter=
face.
>=20
> Theses patches don't work for me however :/ When I introduce some cha=
nge=20
> to a resource/file, even add it to index and click commit (toolbar or=
=20
> menu), commit action does nothing. It is - nothing happens. Can you=20
> reproduce this problem, or should I debug it on my instance? Or do I =
use=20
> it in some wrong way?
It it's too hard to use properly it's wrong. Anyway I could reproduce i=
t. Not sure
why it works sometimes though. I found this in the workspace log. Pleas=
e=20
check if you see it too, so I know we're chasing the same bug.

java.lang.ArrayIndexOutOfBoundsException: 0
        at org.spearce.egit.ui.internal.actions.CommitAction.loadPrevio=
usCommit(CommitAction.java:127)


> > Then we could ask ourselved, should we do something similar for Che=
ckout
> > and reset too? I think that is not as important as those operations=
 are
> > much less frequent.
> >=20
> > -- robin
>=20
> Well, I think that checkout (maybe reset too) would be useful too - t=
o=20
> revert some file quickly.

We do not have a per-file checout/reset yet. What we have checks out al=
l files in the repository.

-- robin
