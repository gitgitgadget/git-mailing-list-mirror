From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Sat, 28 Nov 2015 17:09:32 +0000
Message-ID: <20151128170932.GC15706@vauxhall.crustytoothpaste.net>
References: <20151125010722.GA23632@sigill.intra.peff.net>
 <20151128154010.GA15706@vauxhall.crustytoothpaste.net>
 <20151128163543.GA26759@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 28 18:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2j0q-0004ew-EO
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 18:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbbK1RJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 12:09:39 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:46218 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752393AbbK1RJi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Nov 2015 12:09:38 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 28D492808C;
	Sat, 28 Nov 2015 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1448730576;
	bh=W4lAY7uC3HSLcIIhQugZDNFxKzTFmi9518zs3RlPD0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbRdJ87Q7Ym5kAHpagby+43mBNZ61htUdcUVWu9XvUpC6CiiJ5R9PWQjkg9QCnnf9
	 52DgVp5S9GKKfU3pUSUaA/1RlP5nzSxeFx0jX4F/h6LeKDSlsKewmcbDYieDZFcUof
	 dX15aLXnz3lUsDI7M/rH30Yp/9NLfCuj1fHGioC/aF7ddZzkIwYC5OQ0asgaeptkn8
	 LP8K27y45VAmcnqxIyqtkyTgk6+sZdIYZi7S2UJvGJdEORMgAHHDaadV2dGVEaLVnG
	 ZbMM2iZIjIijRk5/J3oJ0DK959FMNrFgE1uDF6V5fMxPcUMZgn10YGw/xMFn2cRdDw
	 fWt6t8ZKHz/C0ZcAgdyRuNDst+MS4PJ+fuqOxmV6i5T1y3Vm3SIQbZqKnsYg0G0JEh
	 OPNcNX56QqtmKZ2pFmXuWonPdj+I8fjVNXzifnAsmfqxfZkgHWr9skbm2GNTBhH1BE
	 GeqIi6OgzwWmAfRaLxBbsF0zh58A584WSVw7/fssD/kjjyr3FQq
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20151128163543.GA26759@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281791>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2015 at 11:35:43AM -0500, Jeff King wrote:
> On Sat, Nov 28, 2015 at 03:40:10PM +0000, brian m. carlson wrote:
>=20
> > On Tue, Nov 24, 2015 at 08:07:23PM -0500, Jeff King wrote:
> > > What's cooking in git.git (Nov 2015, #04; Tue, 24)
> > > --------------------------------------------------
> > > [New Topics]
> >=20
> > I noticed the object_id series was missing from this list.  Was there
> > something that needed fixing or a reroll?
>=20
> Thanks for bringing this up; I meant to send a note but forgot.
>=20
> I got a bunch of conflicts trying to merge it into 'next' and 'pu' and
> punted on it. I think the tricky bits are coming from
> dt/refs-backend-pre-vtable, where there was a lot of code movement.

I think as for merging into the latest pu, the thing you want to do in
refs.c is simply take what pu has.  You'll have to fix up one additional
struct object call site.  The same thing goes for builtin/merge.c and
builtin/branch.c, where the code I changed has since been eliminated.

I also noticed that merge-recursive.c and builtin/ff-refs.c needed some
minor fixups as well, but a quick compile will show you where those are.
I've included a diff for those two below.

-----%<-----
diff --git a/builtin/ff-refs.c b/builtin/ff-refs.c
index ae68cfbc..c9d37092 100644
--- a/builtin/ff-refs.c
+++ b/builtin/ff-refs.c
@@ -84,19 +84,19 @@ static void do_ref_update(struct ff_ref_data *data, str=
uct ff_ref_details *detai
 		set_git_dir(details->wt->git_dir);
 		read_index(&the_index);
=20
-		if (checkout_fast_forward(details->branch_commit->object.sha1,
-				details->upstream_commit->object.sha1, 1))
+		if (checkout_fast_forward(details->branch_commit->object.oid.hash,
+				details->upstream_commit->object.oid.hash, 1))
 			details->result_type =3D NON_FAST_FORWARD;
-		else if (update_ref("ff-refs", refname, details->upstream_commit->object=
=2Esha1,
-				details->branch_commit->object.sha1, 0, UPDATE_REFS_QUIET_ON_ERR)) {
+		else if (update_ref("ff-refs", refname, details->upstream_commit->object=
=2Eoid.hash,
+				details->branch_commit->object.oid.hash, 0, UPDATE_REFS_QUIET_ON_ERR))=
 {
 			details->result_type =3D UNABLE_TO_UPDATE;
 			run_hook_le(NULL, "post-merge", "0", NULL);
 		}
 		discard_index(&the_index);
 		chdir(path.buf);
 		strbuf_release(&path);
-	} else if (update_ref("ff-refs", refname, details->upstream_commit->objec=
t.sha1,
-			details->branch_commit->object.sha1, 0, UPDATE_REFS_QUIET_ON_ERR))
+	} else if (update_ref("ff-refs", refname, details->upstream_commit->objec=
t.oid.hash,
+			details->branch_commit->object.oid.hash, 0, UPDATE_REFS_QUIET_ON_ERR))
 		details->result_type =3D UNABLE_TO_UPDATE;
 }
=20
@@ -207,7 +207,7 @@ static int analize_refs(const char *refname,
 					details->upstream_commit);
 			details->merge_base =3D bases->item;
=20
-			if (!hashcmp(upstream_hash, details->merge_base->object.sha1))
+			if (!hashcmp(upstream_hash, details->merge_base->object.oid.hash))
 				details->result_type =3D UP_TO_DATE;
=20
 			else if (!in_merge_bases(details->branch_commit, details->upstream_comm=
it))
diff --git a/merge-recursive.c b/merge-recursive.c
index 09d99640..50a16ebf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1835,8 +1835,8 @@ int merge_trees(struct merge_options *o,
 	if (code !=3D 0) {
 		if (o->gently)
 			return error(_("merging of trees %s and %s failed"),
-			    sha1_to_hex(head->object.sha1),
-			    sha1_to_hex(merge->object.sha1));
+			    oid_to_hex(&head->object.oid),
+			    oid_to_hex(&merge->object.oid));
=20
 		if (show(o, 4) || o->call_depth)
 			die(_("merging of trees %s and %s failed"),
-----%<-----
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWWd/MAAoJEL9TXYEfUvaLV+gQALBkjM/2OAf9LKH4PXDF9U6k
eKlPq4D7fJD4XTO57pSarJe41US8XET+pT0dRbESDwjnqsiKX3387hItO1mjahSU
Irx1fm3L6L8NfKgB9HraggVXuheYNx0yMtKiUvLIVHOB3eME3HVlC08Yl9btIcc2
j7EhPHBKHYQnOlUJvdbgVkqSSdf/vz2q9Dhw0ahIy8CiwqDlJpdEiferssM3b2Ux
rOVvj9Z633/v3R7YdWZ/xZo1awowRGfyr0+eiLa6yhiVFZNrrOLx/EAOg15I83cY
QtQKVOjSrlLKRcKja6MUrWYMQ4yroWu0xc71y7KgBogOIJJICfr3nRitPQdvLLL7
b48GlM2IZxjJ4VC1Dyq++skpbqWIzmmLc1/C8ueTt6311LTYI3UOZ/jNHelbKuFM
e0WZQhMgLeKzKQ+672KnNAHNXpVefB7DMuPZ/l6sqOOlosqSLV5v2NRKwZsTMCX/
8cQ8BTz2veySyC+3NGUZfcPg9GuGdJwprIoh3I+cQLvwYB5imYMH8VyTg8eRQZR0
MawxEN0UUDgXFjVeqnypLm0ddD+h2NtRP3BfYvEkKb0N/6M6qWmN57XucyQkRGAW
lVpShMXDALlA3g/m7wUYRA1KM7zsVlSiGHcXFoRLWrC9HWhzsp2TYgBLogpGjmV5
py8ZveVYYtJM7uzsVQhe
=00Xq
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
