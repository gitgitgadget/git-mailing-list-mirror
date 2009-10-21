From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Wed, 21 Oct 2009 10:05:27 +0200
Message-ID: <200910211005.29053.trast@student.ethz.ch>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <alpine.LNX.2.00.0910202044150.14365@iabervon.org> <20091021031528.GB18997@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Sean Estabrooks <seanlkml@sympatico.ca>, <git@vger.kernel.org>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 10:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0WCz-0004gG-KX
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 10:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZJUIGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 04:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbZJUIGA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 04:06:00 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:42214 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbZJUIGA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 04:06:00 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 10:06:01 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 10:06:02 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091021031528.GB18997@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130898>

Bj=F6rn Steinbrink wrote:
> One (maybe important) difference there is that the "pull" gets you:
>=20
>     Merge branch 'pu' of git://git.kernel.org/pub/scm/git/git
>=20
> Even with "master:tmp". But with fetch+merge (storing in refs/remotes=
):
>=20
>     Merge remote branch 'tmp'

What if any combination of fetch and merge always gave you the long
form?  After all, even if you do have a tracking branch for whatever
you are merging, that information is probably useless and it would be
nicer if all of the following resulted in the long form:

* git fetch git://git.kernel.org/pub/scm/git/git pu
  git merge FETCH_HEAD

* git remote add origin git://git.kernel.org/pub/scm/git/git
  git fetch origin
  git merge origin/pu

* git fetch git://git.kernel.org/pub/scm/git/git pu:tmp
  git merge tmp

and so on.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
