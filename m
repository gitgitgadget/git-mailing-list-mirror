From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git cherry-pick --continue?
Date: Fri, 12 Feb 2010 15:11:47 +0100
Message-ID: <20100212141147.GA18676@neumann>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
	<20100210210419.GA7728@coredump.intra.peff.net>
	<20100210212408.GB7728@coredump.intra.peff.net>
	<7v63644uoq.fsf@alter.siamese.dyndns.org>
	<7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
	<20100211193248.GA27072@coredump.intra.peff.net>
	<7vfx5733x7.fsf@alter.siamese.dyndns.org>
	<20100211222714.GA12805@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 15:11:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfwFR-0005eJ-Sq
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 15:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab0BLOLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 09:11:51 -0500
Received: from francis.fzi.de ([141.21.7.5]:14789 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756513Ab0BLOLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 09:11:50 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Feb 2010 15:11:47 +0100
Content-Disposition: inline
In-Reply-To: <20100211222714.GA12805@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 12 Feb 2010 14:11:47.0056 (UTC) FILETIME=[4FF55F00:01CAABED]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139711>

Hi,

On Thu, Feb 11, 2010 at 05:27:14PM -0500, Jeff King wrote:
> On Thu, Feb 11, 2010 at 12:36:52PM -0800, Junio C Hamano wrote:
>=20
> > > Do you just want to pick up my patch from earlier in the thread, =
or do
> > > you have further comments? The only thing I could think to change=
 would
> > > be that we may not want to even bother advertising --continue in =
the
> > > usage message (conversely, we could go a step further and actuall=
y
> > > advertise it in the manpage).
> >=20
> > I would say our eventual goal should be to make "--continue" the pr=
imary
> > word the end users would see.  It would bring us closer to that goa=
l to
> > start advertising --continue early.
>=20
> OK. Then I think my patch is fine. But we could also do this if we
> wanted to push it further now:
>=20
> -- >8 --
> Subject: [PATCH] am: switch --resolved to --continue
>=20
> Rebase calls this same function "--continue", which means
> users may be trained to type it. There is no reason to
> deprecate --resolved (or -r), so we will keep it as a
> synonym.
>=20
> Signed-off-by: Jeff King <peff@peff.net>

Then maybe we should have this, too.

Best,
G=E1bor


 -- >8 --
Subject: [PATCH] bash: support 'git am's new '--continue' option

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 35acad0..fe93747 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -667,7 +667,7 @@ _git_am ()
 {
 	local cur=3D"${COMP_WORDS[COMP_CWORD]}" dir=3D"$(__gitdir)"
 	if [ -d "$dir"/rebase-apply ]; then
-		__gitcomp "--skip --resolved --abort"
+		__gitcomp "--skip --continue --resolved --abort"
 		return
 	fi
 	case "$cur" in
--=20
1.7.0.rc1.84.g9879
