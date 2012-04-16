From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] tests: add tests for the bash prompt functions in the
	completion script
Date: Mon, 16 Apr 2012 11:49:38 +0200
Message-ID: <20120416094938.GE2900@goldbirke>
References: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
	<CAMP44s3LJO_Ryc-ONjF+rEHCb1hB8+4Muar6pzjD3zrazYqK+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 11:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJiZF-0001Q3-4n
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 11:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab2DPJtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 05:49:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:52692 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2DPJtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 05:49:45 -0400
Received: from localhost6.localdomain6 (p5B130635.dip0.t-ipconnect.de [91.19.6.53])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M3qBK-1S1MSv17JK-00r3qh; Mon, 16 Apr 2012 11:49:39 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3LJO_Ryc-ONjF+rEHCb1hB8+4Muar6pzjD3zrazYqK+A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:1qd+pNwYhh6cXEdrb1GOkS+bAfSl+SDnIdoPKYJ3BWL
 oEawhLfYLzCx7lpswbrwa+AaeVgY7HBw/XbC+iJbRoLaLcWvWY
 on/U9NDzwfwJMUPPznX9QNmohygrXge4PlY6n+u5LhedFc//N5
 z2irNDDf+480UZ0W9kYhksrKNyzJztGmkTJyx18LExNwYNEyW9
 uG6BBZK6XGcfWwobWKcXsi1aVOzDOnORSZL3qdf4CbuMARdkzm
 JlM6bJ+ldboszAnc8mSR9QPOl9o2nPzyBkdCqi0XxaFc1MVoBz
 NiJX85F9OF3cfd5vGQR4bZvVOyL0U66iL1OhHXX0Wf1/MTwUOd
 faX/uPVLKb5BRv53Li2U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195605>

Hi,

On Sun, Apr 15, 2012 at 11:56:36PM +0300, Felipe Contreras wrote:
> On Sun, Apr 15, 2012 at 11:31 PM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
> > The tests cover the discovery of the .git directory in the __gitdir=
()
> > function in different scenarios, and the prompt itself, i.e. branch
> > name, detached heads, operations (rebase, merge, cherry-pick, bisec=
t),
> > and status indicators (dirty, stash, untracked files; but not the
> > upstream status).
> >
> > Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
> > ---
> >
> > Goes on top of fc/completion-tests (b8574ba7).
> >
> > =A0t/t9902-completion.sh | =A0436 +++++++++++++++++++++++++++++++++=
++++++++++++++++
> > =A01 file changed, 436 insertions(+)
>=20
> Perhaps it would make sense to create another file for these,

I thought about that briefly but decided against it to avoid
duplicating the bash-specific checks at the beginning, but I don't
care that much either way.

> specially since there's the plan of splitting the prompt stuff to a
> separate file.

Oh, I was not aware of such a plan.  What would be the benefits of
such a move, why is it necessary?  Where would you split it up?  In
particular, what would happen with __gitdir(), which is used in many
completion functions and in __git_ps1() as well?


Best,
G=E1bor
