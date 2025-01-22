Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258261465AE
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512683; cv=none; b=Dx3GO48aYefbGPj3ptfJ3gDdVKEuHlBq25uvDajMXsWbjcHpOqBYmzZv/X/IMkQ+ki+ZBVS8xT6fW39/v+xTs8XtLpmNI8rV4V0N0F1vKQbhq/G3vmv4H29pkY80pv25Fle0Nl8eTgbv2IOIiVEyh4mOZbOCdRro05fgmM7tpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512683; c=relaxed/simple;
	bh=slW3ABBjXf+m2bMy7+MJmxD2o+dAht267MhIW1sEK3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQfbW4Y3K/Moe5RaFxWU5SHgAnpv2V41VHHjdAaGZhWZOvhDjNSRc0SdCaP8xfYU6s2+i+SmQpEBefbcLRwVUv5VMTIE7JJJ0Ny+kd+BWi1SodF9SDLve+J9TckYom9eirHUxOUrSFdicr+dGnyqhmzG00GKZ7BPklpNXFQbIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=v6p9hSQ/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="v6p9hSQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737512679;
	bh=slW3ABBjXf+m2bMy7+MJmxD2o+dAht267MhIW1sEK3k=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=v6p9hSQ/oGaLyvnG2LKDNRWI3x32KkZGSNS3j7hUIjCbZm8HJvhcv4fScHNCVb6XK
	 +OR/5NeQr+YnZPoU50MY0eP491o2BFK0gSiTf2HwiVwsR6NTA3ChOAgUyXcXKBYRaJ
	 gru6bX1rSe2qKJ0x2x0Fc6JvdAnxUhuVCtaTBdHCuHTeuhewYbJhGUtoHvUQ/GLxl1
	 jtqXeuJkxhu3XpN+cn0KTY7YHLl/QEYKGxBmdkL/YDiqIbWjdwbNadEKnoWZ3LmKN7
	 mpCN9uvCV2l6f3oEdtMuuo0VKoi2LH5ubo5EP5ajiC2qGBZ4ppFkV4E6xnimNUiRHs
	 61zbzRURUblflZrcn/bYTWDh/ffMQlpVzGJXQyQpNsqup5mzOlXghnFFls8BB3qSmP
	 pttB8vonbHXdK69wTN0RLbVaRePFQq6STNlLar4ecBS3jx4muJPd2gQONQKzZwaLNP
	 n0q29URqu0Z9bY/tvulFQjS4G3QAI9SSFPGTrVmEdylYzb39HMV
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C374920033;
	Wed, 22 Jan 2025 02:24:39 +0000 (UTC)
Date: Wed, 22 Jan 2025 02:24:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Emily Shaffer <nasamuffin@google.com>,
	Christian Fredrik Johnsen <cfj@johnsen.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature Request] Allow batch removal of remotes with 'git
 remote remove'
Message-ID: <Z5BW5ofJVbM1obb5@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Christian Fredrik Johnsen <cfj@johnsen.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DB9PR05MB110863344D3776D13B436F563C1E72@DB9PR05MB11086.eurprd05.prod.outlook.com>
 <CAJoAoZnecm5y8243R9JsGjRDuv-Mb=UAwa+Hbj5CKDKNPBLB4g@mail.gmail.com>
 <CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/M1a1KQBWsHHHBSE"
Content-Disposition: inline
In-Reply-To: <CALnO6CAEaOUNwMpOTF8wKVd7LAv+UiU5W62ZCBc0U-K_JhHU-g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/M1a1KQBWsHHHBSE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-21 at 21:32:04, D. Ben Knoble wrote:
> On Tue, Jan 21, 2025 at 4:16=E2=80=AFPM Emily Shaffer <nasamuffin@google.=
com> wrote:
> >
> > Hi Christian, is there a reason why opening up the config (`vim
> > .git/config` or `git config edit --local`) and batch-deleting remotes
> > from there is undesirable? If this is a solution you believe only
> > power users need, then I'd posit a power user can both list all
> > remotes *and* remove the offending ones in a single editor pass,
> > rather than having to run multiple `git remote` commands, anyway.
>=20
> I'd posit a power user can also do something a bit like (Zsh with GNU
> or FreeBSD xargs) `print -N my remotes to delete | xargs -0n1 git
> remote remove`, or (portably) `for remote in my remotes to delete; do
> git remote remove "$remote"; done`.

I agree that is possible, but it may not perform well.  I used to work
at a company where, for many years, I merged other developers' code by
hand and pushed it, which necessitated having everyone's remote. In the
main project, there were many people's feature and development branches
in their remotes, so I had well over 80,000 refs in my repository.

Because `git remote remove` will remove remote-tracking branches and
their reflogs, we typically will want to do that all at once in a single
ref transaction, and hence in one command.  Not doing so performs very
poorly (as does, notably `git remote rename`[0]) when all of the refs are
packed.  If you have a large number of remotes to delete and a large
number of total refs, this will perform really badly indeed, since the
operation of rewriting the packed-refs file becomes quadratic.

The removal of the remote-tracking branches is also the reason that
editing the config isn't sufficient, either.

So I think this feature would be useful, although I agree that for many
smaller repos, the shell script approach would be acceptable in the
interim.

[0] Sometime back I reported that `git remote rename` on a fresh clone
with 45,000 refs took about 45 minutes.  The reason I didn't choose the
remote name on the original clone (with `-o`) is because it was in a
GitHub Codespace, which had cloned it for me already.  Fortunately, this
is now down to about 55 to 78 seconds with reftable, which is a major
improvement, and I'm sure we could do better still.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--/M1a1KQBWsHHHBSE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5BW5gAKCRB8DEliiIei
gccWAQDXtrGsgyKJwpE3VYcR3SceWd786zh6Ozk5eRQL883EWAEAzbwXQhQahkiG
IQr8gm98WzsyhDG1u5sEH4Jmnmyt+Q8=
=pZGu
-----END PGP SIGNATURE-----

--/M1a1KQBWsHHHBSE--
