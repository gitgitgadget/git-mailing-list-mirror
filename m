From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Remove need to untrack before tracking new branch
Date: Fri, 15 Apr 2005 01:01:27 +0200
Message-ID: <1113519687.23299.126.camel@nosferatu.lan>
References: <20050413075441.GD16489@pasky.ji.cz>
	 <1113381672.23299.47.camel@nosferatu.lan>
	 <20050413092656.GO16489@pasky.ji.cz>
	 <1113394537.23299.51.camel@nosferatu.lan>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
	 <1113467335.23299.77.camel@nosferatu.lan>
	 <1113467905.23299.81.camel@nosferatu.lan>
	 <20050414091106.GX25711@pasky.ji.cz>
	 <1113471609.23299.95.camel@nosferatu.lan>
	 <20050414224257.GM22699@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-19hen/N5vYn1iyud/zBb"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:57:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDGt-0003MZ-9j
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVDNW7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVDNW7k
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:59:40 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:21394 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261629AbVDNW5k
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:57:40 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id 4CA883686;
	Fri, 15 Apr 2005 00:57:37 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id AFF0F3A26DB;
	Fri, 15 Apr 2005 01:03:43 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22424-05; Fri, 15 Apr 2005 01:03:38 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 331703A26DA;
	Fri, 15 Apr 2005 01:03:38 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414224257.GM22699@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-19hen/N5vYn1iyud/zBb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 00:42 +0200, Petr Baudis wrote:
> Dear diary, on Thu, Apr 14, 2005 at 11:40:09AM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > (PS, can you check the fact that your mail client keeps on adding a 'Re=
:
> > ' ...)
>=20
> Hmm. I guess my ancient reply_regexp
> "^((\\[|\\()([^B]|B([^u]|u([^g]|g([^ ]|AnTiMaTcH))))[^]]+(\\]|\\)))?[
>  \t]*((re([\\[0-9\\]+])*|aw):[ \t]*)?" is broken... ;-)
>=20
> > On Thu, 2005-04-14 at 11:11 +0200, Petr Baudis wrote:
> > > I'm lost. Why do you do --update-modes? That makes no sense to me.
> > > You introduce them to the cache out-of-order w.r.t. commits, that mea=
ns
> > > in the normal git usage they are already unrevertable.
> > >=20
> >=20
> > Right, afterwards I thought I did add it to the wrong place.
>=20
> So, could you please do something with it? :-)
>=20
> > > What are you trying to do? Mode changes _are_ real changes. You _don'=
t_
> > > want to silence them. What you want is to even show them more explici=
tly
> > > in show-diff.
> > >=20
> >=20
> > No, you do not understand.  If you actually change the mode, it will
> > show.  What now happens, is that say I track the 'linus' branch, then
> > untrack, and then track 'pasky' again, the Patches will be applied, but
> > not the mode changes which are stored in the cache ...  Let me show you=
:
> >=20
> > -----
> > $ ls -l $(./show-diff -s | cut -d: -f1)
> ..directroy listing with no 'x' bit..
> > -----
> >=20
> > (Note no 'x' bit ...)
> >=20
> > And that is _after_ doing:
> >=20
> >  $ git track linus; git track
> >=20
> > So basically the modes that are stored in the cache are not applied ...
> > Although, yes, I prob should add the relevant code to checkout-cache.
>=20
> This should be fixed now, BTW. git apply didn't correctly apply the
> mode changes, but now it should. Several bugs prevented it to, in fact.
> ;-)
>=20

Yep, I saw - thought you scrapped this, so mailed a new patch (or was
busy doing the touch ups to the email when this came in.

> > > > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > > > --- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
> > > > +++ uncommitted/show-diff.c
> > > > @@ -5,13 +5,18 @@
> > > >   */
> > > >  #include "cache.h"
> > > >=20
> > > > -static void show_differences(char *name,
> > > > +static void show_differences(struct cache_entry *ce,
> > > >         void *old_contents, unsigned long long old_size)
> > > >  {
> > > >         static char cmd[1000];
> > > > +       static char sha1[41];
> > > > +       int n;
> > > >         FILE *f;
> > > >=20
> > > > -       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, =
name);
> > > > +       for (n =3D 0; n < 20; n++)
> > > > +               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
> > > > +       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s=
 -u -N  - %s",
> > > > +               sha1, ce->name, ce->name, ce->name);
> > >=20
> > > The "directory" sha1 is the sha1 of the tree, not of the particular
> > > file - that one is in the "attributes" list (parentheses after the
> > > filename), together with mode.
> > >=20
> >=20
> > Does it really matter?  It is more just to get the patch prefix right,
> > and I did it as it went nicely with the printed:
> >=20
> > ----
> > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > ----
> >=20
> > for example ...
>=20
> Yes, it matters, and I don't care how nicely it wents with what you
> print before.
>=20

hah ;p

> Either print there some nonsense which is clear not to be a tree ID, or
> (much more preferably) print the real tree ID there. If some tool ever
> uses it (e.g. to help resolve conflicts, perhaps even actually doing a
> real merge based on the patch), you just confused it.
>=20

Ok, understood.  Do you think it will be scripted?  If not I guess we
can just do labels like:

--- committed/
+++ uncommitted/

?

> Also, do you think you could separate this patch from the other
> (--update-modes) patch? (If we actually still need the --update-modes
> patch after git apply was fixed.)
>=20

Yeah, already split it out locally, just waiting on above response ...


Thanks,

--=20
Martin Schlemmer


--=-19hen/N5vYn1iyud/zBb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvZHqburzKaJYLYRAi7+AJ0baQUSCe61fuNwbVEKEf40tcgdewCfV/F/
Vkj7unIlnp2HRI/A/kgsEsw=
=vrLZ
-----END PGP SIGNATURE-----

--=-19hen/N5vYn1iyud/zBb--

