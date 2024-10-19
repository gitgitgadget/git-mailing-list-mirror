Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239C1925AA
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298342; cv=none; b=ReQu+vIzSiCHZSGupuZTdKgGSvEx7FKybxhD3h/x2TvhoATgSOY09KrADkvIW/EjOU7CDjDVuUXaYnTxDG1pcl7PvLwJ+/biwbzo4zohf5gKcB7bTaoIu4lGBBMGMjVGJFtuUFjAtd7TghmXQHgo2V1op/kKp7fxAeWwjd8VS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298342; c=relaxed/simple;
	bh=BIoJLWhLEU9MNjYAcluT7r9EwCP8V2Xdo3Zifb5++pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAP58PvkluC/xebEVoPxUnIarZ8w/obrZbvxSdjf7vEpJZLvkk2123KmGytQid5ABbCF0TVIB0SmWfqRJqKVRRx3d7PkFL5hDXbp5oOtTg88FnKNGTaFsWIT12v/c3UoZ2wh5EsxKNqy6Pw/i01Dvvgo3BE7GR9k4pXegJLBl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=AqPx29xi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AqPx29xi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729298338;
	bh=BIoJLWhLEU9MNjYAcluT7r9EwCP8V2Xdo3Zifb5++pI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=AqPx29xiEdqN4APg41H7EUcX4CX8ur8ShoUA8A/8bydErHt+JDwM8bXWzrIgG5NMz
	 aBqWMH92v8A733Ta/QEvSLW/1YmFu82Eea6WFm0i19t+GSRENsRfDD6iS8fFo0WvOp
	 KulDg9WdiRsYUo2PGKjnKmpF4njLH2i6feX9PATL5Gq6KiiHREiCR/jb801bcQ6omG
	 KZvvJO8sOae2ln63IORemxeu+rZ4BZSBJ3jwRGvHZPTqnlj6UfD2UHw3qR4W+OA3u7
	 uNRuu0r01I9vI1vJXCMkI4q5Tm926rxv7kTiFvCxie6uxRCkjb0dkBiXvrbKpFhPgT
	 DEZjBQZx/+NJMwkBjAn8o1bOFZWg7plnTE/FPvFB1X+4U8XcpaIICSpg+qn4Ysj6J6
	 lhEbuIimibP7ef9kt//4/IYWQ+Ize3k7+QO3QEwG5vHW4Kto1sYf6FSuhTjtaLGcHx
	 H2PB+EljDhRPRl8c8+gf8Vgrmg5YfvE3H+ge0ay3+Q89ucLPSlB
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 095D1200B3;
	Sat, 19 Oct 2024 00:38:58 +0000 (UTC)
Date: Sat, 19 Oct 2024 00:38:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
Message-ID: <ZxL_oAXN5KQ4FVMc@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ODTylrDSde4H6mBA"
Content-Disposition: inline
In-Reply-To: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ODTylrDSde4H6mBA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-19 at 00:14:13, Samuel Adekunle Abraham via GitGitGadget wrote:
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>=20
> Notes can be added to a commit using the -m (message),
> -C (copy a note from a blob object) or
> -F (read the note from a file) options.
> When these options are used, Git does not open an editor,
> it simply takes the content provided via these options and
> attaches it to the commit as a note.
>=20
> Improve flexibility to fine-tune the note before finalizing it
> by allowing the messages to be prefilled in the editor and editted
> after the messages have been provided through -[mF].

I don't use the notes feature, but I definitely see how this is valuable
there much as it is for `git commit`.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 8c26e455269..02cdfdf1c9d 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const cha=
r *prefix)
>  		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
>  			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
>  			parse_reedit_arg),
> +		OPT_BOOL('e', "edit", &d.use_editor,
> +			N_("edit note message in editor")),
>  		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
>  			N_("reuse specified note object"), PARSE_OPT_NONEG,
>  			parse_reuse_arg),
> @@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv, c=
onst char *prefix)
>  		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
>  			N_("reuse specified note object"), PARSE_OPT_NONEG,
>  			parse_reuse_arg),
> +		OPT_BOOL('e', "edit", &d.use_editor,
> +			N_("edit note message in editor")),
>  		OPT_BOOL(0, "allow-empty", &allow_empty,
>  			N_("allow storing empty note")),
>  		OPT_CALLBACK_F(0, "separator", &separator,
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 99137fb2357..7f45a324faa 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1567,4 +1567,33 @@ test_expect_success 'empty notes do not invoke the=
 editor' '
>  	git notes remove HEAD
>  '
> =20
> +test_expect_success '"git notes add" with -m/-F invokes the editor with =
-e' '
> +	test_commit 19th &&
> +	GIT_EDITOR=3D"true" git notes add -m "note message" -e &&
> +	git notes remove HEAD &&
> +	echo "message from file" >file_1 &&
> +	GIT_EDITOR=3D"true" git notes add -F file_1 -e &&
> +	git notes remove HEAD
> +'

Maybe I don't understand what this is supposed to be testing (and if so,
please correct me), but how are we verifying that the editor is being
invoked?  If we're invoking `true`, then that doesn't change the message
in any way, so if we suddenly stopped invoking the editor, I don't think
this would fail.

Maybe we could use something else as `GIT_EDITOR` instead.  For example,
if we did `GIT_EDITOR=3D"perl -pi -e s/file/editor/" git notes add -F file_=
1 -e`
(with an appropriate PERL prerequisite), then we could test that the
message after the fact was "message from editor", which would help us
verify that both the `-F` and `-e` options were being honoured.
(Similar things can be said about the tests you added below this as
well.)

I suggest Perl here because `sed -i` is nonstandard and not portable,
but you could also set up a fake editor script as in t7004, which would
avoid the need for the Perl dependency by using `sed` with a temporary
file.  That might be more palatable to the project at large, but I'd be
fine with either approach.

Do you think there are any cases where testing the `--no-edit`
functionality might be helpful?  For example, is `git notes edit` ever
useful to invoke with such an option, like one might do with `git commit
amend`?  (This isn't rhetorical, since the notes code is one of the areas
of Git I'm least familiar with, so I ask both because I'm curious and if
you think it's a useful thing to do, then tests might be a good idea.)
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--ODTylrDSde4H6mBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxL/oAAKCRB8DEliiIei
gd5WAP0TVw2/Jjw9Xi2Wf0q6MHky+yNO4rs6LND7yleaKe0ufwD/cxP/uPvEdmS1
GCMRPni8LOZzHfwgtH0e3IBXFw/tcAA=
=IALn
-----END PGP SIGNATURE-----

--ODTylrDSde4H6mBA--
