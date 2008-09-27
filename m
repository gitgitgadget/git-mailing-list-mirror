From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Sat, 27 Sep 2008 02:16:17 +0200
Message-ID: <20080927001617.GA6941@neumann>
References: <20080925235029.GA15837@neumann>
	<1222389359-22191-1-git-send-email-vmiklos@frugalware.org>
	<20080926010312.GE6816@neumann>
	<20080926151517.GV23137@genesis.frugalware.org>
	<m37i8y3mqt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 27 02:17:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjNV8-0004Ho-7a
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 02:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbYI0AQX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2008 20:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbYI0AQX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 20:16:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:55522 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYI0AQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 20:16:23 -0400
Received: from [127.0.1.1] (p5B1337E4.dip0.t-ipconnect.de [91.19.55.228])
	by mrelayeu.kundenserver.de (node=mrelayeu0) with ESMTP (Nemesis)
	id 0MKwh2-1KjNTu2rJG-00076K; Sat, 27 Sep 2008 02:16:19 +0200
Content-Disposition: inline
In-Reply-To: <m37i8y3mqt.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+p+yyz6E+MogIC4uXv4JJnOS8YiSv7MkaHTuQ
 aCInwDIWJojWhDYkXx+AvmiAmE7uEFa+CNRxBKs4nuTauAunaO
 1JyXT9KvT2LlCq/wZcmEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96894>

Hi all,

On Fri, Sep 26, 2008 at 09:17:39AM -0700, Jakub Narebski wrote:
> 3. Remove reduce_heads() from git-commit entirely, and record in
>    MERGE_HEAD (or rather now MERGE_HEADS) _all_ _reduced_ heads.
>    _All_ means that HEAD is included in MERGE_HEAD if it is not
>    reduced, _reduced_ means that only non-dependent heads are in
>    MERGE_HEAD.  This for example means that for simple non-octopus
>    merge case MERGE_HEAD/MERGE_HEADS now contain _all_ parents,
>    and not only other side of merge.
>=20
>    This solution has the advantage of being clear solution, clarifyin=
g
>    semantic of MERGE_HEAD (currently HEAD is used both as target, i.e=
=2E
>    where merge is to be recorded, and as one of heads to merge/to
>    consider), and making it possible to separate layers: git-merge
>    is about merging, git-commit doesn't need to know anything about
>    merging.

Well, I'm just following this from the sidelines...  but from design
point of view I would prefer #3 because of the clear separation of
the merge and commit steps.

Best,
G=E1bor
