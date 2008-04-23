From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: showing conflicting merges
Date: Wed, 23 Apr 2008 08:17:15 +0200
Message-ID: <20080423061715.GB25446@digi.com>
References: <20080422091233.GA12091@digi.com> <8aa486160804220249y55677f63o892643775960880f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 08:18:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoYJC-0002iz-Hi
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 08:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYDWGRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Apr 2008 02:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbYDWGRg
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 02:17:36 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:17671 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752567AbYDWGRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 02:17:35 -0400
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-14.tower-29.messagelabs.com!1208931454!11857524!1
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.14]
Received: (qmail 3832 invoked from network); 23 Apr 2008 06:17:35 -0000
Received: from mail.mx2.digi.com (HELO mcl-sms-ns2.DIGI.COM) (66.77.174.14)
  by server-14.tower-29.messagelabs.com with RC4-SHA encrypted SMTP; 23 Apr 2008 06:17:35 -0000
Received: from mcl-sms-exch01.digi.com (10.5.8.50) by mail.mx2.digi.com
 (172.16.1.14) with Microsoft SMTP Server (TLS) id 8.1.263.0; Wed, 23 Apr 2008
 01:16:39 -0500
Received: from mtk-sms-mail01.digi.com (10.10.8.120) by
 mcl-sms-exch01.digi.com (10.5.8.50) with Microsoft SMTP Server id 8.1.263.0;
 Wed, 23 Apr 2008 01:17:33 -0500
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by
 mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 23 Apr
 2008 01:17:18 -0500
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 23 Apr 2008 08:17:15 +0200
Received: by zentaur.digi.com (Postfix, from userid 1080)	id 7C3C62AB12; Wed,
 23 Apr 2008 08:17:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8aa486160804220249y55677f63o892643775960880f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 23 Apr 2008 06:17:15.0875 (UTC) FILETIME=[AD2CEB30:01C8A509]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15866.005
X-TM-AS-Result: No--34.664100-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80190>

Hello Santi,

Santi B=E9jar wrote:
> On Tue, Apr 22, 2008 at 11:12 AM, Uwe Kleine-K=F6nig
> <Uwe.Kleine-Koenig@digi.com> wrote:
> > Hello,
> >
> >  There is a thread on the linux-arm-kernel ML that discusses handli=
ng of
> >  merge conflicts with git.[1]
> >
> >  I played around a bit with that and wondered about a few things:
> >
> >         ukleinek@zentaur:~/gsrc/linux-2.6$ git checkout -b test adf=
6d34e460387ee3e8f1e1875d
> >         Switched to a new branch "test"
> >
> >         ukleinek@zentaur:~/gsrc/linux-2.6$ git merge v2.6.25
> >         Auto-merged MAINTAINERS
> >         CONFLICT (delete/modify): drivers/leds/leds-tosa.c deleted =
in HEAD and modified in v2.6.25. Version v2.6.25 of drivers/leds/leds-t=
osa.c left in tree.
> >         Auto-merged drivers/serial/imx.c
> >         Automatic merge failed; fix conflicts and then commit the r=
esult.
> >
> >  Now "git diff --merge" shows:
> >
> >         diff --cc drivers/leds/leds-tosa.c
> >         index 7ebecc4,0000000..9e0a188
> >         ...
> >
> >  Shouldn't that better be reversed, i.e. 9e0a188..7ebecc4,0000000?
>=20
> It compares the versions in conflict with the version in the working =
copy.

I have not checked in the source code, but the output of=20

	strace -f -e open git diff --merge 2>&1 >/dev/null | grep leds-tosa

seems to contradict that (i.e. there is no output).

	7ebecc4 =3D v2.6.25:drivers/leds/leds-tosa.c
	9e0a188 =3D $(git merge-base test v2.6.25):drivers/leds/leds-tosa.c

(Ah, I just see, that's another hint that diff --merge doesn't look in
the working copy.  The wc has 7ebecc4 which is in the LHS together with
000000 (i.e. the deleted file from HEAD).

Maybe the combined diff format cannot have more than one rev on the RHS=
?

> >  The resolution was to delete drivers/leds/leds-tosa.c:
> >
> >         ukleinek@zentaur:~/gsrc/linux-2.6$ git rm drivers/leds/leds=
-tosa.c
> >         rm 'drivers/leds/leds-tosa.c'
> >         rm 'drivers/leds/leds-tosa.c'
> >
> >         ukleinek@zentaur:~/gsrc/linux-2.6$ git commit
> >         Created commit 99a64ab: Merge commit 'v2.6.25' into test
> >
> >  Now "git show" doesn't show the conflict resolution as it does for=
 other
> >  conflicting merges.
> >  Adding -p and/or --cc didn't help either.  Looking at the source I=
 think
> >  the problem is that diff_tree_combined only shows diffs for paths =
that
> >  are touched by every parent.  I'm not sure how I want to have the =
diff
> >  shown, but showing nothing seems wrong.  Ideas?
>=20
> The combined diff does not show conflicts, it only shows the merged
> results that are different to all the parents. In this case the merge
> resolution is to delete one file as in HEAD, so it won't be shown.
>=20
> If you want to see the conflict resolution you have to recreate the
> merge and compare with the original merge.
An option to show would be great ...

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
