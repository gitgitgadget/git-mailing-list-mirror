From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fixes git-cherry algorithmic flaws
Date: Sun, 24 Sep 2006 13:17:38 +0200
Message-ID: <20060924111737.GL20017@pasky.or.cz>
References: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi> <20060924000051.GI20017@pasky.or.cz> <7virjem3tp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 13:18:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRzd-0003cO-5I
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWIXLRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 07:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWIXLRk
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:17:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2740 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750826AbWIXLRj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 07:17:39 -0400
Received: (qmail 5182 invoked by uid 2001); 24 Sep 2006 13:17:38 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virjem3tp.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27657>

Dear diary, on Sun, Sep 24, 2006 at 03:49:22AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
>=20
> > Dear diary, on Mon, Aug 07, 2006 at 12:30:13PM CEST, I got a letter
> > where Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi> said that...
> >> Old algorithm:
> >>         - printed IDs of identical patches with minus (-) sign; th=
ey
> >> 	  should not be printed at all
> >>         - did not print anything from the changes in the upstream
> >>=20
> >> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
> >
> > Ping? Is this patch bogus or was it just forgotten?
>=20
> These are not fixes to "algorithmic flaws".  It's more like that
> Ilpo is writing a different program to fill different needs, and
> I did not see what workflow wanted to have the list of changes
> that were in the upstream and our changes.  Maybe what Ilpo
> wanted to see was something like "git log upstream...mine"
> (three-dots not two to mean symmetric difference).  I dunno.
> That operation certainly did not exist when we did git-cherry
> originally.
>=20
> The original purpose of git-cherry (which probably is different
> from what Ilpo wanted to have, and that is why Ilpo modified it
> into a different program) is for a developer in the contributor
> role to see which ones of local patches have been accepted
> upstream and which ones still remain unapplied -- the intent is
> to help rebase only the latter and keep trying to convince
> upstream that these remaining ones are also worth applying.
>=20
> So minus (-) lines are very much needed to if you want to see
> which ones have been accepted.  Plus lines are used to pick
> which ones to rebase by older version of git-rebase, but I do
> not think we do that anymore.  And in any case we are _not_
> interested in whatever happened in the upstream that did not
> come from the branch we are looking at.

Hmm, well, what's curious is that the documentation says

	Every commit with a changeset that doesn't exist in the other branch
	has its id (sha1) reported, prefixed by a symbol.  Those existing only
	in the <upstream> branch are prefixed with a minus (-) sign, and those
	that only exist in the <head> branch are prefixed with a plus (+)
	symbol.

which is in contradiction of Ilpo's description of the old algorithm
(and also your description of it). It would seem he just wants to fix i=
t
according to the documented behaviour.

I guess the documentation is what's broken then?

--=20
				Petr "Pasky the Let's See How Long I Can
					Manage Arguing Without Actually
					Looking at the Code" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
