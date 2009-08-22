From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Ensure created test repositories use canonical paths
Date: Sat, 22 Aug 2009 12:15:17 +0200
Message-ID: <200908221215.17681.robin.rosenberg.lists@dewire.com>
References: <1250687891-17916-1-git-send-email-fonseca@diku.dk> <200908210035.10825.robin.rosenberg.lists@dewire.com> <2c6b72b30908212032t39a4896x3308148c44692a80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Aug 22 12:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mene5-0000eh-9x
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 12:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbZHVKPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 06:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbZHVKPU
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 06:15:20 -0400
Received: from mail.dewire.com ([83.140.172.130]:21367 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbZHVKPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 06:15:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CB51E146C0F2;
	Sat, 22 Aug 2009 12:15:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4VulM5Y+O-uE; Sat, 22 Aug 2009 12:15:19 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B2B94146C0E1;
	Sat, 22 Aug 2009 12:15:18 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <2c6b72b30908212032t39a4896x3308148c44692a80@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126803>

l=C3=B6rdag 22 augusti 2009 05:32:59 skrev Jonas Fonseca <fonseca@diku.=
dk>:
> [With correct CC list. Sorry for the resend Robin]
>=20
> On Thu, Aug 20, 2009 at 18:35, Robin
> Rosenberg<robin.rosenberg.lists@dewire.com> wrote:
> > onsdag 19 augusti 2009 15:18:11 skrev Jonas Fonseca <fonseca@diku.d=
k>:
> >> Fixes breakage in the RepositoryCacheTest when running tests using=
:
> >>
> >>       mvn -f ./jgit-maven/jgit/pom.xml test
> >> [...]
> >> @@ -217,7 +217,7 @@ public void setUp() throws Exception {
> >>               trash =3D new File(trashParent,"trash"+System.curren=
tTimeMillis()+"."+(testcount++));
> >> -             trash_git =3D new File(trash, ".git");
> >> +             trash_git =3D new File(trash, ".git").getCanonicalFi=
le();
> >> @@ -307,7 +307,7 @@ protected Repository createNewEmptyRepo() thro=
ws IOException {
> >>       protected Repository createNewEmptyRepo(boolean bare) throws=
 IOException {
> >>               final File newTestRepo =3D new File(trashParent, "ne=
w"
> >>                               + System.currentTimeMillis() + "." +=
 (testcount++)
> >> -                             + (bare ? "" : "/") + ".git");
> >> +                             + (bare ? "" : "/") + ".git").getCan=
onicalFile();
> >
> > We use getCanonicalFile here and Repository.gitDir  is initialized =
with getAbsoluteDir.
>=20
> BTW, a simpler fix would be to initialize trashParent to a canonical
> path, which might be less intrusive.
>=20
> > Does this work on all platforms?
>=20
> I have only tested on Linux.
>=20
> > Seems linux normalized things when you do things like, but I'm not =
sure that happens everywhere.
>=20
> If you think it is a problem, let's drop the patch. It just seemed
> like a simple way to increase robustness.

Just a hunch, can't prove it so I'll accept the patch.

-- robin
