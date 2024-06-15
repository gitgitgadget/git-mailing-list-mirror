Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F7179A8
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718441642; cv=none; b=i8Y1YxBIcBDDIGAvvP/UzklExTDDd4pUXUPjEnJs16WSuvyPFqt96D3ApSGukAusFZsWYqSiaa7g+jt/VEcQkqjzzdAiHQcPfQPDES2faYyp90JzxWSfXlJK57cPT2UdjWPSUgcMdwrAtr4b19L63U5FMytoLsKmciQ302AcySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718441642; c=relaxed/simple;
	bh=VesPKPWtncqInbLVlaPlz+FHJCIsrxFV2+a60fFwwoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B59uC5xYP3Ur6nlT/tlmyesRIx3At2QBzTkIAj+edn+CrQarMJP30F/TEyqRsVuAywxunrHPXD1g+YcKWdKTQQy22YxsMqmJ6A6mTb31yBkID/qSNLm5L/WfbrJsoDNZVFrUU3qCz/VEg+Lobn5nxFw08sAOYvD259IeA9NcIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHhAZSuR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHhAZSuR"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f1c4800easo372866666b.3
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718441639; x=1719046439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyiUSwHHeP8mhpxGD1Iq6+v4GErnFlfFPrlEQRDjziE=;
        b=VHhAZSuRq1DXUWbziW2QmHMuV4eJUBP1uNceGbToA0+0PXp5etMlM8cJDg0huAZ3iX
         ZvMbn4dY3bsrnKWC0AmQ5TLiXEIARl9VE9/1Fo3lnjXt8zobkIKxVc+epa946XxWp3/Q
         b7IpvBro1wF8vnt3jWJSvQljlPhRSN3USp/xwvjcUFm49fCJnDjTQgChSKvf0XSUoE89
         0TNw1EQPk3d1M5E/NKqCZiedcOot6forhbjidTsCRkRlP9gY/bIQe4tAUqWjyoQGblb+
         EWaszrmC195ey4c4V5tpm+kfKv7kUyd41X9RDI62JZ6R8WmaEfmJFfRKxsnL0uBtcAmg
         kjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718441639; x=1719046439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyiUSwHHeP8mhpxGD1Iq6+v4GErnFlfFPrlEQRDjziE=;
        b=Kv0x/HBLhxchlGRb7beW1wx5ZydTj/LbOLF7WkKEVimud/1KB1pyaCTGz8Uhc69ke8
         ZERi/XF27btRHI0EFaNRLzaIwYFWyUn9ZahggMAjaq08NKMmY/kwWVXFOpTzksvwM/SJ
         w02aClWQsGqUJCcOJptnakTKAySwrXliVpfW7XM+L+r7+3gv2GWPdCPFjbDQA/e/MwCa
         Qd/yBl9ix47Yyo4jh4CZyFdKRqptFx2gkjYJNKtdvnG90FcxVfamNw8JUsK4bcPA4lkB
         0wFbgLSbCuw11aJsQz+01uCKbLpy54rjMQ0OjtqbI1XFqrIz15vm9GQUitd+/hmdBSbR
         Lz1Q==
X-Gm-Message-State: AOJu0YxC7+Nb4ps2pRkWCa4PalRzEeYwB4xgf4JFoXhS4YeNoSTwDNGO
	Om2tfsX1AMaW4ACyugWoRKwt+5b55ezCC522d5vk2U9E31/ofhulxWJAsMUC
X-Google-Smtp-Source: AGHT+IHjnw34FZDFCi4O4viyoUDPJRPHz0spd/OcbzxKxPTGDnijFF82six+SrPFVtqlkb4g7e/PbQ==
X-Received: by 2002:a17:906:3749:b0:a6f:2d3c:6b94 with SMTP id a640c23a62f3a-a6f60dc8956mr271831966b.49.1718441638488;
        Sat, 15 Jun 2024 01:53:58 -0700 (PDT)
Received: from localhost.localdomain ([93.170.44.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f40fe2sm281271266b.148.2024.06.15.01.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 01:53:58 -0700 (PDT)
From: Serhii Tereshchenko <serg.partizan@gmail.com>
To: git@vger.kernel.org
Cc: Serhii Tereshchenko <serg.partizan@gmail.com>
Subject: [PATCH] Fix default font scaling
Date: Sat, 15 Jun 2024 11:53:39 +0300
Message-ID: <20240615085345.47278-1-serg.partizan@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes font scaling for default fonts, where we don't set font
sizes explicitly.

Without this, on 4k monitor with text-scaling-factor configured in Gnome,
labels, buttons and settings are using very small font sizes. (Probably,
not just Gnome but anything that sets custom DPI).

Screenshots here: https://twiukraine.com/@partizan/112619567918546426

Signed-off-by: Serhii Tereshchenko <serg.partizan@gmail.com>
---
 git-gui.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 8bc8892..23dd82d 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -810,6 +810,16 @@ if {[is_Windows]} {
 ## config defaults
 
 set cursor_ptr arrow
+
+# For whatever reason, Tk does not apply font scaling to default fonts,
+# but applies font scaling when setting size explicitly.
+# Default -size 10 is still 10, when you look at it with `font actual ...`,
+# but explicitl -size 10 becomes 10 * scale factor.
+# So, we need to configure fonts to use their default font sizes, but scaled.
+foreach font_name [font names] {
+	font configure $font_name -size [font actual $font_name -size]
+}
+
 font create font_ui
 if {[lsearch -exact [font names] TkDefaultFont] != -1} {
 	eval [linsert [font actual TkDefaultFont] 0 font configure font_ui]
-- 
2.45.2

