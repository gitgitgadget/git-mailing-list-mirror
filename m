From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 11:40:09 +0200
Message-ID: <1113471609.23299.95.camel@nosferatu.lan>
References: <20050412132307.GH22614@pasky.ji.cz>
	 <1113375277.23299.25.camel@nosferatu.lan>
	 <20050413075441.GD16489@pasky.ji.cz>
	 <1113381672.23299.47.camel@nosferatu.lan>
	 <20050413092656.GO16489@pasky.ji.cz>
	 <1113394537.23299.51.camel@nosferatu.lan>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
	 <1113467335.23299.77.camel@nosferatu.lan>
	 <1113467905.23299.81.camel@nosferatu.lan>
	 <20050414091106.GX25711@pasky.ji.cz>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UmfI4hoS+Hr5tRIgv2MI"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:34:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM0jA-0008KP-NO
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 11:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDNJgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 05:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVDNJgx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 05:36:53 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:12491 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S261458AbVDNJgl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 05:36:41 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg2.saix.net (Postfix) with ESMTP id 57727D622;
	Thu, 14 Apr 2005 11:36:22 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 9834A3A26DB;
	Thu, 14 Apr 2005 11:42:25 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31206-09; Thu, 14 Apr 2005 11:42:19 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 6352C3A26DA;
	Thu, 14 Apr 2005 11:42:19 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050414091106.GX25711@pasky.ji.cz>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-UmfI4hoS+Hr5tRIgv2MI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

(PS, can you check the fact that your mail client keeps on adding a 'Re:
' ...)

On Thu, 2005-04-14 at 11:11 +0200, Petr Baudis wrote:
> Please trim the replied mails a bit, snipping old and irrelevant parts.
> This is insane. :-)
>=20
> Dear diary, on Thu, Apr 14, 2005 at 10:38:25AM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> ..snip..
> > Normalize show-diff output, add --update-modes target to update-cache,
> > and make sure we only show real changes after changing the tracked
> > branch, as well as update the file modes according to the cache.
>=20
> I'm lost. Why do you do --update-modes? That makes no sense to me.
> You introduce them to the cache out-of-order w.r.t. commits, that means
> in the normal git usage they are already unrevertable.
>=20

Right, afterwards I thought I did add it to the wrong place.


> What are you trying to do? Mode changes _are_ real changes. You _don't_
> want to silence them. What you want is to even show them more explicitly
> in show-diff.
>=20

No, you do not understand.  If you actually change the mode, it will
show.  What now happens, is that say I track the 'linus' branch, then
untrack, and then track 'pasky' again, the Patches will be applied, but
not the mode changes which are stored in the cache ...  Let me show you:

-----
$ ls -l $(./show-diff -s | cut -d: -f1)
-rw-r--r--  1 root root  168 Apr 14 11:33 commit-id
-rw-r--r--  1 root root 2213 Apr 14 11:33 git
-rw-r--r--  1 root root 1168 Apr 14 11:33 gitXnormid.sh
-rw-r--r--  1 root root  403 Apr 14 11:33 gitadd.sh
-rw-r--r--  1 root root  844 Apr 14 11:33 gitaddremote.sh
-rw-r--r--  1 root root 1899 Apr 14 11:33 gitapply.sh
-rw-r--r--  1 root root  479 Apr 14 11:33 gitcancel.sh
-rw-r--r--  1 root root 2512 Apr 14 11:33 gitcommit.sh
-rw-r--r--  1 root root 2152 Apr 14 11:33 gitdiff-do
-rw-r--r--  1 root root  819 Apr 14 11:33 gitdiff.sh
-rw-r--r--  1 root root  717 Apr 14 11:33 gitexport.sh
-rw-r--r--  1 root root  524 Apr 14 11:33 gitlog.sh
-rw-r--r--  1 root root  228 Apr 14 11:33 gitls.sh
-rw-r--r--  1 root root  904 Apr 14 11:33 gitlsobj.sh
-rw-r--r--  1 root root  665 Apr 14 11:33 gitmerge.sh
-rw-r--r--  1 root root 2044 Apr 14 11:33 gitpull.sh
-rw-r--r--  1 root root  433 Apr 14 11:33 gitrm.sh
-rw-r--r--  1 root root  614 Apr 14 11:33 gittag.sh
-rw-r--r--  1 root root 2272 Apr 14 11:33 gittrack.sh
-rw-r--r--  1 root root  284 Apr 14 11:33 parent-id
-rw-r--r--  1 root root  177 Apr 14 11:33 tree-id
-----

(Note no 'x' bit ...)

And that is _after_ doing:

 $ git track linus; git track

So basically the modes that are stored in the cache are not applied ...
Although, yes, I prob should add the relevant code to checkout-cache.

> The --refreshes are fine.
>=20
> > Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
> >=20
> > gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
> > --- ec58f7444a42cd3cbaae919fc68c70a3866420c0/gitcancel.sh
> > +++ uncommitted/gitcancel.sh
> > @@ -12,7 +12,8 @@
> >=20
> >  # FIXME: Does not revert mode changes!
> >=20
> > -show-diff | patch -p0 -R
> > +show-diff | patch -p1 -R
> >  rm -f .git/add-queue .git/rm-queue .git/merged
> >=20
> > -update-cache --refresh
> > +# --update-modes need to be before --refresh
> > +update-cache --update-modes --refresh
>=20
> Here, e.g., you should do the very opposite - change the modes back to
> how are they in the cache.
>=20

Uhm, that is what it did ...  Like I said above, the wrong place though
to add the code to update-cache.

> > show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
> > --- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
> > +++ uncommitted/show-diff.c
> > @@ -5,13 +5,18 @@
> >   */
> >  #include "cache.h"
> >=20
> > -static void show_differences(char *name,
> > +static void show_differences(struct cache_entry *ce,
> >         void *old_contents, unsigned long long old_size)
> >  {
> >         static char cmd[1000];
> > +       static char sha1[41];
> > +       int n;
> >         FILE *f;
> >=20
> > -       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name=
);
> > +       for (n =3D 0; n < 20; n++)
> > +               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
> > +       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s -u =
-N  - %s",
> > +               sha1, ce->name, ce->name, ce->name);
>=20
> The "directory" sha1 is the sha1 of the tree, not of the particular
> file - that one is in the "attributes" list (parentheses after the
> filename), together with mode.
>=20

Does it really matter?  It is more just to get the patch prefix right,
and I did it as it went nicely with the printed:

----
show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
----

for example ...

> >         f =3D popen(cmd, "w");
> >         if (old_size)
> >                 fwrite(old_contents, old_size, 1, f);
> > @@ -99,7 +104,7 @@
> >                         continue;
> >=20
> >                 new =3D read_sha1_file(ce->sha1, type, &size);
> > -               show_differences(ce->name, new, size);
> > +               show_differences(ce, new, size);
> >                 free(new);
> >         }
> >         return 0;
> > update-cache.c:  62d0a6c41560d40863c44599355af10d9e089312
> > --- 62d0a6c41560d40863c44599355af10d9e089312/update-cache.c
> > +++ uncommitted/update-cache.c
> > @@ -210,6 +210,39 @@
> >         }
> >  }
> >=20
> > +static struct cache_entry *update_file_mode(struct cache_entry *ce)
> > +{
> > +       struct stat st;
> > +       int changed;
> > +
> > +       if (stat(ce->name, &st) < 0)
> > +               return NULL;
> > +
> > +       changed =3D cache_match_stat(ce, &st);
> > +       if (!changed)
> > +               return ce;
> > +
> > +       if (changed & MODE_CHANGED)
> > +               if (chmod(ce->name, ce->st_mode))
> > +                       return NULL;
> > +
> > +       return ce;
> > +}
> > +
> > +static void update_modes(void)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < active_nr; i++) {
> > +               struct cache_entry *ce =3D active_cache[i];
> > +
> > +               if (!update_file_mode(ce)) {
> > +                       printf("%s: needs update\n", ce->name);
> > +                       continue;
> > +               }
> > +       }
> > +}
> > +
> >  /*
> >   * We fundamentally don't like some paths: we don't want
> >   * dot or dot-dot anywhere, and in fact, we don't even want
>=20
> Oh. So you are actually doing the _opposite_! But that's very wrong too.
> update-cache is for the direction tree -> index. For the opposite
> direction, you should use checkout-cache.
>=20

Right, will do.

> > @@ -282,6 +315,10 @@
> >                                 refresh_cache();
> >                                 continue;
> >                         }
> > +                       if (!strcmp(path, "--update-modes")) {
> > +                               update_modes();
> > +                               continue;
> > +                       }
> >                         die("unknown option %s", path);
> >                 }
> >                 if (!verify_path(path)) {
> >=20
> >=20
> > --=20
> > Martin Schlemmer
> >=20
>=20


--=20
Martin Schlemmer


--=-UmfI4hoS+Hr5tRIgv2MI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXjp5qburzKaJYLYRAjxvAJ4vZitSDMzLUzVAg7l3Ytq8cZFT/wCfbwh/
iagT6oRixrPtMlN1TQutlQY=
=gZSC
-----END PGP SIGNATURE-----

--=-UmfI4hoS+Hr5tRIgv2MI--

