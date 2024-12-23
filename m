Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D801A8F84
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734961184; cv=none; b=IqRDROwe1Id2DbmJMGzJojIkMypa1tpWWgn18uulzHQf3vvkk2pNo8IrE9gtGhe8oLtIbE+TEb3huRRCJrf6D9b/ufHkvPhhK8h1R+4duhg60bI1o9xi2DQegohTKEoHWCyLt8jVJSG99fEf4fdKp/riH1v72GGKxhSDbaxTOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734961184; c=relaxed/simple;
	bh=qmtRbJnz/0p+5XmCmYz17F84tcN+HkQGkTuTzOmA7FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGK///qjSAEMULJLdfK1bYvztBI/cWBvEiFoLM3Eu8RQT7fnPJD849d97vLo8jraFtoUpi2G80GDLPOfvwxSzR6lZO2UCeIlLTIY5pAc2zMCATuNlQyYfgPrpLIvlVc60W8I2Q5X95BcQZO+U6NVl4io/nZHFgtFxfsGhJEHNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=y0ui1asJ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="y0ui1asJ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso603448066b.2
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 05:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1734961177; x=1735565977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3n59uaRmZNL1CvoiTUKvbY2QXY03iRxInz6fB8K5D0=;
        b=y0ui1asJXNAF45sEUwcckg63n8LLAwNWjo+zg2Nqxtbq5/toxYXDEEXC/6jNJIJEY0
         ac2NLfelcmib/psukkkQDmy9mmKSZj/GFEjTqkvWk1KO2WrNv+Vv4gtIBtSE4Iw/187u
         T57tV5eJ47YLWb1GrNto1SNz1tvafsbneNyDkAB1Eb/qgUyF8IPDGtMWmUBd0LfZcC6L
         00Z2C796q1ENcj9m8cqhSZQD4VR2G1Pz6blI6bTzPbvwFiBaR8c54rQK+Ag/voeaqdcN
         XEw89J1oZ38ymKxfvVBR+kbeONt3hj0sV2WXj1vmZER91rH83MNlANhdL7bAVI3HAhOH
         +M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734961177; x=1735565977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3n59uaRmZNL1CvoiTUKvbY2QXY03iRxInz6fB8K5D0=;
        b=GEfuoK2sgWl7cHKyeNZcAr+GvY43cw4xalUR65DWO2Fn4XhVLe7rJ7oT/xPEKV4RVy
         Tdo/cUnbgK7wyz+reF42KBGBwtAfpI6OKhf3DVklVXJaBm28NstKug6rgt/tDacscwO1
         ZcDnnsGolLYblxSjBAe/ppBvcSpR/dGLwZiKIKDePZv2yhUHJQXo1ZG53u1ksjp8rR2e
         q2o3eUJwcI3CumIVnA+6BpCaIVB90OWCXYTnhYMngwoOE9Wsr7NTnUtLwk3XN+CSgUgY
         24RwJFZ1sJSTmrMhbxA9wg5pgocaH3XNuXlvxJ6F51vxz7XNeAcn8gZX6HV2MQmU8D3B
         qfug==
X-Gm-Message-State: AOJu0Ywh7G4J68kbUSVLLy/v3Bzwoal/B7A1ctUjBxGbYqDdv0avC+cd
	3DyFI9QLkdKg3vtDZJ7dhlUwNQIZ5UV2WLratfOO0lspDltC4eyBiaGDVzST/vmFykU9jmqZvxE
	DyB8=
X-Gm-Gg: ASbGncv21f2iG4qCN/EP3PR1vOXhOMl4kfBFDNFlWVT9DJLTP9QJ01WFEJu3Oht/HTW
	CH8ZDd21jEzGOJMHfrKDXYkLKHVizw7v4PifQ+AbyPcM+XBCRSraBpI2PVjYi5Svup/ReBWkxv5
	eu2+XLYLrptJPzW+wKNSRp9uqSGW/ZODM89opW+4mbEGOsuPSGfOU13PtxJHAT8TJP8jqcr8C+q
	9yD2xEo/F83rHjJtU1uX9Zg31JK92g0vOh3HbcM/BwBTfN1kM4Bgff97oU6P7kUGJrJsrrI8bit
	Shl4H2t4w4Tb6p7/1DnyMt6ejw==
X-Google-Smtp-Source: AGHT+IHecdTGRAT2Xrz92VL421sWj5xstk0GgJBkLRIkvI1I83MDfCzZZ7u1EQMQ7BRZATOcumQXzA==
X-Received: by 2002:a05:6402:5204:b0:5d0:ced8:d22d with SMTP id 4fb4d7f45d1cf-5d81de05c3fmr33747671a12.22.1734961177117;
        Mon, 23 Dec 2024 05:39:37 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06dc7esm519007266b.193.2024.12.23.05.39.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 05:39:36 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	paulus@ozlabs.org,
	j6t@kdbg.org
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 1/1] gitk: Update Bulgarian translation (323t)
Date: Mon, 23 Dec 2024 14:39:18 +0100
Message-ID: <20241223133918.25133-4-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223133918.25133-3-ash@kambanaria.org>
References: <20241223133918.25133-3-ash@kambanaria.org>
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
 po/bg.po | 696 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 360 insertions(+), 336 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 87ab1fac24..5a74108766 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -1,15 +1,15 @@
 # Bulgarian translation of gitk po-file.
-# Copyright (C) 2014, 2015, 2019 Alexander Shopov <ash@kambanaria.org>.
+# Copyright (C) 2014, 2015, 2019, 2020 Alexander Shopov <ash@kambanaria.org>.
 # This file is distributed under the same license as the git package.
-# Alexander Shopov <ash@kambanaria.org>, 2014, 2015, 2019.
+# Alexander Shopov <ash@kambanaria.org>, 2014, 2015, 2019, 2020.
 #
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2019-03-04 11:27+0100\n"
-"PO-Revision-Date: 2019-03-04 11:39+0100\n"
+"POT-Creation-Date: 2024-12-23 14:23+0100\n"
+"PO-Revision-Date: 2024-12-23 14:22+0100\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@fsa-bg.org>\n"
 "Language: bg\n"
@@ -18,32 +18,32 @@ msgstr ""
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=2; plural=(n != 1);\n"
 
-#: gitk:140
+#: gitk:139
 msgid "Couldn't get list of unmerged files:"
-msgstr "Списъкът с неслети файлове не може да бъде получен:"
+msgstr "Списъкът с неслети файлове не може да се получи:"
 
-#: gitk:212 gitk:2403
+#: gitk:211 gitk:2406
 msgid "Color words"
 msgstr "Оцветяване на думите"
 
-#: gitk:217 gitk:2403 gitk:8249 gitk:8282
+#: gitk:216 gitk:2406 gitk:8307 gitk:8340
 msgid "Markup words"
 msgstr "Отбелязване на думите"
 
-#: gitk:324
+#: gitk:323
 msgid "Error parsing revisions:"
 msgstr "Грешка при анализ на версиите:"
 
-#: gitk:380
+#: gitk:379
 msgid "Error executing --argscmd command:"
 msgstr "Грешка при изпълнение на командата с „--argscmd“."
 
-#: gitk:393
+#: gitk:392
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Не са избрани файлове — указана е опцията „--merge“, но няма неслети файлове."
 
-#: gitk:396
+#: gitk:395
 msgid ""
 "No files selected: --merge specified but no unmerged files are within file "
 "limit."
@@ -51,326 +51,326 @@ msgstr ""
 "Не са избрани файлове — указана е опцията „--merge“, но няма неслети файлове "
 "в ограниченията."
 
-#: gitk:418 gitk:566
+#: gitk:417 gitk:565
 msgid "Error executing git log:"
 msgstr "Грешка при изпълнение на „git log“:"
 
-#: gitk:436 gitk:582
+#: gitk:435 gitk:581
 msgid "Reading"
 msgstr "Прочитане"
 
-#: gitk:496 gitk:4549
+#: gitk:495 gitk:4572
 msgid "Reading commits..."
 msgstr "Прочитане на подаванията…"
 
-#: gitk:499 gitk:1641 gitk:4552
+#: gitk:498 gitk:1640 gitk:4575
 msgid "No commits selected"
 msgstr "Не са избрани подавания"
 
-#: gitk:1449 gitk:4069 gitk:12583
+#: gitk:1448 gitk:4092 gitk:12674
 msgid "Command line"
 msgstr "Команден ред"
 
-#: gitk:1515
+#: gitk:1514
 msgid "Can't parse git log output:"
 msgstr "Изходът от „git log“ не може да се анализира:"
 
-#: gitk:1744
+#: gitk:1743
 msgid "No commit information available"
 msgstr "Липсва информация за подавания"
 
-#: gitk:1907 gitk:1936 gitk:4339 gitk:9789 gitk:11388 gitk:11668
+#: gitk:1910 gitk:1939 gitk:4362 gitk:9847 gitk:11451 gitk:11751
 msgid "OK"
 msgstr "Добре"
 
-#: gitk:1938 gitk:4341 gitk:9225 gitk:9304 gitk:9434 gitk:9520 gitk:9791
-#: gitk:11389 gitk:11669
+#: gitk:1941 gitk:4364 gitk:9283 gitk:9362 gitk:9492 gitk:9578 gitk:9849
+#: gitk:11452 gitk:11752
 msgid "Cancel"
 msgstr "Отказ"
 
-#: gitk:2087
+#: gitk:2090
 msgid "&Update"
 msgstr "&Обновяване"
 
-#: gitk:2088
+#: gitk:2091
 msgid "&Reload"
 msgstr "&Презареждане"
 
-#: gitk:2089
+#: gitk:2092
 msgid "Reread re&ferences"
-msgstr "&Наново прочитане"
+msgstr "Прочитане &наново"
 
-#: gitk:2090
+#: gitk:2093
 msgid "&List references"
 msgstr "&Изброяване на указателите"
 
-#: gitk:2092
+#: gitk:2095
 msgid "Start git &gui"
 msgstr "&Стартиране на „git gui“"
 
-#: gitk:2094
+#: gitk:2097
 msgid "&Quit"
 msgstr "&Спиране на програмата"
 
-#: gitk:2086
+#: gitk:2089
 msgid "&File"
 msgstr "&Файл"
 
-#: gitk:2098
+#: gitk:2101
 msgid "&Preferences"
 msgstr "&Настройки"
 
-#: gitk:2097
+#: gitk:2100
 msgid "&Edit"
 msgstr "&Редактиране"
 
-#: gitk:2102
+#: gitk:2105
 msgid "&New view..."
 msgstr "&Нов изглед…"
 
-#: gitk:2103
+#: gitk:2106
 msgid "&Edit view..."
 msgstr "&Редактиране на изгледа…"
 
-#: gitk:2104
+#: gitk:2107
 msgid "&Delete view"
 msgstr "&Изтриване на изгледа"
 
-#: gitk:2106
+#: gitk:2109
 msgid "&All files"
 msgstr "&Всички файлове"
 
-#: gitk:2101
+#: gitk:2104
 msgid "&View"
 msgstr "&Изглед"
 
-#: gitk:2111 gitk:2121
+#: gitk:2114 gitk:2124
 msgid "&About gitk"
 msgstr "&Относно gitk"
 
-#: gitk:2112 gitk:2126
+#: gitk:2115 gitk:2129
 msgid "&Key bindings"
 msgstr "&Клавишни комбинации"
 
-#: gitk:2110 gitk:2125
+#: gitk:2113 gitk:2128
 msgid "&Help"
 msgstr "Помо&щ"
 
-#: gitk:2203 gitk:8681
+#: gitk:2206 gitk:8739
 msgid "SHA1 ID:"
 msgstr "SHA1:"
 
-#: gitk:2247
+#: gitk:2250
 msgid "Row"
 msgstr "Ред"
 
-#: gitk:2285
+#: gitk:2288
 msgid "Find"
 msgstr "Търсене"
 
-#: gitk:2313
+#: gitk:2316
 msgid "commit"
 msgstr "подаване"
 
-#: gitk:2317 gitk:2319 gitk:4711 gitk:4734 gitk:4758 gitk:6779 gitk:6851
-#: gitk:6936
+#: gitk:2320 gitk:2322 gitk:4734 gitk:4757 gitk:4781 gitk:6802 gitk:6874
+#: gitk:6959
 msgid "containing:"
 msgstr "съдържащо:"
 
-#: gitk:2320 gitk:3550 gitk:3555 gitk:4787
+#: gitk:2323 gitk:3573 gitk:3578 gitk:4810
 msgid "touching paths:"
 msgstr "в пътищата:"
 
-#: gitk:2321 gitk:4801
+#: gitk:2324 gitk:4824
 msgid "adding/removing string:"
 msgstr "добавящо/премахващо низ"
 
-#: gitk:2322 gitk:4803
+#: gitk:2325 gitk:4826
 msgid "changing lines matching:"
 msgstr "променящо редове напасващи:"
 
-#: gitk:2331 gitk:2333 gitk:4790
+#: gitk:2334 gitk:2336 gitk:4813
 msgid "Exact"
 msgstr "Точно"
 
-#: gitk:2333 gitk:4878 gitk:6747
+#: gitk:2336 gitk:4901 gitk:6770
 msgid "IgnCase"
 msgstr "Без регистър"
 
-#: gitk:2333 gitk:4760 gitk:4876 gitk:6743
+#: gitk:2336 gitk:4783 gitk:4899 gitk:6766
 msgid "Regexp"
 msgstr "Рег. израз"
 
-#: gitk:2335 gitk:2336 gitk:4898 gitk:4928 gitk:4935 gitk:6872 gitk:6940
+#: gitk:2338 gitk:2339 gitk:4921 gitk:4951 gitk:4958 gitk:6895 gitk:6963
 msgid "All fields"
 msgstr "Всички полета"
 
-#: gitk:2336 gitk:4895 gitk:4928 gitk:6810
+#: gitk:2339 gitk:4918 gitk:4951 gitk:6833
 msgid "Headline"
 msgstr "Първи ред"
 
-#: gitk:2337 gitk:4895 gitk:6810 gitk:6940 gitk:7413
+#: gitk:2340 gitk:4918 gitk:6833 gitk:6963 gitk:7471
 msgid "Comments"
 msgstr "Коментари"
 
-#: gitk:2337 gitk:4895 gitk:4900 gitk:4935 gitk:6810 gitk:7348 gitk:8859
-#: gitk:8874
+#: gitk:2340 gitk:4918 gitk:4923 gitk:4958 gitk:6833 gitk:7406 gitk:8917
+#: gitk:8932
 msgid "Author"
 msgstr "Автор"
 
-#: gitk:2337 gitk:4895 gitk:6810 gitk:7350
+#: gitk:2340 gitk:4918 gitk:6833 gitk:7408
 msgid "Committer"
 msgstr "Подаващ"
 
-#: gitk:2371
+#: gitk:2374
 msgid "Search"
 msgstr "Търсене"
 
-#: gitk:2379
+#: gitk:2382
 msgid "Diff"
 msgstr "Разлики"
 
-#: gitk:2381
+#: gitk:2384
 msgid "Old version"
 msgstr "Стара версия"
 
-#: gitk:2383
+#: gitk:2386
 msgid "New version"
 msgstr "Нова версия"
 
-#: gitk:2386
+#: gitk:2389
 msgid "Lines of context"
 msgstr "Контекст в редове"
 
-#: gitk:2396
+#: gitk:2399
 msgid "Ignore space change"
 msgstr "Празните знаци без значение"
 
-#: gitk:2400 gitk:2402 gitk:7983 gitk:8235
+#: gitk:2403 gitk:2405 gitk:8041 gitk:8293
 msgid "Line diff"
 msgstr "Поредови разлики"
 
-#: gitk:2467
+#: gitk:2478
 msgid "Patch"
 msgstr "Кръпка"
 
-#: gitk:2469
+#: gitk:2480
 msgid "Tree"
 msgstr "Дърво"
 
-#: gitk:2639 gitk:2660
+#: gitk:2650 gitk:2671
 msgid "Diff this -> selected"
 msgstr "Разлики между това и избраното"
 
-#: gitk:2640 gitk:2661
+#: gitk:2651 gitk:2672
 msgid "Diff selected -> this"
 msgstr "Разлики между избраното и това"
 
-#: gitk:2641 gitk:2662
+#: gitk:2652 gitk:2673
 msgid "Make patch"
 msgstr "Създаване на кръпка"
 
-#: gitk:2642 gitk:9283
+#: gitk:2653 gitk:9341
 msgid "Create tag"
 msgstr "Създаване на етикет"
 
-#: gitk:2643
-msgid "Copy commit summary"
-msgstr "Копиране на информацията за подаване"
+#: gitk:2654
+msgid "Copy commit reference"
+msgstr "Копиране на указателя на подаване"
 
-#: gitk:2644 gitk:9414
+#: gitk:2655 gitk:9472
 msgid "Write commit to file"
 msgstr "Запазване на подаването във файл"
 
-#: gitk:2645
+#: gitk:2656
 msgid "Create new branch"
 msgstr "Създаване на нов клон"
 
-#: gitk:2646
+#: gitk:2657
 msgid "Cherry-pick this commit"
 msgstr "Отбиране на това подаване"
 
-#: gitk:2647
+#: gitk:2658
 msgid "Reset HEAD branch to here"
 msgstr "Привеждане на върха на клона към текущото подаване"
 
-#: gitk:2648
+#: gitk:2659
 msgid "Mark this commit"
 msgstr "Отбелязване на това подаване"
 
-#: gitk:2649
+#: gitk:2660
 msgid "Return to mark"
 msgstr "Връщане към отбелязаното подаване"
 
-#: gitk:2650
+#: gitk:2661
 msgid "Find descendant of this and mark"
 msgstr "Откриване и отбелязване на наследниците"
 
-#: gitk:2651
+#: gitk:2662
 msgid "Compare with marked commit"
 msgstr "Сравнение с отбелязаното подаване"
 
-#: gitk:2652 gitk:2663
+#: gitk:2663 gitk:2674
 msgid "Diff this -> marked commit"
 msgstr "Разлики между това и отбелязаното"
 
-#: gitk:2653 gitk:2664
+#: gitk:2664 gitk:2675
 msgid "Diff marked commit -> this"
 msgstr "Разлики между отбелязаното и това"
 
-#: gitk:2654
+#: gitk:2665
 msgid "Revert this commit"
 msgstr "Отмяна на това подаване"
 
-#: gitk:2670
+#: gitk:2681
 msgid "Check out this branch"
 msgstr "Изтегляне на този клон"
 
-#: gitk:2671
+#: gitk:2682
 msgid "Rename this branch"
 msgstr "Преименуване на този клон"
 
-#: gitk:2672
+#: gitk:2683
 msgid "Remove this branch"
 msgstr "Изтриване на този клон"
 
-#: gitk:2673
+#: gitk:2684
 msgid "Copy branch name"
 msgstr "Копиране на името на клона"
 
-#: gitk:2680
+#: gitk:2691
 msgid "Highlight this too"
 msgstr "Отбелязване и на това"
 
-#: gitk:2681
+#: gitk:2692
 msgid "Highlight this only"
 msgstr "Отбелязване само на това"
 
-#: gitk:2682
+#: gitk:2693
 msgid "External diff"
 msgstr "Външна програма за разлики"
 
-#: gitk:2683
+#: gitk:2694
 msgid "Blame parent commit"
 msgstr "Анотиране на родителското подаване"
 
-#: gitk:2684
+#: gitk:2695
 msgid "Copy path"
 msgstr "Копиране на пътя"
 
-#: gitk:2691
+#: gitk:2702
 msgid "Show origin of this line"
 msgstr "Показване на произхода на този ред"
 
-#: gitk:2692
+#: gitk:2703
 msgid "Run git gui blame on this line"
 msgstr "Изпълнение на „git gui blame“ върху този ред"
 
-#: gitk:3036
+#: gitk:3057
 msgid "About gitk"
 msgstr "Относно gitk"
 
-#: gitk:3038
+#: gitk:3059
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -386,324 +386,324 @@ msgstr ""
 "\n"
 "Използвайте и разпространявайте при условията на ОПЛ на ГНУ"
 
-#: gitk:3046 gitk:3113 gitk:10004
+#: gitk:3067 gitk:3134 gitk:10062
 msgid "Close"
 msgstr "Затваряне"
 
-#: gitk:3067
+#: gitk:3088
 msgid "Gitk key bindings"
 msgstr "Клавишни комбинации"
 
-#: gitk:3070
+#: gitk:3091
 msgid "Gitk key bindings:"
 msgstr "Клавишни комбинации:"
 
-#: gitk:3072
+#: gitk:3093
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tСпиране на програмата"
 
-#: gitk:3073
+#: gitk:3094
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-W>\t\tЗатваряне на прозореца"
 
-#: gitk:3074
+#: gitk:3095
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tКъм първото подаване"
 
-#: gitk:3075
+#: gitk:3096
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tКъм последното подаване"
 
-#: gitk:3076
+#: gitk:3097
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Up>, p, k\tЕдно подаване нагоре"
 
-#: gitk:3077
+#: gitk:3098
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Down>, n, j\tЕдно подаване надолу"
 
-#: gitk:3078
+#: gitk:3099
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Left>, z, h\tНазад в историята"
 
-#: gitk:3079
+#: gitk:3100
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\tНапред в историята"
 
-#: gitk:3080
+#: gitk:3101
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tКъм n-тия родител на текущото подаване в историята"
 
-#: gitk:3081
+#: gitk:3102
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tСтраница нагоре в списъка с подаванията"
 
-#: gitk:3082
+#: gitk:3103
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tСтраница надолу в списъка с подаванията"
 
-#: gitk:3083
+#: gitk:3104
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tКъм началото на списъка с подаванията"
 
-#: gitk:3084
+#: gitk:3105
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tКъм края на списъка с подаванията"
 
-#: gitk:3085
+#: gitk:3106
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tРед нагоре в списъка с подавания"
 
-#: gitk:3086
+#: gitk:3107
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tРед надолу в списъка с подавания"
 
-#: gitk:3087
+#: gitk:3108
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tСтраница нагоре в списъка с подавания"
 
-#: gitk:3088
+#: gitk:3109
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tСтраница надолу в списъка с подавания"
 
-#: gitk:3089
+#: gitk:3110
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\tТърсене назад (визуално нагоре, исторически — последващи)"
 
-#: gitk:3090
+#: gitk:3111
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr ""
 "<Shift-Down>\tТърсене напред (визуално надолу, исторически — предхождащи)"
 
-#: gitk:3091
+#: gitk:3112
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tСтраница нагоре в изгледа за разлики"
 
-#: gitk:3092
+#: gitk:3113
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tСтраница надолу в изгледа за разлики"
 
-#: gitk:3093
+#: gitk:3114
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Space>\t\tСтраница надолу в изгледа за разлики"
 
-#: gitk:3094
+#: gitk:3115
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\t18 реда нагоре в изгледа за разлики"
 
-#: gitk:3095
+#: gitk:3116
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\t18 реда надолу в изгледа за разлики"
 
-#: gitk:3096
+#: gitk:3117
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tТърсене"
 
-#: gitk:3097
+#: gitk:3118
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tКъм следващата поява"
 
-#: gitk:3098
+#: gitk:3119
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\tКъм следващата поява"
 
-#: gitk:3099
+#: gitk:3120
 msgid "g\t\tGo to commit"
 msgstr "g\t\tКъм последното подаване"
 
-#: gitk:3100
+#: gitk:3121
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tФокус върху полето за търсене"
 
-#: gitk:3101
+#: gitk:3122
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tКъм предишната поява"
 
-#: gitk:3102
+#: gitk:3123
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tСледващ файл в изгледа за разлики"
 
-#: gitk:3103
+#: gitk:3124
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tТърсене на следващата поява в изгледа за разлики"
 
-#: gitk:3104
+#: gitk:3125
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tТърсене на предишната поява в изгледа за разлики"
 
-#: gitk:3105
+#: gitk:3126
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tПо-голям размер на шрифта"
 
-#: gitk:3106
+#: gitk:3127
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tПо-голям размер на шрифта"
 
-#: gitk:3107
+#: gitk:3128
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tПо-малък размер на шрифта"
 
-#: gitk:3108
+#: gitk:3129
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tПо-малък размер на шрифта"
 
-#: gitk:3109
+#: gitk:3130
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tОбновяване"
 
-#: gitk:3574 gitk:3583
+#: gitk:3597 gitk:3606
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Грешка при създаването на временната директория „%s“:"
 
-#: gitk:3596
+#: gitk:3619
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Грешка при получаването на „%s“ от %s:"
 
-#: gitk:3659
+#: gitk:3682
 msgid "command failed:"
 msgstr "неуспешно изпълнение на команда:"
 
-#: gitk:3808
+#: gitk:3831
 msgid "No such commit"
 msgstr "Такова подаване няма"
 
-#: gitk:3822
+#: gitk:3845
 msgid "git gui blame: command failed:"
 msgstr "„git gui blame“: неуспешно изпълнение на команда:"
 
-#: gitk:3853
+#: gitk:3876
 #, tcl-format
 msgid "Couldn't read merge head: %s"
-msgstr "Върхът за сливане не може да бъде прочетен: %s"
+msgstr "Върхът за сливане не може да се прочете: %s"
 
-#: gitk:3861
+#: gitk:3884
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Грешка при прочитане на индекса: %s"
 
-#: gitk:3886
+#: gitk:3909
 #, tcl-format
 msgid "Couldn't start git blame: %s"
-msgstr "Командата „git blame“ не може да бъде стартирана: %s"
+msgstr "Командата „git blame“ не може да се стартира: %s"
 
-#: gitk:3889 gitk:6778
+#: gitk:3912 gitk:6801
 msgid "Searching"
 msgstr "Търсене"
 
-#: gitk:3921
+#: gitk:3944
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Грешка при изпълнението на „git blame“: %s"
 
-#: gitk:3949
+#: gitk:3972
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "Този ред идва от подаването %s, което не е в изгледа"
 
-#: gitk:3963
+#: gitk:3986
 msgid "External diff viewer failed:"
 msgstr "Неуспешно изпълнение на външната програма за разлики:"
 
-#: gitk:4067
+#: gitk:4090
 msgid "All files"
 msgstr "Всички файлове"
 
-#: gitk:4091
+#: gitk:4114
 msgid "View"
 msgstr "Изглед"
 
-#: gitk:4094
+#: gitk:4117
 msgid "Gitk view definition"
 msgstr "Дефиниция на изглед в Gitk"
 
-#: gitk:4098
+#: gitk:4121
 msgid "Remember this view"
 msgstr "Запазване на този изглед"
 
-#: gitk:4099
+#: gitk:4122
 msgid "References (space separated list):"
 msgstr "Указатели (списък с разделител интервал):"
 
-#: gitk:4100
+#: gitk:4123
 msgid "Branches & tags:"
 msgstr "Клони и етикети:"
 
-#: gitk:4101
+#: gitk:4124
 msgid "All refs"
 msgstr "Всички указатели"
 
-#: gitk:4102
+#: gitk:4125
 msgid "All (local) branches"
 msgstr "Всички (локални) клони"
 
-#: gitk:4103
+#: gitk:4126
 msgid "All tags"
 msgstr "Всички етикети"
 
-#: gitk:4104
+#: gitk:4127
 msgid "All remote-tracking branches"
 msgstr "Всички следящи клони"
 
-#: gitk:4105
+#: gitk:4128
 msgid "Commit Info (regular expressions):"
 msgstr "Информация за подаване (рег. изр.):"
 
-#: gitk:4106
+#: gitk:4129
 msgid "Author:"
 msgstr "Автор:"
 
-#: gitk:4107
+#: gitk:4130
 msgid "Committer:"
 msgstr "Подал:"
 
-#: gitk:4108
+#: gitk:4131
 msgid "Commit Message:"
 msgstr "Съобщение при подаване:"
 
-#: gitk:4109
+#: gitk:4132
 msgid "Matches all Commit Info criteria"
 msgstr "Съвпадение по всички характеристики на подаването"
 
-#: gitk:4110
+#: gitk:4133
 msgid "Matches no Commit Info criteria"
 msgstr "Не съвпада по никоя от характеристиките на подаването"
 
-#: gitk:4111
+#: gitk:4134
 msgid "Changes to Files:"
 msgstr "Промени по файловете:"
 
-#: gitk:4112
+#: gitk:4135
 msgid "Fixed String"
 msgstr "Дословен низ"
 
-#: gitk:4113
+#: gitk:4136
 msgid "Regular Expression"
 msgstr "Регулярен израз"
 
-#: gitk:4114
+#: gitk:4137
 msgid "Search string:"
 msgstr "Низ за търсене:"
 
-#: gitk:4115
+#: gitk:4138
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
@@ -711,204 +711,208 @@ msgstr ""
 "Дата на подаване („2 weeks ago“ (преди 2 седмици), „2009-03-17 15:27:38“, "
 "„March 17, 2009 15:27:38“):"
 
-#: gitk:4116
+#: gitk:4139
 msgid "Since:"
 msgstr "От:"
 
-#: gitk:4117
+#: gitk:4140
 msgid "Until:"
 msgstr "До:"
 
-#: gitk:4118
+#: gitk:4141
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr ""
 "Ограничаване и/или прескачане на определен брой версии (неотрицателно цяло "
 "число):"
 
-#: gitk:4119
+#: gitk:4142
 msgid "Number to show:"
 msgstr "Брой показани:"
 
-#: gitk:4120
+#: gitk:4143
 msgid "Number to skip:"
 msgstr "Брой прескочени:"
 
-#: gitk:4121
+#: gitk:4144
 msgid "Miscellaneous options:"
 msgstr "Разни:"
 
-#: gitk:4122
+#: gitk:4145
 msgid "Strictly sort by date"
 msgstr "Подреждане по дата"
 
-#: gitk:4123
+#: gitk:4146
 msgid "Mark branch sides"
 msgstr "Отбелязване на страните по клона"
 
-#: gitk:4124
+#: gitk:4147
 msgid "Limit to first parent"
 msgstr "Само първия родител"
 
-#: gitk:4125
+#: gitk:4148
 msgid "Simple history"
 msgstr "Опростена история"
 
-#: gitk:4126
+#: gitk:4149
 msgid "Additional arguments to git log:"
 msgstr "Допълнителни аргументи към „git log“:"
 
-#: gitk:4127
+#: gitk:4150
 msgid "Enter files and directories to include, one per line:"
 msgstr "Въведете файловете и директориите за включване, по елемент на ред"
 
-#: gitk:4128
+#: gitk:4151
 msgid "Command to generate more commits to include:"
 msgstr ""
-"Команда за генерирането на допълнителни подавания, които да бъдат включени:"
+"Команда за генерирането на допълнителни подавания, които да се включат:"
 
-#: gitk:4252
+#: gitk:4275
 msgid "Gitk: edit view"
 msgstr "Gitk: редактиране на изглед"
 
-#: gitk:4260
+#: gitk:4283
 msgid "-- criteria for selecting revisions"
 msgstr "— критерии за избор на версии"
 
-#: gitk:4265
+#: gitk:4288
 msgid "View Name"
 msgstr "Име на изглед"
 
-#: gitk:4340
+#: gitk:4363
 msgid "Apply (F5)"
 msgstr "Прилагане (F5)"
 
-#: gitk:4378
+#: gitk:4401
 msgid "Error in commit selection arguments:"
 msgstr "Грешка в аргументите за избор на подавания:"
 
-#: gitk:4433 gitk:4486 gitk:4948 gitk:4962 gitk:6232 gitk:12524 gitk:12525
+#: gitk:4456 gitk:4509 gitk:4971 gitk:4985 gitk:6255 gitk:12615 gitk:12616
 msgid "None"
 msgstr "Няма"
 
-#: gitk:5045 gitk:5050
+#: gitk:5068 gitk:5073
 msgid "Descendant"
 msgstr "Наследник"
 
-#: gitk:5046
+#: gitk:5069
 msgid "Not descendant"
 msgstr "Не е наследник"
 
-#: gitk:5053 gitk:5058
+#: gitk:5076 gitk:5081
 msgid "Ancestor"
 msgstr "Предшественик"
 
-#: gitk:5054
+#: gitk:5077
 msgid "Not ancestor"
 msgstr "Не е предшественик"
 
-#: gitk:5348
+#: gitk:5371
 msgid "Local changes checked in to index but not committed"
 msgstr "Локални промени добавени към индекса, но неподадени"
 
-#: gitk:5384
+#: gitk:5407
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Локални промени извън индекса"
 
-#: gitk:7158
+#: gitk:7155
+msgid "Error starting web browser:"
+msgstr "Грешка при стартирането на уеб браузър:"
+
+#: gitk:7216
 msgid "and many more"
 msgstr "и още много"
 
-#: gitk:7161
+#: gitk:7219
 msgid "many"
 msgstr "много"
 
-#: gitk:7352
+#: gitk:7410
 msgid "Tags:"
 msgstr "Етикети:"
 
-#: gitk:7369 gitk:7375 gitk:8854
+#: gitk:7427 gitk:7433 gitk:8912
 msgid "Parent"
 msgstr "Родител"
 
-#: gitk:7380
+#: gitk:7438
 msgid "Child"
 msgstr "Дете"
 
-#: gitk:7389
+#: gitk:7447
 msgid "Branch"
 msgstr "Клон"
 
-#: gitk:7392
+#: gitk:7450
 msgid "Follows"
 msgstr "Следва"
 
-#: gitk:7395
+#: gitk:7453
 msgid "Precedes"
 msgstr "Предшества"
 
-#: gitk:7990
+#: gitk:8048
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Грешка при получаването на разликите: %s"
 
-#: gitk:8679
+#: gitk:8737
 msgid "Goto:"
 msgstr "Към ред:"
 
-#: gitk:8700
+#: gitk:8758
 #, tcl-format
 msgid "Short SHA1 id %s is ambiguous"
 msgstr "Съкратената сума по SHA1 %s не е еднозначна"
 
-#: gitk:8707
+#: gitk:8765
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Непозната версия %s"
 
-#: gitk:8717
+#: gitk:8775
 #, tcl-format
 msgid "SHA1 id %s is not known"
 msgstr "Непозната сума по SHA1 %s"
 
-#: gitk:8719
+#: gitk:8777
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Версия %s не е в текущия изглед"
 
-#: gitk:8861 gitk:8876
+#: gitk:8919 gitk:8934
 msgid "Date"
 msgstr "Дата"
 
-#: gitk:8864
+#: gitk:8922
 msgid "Children"
 msgstr "Деца"
 
-#: gitk:8927
+#: gitk:8985
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Зануляване на клона „%s“ към текущото подаване"
 
-#: gitk:8929
+#: gitk:8987
 msgid "Detached head: can't reset"
 msgstr "Несвързан връх: невъзможно зануляване"
 
-#: gitk:9034 gitk:9040
+#: gitk:9092 gitk:9098
 msgid "Skipping merge commit "
 msgstr "Пропускане на подаването на сливането"
 
-#: gitk:9049 gitk:9054
+#: gitk:9107 gitk:9112
 msgid "Error getting patch ID for "
 msgstr "Грешка при получаването на идентификатора на "
 
-#: gitk:9050 gitk:9055
+#: gitk:9108 gitk:9113
 msgid " - stopping\n"
 msgstr " — спиране\n"
 
-#: gitk:9060 gitk:9063 gitk:9071 gitk:9085 gitk:9094
+#: gitk:9118 gitk:9121 gitk:9129 gitk:9143 gitk:9152
 msgid "Commit "
 msgstr "Подаване"
 
-#: gitk:9064
+#: gitk:9122
 msgid ""
 " is the same patch as\n"
 "       "
@@ -916,7 +920,7 @@ msgstr ""
 " е същата кръпка като\n"
 "       "
 
-#: gitk:9072
+#: gitk:9130
 msgid ""
 " differs from\n"
 "       "
@@ -924,7 +928,7 @@ msgstr ""
 " се различава от\n"
 "       "
 
-#: gitk:9074
+#: gitk:9132
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -932,147 +936,147 @@ msgstr ""
 "Разлика между подаванията:\n"
 "\n"
 
-#: gitk:9086 gitk:9095
+#: gitk:9144 gitk:9153
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " има %s деца — спиране\n"
 
-#: gitk:9114
+#: gitk:9172
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Грешка при запазването на подаването във файл: %s"
 
-#: gitk:9120
+#: gitk:9178
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Грешка при изчисляването на разликите между подаванията: %s"
 
-#: gitk:9166
+#: gitk:9224
 msgid "Top"
 msgstr "Най-горе"
 
-#: gitk:9167
+#: gitk:9225
 msgid "From"
 msgstr "От"
 
-#: gitk:9172
+#: gitk:9230
 msgid "To"
 msgstr "До"
 
-#: gitk:9196
+#: gitk:9254
 msgid "Generate patch"
 msgstr "Генериране на кръпка"
 
-#: gitk:9198
+#: gitk:9256
 msgid "From:"
 msgstr "От:"
 
-#: gitk:9207
+#: gitk:9265
 msgid "To:"
 msgstr "До:"
 
-#: gitk:9216
+#: gitk:9274
 msgid "Reverse"
 msgstr "Обръщане"
 
-#: gitk:9218 gitk:9428
+#: gitk:9276 gitk:9486
 msgid "Output file:"
 msgstr "Запазване във файла:"
 
-#: gitk:9224
+#: gitk:9282
 msgid "Generate"
 msgstr "Генериране"
 
-#: gitk:9262
+#: gitk:9320
 msgid "Error creating patch:"
 msgstr "Грешка при създаването на кръпка:"
 
-#: gitk:9285 gitk:9416 gitk:9504
+#: gitk:9343 gitk:9474 gitk:9562
 msgid "ID:"
 msgstr "Идентификатор:"
 
-#: gitk:9294
+#: gitk:9352
 msgid "Tag name:"
 msgstr "Име на етикет:"
 
-#: gitk:9297
+#: gitk:9355
 msgid "Tag message is optional"
 msgstr "Съобщението за етикет е незадължително"
 
-#: gitk:9299
+#: gitk:9357
 msgid "Tag message:"
 msgstr "Съобщение за етикет:"
 
-#: gitk:9303 gitk:9474
+#: gitk:9361 gitk:9532
 msgid "Create"
 msgstr "Създаване"
 
-#: gitk:9321
+#: gitk:9379
 msgid "No tag name specified"
 msgstr "Липсва име на етикет"
 
-#: gitk:9325
+#: gitk:9383
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Етикетът „%s“ вече съществува"
 
-#: gitk:9335
+#: gitk:9393
 msgid "Error creating tag:"
 msgstr "Грешка при създаването на етикет:"
 
-#: gitk:9425
+#: gitk:9483
 msgid "Command:"
 msgstr "Команда:"
 
-#: gitk:9433
+#: gitk:9491
 msgid "Write"
 msgstr "Запазване"
 
-#: gitk:9451
+#: gitk:9509
 msgid "Error writing commit:"
 msgstr "Грешка при запазването на подаването:"
 
-#: gitk:9473
+#: gitk:9531
 msgid "Create branch"
 msgstr "Създаване на клон"
 
-#: gitk:9489
+#: gitk:9547
 #, tcl-format
 msgid "Rename branch %s"
 msgstr "Преименуване на клона „%s“"
 
-#: gitk:9490
+#: gitk:9548
 msgid "Rename"
 msgstr "Преименуване"
 
-#: gitk:9514
+#: gitk:9572
 msgid "Name:"
 msgstr "Име:"
 
-#: gitk:9538
+#: gitk:9596
 msgid "Please specify a name for the new branch"
 msgstr "Укажете име за новия клон"
 
-#: gitk:9543
+#: gitk:9601
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
-msgstr "Клонът „%s“ вече съществува. Да бъде ли презаписан?"
+msgstr "Клонът „%s“ вече съществува. Да се презапише ли?"
 
-#: gitk:9587
+#: gitk:9645
 msgid "Please specify a new name for the branch"
 msgstr "Укажете ново име за клона"
 
-#: gitk:9650
+#: gitk:9708
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
-"Подаването „%s“ вече е включено в клона „%s“ — да бъде ли приложено отново?"
+"Подаването „%s“ вече е включено в клона „%s“ — да се приложи ли отново?"
 
-#: gitk:9655
+#: gitk:9713
 msgid "Cherry-picking"
 msgstr "Отбиране"
 
-#: gitk:9664
+#: gitk:9722
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1081,7 +1085,7 @@ msgstr ""
 "Неуспешно отбиране, защото във файла „%s“ има локални промени.\n"
 "Подайте, занулете или ги скатайте и пробвайте отново."
 
-#: gitk:9670
+#: gitk:9728
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1089,20 +1093,20 @@ msgstr ""
 "Неуспешно отбиране поради конфликти при сливане.\n"
 "Искате ли да ги коригирате чрез „git citool“?"
 
-#: gitk:9686 gitk:9744
+#: gitk:9744 gitk:9802
 msgid "No changes committed"
 msgstr "Не са подадени промени"
 
-#: gitk:9713
+#: gitk:9771
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr "Подаването „%s“ не е включено в клона „%s“. Да бъде ли отменено?"
+msgstr "Подаването „%s“ не е включено в клона „%s“. Да се отменени ли?"
 
-#: gitk:9718
+#: gitk:9776
 msgid "Reverting"
 msgstr "Отмяна"
 
-#: gitk:9726
+#: gitk:9784
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
@@ -1111,7 +1115,7 @@ msgstr ""
 "Неуспешна отмяна, защото във файла „%s“ има локални промени.\n"
 "Подайте, занулете или ги скатайте и пробвайте отново."
 
-#: gitk:9730
+#: gitk:9788
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1119,53 +1123,53 @@ msgstr ""
 "Неуспешно отмяна поради конфликти при сливане.\n"
 "Искате ли да ги коригирате чрез „git citool“?"
 
-#: gitk:9773
+#: gitk:9831
 msgid "Confirm reset"
 msgstr "Потвърждаване на зануляването"
 
-#: gitk:9775
+#: gitk:9833
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Да се занули ли клонът „%s“ към „%s“?"
 
-#: gitk:9777
+#: gitk:9835
 msgid "Reset type:"
 msgstr "Вид зануляване:"
 
-#: gitk:9780
+#: gitk:9838
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Слабо: работното дърво и индекса остават същите"
 
-#: gitk:9783
+#: gitk:9841
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Смесено: работното дърво остава същото, индексът се занулява"
 
-#: gitk:9786
+#: gitk:9844
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
 msgstr ""
 "Силно: зануляване и на работното дърво, и на индекса\n"
-"(ВСИЧКИ локални промени ще бъдат безвъзвратно загубени)"
+"(ВСИЧКИ локални промени ще се загубят безвъзвратно)"
 
-#: gitk:9803
+#: gitk:9861
 msgid "Resetting"
 msgstr "Зануляване"
 
-#: gitk:9876
+#: gitk:9934
 #, tcl-format
 msgid "A local branch named %s exists already"
 msgstr "Вече съществува локален клон „%s“."
 
-#: gitk:9884
+#: gitk:9942
 msgid "Checking out"
 msgstr "Изтегляне"
 
-#: gitk:9943
+#: gitk:10001
 msgid "Cannot delete the currently checked-out branch"
-msgstr "Текущо изтегленият клон не може да бъде изтрит"
+msgstr "Текущо изтегленият клон не може да се изтрие"
 
-#: gitk:9949
+#: gitk:10007
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1174,16 +1178,16 @@ msgstr ""
 "Подаванията на клона „%s“ не са на никой друг клон.\n"
 "Наистина ли искате да изтриете клона „%s“?"
 
-#: gitk:9980
+#: gitk:10038
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Етикети и върхове: %s"
 
-#: gitk:9997
+#: gitk:10055
 msgid "Filter"
 msgstr "Филтриране"
 
-#: gitk:10293
+#: gitk:10356
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
@@ -1191,201 +1195,221 @@ msgstr ""
 "Грешка при прочитането на топологията на подаванията. Информацията за клона "
 "и предшестващите/следващите етикети ще е непълна."
 
-#: gitk:11270
+#: gitk:11333
 msgid "Tag"
 msgstr "Етикет"
 
-#: gitk:11274
+#: gitk:11337
 msgid "Id"
 msgstr "Идентификатор"
 
-#: gitk:11357
+#: gitk:11420
 msgid "Gitk font chooser"
 msgstr "Избор на шрифт за Gitk"
 
-#: gitk:11374
+#: gitk:11437
 msgid "B"
 msgstr "Ч"
 
-#: gitk:11377
+#: gitk:11440
 msgid "I"
 msgstr "К"
 
-#: gitk:11495
+#: gitk:11558
 msgid "Commit list display options"
 msgstr "Настройки на списъка с подавания"
 
-#: gitk:11498
+#: gitk:11561
 msgid "Maximum graph width (lines)"
 msgstr "Максимална широчина на графа (в редове)"
 
-#: gitk:11502
+#: gitk:11565
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Максимална широчина на графа (% от панела)"
 
-#: gitk:11505
+#: gitk:11568
 msgid "Show local changes"
 msgstr "Показване на локалните промени"
 
-#: gitk:11508
+#: gitk:11571
 msgid "Auto-select SHA1 (length)"
 msgstr "Автоматично избиране на SHA1 (дължина)"
 
-#: gitk:11512
+#: gitk:11575
 msgid "Hide remote refs"
 msgstr "Скриване на отдалечените указатели"
 
-#: gitk:11516
+#: gitk:11579
 msgid "Diff display options"
 msgstr "Настройки на показването на разликите"
 
-#: gitk:11518
+#: gitk:11581
 msgid "Tab spacing"
 msgstr "Широчина на табулатора"
 
-#: gitk:11521
+#: gitk:11584
 msgid "Display nearby tags/heads"
 msgstr "Извеждане на близките етикети и върхове"
 
-#: gitk:11524
+#: gitk:11587
 msgid "Maximum # tags/heads to show"
 msgstr "Максимален брой етикети/върхове за показване"
 
-#: gitk:11527
+#: gitk:11590
 msgid "Limit diffs to listed paths"
 msgstr "Разлика само в избраните пътища"
 
-#: gitk:11530
+#: gitk:11593
 msgid "Support per-file encodings"
 msgstr "Поддръжка на различни кодирания за всеки файл"
 
-#: gitk:11536 gitk:11683
+#: gitk:11599 gitk:11766
 msgid "External diff tool"
 msgstr "Външен инструмент за разлики"
 
-#: gitk:11537
+#: gitk:11600
 msgid "Choose..."
 msgstr "Избор…"
 
-#: gitk:11542
+#: gitk:11607
+msgid "Web browser"
+msgstr "Уеб браузър"
+
+#: gitk:11612
 msgid "General options"
 msgstr "Общи настройки"
 
-#: gitk:11545
+#: gitk:11615
 msgid "Use themed widgets"
 msgstr "Използване на тема за графичните обекти"
 
-#: gitk:11547
+#: gitk:11617
 msgid "(change requires restart)"
 msgstr "(промяната изисква рестартиране на Gitk)"
 
-#: gitk:11549
+#: gitk:11619
 msgid "(currently unavailable)"
 msgstr "(в момента недостъпно)"
 
-#: gitk:11560
+#: gitk:11631
 msgid "Colors: press to choose"
 msgstr "Цветове: избира се с натискане"
 
-#: gitk:11563
+#: gitk:11634
 msgid "Interface"
 msgstr "Интерфейс"
 
-#: gitk:11564
+#: gitk:11635
 msgid "interface"
 msgstr "интерфейс"
 
-#: gitk:11567
+#: gitk:11638
 msgid "Background"
 msgstr "Фон"
 
-#: gitk:11568 gitk:11598
+#: gitk:11639 gitk:11681
 msgid "background"
 msgstr "фон"
 
-#: gitk:11571
+#: gitk:11642
 msgid "Foreground"
 msgstr "Знаци"
 
-#: gitk:11572
+#: gitk:11643
 msgid "foreground"
 msgstr "знаци"
 
-#: gitk:11575
+#: gitk:11646
 msgid "Diff: old lines"
 msgstr "Разлика: стари редове"
 
-#: gitk:11576
+#: gitk:11647
 msgid "diff old lines"
 msgstr "разлика, стари редове"
 
-#: gitk:11580
+#: gitk:11651
+msgid "Diff: old lines bg"
+msgstr "Разлика: фон на стари редове"
+
+#: gitk:11653
+msgid "diff old lines bg"
+msgstr "разлика, фон на стари редове"
+
+#: gitk:11657
 msgid "Diff: new lines"
 msgstr "Разлика: нови редове"
 
-#: gitk:11581
+#: gitk:11658
 msgid "diff new lines"
 msgstr "разлика, нови редове"
 
-#: gitk:11585
+#: gitk:11662
+msgid "Diff: new lines bg"
+msgstr "Разлика: фон на нови редове"
+
+#: gitk:11664
+msgid "diff new lines bg"
+msgstr "разлика, фон на нови редове"
+
+#: gitk:11668
 msgid "Diff: hunk header"
 msgstr "Разлика: начало на парче"
 
-#: gitk:11587
+#: gitk:11670
 msgid "diff hunk header"
 msgstr "разлика, начало на парче"
 
-#: gitk:11591
+#: gitk:11674
 msgid "Marked line bg"
 msgstr "Фон на отбелязан ред"
 
-#: gitk:11593
+#: gitk:11676
 msgid "marked line background"
 msgstr "фон на отбелязан ред"
 
-#: gitk:11597
+#: gitk:11680
 msgid "Select bg"
 msgstr "Избор на фон"
 
-#: gitk:11606
+#: gitk:11689
 msgid "Fonts: press to choose"
 msgstr "Шрифтове: избира се с натискане"
 
-#: gitk:11608
+#: gitk:11691
 msgid "Main font"
 msgstr "Основен шрифт"
 
-#: gitk:11609
+#: gitk:11692
 msgid "Diff display font"
 msgstr "Шрифт за разликите"
 
-#: gitk:11610
+#: gitk:11693
 msgid "User interface font"
 msgstr "Шрифт на интерфейса"
 
-#: gitk:11632
+#: gitk:11715
 msgid "Gitk preferences"
 msgstr "Настройки на Gitk"
 
-#: gitk:11641
+#: gitk:11724
 msgid "General"
 msgstr "Общи"
 
-#: gitk:11642
+#: gitk:11725
 msgid "Colors"
 msgstr "Цветове"
 
-#: gitk:11643
+#: gitk:11726
 msgid "Fonts"
 msgstr "Шрифтове"
 
-#: gitk:11693
+#: gitk:11776
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: избор на цвят на „%s“"
 
-#: gitk:12206
+#: gitk:12289
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1393,15 +1417,15 @@ msgstr ""
 "Тази версия на Tcl/Tk не се поддържа от Gitk.\n"
 " Необходима ви е поне Tcl/Tk 8.4."
 
-#: gitk:12416
+#: gitk:12507
 msgid "Cannot find a git repository here."
 msgstr "Тук липсва хранилище на Git."
 
-#: gitk:12463
+#: gitk:12554
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Нееднозначен аргумент „%s“: има и такава версия, и такъв файл"
 
-#: gitk:12475
+#: gitk:12566
 msgid "Bad arguments to gitk:"
 msgstr "Неправилни аргументи на gitk:"
-- 
2.47.1

