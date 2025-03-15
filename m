Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310D1D63C3
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047758; cv=none; b=oUujp60+KEul6/M7OuKQMQtuc3GqlM7F+pMQlhErotxPYWBR5mJ0UyORqrsqIfGIW1FRxjgQgwt9kz/pmFS6gM/Y/sDVaGnjcDkmcqaz/ybTzfp9LgnqySC7Sd/NMtfrExqSa25KD909WDPgHKKM/MjyS9k8opm0QAOAvDq/oIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047758; c=relaxed/simple;
	bh=ut1wlFnTu5U7fj67BXHXzul3IXZuskDgKHajLuOyALA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uuGGsZWZgY2OKGKKG+5sMAkNgid9Qxbe94LjwI0uAHnMqLFoT1dQPWQBFN8AdtdWvzVZnN8UHG0Do8ARUha+TJINgL9ExzvLLiWYJrVMgL7wABHMnUkxfY6QZOXDQ+j1Qvi2yyZG5bGAyWw5exskfuazKDByuBZSMBa/H/WRfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=aMYRcveH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="aMYRcveH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742047753; x=1742652553;
	i=oswald.buddenhagen@gmx.de;
	bh=sOyRNrz5wa6FpOpzzALKxdEzqZTUqZvZ3CCgjuX11ZE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aMYRcveHWqGYb7ekmgurV4UY/SC2a6EM4GSJxFTeQaSpXpnyTg7oeRdD3J21d4KA
	 tQdli4rrCrdI0Y0UsLmiD6go00MS59irP6zOXc+Bj9g4m1eDzJw2LaNjsZ5RUN3A9
	 QwQudOF0ROApWw+oaES6BoFY/FzH7N+vYvgLIE6nkqq5Ws35++pWMqmfXX0u4Reug
	 3uB89TY7uy0z5iDPeIvXcuLvYVypi+VcEczI7CJcGqgUAm20UYpQPphZVcP+DlmEz
	 z9KCrSgSNIvwCYVnnVjPS9QuRCgkOIZbTO/5OYwPMB01sstzPv2dveGZWpk6TBFdl
	 sviGQzHZ3y8CbMx2+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.111]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1tU3531xS0-00mrnL; Sat, 15
 Mar 2025 15:09:13 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1ttSCP-QD7-00; Sat, 15 Mar 2025 15:09:13 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Subject: [PATCH] docs: clarify meaning of core.commentString=auto
Date: Sat, 15 Mar 2025 15:09:13 +0100
Message-ID: <20250315140913.577404-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.49.0.416.g2f302f2ef0.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8vszEo4ZfIJnSto2HHCKkkKo8M8VmochkEiciteXHpJPeMmZgkI
 lP6d/+MTht/33Mes7ztL/aWRQ4kK5yn0A3IaW60X/jPBraFFP+lKvYjfrBP13fpOvBjQtQ3
 AImjnXzI2nnQ92jmSgO5B4yigdsdwqDqBiNQ5yzwNl+ZItRtaA7clh3WmPBFNPKKPv1Scyn
 jkmkXoU0pexnWkaH6bwKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BLtOM+VORZg=;mWN8bLO+gJH3aOkmVgY/p7PIGJp
 3Ww/RhZ2ikuNITxAX85EGJkZBPyMCbyVZxH8ri0XsXLpSBcnpE4nbUtg+Ncjh7ppSUwYbftCf
 6wPZqtb8NvfCW9xwbh+IH9x/92mqKCvSCSyAsVU8YxcTppAxgkPamO5bOPZy8NlT3DfXUGPr4
 8NQgOfHDnrg5lYJ146sHPQcXQf+6q5H+tPFhjzCQeJWHu6oI2jGmxSvVJgSgciRsBgp/NyEJ0
 0UEu75dn3/9Zn7JBj/S0MsKmEUroNqNvvC8rFIwKwhSFhA8XGu+yz2R0LPlPUOPHduu4Q7TAR
 U148F/klYCzd+SMsyTDosiV7pY4Ls6Ys6k7B0i5p3IUjZwu9Tty5FKtnvhTwytNMTVbi1+lOE
 n3qESvk24CCtJ3AwdUvDRSu1AFMjOqw0e5v3AmmjFpzNuChCumnAGSPycOk8ByFU/yCUWfi/D
 62NH2WomhXWw+GYzPxqUkaqRDPJaVM1Z+1quGGDz+Ug4e6VuzTP2xVO57MdmMBQOFNyFuciCt
 mQTPEs8vZdi23jty6XsAn+37cZdj4SDZZm1cR+L9k2KiUngwR2p1l3iRaSDHdnkL2tTwUQgcr
 tJrmoar8oAuSzVeG36OuXThcjLKSx57Y2Gpq4hfJWp1K2UnifEwoUdVnVXfILGDoP9A2ku1c7
 44iaSySDBT0kQPdiRHM06lsGnS5AY/toxqmUgmqztpq6BgfetjAeek1s7EkYHEkvrRUpPFNIE
 sMrw3hLaezzXAzi+3/z3ICR7Zgyc/GcxCnSOYllA6dJ+nwVZe8y5Jshs4XWYEp3Wr8+g9YbEb
 jXyBAkAa1JD3WW+u1pnhj8UGxvM9WLivyZ3V6H4MnV1s6i4/93ST/G+jCtdbxH6wf4TbmVnvG
 rzr9W3m+sK89iXa/8DcAU7hgrXZQKaNczfro+drYTRDh7lmDo9OZag0dDZgPjTW/mGSHeXCIw
 Fp9jMotJPE9RZaOYd6J0G7/UBXQR+F8yClTjl1e+zUKYUXauVJGZr2zefE6EpoWHjVLnbQf8m
 IUxgo2UiKu+tL/9p6rBB3nef57L5dIiDPa7ENTemLLUMdwgd78k4uk/zK8N/AM7WacrAUKs6l
 GS1Jg99GfJuUxbfZu4Lz5+IaVPcj9pJEwWF4w199EjQdJKCHN0gvXnro9enoHM6xnuEGvpr17
 SrPWH973nq4NDQ6RP8P4zvssKpKrX0WEfWhvy+NoLAMPu5tlHPWZEKCjnp5XXyZQL5IBLF0Ap
 bPupBqsX73wrSEcZy9wyBsAAdwMEWQGE53tP2IJLNHFZcZiyyYA2PkNv/wjGK60RgCRfviUJz
 9QAy8BpIG0kRpV6noqeonZs4TsYMuIXlhUC2J/NKQlaIWr1btF9NzMgI11jWJUQSra0+ooUCL
 NIhgysI+5WTacYzNB7U6c6iqqmUyBPlFFbsLxo/7Q9H4ZucQSX0tJWUpcgcoNg0HRENQyOGBC
 n//D3l9ehei2GX2zjKTjnM6pNOZU=

I had to read the source to make sense of the feature, which is clearly
not an acceptable state. Make the docu more specific and less
misleading.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---

Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

given the rather crippling limitations of this feature, does anyone
actually use it?
---
 Documentation/config/core.adoc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 8f6d8e7754..b470da72ba 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -526,8 +526,11 @@ core.commentString::
 	commented, and removes them after the editor returns
 	(default '#').
 +
-If set to "auto", `git-commit` would select a character that is not
-the beginning character of any line in existing commit messages.
+If set to "auto", `git-commit` will select the first character
+from the set "#;@!$%^&|:" that does not appear at the beginning
+of any line in the prepared commit message prior to editing.
+Note that this makes it impossible to include comments in the
+prepare-commit-msg hook's output or the commit message template.
 +
 Note that these two variables are aliases of each other, and in modern
 versions of Git you are free to use a string (e.g., `//` or `=E2=81=91=E2=
=81=95=E2=81=91`) with
--=20
2.49.0.416.g2f302f2ef0.dirty

