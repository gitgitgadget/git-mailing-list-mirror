Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5B4426
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="leKFVSu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+IQvvna"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 1E9BB5C003B;
	Thu, 28 Dec 2023 01:28:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Dec 2023 01:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744892; x=1703831292; bh=NxsEGZcw8v
	P7QprNaF4qKO1CIAP0gcFPflEsF7Wv5iY=; b=leKFVSu8o5At5RsHPucCHdPtCs
	ZrDeHhSzr9aLY+4/6aNucgvuJLlDhi45adSqVU6xe0BbaykmMj92b6S0srKpYiAY
	+IpnEG3UmKCVqw7Pd4ZxssWsmE1SPOBJ5XrsStHP2sS0urXA+ai/6jT0kCl9G1/T
	FtH+XI3zSHQsp1YMxNJv5BRW+Pu/oIC2dBf9dBNNc93uJEmo8i4XQ+Dmek6POHe9
	ljxPX9VIDmW9NT0tbvnfN2/03tRDCA8zRQPWz3O2EBmxyFYpcY4CE0M/iyqEYZ55
	gZxt/BMcSA2NNXZcAwBeN/MfSy6bH/6QaBbiaYXeWD4Q1Ds9d/bVL3k32aKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744892; x=1703831292; bh=NxsEGZcw8vP7QprNaF4qKO1CIAP0
	gcFPflEsF7Wv5iY=; b=v+IQvvnakP8G4ob9s5KyhSSnphc/EISdlt7NtSP/UGIi
	iiq+zuD/lyMbs7bmsGklZv8IqniieoPk5sG1Hnv4sAtdzqWeGidcW9k22eJ84cHx
	wyinzxsKUeukyEfXXR/rTg5k1IYqYmv5ikunuhGJcLR2AK0XYDyx4E2oS5SLyLXf
	pCjjb9ccYbtBuaN+6N/8NlHTz7L+uMTWU8cRztKKYSHKGXvR1sQq1u6TL+xQ/HRB
	H7bPni4fWLljkxfZ/xeWP6NOWu5cdzqnH9Wj+4U7HBPx6ItYIwulcByKtbGSq4dz
	mdblbImHqgKlRut5vrKr2EYGjb3ctV9kj0/H4UPZ1w==
X-ME-Sender: <xms:exWNZQEoTdeY2irlQIPKLmzpp-hG2xiDGkxxet5gFTyy44kVbl3Grw>
    <xme:exWNZZUKrQS_I2flfwedlThACgjgxox8647fP0g_2nSng8FGVecZAUFhvdM7BdPhw
    dhYHmerjnPS_gbsbQ>
X-ME-Received: <xmr:exWNZaK362N7Iv9wiix_Lb2S2xdxHSuP78GL4ESGvw32VPugQQsSES7woE-iDe5LWPT-CODlfTge6RpkvLVT0yMruSq6LIHVxHWUR1sSLXXLTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:exWNZSEolFxLfGkkHqTPSXl1JgFWChKUSAoOaHUAwkMJxHyr7Ng3ag>
    <xmx:exWNZWWA0l_yL39cBRRleVI5xD0cjiSYLZ56Omu6H_D144KtkfgVkQ>
    <xmx:exWNZVMF_l-EjjH5JUX3VfoHnYI5Ld9fKutM-8yUrGjX5izzFtTl8A>
    <xmx:fBWNZZe2IVvTJh7387I9oMo6ZdTXCn9fT0Xky88jzD2IC4llPqO-0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:28:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4882d17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:57 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:28:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 8/8] reftable/merged: transfer ownership of records when
 iterating
Message-ID: <25a3919e583a9d13403b8add92260529e19e08fb.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cneaGpuQdbu2PGAj"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--cneaGpuQdbu2PGAj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating over recods with the merged iterator we put the records
into a priority queue before yielding them to the caller. This means
that we need to allocate the contents of these records before we can
pass them over to the caller.

The handover to the caller is quite inefficient though because we first
deallocate the record passed in by the caller and then copy over the new
record, which requires us to reallocate memory.

Refactor the code to instead transfer ownership of the new record to the
caller. So instead of reallocating all contents, we now release the old
record and then copy contents of the new record into place.

The following benchmark of `git show-ref --quiet` in a repository with
around 350k refs shows a clear improvement. Before:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 708,058 allocs, 707,865 frees, 36,783,255 bytes all=
ocated

After:

    HEAP SUMMARY:
        in use at exit: 21,163 bytes in 193 blocks
      total heap usage: 357,007 allocs, 356,814 frees, 24,193,602 bytes all=
ocated

This shows that we now have roundabout a single allocation per record
that we're yielding from the iterator. Ideally, we'd also get rid of
this allocation so that the number of allocations doesn't scale with the
number of refs anymore. This would require some larger surgery though
because the memory is owned by the priority queue before transferring it
over to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index a28bb99aaf..a52914d667 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -124,10 +124,12 @@ static int merged_iter_next_entry(struct merged_iter =
*mi,
 		reftable_record_release(&top.rec);
 	}
=20
-	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
+	reftable_record_release(rec);
+	*rec =3D entry.rec;
=20
 done:
-	reftable_record_release(&entry.rec);
+	if (err)
+		reftable_record_release(&entry.rec);
 	return err;
 }
=20
--=20
2.43.GIT


--cneaGpuQdbu2PGAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFXgACgkQVbJhu7ck
PpTCkRAArXhl4TfWDqVpNQzSseOng+oWTQ6cOywFB5hyze81mBP/El/mu4Xnzvdd
6gsHqtjnxc/+Pe2C8in3N0i0ZKrg2HKM2X77FsKr1SRMPIVdXhrx2f0Rz4XHAfjX
hac/nMJXQ8u/SO20CFKoBbAYMVVK0e8rv2vH3oGgWP2+AGMQb/Kcxeaoc/RKkmJ3
KyWIe4aTWfBKBVSV5XgD00rxRc0B6tqnzTeSbooFUC8F5yn4aTfiAUwpOwXqO0Qc
oZokvO7GE19gsrCKbI6LIzCmbJ8QIFvsmSYfZWcKwYGBSuzRVeVkXg5XsWsLogpA
jGBRXt3jbBqdd47x1M0WDgZ1F9FntgpUCOoK9Chfg9Nh20VUXsm4+71+XU/ZFHKp
SDvCplwV/J/O2LW/Bwk3yiLePMkcgP7Rc9ZBRp1wloRAIW00l8tqYShE8URar/y9
V1qke8zfEw8Lz3m1x6RIEu7B/aBiJcYyrw9TCM5Xyv6hBPX2Ls2cfI7N3wEt+jVB
g4zZHDoivldhqADQSh7FpPwhtaBLyiu7yScRNr6SKX18olDXSxzD/7p6xsmjA3vw
88qSX6PRn1NSdn2WMbDWUmjrVYfL5bNi94iyGJaLU6qOCrgrhNjt6PF2/HUJKMMx
FOuRy6ubA9buXLvVl5ufaxORBuMCSyx8czckj7t+EK8f7Ib07Ek=
=ZS3F
-----END PGP SIGNATURE-----

--cneaGpuQdbu2PGAj--
