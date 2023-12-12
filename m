Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SetDPvq9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9B00cMf"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A77BEA
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:00:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 6ABBF3200AA4
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 02:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702364452; x=1702450852; bh=ewDnT+wFUm
	ftfOY/+Y001WFZk2M6qTcgAjxZ7by7VWg=; b=SetDPvq9/4OWG4zs7uEaIbW3qp
	cqaycaEfoNTyd203sOmWvsgarzoZB1gfK9avCLKOGyHQ0YSReRgrHTS0PjlokjlU
	dd87bGXwX04wvj2QGE8hXSPiFT94xLcCMKGgmsa6S3izRLlItcMuOG4tT8zmkn/n
	hreigL1dfeIkYv7KRr1bsaNScUSRPh9QVmDlsRSlkrgxEv+UeaPDtPyReW0+ljrF
	9pY8lZGbs+9NWsgYT3f0mScAS0wqmteQxU2dy2TaJNHPHpZ24pTGEOdvG2A19gIO
	8+7IseiU+ZEHXPNMUo41oZoM8/HxY0E0D9MuQNI6xsAACLELI8fTE5nhRY1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702364452; x=1702450852; bh=ewDnT+wFUmftfOY/+Y001WFZk2M6
	qTcgAjxZ7by7VWg=; b=Y9B00cMfbjiE4bOISf/g5zYtqxcztPJzbv7hGA9z5ZbV
	EjSo3jVACXwidcEnGumBes54zrQSbpAy0rAZGXanSFpjAK81i3u6qxaRoORF5pwj
	KNbLlKz6YQ6cY65+G+lPWkKACQ4P4+Rqi9U3pBiHrussewnsVD+5L8B/+Ix2bPFR
	M3wONbUBOzuamqCxByVkiGO1rYi34BMpaGOD0CgWwb+q6jaWWffawfWCpukA1fJO
	KLmUb9/AkttgyC8iNFssk/GmbBn85nZPV6lMTTvzCFWgoKEmLS0unL2wVPFlELeF
	BIgzscnmacj8xgMxyY5iQhJ4ZeSTpntODop7C+HtDQ==
X-ME-Sender: <xms:JAV4ZQz2FSWAtaZ9-k8KunehJSUWqhjhxZVZM07MDTgqYQktA_ItYA>
    <xme:JAV4ZUSnbghQzLQVTUUGmy7MUBMIq0jwLn3iaWyTwGCY95WrfEYASRqCY5R9c7pYf
    6JYjIWNn1Dm1LzAIw>
X-ME-Received: <xmr:JAV4ZSWodCM_SKoe_mYewlNn1ZPJm-rvghLNNcpKfyLYXTUtAn0-gXb5r42xm8RuoaH1acKKsigfxvIxZiSHffjslET_kyN2ASeeOfjBMEsCQwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JAV4ZehBvEQCYRChMRkOiomN4G8lklOTPYBwvvSUbBu0nhzLsrFaSA>
    <xmx:JAV4ZSBEgpVgHoZWgkG-nRV1yGp09HixRwOIrxd_bkqFwfahSNTLqQ>
    <xmx:JAV4ZfJdEsDObclLSkhc6E2ff4FTnfwHKiPzpDoX_hpEbb7YiCgfHA>
    <xmx:JAV4ZZ_-vqjU0hywSk2nC_0P2KekLNtT0hQPGGxCGS40h77rWgqHBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 12 Dec 2023 02:00:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4916cab6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 12 Dec 2023 06:59:13 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:00:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH v2 3/7] remote-curl: rediscover repository when fetching refs
Message-ID: <374a1c514bcb6de4e1cfd7a3a664c014807598a2.1702361370.git.ps@pks.im>
References: <cover.1701863960.git.ps@pks.im>
 <cover.1702361370.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="31cd5Il9zQBdoYuH"
Content-Disposition: inline
In-Reply-To: <cover.1702361370.git.ps@pks.im>


--31cd5Il9zQBdoYuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable format encodes the hash function used by the repository
inside of its tables. The reftable backend thus needs to be initialized
with the correct hash function right from the start, or otherwise we may
end up writing tables with the wrong hash function. But git-clone(1)
initializes the reference database before learning about the hash
function used by the remote repository, which has never been a problem
with the reffiles backend.

To fix this, we'll have to change git-clone(1) to be more careful and
only create the reference backend once it learned about the remote hash
function. This creates a problem for git-remote-curl(1), which will then
be spawned at a time where the repository is not yet fully-initialized.
Consequentially, git-remote-curl(1) will fail to detect the repository,
which eventually causes it to error out once it is asked to fetch remote
objects.

We can address this issue by trying to re-discover the Git repository in
case none was detected at startup time. With this change, the clone will
look as following:

  1. git-clone(1) sets up the initial repository, excluding the
     reference database.

  2. git-clone(1) spawns git-remote-curl(1), which will be unable to
     detect the repository due to a missing "HEAD".

  3. git-clone(1) asks git-remote-curl(1) to list remote references.
     This works just fine as this step does not require a local
     repository

  4. git-clone(1) creates the reference database as it has now learned
     about the hash function.

  5. git-clone(1) asks git-remote-curl(1) to fetch the remote packfile.
     The latter notices that it doesn't have a repository available, but
     it now knows to try and re-discover it.

If the re-discovery succeeds in the last step we can continue with the
clone.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote-curl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..fc29757b65 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1564,8 +1564,11 @@ int cmd_main(int argc, const char **argv)
 		if (buf.len =3D=3D 0)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
-			if (nongit)
-				die(_("remote-curl: fetch attempted without a local repo"));
+			if (nongit) {
+				setup_git_directory_gently(&nongit);
+				if (nongit)
+					die(_("remote-curl: fetch attempted without a local repo"));
+			}
 			parse_fetch(&buf);
=20
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
--=20
2.43.GIT


--31cd5Il9zQBdoYuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4BSEACgkQVbJhu7ck
PpTdag//XytZxJAPjNpuJRxIVCUdG4F4dicmyhu6KaQ2X3JqGLTaN/HBEM259jWe
utmQy19LAZoYz0kQ5bIGqV9GoaeT7kXlfUK9s2rKLpSniBmiKA4SBW/TRxGEW/iA
UOIHSkwOoK+QzTmSQMR7QE7wqylr4n8MGQVJn/16Pp6S311VyS48xQMKChYwbm29
myiqJhwShAetsxYJarDvMEi6mpzN+KHommPMRVVplXaqkcuHelIxPYsgYWkmlpyq
fgjgq/gAgWpX0hZ3FLsnLtci1bFcfF5qWmnznBUBtsSxhwYmqp94iUKLo45u9P16
PclLdC9UetyZdU88or4MmURrHDxLCh5I5j9I0Oub3AYFWiaYlDNE3YzKzg6kJsIK
i3tIGJ4Y6zxYxhItDJHKHHUfFOxWz8S/p+r6RNFLNoPIBPuxXM+iqhnPmsf0QeDb
20NDaazJJJFvtCjCsxByB+ZfMYtd242KcWxsbv+6jMAiExj0wcm9Wq7Sd7P/SF8T
0mZ7LYr5OUnXuDXOLgjxYJu6y7xF8IAOnv4Wgrgq7zrjM1/257NChZxUbE4DH318
eLlEO1HldvI2vst6tcBTtVX5HS5JKQkllyboPSZGlQ96GnYA+nyrEoVOd4vyyKYw
WXOugIoSsqNRPrLtOi3opFGEW1+VDROG/7BA2+HCGL69xQNPru8=
=pBAd
-----END PGP SIGNATURE-----

--31cd5Il9zQBdoYuH--
