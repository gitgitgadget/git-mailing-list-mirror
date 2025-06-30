Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89F13774D
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306809; cv=none; b=DWxGhw093sYCfwy6XCBr4BS/Y6BFtfCPR6M1qw29wEik57yH/LtHX7h30MijXIIeuy/jdK5fh4K7HprZLr/8equeX4MvFm0I6XUqgl3Sk8+lwnqehFum+N8y4WZ3qys/gbUvUrQa5L+zYg/8+jqlTKwJyx9mlwWjpXs56R9PESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306809; c=relaxed/simple;
	bh=U1kFsxglAEPYe1BxsSTQ1rSUSBGKtf5M18cxND+w4EY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb7E27A+9s4wqCVtD3RqizMOiiLqHwS/mh3TA1lhSZGxP0LO9FpH8tgW9+fl93N40u7S0AH8XtlDcv6VXg1o2UQdWRHiKIsW+vIiUqRE0qDNHRXe8msVsR0Fh4H87v41c9ql1SbaV98alMb8eE+Uw6HMpardwdx4+TqM/SOf8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=McPgK/lT; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="McPgK/lT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1751306798; x=1751565998;
	bh=U1kFsxglAEPYe1BxsSTQ1rSUSBGKtf5M18cxND+w4EY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=McPgK/lT848cGPEmlT8TUjnT+FI1DVgKVs81WvUkHv7ZEyq+BMV/zL3lniEwqKVCu
	 ZySV4oN3Fxnma4T1wTHZn0wB+FleFz7Dj/wuk7yOd6gGMlT4M+tz0wRPAkGboZgaDB
	 UCl7pkz6tNPtjYcr+v1q8B0EOi5gcXw8UI8mPp5y0kRga6JaiMUNE5VxIFimWWLX1/
	 4y5Rz/1niGmk9jKwBkDKE1LFzwb+ychVOqR15FcT5jQH4CJEjo4RabSLX7U49R25fZ
	 yHbyZXdkVFuE+UbB590a52iBZWGBTf6UKrHuOsPeEkAJ/7KzQ7uoynDvFOwl9P7YuY
	 uinMOCgnWXUEw==
Date: Mon, 30 Jun 2025 18:06:34 +0000
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/5] docs: add outlookidfix config option to sendemail documentation
Message-ID: <20250630180511.499-3-gargaditya08@proton.me>
In-Reply-To: <20250630180511.499-1-gargaditya08@proton.me>
References: <20250630180511.499-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 95ed6d09da28a2a7ed56117954e279cf7ca67c7d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@live.com>

The documentation for command line option `--outlook-id-fix` is there in
the sendemail documentation, but the config option `sendemail.outlookidfix`
was missing. Add the same to the documentation.

White at it, also enclose the values `true` and `false` in backticks in
the documentation for `sendemail.mailmap`.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
index 54f1248e64..4722334657 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -31,8 +31,8 @@ sendemail.confirm::
 =09values.
=20
 sendemail.mailmap::
-=09If true, makes linkgit:git-send-email[1] assume `--mailmap`,
-=09otherwise assume `--no-mailmap`. False by default.
+=09If `true`, makes linkgit:git-send-email[1] assume `--mailmap`,
+=09otherwise assume `--no-mailmap`. `False` by default.
=20
 sendemail.mailmap.file::
 =09The location of a linkgit:git-send-email[1] specific augmenting
@@ -96,6 +96,11 @@ sendemail.xmailer::
 =09linkgit:git-send-email[1] command-line options. See its
 =09documentation for details.
=20
+sendemail.outlookidfix::
+=09If `true`, makes linkgit:git-send-email[1] assume `--outlook-id-fix`,
+=09and if `false` assume `--no-outlook-id-fix`. If not specified, it will
+=09behave the same way as if `--outlook-id-fix` is not specified.
+
 sendemail.signedOffCc (deprecated)::
 =09Deprecated alias for `sendemail.signedOffByCc`.
=20
--=20
2.50.0.windows.1


