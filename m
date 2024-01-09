Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5C38DD6
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hoNm4ox6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKDBvHp5"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D82BB5C0400
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 07:17:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Jan 2024 07:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704802643; x=1704889043; bh=m5R3HoFL0d
	k9vJhY1DFj0NRmlI2fN6ZQtMbQMNiUDYk=; b=hoNm4ox6cvpXzFVI5ossPNWNL6
	JEvlHxYkJ8q3vo49vIggP/eRQMmmvqcZ3/gaeBRyYGe0wlJXgzkYD+pwfVbTNNOE
	W2w/8MPj/Mg32mm+LCOD13vWEAvGq5rE169LU7cGwfLEnZTZvcwaqdM9d4Apx7+M
	c3m98ZwABVj3MBMT6p/Tm1kn4YRaO4qQQIPaK8UQI/vRRwG2GPrF5xIXP9k8gVm7
	uUYMS8I5sqQFPhBpAoQ2CyhT/ANsrtZ+HN9jIjWxNYsRGd8EvBr326C7trKA3pMo
	X2z6ZxoSBQD1llBAq2qGvHK3A1i6w0mYvyc+r8gwhhc43hBKGP50JGHwTwnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704802643; x=1704889043; bh=m5R3HoFL0dk9vJhY1DFj0NRmlI2f
	N6ZQtMbQMNiUDYk=; b=AKDBvHp5Uv7dc2s/+03CMImFfVd3ZmeTtRUGz6QveOU3
	MsPmcVmjLUfLn5uqq0HCMwdHo3lIumDtKnR7VLQ7bU/j28578JCRpP364COCrzGE
	cp3qvtWqqWANoVONRZ6cSVAnKUVoRtvrnVi2WN8lG2SCb2V29zvBCO/Pw26ix47y
	dpC5WZ54I1gpc46HwB1PJfK6529nqA53ulj+mgnuXNREBX9Vz52QQBwjtTttuMRt
	8x7YHJ5fKBuUo7bVkjMceqxEqa2vFxrB8P/HtJNr7ZdjgYELBuOZCUAC86Js6ybM
	N5uwKzRA50c4xo0kdCkAZ49KbPOPfdpqzV+O6N4Hog==
X-ME-Sender: <xms:UzmdZbWMloectoxzl5mu8AtcP6LEiNNJ_pjpMBealG0ovBQMAsv6bQ>
    <xme:UzmdZTmjVvIHX-EqQaj47igZ0RBN04UwIljFw2ZhlsC3v2ccWWNlWl3wFxxnUHq9s
    2aBT_C9x1EVAANLOw>
X-ME-Received: <xmr:UzmdZXYNdeOPMhHNOTJLuPmopdqTGUckwOaOE-F6b-WNAR7PV_8XwbzVX6JlPmsY5AXhP_FkiMfd8CJVVx-p7aRQRJiuhAJ0v9xV7OR1FlF1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UzmdZWUrmgSVvGG_lUMaasfxc6pRaN0nie_8yiy_eed-IAjeG1gSSw>
    <xmx:UzmdZVn8AExZR0mC4s0pvxsLKXSnHgB58QSiGSKz4aB0T0i3CkX6ng>
    <xmx:UzmdZTcEFpCLjPyk6YZhecUMIFfHLgNwVrDbmpf0IDYMtbrIZeeg7A>
    <xmx:UzmdZTSkjHp_9yW7YpdP7B6dYMBHA6YaiABK7ORVZdQWJRl7HSk-kA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 9 Jan 2024 07:17:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc6fbc86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 9 Jan 2024 12:14:44 +0000 (UTC)
Date: Tue, 9 Jan 2024 13:17:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/6] t5526: break test submodule differently
Message-ID: <51e494a50e4416ed0cbfd3c474ffcaf8b72e6ef4.1704802213.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jVqiUmCMjR3c9HJO"
Content-Disposition: inline
In-Reply-To: <cover.1704802213.git.ps@pks.im>


--jVqiUmCMjR3c9HJO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01) we fixed a bug when doing a
recursive fetch with submodule in the case where the submodule is broken
due to whatever reason. The test to exercise that the fix works breaks
the submodule by deleting its `HEAD` reference, which will cause us to
not detect the directory as a Git repository.

While this is perfectly fine in theory, this way of breaking the repo
becomes problematic with the current efforts to introduce another refdb
backend into Git. The new reftable backend has a stub HEAD file that
always contains "ref: refs/heads/.invalid" so that tools continue to be
able to detect such a repository. But as the reftable backend will never
delete this file even when asked to delete `HEAD` the current way to
delete the `HEAD` reference will stop working.

Adapt the code to instead delete the objects database. Going back with
this new way to cuase breakage confirms that it triggers the infinite
recursion just the same, and there are no equivalent ongoing efforts to
replace the object database with an alternate backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5526-fetch-submodules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7ab220fa31..5e566205ba 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a broken r=
epository' '
 	git -C dst fetch --recurse-submodules &&
=20
 	# Break the receiving submodule
-	test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF msg HEAD &&
+	rm -r dst/sub/.git/objects &&
=20
 	# NOTE: without the fix the following tests will recurse forever!
 	# They should terminate with an error.
--=20
2.43.GIT


--jVqiUmCMjR3c9HJO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWdOVAACgkQVbJhu7ck
PpT70Q/+LU2aPIYSXb0jN/+ZXppxHZDGGMwQTkB8O1Fb2al6b4ivp+APhJc9bMQy
EIj7t9NK8wySnjNEktWwkz4ETWfLYjUgfCFNU3yzEDIru8VnLr6Gso48CwocwSrG
qZ9Dc5ATb5F7db2IhyJpf7Wclj2qJPHgWF6YlAULjBfbZi5YBP6lg9BFMU7D+UB2
LIIu+o7Xk+TsLANs5kZWbcIOqw4+afdAzpkSoTlu3x7GooGKe89QE3ANw8q31ddV
htR1/SLKeWlyPqaD6+/9CWmAujNtksUxTGlo6gbWIhsHB15TL2BaIQzT3I7ZxcGV
/QsenZyIuhtzfy+sCRqRf9bb/RxjDwAWjp996VtKh4bg55RfLAM+x4V9+5Qm7rkM
BVdw6V3+fLFKjz+8foINBrlk/kqHQvP7Waah7CAM19BycqtnLQnau+WQCQ+4qZEb
f0sDdZ7ZuVwwU6VJ+wm5VQqE/fXREw8ZudVdgAK3e8IbJiXF2DCffKGmRotO7GXn
fNKWzp4erygYzylLbLzfEqvy13PzBjdKuiQBh4sxODeYVpLVcSMAr6PMUtbcs3IE
gpBwiqrwiuUwy02OMiRvaxaPy2sEj6FOiF7gaAacftZYZL/GfJ0Dd0MnVZ6cTLQW
EvgGKQuDbotoq4jmOEXdax8A0dFth2qf6YnwdI8+/svRtVLaBOI=
=RpNz
-----END PGP SIGNATURE-----

--jVqiUmCMjR3c9HJO--
