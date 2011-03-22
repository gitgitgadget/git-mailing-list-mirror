From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 11:09:03 +0100
Message-ID: <20110322100903.GG14520@neumann>
References: <4D871972.7080008@elegosoft.com>
	<7vhbawno11.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1103212302000.1561@bonsai2>
	<7v4o6vmvzs.fsf@alter.siamese.dyndns.org>
	<20110322085027.GF14520@neumann>
	<AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakob Pfender <jpfender@elegosoft.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, lee.marlow@gmail.com,
	markus.heidelberg@web.de, spearce@spearce.org, bebarino@gmail.com,
	ted@tedpavlic.com, tlikonen@iki.fi, trast@student.ethz.ch
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 11:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1yWd-0001TU-6s
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 11:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab1CVKJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 06:09:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:59850 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab1CVKJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 06:09:11 -0400
Received: from localhost6.localdomain6 (p5B130955.dip0.t-ipconnect.de [91.19.9.85])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mb5Ch-1QI8jL2py7-00KnHi; Tue, 22 Mar 2011 11:09:05 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTi=zbsNxLSCcWQorZCnRFuDPujqYzW7B0xJx2FHp@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:LAjDSUGr/rvpo4dGSjOGHWPlCyEC9vo4Ri7DswVbSYo
 qNj1Bo1hgfvrsxwSSxM5rA1vxmlGjZm34nHwmnlJ5/PeQ+Um7V
 EfR8gh6B/pW5BQDK11b4uQzBWfK6S7GFUCCWg3uOWuQvuV03Jr
 j7T1YAshZreYpK8HTJFV9W7g3SG1soIMm3YgeYBnSXhGyR+bVY
 CRXBtzf8Id11Y7cT+wpyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169717>

On Tue, Mar 22, 2011 at 10:16:16AM +0100, Erik Faye-Lund wrote:
> 2011/3/22 SZEDER G=E1bor <szeder@ira.uka.de>:
> > On Tue, Mar 22, 2011 at 12:53:43AM -0700, Junio C Hamano wrote:
> >> This is a constructive tangent but if we are going to run $(__git_=
aliases)
> >> every time we run _git_help, perhaps it would want a hack similar =
to the
> >> way the value for $__git_all_commands is generated just once?
> >
> > I think this is not necessary. =A0We already run __git_aliases() ev=
ery
> > time after 'git <TAB>', and it was not an issue so far. =A0And inde=
ed, I
> > just created 50 aliases, and the time required for __git_aliases()
> > seems to be negligible:
> >
> > =A0$ time __git_aliases
> > =A0<bunch of aliases>
> >
> > =A0real =A0 =A00m0.028s
> > =A0user =A0 =A00m0.016s
> > =A0sys =A0 =A0 0m0.004s
> >
>=20
> Unfortunately, the situation is not quite so good on Windows:
> $ time __git_aliases
> <bunch of aliases>
>=20
> real    0m0.112s
> user    0m0.030s
> sys     0m0.015s
>=20
> This is with 50 aliases, with 0 aliases I get this:
> $ time __git_aliases
> test
>=20
> real    0m0.063s
> user    0m0.015s
> sys     0m0.015s

I see.  However, on Windows everything git-related tends to be slow,
so this is nothing new.

The question is whether the slowness of a known slow platform would
justify the regression on all platforms.


Best,
G=E1bor
