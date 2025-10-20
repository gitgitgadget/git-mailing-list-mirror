Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA51EDA0B
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984442; cv=none; b=cRdj0CZlCQ8ULigvRH0Qho7USc9WGIQpXHoSrInCuHh5mt4xWgqevSv22BXLk0cg0W6JashPq0wFpxxB177/mrf2Mi8uZVAYuSpHVMzweJWfHlpTUJdVQ+dLxBTe794JLPkoOSHNTMdaRjF0+eGyG7NyT3C8TEiEp6Ztabjv44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984442; c=relaxed/simple;
	bh=E3Z52AS2c76fAwFybbeJ1AlM+/PmJqTi4KNSwSiEo1I=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=d0qQgxKAcYEOc6KM1mgJk9tkWGKBYfvD09lvnJFgvPcHTPVGY8QnFJee8OUt6A9crqk3Agc1jSTwc4Sh9g6uFCFQKff+OSofeKOTC9i/BpsA7rE9z45bHwzVGB2rGe3VsZ9yXSdoxQ5NUwFJpj0hd7ErVjQLERhEGWl8Dijoyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=dqW8fzMh; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="dqW8fzMh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:Message-ID:
	In-Reply-To:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8rrFYJ8TdNayl2OIbca3e/oCOqoJBndMIFMbbPnGXaY=; b=dqW8fzMhZxkax+cVldcyT2hIGj
	A2NN4oZtxOquMttj68NJKir8yLwd1Qct5gix+TFQSbAt4cdDevqHvVQhsYM1yK78q47QFGmtn8bO7
	xMuKtiarwAKKzLgriPPV5QN2u4TH1ejzOxxbtjxFfMgD6k5x/wjAsDnmOiifJK9DkRSaozSzJBIIR
	GxoBFHf0ML+uTskWbdb7MxEexFrlK+eiln7Iod67qenD8nPvph1zT4v3Htb8NoEfnXsBHtv/RhFEj
	3VabWJAifF9kmwWgOOQiUY1PiLt2SUyUPbQVi4eD4PZMU3mEK186Qe2JEltCEl7Fxi6ofFCuYl33g
	HqrySxmw==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1vAuUk-00Dczm-JW
	for git@vger.kernel.org; Mon, 20 Oct 2025 20:20:34 +0200
Received: from login2 (141.76.13.165) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Mon, 20 Oct
 2025 20:20:25 +0200
Date: Mon, 20 Oct 2025 20:20:22 +0200
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: <git@vger.kernel.org>
Subject: [PATCH v2] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de>
Message-ID: <0a61b0b3-365b-c198-6afd-f26fcd5a9c20@mailbox.tu-dresden.de>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: MSX-L422.msx.ad.zih.tu-dresden.de (172.26.34.142) To
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
* Get rid of $(MAIN), $(SRCS) and $(OBJS) and simply use their values
  such as git-credential-libsecret and git-credential-libsecret.o.
* Strip @ from $(RM) to let the clean target rule be verbose.
* Define .PHONY for all special targets (all, clean).

Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
---
Changes in v2:
* Revert the changes in contrib/credentials/osxkeychain/Makefile that
  have introduced $(MAIN), $(SRCS) and $(OBJS) as placeholders for
  git-credential-osxkeychain, git-credential-osxkeychain.c and
  git-credential-osxkeychain.o similar to
  contrib/credential/libsecret/Makefile.  Instead replace $(MAIN),
  $(SRCS) and $(OBJS) in contrib/credential/libsecret/Makefile.
* Remove install target rule again to send this change as a separate
  patch later as requested.
* Adapt commit message.
* Link to v1: https://lore.kernel.org/git/48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de/

 contrib/credential/libsecret/Makefile   | 29 ++++++++++++-------------
 contrib/credential/osxkeychain/Makefile | 21 +++++++++++-------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
index 97ce9c9..7cacc57 100644
--- a/contrib/credential/libsecret/Makefile
+++ b/contrib/credential/libsecret/Makefile
@@ -1,28 +1,27 @@
 # The default target of this Makefile is...
-all::
-
-MAIN:=git-credential-libsecret
-all:: $(MAIN)
-
-CC = gcc
-RM = rm -f
-CFLAGS = -g -O2 -Wall
-PKG_CONFIG = pkg-config
+all:: git-credential-libsecret

 -include ../../../config.mak.autogen
 -include ../../../config.mak

+prefix ?= /usr/local
+gitexecdir ?= $(prefix)/libexec/git-core
+
+CC ?= gcc
+CFLAGS ?= -g -O2 -Wall
+PKG_CONFIG ?= pkg-config
+RM ?= rm -f
+
 INCS:=$(shell $(PKG_CONFIG) --cflags libsecret-1 glib-2.0)
 LIBS:=$(shell $(PKG_CONFIG) --libs libsecret-1 glib-2.0)

-SRCS:=$(MAIN).c
-OBJS:=$(SRCS:.c=.o)
-
 %.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<

-$(MAIN): $(OBJS)
-	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
+git-credential-libsecret: git-credential-libsecret.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

 clean:
-	@$(RM) $(MAIN) $(OBJS)
+	$(RM) git-credential-libsecret git-credential-libsecret.o
+
+.PHONY: all clean
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index 0948297..c7d9121 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,19 +1,24 @@
 # The default target of this Makefile is...
 all:: git-credential-osxkeychain

-CC = gcc
-RM = rm -f
-CFLAGS = -g -O2 -Wall
-
 -include ../../../config.mak.autogen
 -include ../../../config.mak

+prefix ?= /usr/local
+gitexecdir ?= $(prefix)/libexec/git-core
+
+CC ?= gcc
+CFLAGS ?= -g -O2 -Wall
+RM ?= rm -f
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
+
 git-credential-osxkeychain: git-credential-osxkeychain.o
-	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) \
+	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
 		-framework Security -framework CoreFoundation

-git-credential-osxkeychain.o: git-credential-osxkeychain.c
-	$(CC) -c $(CFLAGS) $<
-
 clean:
 	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+
+.PHONY: all clean

base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b
-- 
2.47.3
