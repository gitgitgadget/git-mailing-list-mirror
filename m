Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB11C3C1F
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575561; cv=none; b=MNjkEx6HR+PdmfKKPMBBxcv+8kiswRU1PNtqIovPp2OSxP6GJRjaWcvEKC3ueeys5bN0nwOD3ZoX4iWngeovWG2CsJHEweccWlm7Ci0Jn9s0WiFnodOPCrrRYfrTLLK4CkeDefZGEG3G3ye100MJQJOK4WW+ybvB8HcaxBwXeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575561; c=relaxed/simple;
	bh=ssXWSWG19JLYwubCF0QmPrXzDmtfBXiR8zUA61Itkr4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oRVm7Dhs8Kr4r1VBxBgw+ZL68OfH13WMuOZ4fP07jNASWRJI/Bm378sB2MJW62XaISkljPYW6gURK48LXhnwMd5Nz7h3rubDMD856MZYGCbCbZQdp7uWbXoW5VquWzibVVGb/pskXE/dzbvEkZc5B8wBhyXNZ+82DJajYLEVKcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP+HCNBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP+HCNBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B28C4CEF7
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770575560;
	bh=ssXWSWG19JLYwubCF0QmPrXzDmtfBXiR8zUA61Itkr4=;
	h=Date:From:To:Subject:From;
	b=MP+HCNBkH1pp61GYkiiYKk6zsbSaAFKbEiuqTx/F/WQvKceyndellcwtZSBg/BgfL
	 1vpcsaThmKuadst1Y7kiL5x7fUd7DxkTkDhpHk4XijnJwqkItFkn0aOlEitHlDMZEJ
	 fIddVtNnch+aYV/a4VqlIH1lplQkC3OwMINSUqeU+3JQAItabkNWsfoWpm0HPlcFgL
	 xquclYJEBqs8hbqu8lSsOGjBProJvykhOVHPNg3yKoibSBKyurnMH3s0sivBZuh9ui
	 X4L5yyl0xq2Wmf4moTJUaLO7n2klj/5tOnqdR26JURvbsiPEMYKHeiTK0PGJaskRLU
	 OsNDzC6XtTHnA==
Date: Sun, 8 Feb 2026 19:32:37 +0100
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: color.diff.<slot> for commit headers (Author, Date, ...)
Message-ID: <aYjVlRqvafWeePvi@devuan>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23zha25r3ywhlr4m"
Content-Disposition: inline


--23zha25r3ywhlr4m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: git@vger.kernel.org
Subject: color.diff.<slot> for commit headers (Author, Date, ...)
Message-ID: <aYjVlRqvafWeePvi@devuan>
MIME-Version: 1.0

Hi!

According to git-config(1):

     color.diff.<slot>
         Use customized color for diff colorization.  <slot> specifies
         which part of the patch to use the specified color, and is one
         of context (context text - plain is a historical synonym),
         meta (metainformation), frag (hunk header), func (function in
         hunk header), old (removed lines), new (added lines), commit
         (commit headers), whitespace (highlighting whitespace errors),
         oldMoved (deleted lines), newMoved (added lines),
         oldMovedDimmed, oldMovedAlternative,
         oldMovedAlternativeDimmed, newMovedDimmed, newMovedAlternative
         newMovedAlternativeDimmed (See the <mode> setting of
         --color-moved in git=E2=80=90diff(1) for details), contextDimmed,
         oldDimmed, newDimmed, contextBold, oldBold, and newBold (see
         git=E2=80=90range=E2=80=90diff(1) for details).

color.diff.commit (commit headers) would seem to be the slot for
coloring Author, Date, etc.  However, that colors the commit hash
exclusively.

The documentation should be updated to reflect reality.  Maybe

	s/headers/hash/

Also, I'm interested in coloring the actual header fields; that is
Author, Date, etc.  I think a good name for that slot could be
'header'.  Would you mind adding that?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--23zha25r3ywhlr4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmI1r8ACgkQ64mZXMKQ
wqk6wA/9FJf79D+4ixpjLGidB9m630OpOMl/ljCh2TO1Z+c8gM4xZcVKIaFVr/dc
Qw+LrxZsYLyRVMt7jUxz+T6XMnh2IEWTJMFp+5q9D6/HuDIXWpK7jBzX55ZSZE5m
iwxKbk2PPi+Zq1cRv2ZG3ZUYkB7Jwvz+OQUUwG2dBwBNVMfoE2ZlDKp3xExIUID8
nJUqHwkk0639YIZzRk7iYhjiJbhsNYS6hjgO9PnBkLhs0L8KoKnfUzsOM1FV/TnA
8U3Dh/M+1k3lqJASjnrbXkeno/l5tQiRPRItQJJfgPBWl7HR6svsfATonTOu52Gf
DPZBxD7urGlpowgf142IFE01GDrzipZii0zdK2pbiOTNO0fyyP/5aVFmxohlvlr0
eSycAWab2oo2uPRUkuSflyyPrtQueA25viRLZtUrf1IpwsOA4TfTWhdn8TPYEgNM
oyRDUUrFLP7CkyCuSPzbtwErVro9/Rnx0Kp1uYvpNKMZl8MSfPjI1EpZe/fqqL6e
L6CsuP/t5zSQ9/Ezb9M9mItniUBx9bD6Hi9KwAWV9qDChe1/k8JhGiX/zFjlhm7I
6sj4FIElw+zCCamuWyVfAunhppuCfGfLHfd7jyMuQOnwbdykAGkpulaptMRniuIg
YtfmGB7PDRkI238Nt0E+8msHgWeJrlnh0T5J5xZRQYLkwJ332wc=
=cZzY
-----END PGP SIGNATURE-----

--23zha25r3ywhlr4m--
