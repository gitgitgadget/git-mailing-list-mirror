From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 19:31:00 +0200
Message-ID: <4852AED4.50206@free.fr>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>	 <20080611230344.GD19474@sigill.intra.peff.net>	 <alpine.LFD.1.10.0806111918300.23110@xanadu.home>	 <loom.20080612T042942-698@post.gmane.org>	 <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>	 <4851F6F4.8000503@op5.se>	 <20080613055800.GA26768@sigill.intra.peff.net>	 <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>	 <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org> <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Jun 13 19:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7D7d-0006hx-1H
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 19:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbYFMRag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYFMRag
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 13:30:36 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:46797 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbYFMRaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 13:30:35 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 84D8712B6C5;
	Fri, 13 Jun 2008 19:30:34 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0C13F12B6D8;
	Fri, 13 Jun 2008 19:30:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <bd6139dc0806130333n2cfbc564k79ed5562f14fc848@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84904>

Sverre Rabbelier a =E9crit :
>=20
>  OTOH: I dislike the idea of 'forcing' the users to go through their
> stashes lest they lose their work. I don't see why anybody would want
> to do some work, stash it, and then "for no apparent reason" (the
> reason being not touching it for some time) lose it later.

I agree. And even without that:

> What if
> their system borks up and gives a wrong value as current time (say, 1=
0
> years in the future), all of a sudden their stashes are gone, and the=
y
> might not even find out till it was too late. Sure, they'd lose some
> stale objects too, but that I can live with, those they did not ask
> git to take care of explicitly!

it seems pretty strange to ask the user for a confirmation: are you sur=
e
you want to keep what you ask us to store in the stash?

> The per-branch stashes sounds very nice, especially if you can get a
> 'git stash list --all' feature, that shows all stashes, regardless of
> what branch they are on. I myself would use such a per-branch feature
> most of the time, it would be nice to have a config option that
> defaults to that (making 'git stash' create a per-branch stash by
> default that is).

I think the same and would prefer per-branch stash by default because I
don't see a real use of a "global" one but maybe I'm wrong. Perhaps, a
config option could make everyone happy. :-)

Olivier.
