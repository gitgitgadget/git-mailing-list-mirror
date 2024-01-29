Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2781429F
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560130; cv=none; b=RiU1seswZylVHDRB0+vgGR4EcfM0DoQoJmlZSby8TVHRkmFMcWJALZbJCCkWjTDz7ebGWTTXxWDYPSCFZxd2TymQk0NFXuWeoVu7aYvCU+avjzYsqZuEKBvgGB+5ekEXDHaU0uNCVLpFXVv7Pwxumf6DCbW/9LmXRnSQ9Jwkopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560130; c=relaxed/simple;
	bh=K8l1zgwRFVe0MKOfNMAnzLIo1spy9JmhJ2AfhpjZb+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjSOm/vSUs3WHXy0pBHahJpMnFTbDQ95pR+R1OY4QL+17BZiAOfXAGWIcUApzIay4VMz5LcJB0yG+A/mwBiTFiabIzeeUGhrbcG1BBGWUyMRRZ71/xR79BtTqXw3/1+Vm2cJ5mdPKRymn1Z3vLpkbeDCHxjjOzfoGS15XIAdIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MZqR1E/5; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MZqR1E/5"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C9DE821CF0;
	Mon, 29 Jan 2024 15:28:48 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=K8l1zgwRFVe0MKOfNMAnzLIo1
	spy9JmhJ2AfhpjZb+8=; b=MZqR1E/5pQhebENEUk+L3w5M2wohuj+m6GEjgYcvk
	9sOlWdMBddiUhq3OuXIN7qAkdFcTuH7solsy49RwC/uE4cjPZNusBkJe9ThRVXbr
	GxTGeeBaDmgUVBrdqFWbQUb2wAdgF0VIJbIY4LN+fjM3bNfa9H1Wlpaitz0hJKjq
	9I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C280B21CEF;
	Mon, 29 Jan 2024 15:28:48 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A0C321CEE;
	Mon, 29 Jan 2024 15:28:45 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] reftable/pq_test: comment style fix
Date: Mon, 29 Jan 2024 12:28:39 -0800
Message-ID: <20240129202839.2234084-4-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-440-gb50a608ba2
In-Reply-To: <20240129202839.2234084-1-gitster@pobox.com>
References: <20240129202839.2234084-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 001E688A-BEE5-11EE-8C4B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 reftable/pq_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/pq_test.c b/reftable/pq_test.c
index 011b5c7502..c202eff848 100644
--- a/reftable/pq_test.c
+++ b/reftable/pq_test.c
@@ -60,7 +60,7 @@ static void test_pq(void)
 		if (last) {
 			EXPECT(strcmp(last, rec->u.ref.refname) < 0);
 		}
-		// this is names[i], so don't dealloc.
+		/* this is names[i], so don't dealloc. */
 		last =3D rec->u.ref.refname;
 		rec->u.ref.refname =3D NULL;
 		reftable_record_release(rec);
--=20
2.43.0-440-gb50a608ba2

