Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F22E7198
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306833; cv=none; b=VCVj8dAhcNgZwFPEftVKQvt5lpRIfjlhVr70g3GRQRxgP0LX9t9nxVNla+L1qxS+dxslSBLidEHLy0qBJMjKGJq9t/55kKYnvqOU+P/D+Z4K7/Yt/izVay/NLq+UFroNeDvR96+dU3wV62CXlWVdFHXrXRn6sivScro167i5X88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306833; c=relaxed/simple;
	bh=EaBJurLE8vJa83MsVmg/fHU5sHsjzesiXtVOE1VM3qM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PERbTzW5E42yZQ7OI6mBn0TaMrFQko77r9b03NjtrxQaAdS+rNrI692VCOQEwRRoKSSeXw5VumzrKr/MXCLJfvJLOZFDYq2V+7x2EyxYwgc7UmgmRTBCPKfL5TcQT3v1rJU+2Nm33/ySkHAozSe54nRGSbNRxNgJptY76FBqqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=JQTnlpR2; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="JQTnlpR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xksxrq5vpfeprafplf4maa6x4y.protonmail; t=1751306821; x=1751566021;
	bh=EaBJurLE8vJa83MsVmg/fHU5sHsjzesiXtVOE1VM3qM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JQTnlpR2kkUTcqawlW7oXWZpYAoFDcCtlDPPI/i4023hbTaapqkZ6Mq5toX/9U+9R
	 T+K5sLJ62xYQceUN+XAgRwsmy1IuZuTEJN/CUhBKGIUwrlMR6PEUueGfPngzH7qU8c
	 xDg3eFdK6flvywU3+cm+Mj8wIMXypOM1LGuwzHP3eHHNRPLt763j94xkidV+e7bJlH
	 cfu7pWQSY2TieFEk7MON3Y0uFZ/M/osbFRvokIPBnTN/JLOHxGmd3s/6h2x5RoBo6S
	 DqDOUuqY/Umvz/H1kWWbM6Suj13zCXDJZEb2KwjN4aMfLwnMd++b3kT64qEPvMaT6y
	 B3g6xqWr0Q6YA==
Date: Mon, 30 Jun 2025 18:06:56 +0000
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/5] docs: mention possible options for Proton Mail users
Message-ID: <20250630180511.499-6-gargaditya08@proton.me>
In-Reply-To: <20250630180511.499-1-gargaditya08@proton.me>
References: <20250630180511.499-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 68df158a27d2d53ef63d4a4c957f8ee1f3deb99b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@live.com>

Proton Mail is an privacy-focused email service gaining popularity.
Unfortunately, it does not provide an SMTP server to send emails.
Proton Mail Bridge is an official solution for paid users, and for free
users, a client named git-protonmail is available. Mention the same in the
docs.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 6556f949a1..5335502d68 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -606,6 +606,14 @@ available online. Community maintained credential help=
ers are also available:
 You can also see linkgit:gitcredentials[7] for more OAuth based authentica=
tion
 helpers.
=20
+Proton Mail does not provide an SMTP server to send emails. If you are a p=
aid
+customer of Proton Mail, you can use
+https://proton.me/mail/bridge[Proton Mail Bridge]
+officially provided by Proton Mail to create a local SMTP server for sendi=
ng
+emails. For both free and paid users, community maintained projects like
+https://github.com/AdityaGarg8/git-credential-email[git-protonmail] can be
+used.
+
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
=20
--=20
2.50.0.windows.1


