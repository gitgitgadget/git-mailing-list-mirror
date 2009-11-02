From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Binary files in a linear repository
Date: Mon, 2 Nov 2009 17:09:03 +0100
Message-ID: <20091102160903.GA6197@atjola.homenet>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org>
 <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
 <20091102154831.GC27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:09:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4zT3-00051g-G7
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 17:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbZKBQJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 11:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755336AbZKBQJE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:09:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:42731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755168AbZKBQJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 11:09:03 -0500
Received: (qmail invoked by alias); 02 Nov 2009 16:09:07 -0000
Received: from i59F546D3.versanet.de (EHLO atjola.homenet) [89.245.70.211]
  by mail.gmx.net (mp063) with SMTP; 02 Nov 2009 17:09:07 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18iHpIRnsgirtE4l/pXDtM9cYMokCCdqC69jmT7eM
	ZmG3aGETc4iO+s
Content-Disposition: inline
In-Reply-To: <20091102154831.GC27126@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131920>

On 2009.11.02 18:48:31 +0300, Dmitry Potapov wrote:
> On Mon, Nov 02, 2009 at 04:08:25PM +0100, Markus Hitter wrote:
> >
> > Now I'm thinking about a much simpler solution: Simply declare the =
=20
> > current set of files as (a modified) master/com005 and commit them.=
 A =20
> > "cp $GIT_DIR/master $GIT_DIR/HEAD" followed by a commit would do it=
=2E
> >
> > Now my question: Is it safe to tweak the files in $GIT_DIR this way=
 or=20
> > will this corrupt the repository?
>=20
> You probably should use 'git update-ref' if you want to change HEAD
> manually. But it seems to me that you do not need even that. All what
> you need is:
>=20
> $ git reset --soft master
>=20
> and then commit your changes (git reset --soft does not touch the ind=
ex
> file nor the working tree at all).

But then you still have to do:
git checkout master
git merge HEAD@{1}

To actually update the "master" branch head. The reset doesn't re-attac=
h
HEAD.

Bj=F6rn
