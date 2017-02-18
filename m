Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EEB201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 01:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbdBRB0R (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 20:26:17 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:60340 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752468AbdBRB0Q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Feb 2017 20:26:16 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 296A3280AD;
        Sat, 18 Feb 2017 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487381173;
        bh=rMBbYsoOXtBGF1eiYXR4Ay9tuq3MCHFD+nhRjr9Tv1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UGNe7u7mswLO+vu0O3czvTmo8JzKcnN33WAPgneYENTSclLv5dSrFuBq/FrVdCT9H
         f5RktlPUTFHYGqOaXV75sCl+scBiJAT7sW0qF4QEAOIa8f82pZ2/GGnerj8ysdf+xH
         bLx2JTldYP98GHjNjYaf/GUOkhwoD4El0dWa6XkSLr2mkCaPqkJ4osQAmwurXEU6rl
         s8IhIGmDAzVuFxvPPWTFeBHRi6x6zVaWf4iYCte3b9sg05RsYFKhR8e3uxfG4JsbxE
         Vv87z/ZfFI1aeEYmBQ2tLjRxA9YuIyqFlcu5pysbCJJz6Im7mAiEoIkEBCeB36YhKY
         rcUao8jZqAcBCwF/+ZZUiBgnKgiAusuW+/+OUYQ6eqvziSU+hmqiodfbv+aAm53tRf
         PcUjUgxlv2ChDRHmeoqehIfjAZkv+uLh5dfxVQh0hpAW8fciQt8cEzuQBt5qnnBC0b
         QB14pn+wfpOS1P4mZ9jlhi5QFaWin/e4hi2H/rx2XQ/P6bTCb7L
Date:   Sat, 18 Feb 2017 01:26:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170218012607.kdisudmmponvts35@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-3-sandals@crustytoothpaste.net>
 <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7emourrbwjhrre7s"
Content-Disposition: inline
In-Reply-To: <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7emourrbwjhrre7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2017 at 01:18:11AM +0000, Ramsay Jones wrote:
>=20
>=20
> On 18/02/17 00:06, brian m. carlson wrote:
> > Convert most leaf functions to struct object_id.  Rewrite several
> > hardcoded numbers in terms of GIT_SHA1_HEXSZ, using an intermediate
> > variable where that makes sense.
> >=20
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  builtin/diff-tree.c | 38 ++++++++++++++++++++------------------
> >  1 file changed, 20 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> > index 8ce00480cd..1f1573bb2a 100644
> > --- a/builtin/diff-tree.c
> > +++ b/builtin/diff-tree.c
> > @@ -7,9 +7,9 @@
> > =20
> >  static struct rev_info log_tree_opt;
> > =20
> > -static int diff_tree_commit_sha1(const unsigned char *sha1)
> > +static int diff_tree_commit_sha1(const struct object_id *oid)
> >  {
> > -	struct commit *commit =3D lookup_commit_reference(sha1);
> > +	struct commit *commit =3D lookup_commit_reference(oid->hash);
> >  	if (!commit)
> >  		return -1;
> >  	return log_tree_commit(&log_tree_opt, commit);
> > @@ -18,22 +18,22 @@ static int diff_tree_commit_sha1(const unsigned cha=
r *sha1)
> >  /* Diff one or more commits. */
> >  static int stdin_diff_commit(struct commit *commit, char *line, int le=
n)
> >  {
> > -	unsigned char sha1[20];
> > -	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
> > +	struct object_id oid;
> > +	if (isspace(line[GIT_SHA1_HEXSZ]) && !get_oid_hex(line+GIT_SHA1_HEXSZ=
+1, &oid)) {
> >  		/* Graft the fake parents locally to the commit */
> > -		int pos =3D 41;
> > +		int pos =3D GIT_SHA1_HEXSZ + 1;
> >  		struct commit_list **pptr;
> > =20
> >  		/* Free the real parent list */
> >  		free_commit_list(commit->parents);
> >  		commit->parents =3D NULL;
> >  		pptr =3D &(commit->parents);
> > -		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
> > -			struct commit *parent =3D lookup_commit(sha1);
> > +		while (line[pos] && !get_oid_hex(line + pos, &oid)) {
> > +			struct commit *parent =3D lookup_commit(oid.hash);
> >  			if (parent) {
> >  				pptr =3D &commit_list_insert(parent, pptr)->next;
> >  			}
> > -			pos +=3D 41;
> > +			pos +=3D GIT_SHA1_HEXSZ + 1;
> >  		}
> >  	}
> >  	return log_tree_commit(&log_tree_opt, commit);
> > @@ -42,11 +42,13 @@ static int stdin_diff_commit(struct commit *commit,=
 char *line, int len)
> >  /* Diff two trees. */
> >  static int stdin_diff_trees(struct tree *tree1, char *line, int len)
> >  {
> > -	unsigned char sha1[20];
> > +	struct object_id oid;
> >  	struct tree *tree2;
> > -	if (len !=3D 82 || !isspace(line[40]) || get_sha1_hex(line + 41, sha1=
))
> > +	const int chunksz =3D GIT_SHA1_HEXSZ + 1;
> > +	if (len !=3D 2 * chunksz || !isspace(line[chunksz-1]) ||
> > +		get_sha1_hex(line + chunksz, oid.hash))
>=20
> I'm not sure that this is an improvement. The input expected in 'line'
> is supposed to look like: '<sha1> + <space> + <sha1> + <\n>'. So your
> 'chunk' would be a <sha1> plus one 'char' of some sort. Except that the
> caller of this function has already replaced the newline character with
> a '\0' char (so strlen(line) would return 81), but still passes the
> original line length! Also, note that this (and other functions in this
> file) actually test for 'isspace(char)' rather than for a ' ' char!
>=20
> Hmm, maybe just:
>=20
> if (len < (2 * GIT_SHA1_HEXSZ + 1) || line[GIT_SHA1_HEXSZ] !=3D ' ' ||
>     get_sha1_hex(line + GIT_SHA1_HEXSZ + 1, oid.hash))
>=20
> (or, perhaps, still call isspace() in this patch ...)

Well, I think it's strictly an improvement in that we have avoided
writing hardcoded constants[0].  I did intend it as a "hash plus one"
chunk, which is actually quite common throughout the code.

I'm wondering if parse_oid_hex could be useful here as well.

[0] If we change the hash size, all of the GIT_SHA1_HEXSZ constants can
be replaced with a variable that varies based on hash size, and the code
still works.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--7emourrbwjhrre7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlinoq8ACgkQv1NdgR9S
9os29A//SDLOLK6mDa2tKXuX+bIgK1lkqVl6Mv5jzEF32jcG9B0Ik9CT6f6jYvtW
sAx/uH0IIUsVEj49JuN1lJrxGlMi8JtKGigaH99WKq4YgsnBpTAq2ps+fs134LNw
jC8mqC3pLj3v1D73aHw9VI6+h+oX/BXe0aU1P3vGg92dYq86dfQc/wHd9fXbBCHd
pJG8Wz0eZZ1uTT54E8HgnSzcsqUo1iwOpwBgrBOY5pfEayZWhLRXV6yQb7TiyEhm
y+eS9x5xEAG9rBEUOeCAh1ZlOr0jBeL6pi6E6nIzkqqA9sPi8Nh5OpqA/LP0Mm/n
twzFFt8415ybFfnRG+sj9/6TdAkC2R4YWY4LuRrwI8Y12MGptMOpSkoSI0Sf6uTr
Vs6YT5jUMtR+gk+HYU+lj/lTy3P2389jdiHVCmbbON4WAp5N7nkNt3JNcCudYbQ+
531g6V8CuYNGEIgjqymureP+1zm1RBv8FMfhNE5JGxpaKLpQwz1Qw27X3TQS3wD7
CA0f2fqjZiXNBK3n80OpbILNjXn6tGy8p17olDNMiheDh0ID1lBXVxdAVK8u/y3J
jgMvdk2Ka0Udy1nuJeCMUXuPGq0xgdtZpvgkHonU8BiWhydqWOPs14GILbhff67p
c9LOGRSGtsVkuja1XcXIuhTpy8qyFgLbAwfoO+huVnFyeVro+cA=
=o8GP
-----END PGP SIGNATURE-----

--7emourrbwjhrre7s--
