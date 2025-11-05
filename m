Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8377342CB6
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372539; cv=none; b=DDjjrfKxOl9VRKAeShRWWqReioJwIs9Pjps0F255yDLYYEV4vbgXpvuOG78SdyxKCNTmz5WYjeHbldPDD7M6oRrj80PmtOvsF1eWivyePcgIGL1GQXHjYAHW1FbPcAePZ3MtqblXruUM9XJchPlHv9XZasZuNWaEdm8JhGcV++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372539; c=relaxed/simple;
	bh=pM/HoBmGwYphZcD7cvEGh7+3CpfDx4yOeJOqJljJ1q4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=N14UpY7w+vlJegmPtiawKneVrCeM3Nsq2juV10MqJ+fhXocq91OunDj5qPba9zQ/SEBTafnP8gApuxWaKU7Y3BXkjuEp1Ehjj1jisVIhLjZx0dchvhdVP8EFbdBxADXxHPI/FeyE4TRPsLUngaMB9PhqU3xk3J5CNSDF/rUTIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=ji2Gr5kN; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="ji2Gr5kN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:Message-ID:Subject:
	CC:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d20F6W3TE35YjEutPMfGw18hKoijzf027HAsGi0PDVE=; b=ji2Gr5kN1Rl3fxoAebrm8wbEJb
	eC2EnTuqt+tydJtfzCmvsCkRUTYKRm+LA4bKCYJracMN8j/DqqqlPHo9Dr5c6gh0d1roVSBRf/ecS
	MLB/bWyT5Bo94IpOpOfYW06gr23eKsIbgk54xHnKaBwxzGa0WvRe/Ein2aUeau5LYnFGHAl2oqFUj
	zEGo/JVLhjULyUSJFdzObPCMBPKR2mDdrXDzUakTUIUFp64z/W4tySL+jHBd/iaVzuZMOtX5py+75
	y/ajyFif0VJyp/+YogMU2Bjn/CPlco0XvI/u5XwYikue3Ao4pRgHU1lZjHdPYC8Y4M8FjZINMi61a
	g+At4nsA==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1vGjbP-000i6Y-7z; Wed, 05 Nov 2025 20:55:31 +0100
Received: from login2 (141.76.13.165) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 5 Nov
 2025 20:55:22 +0100
Date: Wed, 5 Nov 2025 20:55:19 +0100
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: <git@vger.kernel.org>
CC: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] wincred: align Makefile with other Makefiles in contrib
Message-ID: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de>
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

* Replace $(LOADLIBES) because it is deprecated since long and it is
  used nowhere else in the git project.
* Use $(gitexecdir) instead of $(libexecdir) because config.mak defines
  $(libexecdir) as $(prefix)/libexec, not as $(prefix)/libexec/git-core.
* Similar to other Makefiles, let install target rule create
  $(gitexecdir) to make sure the directory exists before copying the
  executable and also let it respect $(DESTDIR).
* Shuffle the lines for the default settings to align them with the
  other Makefiles in contrib/credential.
* Define .PHONY for all special targets (all, install, clean).

Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
---
 contrib/credential/wincred/Makefile | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
index 5b795fc..d92e721 100644
--- a/contrib/credential/wincred/Makefile
+++ b/contrib/credential/wincred/Makefile
@@ -4,20 +4,22 @@
 -include ../../../config.mak.autogen
 -include ../../../config.mak

-CC ?= gcc
-RM ?= rm -f
-CFLAGS ?= -O2 -Wall
-
 prefix ?= /usr/local
-libexecdir ?= $(prefix)/libexec/git-core
+gitexecdir ?= $(prefix)/libexec/git-core

+CC ?= gcc
+CFLAGS ?= -O2 -Wall
 INSTALL ?= install
+RM ?= rm -f

-git-credential-wincred.exe : git-credential-wincred.c
-	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
+git-credential-wincred.exe: git-credential-wincred.c
+	$(LINK.c) -o $@ $^ $(LDFLAGS) $(LDLIBS)

 install: git-credential-wincred.exe
-	$(INSTALL) -m 755 $^ $(libexecdir)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)

 clean:
 	$(RM) git-credential-wincred.exe
+
+.PHONY: all install clean

base-commit: 4cf919bd7b946477798af5414a371b23fd68bf93
-- 
2.47.3
