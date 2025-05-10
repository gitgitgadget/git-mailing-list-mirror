Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C996182BC
	for <git@vger.kernel.org>; Sat, 10 May 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746897450; cv=none; b=OJPc5ZTzGqQKeOtGDaobE+x7lU9f9/i+5yTAS65YLCa2gWHUZvluMLfVzN6HCVlY3gOKV/g6QDXueduxSiKebEzbHIcPMY+TbwjuPWenAtObuNXL2nDA4211YThL0uxJ0CLwTq+dtxY58+LgZmzB/R0RTwYCcZE7P8G7i3sXvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746897450; c=relaxed/simple;
	bh=mfP5OqZxmZB9+xRYNvi15fCtiO8h9o6TVX96q+dxhzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeDspHEFfhHy5YYyU93KyYZ6U2+yscBNGf+Gg6/o9YJWSFRJBYtUyfgfieDMTZOXAa2mf31wCBt8kiGKF6GIXgWOKUY+eMGA9TmtQFluekAGfE3NBJQqsVYQXA+bKezv3aANdZRXF5i2NauZjRRRH2D7IbdOMKYDm59NI1Of20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arYVBJ/O; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arYVBJ/O"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f5496972d3so30288636d6.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746897448; x=1747502248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x77Lkc1xYwVC68fngeRB5IeFVLyRol+ljq8X90rgzuY=;
        b=arYVBJ/OGBEHmAFbA0bPCzWysQ8n/9uStdHhSDxIP6tsoT8/n9m6n3MQ/rr7It/UD8
         liyrbewFhd9Ai1we+OtvIrrLsBeT3Ddl8lmwbzzp9HrNtY7zmWjB0w2Vq9qk2VhtR4Op
         yYSWIIGb1qocwTaorsu3sQjIX0WtU1VvMB28WvQ77KEyZXd+ZoDUk4J8N3ZJl9T3vDfP
         OILVhmkpf/VRC54kRu6UBkatCu2gqebSDltYRBYWwxnFeXYvn/Jv3NL0yt/bQM7pe9rj
         OA1eJ1C/p3c3wb6+TTznQC5xNXbwHAxfCpqvTkuBofWuM/NVX5f59zq2fBxYezwy314+
         FHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746897448; x=1747502248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x77Lkc1xYwVC68fngeRB5IeFVLyRol+ljq8X90rgzuY=;
        b=FvNVnGCSQlw4ZYEC0vDi8ak02dW2ZAGs/dIYdVbMyDkilcZCRbMFmzitV+v/LL48LF
         b9T7TtG3H6u9GA4RsXdK+6bc8q4wnA/6j9x3TuNQRQckz3jWrMpct4mc9cCGiJgPe1/T
         osSuUQItwAQpy8rrG6TgY/VNqC108X/4m7rwcm5t/2HJVlPc+Nt0HQ9It7ermGKAVuPH
         i/s23ISUyK0+f53Hc7topIU7eT3uPdZwC/UzZhcLZNavG/sU6ZBnbftTqlWPj332jiv0
         cRm8zhizDqZvnCDoeBORca1SoTHcGrqcXnn/SAvJKWSarjvYIKG2TD5IbG9XW7+Dwd8h
         a+9Q==
X-Gm-Message-State: AOJu0YwlxjlPYfr/42QmAxjGeNj8PaAiNY1pyAlh2FOSZf/eJoj4qS1M
	ix4uuccm+R6qrOioSICMWQqilM1C3c1GySIuPvfNvAUmjaJllOncxEAIXw==
X-Gm-Gg: ASbGncvwcZAgcg7MYy0liKScEyPuK+WxLYYj3KJRTVSpsOB6CT9XAxgpAXSdz85kgst
	DyDksZu7GI6CMem+Z/lldDE9IGTO8/p4DfQslLO4K4feay/epR/JK6HM4t5hvkm67hia04SSCvr
	fkCalDsXF530RymI33tsZ6ai1h9zqfs1L4dpHI3Sum5BgjmaZPNwavfrH4UBYFdiNne/EBf8vHT
	DFcD+BtpETuatyt6Y9VJ2FPq/Y/SemE7ADlkA66/KQM3i/dyZ9asn2qTkLaK8DzcrMXH/WcBLeJ
	6rmRURVtqZpiPmk9wqXrVEHdgtW53Q3CI1Q=
X-Google-Smtp-Source: AGHT+IGVP+8xAPQldXdq2nlYr0n45i9r+OaTyAhpbJwvC1Y6WuQXzfgq4PCM/j/JTQRoFXiT0lGAtg==
X-Received: by 2002:a05:6214:202c:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6f6e48407f1mr120274156d6.42.1746897447783;
        Sat, 10 May 2025 10:17:27 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264e:4200::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a600ddsm27608646d6.119.2025.05.10.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 10:17:27 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: j6t@kdbg.org
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] gitk: use makedroplist, not ::combobox
Date: Sat, 10 May 2025 13:17:23 -0400
Message-ID: <20250510171723.32163-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.49.0.99.610
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gitk offers to not use themed tk (ttk), and cannot use such on Tcl/Tk
earlier than 8.5 where ttk was introduced. To facilitate this, widgets
are switched from themed to not by use of the global ${NS}: ${NS} == ttk
to select themed widgets, "" for non-themed. The combobox widget exists
only in ttk, and proc makedroplist exists to create a combobox like
widget using only base tk widgets.

However, 904b36b815 ("gitk: add text wrapping preferences", 2024-12-05),
introduced two instances of ${NS}::combobox, and since that commit,
gitk effectively requires Tk >= 8.5 and themed widgets enabled.

Fix this by using makedropbox instead.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 11ad639..d48982f 100755
--- a/gitk
+++ b/gitk
@@ -11736,12 +11736,12 @@ proc prefspage_general {notebook} {
     grid x $page.tabstopl $page.tabstop -sticky w
 
     ${NS}::label $page.wrapcommentl -text [mc "Wrap comment text"]
-    ${NS}::combobox $page.wrapcomment -values {none char word} -state readonly \
+    makedroplist $page.wrapcomment -values {none char word} -state readonly \
         -textvariable wrapcomment
     grid x $page.wrapcommentl $page.wrapcomment -sticky w
 
     ${NS}::label $page.wrapdefaultl -text [mc "Wrap other text"]
-    ${NS}::combobox $page.wrapdefault -values {none char word} -state readonly \
+    makedroplist $page.wrapdefault -values {none char word} -state readonly \
         -textvariable wrapdefault
     grid x $page.wrapdefaultl $page.wrapdefault -sticky w
 
-- 
2.49.0.99.610

