From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Binary files in a linear repository
Date: Mon, 2 Nov 2009 18:01:06 +0100
Message-ID: <20091102170106.GA8650@atjola.homenet>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org>
 <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
 <20091102154831.GC27126@dpotapov.dyndns.org>
 <20091102160903.GA6197@atjola.homenet>
 <20091102165215.GD27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 18:03:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N50Jb-0005aR-Bw
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 18:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbZKBRBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 12:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbZKBRBK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 12:01:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54241 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756014AbZKBRBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 12:01:09 -0500
Received: (qmail invoked by alias); 02 Nov 2009 17:01:10 -0000
Received: from i59F546D3.versanet.de (EHLO atjola.homenet) [89.245.70.211]
  by mail.gmx.net (mp060) with SMTP; 02 Nov 2009 18:01:10 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18HpIh0rdwHLEASEvDL4VhnPoWp3CyNOyx37//Dsw
	Fp2ZTnb7ZDFOvX
Content-Disposition: inline
In-Reply-To: <20091102165215.GD27126@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131927>

On 2009.11.02 19:52:15 +0300, Dmitry Potapov wrote:
> On Mon, Nov 02, 2009 at 05:09:03PM +0100, Bj=F6rn Steinbrink wrote:
> > On 2009.11.02 18:48:31 +0300, Dmitry Potapov wrote:
> > > On Mon, Nov 02, 2009 at 04:08:25PM +0100, Markus Hitter wrote:
> > > You probably should use 'git update-ref' if you want to change HE=
AD
> > > manually. But it seems to me that you do not need even that. All =
what
> > > you need is:
> > >=20
> > > $ git reset --soft master
> > >=20
> > > and then commit your changes (git reset --soft does not touch the=
 index
> > > file nor the working tree at all).
> >=20
> > But then you still have to do:
> > git checkout master
> > git merge HEAD@{1}
> >=20
> > To actually update the "master" branch head. The reset doesn't re-a=
ttach
> > HEAD.
>=20
> You are right... I forgot about that somehow. So, it should be
>=20
> $ git reset --soft master
> $ git checkout master
>=20
> and only then
>=20
> $ git commit

That would do, but:
git checkout <commit>
*make changes*
git reset --soft master
git checkout master
git commit

seems unnecessarily complicated, when you could as well do:
git read-tree -u --reset <commit>
*make changes*
git commit

Bj=F6rn
