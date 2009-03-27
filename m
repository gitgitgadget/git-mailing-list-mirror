From: Etienne Vallette d'Osia <Etienne.VallettedOsia@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 11:57:45 +0100
Message-ID: <49CCB129.1070606@gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <20090327090554.5d6160f2@pc09.procura.nl> <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 11:59:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln9me-0004rE-9P
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 11:59:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbZC0K6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 06:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756505AbZC0K57
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 06:57:59 -0400
Received: from main.gmane.org ([80.91.229.2]:60380 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755612AbZC0K57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 06:57:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ln9l5-0001Kk-OI
	for git@vger.kernel.org; Fri, 27 Mar 2009 10:57:55 +0000
Received: from schubby.inria.fr ([138.96.218.89])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 10:57:55 +0000
Received: from Etienne.VallettedOsia by schubby.inria.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 10:57:55 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: schubby.inria.fr
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114879>

Ulrich Windl a =E9crit :
>>> 3) "git undo": If possible undo the effects of the last command.
>=20
> If impossible, add confirmations for some "dangerous" (non-obvious) c=
ommands=20
> before doing possibly harmful things. Maybe adding a kind of "user-le=
vel setting"=20
> (novice, expert, guro) could control such confirmations.
>=20
Why ?
All objects stored are immutable, and some tools keep informations=20
(ORIGIN_HEAD, refs/original) to allow a undo hand-made.
Moreover the reflog (and stash if you want to use it for this use) stor=
e=20
  informations during time...

So it's possible to provide a generic undo for all commands that change=
=20
refs.

Maybe an "undo" directory in $GIT_DIR, which will a keep a copy version=
=20
of all refs. Every commands store the current refs in this folder _befo=
re_
to change anything, and the undo restore them all.
At least, a "lastcmd" (for example) file could be added in this=20
directory to allow an more clever undo.
