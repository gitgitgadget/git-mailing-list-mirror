Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC54A02
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117439; cv=none; b=Kk4ML88SedZu5l+WR0QGc3MKwJxVEqGyBg/SRz5Dkf2WilQ1IeNiK9AEdxZFIYmydU40kFIQ/afCEnLZ1Sl7MHtL5E/CcPPpxxNksen9MiCx3ZmWU08fG6LbCRb4KYgB6MArSkBcn8N2gWZ0gdgm8/bIGcqjCeOrWVIdhdLnRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117439; c=relaxed/simple;
	bh=KrMZVh47d+L+EQDXWFtKq4lyDIqKrWXQOAhN3Fkms+I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Z5eIb2dr4sYzyfA0bqmtLTH4KUnKz2zeFjy2u0ffEm2tI7BTVLkP6oxXxdzQAA5lEC/3M5XR/pxHNghgYPloSh8tMwVIoptVxHYSAMDi0BhXSmJdvLfFCiXysCvTsB281xyTg6nQdfYf3rwC75cowBYF/mVfwp+Vuw7+dBPnVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=u8fZLrcw; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="u8fZLrcw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:Message-ID:Subject:
	To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K383emRZGFT/mJUkrV6NMkhfnSjax/6n7s9gSx2AmqM=; b=u8fZLrcwiL4yLWdch78q0J6nfT
	60wvy2XwlVJXkOjwQAUuPgd/Fi46/aJsuIKcx+5KiFY4xWyPhD20t9sDIEZeR8i5UAJTKCdbnI1so
	KqV4nz4jGWYYSuTpNvQkpWpk3z58I7oJeDuxhDCO90qD1NxZgjA7dUKQjFoJspycmBBTcZRVR5BQf
	ZZrbSQe/9YRCd8a7NKU6UoDV+goxP63WI12L7thThmRZ1ipG0UHhwEoce4RQvx3GY70iucfb7eW0T
	mFVPDrQcXzZf7/9MWZPk/WraXGzii4ZR1WKPv04MUi04RQJ3HCJFk7a4qOe+GGm5Wq+Iv9ggv8B7j
	OIkvgGgQ==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1v7Gwo-00DzeU-Ig
	for git@vger.kernel.org; Fri, 10 Oct 2025 19:30:32 +0200
Received: from login2 (141.76.13.165) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Fri, 10 Oct
 2025 19:30:22 +0200
Date: Fri, 10 Oct 2025 19:30:22 +0200
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: <git@vger.kernel.org>
Subject: [PATCH] contrib/credential: Amend and harmonize Makefiles
Message-ID: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
X-ClientProxiedBy: MSX-T414.msx.ad.zih.tu-dresden.de (172.26.35.134) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout3.zih.tu-dresden.de

Update these Makefiles to be in line with other Makefiles from contrib
such as for contacts or subtree by making the following changes:
* Make the default settings after including config.mak.autogen and
   config.mak.
* Add the missing $(CPPFLAGS) to the compiler command as well as the
   missing $(CFLAGS) to the linker command.
* Use a pattern rule for compilation instead of a dedicated rule for
   each compile unit.
* Add an install target rule.
* Strip @ from $(RM) to let the clean target rule be verbose.
* Define .PHONY for all special targets (all, clean, install).

Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
---
  contrib/credential/libsecret/Makefile   | 30 ++++++++++++++-------
  contrib/credential/osxkeychain/Makefile | 36 ++++++++++++++++++-------
  2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
index 97ce9c9..8ee6cce 100644
--- a/contrib/credential/libsecret/Makefile
+++ b/contrib/credential/libsecret/Makefile
@@ -1,17 +1,21 @@
  # The default target of this Makefile is...
  all::

-MAIN:=git-credential-libsecret
-all:: $(MAIN)
-
-CC = gcc
-RM = rm -f
-CFLAGS = -g -O2 -Wall
-PKG_CONFIG = pkg-config
-
  -include ../../../config.mak.autogen
  -include ../../../config.mak

+prefix ?= /usr/local
+gitexecdir ?= $(prefix)/libexec/git-core
+
+CC ?= gcc
+CFLAGS ?= -g -O2 -Wall
+PKG_CONFIG ?= pkg-config
+INSTALL ?= install
+RM ?= rm -f
+
+MAIN:=git-credential-libsecret
+all:: $(MAIN)
+
  INCS:=$(shell $(PKG_CONFIG) --cflags libsecret-1 glib-2.0)
  LIBS:=$(shell $(PKG_CONFIG) --libs libsecret-1 glib-2.0)

@@ -22,7 +26,13 @@ OBJS:=$(SRCS:.c=.o)
  	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<

  $(MAIN): $(OBJS)
-	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)
+
+install: $(MAIN)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)

  clean:
-	@$(RM) $(MAIN) $(OBJS)
+	$(RM) $(MAIN) $(OBJS)
+
+.PHONY: all install clean
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 0948297..b1d7c29 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,19 +1,35 @@
  # The default target of this Makefile is...
-all:: git-credential-osxkeychain
-
-CC = gcc
-RM = rm -f
-CFLAGS = -g -O2 -Wall
+all::

  -include ../../../config.mak.autogen
  -include ../../../config.mak

-git-credential-osxkeychain: git-credential-osxkeychain.o
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) \
+prefix ?= /usr/local
+gitexecdir ?= $(prefix)/libexec/git-core
+
+CC ?= gcc
+CFLAGS ?= -g -O2 -Wall
+INSTALL ?= install
+RM ?= rm -f
+
+MAIN:=git-credential-osxkeychain
+all:: $(MAIN)
+
+SRCS:=$(MAIN).c
+OBJS:=$(SRCS:.c=.o)
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
+
+$(MAIN): $(OBJS)
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
  		-framework Security -framework CoreFoundation

-git-credential-osxkeychain.o: git-credential-osxkeychain.c
-	$(CC) -c $(CFLAGS) $<
+install: $(MAIN)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)

  clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	$(RM) $(MAIN) $(OBJS)
+
+.PHONY: all install clean

base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b
-- 
2.47.3
