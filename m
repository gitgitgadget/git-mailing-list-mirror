Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FE2E0905
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761424213; cv=none; b=ZF8GLhwo9fNFy8JijG76+eHJ8/kiug2JKkB7iAQicSXRWmPdNOG8Ju4xmH8F3Qy8ARxZZyNy4QHWX5+00mjYyBKCRqyh3BptIQxOoV0eMCxBcYJxZykhcIpQenxEvHG2/z3J5rdQFSNQLVkVBp5mJxNgUbG0Hin2FIiUnxQsp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761424213; c=relaxed/simple;
	bh=oqCXmZEZbbJt2X7d4mfQmvoga46SFoBjrs+lO6kLpcg=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jju3dDTDsqxtM2bDGRhomCSP5Zjx6s7R2Tc7VzvxcYwfkh9PiHE+96bbSxr4milL3ifvoc1Zk9nVsQgXjgQ7Tg9FGJSOtTqt77aaOywumHJ8oRwIf6QwiajLZ+11hPKneB05MqfhGWcoscVK/LLX0r58rz5wuCeGBBnFBDh7pjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=MBHMGwJl; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="MBHMGwJl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:Message-ID:
	In-Reply-To:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=49grqOTApvz8GB3tBUiZ8h3nI+hz3cFvWcAGs5jRB9Y=; b=MBHMGwJlrZv03msgB9C9WT+QDl
	VxO/tlTGr/SIPR2Q4XjCta1d9oWfW1/qBRHCnqnZD89JNK/rDL0jqIVMDzjYgo77BIXi8+RGfMBY3
	G/KttB86rI0VvAbys1RZ3IyAUalPDbooS7ZvTUtijTgcZUIcfzug5Bur2RcacU1iWg7+MOoA0IGnH
	9V8UDyEgs9GaLA+w8UVNag8zoTzXs4naebh9PglqhQM5Rb3Y4RIzUWKcYRxboIpHJVgzuD2FmJ3/Q
	swW0/k2O1d7z2OYDPKFbyjIKPv233FDSH+6+7qXy52+BIF4Z5bnyocGK9Hw66PChYcqRY1puVwlGQ
	Yd9WQbOg==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1vCktr-00Dv00-Eu
	for git@vger.kernel.org; Sat, 25 Oct 2025 22:30:07 +0200
Received: from login2 (141.76.13.149) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Sat, 25 Oct
 2025 22:30:07 +0200
Date: Sat, 25 Oct 2025 22:30:07 +0200
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: <git@vger.kernel.org>
Subject: [PATCH v2] contrib/credential: add install target
In-Reply-To: <84d7c984-b594-3ac7-2593-58664bd8c726@mailbox.tu-dresden.de>
Message-ID: <f67b3cbd-a117-a863-37ba-fbba7a2ca17a@mailbox.tu-dresden.de>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: MSX-L416.msx.ad.zih.tu-dresden.de (172.26.34.136) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout3.zih.tu-dresden.de

Add an install target rule to the Makefiles in contrib/credential in the
same manner as in other Makefiles in contrib such as for contacts or
subtree.

Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
---
I am terribly sorry to send this patch again as I forgot to add the
"Signed-off-by" footer.  Everything else is still the same.

This is the follow-up commit on top of some clean-up changes to the
Makefiles in contrib/credential that I have been asked to send as a
separate patch.  Here is the previous patch:
https://lore.kernel.org/git/0a61b0b3-365b-c198-6afd-f26fcd5a9c20@mailbox.tu-dresden.de/

 contrib/credential/libsecret/Makefile   | 7 ++++++-
 contrib/credential/osxkeychain/Makefile | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
index 7cacc57..b10cfa3 100644
--- a/contrib/credential/libsecret/Makefile
+++ b/contrib/credential/libsecret/Makefile
@@ -10,6 +10,7 @@
 CC ?= gcc
 CFLAGS ?= -g -O2 -Wall
 PKG_CONFIG ?= pkg-config
+INSTALL ?= install
 RM ?= rm -f

 INCS:=$(shell $(PKG_CONFIG) --cflags libsecret-1 glib-2.0)
@@ -21,7 +22,11 @@
 git-credential-libsecret: git-credential-libsecret.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

+install: git-credential-libsecret
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
+
 clean:
 	$(RM) git-credential-libsecret git-credential-libsecret.o

-.PHONY: all clean
+.PHONY: all install clean
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index c7d9121..5569581 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -9,6 +9,7 @@

 CC ?= gcc
 CFLAGS ?= -g -O2 -Wall
+INSTALL ?= install
 RM ?= rm -f

 %.o: %.c
@@ -18,7 +19,11 @@
 	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
 		-framework Security -framework CoreFoundation

+install: git-credential-osxkeychain
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
+
 clean:
 	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o

-.PHONY: all clean
+.PHONY: all install clean

base-commit: 4e98b730f18d59b670ee57b803e5048b9d14b968
-- 
2.47.3
