Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A2C636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBGWeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBGWeT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:34:19 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8003C38B53
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:34:17 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6BDD05A210;
        Tue,  7 Feb 2023 22:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675809256;
        bh=jKLgGNo70zyKwq+TUlunDA+9evpmsGSMGT6wVJK1tNQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yR0hAlUvUfQKzgoy4SNBZ/RR1n86qgnSsAa5/5E+f7qOLOG3K4A43DZagXrKzCd5O
         B4sy6JLXa4KgCJN9s5lEWUJ0LpWUTyaWMzM7hKVpEYawChqYADAz5r2vjwrbfr6GPn
         6rKb3Lm6JnCAf7sjFoSiIJEwDpn/lmYO8WLDBjypqpliRbj44QVsfSj6vG982LwNOE
         7JGpr1iRPzOK7eDiY+O4qfIDXx8M4t1YPyD0eQQkfI9T58vcJh0QitoPdic39o3C8P
         7O5lulFONlEMbX4zKqhKaRqn6420cFPzgffBHWHriuW8bbO6fjCWCW2IgUePXn6WIz
         Fi0g7MHGn3yajXZTfku9ZRniX2wjWtQZjpMx26JAHtPnEGv/jt5wTrzI8pVQlviYqp
         uDRP7eX5kcAG1DNRunpeSm75htq4/R2GWtBqmKrGbdz03pPX9gGYaI2LOCmNvNYWzl
         cHBcJqWaD1dCQYcvghqVJ6HuqXZ/VB1MxUtjXX2XODbAs5iW8d9
Date:   Tue, 7 Feb 2023 22:34:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Message-ID: <Y+LR5rlFTqyLfoeF@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
 <20230205221728.4179674-2-sandals@crustytoothpaste.net>
 <xmqq8rha5wno.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bUvcJeh1ag/wKNqY"
Content-Disposition: inline
In-Reply-To: <xmqq8rha5wno.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bUvcJeh1ag/wKNqY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-06 at 21:08:59, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> "is identical to what"?  Ditto for the one in the previous
> paragraph.  The first paragraph is better in that there is "between
> versions", even though it would be easier to grok if we made it more
> clear that we are talking about versions of the software that is
> used to create the archive, not the version of contents being
> archived.
>=20
> Our goal is that serializing the same tree object or the same commit
> object result in bit-for-bit identical result, no matter which
> version of Git is used, and no matter what platform the Git used to
> create the archive was built on.  Mentioning both what we take an
> archive out of (i.e. tree or commit) and we can use different
> versions of Git to create archives, in the description would make it
> easier to grok.

I can update that to reflect things more accurately.

> > +Goals and Rationale
> > +-------------------
> > +
> > +The goals for this format are that it is first and foremost reproducib=
le, that
> > +identical trees produce identical results, that it is simple and easy =
to
> > +implement correctly, and that it is useful in general.  While we don't=
 consider
> > +functionality needs beyond Git's at the moment (such as hardlinks, xat=
trs, or
> > +sparse files), there is intense interest in reproducible builds, and s=
o it makes
> > +sense to design something that can see general use for software interc=
hange.
>=20
> Perfect.
>=20
> > +Because the goal is strict reproducibility, this format doesn't honor
> > +`tar.umask` or other options that can produce different output.  It se=
rializes
> > +all timestamps as the Epoch, which produces identical results whether =
the tree
> > +is serialized as a tree, commit, or tag.  This is consistent with the =
behaviour
> > +of some other tar serializers, including the default for modern Rust c=
rates, and
> > +is not believed to pose any interoperability problems.
>=20
> > +Object IDs are not included in this version of the format because this=
 produces
> > +non-identical data when identical data is serialized with different ha=
sh
> > +algorithms.
>=20
> Declaring that we'll always peel a tag or a commit down to a tree is
> one sure way to avoid having to worry about object name hashes, but
> aren't we discarding too much utility by doing so?
>=20
> This is probably debatable.  The commit object name embedded in the
> extended header of an archive makes it trivial to identify what
> version the archive _claims_ to have been taken from (you could also
> embed it in the filename that stores archive, but the use of the
> embedded metainfo makes it more robust against file names).  And
> running "git archive" twice, with different versions of Git on
> different architectures, should be reproducible as long as both
> invokers expressed their desire to see the commit object name in the
> archive by passing the commit, not its tree, to the command, and
> they are using the same hash algorithm.

It's true that it makes it easy to look up, but I can say I've never
used that functionality.  I think very few people actually know it
exists.

> Having said all that, I think stripping the commit object name (or
> tags) is a better design.  Imagine that I see I created a tarball
> earlier and published its hash, but later lost the tarball.  By not
> allowing any commit object name in the archive, it would force me to
> somehow name the tarball in such a way that I can tell which commit
> I used to create it, e.g. "git-e83c516331.tar".  Other people can
> notice the filename and without having seen the bytes in it, they
> can try running "git archive e83c516331" in their repository and see
> the output matches the hash I published earlier.  Having commit or
> tag embedded in the archive would make it harder to do this kind of
> things.

Most people do this anyway (except with a tag name), so I don't think
it's a big deal to have this as the primary mechanism.

> By the way, other potentially interesting points are:
>=20
>  - Do we want to ignore "export-subst" for stability?

I think that would be a good idea.  I'll add it in v2.

>  - "git archive" can be invoked with pathspec to archive only a
>    subset of paths.

True.  I don't think that's a problem as long as we generate paths
correctly.  I'll be sure to add tests for it, though.

> > +Introduction to the Underlying Format
> > +-------------------------------------
> > ...
> > +A global extended header sets metadata for the entire file, and a per-=
file
> > +extended header applies to only the to which it corresponds.  A per-fi=
le
>=20
> "only the to which" -> "only the file to which"

Will fix.

> > +While pax extensions are widely supported by most modern versions of t=
ar
> > +(including versions on Windows and all major open-source OSes), some o=
lder
> > +archivers and non-tar implementations which do not understand them typ=
ically
> > +extract the extended headers as regular files.  Thus, it's helpful to =
have these
> > +entries have reasonable permissions and unique names.
>=20
> Surely, and to make things reproducible, they shouldn't just be
> reasonable and unique.  They should be exactly as we define in the
> specification.

Yes, of course.  This is more to indicate why we've made the decisions
to name them as they are and give them the permissions we did.

> > +Every file serialized in the archive is serialized in lexicographical =
order by
> > +its bytes.  A directory is always serialized before its contents, and a
>=20
> "by its bytes" -> "by the bytes in its filename" or something?
> Surely we do not sort by contents ;-)

Good point.  We should avoid ambiguity.

> > +directory is never serialized with a trailing slash.  If a system uses=
 a Unicode
> > +encoding other than UTF-8, it encodes filenames as UTF-8.
>=20
> This is a bit hard to grok.  Do you mean there may be UTF-16 system
> where the data in our tree objects, whose paths are recorded in UTF-8,
> but "git checkout" of the tree may result in files in the native
> filename on that system, i.e. UTF-16 not UTF-8?  And even on such a
> system, running "git archive" would record paths in the archive in
> UTF-8 (i.e. the same as what was in the tree object)?  Or do you
> mean something stronger, like on a Latin-1 system with Latin-1
> project that used Latin-1 as pathnames even in the tree objects,
> when "git archive" produces an archive, the paths in it shall be
> transcoded from the original Latin-1 pathnames to UTF-8?

This means if, on Windows, someone uses --add-file or
--add-virtual-file, those paths will be encoded in UTF-8, not UTF-16.

> > +Version Number
> > +--------------
> > +
> > +The version number for this version is `ctar-v1`.
> > +
> > +Extended Headers
> > +----------------
> > +
> > +Global Extended Header
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The global extended header (record `g`) shall contain one header:
> > +`CTAR.version`, which contains the version number specified above.
> > +
> > +The contents of the ustar header for the global extended header are as=
 below,
> > +except that the `name` field contains `pax_global_header`.
>=20
> "as below" meaning...?  The same as what is listed in "Per-File
> Extended Header"?  There is no `name` field listed there, though.

I'll make a clearer reference.

> > +Per-File Extended Header
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Each file has a per-file extended header.
> > +
> > +The following per-file extended header fields are included:
> > +
> > +|=3D=3D=3D
> > +| Field Name   | When Present  | Value
> > +
> > +| `atime`      | always        | `0`
> > +| `mtime`      | always        | `0`
> > +| `size`       | always        | size of the data in bytes
> > +| `path`       | always        | full path name of the file
>=20
> These are length-prefixed data, so we do not have to worry about
> overly long pathnames or symlinks?

Correct.  This data can be arbitrarily long as long as all the metadata
can be encoded in a ustar header, so we're limited to at least several
gigabytes or so.  I don't think anybody thinks of that as a practical
limitation on filenames or other metadata.

> "we because" -> "because"

Will fix.

> > +we avoid explicitly declaring them as such and rely on the default arc=
hiver
> > +behavior, which may be more sensible.
>=20
> So, do we or do we not store hdrcharset?  Producing Git does not know
> if the pathnames stored in the tree it is asked to produce archive
> for are not in UTF-8, so it assumes everything is in UTF-8 hence
> does not see the need to add hdrcharset?

pax says that these values are UTF-8 if not specified.  If they're
clearly not UTF-8, we use `hdcharset` and say they're binary.  If they
look like valid UTF-8, we don't use `hdrcharset` and pretend they are in
fact UTF-8, in case somebody just likes causing discord by using
Windows-1252 that looks like UTF-8.

> In other words, we just store the contents of the blob that
> represents the symbolic link there?  I wonder if we do anything
> special if a blob, that is pointed at in an entry in a tree whose
> mode bits are 120000, has NUL in it (should we teach fsck to flag
> it, for example)?

This is the destination of the symlink, yes.  We can simply check for
NUL and abort; I don't think that's an unreasonable behaviour in any
case.

> The order of entries need to be specified when we aim for
> bit-for-bit reproduceability, no?

Yes.  That's specified in the next section, where we say this:

  When encoding the data for an extended header, all entries are sorted in =
order
  by the byte values of their keys as encoded in UTF-8.  Duplicate keys are=
 not
  permitted.

I'll make a reference to that section and describe it more clearly.

> "the header block" -> "the ustar header block" to match the next
> section, probably.

I'll update that.

> These are barebone header fields, not extended headers.  Do we want
> to refer to some canonical sources so that readers understand that
> unlike the extended headres we are talking about fixed-length fields?=20
> The description above talks about "padding", but that of course
> applies to fixed width columns.

Correct.  I'll mention that these are the values in the ustar header for
the extended header.  I'll also put some references in to the
documentation.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bUvcJeh1ag/wKNqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY+LR5gAKCRB8DEliiIei
gfOEAQCPJkRd8U2jrY8shA88sJtzVkjupb2C0r7BzmMV5nohNQEAo21c7RKPGLOa
DwE86oZ723A3KFNop7o+DF7KYqKO9As=
=mA1G
-----END PGP SIGNATURE-----

--bUvcJeh1ag/wKNqY--
