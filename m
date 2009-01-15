From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Thu, 15 Jan 2009 23:59:12 +0100
Message-ID: <20090115225912.GL9794@neumann>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	<7vfxjlxuu5.fsf@gitster.siamese.dyndns.org>
	<20090115153529.GA13961@neumann>
	<7vvdsgql17.fsf@gitster.siamese.dyndns.org>
	<bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNbCn-0000Xc-Py
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 00:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934974AbZAOW7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbZAOW7V
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:59:21 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:51136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935648AbZAOW7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 17:59:19 -0500
Received: from [127.0.1.1] (p5B133987.dip0.t-ipconnect.de [91.19.57.135])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1LNbBA0AAN-0001sE; Thu, 15 Jan 2009 23:59:13 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1/LVmdIOIfmDrJcYA+bodBnl4sOZBnRG3J2Byk
 3qjyhcl7gqekJNpwYrKB4H24iaT/G07v/lV5xNvpSNjlgbruCj
 AzknI5IfBQqy0KS9yV6Zw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105891>

On Thu, Jan 15, 2009 at 11:20:08PM +0100, Sverre Rabbelier wrote:
> On Thu, Jan 15, 2009 at 23:09, Junio C Hamano <gitster@pobox.com> wro=
te:
> > I agree that is a true disadvantage that shows "reset --soft HEAD^"=
 is a
> > bad idea (you could still say commit -c @{1}, though).
>=20
> But it's not:
> "It also makes sure that a pre-filled editor is fired up when doing
> "git rebase --continue", in case the user just wanted to fix the
> commit message."

Indeed, but in this case the rebase process will continue after
finishing the commit message.  OTOH, with the current behaviour, you
must do a 'git commit --amend && git rebase --continue', which might
seem more complicated at first sight, but...

But the current behaviour of the 'edit' rebase command gives you the
possibility of adding further commits on top of the selected one
(after you have edited that or left intact, doesn't matter).  To do
that with this automatic 'reset --soft HEAD^' modification you would
first need to 'git commit -c @{1}' to keep the selected commit before
going on with adding further commits, which is not quite nice.


Regards,
G=E1bor
