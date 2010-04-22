From: Petr Baudis <pasky@suse.cz>
Subject: Creating tracked branches
Date: Thu, 22 Apr 2010 13:49:24 +0200
Message-ID: <20100422114924.GH3563@machine.or.cz>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
 <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <86tyr4v12n.fsf@red.stonehenge.com>
 <u2n3abd05a91004211657v3dcdaf40j3608f3d8f59c4c1b@mail.gmail.com>
 <20100422081055.GG3563@machine.or.cz>
 <7vy6gf52d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aghiles <aghilesk@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 13:49:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4uuU-0006ui-Cw
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 13:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0DVLt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 07:49:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45970 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab0DVLt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 07:49:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E86A0125A114; Thu, 22 Apr 2010 13:49:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy6gf52d1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145521>

On Thu, Apr 22, 2010 at 01:16:10AM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
>=20
> > On Wed, Apr 21, 2010 at 07:57:17PM -0400, Aghiles wrote:
> >> On Wed, Apr 21, 2010, Randal L. Schwartz  wrote:
> >> > =A0 =A0git checkout -b test origin/test
> > ...
> > So, do I understand it right that there is still no canonical synta=
x to
> > check out local branch tracking a remote one of the same name, with=
out
> > spelling out the branch name twice?
>=20
> Only if you don't count Dscho's DWIM.
>=20
>     $ git checkout tr/word-diff
>     Branch tr/word-diff set up to track remote branch tr/word-diff fr=
om origin.
>     Switched to a new branch 'tr/word-diff'

Ugh. Right, so _this_ is what kept me from ever learning the proper way=
:

  (i) If you do `checkout B`, it will track remote branch B if it exist=
s.

  (ii) If you do `checkout -b B`, it will never auto-track anything.

  (iii) If you do `git checkout -t -b B`, it will auto-track your curre=
nt
_local_ branch.

This keeps getting me really confused, I hope I will remember it now fo=
r
good, but I have seen others having trouble with this as well. I don't
have immediate ideas that would do less harm than good to fix this up..=
=2E

perhaps except changing (iii) to auto-track the remote branch B if it
exists and require tracked branch name if it doesn't - the current
default seems pretty much useless to me for usual cases. (I can imagine
a scenario where it would be useful, but not a common scenario where
this would be useful default.)

P.S.: The "--track without -b implies branch creation" sentence in
git-checkout(1) seems to be plain wrong?

--=20
				Petr "Pasky" Baudis
http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
