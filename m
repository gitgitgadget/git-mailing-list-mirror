Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3EB79FA
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VYlA2rkV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0cwOsuJ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4B93C4
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 00:17:13 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 0DEA73200AA4;
	Fri, 10 Nov 2023 03:17:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Nov 2023 03:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699604232; x=1699690632; bh=Es
	CnNYWyENUfXoNxb62788jHYjZSmBUMl1evJiTXje8=; b=VYlA2rkVp+r09TfWWW
	Nczbx+Zxrove8jdOW6tmJRYk5t7GDwetOrK0X8a9oZ5Nm4ldNeP0Yw2V/uAh7a7/
	J16A2P+8X36dSdfg2CldjGoSGgcQ7LV4fTRHjJCayv2csgfu9wGaXtEJFqH/2byZ
	0rudKe5kcWY/7mAvJ61FO739BPlGDRzP7QYHyfb7fF9ll+YiZzdaIrKWHJEoOPbV
	Nj0LSzvy+c7VkfnJoxs/vN73nYuhCw2kW1SftGCunsSnBWn96nXhP8FFd+Fq/Ike
	Nxf5RBOS710Mkcz0JlL/h2Yjfb3nlIa6ZuOE0dhoDXxfcBbCAonNJ+z2SCBH0ZwX
	8vOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699604232; x=1699690632; bh=EsCnNYWyENUfX
	oNxb62788jHYjZSmBUMl1evJiTXje8=; b=P0cwOsuJ6UduZNQCJEHfxZQphGmiq
	xpFt3TjaJ+UVj/j8HRmmYTen2z+IAe79jPz2lsBqH9L9X0eDA9aoRwQPv4q99QI6
	tO3MF9OrqkynJnphTiGBn821fvqJK5fNyGln8q+Gov8Ew2vPVf3S7zbgYGjsJFV0
	GPC7QwPQscHxhySg37bTeebKWvtVVE4i/Do4hx4+ErP6eAyE8YXxF/hplAHNmyUo
	jjgx5zI7F7qZQxUnCHryZClbNjGnME3UQtobW1UuaAEqPfU1ha5t8Q1R0s6hetUK
	zDtVSe/gAfL5T/f5LFfsv/4P+Ae5O5/s8Rl5k8aG25bLbCGg43LJBXy9g==
X-ME-Sender: <xms:COdNZZaARKEJtfIEfDGU4udJxdGqvRpYIvbSopT3IENVqIJuYV8NkQ>
    <xme:COdNZQag7xubVW05VbnnfhgRVrdMl-jwrq5TTbfc0uFYYv5_JFMzVuGquOJelk7rd
    9l-qKey5fgFFHChAQ>
X-ME-Received: <xmr:COdNZb_etN_hRzMGo4jlukbPY3oGikyCUStwCUsRbyv2pK6PZWA9s2Hak3mzGtvgtet8Np3iwIL4gnvdkjPTNAvpW8A6rv2wLwdbdRYrL2TaEi-2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:COdNZXrdGf_2grBRnMXeVZ2Yf1iPPx8U16Ke6N65YjOxyGqKCoNTAw>
    <xmx:COdNZUqtug9xcurAFt5q1XX4jFvZPsJ5IXlrK7qQPBFGt0K1IqUx4A>
    <xmx:COdNZdTgStd3xVSy4SBgaEEsTb_1sicuuzI-9FdSmRYtQ3XNM33aQQ>
    <xmx:COdNZRBe3da8rBjurOtGYNLDmGSeEOwcSniFTRF1pEp9okI34RNG2w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 03:17:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb221fae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 08:16:41 +0000 (UTC)
Date: Fri, 10 Nov 2023 09:17:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/3] t9164: fix inability to find basename(1) in
 Subversion hooks
Message-ID: <6a7773aadba4fec5daa1e215a50ab122515ea456.1699596457.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
 <cover.1699596457.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8QQL9t75Mv1dCMhy"
Content-Disposition: inline
In-Reply-To: <cover.1699596457.git.ps@pks.im>


--8QQL9t75Mv1dCMhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hooks executed by Subversion are spawned with an empty environment. By
default, not even variables like PATH will be propagated to them. In
order to ensure that we're still able to find required executables, we
thus write the current PATH variable into the hook script itself and
then re-export it in t9164.

This happens too late in the script though, as we already tried to
execute the basename(1) utility before exporting the PATH variable. This
tends to work on most platforms as the fallback value of PATH for Bash
(see `getconf PATH`) is likely to contain this binary. But on more
exotic platforms like NixOS this is not the case, and thus the test
fails.

While we could work around this issue by simply setting PATH earlier, it
feels fragile to inject a user-controlled value into the script and have
the shell interpret it. Instead, we can refactor the hook setup to write
a `hooks-env` file that configures PATH for us. Like this, Subversion
will know to set up the environment as expected for all hooks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9164-git-svn-dcommit-concurrent.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommi=
t-concurrent.sh
index c8e6c0733f4..d1dec89c3b7 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -46,6 +46,14 @@ setup_hook()
 			"passed to setup_hook" >&2 ; return 1; }
 	echo "cnt=3D$skip_revs" > "$hook_type-counter"
 	rm -f "$rawsvnrepo/hooks/"*-commit # drop previous hooks
+
+	# Subversion hooks run with an empty environment by default. We thus
+	# need to propagate PATH so that we can find executables.
+	cat >"$rawsvnrepo/conf/hooks-env" <<-EOF
+	[default]
+	PATH =3D ${PATH}
+	EOF
+
 	hook=3D"$rawsvnrepo/hooks/$hook_type"
 	cat > "$hook" <<- 'EOF1'
 		#!/bin/sh
@@ -63,7 +71,6 @@ EOF1
 	if [ "$hook_type" =3D "pre-commit" ]; then
 		echo "echo 'commit disallowed' >&2; exit 1" >>"$hook"
 	else
-		echo "PATH=3D\"$PATH\"; export PATH" >>"$hook"
 		echo "svnconf=3D\"$svnconf\"" >>"$hook"
 		cat >>"$hook" <<- 'EOF2'
 			cd work-auto-commits.svn
--=20
2.42.0


--8QQL9t75Mv1dCMhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVN5wQACgkQVbJhu7ck
PpRTyg//YBAHRizzVscHCeZ9kUw4cVyFi81IZT+hhA4FXA2szqK5nEQqR7w6mk4h
ADhuvyC2QpLEnFzo3Dhj32s2KG4+gl/vsELpF+tbP2PDb4tJM7Z5N5AdtOd+90mU
55ripNbiLQJ+TM+Nmtg+5vioZIn5nXPapAAGRSeJv7bdHSclAq7ioslkvINpN3gp
+L8aPE4BXUkyjdsljvr2KFe/z07bCzpakVsSCShZoD4YLWngs8JGnlpMeyeKx+fl
fIeEPHkbKAErR4Bp1tmsxhMgTyZqAoHu6yI7qhbQ11hDnObR3iRR+ssxErpzLDOz
n7RSZ9BC0SA/U9Xl2Ie84UfOBOTRVn+OlSKN0yNy8P0ywjOVFECB4HsX8RC/vIEe
RtCplslt3ibIcEDbympbPvtsdvUTHTOPXQ01ZNtqmzdI/s5RO7NjkJLTTR4+9VHd
PQVtfojnQWdVXbu8CT6xZ16Ts/ycjjF9Z4frJwD0JHvMzJhpZow0LXVZ286stq+n
2ybCkdEMKA4SWH50zvjGzZUmCm4ECZh43EQoC8lwW34dC8eUeOGCBGbIMdHW5JPS
6j+JiKo1dUn8+QUlI5CQHrHHnwIpeRVyJpD6pT+i5p8VH4+aW2URjvddNC/w2Ll2
pppiYgCzrCc+GFuVbwatc8xsiDU0KpNeRCyfLoCKwHazoqsuhnY=
=qG2i
-----END PGP SIGNATURE-----

--8QQL9t75Mv1dCMhy--
