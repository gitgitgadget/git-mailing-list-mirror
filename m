From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 13:37:34 +0100
Message-ID: <20080322123734.GA10467@atjola.homenet>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <20080322015252.GA7570@atjola.homenet> <20080322094051.GA30074@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 13:38:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd2zU-0004kt-RQ
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 13:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbYCVMhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Mar 2008 08:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754845AbYCVMhi
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 08:37:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:42471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754646AbYCVMhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 08:37:37 -0400
Received: (qmail invoked by alias); 22 Mar 2008 12:37:35 -0000
Received: from i577AC47C.versanet.de (EHLO atjola.local) [87.122.196.124]
  by mail.gmx.net (mp027) with SMTP; 22 Mar 2008 13:37:35 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/zOL9V+nHz9FIvI/NiMoHXWUSOlReYfbYFyr+8Vz
	2F5org+Zv/ebx+
Content-Disposition: inline
In-Reply-To: <20080322094051.GA30074@alea.gnuu.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77800>

On 2008.03.22 10:40:51 +0100, J=F6rg Sommer wrote:
> Hallo Bj=F6rn,
>=20
> Bj=F6rn Steinbrink schrieb am Sat 22. Mar, 02:52 (+0100):
> > On 2008.03.22 02:19:42 +0100, J=F6rg Sommer wrote:
> > > The current version of git-rebase--interactive shows the user the=
 commits
> > > coming from a merge.
> > >=20
> > > M---A---B
> > >  \       \
> > >   o---o---+---o branch
> > >=20
> > > Rebasing branch on M with preserve merges gives the commits A and=
 B. But
> > > if you mark them for editing or remove them the rebase fails. You=
 must
> > > keep them as they are. It's useless to bother the user with these=
 commits
> > > and might lead to mistakes.
> >=20
> > Uhm, why do you completely remove the possibility to edit A instead=
 of
> > fixing the code so that the editing actually works?
>=20
> Because I didn't see why it's useful to edit A and create A' and merg=
e in
> A again, later.
>=20
> M---A---B
>  \       \
>   C---D---+---o branch
>=20
> M---A--------------B
>  \                  \
>   C---B'---D'---A'---+---o branch

Hm? Why do you have A' and B' on the other side of the merge? Using -p
means that you deliberately _disable_ the linearization. The structure
of the history is not supposed to change at all. You're just editing A
and the merge should pull A(edited) and B in.

Bj=F6rn
