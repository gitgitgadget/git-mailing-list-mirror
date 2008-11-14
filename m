From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Fri, 14 Nov 2008 10:34:05 +0100
Message-ID: <200811141034.06282.chriscool@tuxfamily.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org> <200811121515.48277.chriscool@tuxfamily.org> <491C58A3.2000609@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 10:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0v3E-0007FD-4K
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 10:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbYKNJb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 04:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbYKNJb7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 04:31:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:36324 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbYKNJb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 04:31:57 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9D8FC1AB2CE;
	Fri, 14 Nov 2008 10:31:55 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6ECC41AB307;
	Fri, 14 Nov 2008 10:31:55 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <491C58A3.2000609@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100961>

Le jeudi 13 novembre 2008, Paolo Bonzini a =E9crit :
> > Of course it also depends on how often people use "git bisect", but=
 it
> > seems that there are people out there bisecting very frequently and
> > that these people care very much about bisectability of the tree.
>
> What about "git bisect cherry-pick COMMIT" which would do a "cherry-p=
ick
> -n" of COMMIT after every bisection unless COMMIT is in the ancestry =
of
> the current revision?  So if you have to bisect between A and B, and =
you
> know that a bug present between A and B was fixed by C, you could do
>
>   git bisect good A
>   git bisect bad B
>   git bisect cherry-pick C
>
> This would subsume Junio's proposal:

Yes, it looks better than Junio's, except when there is no existing com=
mit=20
that perfectly works.

> users could also set up a few=20
> special bisect/set-debug-to-1, bisect/remove-cflags-o2 and so on patc=
hes
> that you could use for purposes other than ensuring known bugs are fi=
xed.

In this case it is similar to Junio's proposal. But I think that for ch=
anges=20
like set-debug-to-1 and remove-cflags-o2, using the right make command=20
should be enough.

> Finally, you could have a [bisect] configuration section with entries
> like "cherry-pick =3D BROKEN-SHA1 FIX-SHA1" and "git bisect" would ap=
ply
> FIX-SHA1 automatically if the bisect tip were in BROKEN-SHA1..FIX-SHA=
1.

Yes, but how do you share this between members of a team?

Your proposal and Junio's proposal also don't use real sha1 names for=20
commits that are tested, so it's more difficult to talk about them, sha=
re=20
them, use them, ...

Regards,
Christian.
