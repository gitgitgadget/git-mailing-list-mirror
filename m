From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Thu, 14 Apr 2005 11:55:57 +0200
Message-ID: <1113472557.23299.99.camel@nosferatu.lan>
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
	 <1113471609.23299.95.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ess7+6E2SOb6MULuUZTs"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:49:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM0yJ-000259-Qv
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 11:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDNJwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 05:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDNJwe
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 05:52:34 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:50315 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261453AbVDNJwS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 05:52:18 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id E2443B7F0;
	Thu, 14 Apr 2005 11:52:12 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id A59543A26DB;
	Thu, 14 Apr 2005 11:58:16 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21353-16; Thu, 14 Apr 2005 11:58:07 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 7BD263A26DA;
	Thu, 14 Apr 2005 11:58:07 +0200 (SAST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <1113471609.23299.95.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ess7+6E2SOb6MULuUZTs
Content-Type: multipart/mixed; boundary="=-MIv/XzASgdn/dRAZVy3T"


--=-MIv/XzASgdn/dRAZVy3T
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 11:40 +0200, Martin Schlemmer wrote:
> On Thu, 2005-04-14 at 11:11 +0200, Petr Baudis wrote:
> > Please trim the replied mails a bit, snipping old and irrelevant parts.
> > This is insane. :-)
> >=20
> > Dear diary, on Thu, Apr 14, 2005 at 10:38:25AM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > ..snip..
> > > Normalize show-diff output, add --update-modes target to update-cache=
,
> > > and make sure we only show real changes after changing the tracked
> > > branch, as well as update the file modes according to the cache.
> >=20
> > I'm lost. Why do you do --update-modes? That makes no sense to me.
> > You introduce them to the cache out-of-order w.r.t. commits, that means
> > in the normal git usage they are already unrevertable.
> >=20
>=20
> Right, afterwards I thought I did add it to the wrong place.
>=20
>=20
> > What are you trying to do? Mode changes _are_ real changes. You _don't_
> > want to silence them. What you want is to even show them more explicitl=
y
> > in show-diff.
> >=20
>=20
> No, you do not understand.  If you actually change the mode, it will
> show.  What now happens, is that say I track the 'linus' branch, then
> untrack, and then track 'pasky' again, the Patches will be applied, but
> not the mode changes which are stored in the cache ...
>
> So basically the modes that are stored in the cache are not applied ...
> Although, yes, I prob should add the relevant code to checkout-cache.
>=20

Ok, this should be a better one I think.

----

Normalize show-diff output, add --update-modes target to update-cache,
and make sure we only show real changes after changing the tracked
branch, as well as update the file modes according to the cache.

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

checkout-cache.c:  f06871cdbc1b18ea93bdf4e17126aeb4cca1373e
--- f06871cdbc1b18ea93bdf4e17126aeb4cca1373e/checkout-cache.c
+++ uncommitted/checkout-cache.c
@@ -34,7 +34,7 @@
  */
 #include "cache.h"

-static int force =3D 0, quiet =3D 0;
+static int force =3D 0, quiet =3D 0, update_mode =3D 0;

 static void create_directories(const char *path)
 {
@@ -99,6 +99,8 @@
                unsigned changed =3D cache_match_stat(ce, &st);
                if (!changed)
                        return 0;
+               if (update_mode && changed & MODE_CHANGED)
+                       chmod(ce->name, ce->st_mode);
                if (!force) {
                        if (!quiet)
                                fprintf(stderr, "checkout-cache: %s already=
 exists\n", ce->name);
@@ -158,6 +160,10 @@
                                quiet =3D 1;
                                continue;
                        }
+                       if (!strcmp(arg, "-m")) {
+                               update_mode =3D 1;
+                               continue;
+                       }
                }
                checkout_file(arg);
        }
gitcancel.sh:  ec58f7444a42cd3cbaae919fc68c70a3866420c0
--- ec58f7444a42cd3cbaae919fc68c70a3866420c0/gitcancel.sh
+++ uncommitted/gitcancel.sh
@@ -12,7 +12,8 @@

 # FIXME: Does not revert mode changes!

-show-diff | patch -p0 -R
+show-diff | patch -p1 -R
 rm -f .git/add-queue .git/rm-queue .git/merged

+checkout-cache -q -m -a
 update-cache --refresh
gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
--- 03d6db1fb3a70605ef249c632c04e542457f0808/gittrack.sh
+++ uncommitted/gittrack.sh
@@ -51,6 +51,8 @@

        read-tree $(tree-id "$name")
        gitdiff.sh local "$name" | gitapply.sh
+       checkout-cache -q -m -a
+       update-cache --refresh

 else
        [ "$tracking" ] || \
@@ -61,6 +63,8 @@
        if [ -s ".git/HEAD.local" ]; then
                gitdiff.sh "$tracking" local | gitapply.sh
                read-tree $(tree-id local)
+               checkout-cache -q -m -a
+               update-cache --refresh

                head=3D$(cat .git/HEAD)
                branchhead=3D$(cat .git/heads/$tracking)
show-diff.c:  a531ca4078525d1c8dcf84aae0bfa89fed6e5d96
--- a531ca4078525d1c8dcf84aae0bfa89fed6e5d96/show-diff.c
+++ uncommitted/show-diff.c
@@ -5,13 +5,18 @@
  */
 #include "cache.h"

-static void show_differences(char *name,
+static void show_differences(struct cache_entry *ce,
        void *old_contents, unsigned long long old_size)
 {
        static char cmd[1000];
+       static char sha1[41];
+       int n;
        FILE *f;

-       snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name);
+       for (n =3D 0; n < 20; n++)
+               snprintf(&(sha1[n*2]), 3, "%02x", ce->sha1[n]);
+       snprintf(cmd, sizeof(cmd), "diff -L %s/%s -L uncommitted/%s -u -N  =
- %s",
+               sha1, ce->name, ce->name, ce->name);
        f =3D popen(cmd, "w");
        if (old_size)
                fwrite(old_contents, old_size, 1, f);
@@ -99,7 +104,7 @@
                        continue;

                new =3D read_sha1_file(ce->sha1, type, &size);
-               show_differences(ce->name, new, size);
+               show_differences(ce, new, size);
                free(new);
        }
        return 0;


--=20
Martin Schlemmer


--=-MIv/XzASgdn/dRAZVy3T
Content-Disposition: attachment; filename=git-show-diff.patch
Content-Type: text/x-patch; name=git-show-diff.patch; charset=UTF-8
Content-Transfer-Encoding: base64

Y2hlY2tvdXQtY2FjaGUuYzogIGYwNjg3MWNkYmMxYjE4ZWE5M2JkZjRlMTcxMjZhZWI0Y2NhMTM3
M2UNCi0tLSBmMDY4NzFjZGJjMWIxOGVhOTNiZGY0ZTE3MTI2YWViNGNjYTEzNzNlL2NoZWNrb3V0
LWNhY2hlLmMNCisrKyB1bmNvbW1pdHRlZC9jaGVja291dC1jYWNoZS5jDQpAQCAtMzQsNyArMzQs
NyBAQA0KICAqLw0KICNpbmNsdWRlICJjYWNoZS5oIg0KIA0KLXN0YXRpYyBpbnQgZm9yY2UgPSAw
LCBxdWlldCA9IDA7DQorc3RhdGljIGludCBmb3JjZSA9IDAsIHF1aWV0ID0gMCwgdXBkYXRlX21v
ZGUgPSAwOw0KIA0KIHN0YXRpYyB2b2lkIGNyZWF0ZV9kaXJlY3Rvcmllcyhjb25zdCBjaGFyICpw
YXRoKQ0KIHsNCkBAIC05OSw2ICs5OSw4IEBADQogCQl1bnNpZ25lZCBjaGFuZ2VkID0gY2FjaGVf
bWF0Y2hfc3RhdChjZSwgJnN0KTsNCiAJCWlmICghY2hhbmdlZCkNCiAJCQlyZXR1cm4gMDsNCisJ
CWlmICh1cGRhdGVfbW9kZSAmJiBjaGFuZ2VkICYgTU9ERV9DSEFOR0VEKQ0KKwkJCWNobW9kKGNl
LT5uYW1lLCBjZS0+c3RfbW9kZSk7DQogCQlpZiAoIWZvcmNlKSB7DQogCQkJaWYgKCFxdWlldCkN
CiAJCQkJZnByaW50ZihzdGRlcnIsICJjaGVja291dC1jYWNoZTogJXMgYWxyZWFkeSBleGlzdHNc
biIsIGNlLT5uYW1lKTsNCkBAIC0xNTgsNiArMTYwLDEwIEBADQogCQkJCXF1aWV0ID0gMTsNCiAJ
CQkJY29udGludWU7DQogCQkJfQ0KKwkJCWlmICghc3RyY21wKGFyZywgIi1tIikpIHsNCisJCQkJ
dXBkYXRlX21vZGUgPSAxOw0KKwkJCQljb250aW51ZTsNCisJCQl9DQogCQl9DQogCQljaGVja291
dF9maWxlKGFyZyk7DQogCX0NCmdpdGNhbmNlbC5zaDogIGVjNThmNzQ0NGE0MmNkM2NiYWFlOTE5
ZmM2OGM3MGEzODY2NDIwYzANCi0tLSBlYzU4Zjc0NDRhNDJjZDNjYmFhZTkxOWZjNjhjNzBhMzg2
NjQyMGMwL2dpdGNhbmNlbC5zaA0KKysrIHVuY29tbWl0dGVkL2dpdGNhbmNlbC5zaA0KQEAgLTEy
LDcgKzEyLDggQEANCiANCiAjIEZJWE1FOiBEb2VzIG5vdCByZXZlcnQgbW9kZSBjaGFuZ2VzIQ0K
IA0KLXNob3ctZGlmZiB8IHBhdGNoIC1wMCAtUg0KK3Nob3ctZGlmZiB8IHBhdGNoIC1wMSAtUg0K
IHJtIC1mIC5naXQvYWRkLXF1ZXVlIC5naXQvcm0tcXVldWUgLmdpdC9tZXJnZWQNCiANCitjaGVj
a291dC1jYWNoZSAtcSAtbSAtYQ0KIHVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gNCmdpdHRyYWNrLnNo
OiAgMDNkNmRiMWZiM2E3MDYwNWVmMjQ5YzYzMmMwNGU1NDI0NTdmMDgwOA0KLS0tIDAzZDZkYjFm
YjNhNzA2MDVlZjI0OWM2MzJjMDRlNTQyNDU3ZjA4MDgvZ2l0dHJhY2suc2gNCisrKyB1bmNvbW1p
dHRlZC9naXR0cmFjay5zaA0KQEAgLTUxLDYgKzUxLDggQEANCiANCiAJcmVhZC10cmVlICQodHJl
ZS1pZCAiJG5hbWUiKQ0KIAlnaXRkaWZmLnNoIGxvY2FsICIkbmFtZSIgfCBnaXRhcHBseS5zaA0K
KwljaGVja291dC1jYWNoZSAtcSAtbSAtYQ0KKwl1cGRhdGUtY2FjaGUgLS1yZWZyZXNoDQogDQog
ZWxzZQ0KIAlbICIkdHJhY2tpbmciIF0gfHwgXA0KQEAgLTYxLDYgKzYzLDggQEANCiAJaWYgWyAt
cyAiLmdpdC9IRUFELmxvY2FsIiBdOyB0aGVuDQogCQlnaXRkaWZmLnNoICIkdHJhY2tpbmciIGxv
Y2FsIHwgZ2l0YXBwbHkuc2gNCiAJCXJlYWQtdHJlZSAkKHRyZWUtaWQgbG9jYWwpDQorCQljaGVj
a291dC1jYWNoZSAtcSAtbSAtYQ0KKwkJdXBkYXRlLWNhY2hlIC0tcmVmcmVzaA0KIA0KIAkJaGVh
ZD0kKGNhdCAuZ2l0L0hFQUQpDQogCQlicmFuY2hoZWFkPSQoY2F0IC5naXQvaGVhZHMvJHRyYWNr
aW5nKQ0Kc2hvdy1kaWZmLmM6ICBhNTMxY2E0MDc4NTI1ZDFjOGRjZjg0YWFlMGJmYTg5ZmVkNmU1
ZDk2DQotLS0gYTUzMWNhNDA3ODUyNWQxYzhkY2Y4NGFhZTBiZmE4OWZlZDZlNWQ5Ni9zaG93LWRp
ZmYuYw0KKysrIHVuY29tbWl0dGVkL3Nob3ctZGlmZi5jDQpAQCAtNSwxMyArNSwxOCBAQA0KICAq
Lw0KICNpbmNsdWRlICJjYWNoZS5oIg0KIA0KLXN0YXRpYyB2b2lkIHNob3dfZGlmZmVyZW5jZXMo
Y2hhciAqbmFtZSwNCitzdGF0aWMgdm9pZCBzaG93X2RpZmZlcmVuY2VzKHN0cnVjdCBjYWNoZV9l
bnRyeSAqY2UsDQogCXZvaWQgKm9sZF9jb250ZW50cywgdW5zaWduZWQgbG9uZyBsb25nIG9sZF9z
aXplKQ0KIHsNCiAJc3RhdGljIGNoYXIgY21kWzEwMDBdOw0KKwlzdGF0aWMgY2hhciBzaGExWzQx
XTsNCisJaW50IG47DQogCUZJTEUgKmY7DQogDQotCXNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCks
ICJkaWZmIC1MICVzIC11IC1OICAtICVzIiwgbmFtZSwgbmFtZSk7DQorCWZvciAobiA9IDA7IG4g
PCAyMDsgbisrKQ0KKwkJc25wcmludGYoJihzaGExW24qMl0pLCAzLCAiJTAyeCIsIGNlLT5zaGEx
W25dKTsNCisJc25wcmludGYoY21kLCBzaXplb2YoY21kKSwgImRpZmYgLUwgJXMvJXMgLUwgdW5j
b21taXR0ZWQvJXMgLXUgLU4gIC0gJXMiLA0KKwkJc2hhMSwgY2UtPm5hbWUsIGNlLT5uYW1lLCBj
ZS0+bmFtZSk7DQogCWYgPSBwb3BlbihjbWQsICJ3Iik7DQogCWlmIChvbGRfc2l6ZSkNCiAJCWZ3
cml0ZShvbGRfY29udGVudHMsIG9sZF9zaXplLCAxLCBmKTsNCkBAIC05OSw3ICsxMDQsNyBAQA0K
IAkJCWNvbnRpbnVlOw0KIA0KIAkJbmV3ID0gcmVhZF9zaGExX2ZpbGUoY2UtPnNoYTEsIHR5cGUs
ICZzaXplKTsNCi0JCXNob3dfZGlmZmVyZW5jZXMoY2UtPm5hbWUsIG5ldywgc2l6ZSk7DQorCQlz
aG93X2RpZmZlcmVuY2VzKGNlLCBuZXcsIHNpemUpOw0KIAkJZnJlZShuZXcpOw0KIAl9DQogCXJl
dHVybiAwOw0K


--=-MIv/XzASgdn/dRAZVy3T--

--=-ess7+6E2SOb6MULuUZTs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXj4tqburzKaJYLYRAh6kAJwKN8o83Bg8AJc/S9wzqbJ9kwMj9QCeL/Vs
uNaffXyAH/neK3ZLT4ntMWQ=
=56dx
-----END PGP SIGNATURE-----

--=-ess7+6E2SOb6MULuUZTs--

