Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3118C933
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734898057; cv=none; b=buU+pfqbMh92IDseEModHgw+7iTEhe+UzC1HsNWtqeCz8QkCu8l493IlNsji+aXTHqaVvFgpQ/2aq7a2gOYmc+ZBdlnAcDLoUlOMEmPc2OZJKvibvmmht1aJuwiq737LoCHCou86kJpwgTBA0oMGUBMA+EnMerde6yykK2CqJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734898057; c=relaxed/simple;
	bh=jSyEcXU3N3gkedjA58LnGxF1ubEzJ/tFH54+SZdCXNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAg24oyQ9Rq6Sh9qmGPkIiorLszkWEfBppJPKz1+lWEHQEF4V2OdoC4uUU0UXAzjXR1WB+lUmmwX4L0gKvCc+D+EUaGt67LA2wfq4xnk/QI6rwAd5H0E8Q5kO76yf1O1By/AizZdml9V9XAUxXZVSuN2mTi5OLX7R6wQ8FbEVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=dtbDEDZa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="dtbDEDZa"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so527677066b.0
        for <git@vger.kernel.org>; Sun, 22 Dec 2024 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1734898048; x=1735502848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jz4m5VbDu5iXvnk1SPtQk8eoQGPWVIearG58g/0uxR0=;
        b=dtbDEDZaCpZzGaYlnmZ2vaQR4bOJY/GyV4bYD+93zUURSA0nh28ClgomOA1tzoU1F2
         knbJOLDVpWdrQOygUraGgv9lIuf31BeFN8BdBRBFcjoD1QJdV+I2tWsUVU3sPsN+Swj9
         eKuLS/j2J8IVsTtN4Z7GO/Kx+3XGJIlit9fRrDglbiGruPFHG12fdDpaGW5YkQNqhCB+
         ypmbRangCzsvFETBjuTxZilrFIkLeSUVEXYrihFWDYQBJGelx/xF4duFZr/Kg2yOTSAO
         iripsmpbsNePfWqing1ilOOatipuS3iTtEgNViIDWvi0IzaSuOWrGa1hbU1Vd73ULGk8
         ivvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734898048; x=1735502848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jz4m5VbDu5iXvnk1SPtQk8eoQGPWVIearG58g/0uxR0=;
        b=r2CEoXaDJQWT+XFlVamXOvMfmoRtmcGtLeY5ZtWEvogoVbz6R+t1sCn65V1bamuOqK
         sUmtJEuJuAy9bRLhQr0JJjq5c9MvaS/clXQLrjsPvPmIucWZfODOBVlzLYL88quU14ED
         V9dIjTtF5rtpxoKRh9dagPxBC8mtU5xrhMQkwzif11dFBfU5WO4FQlGPkHfcYVsJNzhN
         eB5nFcvzrXYgEK+E1n83ll60kc60l+eXLfpix+/RIOb78yNRXMsB9CgNtxtGZ9E7pFKz
         ZayzFsWATHDtYYn46aogVbK330paxFlTa7Hz0tv7Q8T/Q6cOoFK+J7+nFdybFW+DwRXb
         ttwA==
X-Gm-Message-State: AOJu0YyxX/U3RihQeoDZgVMx2sDUwulnkuU2bozBdeUtrTZBkKeP6yc+
	sdPlnjfonv6BUXmsl0I+jh7ldIe25LiCvc7iyDU/eiEjJMlHrJP6UlVqHoQqTAEGMcnKL2XLz02
	+VGo=
X-Gm-Gg: ASbGncuJIZa2sjlVLvHUfv7bmuRvLnvesSojTcLaLHXpqc6oN/dQaZq7g2/5yYDJlRd
	hCuu59AAb8zignU+8fbi6OtDBqr6sMRcfNrknaS3cr5iFpEoWmq29oBpAF8h2J440+NBtXgU0j6
	SUrkY1spJ7opyKQPkFaTSXn7IxI//My80/E6p6MwpGHMsakDxNpvI5W5tDhKf37o5bm0JsJDC55
	xa7qu5cv6kPtCilaU+LNdUXDhszd73PdtFNIeCbQp8i2uMZTdakfwClCt2fjeRN1Be7BUYBAXuq
	6Qz6
X-Google-Smtp-Source: AGHT+IHjfoRz1Pu025tooqA/2ynu7rPm1LEMmHh5alQCwFHeX4eb3PYvyp9RfcjCPIayPjwcPp+HwA==
X-Received: by 2002:a05:6402:2550:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5d81de06532mr25800437a12.24.1734898045413;
        Sun, 22 Dec 2024 12:07:25 -0800 (PST)
Received: from localhost.localdomain ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aae9a325afbsm208293866b.181.2024.12.22.12.07.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Dec 2024 12:07:23 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	j6t@kdbg.org
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 1/1] git-gui i18n: Updated Bulgarian translation (579t)
Date: Sun, 22 Dec 2024 21:07:03 +0100
Message-ID: <20241222200707.98738-4-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241222200707.98738-3-ash@kambanaria.org>
References: <20241222200707.98738-3-ash@kambanaria.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 3721 +++++++++++++++++++++++++++---------------------------
 1 file changed, 1890 insertions(+), 1831 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 5af78f15a8..27b05038e4 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -1,15 +1,15 @@
 # Bulgarian translation of git-gui po-file.
-# Copyright (C) 2012, 2013, 2014, 2015, 2016 Alexander Shopov <ash@kambanaria.org>.
+# Copyright (C) 2012, 2013, 2014, 2015, 2016, 2024 Alexander Shopov <ash@kambanaria.org>.
 # This file is distributed under the same license as the git package.
-# Alexander Shopov <ash@kambanaria.org>, 2012, 2013, 2014, 2015, 2016.
+# Alexander Shopov <ash@kambanaria.org>, 2012, 2013, 2014, 2015, 2016, 2024.
 #
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: git-gui master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2016-10-13 15:16+0300\n"
-"PO-Revision-Date: 2016-10-13 15:16+0300\n"
+"POT-Creation-Date: 2020-02-08 22:54+0100\n"
+"PO-Revision-Date: 2024-12-22 15:44+0100\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -18,33 +18,33 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=2; plural=(n != 1);\n"
 
-#: git-gui.sh:865
+#: git-gui.sh:847
 #, tcl-format
 msgid "Invalid font specified in %s:"
 msgstr "Указан е неправилен шрифт в „%s“:"
 
-#: git-gui.sh:919
+#: git-gui.sh:901
 msgid "Main Font"
 msgstr "Основен шрифт"
 
-#: git-gui.sh:920
+#: git-gui.sh:902
 msgid "Diff/Console Font"
 msgstr "Шрифт за разликите/конзолата"
 
-#: git-gui.sh:935 git-gui.sh:949 git-gui.sh:962 git-gui.sh:1052 git-gui.sh:1071
-#: git-gui.sh:3147
+#: git-gui.sh:917 git-gui.sh:931 git-gui.sh:944 git-gui.sh:1034 git-gui.sh:1053
+#: git-gui.sh:3212
 msgid "git-gui: fatal error"
 msgstr "git-gui: фатална грешка"
 
-#: git-gui.sh:936
+#: git-gui.sh:918
 msgid "Cannot find git in PATH."
 msgstr "Командата git липсва в пътя (PATH)."
 
-#: git-gui.sh:963
+#: git-gui.sh:945
 msgid "Cannot parse Git version string:"
-msgstr "Низът с версията на Git не може да бъде интерпретиран:"
+msgstr "Низът с версията на Git не може да се анализира:"
 
-#: git-gui.sh:988
+#: git-gui.sh:970
 #, tcl-format
 msgid ""
 "Git version cannot be determined.\n"
@@ -55,7 +55,7 @@ msgid ""
 "\n"
 "Assume '%s' is version 1.5.0?\n"
 msgstr ""
-"Версията на Git не може да бъде определена.\n"
+"Версията на Git не може да се определи.\n"
 "\n"
 "Версията на „%s“ изглежда, че е „%s“.\n"
 "\n"
@@ -63,506 +63,522 @@ msgstr ""
 "\n"
 "Да се приеме ли, че „%s“ е версия „1.5.0“?\n"
 
-#: git-gui.sh:1285
+#: git-gui.sh:1267
 msgid "Git directory not found:"
 msgstr "Директорията на Git не е открита:"
 
-#: git-gui.sh:1319
+#: git-gui.sh:1301
 msgid "Cannot move to top of working directory:"
-msgstr "Не може да се премине към родителската  директория."
+msgstr "Не може да се премине към родителската директория."
 
-#: git-gui.sh:1327
+#: git-gui.sh:1309
 msgid "Cannot use bare repository:"
 msgstr "Голо хранилище не може да се използва:"
 
-#: git-gui.sh:1335
+#: git-gui.sh:1317
 msgid "No working directory"
 msgstr "Работната директория липсва"
 
-#: git-gui.sh:1507 lib/checkout_op.tcl:306
+#: git-gui.sh:1491 lib/checkout_op.tcl:306
 msgid "Refreshing file status..."
 msgstr "Обновяване на състоянието на файла…"
 
-#: git-gui.sh:1567
+#: git-gui.sh:1551
 msgid "Scanning for modified files ..."
 msgstr "Проверка за променени файлове…"
 
-#: git-gui.sh:1645
+#: git-gui.sh:1629
 msgid "Calling prepare-commit-msg hook..."
 msgstr "Куката „prepare-commit-msg“ се изпълнява в момента…"
 
-#: git-gui.sh:1662
+#: git-gui.sh:1646
 msgid "Commit declined by prepare-commit-msg hook."
 msgstr "Подаването е отхвърлено от куката „prepare-commit-msg“."
 
-#: git-gui.sh:1820 lib/browser.tcl:252
+#: git-gui.sh:1804 lib/browser.tcl:252
 msgid "Ready."
 msgstr "Готово."
 
-#: git-gui.sh:1984
+#: git-gui.sh:1968
 #, tcl-format
 msgid ""
 "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files."
 msgstr ""
-"Достигнат е максималният размер на списъка за извеждане(gui."
-"maxfilesdisplayed = %s), съответно не са показани всички %s файла."
+"Достигнат е максималният размер на списъка за "
+"извеждане(gui.maxfilesdisplayed = %s), съответно не са показани всички %s "
+"файла."
 
-#: git-gui.sh:2107
+#: git-gui.sh:2091
 msgid "Unmodified"
 msgstr "Непроменен"
 
-#: git-gui.sh:2109
+#: git-gui.sh:2093
 msgid "Modified, not staged"
 msgstr "Променен, но не е в индекса"
 
-#: git-gui.sh:2110 git-gui.sh:2122
+#: git-gui.sh:2094 git-gui.sh:2106
 msgid "Staged for commit"
 msgstr "В индекса за подаване"
 
-#: git-gui.sh:2111 git-gui.sh:2123
+#: git-gui.sh:2095 git-gui.sh:2107
 msgid "Portions staged for commit"
 msgstr "Части са в индекса за подаване"
 
-#: git-gui.sh:2112 git-gui.sh:2124
+#: git-gui.sh:2096 git-gui.sh:2108
 msgid "Staged for commit, missing"
 msgstr "В индекса за подаване, но липсва"
 
-#: git-gui.sh:2114
+#: git-gui.sh:2098
 msgid "File type changed, not staged"
 msgstr "Видът на файла е сменен, но не е в индекса"
 
-#: git-gui.sh:2115 git-gui.sh:2116
+#: git-gui.sh:2099 git-gui.sh:2100
 msgid "File type changed, old type staged for commit"
 msgstr "Видът на файла е сменен, но новият вид не е в индекса"
 
-#: git-gui.sh:2117
+#: git-gui.sh:2101
 msgid "File type changed, staged"
 msgstr "Видът на файла е сменен и е в индекса"
 
-#: git-gui.sh:2118
+#: git-gui.sh:2102
 msgid "File type change staged, modification not staged"
 msgstr "Видът на файла е сменен в индекса, но не и съдържанието"
 
-#: git-gui.sh:2119
+#: git-gui.sh:2103
 msgid "File type change staged, file missing"
 msgstr "Видът на файла е сменен в индекса, но файлът липсва"
 
-#: git-gui.sh:2121
+#: git-gui.sh:2105
 msgid "Untracked, not staged"
 msgstr "Неследен"
 
-#: git-gui.sh:2126
+#: git-gui.sh:2110
 msgid "Missing"
 msgstr "Липсващ"
 
-#: git-gui.sh:2127
+#: git-gui.sh:2111
 msgid "Staged for removal"
 msgstr "В индекса за изтриване"
 
-#: git-gui.sh:2128
+#: git-gui.sh:2112
 msgid "Staged for removal, still present"
 msgstr "В индекса за изтриване, но още го има"
 
-#: git-gui.sh:2130 git-gui.sh:2131 git-gui.sh:2132 git-gui.sh:2133
-#: git-gui.sh:2134 git-gui.sh:2135
+#: git-gui.sh:2114 git-gui.sh:2115 git-gui.sh:2116 git-gui.sh:2117
+#: git-gui.sh:2118 git-gui.sh:2119
 msgid "Requires merge resolution"
 msgstr "Изисква коригиране при сливане"
 
-#: git-gui.sh:2170
-msgid "Starting gitk... please wait..."
-msgstr "Стартиране на „gitk“…, изчакайте…"
-
-#: git-gui.sh:2182
+#: git-gui.sh:2164
 msgid "Couldn't find gitk in PATH"
 msgstr "Командата „gitk“ липсва в пътищата, определени от променливата PATH."
 
-#: git-gui.sh:2241
+#: git-gui.sh:2210 git-gui.sh:2245
+#, tcl-format
+msgid "Starting %s... please wait..."
+msgstr "Стартиране на „%s“…, изчакайте…"
+
+#: git-gui.sh:2224
 msgid "Couldn't find git gui in PATH"
 msgstr ""
 "Командата „git gui“ липсва в пътищата, определени от променливата PATH."
 
-#: git-gui.sh:2676 lib/choose_repository.tcl:41
+#: git-gui.sh:2726 lib/choose_repository.tcl:53
 msgid "Repository"
 msgstr "Хранилище"
 
-#: git-gui.sh:2677
+#: git-gui.sh:2727
 msgid "Edit"
 msgstr "Редактиране"
 
-#: git-gui.sh:2679 lib/choose_rev.tcl:567
+#: git-gui.sh:2729 lib/choose_rev.tcl:567
 msgid "Branch"
 msgstr "Клон"
 
-#: git-gui.sh:2682 lib/choose_rev.tcl:554
+#: git-gui.sh:2732 lib/choose_rev.tcl:554
 msgid "Commit@@noun"
 msgstr "Подаване"
 
-#: git-gui.sh:2685 lib/merge.tcl:127 lib/merge.tcl:174
+#: git-gui.sh:2735 lib/merge.tcl:127 lib/merge.tcl:174
 msgid "Merge"
 msgstr "Сливане"
 
-#: git-gui.sh:2686 lib/choose_rev.tcl:563
+#: git-gui.sh:2736 lib/choose_rev.tcl:563
 msgid "Remote"
 msgstr "Отдалечено хранилище"
 
-#: git-gui.sh:2689
+#: git-gui.sh:2739
 msgid "Tools"
 msgstr "Команди"
 
-#: git-gui.sh:2698
+#: git-gui.sh:2748
 msgid "Explore Working Copy"
 msgstr "Разглеждане на работното копие"
 
-#: git-gui.sh:2704
+#: git-gui.sh:2763
 msgid "Git Bash"
 msgstr "Bash за Git"
 
-#: git-gui.sh:2714
+#: git-gui.sh:2772
 msgid "Browse Current Branch's Files"
 msgstr "Разглеждане на файловете в текущия клон"
 
-#: git-gui.sh:2718
+#: git-gui.sh:2776
 msgid "Browse Branch Files..."
 msgstr "Разглеждане на текущия клон…"
 
-#: git-gui.sh:2723
+#: git-gui.sh:2781
 msgid "Visualize Current Branch's History"
 msgstr "Визуализация на историята на текущия клон"
 
-#: git-gui.sh:2727
+#: git-gui.sh:2785
 msgid "Visualize All Branch History"
 msgstr "Визуализация на историята на всички клонове"
 
-#: git-gui.sh:2734
+#: git-gui.sh:2792
 #, tcl-format
 msgid "Browse %s's Files"
 msgstr "Разглеждане на файловете в „%s“"
 
-#: git-gui.sh:2736
+#: git-gui.sh:2794
 #, tcl-format
 msgid "Visualize %s's History"
 msgstr "Визуализация на историята на „%s“"
 
-#: git-gui.sh:2741 lib/database.tcl:40
+#: git-gui.sh:2799 lib/database.tcl:40
 msgid "Database Statistics"
 msgstr "Статистика на базата от данни"
 
-#: git-gui.sh:2744 lib/database.tcl:33
+#: git-gui.sh:2802 lib/database.tcl:33
 msgid "Compress Database"
 msgstr "Компресиране на базата от данни"
 
-#: git-gui.sh:2747
+#: git-gui.sh:2805
 msgid "Verify Database"
 msgstr "Проверка на базата от данни"
 
-#: git-gui.sh:2754 git-gui.sh:2758 git-gui.sh:2762
+#: git-gui.sh:2812 git-gui.sh:2816 git-gui.sh:2820
 msgid "Create Desktop Icon"
 msgstr "Добавяне на икона на работния плот"
 
-#: git-gui.sh:2770 lib/choose_repository.tcl:193 lib/choose_repository.tcl:201
+#: git-gui.sh:2828 lib/choose_repository.tcl:209 lib/choose_repository.tcl:217
 msgid "Quit"
 msgstr "Спиране на програмата"
 
-#: git-gui.sh:2778
+#: git-gui.sh:2836
 msgid "Undo"
 msgstr "Отмяна"
 
-#: git-gui.sh:2781
+#: git-gui.sh:2839
 msgid "Redo"
 msgstr "Повторение"
 
-#: git-gui.sh:2785 git-gui.sh:3399
+#: git-gui.sh:2843 git-gui.sh:3461
 msgid "Cut"
 msgstr "Отрязване"
 
-#: git-gui.sh:2788 git-gui.sh:3402 git-gui.sh:3476 git-gui.sh:3562
+#: git-gui.sh:2846 git-gui.sh:3464 git-gui.sh:3540 git-gui.sh:3633
 #: lib/console.tcl:69
 msgid "Copy"
 msgstr "Копиране"
 
-#: git-gui.sh:2791 git-gui.sh:3405
+#: git-gui.sh:2849 git-gui.sh:3467
 msgid "Paste"
 msgstr "Поставяне"
 
-#: git-gui.sh:2794 git-gui.sh:3408 lib/branch_delete.tcl:28
-#: lib/remote_branch_delete.tcl:39
+#: git-gui.sh:2852 git-gui.sh:3470 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
 msgid "Delete"
 msgstr "Изтриване"
 
-#: git-gui.sh:2798 git-gui.sh:3412 git-gui.sh:3566 lib/console.tcl:71
+#: git-gui.sh:2856 git-gui.sh:3474 git-gui.sh:3637 lib/console.tcl:71
 msgid "Select All"
 msgstr "Избиране на всичко"
 
-#: git-gui.sh:2807
+#: git-gui.sh:2865
 msgid "Create..."
 msgstr "Създаване…"
 
-#: git-gui.sh:2813
+#: git-gui.sh:2871
 msgid "Checkout..."
 msgstr "Изтегляне…"
 
-#: git-gui.sh:2819
+#: git-gui.sh:2877
 msgid "Rename..."
 msgstr "Преименуване…"
 
-#: git-gui.sh:2824
+#: git-gui.sh:2882
 msgid "Delete..."
 msgstr "Изтриване…"
 
-#: git-gui.sh:2829
+#: git-gui.sh:2887
 msgid "Reset..."
 msgstr "Отмяна на промените…"
 
-#: git-gui.sh:2839
+#: git-gui.sh:2897
 msgid "Done"
 msgstr "Готово"
 
-#: git-gui.sh:2841
+#: git-gui.sh:2899
 msgid "Commit@@verb"
 msgstr "Подаване"
 
-#: git-gui.sh:2850 git-gui.sh:3335
-msgid "New Commit"
-msgstr "Ново подаване"
-
-#: git-gui.sh:2858 git-gui.sh:3342
+#: git-gui.sh:2908 git-gui.sh:3400
 msgid "Amend Last Commit"
 msgstr "Поправяне на последното подаване"
 
-#: git-gui.sh:2868 git-gui.sh:3296 lib/remote_branch_delete.tcl:101
+#: git-gui.sh:2918 git-gui.sh:3361 lib/remote_branch_delete.tcl:101
 msgid "Rescan"
 msgstr "Обновяване"
 
-#: git-gui.sh:2874
+#: git-gui.sh:2924
 msgid "Stage To Commit"
 msgstr "Към индекса за подаване"
 
-#: git-gui.sh:2880
+#: git-gui.sh:2930
 msgid "Stage Changed Files To Commit"
 msgstr "Всички променени файлове към индекса за подаване"
 
-#: git-gui.sh:2886
+#: git-gui.sh:2936
 msgid "Unstage From Commit"
 msgstr "Изваждане от индекса за подаване"
 
-#: git-gui.sh:2892 lib/index.tcl:442
+#: git-gui.sh:2942 lib/index.tcl:521
 msgid "Revert Changes"
 msgstr "Връщане на оригинала"
 
-#: git-gui.sh:2900 git-gui.sh:3613 git-gui.sh:3644
+#: git-gui.sh:2950 git-gui.sh:3700 git-gui.sh:3731
 msgid "Show Less Context"
 msgstr "По-малко контекст"
 
-#: git-gui.sh:2904 git-gui.sh:3617 git-gui.sh:3648
+#: git-gui.sh:2954 git-gui.sh:3704 git-gui.sh:3735
 msgid "Show More Context"
 msgstr "Повече контекст"
 
-#: git-gui.sh:2911 git-gui.sh:3309 git-gui.sh:3423
+#: git-gui.sh:2961 git-gui.sh:3374 git-gui.sh:3485
 msgid "Sign Off"
 msgstr "Подписване"
 
-#: git-gui.sh:2927
+#: git-gui.sh:2977
 msgid "Local Merge..."
 msgstr "Локално сливане…"
 
-#: git-gui.sh:2932
+#: git-gui.sh:2982
 msgid "Abort Merge..."
 msgstr "Преустановяване на сливане…"
 
-#: git-gui.sh:2944 git-gui.sh:2972
+#: git-gui.sh:2994 git-gui.sh:3022
 msgid "Add..."
 msgstr "Добавяне…"
 
-#: git-gui.sh:2948
+#: git-gui.sh:2998
 msgid "Push..."
 msgstr "Изтласкване…"
 
-#: git-gui.sh:2952
+#: git-gui.sh:3002
 msgid "Delete Branch..."
 msgstr "Изтриване на клон…"
 
-#: git-gui.sh:2962 git-gui.sh:3595
+#: git-gui.sh:3012 git-gui.sh:3666
 msgid "Options..."
 msgstr "Опции…"
 
-#: git-gui.sh:2973
+#: git-gui.sh:3023
 msgid "Remove..."
 msgstr "Премахване…"
 
-#: git-gui.sh:2982 lib/choose_repository.tcl:55
+#: git-gui.sh:3032 lib/choose_repository.tcl:67
 msgid "Help"
 msgstr "Помощ"
 
-#: git-gui.sh:2986 git-gui.sh:2990 lib/about.tcl:14
-#: lib/choose_repository.tcl:49 lib/choose_repository.tcl:58
+#: git-gui.sh:3036 git-gui.sh:3040 lib/choose_repository.tcl:61
+#: lib/choose_repository.tcl:70 lib/about.tcl:14
 #, tcl-format
 msgid "About %s"
-msgstr "Относно %s"
+msgstr "Относно „%s“"
 
-#: git-gui.sh:3014
+#: git-gui.sh:3064
 msgid "Online Documentation"
 msgstr "Документация в Интернет"
 
-#: git-gui.sh:3017 lib/choose_repository.tcl:52 lib/choose_repository.tcl:61
+#: git-gui.sh:3067 lib/choose_repository.tcl:64 lib/choose_repository.tcl:73
 msgid "Show SSH Key"
 msgstr "Показване на ключа за SSH"
 
-#: git-gui.sh:3032 git-gui.sh:3164
+#: git-gui.sh:3097 git-gui.sh:3229
 msgid "usage:"
 msgstr "употреба:"
 
-#: git-gui.sh:3036 git-gui.sh:3168
+#: git-gui.sh:3101 git-gui.sh:3233
 msgid "Usage"
 msgstr "Употреба"
 
-#: git-gui.sh:3117 lib/blame.tcl:573
+#: git-gui.sh:3182 lib/blame.tcl:575
 msgid "Error"
 msgstr "Грешка"
 
-#: git-gui.sh:3148
+#: git-gui.sh:3213
 #, tcl-format
 msgid "fatal: cannot stat path %s: No such file or directory"
-msgstr ""
-"ФАТАЛНА ГРЕШКА: пътят %s не може да бъде открит: такъв файл или директория "
-"няма"
+msgstr "ФАТАЛНА ГРЕШКА: пътят „%s“ липсва: такъв файл или директория няма"
 
-#: git-gui.sh:3181
+#: git-gui.sh:3246
 msgid "Current Branch:"
 msgstr "Текущ клон:"
 
-#: git-gui.sh:3206
+#: git-gui.sh:3271
 msgid "Unstaged Changes"
 msgstr "Промени извън индекса"
 
-#: git-gui.sh:3228
+#: git-gui.sh:3293
 msgid "Staged Changes (Will Commit)"
 msgstr "Промени в индекса (за подаване)"
 
-#: git-gui.sh:3302
+#: git-gui.sh:3367
 msgid "Stage Changed"
 msgstr "Индексът е променен"
 
-#: git-gui.sh:3321 lib/transport.tcl:137
+#: git-gui.sh:3386 lib/transport.tcl:137
 msgid "Push"
 msgstr "Изтласкване"
 
-#: git-gui.sh:3356
+#: git-gui.sh:3413
 msgid "Initial Commit Message:"
 msgstr "Първоначално съобщение при подаване:"
 
-#: git-gui.sh:3357
+#: git-gui.sh:3414
 msgid "Amended Commit Message:"
 msgstr "Поправено съобщение при подаване:"
 
-#: git-gui.sh:3358
+#: git-gui.sh:3415
 msgid "Amended Initial Commit Message:"
 msgstr "Поправено първоначално съобщение при подаване:"
 
-#: git-gui.sh:3359
+#: git-gui.sh:3416
 msgid "Amended Merge Commit Message:"
 msgstr "Поправено съобщение при подаване със сливане:"
 
-#: git-gui.sh:3360
+#: git-gui.sh:3417
 msgid "Merge Commit Message:"
 msgstr "Съобщение при подаване със сливане:"
 
-#: git-gui.sh:3361
+#: git-gui.sh:3418
 msgid "Commit Message:"
 msgstr "Съобщение при подаване:"
 
-#: git-gui.sh:3415 git-gui.sh:3570 lib/console.tcl:73
+#: git-gui.sh:3477 git-gui.sh:3641 lib/console.tcl:73
 msgid "Copy All"
 msgstr "Копиране на всичко"
 
-#: git-gui.sh:3439 lib/blame.tcl:105
+#: git-gui.sh:3501 lib/blame.tcl:106
 msgid "File:"
 msgstr "Файл:"
 
-#: git-gui.sh:3558
+#: git-gui.sh:3549 lib/choose_repository.tcl:1100
+msgid "Open"
+msgstr "Отваряне"
+
+#: git-gui.sh:3629
 msgid "Refresh"
 msgstr "Обновяване"
 
-#: git-gui.sh:3579
+#: git-gui.sh:3650
 msgid "Decrease Font Size"
-msgstr "По-едър шрифт"
+msgstr "По-дребен шрифт"
 
-#: git-gui.sh:3583
+#: git-gui.sh:3654
 msgid "Increase Font Size"
-msgstr "По-дребен шрифт"
+msgstr "По-едър шрифт"
 
-#: git-gui.sh:3591 lib/blame.tcl:294
+#: git-gui.sh:3662 lib/blame.tcl:296
 msgid "Encoding"
 msgstr "Кодиране"
 
-#: git-gui.sh:3602
+#: git-gui.sh:3673
 msgid "Apply/Reverse Hunk"
 msgstr "Прилагане/връщане на парче"
 
-#: git-gui.sh:3607
+#: git-gui.sh:3678
 msgid "Apply/Reverse Line"
 msgstr "Прилагане/връщане на ред"
 
-#: git-gui.sh:3626
+#: git-gui.sh:3684 git-gui.sh:3794 git-gui.sh:3805
+msgid "Revert Hunk"
+msgstr "Връщане на парче"
+
+#: git-gui.sh:3689 git-gui.sh:3801 git-gui.sh:3812
+msgid "Revert Line"
+msgstr "Връщане на ред"
+
+#: git-gui.sh:3694 git-gui.sh:3791
+msgid "Undo Last Revert"
+msgstr "Отмяна на последното връщане"
+
+#: git-gui.sh:3713
 msgid "Run Merge Tool"
 msgstr "Изпълнение на програмата за сливане"
 
-#: git-gui.sh:3631
+#: git-gui.sh:3718
 msgid "Use Remote Version"
 msgstr "Версия от отдалеченото хранилище"
 
-#: git-gui.sh:3635
+#: git-gui.sh:3722
 msgid "Use Local Version"
 msgstr "Локална версия"
 
-#: git-gui.sh:3639
+#: git-gui.sh:3726
 msgid "Revert To Base"
 msgstr "Връщане към родителската версия"
 
-#: git-gui.sh:3657
+#: git-gui.sh:3744
 msgid "Visualize These Changes In The Submodule"
 msgstr "Визуализиране на промените в подмодула"
 
-#: git-gui.sh:3661
+#: git-gui.sh:3748
 msgid "Visualize Current Branch History In The Submodule"
 msgstr "Визуализация на историята на текущия клон в историята за подмодула"
 
-#: git-gui.sh:3665
+#: git-gui.sh:3752
 msgid "Visualize All Branch History In The Submodule"
 msgstr "Визуализация на историята на всички клони в историята за подмодула"
 
-#: git-gui.sh:3670
+#: git-gui.sh:3757
 msgid "Start git gui In The Submodule"
 msgstr "Стартиране на „git gui“ за подмодула"
 
-#: git-gui.sh:3705
+#: git-gui.sh:3793
 msgid "Unstage Hunk From Commit"
 msgstr "Изваждане на парчето от подаването"
 
-#: git-gui.sh:3707
+#: git-gui.sh:3797
 msgid "Unstage Lines From Commit"
 msgstr "Изваждане на редовете от подаването"
 
-#: git-gui.sh:3709
+#: git-gui.sh:3798 git-gui.sh:3809
+msgid "Revert Lines"
+msgstr "Връщане на редовете"
+
+#: git-gui.sh:3800
 msgid "Unstage Line From Commit"
 msgstr "Изваждане на реда от подаването"
 
-#: git-gui.sh:3712
+#: git-gui.sh:3804
 msgid "Stage Hunk For Commit"
 msgstr "Добавяне на парчето за подаване"
 
-#: git-gui.sh:3714
+#: git-gui.sh:3808
 msgid "Stage Lines For Commit"
 msgstr "Добавяне на редовете за подаване"
 
-#: git-gui.sh:3716
+#: git-gui.sh:3811
 msgid "Stage Line For Commit"
 msgstr "Добавяне на реда за подаване"
 
-#: git-gui.sh:3741
+#: git-gui.sh:3861
 msgid "Initializing..."
 msgstr "Инициализиране…"
 
-#: git-gui.sh:3886
+#: git-gui.sh:4017
 #, tcl-format
 msgid ""
 "Possible environment issues exist.\n"
@@ -574,12 +590,12 @@ msgid ""
 msgstr ""
 "Възможно е да има проблем със средата.\n"
 "\n"
-"Най-вероятно следните променливи няма да бъдат\n"
-"взети под внимание от подпроцесите на Git\n"
+"Най-вероятно следните променливи няма да се\n"
+"вземат под внимание от подпроцесите на Git\n"
 "от %s:\n"
 "\n"
 
-#: git-gui.sh:3915
+#: git-gui.sh:4046
 msgid ""
 "\n"
 "This is due to a known issue with the\n"
@@ -589,7 +605,7 @@ msgstr ""
 "Това е познат проблем и се дължи на\n"
 "версията на Tcl включена в Cygwin."
 
-#: git-gui.sh:3920
+#: git-gui.sh:4051
 #, tcl-format
 msgid ""
 "\n"
@@ -605,389 +621,204 @@ msgstr ""
 "е да поставите настройките „user.name“ и\n"
 "„user.email“ в личния си файл „~/.gitconfig“.\n"
 
-#: lib/about.tcl:26
-msgid "git-gui - a graphical user interface for Git."
-msgstr "git-gui — графичен интерфейс за Git."
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Тази програма за проверка на правописа не се поддържа"
 
-#: lib/blame.tcl:73
-#, tcl-format
-msgid "%s (%s): File Viewer"
-msgstr "%s (%s): Преглед на файлове"
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Липсва програма за проверка на правописа"
 
-#: lib/blame.tcl:79
-msgid "Commit:"
-msgstr "Подаване:"
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Неправилни настройки на проверката на правописа"
 
-#: lib/blame.tcl:280
-msgid "Copy Commit"
-msgstr "Копиране на подаване"
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "Ползване на речник за език „%s“."
 
-#: lib/blame.tcl:284
-msgid "Find Text..."
-msgstr "Търсене на текст…"
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "Програмата за правопис даже не стартира успешно."
 
-#: lib/blame.tcl:288
-msgid "Goto Line..."
-msgstr "Към ред…"
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Непозната програма за проверка на правописа"
 
-#: lib/blame.tcl:297
-msgid "Do Full Copy Detection"
-msgstr "Пълно търсене на копиране"
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Няма предложения"
 
-#: lib/blame.tcl:301
-msgid "Show History Context"
-msgstr "Показване на контекста от историята"
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "Неочакван край на файл от програмата за проверка на правописа"
 
-#: lib/blame.tcl:304
-msgid "Blame Parent Commit"
-msgstr "Анотиране на родителското подаване"
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Грешка в програмата за проверка на правописа"
 
-#: lib/blame.tcl:466
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
 #, tcl-format
-msgid "Reading %s..."
-msgstr "Чете се „%s“…"
+msgid "fetch %s"
+msgstr "доставяне на „%s“"
 
-#: lib/blame.tcl:594
-msgid "Loading copy/move tracking annotations..."
-msgstr "Зареждане на анотациите за проследяване на копирането/преместването…"
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Доставяне на промените от „%s“"
 
-#: lib/blame.tcl:614
-msgid "lines annotated"
-msgstr "реда анотирани"
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "окастряне на следящите клони към „%s“"
 
-#: lib/blame.tcl:806
-msgid "Loading original location annotations..."
-msgstr "Зареждане на анотациите за първоначалното местоположение…"
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "Окастряне на следящите клони на изтритите клони от „%s“"
 
-#: lib/blame.tcl:809
-msgid "Annotation complete."
-msgstr "Анотирането завърши."
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "доставяне от всички отдалечени"
 
-#: lib/blame.tcl:839
-msgid "Busy"
-msgstr "Операцията не е завършила"
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "Доставяне на промените от всички отдалечени хранилища"
 
-#: lib/blame.tcl:840
-msgid "Annotation process is already running."
-msgstr "В момента тече процес на анотиране."
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "окастряне на следящите изтрити"
 
-#: lib/blame.tcl:879
-msgid "Running thorough copy detection..."
-msgstr "Изпълнява се цялостен процес на откриване на копиране…"
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr ""
+"Окастряне на следящите клони на изтритите клони от всички отдалечени "
+"хранилища"
 
-#: lib/blame.tcl:947
-msgid "Loading annotation..."
-msgstr "Зареждане на анотации…"
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
+msgstr "изтласкване на „%s“"
 
-#: lib/blame.tcl:1000
-msgid "Author:"
-msgstr "Автор:"
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "Изтласкване на промените към „%s“"
 
-#: lib/blame.tcl:1004
-msgid "Committer:"
-msgstr "Подал:"
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "Изтласкване на всичко към „%s“"
 
-#: lib/blame.tcl:1009
-msgid "Original File:"
-msgstr "Първоначален файл:"
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "Изтласкване на %s „%s“ към „%s“"
 
-#: lib/blame.tcl:1057
-msgid "Cannot find HEAD commit:"
-msgstr "Подаването за връх „HEAD“ не може да се открие:"
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "Клони за изтласкване"
 
-#: lib/blame.tcl:1112
-msgid "Cannot find parent commit:"
-msgstr "Родителското подаване не може да бъде открито"
+#: lib/transport.tcl:141 lib/checkout_op.tcl:580 lib/remote_add.tcl:34
+#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/branch_rename.tcl:32
+#: lib/choose_font.tcl:45 lib/option.tcl:127 lib/tools_dlg.tcl:41
+#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/remote_branch_delete.tcl:43
+#: lib/branch_create.tcl:37 lib/branch_delete.tcl:34 lib/merge.tcl:178
+msgid "Cancel"
+msgstr "Отказване"
 
-#: lib/blame.tcl:1127
-msgid "Unable to display parent"
-msgstr "Родителят не може да бъде показан"
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "Клони-източници"
 
-#: lib/blame.tcl:1128 lib/diff.tcl:358
-msgid "Error loading diff:"
-msgstr "Грешка при зареждане на разлика:"
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "Целево хранилище"
 
-#: lib/blame.tcl:1269
-msgid "Originally By:"
-msgstr "Първоначално от:"
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "Отдалечено хранилище:"
 
-#: lib/blame.tcl:1275
-msgid "In File:"
-msgstr "Във файл:"
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "Произволно местоположение:"
 
-#: lib/blame.tcl:1280
-msgid "Copied Or Moved Here By:"
-msgstr "Копирано или преместено тук от:"
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "Настройки при пренасянето"
 
-#: lib/branch_checkout.tcl:16
-#, tcl-format
-msgid "%s (%s): Checkout Branch"
-msgstr "%s (%s): Клон за изтегляне"
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr ""
+"Изрично презаписване на съществуващ клон (някои промени може да се загубят)"
 
-#: lib/branch_checkout.tcl:21
-msgid "Checkout Branch"
-msgstr "Клон за изтегляне"
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "Максимална компресия (за бавни мрежови връзки)"
 
-#: lib/branch_checkout.tcl:26
-msgid "Checkout"
-msgstr "Изтегляне"
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "Включване на етикетите"
 
-#: lib/branch_checkout.tcl:30 lib/branch_create.tcl:37 lib/branch_delete.tcl:34
-#: lib/branch_rename.tcl:32 lib/browser.tcl:292 lib/checkout_op.tcl:579
-#: lib/choose_font.tcl:45 lib/merge.tcl:178 lib/option.tcl:127
-#: lib/remote_add.tcl:34 lib/remote_branch_delete.tcl:43 lib/tools_dlg.tcl:41
-#: lib/tools_dlg.tcl:202 lib/tools_dlg.tcl:345 lib/transport.tcl:141
-msgid "Cancel"
-msgstr "Отказване"
+#: lib/transport.tcl:229
+#, tcl-format
+msgid "%s (%s): Push"
+msgstr "%s (%s): Изтласкване"
 
-#: lib/branch_checkout.tcl:35 lib/browser.tcl:297 lib/tools_dlg.tcl:321
-msgid "Revision"
-msgstr "Версия"
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "Доставяне на „%s“ от „%s“"
 
-#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:69 lib/option.tcl:310
-msgid "Options"
-msgstr "Опции"
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "фатална грешка: „%s“ не може да се открие"
 
-#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
-msgid "Fetch Tracking Branch"
-msgstr "Изтегляне на промените от следения клон"
+#: lib/checkout_op.tcl:146 lib/sshkey.tcl:58 lib/console.tcl:81
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "Затваряне"
 
-#: lib/branch_checkout.tcl:47
-msgid "Detach From Local Branch"
-msgstr "Изтриване от локалния клон"
+#: lib/checkout_op.tcl:175
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "Клонът „%s“ не съществува."
 
-#: lib/branch_create.tcl:23
+#: lib/checkout_op.tcl:194
 #, tcl-format
-msgid "%s (%s): Create Branch"
-msgstr "%s (%s): Създаване на клон"
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Неуспешно настройване на опростен git-pull за „%s“."
 
-#: lib/branch_create.tcl:28
-msgid "Create New Branch"
-msgstr "Създаване на нов клон"
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "Клонът „%s“ вече съществува."
 
-#: lib/branch_create.tcl:33 lib/choose_repository.tcl:407
-msgid "Create"
-msgstr "Създаване"
+#: lib/checkout_op.tcl:229
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"Клонът „%s“ съществува.\n"
+"\n"
+"Той не може да се слее тривиално до „%s“.\n"
+"Необходимо е сливане."
 
-#: lib/branch_create.tcl:42
-msgid "Branch Name"
-msgstr "Име на клона"
+#: lib/checkout_op.tcl:243
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "Стратегия за сливане „%s“ не се поддържа."
 
-#: lib/branch_create.tcl:44 lib/remote_add.tcl:41 lib/tools_dlg.tcl:51
-msgid "Name:"
-msgstr "Име:"
-
-#: lib/branch_create.tcl:57
-msgid "Match Tracking Branch Name"
-msgstr "Съвпадане по името на следения клон"
-
-#: lib/branch_create.tcl:66
-msgid "Starting Revision"
-msgstr "Начална версия"
-
-#: lib/branch_create.tcl:72
-msgid "Update Existing Branch:"
-msgstr "Обновяване на съществуващ клон:"
-
-#: lib/branch_create.tcl:75
-msgid "No"
-msgstr "Не"
-
-#: lib/branch_create.tcl:80
-msgid "Fast Forward Only"
-msgstr "Само тривиално превъртащо сливане"
-
-#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
-msgid "Reset"
-msgstr "Отначало"
-
-#: lib/branch_create.tcl:97
-msgid "Checkout After Creation"
-msgstr "Преминаване към клона след създаването му"
-
-#: lib/branch_create.tcl:132
-msgid "Please select a tracking branch."
-msgstr "Изберете клон за следени."
-
-#: lib/branch_create.tcl:141
-#, tcl-format
-msgid "Tracking branch %s is not a branch in the remote repository."
-msgstr "Следящият клон — „%s“, не съществува в отдалеченото хранилище."
-
-#: lib/branch_create.tcl:154 lib/branch_rename.tcl:92
-msgid "Please supply a branch name."
-msgstr "Дайте име на клона."
-
-#: lib/branch_create.tcl:165 lib/branch_rename.tcl:112
-#, tcl-format
-msgid "'%s' is not an acceptable branch name."
-msgstr "„%s“ не може да се използва за име на клон."
-
-#: lib/branch_delete.tcl:16
-#, tcl-format
-msgid "%s (%s): Delete Branch"
-msgstr "%s (%s): Изтриване на клон"
-
-#: lib/branch_delete.tcl:21
-msgid "Delete Local Branch"
-msgstr "Изтриване на локален клон"
-
-#: lib/branch_delete.tcl:39
-msgid "Local Branches"
-msgstr "Локални клони"
-
-#: lib/branch_delete.tcl:51
-msgid "Delete Only If Merged Into"
-msgstr "Изтриване, само ако промените са слети и другаде"
-
-#: lib/branch_delete.tcl:53 lib/remote_branch_delete.tcl:120
-msgid "Always (Do not perform merge checks)"
-msgstr "Винаги (без проверка за сливане)"
-
-#: lib/branch_delete.tcl:103
-#, tcl-format
-msgid "The following branches are not completely merged into %s:"
-msgstr "Не всички промени в клоните са слети в „%s“:"
-
-#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:218
-msgid ""
-"Recovering deleted branches is difficult.\n"
-"\n"
-"Delete the selected branches?"
-msgstr ""
-"Възстановяването на изтрити клони може да е трудно.\n"
-"\n"
-"Сигурни ли сте, че искате да триете?"
-
-#: lib/branch_delete.tcl:131
-#, tcl-format
-msgid " - %s:"
-msgstr " — „%s:“"
-
-#: lib/branch_delete.tcl:141
-#, tcl-format
-msgid ""
-"Failed to delete branches:\n"
-"%s"
-msgstr ""
-"Неуспешно триене на клони:\n"
-"%s"
-
-#: lib/branch_rename.tcl:15
-#, tcl-format
-msgid "%s (%s): Rename Branch"
-msgstr "%s (%s): Преименуване на клон"
-
-#: lib/branch_rename.tcl:23
-msgid "Rename Branch"
-msgstr "Преименуване на клон"
-
-#: lib/branch_rename.tcl:28
-msgid "Rename"
-msgstr "Преименуване"
-
-#: lib/branch_rename.tcl:38
-msgid "Branch:"
-msgstr "Клон:"
-
-#: lib/branch_rename.tcl:46
-msgid "New Name:"
-msgstr "Ново име:"
-
-#: lib/branch_rename.tcl:81
-msgid "Please select a branch to rename."
-msgstr "Изберете клон за преименуване."
-
-#: lib/branch_rename.tcl:102 lib/checkout_op.tcl:202
-#, tcl-format
-msgid "Branch '%s' already exists."
-msgstr "Клонът „%s“ вече съществува."
-
-#: lib/branch_rename.tcl:123
-#, tcl-format
-msgid "Failed to rename '%s'."
-msgstr "Неуспешно преименуване на „%s“."
-
-#: lib/browser.tcl:17
-msgid "Starting..."
-msgstr "Стартиране…"
-
-#: lib/browser.tcl:27
-#, tcl-format
-msgid "%s (%s): File Browser"
-msgstr "%s (%s): Файлов браузър"
-
-#: lib/browser.tcl:132 lib/browser.tcl:149
-#, tcl-format
-msgid "Loading %s..."
-msgstr "Зареждане на „%s“…"
-
-#: lib/browser.tcl:193
-msgid "[Up To Parent]"
-msgstr "[Към родителя]"
-
-#: lib/browser.tcl:275
-#, tcl-format
-msgid "%s (%s): Browse Branch Files"
-msgstr "%s (%s): Разглеждане на файловете в клона"
-
-#: lib/browser.tcl:282
-msgid "Browse Branch Files"
-msgstr "Разглеждане на файловете в клона"
-
-#: lib/browser.tcl:288 lib/choose_repository.tcl:422
-#: lib/choose_repository.tcl:509 lib/choose_repository.tcl:518
-#: lib/choose_repository.tcl:1074
-msgid "Browse"
-msgstr "Разглеждане"
-
-#: lib/checkout_op.tcl:85
-#, tcl-format
-msgid "Fetching %s from %s"
-msgstr "Доставяне на „%s“ от „%s“"
-
-#: lib/checkout_op.tcl:133
-#, tcl-format
-msgid "fatal: Cannot resolve %s"
-msgstr "фатална грешка: „%s“ не може да се открие"
-
-#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:30
-#: lib/sshkey.tcl:55
-msgid "Close"
-msgstr "Затваряне"
-
-#: lib/checkout_op.tcl:175
-#, tcl-format
-msgid "Branch '%s' does not exist."
-msgstr "Клонът „%s“ не съществува."
-
-#: lib/checkout_op.tcl:194
-#, tcl-format
-msgid "Failed to configure simplified git-pull for '%s'."
-msgstr "Неуспешно настройване на опростен git-pull за „%s“."
-
-#: lib/checkout_op.tcl:229
-#, tcl-format
-msgid ""
-"Branch '%s' already exists.\n"
-"\n"
-"It cannot fast-forward to %s.\n"
-"A merge is required."
-msgstr ""
-"Клонът „%s“ съществува.\n"
-"\n"
-"Той не може да бъде тривиално слят до „%s“.\n"
-"Необходимо е сливане."
-
-#: lib/checkout_op.tcl:243
-#, tcl-format
-msgid "Merge strategy '%s' not supported."
-msgstr "Стратегия за сливане  „%s“ не се поддържа."
-
-#: lib/checkout_op.tcl:262
-#, tcl-format
-msgid "Failed to update '%s'."
-msgstr "Неуспешно обновяване на „%s“."
+#: lib/checkout_op.tcl:262
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Неуспешно обновяване на „%s“."
 
 #: lib/checkout_op.tcl:274
 msgid "Staging area (index) is already locked."
@@ -1006,7 +837,7 @@ msgstr ""
 "хранилището.\n"
 "\n"
 "Някой друг процес за Git е променил хранилището междувременно. Състоянието "
-"трябва да бъде проверено, преди да се премине към нов клон.\n"
+"трябва да се провери, преди да се премине към нов клон.\n"
 "\n"
 "Автоматично ще започне нова проверка.\n"
 
@@ -1019,22 +850,22 @@ msgstr "Работната директория се привежда към „
 msgid "files checked out"
 msgstr "файла са изтеглени"
 
-#: lib/checkout_op.tcl:376
+#: lib/checkout_op.tcl:377
 #, tcl-format
 msgid "Aborted checkout of '%s' (file level merging is required)."
 msgstr ""
 "Преустановяване на изтеглянето на „%s“ (необходимо е пофайлово сливане)."
 
-#: lib/checkout_op.tcl:377
+#: lib/checkout_op.tcl:378
 msgid "File level merge required."
 msgstr "Необходимо е пофайлово сливане."
 
-#: lib/checkout_op.tcl:381
+#: lib/checkout_op.tcl:382
 #, tcl-format
 msgid "Staying on branch '%s'."
 msgstr "Оставане върху клона „%s“."
 
-#: lib/checkout_op.tcl:452
+#: lib/checkout_op.tcl:453
 msgid ""
 "You are no longer on a local branch.\n"
 "\n"
@@ -1045,31 +876,35 @@ msgstr ""
 "\n"
 "Ако искате да сте на клон, създайте базиран на „Това несвързано изтегляне“."
 
-#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
+#: lib/checkout_op.tcl:504 lib/checkout_op.tcl:508
 #, tcl-format
 msgid "Checked out '%s'."
 msgstr "„%s“ е изтеглен."
 
-#: lib/checkout_op.tcl:535
+#: lib/checkout_op.tcl:536
 #, tcl-format
 msgid "Resetting '%s' to '%s' will lose the following commits:"
 msgstr ""
 "Зануляването на „%s“ към „%s“ ще доведе до загубването на следните подавания:"
 
-#: lib/checkout_op.tcl:557
+#: lib/checkout_op.tcl:558
 msgid "Recovering lost commits may not be easy."
 msgstr "Възстановяването на загубените подавания може да е трудно."
 
-#: lib/checkout_op.tcl:562
+#: lib/checkout_op.tcl:563
 #, tcl-format
 msgid "Reset '%s'?"
 msgstr "Зануляване на „%s“?"
 
-#: lib/checkout_op.tcl:567 lib/merge.tcl:170 lib/tools_dlg.tcl:336
+#: lib/checkout_op.tcl:568 lib/tools_dlg.tcl:336 lib/merge.tcl:170
 msgid "Visualize"
 msgstr "Визуализация"
 
-#: lib/checkout_op.tcl:635
+#: lib/checkout_op.tcl:572 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "Отначало"
+
+#: lib/checkout_op.tcl:636
 #, tcl-format
 msgid ""
 "Failed to set current branch.\n"
@@ -1087,1721 +922,1945 @@ msgstr ""
 "Това състояние е аварийно и не трябва да се случва. Програмата „%s“ ще "
 "преустанови работа."
 
-#: lib/choose_font.tcl:41
-msgid "Select"
-msgstr "Избор"
+#: lib/remote_add.tcl:20
+#, tcl-format
+msgid "%s (%s): Add Remote"
+msgstr "%s (%s): Добавяне на отдалечено хранилище"
 
-#: lib/choose_font.tcl:55
-msgid "Font Family"
-msgstr "Шрифт"
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "Добавяне на отдалечено хранилище"
 
-#: lib/choose_font.tcl:76
-msgid "Font Size"
-msgstr "Размер"
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "Добавяне"
 
-#: lib/choose_font.tcl:93
-msgid "Font Example"
-msgstr "Мостра"
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "Данни за отдалеченото хранилище"
 
-#: lib/choose_font.tcl:105
-msgid ""
-"This is example text.\n"
-"If you like this text, it can be your font."
-msgstr ""
-"Това е примерен текст.\n"
-"Ако ви харесва как изглежда, изберете шрифта."
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "Име:"
 
-#: lib/choose_repository.tcl:33
-msgid "Git Gui"
-msgstr "ГПИ на Git"
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Местоположение:"
 
-#: lib/choose_repository.tcl:92 lib/choose_repository.tcl:412
-msgid "Create New Repository"
-msgstr "Създаване на ново хранилище"
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "Следващо действие"
 
-#: lib/choose_repository.tcl:98
-msgid "New..."
-msgstr "Ново…"
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "Незабавно доставяне"
 
-#: lib/choose_repository.tcl:105 lib/choose_repository.tcl:496
-msgid "Clone Existing Repository"
-msgstr "Клониране на съществуващо хранилище"
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "Инициализиране на отдалеченото хранилище и изтласкване на промените"
 
-#: lib/choose_repository.tcl:116
-msgid "Clone..."
-msgstr "Клониране…"
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "Да не се прави нищо"
 
-#: lib/choose_repository.tcl:123 lib/choose_repository.tcl:1064
-msgid "Open Existing Repository"
-msgstr "Отваряне на съществуващо хранилище"
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "Задайте име за отдалеченото хранилище."
 
-#: lib/choose_repository.tcl:129
-msgid "Open..."
-msgstr "Отваряне…"
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "Отдалечено хранилище не може да се казва „%s“."
 
-#: lib/choose_repository.tcl:142
-msgid "Recent Repositories"
-msgstr "Скоро ползвани"
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Неуспешно добавяне на отдалеченото хранилище „%s“ от адрес „%s“."
 
-#: lib/choose_repository.tcl:148
-msgid "Open Recent Repository:"
-msgstr "Отваряне на хранилище ползвано наскоро:"
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "Доставяне на „%s“"
 
-#: lib/choose_repository.tcl:316 lib/choose_repository.tcl:323
-#: lib/choose_repository.tcl:330
+#: lib/remote_add.tcl:156
 #, tcl-format
-msgid "Failed to create repository %s:"
-msgstr "Неуспешно създаване на хранилището „%s“:"
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "Хранилището с местоположение „%s“ не може да се инициализира."
 
-#: lib/choose_repository.tcl:417
-msgid "Directory:"
-msgstr "Директория:"
+#: lib/remote_add.tcl:163
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "Добавяне на хранилище „%s“ (с адрес „%s“)"
 
-#: lib/choose_repository.tcl:447 lib/choose_repository.tcl:573
-#: lib/choose_repository.tcl:1098
-msgid "Git Repository"
-msgstr "Хранилище на Git"
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "Стартиране…"
 
-#: lib/choose_repository.tcl:472
+#: lib/browser.tcl:27
 #, tcl-format
-msgid "Directory %s already exists."
-msgstr "Вече съществува директория „%s“."
+msgid "%s (%s): File Browser"
+msgstr "%s (%s): Файлов браузър"
 
-#: lib/choose_repository.tcl:476
+#: lib/browser.tcl:132 lib/browser.tcl:149
 #, tcl-format
-msgid "File %s already exists."
-msgstr "Вече съществува файл „%s“."
+msgid "Loading %s..."
+msgstr "Зареждане на „%s“…"
 
-#: lib/choose_repository.tcl:491
-msgid "Clone"
-msgstr "Клониране"
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[Към родителя]"
 
-#: lib/choose_repository.tcl:504
-msgid "Source Location:"
-msgstr "Адрес на източника:"
+#: lib/browser.tcl:275
+#, tcl-format
+msgid "%s (%s): Browse Branch Files"
+msgstr "%s (%s): Разглеждане на файловете в клона"
 
-#: lib/choose_repository.tcl:513
-msgid "Target Directory:"
-msgstr "Целева директория:"
+#: lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "Разглеждане на файловете в клона"
 
-#: lib/choose_repository.tcl:523
-msgid "Clone Type:"
-msgstr "Вид клониране:"
+#: lib/browser.tcl:288 lib/choose_repository.tcl:437
+#: lib/choose_repository.tcl:524 lib/choose_repository.tcl:533
+#: lib/choose_repository.tcl:1115
+msgid "Browse"
+msgstr "Разглеждане"
 
-#: lib/choose_repository.tcl:528
-msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
-msgstr "Стандартно (бързо, частично споделяне на файлове, твърди връзки)"
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:321
+msgid "Revision"
+msgstr "Версия"
 
-#: lib/choose_repository.tcl:533
-msgid "Full Copy (Slower, Redundant Backup)"
-msgstr "Пълно (бавно, пълноценно резервно копие)"
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "Индексът не може да се отключи."
 
-#: lib/choose_repository.tcl:538
-msgid "Shared (Fastest, Not Recommended, No Backup)"
-msgstr "Споделено (най-бързо, не се препоръчва, не прави резервно копие)"
+#: lib/index.tcl:30
+msgid "Index Error"
+msgstr "Грешка в индекса"
 
-#: lib/choose_repository.tcl:545
-msgid "Recursively clone submodules too"
-msgstr "Рекурсивно клониране и на подмодулите"
+#: lib/index.tcl:32
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically started to "
+"resynchronize git-gui."
+msgstr ""
+"Неуспешно обновяване на индекса на Git. Автоматично ще започне нова проверка "
+"за синхронизирането на git-gui."
 
-#: lib/choose_repository.tcl:579 lib/choose_repository.tcl:626
-#: lib/choose_repository.tcl:772 lib/choose_repository.tcl:842
-#: lib/choose_repository.tcl:1104 lib/choose_repository.tcl:1112
-#, tcl-format
-msgid "Not a Git repository: %s"
-msgstr "Това не е хранилище на Git: %s"
+#: lib/index.tcl:43
+msgid "Continue"
+msgstr "Продължаване"
 
-#: lib/choose_repository.tcl:615
-msgid "Standard only available for local repository."
-msgstr "Само локални хранилища могат да се клонират стандартно"
+#: lib/index.tcl:46
+msgid "Unlock Index"
+msgstr "Отключване на индекса"
 
-#: lib/choose_repository.tcl:619
-msgid "Shared only available for local repository."
-msgstr "Само локални хранилища могат да се клонират споделено"
+#: lib/index.tcl:77 lib/index.tcl:146 lib/index.tcl:220 lib/index.tcl:587
+#: lib/choose_repository.tcl:999
+msgid "files"
+msgstr "файлове"
 
-#: lib/choose_repository.tcl:640
-#, tcl-format
-msgid "Location %s already exists."
-msgstr "Местоположението „%s“ вече съществува."
+#: lib/index.tcl:326
+msgid "Unstaging selected files from commit"
+msgstr "Изваждане на избраните файлове от подаването"
 
-#: lib/choose_repository.tcl:651
-msgid "Failed to configure origin"
-msgstr "Неуспешно настройване на хранилището-източник"
+#: lib/index.tcl:330
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "Изваждане на „%s“ от подаването"
 
-#: lib/choose_repository.tcl:663
-msgid "Counting objects"
-msgstr "Преброяване на обекти"
+#: lib/index.tcl:369
+msgid "Ready to commit."
+msgstr "Готовност за подаване."
 
-#: lib/choose_repository.tcl:664
-msgid "buckets"
-msgstr "клетки"
+#: lib/index.tcl:378
+msgid "Adding selected files"
+msgstr "Добавяне на избраните файлове"
 
-#: lib/choose_repository.tcl:688
+#: lib/index.tcl:382
 #, tcl-format
-msgid "Unable to copy objects/info/alternates: %s"
-msgstr "Обектите/информацията/синонимите не могат да бъдат копирани: %s"
+msgid "Adding %s"
+msgstr "Добавяне на „%s“"
 
-#: lib/choose_repository.tcl:724
+#: lib/index.tcl:412
 #, tcl-format
-msgid "Nothing to clone from %s."
-msgstr "Няма какво да се клонира от „%s“."
+msgid "Stage %d untracked files?"
+msgstr "Да се добавят ли %d неследени файла към индекса?"
 
-#: lib/choose_repository.tcl:726 lib/choose_repository.tcl:940
-#: lib/choose_repository.tcl:952
-msgid "The 'master' branch has not been initialized."
-msgstr "Основният клон — „master“ не е инициализиран."
+#: lib/index.tcl:420
+msgid "Adding all changed files"
+msgstr "Добавяне на всички променени файлове"
 
-#: lib/choose_repository.tcl:739
-msgid "Hardlinks are unavailable.  Falling back to copying."
-msgstr "Не се поддържат твърди връзки. Преминава се към копиране."
+#: lib/index.tcl:503
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Да се махнат ли промените във файла „%s“?"
 
-#: lib/choose_repository.tcl:751
+#: lib/index.tcl:508
 #, tcl-format
-msgid "Cloning from %s"
-msgstr "Клониране на „%s“"
+msgid "Revert changes in these %i files?"
+msgstr "Да се махнат ли промените в тези %i файла?"
 
-#: lib/choose_repository.tcl:782
-msgid "Copying objects"
-msgstr "Копиране на обекти"
+#: lib/index.tcl:517
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"Всички промени, които не са били добавени в индекса, ще се загубят "
+"безвъзвратно."
 
-#: lib/choose_repository.tcl:783
-msgid "KiB"
-msgstr "KiB"
+#: lib/index.tcl:520 lib/index.tcl:563
+msgid "Do Nothing"
+msgstr "Нищо да не се прави"
 
-#: lib/choose_repository.tcl:807
+#: lib/index.tcl:545
 #, tcl-format
-msgid "Unable to copy object: %s"
-msgstr "Неуспешно копиране на обект: %s"
-
-#: lib/choose_repository.tcl:817
-msgid "Linking objects"
-msgstr "Създаване на връзки към обектите"
-
-#: lib/choose_repository.tcl:818
-msgid "objects"
-msgstr "обекти"
+msgid "Delete untracked file %s?"
+msgstr "Да се изтрие ли неследеният файл „%s“?"
 
-#: lib/choose_repository.tcl:826
+#: lib/index.tcl:550
 #, tcl-format
-msgid "Unable to hardlink object: %s"
-msgstr "Неуспешно създаване на твърда връзка към обект: %s"
+msgid "Delete these %i untracked files?"
+msgstr "Да се изтрият ли тези %d неследени файла?"
 
-#: lib/choose_repository.tcl:881
-msgid "Cannot fetch branches and objects.  See console output for details."
-msgstr ""
-"Клоните и обектите не могат да бъдат изтеглени. За повече информация "
-"погледнете изхода на конзолата."
+#: lib/index.tcl:560
+msgid "Files will be permanently deleted."
+msgstr "Файловете ще се изтрият окончателно."
 
-#: lib/choose_repository.tcl:892
-msgid "Cannot fetch tags.  See console output for details."
-msgstr ""
-"Етикетите не могат да бъдат изтеглени. За повече информация погледнете "
-"изхода на конзолата."
+#: lib/index.tcl:564
+msgid "Delete Files"
+msgstr "Изтриване на файлове"
 
-#: lib/choose_repository.tcl:916
-msgid "Cannot determine HEAD.  See console output for details."
-msgstr ""
-"Върхът „HEAD“ не може да бъде определен. За повече информация погледнете "
-"изхода на конзолата."
+#: lib/index.tcl:586
+msgid "Deleting"
+msgstr "Изтриване"
 
-#: lib/choose_repository.tcl:925
+#: lib/index.tcl:665
+msgid "Encountered errors deleting files:\n"
+msgstr "Грешки при изтриване на файловете:\n"
+
+#: lib/index.tcl:674
 #, tcl-format
-msgid "Unable to cleanup %s"
-msgstr "„%s“ не може да се зачисти"
+msgid "None of the %d selected files could be deleted."
+msgstr "Никой от избраните %d файла не бе изтрит."
 
-#: lib/choose_repository.tcl:931
-msgid "Clone failed."
-msgstr "Неуспешно клониране."
+#: lib/index.tcl:679
+#, tcl-format
+msgid "%d of the %d selected files could not be deleted."
+msgstr "%d от избраните %d файла не бяха изтрити."
 
-#: lib/choose_repository.tcl:938
-msgid "No default branch obtained."
-msgstr "Не е получен клон по подразбиране."
+#: lib/index.tcl:726
+msgid "Reverting selected files"
+msgstr "Махане на промените в избраните файлове"
 
-#: lib/choose_repository.tcl:949
+#: lib/index.tcl:730
 #, tcl-format
-msgid "Cannot resolve %s as a commit."
-msgstr "Няма подаване отговарящо на „%s“."
-
-#: lib/choose_repository.tcl:961
-msgid "Creating working directory"
-msgstr "Създаване на работната директория"
+msgid "Reverting %s"
+msgstr "Махане на промените в „%s“"
 
-#: lib/choose_repository.tcl:962 lib/index.tcl:70 lib/index.tcl:136
-#: lib/index.tcl:207
-msgid "files"
-msgstr "файлове"
+#: lib/branch_checkout.tcl:16
+#, tcl-format
+msgid "%s (%s): Checkout Branch"
+msgstr "%s (%s): Клон за изтегляне"
 
-#: lib/choose_repository.tcl:981
-msgid "Cannot clone submodules."
-msgstr "Подмодулите не могат да се клонират."
+#: lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "Клон за изтегляне"
 
-#: lib/choose_repository.tcl:990
-msgid "Cloning submodules"
-msgstr "Клониране на подмодули"
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "Изтегляне"
 
-#: lib/choose_repository.tcl:1015
-msgid "Initial file checkout failed."
-msgstr "Неуспешно първоначално изтегляне."
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl:69
+msgid "Options"
+msgstr "Опции"
 
-#: lib/choose_repository.tcl:1059
-msgid "Open"
-msgstr "Отваряне"
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Изтегляне на промените от следения клон"
 
-#: lib/choose_repository.tcl:1069
-msgid "Repository:"
-msgstr "Хранилище:"
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "Изтриване от локалния клон"
 
-#: lib/choose_repository.tcl:1118
+#: lib/status_bar.tcl:263
 #, tcl-format
-msgid "Failed to open repository %s:"
-msgstr "Неуспешно отваряне на хранилището „%s“:"
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s… %*i от общо %*i %s (%3i%%)"
 
-#: lib/choose_rev.tcl:52
-msgid "This Detached Checkout"
-msgstr "Това несвързано изтегляне"
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "Изтласкване към"
 
-#: lib/choose_rev.tcl:60
-msgid "Revision Expression:"
-msgstr "Израз за версия:"
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "Премахване на отдалечено хранилище"
 
-#: lib/choose_rev.tcl:72
-msgid "Local Branch"
-msgstr "Локален клон"
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "Окастряне от"
 
-#: lib/choose_rev.tcl:77
-msgid "Tracking Branch"
-msgstr "Следящ клон"
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "Доставяне от"
 
-#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
-msgid "Tag"
-msgstr "Етикет"
+#: lib/remote.tcl:249 lib/remote.tcl:253 lib/remote.tcl:258 lib/remote.tcl:264
+msgid "All"
+msgstr "Всички"
 
-#: lib/choose_rev.tcl:321
+#: lib/branch_rename.tcl:15
 #, tcl-format
-msgid "Invalid revision: %s"
-msgstr "Неправилна версия: %s"
-
-#: lib/choose_rev.tcl:342
-msgid "No revision selected."
-msgstr "Не е избрана версия."
+msgid "%s (%s): Rename Branch"
+msgstr "%s (%s): Преименуване на клон"
 
-#: lib/choose_rev.tcl:350
-msgid "Revision expression is empty."
-msgstr "Изразът за версия е празен."
+#: lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "Преименуване на клон"
 
-#: lib/choose_rev.tcl:537
-msgid "Updated"
-msgstr "Обновен"
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "Преименуване"
 
-#: lib/choose_rev.tcl:565
-msgid "URL"
-msgstr "Адрес"
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "Клон:"
 
-#: lib/commit.tcl:9
-msgid ""
-"There is nothing to amend.\n"
-"\n"
-"You are about to create the initial commit.  There is no commit before this "
-"to amend.\n"
-msgstr ""
-"Няма какво да се поправи.\n"
-"\n"
-"Ще създадете първоначалното подаване. Преди него няма други подавания, които "
-"да поправите.\n"
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "Ново име:"
 
-#: lib/commit.tcl:18
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "Изберете клон за преименуване."
+
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "Дайте име на клона."
+
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "„%s“ не може да се използва за име на клон."
+
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Неуспешно преименуване на „%s“."
+
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "Избор"
+
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "Шрифт"
+
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "Размер"
+
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "Мостра"
+
+#: lib/choose_font.tcl:105
 msgid ""
-"Cannot amend while merging.\n"
-"\n"
-"You are currently in the middle of a merge that has not been fully "
-"completed.  You cannot amend the prior commit unless you first abort the "
-"current merge activity.\n"
+"This is example text.\n"
+"If you like this text, it can be your font."
 msgstr ""
-"По време на сливане не може да поправяте.\n"
-"\n"
-"В момента все още не сте завършили операция по сливане. Не може да поправите "
-"предишното подаване, освен ако първо не преустановите текущото сливане.\n"
+"Това е примерен текст.\n"
+"Ако ви харесва как изглежда, изберете шрифта."
 
-#: lib/commit.tcl:48
-msgid "Error loading commit data for amend:"
-msgstr "Грешка при зареждане на данните от подаване, които да се поправят:"
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Неправилно глобално кодиране „%s“"
 
-#: lib/commit.tcl:75
-msgid "Unable to obtain your identity:"
-msgstr "Идентификацията ви не може да бъде определена:"
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Неправилно кодиране „%s“ на хранилището"
 
-#: lib/commit.tcl:80
-msgid "Invalid GIT_COMMITTER_IDENT:"
-msgstr "Неправилно поле „GIT_COMMITTER_IDENT“:"
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "Стандартни настройки"
 
-#: lib/commit.tcl:129
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "Запазване"
+
+#: lib/option.tcl:133
 #, tcl-format
-msgid "warning: Tcl does not support encoding '%s'."
-msgstr "предупреждение: Tcl не поддържа кодирането „%s“."
+msgid "%s Repository"
+msgstr "Хранилище „%s“"
 
-#: lib/commit.tcl:149
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before another commit can be created.\n"
-"\n"
-"The rescan will be automatically started now.\n"
-msgstr ""
-"Състоянието при последната проверка не отговаря на състоянието на "
-"хранилището.\n"
-"\n"
-"Някой друг процес за Git е променил хранилището междувременно. Състоянието "
-"трябва да бъде проверено преди ново подаване.\n"
-"\n"
-"Автоматично ще започне нова проверка.\n"
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "Глобално (за всички хранилища)"
+
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "Потребителско име"
+
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "Адрес на е-поща"
+
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "Обобщаване на подаванията при сливане"
+
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "Подробности при сливанията"
+
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "Извеждане на статистика след сливанията"
+
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "Използване на програма за сливане"
+
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "Доверие във времето на промяна на файловете"
+
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Окастряне на следящите клонове при доставяне"
+
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "Напасване на следящите клонове"
+
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Използване на „textconv“ за разликите и анотирането"
+
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "Анотиране на копието само по променените файлове"
+
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Максимален брой на списъка „Скоро ползвани“ хранилища"
+
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "Минимален брой знаци за анотиране на копието"
+
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "Исторически обхват за анотиране в дни"
+
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "Брой редове за контекста на разликите"
+
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
+msgstr "Аргументи към командата за разликите"
+
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "Широчина на текста на съобщението при подаване"
+
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "Шаблон за името на новите клони"
+
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "Кодиране на файловете"
+
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
+msgstr "Предупреждаване при подаване към несвързан указател"
 
-#: lib/commit.tcl:173
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
+msgstr "Добавяне на неследените файлове към индекса"
+
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr "Показване на неследените файлове"
+
+#: lib/option.tcl:164
+msgid "Tab spacing"
+msgstr "Ширина на табулацията"
+
+#: lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220 lib/option.tcl:282
+#: lib/database.tcl:57
 #, tcl-format
-msgid ""
-"Unmerged files cannot be committed.\n"
-"\n"
-"File %s has merge conflicts.  You must resolve them and stage the file "
-"before committing.\n"
-msgstr ""
-"Неслетите файлове не могат да бъдат подавани.\n"
-"\n"
-"Във файла „%s“ има конфликти при сливане. За да го подадете, трябва първо да "
-"коригирате конфликтите и да добавите файла към индекса за подаване.\n"
+msgid "%s:"
+msgstr "%s:"
+
+#: lib/option.tcl:210
+msgid "Change"
+msgstr "Смяна"
+
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
+msgstr "Правописен речник:"
+
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr "Смяна на шрифта"
 
-#: lib/commit.tcl:181
+#: lib/option.tcl:288
 #, tcl-format
-msgid ""
-"Unknown file state %s detected.\n"
-"\n"
-"File %s cannot be committed by this program.\n"
-msgstr ""
-"Непознато състояние на файл „%s“.\n"
-"\n"
-"Файлът „%s“ не може да бъде подаден чрез текущата програма.\n"
+msgid "Choose %s"
+msgstr "Избор на „%s“"
 
-#: lib/commit.tcl:189
-msgid ""
-"No changes to commit.\n"
-"\n"
-"You must stage at least 1 file before you can commit.\n"
-msgstr ""
-"Няма промени за подаване.\n"
-"\n"
-"Трябва да добавите поне един файл към индекса, за да подадете.\n"
+#: lib/option.tcl:294
+msgid "pt."
+msgstr "тчк."
+
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr "Настройки"
+
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr "Неуспешно запазване на настройките:"
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Стандартното"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Системното (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Друго"
+
+#: lib/tools.tcl:76
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "За изпълнението на „%s“ трябва да изберете файл."
+
+#: lib/tools.tcl:92
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "Сигурни ли сте, че искате да изпълните „%1$s“ върху файла „%2$s“?"
+
+#: lib/tools.tcl:96
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Сигурни ли сте, че искате да изпълните „%s“?"
+
+#: lib/tools.tcl:118
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Команда: %s"
+
+#: lib/tools.tcl:119
+#, tcl-format
+msgid "Running: %s"
+msgstr "Изпълнение: %s"
+
+#: lib/tools.tcl:158
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "Командата завърши успешно: %s"
+
+#: lib/tools.tcl:160
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "Командата върна грешка: %s"
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "Да се използва базовата версия"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "Да се използва версията от този клон"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "Да се използва версията от другия клон"
 
-#: lib/commit.tcl:204
+#: lib/mergetool.tcl:14
+#, tcl-format
 msgid ""
-"Please supply a commit message.\n"
+"Note that the diff shows only conflicting changes.\n"
 "\n"
-"A good commit message has the following format:\n"
+"%s will be overwritten.\n"
 "\n"
-"- First line: Describe in one sentence what you did.\n"
-"- Second line: Blank\n"
-"- Remaining lines: Describe why this change is good.\n"
+"This operation can be undone only by restarting the merge."
 msgstr ""
-"Задайте добро съобщение при подаване.\n"
+"Разликата показва само разликите с конфликт.\n"
 "\n"
-"Използвайте следния формат:\n"
+"Файлът „%s“ ще се презапише.\n"
 "\n"
-"● Първи ред: описание в едно изречение на промяната.\n"
-"● Втори ред: празен.\n"
-"● Останалите редове: опишете защо се налага тази промяна.\n"
-
-#: lib/commit.tcl:235
-msgid "Calling pre-commit hook..."
-msgstr "Изпълняване на куката преди подаване…"
-
-#: lib/commit.tcl:250
-msgid "Commit declined by pre-commit hook."
-msgstr "Подаването е отхвърлено от куката преди подаване."
+"Тази операция може да се отмени само чрез започване на сливането наново."
 
-#: lib/commit.tcl:269
-msgid ""
-"You are about to commit on a detached head. This is a potentially dangerous "
-"thing to do because if you switch to another branch you will lose your "
-"changes and it can be difficult to retrieve them later from the reflog. You "
-"should probably cancel this commit and create a new branch to continue.\n"
-" \n"
-" Do you really want to proceed with your Commit?"
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
 msgstr ""
-"Ще подадете към несвързан, отделѐн указател „HEAD“. Това е опасно, защото "
-"при преминаването към клон ще загубите промените си, като единственият начин "
-"да ги върнете ще е чрез журнала на указателите (reflog). Най-вероятно трябва "
-"да не правите това подаване, а да създадете нов клон, преди да продължите.\n"
-" \n"
-"Сигурни ли сте, че искате да извършите текущото подаване?"
+"Изглежда, че все още има некоригирани конфликти във файла „%s“. Да се добави "
+"ли файлът към индекса?"
 
-#: lib/commit.tcl:290
-msgid "Calling commit-msg hook..."
-msgstr "Изпълняване на куката за съобщението при подаване…"
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "Добавяне на корекция на конфликтите в „%s“"
 
-#: lib/commit.tcl:305
-msgid "Commit declined by commit-msg hook."
-msgstr "Подаването е отхвърлено от куката за съобщението при подаване."
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr ""
+"Конфликтите при символни връзки или изтриване не може да се коригират с "
+"външна програма."
 
-#: lib/commit.tcl:318
-msgid "Committing changes..."
-msgstr "Подаване на промените…"
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "Файлът, в който е конфликтът, не съществува"
 
-#: lib/commit.tcl:334
-msgid "write-tree failed:"
-msgstr "неуспешно запазване на дървото (write-tree):"
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "Това не е графична програма за сливане: „%s“"
 
-#: lib/commit.tcl:335 lib/commit.tcl:382 lib/commit.tcl:403
-msgid "Commit failed."
-msgstr "Неуспешно подаване."
+#: lib/mergetool.tcl:275
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Неподдържана програма за сливане: „%s“"
+
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
+msgstr "Програмата за сливане вече е стартирана. Да се изключи ли?"
 
-#: lib/commit.tcl:352
+#: lib/mergetool.tcl:330
 #, tcl-format
-msgid "Commit %s appears to be corrupt"
-msgstr "Подаването „%s“ изглежда повредено"
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Грешка при изтеглянето на версии:\n"
+"%s"
 
-#: lib/commit.tcl:357
+#: lib/mergetool.tcl:350
+#, tcl-format
 msgid ""
-"No changes to commit.\n"
-"\n"
-"No files were modified by this commit and it was not a merge commit.\n"
+"Could not start the merge tool:\n"
 "\n"
-"A rescan will be automatically started now.\n"
+"%s"
 msgstr ""
-"Няма промени за подаване.\n"
+"Програмата за сливане не може да се стартира:\n"
 "\n"
-"В това подаване не са променяни никакви файлове, а и не е подаване със "
-"сливане.\n"
-"\n"
-"Автоматично ще започне нова проверка.\n"
-
-#: lib/commit.tcl:364
-msgid "No changes to commit."
-msgstr "Няма промени за подаване."
+"%s"
 
-#: lib/commit.tcl:381
-msgid "commit-tree failed:"
-msgstr "неуспешно подаване на дървото (commit-tree):"
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
+msgstr "Стартиране на програмата за сливане…"
 
-#: lib/commit.tcl:402
-msgid "update-ref failed:"
-msgstr "неуспешно обновяване на указателите (update-ref):"
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
+msgstr "Грешка в програмата за сливане."
 
-#: lib/commit.tcl:495
+#: lib/tools_dlg.tcl:22
 #, tcl-format
-msgid "Created commit %s: %s"
-msgstr "Успешно подаване %s: %s"
+msgid "%s (%s): Add Tool"
+msgstr "%s (%s): Добавяне на команда"
 
-#: lib/console.tcl:59
-msgid "Working... please wait..."
-msgstr "В момента се извършва действие, изчакайте…"
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Добавяне на команда"
 
-#: lib/console.tcl:186
-msgid "Success"
-msgstr "Успех"
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "Глобално добавяне"
 
-#: lib/console.tcl:200
-msgid "Error: Command Failed"
-msgstr "Грешка: неуспешно изпълнение на команда"
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "Подробности за командата"
 
-#: lib/database.tcl:42
-msgid "Number of loose objects"
-msgstr "Брой непакетирани обекти"
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "За създаване на подменюта използвайте знака „/“ за разделител:"
 
-#: lib/database.tcl:43
-msgid "Disk space used by loose objects"
-msgstr "Дисково пространство заето от непакетирани обекти"
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "Команда:"
 
-#: lib/database.tcl:44
-msgid "Number of packed objects"
-msgstr "Брой пакетирани обекти"
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "Преди изпълнение да се извежда диалогов прозорец"
 
-#: lib/database.tcl:45
-msgid "Number of packs"
-msgstr "Брой пакети"
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Потребителят да укаже версия (задаване на променливата $REVISION)"
 
-#: lib/database.tcl:46
-msgid "Disk space used by packed objects"
-msgstr "Дисково пространство заето от пакетирани обекти"
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr ""
+"Потребителят да укаже допълнителни аргументи (задаване на променливата $ARGS)"
 
-#: lib/database.tcl:47
-msgid "Packed objects waiting for pruning"
-msgstr "Пакетирани обекти за окастряне"
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "Без показване на прозорец с изхода от командата"
 
-#: lib/database.tcl:48
-msgid "Garbage files"
-msgstr "Файлове за боклука"
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr ""
+"Стартиране само след избор на разлика (променливата $FILENAME не е празна)"
 
-#: lib/database.tcl:57 lib/option.tcl:182 lib/option.tcl:197 lib/option.tcl:220
-#: lib/option.tcl:282
-#, tcl-format
-msgid "%s:"
-msgstr "%s:"
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "Задайте име за командата."
 
-#: lib/database.tcl:66
+#: lib/tools_dlg.tcl:126
 #, tcl-format
-msgid "%s (%s): Database Statistics"
-msgstr "%s (%s): Статистика на базата от данни"
-
-#: lib/database.tcl:72
-msgid "Compressing the object database"
-msgstr "Компресиране на базата с данни за обектите"
-
-#: lib/database.tcl:83
-msgid "Verifying the object database with fsck-objects"
-msgstr "Проверка на базата с данни за обектите с програмата „fsck-objects“"
+msgid "Tool '%s' already exists."
+msgstr "Командата „%s“ вече съществува."
 
-#: lib/database.tcl:107
+#: lib/tools_dlg.tcl:148
 #, tcl-format
 msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you compress "
-"the database.\n"
-"\n"
-"Compress the database now?"
+"Could not add tool:\n"
+"%s"
 msgstr ""
-"В това хранилище в момента има към %i непакетирани обекти.\n"
-"\n"
-"За добра производителност се препоръчва да компресирате базата с данни за "
-"обектите.\n"
-"\n"
-"Да се започне ли компресирането?"
+"Командата не може да се добави:\n"
+"%s"
 
-#: lib/date.tcl:25
+#: lib/tools_dlg.tcl:187
 #, tcl-format
-msgid "Invalid date from Git: %s"
-msgstr "Неправилни данни от Git: %s"
+msgid "%s (%s): Remove Tool"
+msgstr "%s (%s): Премахване на команда"
 
-#: lib/diff.tcl:77
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "Премахване на команди"
+
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "Премахване"
+
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(командите към локалното хранилище са обозначени в синьо)"
+
+#: lib/tools_dlg.tcl:283
 #, tcl-format
-msgid ""
-"No differences detected.\n"
-"\n"
-"%s has no changes.\n"
-"\n"
-"The modification date of this file was updated by another application, but "
-"the content within the file was not changed.\n"
-"\n"
-"A rescan will be automatically started to find other files which may have "
-"the same state."
-msgstr ""
-"Не са открити разлики.\n"
-"\n"
-"Няма промени в „%s“.\n"
-"\n"
-"Времето на промяна на файла е бил зададен от друга програма, но съдържанието "
-"му не е променено.\n"
-"\n"
-"Автоматично ще започне нова проверка дали няма други файлове в това "
-"състояние."
+msgid "%s (%s):"
+msgstr "%s (%s):"
 
-#: lib/diff.tcl:117
+#: lib/tools_dlg.tcl:292
 #, tcl-format
-msgid "Loading diff of %s..."
-msgstr "Зареждане на разликите в „%s“…"
+msgid "Run Command: %s"
+msgstr "Изпълнение на командата „%s“"
 
-#: lib/diff.tcl:143
-msgid ""
-"LOCAL: deleted\n"
-"REMOTE:\n"
-msgstr ""
-"ЛОКАЛНО: изтрит\n"
-"ОТДАЛЕЧЕНО:\n"
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "Аргументи"
 
-#: lib/diff.tcl:148
-msgid ""
-"REMOTE: deleted\n"
-"LOCAL:\n"
-msgstr ""
-"ОТДАЛЕЧЕНО: изтрит\n"
-"ЛОКАЛНО:\n"
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "Добре"
+
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "Търсене:"
+
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "Следваща поява"
+
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "Предишна поява"
+
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "РегИзр"
+
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "Главни/Малки"
+
+#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#, tcl-format
+msgid "%s (%s): Create Desktop Icon"
+msgstr "%s (%s): Добавяне на икона на работния плот"
 
-#: lib/diff.tcl:155
-msgid "LOCAL:\n"
-msgstr "ЛОКАЛНО:\n"
+#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
+msgid "Cannot write shortcut:"
+msgstr "Клавишната комбинация не може да се запази:"
 
-#: lib/diff.tcl:158
-msgid "REMOTE:\n"
-msgstr "ОТДАЛЕЧЕНО:\n"
+#: lib/shortcut.tcl:140
+msgid "Cannot write icon:"
+msgstr "Иконата не може да се запази:"
 
-#: lib/diff.tcl:220 lib/diff.tcl:357
+#: lib/remote_branch_delete.tcl:29
 #, tcl-format
-msgid "Unable to display %s"
-msgstr "Файлът „%s“ не може да бъде показан"
+msgid "%s (%s): Delete Branch Remotely"
+msgstr "%s (%s): Изтриване на отдалечения клон"
 
-#: lib/diff.tcl:221
-msgid "Error loading file:"
-msgstr "Грешка при зареждане на файл:"
+#: lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Изтриване на отдалечения клон"
 
-#: lib/diff.tcl:227
-msgid "Git Repository (subproject)"
-msgstr "Хранилище на Git (подмодул)"
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
+msgstr "От хранилище"
 
-#: lib/diff.tcl:239
-msgid "* Binary file (not showing content)."
-msgstr "● Двоичен файл (съдържанието не се показва)."
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
+msgstr "Клони"
 
-#: lib/diff.tcl:244
-#, tcl-format
-msgid ""
-"* Untracked file is %d bytes.\n"
-"* Showing only first %d bytes.\n"
-msgstr ""
-"● Неследеният файл е %d байта.\n"
-"● Показват се само първите %d байта.\n"
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
+msgstr "Изтриване, само ако"
 
-#: lib/diff.tcl:250
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
+msgstr "Слят в:"
+
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "Винаги (без проверка за сливане)"
+
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
+msgstr "За данните „Слят в“ е необходимо да зададете клон."
+
+#: lib/remote_branch_delete.tcl:185
 #, tcl-format
 msgid ""
+"The following branches are not completely merged into %s:\n"
 "\n"
-"* Untracked file clipped here by %s.\n"
-"* To see the entire file, use an external editor.\n"
+" - %s"
 msgstr ""
+"Следните клони не са слети напълно в „%s“:\n"
 "\n"
-"● Неследеният файл е отрязан дотук от програмата „%s“.\n"
-"● Използвайте външен редактор, за да видите целия файл.\n"
-
-#: lib/diff.tcl:580
-msgid "Failed to unstage selected hunk."
-msgstr "Избраното парче не може да бъде извадено от индекса."
-
-#: lib/diff.tcl:587
-msgid "Failed to stage selected hunk."
-msgstr "Избраното парче не може да бъде добавено към индекса."
+" ● %s"
 
-#: lib/diff.tcl:666
-msgid "Failed to unstage selected line."
-msgstr "Избраният ред не може да бъде изваден от индекса."
+#: lib/remote_branch_delete.tcl:190
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched the "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Поне една от пробите за сливане е неуспешна, защото не сте доставили всички "
+"необходими подавания. Пробвайте първо да доставите подаванията от „%s“."
 
-#: lib/diff.tcl:674
-msgid "Failed to stage selected line."
-msgstr "Избраният ред не може да бъде добавен към индекса."
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
+msgstr "Изберете поне един клон за изтриване."
 
-#: lib/encoding.tcl:443
-msgid "Default"
-msgstr "Стандартното"
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Възстановяването на изтрити клони може да е трудно.\n"
+"\n"
+"Сигурни ли сте, че искате да триете?"
 
-#: lib/encoding.tcl:448
+#: lib/remote_branch_delete.tcl:227
 #, tcl-format
-msgid "System (%s)"
-msgstr "Системното (%s)"
-
-#: lib/encoding.tcl:459 lib/encoding.tcl:465
-msgid "Other"
-msgstr "Друго"
+msgid "Deleting branches from %s"
+msgstr "Изтриване на клони от „%s“"
 
-#: lib/error.tcl:20
-#, tcl-format
-msgid "%s: error"
-msgstr "%s: грешка"
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
+msgstr "Не е избрано хранилище."
 
-#: lib/error.tcl:36
+#: lib/remote_branch_delete.tcl:305
 #, tcl-format
-msgid "%s: warning"
-msgstr "%s: предупреждение"
+msgid "Scanning %s..."
+msgstr "Претърсване на „%s“…"
 
-#: lib/error.tcl:80
-#, tcl-format
-msgid "%s hook failed:"
-msgstr "%s: грешка от куката"
+#: lib/choose_repository.tcl:45
+msgid "Git Gui"
+msgstr "ГПИ на Git"
 
-#: lib/error.tcl:96
-msgid "You must correct the above errors before committing."
-msgstr "Преди да можете да подадете, коригирайте горните грешки."
+#: lib/choose_repository.tcl:104 lib/choose_repository.tcl:427
+msgid "Create New Repository"
+msgstr "Създаване на ново хранилище"
 
-#: lib/error.tcl:116
-#, tcl-format
-msgid "%s (%s): error"
-msgstr "%s (%s): грешка"
+#: lib/choose_repository.tcl:110
+msgid "New..."
+msgstr "Ново…"
 
-#: lib/index.tcl:6
-msgid "Unable to unlock the index."
-msgstr "Индексът не може да бъде отключен."
+#: lib/choose_repository.tcl:117 lib/choose_repository.tcl:511
+msgid "Clone Existing Repository"
+msgstr "Клониране на съществуващо хранилище"
 
-#: lib/index.tcl:17
-msgid "Index Error"
-msgstr "Грешка в индекса"
+#: lib/choose_repository.tcl:128
+msgid "Clone..."
+msgstr "Клониране…"
 
-#: lib/index.tcl:19
-msgid ""
-"Updating the Git index failed.  A rescan will be automatically started to "
-"resynchronize git-gui."
-msgstr ""
-"Неуспешно обновяване на индекса на Git. Автоматично ще започне нова проверка "
-"за синхронизирането на git-gui."
+#: lib/choose_repository.tcl:135 lib/choose_repository.tcl:1105
+msgid "Open Existing Repository"
+msgstr "Отваряне на съществуващо хранилище"
 
-#: lib/index.tcl:30
-msgid "Continue"
-msgstr "Продължаване"
+#: lib/choose_repository.tcl:141
+msgid "Open..."
+msgstr "Отваряне…"
 
-#: lib/index.tcl:33
-msgid "Unlock Index"
-msgstr "Отключване на индекса"
+#: lib/choose_repository.tcl:154
+msgid "Recent Repositories"
+msgstr "Скоро ползвани"
 
-#: lib/index.tcl:294
-msgid "Unstaging selected files from commit"
-msgstr "Изваждане на избраните файлове от подаването"
+#: lib/choose_repository.tcl:164
+msgid "Open Recent Repository:"
+msgstr "Отваряне на хранилище ползвано наскоро:"
 
-#: lib/index.tcl:298
+#: lib/choose_repository.tcl:331 lib/choose_repository.tcl:338
+#: lib/choose_repository.tcl:345
 #, tcl-format
-msgid "Unstaging %s from commit"
-msgstr "Изваждане на „%s“ от подаването"
+msgid "Failed to create repository %s:"
+msgstr "Неуспешно създаване на хранилището „%s“:"
 
-#: lib/index.tcl:337
-msgid "Ready to commit."
-msgstr "Готовност за подаване."
+#: lib/choose_repository.tcl:422 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "Създаване"
 
-#: lib/index.tcl:346
-msgid "Adding selected files"
-msgstr "Добавяне на избраните файлове"
+#: lib/choose_repository.tcl:432
+msgid "Directory:"
+msgstr "Директория:"
+
+#: lib/choose_repository.tcl:462 lib/choose_repository.tcl:588
+#: lib/choose_repository.tcl:1139
+msgid "Git Repository"
+msgstr "Хранилище на Git"
 
-#: lib/index.tcl:350
+#: lib/choose_repository.tcl:487
 #, tcl-format
-msgid "Adding %s"
-msgstr "Добавяне на „%s“"
+msgid "Directory %s already exists."
+msgstr "Вече съществува директория „%s“."
 
-#: lib/index.tcl:380
+#: lib/choose_repository.tcl:491
 #, tcl-format
-msgid "Stage %d untracked files?"
-msgstr "Да се добавят ли %d неследени файла към индекса?"
+msgid "File %s already exists."
+msgstr "Вече съществува файл „%s“."
 
-#: lib/index.tcl:388
-msgid "Adding all changed files"
-msgstr "Добавяне на всички променени файлове"
+#: lib/choose_repository.tcl:506
+msgid "Clone"
+msgstr "Клониране"
 
-#: lib/index.tcl:428
-#, tcl-format
-msgid "Revert changes in file %s?"
-msgstr "Да се махнат ли промените във файла „%s“?"
+#: lib/choose_repository.tcl:519
+msgid "Source Location:"
+msgstr "Адрес на източника:"
 
-#: lib/index.tcl:430
-#, tcl-format
-msgid "Revert changes in these %i files?"
-msgstr "Да се махнат ли промените в тези %i файла?"
+#: lib/choose_repository.tcl:528
+msgid "Target Directory:"
+msgstr "Целева директория:"
 
-#: lib/index.tcl:438
-msgid "Any unstaged changes will be permanently lost by the revert."
-msgstr ""
-"Всички промени, които не са били вкарани в индекса, ще бъдат безвъзвратно "
-"загубени."
+#: lib/choose_repository.tcl:538
+msgid "Clone Type:"
+msgstr "Вид клониране:"
 
-#: lib/index.tcl:441
-msgid "Do Nothing"
-msgstr "Нищо да не се прави"
+#: lib/choose_repository.tcl:543
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Стандартно (бързо, частично споделяне на файлове, твърди връзки)"
 
-#: lib/index.tcl:459
-msgid "Reverting selected files"
-msgstr "Махане на промените в избраните файлове"
+#: lib/choose_repository.tcl:548
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "Пълно (бавно, пълноценно резервно копие)"
 
-#: lib/index.tcl:463
-#, tcl-format
-msgid "Reverting %s"
-msgstr "Махане на промените в „%s“"
+#: lib/choose_repository.tcl:553
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Споделено (най-бързо, не се препоръчва, не прави резервно копие)"
 
-#: lib/line.tcl:17
-msgid "Goto Line:"
-msgstr "Към ред:"
+#: lib/choose_repository.tcl:560
+msgid "Recursively clone submodules too"
+msgstr "Рекурсивно клониране и на подмодулите"
 
-#: lib/line.tcl:23
-msgid "Go"
-msgstr "Придвижване"
+#: lib/choose_repository.tcl:594 lib/choose_repository.tcl:641
+#: lib/choose_repository.tcl:790 lib/choose_repository.tcl:864
+#: lib/choose_repository.tcl:1145 lib/choose_repository.tcl:1153
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "Това не е хранилище на Git: %s"
 
-#: lib/merge.tcl:13
-msgid ""
-"Cannot merge while amending.\n"
-"\n"
-"You must finish amending this commit before starting any type of merge.\n"
-msgstr ""
-"По време на поправяне не може да сливане.\n"
-"\n"
-"Трябва да завършите поправянето на текущото подаване, преди да започнете "
-"сливане.\n"
+#: lib/choose_repository.tcl:630
+msgid "Standard only available for local repository."
+msgstr "Само локални хранилища може да се клонират стандартно"
 
-#: lib/merge.tcl:27
-msgid ""
-"Last scanned state does not match repository state.\n"
-"\n"
-"Another Git program has modified this repository since the last scan.  A "
-"rescan must be performed before a merge can be performed.\n"
-"\n"
-"The rescan will be automatically started now.\n"
-msgstr ""
-"Последно установеното състояние не отговаря на това в хранилището.\n"
-"\n"
-"Някой друг процес за Git е променил хранилището междувременно. Състоянието "
-"трябва да бъде проверено, преди да се извърши сливане.\n"
-"\n"
-"Автоматично ще започне нова проверка.\n"
-"\n"
+#: lib/choose_repository.tcl:634
+msgid "Shared only available for local repository."
+msgstr "Само локални хранилища може да се клонират споделено"
 
-#: lib/merge.tcl:45
+#: lib/choose_repository.tcl:655
 #, tcl-format
-msgid ""
-"You are in the middle of a conflicted merge.\n"
-"\n"
-"File %s has merge conflicts.\n"
-"\n"
-"You must resolve them, stage the file, and commit to complete the current "
-"merge.  Only then can you begin another merge.\n"
-msgstr ""
-"В момента тече сливане, но има конфликти.\n"
-"\n"
-"Погледнете файла „%s“.\n"
-"\n"
-"Трябва да коригирате конфликтите в него, да го добавите към индекса и да "
-"завършите текущото сливане чрез подаване. Чак тогава може да започнете ново "
-"сливане.\n"
+msgid "Location %s already exists."
+msgstr "Местоположението „%s“ вече съществува."
 
-#: lib/merge.tcl:55
-#, tcl-format
-msgid ""
-"You are in the middle of a change.\n"
-"\n"
-"File %s is modified.\n"
-"\n"
-"You should complete the current commit before starting a merge.  Doing so "
-"will help you abort a failed merge, should the need arise.\n"
-msgstr ""
-"В момента тече подаване.\n"
-"\n"
-"Файлът „%s“ е променен.\n"
-"\n"
-"Трябва да завършите текущото подаване, преди да започнете сливане. Така ще "
-"можете лесно да преустановите сливането, ако възникне нужда.\n"
+#: lib/choose_repository.tcl:666
+msgid "Failed to configure origin"
+msgstr "Неуспешно настройване на хранилището-източник"
 
-#: lib/merge.tcl:108
+#: lib/choose_repository.tcl:678
+msgid "Counting objects"
+msgstr "Преброяване на обекти"
+
+#: lib/choose_repository.tcl:679
+msgid "buckets"
+msgstr "клетки"
+
+#: lib/choose_repository.tcl:703
 #, tcl-format
-msgid "%s of %s"
-msgstr "%s от общо %s"
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "Обектите/Информацията/Синонимите не може да се копират: %s"
 
-#: lib/merge.tcl:126
+#: lib/choose_repository.tcl:740
 #, tcl-format
-msgid "Merging %s and %s..."
-msgstr "Сливане на „%s“ и „%s“…"
+msgid "Nothing to clone from %s."
+msgstr "Няма какво да се клонира от „%s“."
 
-#: lib/merge.tcl:137
-msgid "Merge completed successfully."
-msgstr "Сливането завърши успешно."
+#: lib/choose_repository.tcl:742 lib/choose_repository.tcl:962
+#: lib/choose_repository.tcl:974
+msgid "The 'master' branch has not been initialized."
+msgstr "Основният клон — „master“ не е инициализиран."
 
-#: lib/merge.tcl:139
-msgid "Merge failed.  Conflict resolution is required."
-msgstr "Неуспешно сливане — има конфликти за коригиране."
+#: lib/choose_repository.tcl:755
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Не се поддържат твърди връзки. Преминава се към копиране."
 
-#: lib/merge.tcl:156
+#: lib/choose_repository.tcl:769
 #, tcl-format
-msgid "%s (%s): Merge"
-msgstr "%s (%s): Сливане"
+msgid "Cloning from %s"
+msgstr "Клониране на „%s“"
 
-#: lib/merge.tcl:164
+#: lib/choose_repository.tcl:800
+msgid "Copying objects"
+msgstr "Копиране на обекти"
+
+#: lib/choose_repository.tcl:801
+msgid "KiB"
+msgstr "KiB"
+
+#: lib/choose_repository.tcl:825
 #, tcl-format
-msgid "Merge Into %s"
-msgstr "Сливане в „%s“"
+msgid "Unable to copy object: %s"
+msgstr "Неуспешно копиране на обект: %s"
 
-#: lib/merge.tcl:183
-msgid "Revision To Merge"
-msgstr "Версия за сливане"
+#: lib/choose_repository.tcl:837
+msgid "Linking objects"
+msgstr "Създаване на връзки към обектите"
 
-#: lib/merge.tcl:218
-msgid ""
-"Cannot abort while amending.\n"
-"\n"
-"You must finish amending this commit.\n"
+#: lib/choose_repository.tcl:838
+msgid "objects"
+msgstr "обекти"
+
+#: lib/choose_repository.tcl:846
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "Неуспешно създаване на твърда връзка към обект: %s"
+
+#: lib/choose_repository.tcl:903
+msgid "Cannot fetch branches and objects.  See console output for details."
 msgstr ""
-"Поправянето не може да бъде преустановено.\n"
-"\n"
-"Трябва да завършите поправката на това подаване.\n"
+"Клоните и обектите не може да се изтеглят. За повече информация погледнете "
+"изхода на конзолата."
 
-#: lib/merge.tcl:228
-msgid ""
-"Abort merge?\n"
-"\n"
-"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with aborting the current merge?"
+#: lib/choose_repository.tcl:914
+msgid "Cannot fetch tags.  See console output for details."
 msgstr ""
-"Да се преустанови ли сливането?\n"
-"\n"
-"В такъв случай ●ВСИЧКИ● неподадени промени ще бъдат безвъзвратно загубени.\n"
-"\n"
-"Наистина ли да се преустанови сливането?"
+"Етикетите не може да се изтеглят. За повече информация погледнете изхода на "
+"конзолата."
 
-#: lib/merge.tcl:234
-msgid ""
-"Reset changes?\n"
-"\n"
-"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
-"\n"
-"Continue with resetting the current changes?"
+#: lib/choose_repository.tcl:938
+msgid "Cannot determine HEAD.  See console output for details."
 msgstr ""
-"Да се занулят ли промените?\n"
-"\n"
-"В такъв случай ●ВСИЧКИ● неподадени промени ще бъдат безвъзвратно загубени.\n"
-"\n"
-"Наистина ли да се занулят промените?"
+"Върхът „HEAD“ не може да се определи. За повече информация погледнете изхода "
+"на конзолата."
 
-#: lib/merge.tcl:245
-msgid "Aborting"
-msgstr "Преустановяване"
+#: lib/choose_repository.tcl:947
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "„%s“ не може да се изчисти"
 
-#: lib/merge.tcl:245
-msgid "files reset"
-msgstr "файла със занулени промени"
+#: lib/choose_repository.tcl:953
+msgid "Clone failed."
+msgstr "Неуспешно клониране."
 
-#: lib/merge.tcl:273
-msgid "Abort failed."
-msgstr "Неуспешно преустановяване."
+#: lib/choose_repository.tcl:960
+msgid "No default branch obtained."
+msgstr "Не е получен клон по подразбиране."
 
-#: lib/merge.tcl:275
-msgid "Abort completed.  Ready."
-msgstr "Успешно преустановяване. Готовност за следващо действие."
+#: lib/choose_repository.tcl:971
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "Няма подаване отговарящо на „%s“."
 
-#: lib/mergetool.tcl:8
-msgid "Force resolution to the base version?"
-msgstr "Да се използва базовата версия"
+#: lib/choose_repository.tcl:998
+msgid "Creating working directory"
+msgstr "Създаване на работната директория"
 
-#: lib/mergetool.tcl:9
-msgid "Force resolution to this branch?"
-msgstr "Да се използва версията от този клон"
+#: lib/choose_repository.tcl:1028
+msgid "Initial file checkout failed."
+msgstr "Неуспешно първоначално изтегляне."
 
-#: lib/mergetool.tcl:10
-msgid "Force resolution to the other branch?"
-msgstr "Да се използва версията от другия клон"
+#: lib/choose_repository.tcl:1072
+msgid "Cloning submodules"
+msgstr "Клониране на подмодули"
 
-#: lib/mergetool.tcl:14
-#, tcl-format
-msgid ""
-"Note that the diff shows only conflicting changes.\n"
-"\n"
-"%s will be overwritten.\n"
-"\n"
-"This operation can be undone only by restarting the merge."
-msgstr ""
-"Разликата показва само разликите с конфликт.\n"
-"\n"
-"Файлът „%s“ ще бъде презаписан.\n"
-"\n"
-"Тази операция може да бъде отменена само чрез започване на сливането наново."
+#: lib/choose_repository.tcl:1087
+msgid "Cannot clone submodules."
+msgstr "Подмодулите не може да се клонират."
 
-#: lib/mergetool.tcl:45
+#: lib/choose_repository.tcl:1110
+msgid "Repository:"
+msgstr "Хранилище:"
+
+#: lib/choose_repository.tcl:1159
 #, tcl-format
-msgid "File %s seems to have unresolved conflicts, still stage?"
-msgstr ""
-"Изглежда, че все още има некоригирани конфликти във файла „%s“. Да се добави "
-"ли файлът към индекса?"
+msgid "Failed to open repository %s:"
+msgstr "Неуспешно отваряне на хранилището „%s“:"
 
-#: lib/mergetool.tcl:60
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui — графичен интерфейс за Git."
+
+#: lib/blame.tcl:74
 #, tcl-format
-msgid "Adding resolution for %s"
-msgstr "Добавяне на корекция на конфликтите в „%s“"
+msgid "%s (%s): File Viewer"
+msgstr "%s (%s): Преглед на файлове"
 
-#: lib/mergetool.tcl:141
-msgid "Cannot resolve deletion or link conflicts using a tool"
-msgstr ""
-"Конфликтите при символни връзки или изтриване не могат да бъдат коригирани с "
-"външна програма."
+#: lib/blame.tcl:80
+msgid "Commit:"
+msgstr "Подаване:"
 
-#: lib/mergetool.tcl:146
-msgid "Conflict file does not exist"
-msgstr "Файлът, в който е конфликтът, не съществува"
+#: lib/blame.tcl:282
+msgid "Copy Commit"
+msgstr "Копиране на подаване"
 
-#: lib/mergetool.tcl:246
-#, tcl-format
-msgid "Not a GUI merge tool: '%s'"
-msgstr "Това не е графична програма за сливане: „%s“"
+#: lib/blame.tcl:286
+msgid "Find Text..."
+msgstr "Търсене на текст…"
 
-#: lib/mergetool.tcl:275
-#, tcl-format
-msgid "Unsupported merge tool '%s'"
-msgstr "Неподдържана програма за сливане: „%s“"
+#: lib/blame.tcl:290
+msgid "Goto Line..."
+msgstr "Към ред…"
 
-#: lib/mergetool.tcl:310
-msgid "Merge tool is already running, terminate it?"
-msgstr "Програмата за сливане вече е стартирана. Да бъде ли изключена?"
+#: lib/blame.tcl:299
+msgid "Do Full Copy Detection"
+msgstr "Пълно търсене на копиране"
 
-#: lib/mergetool.tcl:330
-#, tcl-format
-msgid ""
-"Error retrieving versions:\n"
-"%s"
-msgstr ""
-"Грешка при изтеглянето на версии:\n"
-"%s"
+#: lib/blame.tcl:303
+msgid "Show History Context"
+msgstr "Показване на контекста от историята"
 
-#: lib/mergetool.tcl:350
+#: lib/blame.tcl:306
+msgid "Blame Parent Commit"
+msgstr "Анотиране на родителското подаване"
+
+#: lib/blame.tcl:468
 #, tcl-format
-msgid ""
-"Could not start the merge tool:\n"
-"\n"
-"%s"
-msgstr ""
-"Програмата за сливане не може да бъде стартирана:\n"
-"\n"
-"%s"
+msgid "Reading %s..."
+msgstr "Чете се „%s“…"
 
-#: lib/mergetool.tcl:354
-msgid "Running merge tool..."
-msgstr "Стартиране на програмата за сливане…"
+#: lib/blame.tcl:596
+msgid "Loading copy/move tracking annotations..."
+msgstr "Зареждане на анотациите за проследяване на копирането/преместването…"
 
-#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
-msgid "Merge tool failed."
-msgstr "Грешка в програмата за сливане."
+#: lib/blame.tcl:613
+msgid "lines annotated"
+msgstr "реда анотирани"
+
+#: lib/blame.tcl:815
+msgid "Loading original location annotations..."
+msgstr "Зареждане на анотациите за първоначалното местоположение…"
+
+#: lib/blame.tcl:818
+msgid "Annotation complete."
+msgstr "Анотирането завърши."
+
+#: lib/blame.tcl:849
+msgid "Busy"
+msgstr "Операцията не е завършила"
 
-#: lib/option.tcl:11
-#, tcl-format
-msgid "Invalid global encoding '%s'"
-msgstr "Неправилно глобално кодиране „%s“"
+#: lib/blame.tcl:850
+msgid "Annotation process is already running."
+msgstr "В момента тече процес на анотиране."
 
-#: lib/option.tcl:19
-#, tcl-format
-msgid "Invalid repo encoding '%s'"
-msgstr "Неправилно кодиране „%s“ на хранилището"
+#: lib/blame.tcl:889
+msgid "Running thorough copy detection..."
+msgstr "Изпълнява се цялостен процес на откриване на копиране…"
 
-#: lib/option.tcl:119
-msgid "Restore Defaults"
-msgstr "Стандартни настройки"
+#: lib/blame.tcl:957
+msgid "Loading annotation..."
+msgstr "Зареждане на анотации…"
 
-#: lib/option.tcl:123
-msgid "Save"
-msgstr "Запазване"
+#: lib/blame.tcl:1010
+msgid "Author:"
+msgstr "Автор:"
 
-#: lib/option.tcl:133
-#, tcl-format
-msgid "%s Repository"
-msgstr "Хранилище „%s“"
+#: lib/blame.tcl:1014
+msgid "Committer:"
+msgstr "Подал:"
 
-#: lib/option.tcl:134
-msgid "Global (All Repositories)"
-msgstr "Глобално (за всички хранилища)"
+#: lib/blame.tcl:1019
+msgid "Original File:"
+msgstr "Първоначален файл:"
 
-#: lib/option.tcl:140
-msgid "User Name"
-msgstr "Потребителско име"
+#: lib/blame.tcl:1067
+msgid "Cannot find HEAD commit:"
+msgstr "Подаването за връх „HEAD“ не може да се открие:"
 
-#: lib/option.tcl:141
-msgid "Email Address"
-msgstr "Адрес на е-поща"
+#: lib/blame.tcl:1122
+msgid "Cannot find parent commit:"
+msgstr "Родителското подаване не може да се открие"
 
-#: lib/option.tcl:143
-msgid "Summarize Merge Commits"
-msgstr "Обобщаване на подаванията при сливане"
+#: lib/blame.tcl:1137
+msgid "Unable to display parent"
+msgstr "Родителят не може да се покаже"
 
-#: lib/option.tcl:144
-msgid "Merge Verbosity"
-msgstr "Подробности при сливанията"
+#: lib/blame.tcl:1138 lib/diff.tcl:345
+msgid "Error loading diff:"
+msgstr "Грешка при зареждане на разлика:"
 
-#: lib/option.tcl:145
-msgid "Show Diffstat After Merge"
-msgstr "Извеждане на статистика след сливанията"
+#: lib/blame.tcl:1279
+msgid "Originally By:"
+msgstr "Първоначално от:"
 
-#: lib/option.tcl:146
-msgid "Use Merge Tool"
-msgstr "Използване на програма за сливане"
+#: lib/blame.tcl:1285
+msgid "In File:"
+msgstr "Във файл:"
 
-#: lib/option.tcl:148
-msgid "Trust File Modification Timestamps"
-msgstr "Доверие във времето на промяна на файловете"
+#: lib/blame.tcl:1290
+msgid "Copied Or Moved Here By:"
+msgstr "Копирано или преместено тук от:"
 
-#: lib/option.tcl:149
-msgid "Prune Tracking Branches During Fetch"
-msgstr "Окастряне на следящите клонове при доставяне"
+#: lib/diff.tcl:77
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may have "
+"the same state."
+msgstr ""
+"Не са открити разлики.\n"
+"\n"
+"Няма промени в „%s“.\n"
+"\n"
+"Времето на промяна на файла е бил зададен от друга програма, но съдържанието "
+"му не е променено.\n"
+"\n"
+"Автоматично ще започне нова проверка дали няма други файлове в това "
+"състояние."
 
-#: lib/option.tcl:150
-msgid "Match Tracking Branches"
-msgstr "Напасване на следящите клонове"
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "Зареждане на разликите в „%s“…"
 
-#: lib/option.tcl:151
-msgid "Use Textconv For Diffs and Blames"
-msgstr "Използване на „textconv“ за разликите и анотирането"
+#: lib/diff.tcl:143
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"ЛОКАЛНО: изтрит\n"
+"ОТДАЛЕЧЕНО:\n"
 
-#: lib/option.tcl:152
-msgid "Blame Copy Only On Changed Files"
-msgstr "Анотиране на копието само по променените файлове"
+#: lib/diff.tcl:148
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"ОТДАЛЕЧЕНО: изтрит\n"
+"ЛОКАЛНО:\n"
 
-#: lib/option.tcl:153
-msgid "Maximum Length of Recent Repositories List"
-msgstr "Максимален брой на списъка „Скоро ползвани“ хранилища"
+#: lib/diff.tcl:155
+msgid "LOCAL:\n"
+msgstr "ЛОКАЛНО:\n"
 
-#: lib/option.tcl:154
-msgid "Minimum Letters To Blame Copy On"
-msgstr "Минимален брой знаци за анотиране на копието"
+#: lib/diff.tcl:158
+msgid "REMOTE:\n"
+msgstr "ОТДАЛЕЧЕНО:\n"
 
-#: lib/option.tcl:155
-msgid "Blame History Context Radius (days)"
-msgstr "Исторически обхват за анотиране в дни"
+#: lib/diff.tcl:220 lib/diff.tcl:344
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "Файлът „%s“ не може да се покаже"
 
-#: lib/option.tcl:156
-msgid "Number of Diff Context Lines"
-msgstr "Брой редове за контекста на разликите"
+#: lib/diff.tcl:221
+msgid "Error loading file:"
+msgstr "Грешка при зареждане на файл:"
 
-#: lib/option.tcl:157
-msgid "Additional Diff Parameters"
-msgstr "Аргументи към командата за разликите"
+#: lib/diff.tcl:227
+msgid "Git Repository (subproject)"
+msgstr "Хранилище на Git (подмодул)"
 
-#: lib/option.tcl:158
-msgid "Commit Message Text Width"
-msgstr "Широчина на текста на съобщението при подаване"
+#: lib/diff.tcl:239
+msgid "* Binary file (not showing content)."
+msgstr "● Двоичен файл (съдържанието не се показва)."
 
-#: lib/option.tcl:159
-msgid "New Branch Name Template"
-msgstr "Шаблон за името на новите клони"
+#: lib/diff.tcl:244
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"● Неследеният файл е %d байта.\n"
+"● Показват се само първите %d байта.\n"
 
-#: lib/option.tcl:160
-msgid "Default File Contents Encoding"
-msgstr "Кодиране на файловете"
+#: lib/diff.tcl:250
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"● Неследеният файл е отрязан дотук от програмата „%s“.\n"
+"● Използвайте външен редактор, за да видите целия файл.\n"
 
-#: lib/option.tcl:161
-msgid "Warn before committing to a detached head"
-msgstr "Предупреждаване при подаване към несвързан указател"
+#: lib/diff.tcl:583
+msgid "Failed to unstage selected hunk."
+msgstr "Избраното парче не може да се извади от индекса."
 
-#: lib/option.tcl:162
-msgid "Staging of untracked files"
-msgstr "Добавяне на неследените файлове към индекса"
+#: lib/diff.tcl:591
+msgid "Failed to revert selected hunk."
+msgstr "Избраното парче не може да се върне."
 
-#: lib/option.tcl:163
-msgid "Show untracked files"
-msgstr "Показване на неследените файлове"
+#: lib/diff.tcl:594
+msgid "Failed to stage selected hunk."
+msgstr "Избраното парче не може да се добави към индекса."
 
-#: lib/option.tcl:164
-msgid "Tab spacing"
-msgstr "Ширина на табулацията"
+#: lib/diff.tcl:687
+msgid "Failed to unstage selected line."
+msgstr "Избраният ред не може да се извади от индекса."
 
-#: lib/option.tcl:210
-msgid "Change"
-msgstr "Смяна"
+#: lib/diff.tcl:696
+msgid "Failed to revert selected line."
+msgstr "Избраният ред не може да се върне."
 
-#: lib/option.tcl:254
-msgid "Spelling Dictionary:"
-msgstr "Правописен речник:"
+#: lib/diff.tcl:700
+msgid "Failed to stage selected line."
+msgstr "Избраният ред не може да се добави към индекса."
 
-#: lib/option.tcl:284
-msgid "Change Font"
-msgstr "Смяна на шрифта"
+#: lib/diff.tcl:889
+msgid "Failed to undo last revert."
+msgstr "Неуспешна отмяна на последното връщане."
 
-#: lib/option.tcl:288
+#: lib/sshkey.tcl:34
+msgid "No keys found."
+msgstr "Не са открити ключове."
+
+#: lib/sshkey.tcl:37
 #, tcl-format
-msgid "Choose %s"
-msgstr "Избор на „%s“"
+msgid "Found a public key in: %s"
+msgstr "Открит е публичен ключ в „%s“"
 
-#: lib/option.tcl:294
-msgid "pt."
-msgstr "тчк."
+#: lib/sshkey.tcl:43
+msgid "Generate Key"
+msgstr "Генериране на ключ"
 
-#: lib/option.tcl:308
-msgid "Preferences"
-msgstr "Настройки"
+#: lib/sshkey.tcl:61
+msgid "Copy To Clipboard"
+msgstr "Копиране към системния буфер"
 
-#: lib/option.tcl:345
-msgid "Failed to completely save options:"
-msgstr "Неуспешно запазване на настройките:"
+#: lib/sshkey.tcl:75
+msgid "Your OpenSSH Public Key"
+msgstr "Публичният ви ключ за OpenSSH"
 
-#: lib/remote.tcl:200
-msgid "Push to"
-msgstr "Изтласкване към"
+#: lib/sshkey.tcl:83
+msgid "Generating..."
+msgstr "Генериране…"
 
-#: lib/remote.tcl:218
-msgid "Remove Remote"
-msgstr "Премахване на отдалечено хранилище"
+#: lib/sshkey.tcl:89
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"Програмата „ssh-keygen“ не може да се стартира:\n"
+"\n"
+"%s"
 
-#: lib/remote.tcl:223
-msgid "Prune from"
-msgstr "Окастряне от"
+#: lib/sshkey.tcl:116
+msgid "Generation failed."
+msgstr "Неуспешно генериране."
 
-#: lib/remote.tcl:228
-msgid "Fetch from"
-msgstr "Доставяне от"
+#: lib/sshkey.tcl:123
+msgid "Generation succeeded, but no keys found."
+msgstr "Генерирането завърши успешно, а не са намерени ключове."
 
-#: lib/remote.tcl:253 lib/remote.tcl:258
-msgid "All"
-msgstr "Всички"
+#: lib/sshkey.tcl:126
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "Ключът ви е в „%s“"
 
-#: lib/remote_add.tcl:20
+#: lib/branch_create.tcl:23
 #, tcl-format
-msgid "%s (%s): Add Remote"
-msgstr "%s (%s): Добавяне на отдалечено хранилище"
+msgid "%s (%s): Create Branch"
+msgstr "%s (%s): Създаване на клон"
 
-#: lib/remote_add.tcl:25
-msgid "Add New Remote"
-msgstr "Добавяне на отдалечено хранилище"
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "Създаване на нов клон"
 
-#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
-msgid "Add"
-msgstr "Добавяне"
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "Име на клона"
 
-#: lib/remote_add.tcl:39
-msgid "Remote Details"
-msgstr "Данни за отдалеченото хранилище"
+#: lib/branch_create.tcl:57
+msgid "Match Tracking Branch Name"
+msgstr "Съвпадане по името на следения клон"
 
-#: lib/remote_add.tcl:50
-msgid "Location:"
-msgstr "Местоположение:"
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Начална версия"
 
-#: lib/remote_add.tcl:60
-msgid "Further Action"
-msgstr "Следващо действие"
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Обновяване на съществуващ клон:"
 
-#: lib/remote_add.tcl:63
-msgid "Fetch Immediately"
-msgstr "Незабавно доставяне"
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "Не"
 
-#: lib/remote_add.tcl:69
-msgid "Initialize Remote Repository and Push"
-msgstr "Инициализиране на отдалеченото хранилище и изтласкване на промените"
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Само тривиално превъртащо сливане"
 
-#: lib/remote_add.tcl:75
-msgid "Do Nothing Else Now"
-msgstr "Да не се прави нищо"
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Преминаване към клона след създаването му"
 
-#: lib/remote_add.tcl:100
-msgid "Please supply a remote name."
-msgstr "Задайте име за отдалеченото хранилище."
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "Изберете клон за следени."
 
-#: lib/remote_add.tcl:113
+#: lib/branch_create.tcl:141
 #, tcl-format
-msgid "'%s' is not an acceptable remote name."
-msgstr "Отдалечено хранилище не може да се казва „%s“."
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "Следящият клон — „%s“, не съществува в отдалеченото хранилище."
 
-#: lib/remote_add.tcl:124
-#, tcl-format
-msgid "Failed to add remote '%s' of location '%s'."
-msgstr "Неуспешно добавяне на отдалеченото хранилище „%s“ от адрес „%s“."
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "В момента се извършва действие, изчакайте…"
 
-#: lib/remote_add.tcl:132 lib/transport.tcl:6
-#, tcl-format
-msgid "fetch %s"
-msgstr "доставяне на „%s“"
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Успех"
 
-#: lib/remote_add.tcl:133
-#, tcl-format
-msgid "Fetching the %s"
-msgstr "Доставяне на „%s“"
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Грешка: неуспешно изпълнение на команда"
 
-#: lib/remote_add.tcl:156
-#, tcl-format
-msgid "Do not know how to initialize repository at location '%s'."
-msgstr "Хранилището с местоположение „%s“ не може да бъде инициализирано."
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "Към ред:"
 
-#: lib/remote_add.tcl:162 lib/transport.tcl:54 lib/transport.tcl:92
-#: lib/transport.tcl:110
-#, tcl-format
-msgid "push %s"
-msgstr "изтласкване на „%s“"
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "Към"
 
-#: lib/remote_add.tcl:163
-#, tcl-format
-msgid "Setting up the %s (at %s)"
-msgstr "Добавяне на хранилище „%s“ (с адрес „%s“)"
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "Това несвързано изтегляне"
 
-#: lib/remote_branch_delete.tcl:29
-#, tcl-format
-msgid "%s (%s): Delete Branch Remotely"
-msgstr "%s (%s): Изтриване на отдалечения клон"
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Израз за версия:"
 
-#: lib/remote_branch_delete.tcl:34
-msgid "Delete Branch Remotely"
-msgstr "Изтриване на отдалечения клон"
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "Локален клон"
 
-#: lib/remote_branch_delete.tcl:48
-msgid "From Repository"
-msgstr "От хранилище"
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "Следящ клон"
 
-#: lib/remote_branch_delete.tcl:51 lib/transport.tcl:165
-msgid "Remote:"
-msgstr "Отдалечено хранилище:"
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "Етикет"
 
-#: lib/remote_branch_delete.tcl:72 lib/transport.tcl:187
-msgid "Arbitrary Location:"
-msgstr "Произволно местоположение:"
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Неправилна версия: %s"
 
-#: lib/remote_branch_delete.tcl:88
-msgid "Branches"
-msgstr "Клони"
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "Не е избрана версия."
 
-#: lib/remote_branch_delete.tcl:110
-msgid "Delete Only If"
-msgstr "Изтриване, само ако"
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "Изразът за версия е празен."
 
-#: lib/remote_branch_delete.tcl:112
-msgid "Merged Into:"
-msgstr "Слят в:"
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "Обновен"
 
-#: lib/remote_branch_delete.tcl:153
-msgid "A branch is required for 'Merged Into'."
-msgstr "За данните „Слят в“ е необходимо да зададете клон."
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "Адрес"
 
-#: lib/remote_branch_delete.tcl:185
-#, tcl-format
+#: lib/commit.tcl:9
 msgid ""
-"The following branches are not completely merged into %s:\n"
+"There is nothing to amend.\n"
 "\n"
-" - %s"
+"You are about to create the initial commit.  There is no commit before this "
+"to amend.\n"
 msgstr ""
-"Следните клони не са слети напълно в „%s“:\n"
+"Няма какво да се поправи.\n"
 "\n"
-" ● %s"
+"Ще създадете първоначалното подаване. Преди него няма други подавания, които "
+"да поправите.\n"
 
-#: lib/remote_branch_delete.tcl:190
-#, tcl-format
+#: lib/commit.tcl:18
 msgid ""
-"One or more of the merge tests failed because you have not fetched the "
-"necessary commits.  Try fetching from %s first."
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort the "
+"current merge activity.\n"
 msgstr ""
-"Поне една от пробите за сливане е неуспешна, защото не сте доставили всички "
-"необходими подавания. Пробвайте първо да доставите подаванията от „%s“."
-
-#: lib/remote_branch_delete.tcl:208
-msgid "Please select one or more branches to delete."
-msgstr "Изберете поне един клон за изтриване."
-
-#: lib/remote_branch_delete.tcl:227
-#, tcl-format
-msgid "Deleting branches from %s"
-msgstr "Изтриване на клони от „%s“"
-
-#: lib/remote_branch_delete.tcl:300
-msgid "No repository selected."
-msgstr "Не е избрано хранилище."
-
-#: lib/remote_branch_delete.tcl:305
-#, tcl-format
-msgid "Scanning %s..."
-msgstr "Претърсване на „%s“…"
-
-#: lib/search.tcl:48
-msgid "Find:"
-msgstr "Търсене:"
-
-#: lib/search.tcl:50
-msgid "Next"
-msgstr "Следваща поява"
+"По време на сливане не може да поправяте.\n"
+"\n"
+"В момента все още не сте завършили операция по сливане. Не може да поправите "
+"предишното подаване, освен ако първо не преустановите текущото сливане.\n"
 
-#: lib/search.tcl:51
-msgid "Prev"
-msgstr "Предишна поява"
+#: lib/commit.tcl:56
+msgid "Error loading commit data for amend:"
+msgstr "Грешка при зареждане на данните от подаване, които да се поправят:"
 
-#: lib/search.tcl:52
-msgid "RegExp"
-msgstr "РегИзр"
+#: lib/commit.tcl:83
+msgid "Unable to obtain your identity:"
+msgstr "Идентификацията ви не може да се определи:"
 
-#: lib/search.tcl:54
-msgid "Case"
-msgstr "Главни/малки"
+#: lib/commit.tcl:88
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "Неправилно поле „GIT_COMMITTER_IDENT“:"
 
-#: lib/shortcut.tcl:8 lib/shortcut.tcl:43 lib/shortcut.tcl:75
+#: lib/commit.tcl:138
 #, tcl-format
-msgid "%s (%s): Create Desktop Icon"
-msgstr "%s (%s): Добавяне на икона на работния плот"
-
-#: lib/shortcut.tcl:24 lib/shortcut.tcl:65
-msgid "Cannot write shortcut:"
-msgstr "Клавишната комбинация не може да бъде запазена:"
-
-#: lib/shortcut.tcl:140
-msgid "Cannot write icon:"
-msgstr "Иконата не може да бъде запазена:"
-
-#: lib/spellcheck.tcl:57
-msgid "Unsupported spell checker"
-msgstr "Тази програма за проверка на правописа не се поддържа"
-
-#: lib/spellcheck.tcl:65
-msgid "Spell checking is unavailable"
-msgstr "Липсва програма за проверка на правописа"
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "предупреждение: Tcl не поддържа кодирането „%s“."
 
-#: lib/spellcheck.tcl:68
-msgid "Invalid spell checking configuration"
-msgstr "Неправилни настройки на проверката на правописа"
+#: lib/commit.tcl:158
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Състоянието при последната проверка не отговаря на състоянието на "
+"хранилището.\n"
+"\n"
+"Някой друг процес за Git е променил хранилището междувременно. Състоянието "
+"трябва да се провери преди ново подаване.\n"
+"\n"
+"Автоматично ще започне нова проверка.\n"
 
-#: lib/spellcheck.tcl:70
+#: lib/commit.tcl:182
 #, tcl-format
-msgid "Reverting dictionary to %s."
-msgstr "Ползване на речник за език „%s“."
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the file "
+"before committing.\n"
+msgstr ""
+"Неслетите файлове не може да се подадат.\n"
+"\n"
+"Във файла „%s“ има конфликти при сливане. За да го подадете, трябва първо да "
+"коригирате конфликтите и да добавите файла към индекса за подаване.\n"
 
-#: lib/spellcheck.tcl:73
-msgid "Spell checker silently failed on startup"
-msgstr "Програмата за правопис даже не стартира успешно."
+#: lib/commit.tcl:190
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Непознато състояние на файл „%s“.\n"
+"\n"
+"Файлът „%s“ не може да се подаде чрез текущата програма.\n"
 
-#: lib/spellcheck.tcl:80
-msgid "Unrecognized spell checker"
-msgstr "Непозната програма за проверка на правописа"
+#: lib/commit.tcl:198
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Няма промени за подаване.\n"
+"\n"
+"Трябва да добавите поне един файл към индекса, за да подадете.\n"
 
-#: lib/spellcheck.tcl:186
-msgid "No Suggestions"
-msgstr "Няма предложения"
+#: lib/commit.tcl:213
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Задайте добро съобщение при подаване.\n"
+"\n"
+"Използвайте следния формат:\n"
+"\n"
+"● Първи ред: описание в едно изречение на промяната.\n"
+"● Втори ред: празен.\n"
+"● Останалите редове: опишете защо се налага тази промяна.\n"
 
-#: lib/spellcheck.tcl:388
-msgid "Unexpected EOF from spell checker"
-msgstr "Неочакван край на файл от програмата за проверка на правописа"
+#: lib/commit.tcl:244
+msgid "Calling pre-commit hook..."
+msgstr "Изпълняване на куката преди подаване…"
 
-#: lib/spellcheck.tcl:392
-msgid "Spell Checker Failed"
-msgstr "Грешка в програмата за проверка на правописа"
+#: lib/commit.tcl:259
+msgid "Commit declined by pre-commit hook."
+msgstr "Подаването е отхвърлено от куката преди подаване."
 
-#: lib/sshkey.tcl:31
-msgid "No keys found."
-msgstr "Не са открити ключове."
+#: lib/commit.tcl:278
+msgid ""
+"You are about to commit on a detached head. This is a potentially dangerous "
+"thing to do because if you switch to another branch you will lose your "
+"changes and it can be difficult to retrieve them later from the reflog. You "
+"should probably cancel this commit and create a new branch to continue.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"Ще подадете към несвързан, отделѐн указател „HEAD“. Това е опасно, защото "
+"при преминаването към клон ще загубите промените си, като единственият начин "
+"да ги върнете ще е чрез журнала на указателите (reflog). Най-вероятно трябва "
+"да не правите това подаване, а да създадете нов клон, преди да продължите.\n"
+" \n"
+"Сигурни ли сте, че искате да извършите текущото подаване?"
 
-#: lib/sshkey.tcl:34
-#, tcl-format
-msgid "Found a public key in: %s"
-msgstr "Открит е публичен ключ в „%s“"
+#: lib/commit.tcl:299
+msgid "Calling commit-msg hook..."
+msgstr "Изпълняване на куката за съобщението при подаване…"
 
-#: lib/sshkey.tcl:40
-msgid "Generate Key"
-msgstr "Генериране на ключ"
+#: lib/commit.tcl:314
+msgid "Commit declined by commit-msg hook."
+msgstr "Подаването е отхвърлено от куката за съобщението при подаване."
 
-#: lib/sshkey.tcl:58
-msgid "Copy To Clipboard"
-msgstr "Копиране към системния буфер"
+#: lib/commit.tcl:327
+msgid "Committing changes..."
+msgstr "Подаване на промените…"
 
-#: lib/sshkey.tcl:72
-msgid "Your OpenSSH Public Key"
-msgstr "Публичният ви ключ за OpenSSH"
+#: lib/commit.tcl:344
+msgid "write-tree failed:"
+msgstr "неуспешно запазване на дървото (write-tree):"
 
-#: lib/sshkey.tcl:80
-msgid "Generating..."
-msgstr "Генериране…"
+#: lib/commit.tcl:345 lib/commit.tcl:395 lib/commit.tcl:422
+msgid "Commit failed."
+msgstr "Неуспешно подаване."
 
-#: lib/sshkey.tcl:86
+#: lib/commit.tcl:362
 #, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "Подаването „%s“ изглежда повредено"
+
+#: lib/commit.tcl:367
 msgid ""
-"Could not start ssh-keygen:\n"
+"No changes to commit.\n"
 "\n"
-"%s"
+"No files were modified by this commit and it was not a merge commit.\n"
+"\n"
+"A rescan will be automatically started now.\n"
 msgstr ""
-"Програмата „ssh-keygen“ не може да бъде стартирана:\n"
+"Няма промени за подаване.\n"
 "\n"
-"%s"
+"В това подаване не са променяни никакви файлове, а и не е подаване със "
+"сливане.\n"
+"\n"
+"Автоматично ще започне нова проверка.\n"
 
-#: lib/sshkey.tcl:113
-msgid "Generation failed."
-msgstr "Неуспешно генериране."
+#: lib/commit.tcl:374
+msgid "No changes to commit."
+msgstr "Няма промени за подаване."
 
-#: lib/sshkey.tcl:120
-msgid "Generation succeeded, but no keys found."
-msgstr "Генерирането завърши успешно, а не са намерени ключове."
+#: lib/commit.tcl:394
+msgid "commit-tree failed:"
+msgstr "неуспешно подаване на дървото (commit-tree):"
 
-#: lib/sshkey.tcl:123
-#, tcl-format
-msgid "Your key is in: %s"
-msgstr "Ключът ви е в „%s“"
+#: lib/commit.tcl:421
+msgid "update-ref failed:"
+msgstr "неуспешно обновяване на указателите (update-ref):"
 
-#: lib/status_bar.tcl:87
+#: lib/commit.tcl:514
 #, tcl-format
-msgid "%s ... %*i of %*i %s (%3i%%)"
-msgstr "%s… %*i от общо %*i %s (%3i%%)"
+msgid "Created commit %s: %s"
+msgstr "Успешно подаване %s: %s"
 
-#: lib/tools.tcl:76
+#: lib/branch_delete.tcl:16
 #, tcl-format
-msgid "Running %s requires a selected file."
-msgstr "За изпълнението на „%s“ трябва да изберете файл."
+msgid "%s (%s): Delete Branch"
+msgstr "%s (%s): Изтриване на клон"
 
-#: lib/tools.tcl:92
-#, tcl-format
-msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
-msgstr "Сигурни ли сте, че искате да изпълните „%1$s“ върху файла „%2$s“?"
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "Изтриване на локален клон"
 
-#: lib/tools.tcl:96
-#, tcl-format
-msgid "Are you sure you want to run %s?"
-msgstr "Сигурни ли сте, че искате да изпълните „%s“?"
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "Локални клони"
 
-#: lib/tools.tcl:118
-#, tcl-format
-msgid "Tool: %s"
-msgstr "Команда: %s"
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "Изтриване, само ако промените са слети и другаде"
 
-#: lib/tools.tcl:119
+#: lib/branch_delete.tcl:103
 #, tcl-format
-msgid "Running: %s"
-msgstr "Изпълнение: %s"
+msgid "The following branches are not completely merged into %s:"
+msgstr "Не всички промени в клоните са слети в „%s“:"
 
-#: lib/tools.tcl:158
+#: lib/branch_delete.tcl:131
 #, tcl-format
-msgid "Tool completed successfully: %s"
-msgstr "Командата завърши успешно: %s"
+msgid " - %s:"
+msgstr " — „%s:“"
 
-#: lib/tools.tcl:160
+#: lib/branch_delete.tcl:141
 #, tcl-format
-msgid "Tool failed: %s"
-msgstr "Командата върна грешка: %s"
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Неуспешно триене на клони:\n"
+"%s"
 
-#: lib/tools_dlg.tcl:22
+#: lib/date.tcl:25
 #, tcl-format
-msgid "%s (%s): Add Tool"
-msgstr "%s (%s): Добавяне на команда"
-
-#: lib/tools_dlg.tcl:28
-msgid "Add New Tool Command"
-msgstr "Добавяне на команда"
-
-#: lib/tools_dlg.tcl:34
-msgid "Add globally"
-msgstr "Глобално добавяне"
-
-#: lib/tools_dlg.tcl:46
-msgid "Tool Details"
-msgstr "Подробности за командата"
-
-#: lib/tools_dlg.tcl:49
-msgid "Use '/' separators to create a submenu tree:"
-msgstr "За създаване на подменюта използвайте знака „/“ за разделител:"
-
-#: lib/tools_dlg.tcl:60
-msgid "Command:"
-msgstr "Команда:"
+msgid "Invalid date from Git: %s"
+msgstr "Неправилни данни от Git: %s"
 
-#: lib/tools_dlg.tcl:71
-msgid "Show a dialog before running"
-msgstr "Преди изпълнение да се извежда диалогов прозорец"
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "Брой непакетирани обекти"
 
-#: lib/tools_dlg.tcl:77
-msgid "Ask the user to select a revision (sets $REVISION)"
-msgstr "Потребителят да укаже версия (задаване на променливата $REVISION)"
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "Дисково пространство заето от непакетирани обекти"
 
-#: lib/tools_dlg.tcl:82
-msgid "Ask the user for additional arguments (sets $ARGS)"
-msgstr ""
-"Потребителят да укаже допълнителни аргументи (задаване на променливата $ARGS)"
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "Брой пакетирани обекти"
 
-#: lib/tools_dlg.tcl:89
-msgid "Don't show the command output window"
-msgstr "Без показване на прозорец с изхода от командата"
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "Брой пакети"
 
-#: lib/tools_dlg.tcl:94
-msgid "Run only if a diff is selected ($FILENAME not empty)"
-msgstr ""
-"Стартиране само след избор на разлика (променливата $FILENAME не е празна)"
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "Дисково пространство заето от пакетирани обекти"
 
-#: lib/tools_dlg.tcl:118
-msgid "Please supply a name for the tool."
-msgstr "Задайте име за командата."
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "Пакетирани обекти за окастряне"
 
-#: lib/tools_dlg.tcl:126
+#: lib/database.tcl:48
+msgid "Garbage files"
+msgstr "Файлове за боклука"
+
+#: lib/database.tcl:66
 #, tcl-format
-msgid "Tool '%s' already exists."
-msgstr "Командата „%s“ вече съществува."
+msgid "%s (%s): Database Statistics"
+msgstr "%s (%s): Статистика на базата от данни"
 
-#: lib/tools_dlg.tcl:148
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "Компресиране на базата с данни за обектите"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "Проверка на базата с данни за обектите с програмата „fsck-objects“"
+
+#: lib/database.tcl:107
 #, tcl-format
 msgid ""
-"Could not add tool:\n"
-"%s"
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you compress "
+"the database.\n"
+"\n"
+"Compress the database now?"
 msgstr ""
-"Командата не може да бъде добавена:\n"
-"%s"
+"В това хранилище в момента има към %i непакетирани обекти.\n"
+"\n"
+"За добра производителност се препоръчва да компресирате базата с данни за "
+"обектите.\n"
+"\n"
+"Да се започне ли компресирането?"
 
-#: lib/tools_dlg.tcl:187
+#: lib/error.tcl:20
 #, tcl-format
-msgid "%s (%s): Remove Tool"
-msgstr "%s (%s): Премахване на команда"
-
-#: lib/tools_dlg.tcl:193
-msgid "Remove Tool Commands"
-msgstr "Премахване на команди"
-
-#: lib/tools_dlg.tcl:198
-msgid "Remove"
-msgstr "Премахване"
+msgid "%s: error"
+msgstr "%s: грешка"
 
-#: lib/tools_dlg.tcl:231
-msgid "(Blue denotes repository-local tools)"
-msgstr "(командите към локалното хранилище са обозначени в синьо)"
+#: lib/error.tcl:36
+#, tcl-format
+msgid "%s: warning"
+msgstr "%s: предупреждение"
 
-#: lib/tools_dlg.tcl:283
+#: lib/error.tcl:80
 #, tcl-format
-msgid "%s (%s):"
-msgstr "%s (%s):"
+msgid "%s hook failed:"
+msgstr "%s: грешка от куката"
 
-#: lib/tools_dlg.tcl:292
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr "Преди да можете да подадете, коригирайте горните грешки."
+
+#: lib/error.tcl:116
 #, tcl-format
-msgid "Run Command: %s"
-msgstr "Изпълнение на командата „%s“"
+msgid "%s (%s): error"
+msgstr "%s (%s): грешка"
 
-#: lib/tools_dlg.tcl:306
-msgid "Arguments"
-msgstr "Аргументи"
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merge.\n"
+msgstr ""
+"По време на поправяне не може да сливане.\n"
+"\n"
+"Трябва да завършите поправянето на текущото подаване, преди да започнете "
+"сливане.\n"
 
-#: lib/tools_dlg.tcl:341
-msgid "OK"
-msgstr "Добре"
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"Последно установеното състояние не отговаря на това в хранилището.\n"
+"\n"
+"Някой друг процес за Git е променил хранилището междувременно. Състоянието "
+"трябва да се провери, преди да се извърши сливане.\n"
+"\n"
+"Автоматично ще започне нова проверка.\n"
+"\n"
 
-#: lib/transport.tcl:7
+#: lib/merge.tcl:45
 #, tcl-format
-msgid "Fetching new changes from %s"
-msgstr "Доставяне на промените от „%s“"
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the current "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"В момента тече сливане, но има конфликти.\n"
+"\n"
+"Погледнете файла „%s“.\n"
+"\n"
+"Трябва да коригирате конфликтите в него, да го добавите към индекса и да "
+"завършите текущото сливане чрез подаване. Чак тогава може да започнете ново "
+"сливане.\n"
 
-#: lib/transport.tcl:18
+#: lib/merge.tcl:55
 #, tcl-format
-msgid "remote prune %s"
-msgstr "окастряне на следящите клони към „%s“"
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doing so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"В момента тече подаване.\n"
+"\n"
+"Файлът „%s“ е променен.\n"
+"\n"
+"Трябва да завършите текущото подаване, преди да започнете сливане. Така ще "
+"можете лесно да преустановите сливането, ако възникне нужда.\n"
 
-#: lib/transport.tcl:19
+#: lib/merge.tcl:108
 #, tcl-format
-msgid "Pruning tracking branches deleted from %s"
-msgstr "Окастряне на следящите клони на изтритите клони от „%s“"
-
-#: lib/transport.tcl:25
-msgid "fetch all remotes"
-msgstr "доставяне от всички отдалечени"
-
-#: lib/transport.tcl:26
-msgid "Fetching new changes from all remotes"
-msgstr "Доставяне на промените от всички отдалечени хранилища"
+msgid "%s of %s"
+msgstr "%s от общо %s"
 
-#: lib/transport.tcl:40
-msgid "remote prune all remotes"
-msgstr "окастряне на следящите изтрити"
+#: lib/merge.tcl:126
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "Сливане на „%s“ и „%s“…"
 
-#: lib/transport.tcl:41
-msgid "Pruning tracking branches deleted from all remotes"
-msgstr ""
-"Окастряне на следящите клони на изтритите клони от всички отдалечени "
-"хранилища"
+#: lib/merge.tcl:137
+msgid "Merge completed successfully."
+msgstr "Сливането завърши успешно."
 
-#: lib/transport.tcl:55
-#, tcl-format
-msgid "Pushing changes to %s"
-msgstr "Изтласкване на промените към „%s“"
+#: lib/merge.tcl:139
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Неуспешно сливане — има конфликти за коригиране."
 
-#: lib/transport.tcl:93
+#: lib/merge.tcl:156
 #, tcl-format
-msgid "Mirroring to %s"
-msgstr "Изтласкване на всичко към „%s“"
+msgid "%s (%s): Merge"
+msgstr "%s (%s): Сливане"
 
-#: lib/transport.tcl:111
+#: lib/merge.tcl:164
 #, tcl-format
-msgid "Pushing %s %s to %s"
-msgstr "Изтласкване на %s „%s“ към „%s“"
-
-#: lib/transport.tcl:132
-msgid "Push Branches"
-msgstr "Клони за изтласкване"
+msgid "Merge Into %s"
+msgstr "Сливане в „%s“"
 
-#: lib/transport.tcl:147
-msgid "Source Branches"
-msgstr "Клони-източници"
+#: lib/merge.tcl:183
+msgid "Revision To Merge"
+msgstr "Версия за сливане"
 
-#: lib/transport.tcl:162
-msgid "Destination Repository"
-msgstr "Целево хранилище"
+#: lib/merge.tcl:218
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"Поправянето не може да се преустанови.\n"
+"\n"
+"Трябва да завършите поправката на това подаване.\n"
 
-#: lib/transport.tcl:205
-msgid "Transfer Options"
-msgstr "Настройки при пренасянето"
+#: lib/merge.tcl:228
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Да се преустанови ли сливането?\n"
+"\n"
+"В такъв случай ●ВСИЧКИ● неподадени промени ще се загубят безвъзвратно.\n"
+"\n"
+"Наистина ли да се преустанови сливането?"
 
-#: lib/transport.tcl:207
-msgid "Force overwrite existing branch (may discard changes)"
+#: lib/merge.tcl:234
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost.\n"
+"\n"
+"Continue with resetting the current changes?"
 msgstr ""
-"Изрично презаписване на съществуващ клон (някои промени може да бъдат "
-"загубени)"
+"Да се занулят ли промените?\n"
+"\n"
+"В такъв случай ●ВСИЧКИ● неподадени промени ще се загубят безвъзвратно.\n"
+"\n"
+"Наистина ли да се занулят промените?"
 
-#: lib/transport.tcl:211
-msgid "Use thin pack (for slow network connections)"
-msgstr "Максимална компресия (за бавни мрежови връзки)"
+#: lib/merge.tcl:246
+msgid "Aborting"
+msgstr "Преустановяване"
 
-#: lib/transport.tcl:215
-msgid "Include tags"
-msgstr "Включване на етикетите"
+#: lib/merge.tcl:247
+msgid "files reset"
+msgstr "файла със занулени промени"
 
-#: lib/transport.tcl:229
-#, tcl-format
-msgid "%s (%s): Push"
-msgstr "%s (%s): Изтласкване"
+#: lib/merge.tcl:277
+msgid "Abort failed."
+msgstr "Неуспешно преустановяване."
+
+#: lib/merge.tcl:279
+msgid "Abort completed.  Ready."
+msgstr "Успешно преустановяване. Готовност за следващо действие."
-- 
2.47.1

