Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5A2FE2F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okUHOySj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTCrWcC7"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469311BE5
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 06:57:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id D3A46320093F;
	Wed,  8 Nov 2023 09:57:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Nov 2023 09:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699455439; x=1699541839; bh=hF
	Vsqy3TRjenRR7QmkOy0nyrkoWGTzR47gl31Tm/OIU=; b=okUHOySjfjRQ/kTA0y
	PE4ov70ijESK+eJgIm27iDD5sSW8QnwjuvXeEKM2G9kfddx28LwHCRcP8cHaz8fL
	Tq8Z62/jowkbuh7aHTOYywwO+jHfzXr5PBjkaIrbsc2Ic3Q995t1Bua0o3T1Mdq9
	osPssheVvaYZEpmUIvvL4/mqS/hgAFMGBDr4BAA9ebaRmRFzf1j+ZFKtGnbLhepm
	3jSW3SlhqkVjE/1DTnqRFre8Pl6V0w1/cTtyWCXt752YqaahrmQHfK5k4UaUTVuz
	YPoKjKm9nw7Cf99S2gm8GjXm/J0WQ+Nyzf1voZVy3GvZe6vuVylpR+yCALXse/G9
	oLCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699455439; x=1699541839; bh=hFVsqy3TRjenR
	R7QmkOy0nyrkoWGTzR47gl31Tm/OIU=; b=RTCrWcC7zIWZ2KWvw7X+4TKD5Ldgt
	NVbA1DZnFs8GqcpfNbWN0YWm/xTRjj6YWHqnYcBjjVF5F9mEAJOr2ZsLqgxOTAhx
	q8ZjefF2AWRcxsDABd00dhfI9LLtZ3z1u2hltDJGPPbPNp01TX+J4NhMFSWfKnt1
	94q7RgyUYqDCKejX8Y6ttc7Y5R6PRttzNo0gcyabHQ2b/iKn8QSCt8NMQzf9PR+Y
	znSH4OypHV6NRnaSnwmKzGAuN3XmnBtxypmepKdYdg8omrOzASaJ9HSuMWCE5FNl
	xzo5DL8wjqBxCiwSPiyjiJHa4Y6o+dJL896+p23xtccMX5Oi/FMS8aUdA==
X-ME-Sender: <xms:z6FLZY24Qsl_X18P3aEEdBxQQt_iKhxc3IIBIeXrwAaavTIcPCxvWA>
    <xme:z6FLZTFeKVNFzy2xa13m0xbmWa61m-nWg83n0PWYEsCs4zeKJI4gUt271VSTUFk5j
    nk-NmHTR8Ni5uP3Yg>
X-ME-Received: <xmr:z6FLZQ55yd2K-fHoH-C89NEZMN1my3qaYcN7UckUFL60ZkTI1Lb_R3TCWVmB-m6WDvksDoUaZg5iKdYTTlpPcxplMWb0CMerZhMuYafkXLCd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvheetgefgveeuveehtdelleeviefgfe
    eiudeigfdvffefgedvieetgfetveevueenucffohhmrghinhephhhtthhpugdrshhhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:z6FLZR2LVnOi_Qv1Tk7tvkPg_c1jFVCPZsk6n94hHpboRalXLyviCw>
    <xmx:z6FLZbEN1X2aKYwN3eCUEixfYbFtfvawhpZKpn9u__J2TFcPWG3YDg>
    <xmx:z6FLZa92FpyoW91wkm4r0MhHXdvA4pnQvU0l26Gtzo60Y77Ws3jU-Q>
    <xmx:z6FLZeNpexKk4BHA2VIKmSDZllBmRI1iSiLxVbXe3Pt5pgKH2IAtcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 09:57:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a5c04d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 14:56:51 +0000 (UTC)
Date: Wed, 8 Nov 2023 15:57:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] t: improve compatibility with NixOS
Message-ID: <cover.1699455383.git.ps@pks.im>
References: <cover.1699428122.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xyLjymIgs6MDFpw6"
Content-Disposition: inline
In-Reply-To: <cover.1699428122.git.ps@pks.im>


--xyLjymIgs6MDFpw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series to improve compatibility
of our tests with NixOS.

There's only a single change compared to v1. As suggested by Junio, we
now use the executable discovered via PATH and the modules detected via
`HTTPD_ROOT` as fallback values if none of our hardcoded paths were
detected. This should further ensure that the refactoring doesn't cause
any issues on platforms that follow the FHS more closely than NixOS
does. It also has the benefit that the change is now a lot more straight
forward.

Patrick

Patrick Steinhardt (3):
  t/lib-httpd: dynamically detect httpd and modules path
  t/lib-httpd: stop using legacy crypt(3) for authentication
  t9164: fix inability to find basename(1) in hooks

 t/lib-httpd.sh                        | 10 ++++++++--
 t/lib-httpd/passwd                    |  2 +-
 t/lib-httpd/proxy-passwd              |  2 +-
 t/t9164-git-svn-dcommit-concurrent.sh | 12 +++++++++---
 4 files changed, 19 insertions(+), 7 deletions(-)

Range-diff against v1:
1:  ac059db8fed ! 1:  cee8fbebf84 t/lib-httpd: dynamically detect httpd and=
 modules path
    @@ Commit message
             - The module directory can (in many cases) be derived via the
               `HTTPD_ROOT` compile-time variable.
    =20
    -    Refactor the code to do so. If runtime detection of the paths fail=
s we
    -    continue to fall back to the hardcoded list of paths.
    +    Amend the code to do so. The new runtime-detected paths will only =
be
    +    used in case none of the hardcoded paths are usable.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ t/lib-httpd.sh: fi
      HTTPD_PARA=3D""
     =20
     -for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
    --do
    --	if test -x "$DEFAULT_HTTPD_PATH"
    --	then
    --		break
    --	fi
    --done
    --
    --for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
    --				 '/usr/lib/apache2/modules' \
    --				 '/usr/lib64/httpd/modules' \
    --				 '/usr/lib/httpd/modules' \
    --				 '/usr/libexec/httpd'
    --do
    --	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
    -+DEFAULT_HTTPD_PATH=3D"$(command -v httpd)"
    -+if test -z "$DEFAULT_HTTPD_PATH" -o ! -x "$DEFAULT_HTTPD_PATH"
    -+then
    -+	for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2'
    -+	do
    -+		if test -x "$DEFAULT_HTTPD_PATH"
    -+		then
    -+			break
    -+		fi
    -+	done
    -+fi
    -+
    -+if test -x "$DEFAULT_HTTPD_PATH"
    -+then
    -+	HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D HTTPD_ROOT=
=3D"\(.*\)"$/\1/p')"
    -+	if test -n "$HTTPD_ROOT" -a -d "$HTTPD_ROOT/modules"
    ++for DEFAULT_HTTPD_PATH in '/usr/sbin/httpd' '/usr/sbin/apache2' "$(co=
mmand -v httpd)"
    + do
    + 	if test -x "$DEFAULT_HTTPD_PATH"
      	then
    --		break
    -+		DEFAULT_HTTPD_MODULE_PATH=3D"$HTTPD_ROOT/modules"
    +@@ t/lib-httpd.sh: do
      	fi
    --done
    -+	unset HTTPD_ROOT
    -+fi
    -+
    -+if test -z "$DEFAULT_HTTPD_MODULE_PATH" -o ! -d "$DEFAULT_HTTPD_MODUL=
E_PATH"
    + done
    +=20
    ++if test -x "$DEFAULT_HTTPD_PATH"
     +then
    -+	for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
    -+					 '/usr/lib/apache2/modules' \
    -+					 '/usr/lib64/httpd/modules' \
    -+					 '/usr/lib/httpd/modules' \
    -+					 '/usr/libexec/httpd'
    -+	do
    -+		if test -d "$DEFAULT_HTTPD_MODULE_PATH"
    -+		then
    -+			break
    -+		fi
    -+	done
    ++	DETECTED_HTTPD_ROOT=3D"$("$DEFAULT_HTTPD_PATH" -V | sed -n 's/^ -D H=
TTPD_ROOT=3D"\(.*\)"$/\1/p')"
     +fi
    -=20
    - case $(uname) in
    - 	Darwin)
    ++
    + for DEFAULT_HTTPD_MODULE_PATH in '/usr/libexec/apache2' \
    + 				 '/usr/lib/apache2/modules' \
    + 				 '/usr/lib64/httpd/modules' \
    + 				 '/usr/lib/httpd/modules' \
    +-				 '/usr/libexec/httpd'
    ++				 '/usr/libexec/httpd' \
    ++				 "${DETECTED_HTTPD_ROOT:+${DETECTED_HTTPD_ROOT}/modules}"
    + do
    + 	if test -d "$DEFAULT_HTTPD_MODULE_PATH"
    + 	then
2:  23835763002 =3D 2:  f4c6c754f1e t/lib-httpd: stop using legacy crypt(3)=
 for authentication
3:  b50e625f967 =3D 3:  361f1bd9c88 t9164: fix inability to find basename(1=
) in hooks

base-commit: 98009afd24e2304bf923a64750340423473809ff
--=20
2.42.0


--xyLjymIgs6MDFpw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLocoACgkQVbJhu7ck
PpTcixAAopKniTxkQF6o1chuw3COK34oYo7Ac9cThMQIXoYqNMe6KpQhxsUKQZUf
2sR1fmmXpxM0htHO+01rnzOpJuQl2dvZ77wbyyvqJ9wTkBKCkqYNUiE3n4tDfJhX
LbBxgJn5gP0LzNaige6DLTCSwQ1YZ17EUJOe4nMwIYUVCYEgMKOtFAwget8PlWdd
Yn8Rgcb7ecVRkpZVMatPgbyv6wvRIQJTPzM96lF09HY8LzjekZnxhZ6deM4fWI0/
h67yE57ZJyiUSut8xUNSjZS1Slyh1pze2S56e7JvMo3riRxZD+CHk4KWoSCo+bqV
LiqQJwj0BwzNXHGI2Sb2suDjogfS+AWuUYEV/uVqySx6XBYEzbbr640t/CAdKv/k
2Xh0V40JtdBoM9nk9zcA/XoExi4phhuhc80sAwNJeFtWVfYy7eSoTKjJczndtlhu
18rWcxciYxYexJ0qdnRl2ZcbX+P7znss8PadkTScLqt8j0DCFWEKrgzLiUjm/XGx
aVJXWQ+HV0hVzZWBv2RGUlCQTwuxT6rrhL2ttO8hMdsAlV9pOphXtTeSFJYPKY2H
WK3ZuVxOWHQFf28+B7I73GVG/+0eTQ57voxmLkArtLsTJzAhrOekmIS9zQT9Fm80
9KYfYvJ0MTJ+jYrTeMzyuP7nSEqUzvjWA8Cja/44HXUX6gvAOmA=
=Mx9d
-----END PGP SIGNATURE-----

--xyLjymIgs6MDFpw6--
