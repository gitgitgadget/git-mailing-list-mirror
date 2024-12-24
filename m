Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E61BFE0C
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035500; cv=none; b=SbGnWsM9HU2EZ91aZcsdnNTCmOBhAG1zJv78xYqzbEi1mManmsbAZcH5Hlee4k+26rzyAjI3Q+cKIwGPZ3QmPSYKMBJPPfwq1THqJZJ+h1S2IwLSGYo3fOo+Jr7BD2g76kRU7n/mCp7BbQGUHIQkeyU82E8eQ39zY6M3v/kw5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035500; c=relaxed/simple;
	bh=VeBUxEjo6m7d++Nuwg9aR5ViIfaT3EdjVn6ungSlhis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mji5+ewurODdwVMnw2sTdvaYRj6/4IoBJuMMQqayK478eWCc7rWsN8RMu/R3yxn1YDFNjbXMmY7enimXG5FG6PJsSwZGdvn7+hxqOTinue19MecW1bdU0YGb00wXNrVbkFr7mwqTDWvRI4q+FGlh8LzuQEDVl2NQM0dr+iXbwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=iacwwXtC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="iacwwXtC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8234623a12.2
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735035494; x=1735640294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvjL1hXeAftAgSdelvmOTIHQcl8zqu4ZwmMwQWi582k=;
        b=iacwwXtCuEQWHlGdl0dN3cHgvnhwCEc8t1Hv3COfiEAmAzVjiv2GOSaRkST7+Z/cau
         gusKPjx8y/Oeyz7kM+M8EKCLUcqlNRY4gPrvYwthyubVSisMn3MU/XoNqon3wqgsqDT7
         8cDefmS5Amm6j1C7QESsdgfPOfyOwAY7fUt6OjvL/ukJoCT0lxY7tBIMXJ/A5Pk1Icko
         7e0y3mWjDh5q46qan0mRQvHSQQr6VgEnEUTQa91e7r9cW/VQQ2mcy15GxXE3EsVk8OQm
         Arh4+kB5XhNf73P3mlFUmy6kjxUftEmY6pKzXMKyRDfHOdQgAFpxBSYMbyDxEWgQCEdc
         zhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735035494; x=1735640294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvjL1hXeAftAgSdelvmOTIHQcl8zqu4ZwmMwQWi582k=;
        b=jHsVJF6MkWuaajYpPCJpFadejfZT0vtnN1J7JpJGUtdLOmLahA5jhBNTXCXVLRRsEn
         GIkHJwlkRejfihcGe8pRyRrYaG7Mgm/xQJW5ACkaO8CWcCbLbkf3OJxuLgN6ov/l73jn
         GrHJr81M6nBWnp23KnP20BbWTvOOUx6TFBbzOBaHxEMS3vEC9k0ih5psxyz+PD55rp7d
         kuTzKszBwpFjTupjs1vrHJmEo7Ki+sNgoCw9F8ZXlS3cc98aXYEHGNYFQiXF8U9C95vw
         P7FFowOxNv3Hhb8PsKjCJxQKoLmJozHHFqXcjGLX1Zqirw/tB3xSbXqfJ0g3QqX82+Xy
         Az8w==
X-Forwarded-Encrypted: i=1; AJvYcCVVpZJk1mmS52jSO1WCIM96BYY0x5YKc1XSnUJ0RYo30oqjgPge4ZhLwaOL0710Tod47bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOTiHwlCWabXa+x3wUfU2yrfFymz1fEFbF9OGI82pgBTbloRZ
	SI4uUcEns3uYd8zxdOvnQ2Y0cuqmYHnp1HYgpXrVX6GeJuW6vBlgpQ+0FAYJQGpEf7zMBFyaxJ+
	opzs=
X-Gm-Gg: ASbGncuPgA36W2QgBz7fmSXBGkMYp4YtAWjTJNJoRPGxBxZOaQM8GYmZquO49S0J172
	YStqZychU9kmExL56yLq0gdAYbKrCoPwSxDtDFk9sJ2dOhXg0OLyBUsnbfLShZfQm7yAuhK3x+2
	FjqjL7yQgKtG9AdY9l03QWx2wN1xv70+GC2tto0kBGIoTdVReFhHpCWnf9fdIHtIghWZMYML5jo
	yOZoGVn5RKsqVxut4W2yrigocAjaGMxb5H6EKvWSA5fx3QwtuVr6JioBzPKB/mM7EP5BqWmzoDU
	0vR8L8TzPGobpzxjqpvk1nikVQ==
X-Google-Smtp-Source: AGHT+IFU2LiQskS2iWTsbV/Ic7LmS3V+chwniVmLX6LTukwuCSWowsCEAywDg9KWi/GGPc6ArWoEFQ==
X-Received: by 2002:a05:6402:2802:b0:5d2:723c:a568 with SMTP id 4fb4d7f45d1cf-5d81ddf3ba0mr16366962a12.10.1735035493999;
        Tue, 24 Dec 2024 02:18:13 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f0e4sm6000993a12.42.2024.12.24.02.18.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Dec 2024 02:18:13 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: j6t@kdbg.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 2 1/1] gitk: Update Bulgarian translation (327t)
Date: Tue, 24 Dec 2024 11:17:58 +0100
Message-ID: <20241224101802.13762-4-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
References: <af81f74b-b5ef-4557-b929-c56fc3309d29@kdbg.org>
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
 po/bg.po | 730 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 385 insertions(+), 345 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 87ab1fac24..773a049831 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -1,15 +1,15 @@
 # Bulgarian translation of gitk po-file.
-# Copyright (C) 2014, 2015, 2019 Alexander Shopov <ash@kambanaria.org>.
+# Copyright (C) 2014, 2015, 2019, 2020, 2024 Alexander Shopov <ash@kambanaria.org>.
 # This file is distributed under the same license as the git package.
-# Alexander Shopov <ash@kambanaria.org>, 2014, 2015, 2019.
+# Alexander Shopov <ash@kambanaria.org>, 2014, 2015, 2019, 2020, 2024.
 #
 #
 msgid ""
 msgstr ""
 "Project-Id-Version: gitk master\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2019-03-04 11:27+0100\n"
-"PO-Revision-Date: 2019-03-04 11:39+0100\n"
+"POT-Creation-Date: 2024-12-24 11:01+0100\n"
+"PO-Revision-Date: 2024-12-24 11:05+0100\n"
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
+#: gitk:211 gitk:2430
 msgid "Color words"
 msgstr "Оцветяване на думите"
 
-#: gitk:217 gitk:2403 gitk:8249 gitk:8282
+#: gitk:216 gitk:2430 gitk:8335 gitk:8368
 msgid "Markup words"
 msgstr "Отбелязване на думите"
 
-#: gitk:324
+#: gitk:323
 msgid "Error parsing revisions:"
 msgstr "Грешка при анализ на версиите:"
 
-#: gitk:380
+#: gitk:389
 msgid "Error executing --argscmd command:"
 msgstr "Грешка при изпълнение на командата с „--argscmd“."
 
-#: gitk:393
+#: gitk:402
 msgid "No files selected: --merge specified but no files are unmerged."
 msgstr ""
 "Не са избрани файлове — указана е опцията „--merge“, но няма неслети файлове."
 
-#: gitk:396
+#: gitk:405
 msgid ""
 "No files selected: --merge specified but no unmerged files are within file "
 "limit."
@@ -51,326 +51,326 @@ msgstr ""
 "Не са избрани файлове — указана е опцията „--merge“, но няма неслети файлове "
 "в ограниченията."
 
-#: gitk:418 gitk:566
+#: gitk:430 gitk:585
 msgid "Error executing git log:"
 msgstr "Грешка при изпълнение на „git log“:"
 
-#: gitk:436 gitk:582
+#: gitk:448 gitk:601
 msgid "Reading"
 msgstr "Прочитане"
 
-#: gitk:496 gitk:4549
+#: gitk:508 gitk:4596
 msgid "Reading commits..."
 msgstr "Прочитане на подаванията…"
 
-#: gitk:499 gitk:1641 gitk:4552
+#: gitk:511 gitk:1660 gitk:4599
 msgid "No commits selected"
 msgstr "Не са избрани подавания"
 
-#: gitk:1449 gitk:4069 gitk:12583
+#: gitk:1468 gitk:4116 gitk:12738
 msgid "Command line"
 msgstr "Команден ред"
 
-#: gitk:1515
+#: gitk:1534
 msgid "Can't parse git log output:"
 msgstr "Изходът от „git log“ не може да се анализира:"
 
-#: gitk:1744
+#: gitk:1763
 msgid "No commit information available"
 msgstr "Липсва информация за подавания"
 
-#: gitk:1907 gitk:1936 gitk:4339 gitk:9789 gitk:11388 gitk:11668
+#: gitk:1930 gitk:1959 gitk:4386 gitk:9875 gitk:11485 gitk:11805
 msgid "OK"
 msgstr "Добре"
 
-#: gitk:1938 gitk:4341 gitk:9225 gitk:9304 gitk:9434 gitk:9520 gitk:9791
-#: gitk:11389 gitk:11669
+#: gitk:1961 gitk:4388 gitk:9311 gitk:9390 gitk:9520 gitk:9606 gitk:9877
+#: gitk:11486 gitk:11806
 msgid "Cancel"
 msgstr "Отказ"
 
-#: gitk:2087
+#: gitk:2114
 msgid "&Update"
 msgstr "&Обновяване"
 
-#: gitk:2088
+#: gitk:2115
 msgid "&Reload"
 msgstr "&Презареждане"
 
-#: gitk:2089
+#: gitk:2116
 msgid "Reread re&ferences"
-msgstr "&Наново прочитане"
+msgstr "Прочитане &наново"
 
-#: gitk:2090
+#: gitk:2117
 msgid "&List references"
 msgstr "&Изброяване на указателите"
 
-#: gitk:2092
+#: gitk:2119
 msgid "Start git &gui"
 msgstr "&Стартиране на „git gui“"
 
-#: gitk:2094
+#: gitk:2121
 msgid "&Quit"
 msgstr "&Спиране на програмата"
 
-#: gitk:2086
+#: gitk:2113
 msgid "&File"
 msgstr "&Файл"
 
-#: gitk:2098
+#: gitk:2125
 msgid "&Preferences"
 msgstr "&Настройки"
 
-#: gitk:2097
+#: gitk:2124
 msgid "&Edit"
 msgstr "&Редактиране"
 
-#: gitk:2102
+#: gitk:2129
 msgid "&New view..."
 msgstr "&Нов изглед…"
 
-#: gitk:2103
+#: gitk:2130
 msgid "&Edit view..."
 msgstr "&Редактиране на изгледа…"
 
-#: gitk:2104
+#: gitk:2131
 msgid "&Delete view"
 msgstr "&Изтриване на изгледа"
 
-#: gitk:2106
+#: gitk:2133
 msgid "&All files"
 msgstr "&Всички файлове"
 
-#: gitk:2101
+#: gitk:2128
 msgid "&View"
 msgstr "&Изглед"
 
-#: gitk:2111 gitk:2121
+#: gitk:2138 gitk:2148
 msgid "&About gitk"
 msgstr "&Относно gitk"
 
-#: gitk:2112 gitk:2126
+#: gitk:2139 gitk:2153
 msgid "&Key bindings"
 msgstr "&Клавишни комбинации"
 
-#: gitk:2110 gitk:2125
+#: gitk:2137 gitk:2152
 msgid "&Help"
 msgstr "Помо&щ"
 
-#: gitk:2203 gitk:8681
-msgid "SHA1 ID:"
-msgstr "SHA1:"
+#: gitk:2230 gitk:8767
+msgid "Commit ID:"
+msgstr "Подаване:"
 
-#: gitk:2247
+#: gitk:2274
 msgid "Row"
 msgstr "Ред"
 
-#: gitk:2285
+#: gitk:2312
 msgid "Find"
 msgstr "Търсене"
 
-#: gitk:2313
+#: gitk:2340
 msgid "commit"
 msgstr "подаване"
 
-#: gitk:2317 gitk:2319 gitk:4711 gitk:4734 gitk:4758 gitk:6779 gitk:6851
-#: gitk:6936
+#: gitk:2344 gitk:2346 gitk:4758 gitk:4781 gitk:4805 gitk:6826 gitk:6898
+#: gitk:6983
 msgid "containing:"
 msgstr "съдържащо:"
 
-#: gitk:2320 gitk:3550 gitk:3555 gitk:4787
+#: gitk:2347 gitk:3597 gitk:3602 gitk:4834
 msgid "touching paths:"
 msgstr "в пътищата:"
 
-#: gitk:2321 gitk:4801
+#: gitk:2348 gitk:4848
 msgid "adding/removing string:"
 msgstr "добавящо/премахващо низ"
 
-#: gitk:2322 gitk:4803
+#: gitk:2349 gitk:4850
 msgid "changing lines matching:"
 msgstr "променящо редове напасващи:"
 
-#: gitk:2331 gitk:2333 gitk:4790
+#: gitk:2358 gitk:2360 gitk:4837
 msgid "Exact"
 msgstr "Точно"
 
-#: gitk:2333 gitk:4878 gitk:6747
+#: gitk:2360 gitk:4925 gitk:6794
 msgid "IgnCase"
 msgstr "Без регистър"
 
-#: gitk:2333 gitk:4760 gitk:4876 gitk:6743
+#: gitk:2360 gitk:4807 gitk:4923 gitk:6790
 msgid "Regexp"
 msgstr "Рег. израз"
 
-#: gitk:2335 gitk:2336 gitk:4898 gitk:4928 gitk:4935 gitk:6872 gitk:6940
+#: gitk:2362 gitk:2363 gitk:4945 gitk:4975 gitk:4982 gitk:6919 gitk:6987
 msgid "All fields"
 msgstr "Всички полета"
 
-#: gitk:2336 gitk:4895 gitk:4928 gitk:6810
+#: gitk:2363 gitk:4942 gitk:4975 gitk:6857
 msgid "Headline"
 msgstr "Първи ред"
 
-#: gitk:2337 gitk:4895 gitk:6810 gitk:6940 gitk:7413
+#: gitk:2364 gitk:4942 gitk:6857 gitk:6987 gitk:7499
 msgid "Comments"
 msgstr "Коментари"
 
-#: gitk:2337 gitk:4895 gitk:4900 gitk:4935 gitk:6810 gitk:7348 gitk:8859
-#: gitk:8874
+#: gitk:2364 gitk:4942 gitk:4947 gitk:4982 gitk:6857 gitk:7434 gitk:8945
+#: gitk:8960
 msgid "Author"
 msgstr "Автор"
 
-#: gitk:2337 gitk:4895 gitk:6810 gitk:7350
+#: gitk:2364 gitk:4942 gitk:6857 gitk:7436
 msgid "Committer"
 msgstr "Подаващ"
 
-#: gitk:2371
+#: gitk:2398
 msgid "Search"
 msgstr "Търсене"
 
-#: gitk:2379
+#: gitk:2406
 msgid "Diff"
 msgstr "Разлики"
 
-#: gitk:2381
+#: gitk:2408
 msgid "Old version"
 msgstr "Стара версия"
 
-#: gitk:2383
+#: gitk:2410
 msgid "New version"
 msgstr "Нова версия"
 
-#: gitk:2386
+#: gitk:2413
 msgid "Lines of context"
 msgstr "Контекст в редове"
 
-#: gitk:2396
+#: gitk:2423
 msgid "Ignore space change"
 msgstr "Празните знаци без значение"
 
-#: gitk:2400 gitk:2402 gitk:7983 gitk:8235
+#: gitk:2427 gitk:2429 gitk:8069 gitk:8321
 msgid "Line diff"
 msgstr "Поредови разлики"
 
-#: gitk:2467
+#: gitk:2502
 msgid "Patch"
 msgstr "Кръпка"
 
-#: gitk:2469
+#: gitk:2504
 msgid "Tree"
 msgstr "Дърво"
 
-#: gitk:2639 gitk:2660
+#: gitk:2674 gitk:2695
 msgid "Diff this -> selected"
 msgstr "Разлики между това и избраното"
 
-#: gitk:2640 gitk:2661
+#: gitk:2675 gitk:2696
 msgid "Diff selected -> this"
 msgstr "Разлики между избраното и това"
 
-#: gitk:2641 gitk:2662
+#: gitk:2676 gitk:2697
 msgid "Make patch"
 msgstr "Създаване на кръпка"
 
-#: gitk:2642 gitk:9283
+#: gitk:2677 gitk:9369
 msgid "Create tag"
 msgstr "Създаване на етикет"
 
-#: gitk:2643
-msgid "Copy commit summary"
-msgstr "Копиране на информацията за подаване"
+#: gitk:2678
+msgid "Copy commit reference"
+msgstr "Копиране на указателя на подаване"
 
-#: gitk:2644 gitk:9414
+#: gitk:2679 gitk:9500
 msgid "Write commit to file"
 msgstr "Запазване на подаването във файл"
 
-#: gitk:2645
+#: gitk:2680
 msgid "Create new branch"
 msgstr "Създаване на нов клон"
 
-#: gitk:2646
+#: gitk:2681
 msgid "Cherry-pick this commit"
 msgstr "Отбиране на това подаване"
 
-#: gitk:2647
+#: gitk:2682
 msgid "Reset HEAD branch to here"
 msgstr "Привеждане на върха на клона към текущото подаване"
 
-#: gitk:2648
+#: gitk:2683
 msgid "Mark this commit"
 msgstr "Отбелязване на това подаване"
 
-#: gitk:2649
+#: gitk:2684
 msgid "Return to mark"
 msgstr "Връщане към отбелязаното подаване"
 
-#: gitk:2650
+#: gitk:2685
 msgid "Find descendant of this and mark"
 msgstr "Откриване и отбелязване на наследниците"
 
-#: gitk:2651
+#: gitk:2686
 msgid "Compare with marked commit"
 msgstr "Сравнение с отбелязаното подаване"
 
-#: gitk:2652 gitk:2663
+#: gitk:2687 gitk:2698
 msgid "Diff this -> marked commit"
 msgstr "Разлики между това и отбелязаното"
 
-#: gitk:2653 gitk:2664
+#: gitk:2688 gitk:2699
 msgid "Diff marked commit -> this"
 msgstr "Разлики между отбелязаното и това"
 
-#: gitk:2654
+#: gitk:2689
 msgid "Revert this commit"
 msgstr "Отмяна на това подаване"
 
-#: gitk:2670
+#: gitk:2705
 msgid "Check out this branch"
 msgstr "Изтегляне на този клон"
 
-#: gitk:2671
+#: gitk:2706
 msgid "Rename this branch"
 msgstr "Преименуване на този клон"
 
-#: gitk:2672
+#: gitk:2707
 msgid "Remove this branch"
 msgstr "Изтриване на този клон"
 
-#: gitk:2673
+#: gitk:2708
 msgid "Copy branch name"
 msgstr "Копиране на името на клона"
 
-#: gitk:2680
+#: gitk:2715
 msgid "Highlight this too"
 msgstr "Отбелязване и на това"
 
-#: gitk:2681
+#: gitk:2716
 msgid "Highlight this only"
 msgstr "Отбелязване само на това"
 
-#: gitk:2682
+#: gitk:2717
 msgid "External diff"
 msgstr "Външна програма за разлики"
 
-#: gitk:2683
+#: gitk:2718
 msgid "Blame parent commit"
 msgstr "Анотиране на родителското подаване"
 
-#: gitk:2684
+#: gitk:2719
 msgid "Copy path"
 msgstr "Копиране на пътя"
 
-#: gitk:2691
+#: gitk:2726
 msgid "Show origin of this line"
 msgstr "Показване на произхода на този ред"
 
-#: gitk:2692
+#: gitk:2727
 msgid "Run git gui blame on this line"
 msgstr "Изпълнение на „git gui blame“ върху този ред"
 
-#: gitk:3036
+#: gitk:3081
 msgid "About gitk"
 msgstr "Относно gitk"
 
-#: gitk:3038
+#: gitk:3083
 msgid ""
 "\n"
 "Gitk - a commit viewer for git\n"
@@ -386,324 +386,324 @@ msgstr ""
 "\n"
 "Използвайте и разпространявайте при условията на ОПЛ на ГНУ"
 
-#: gitk:3046 gitk:3113 gitk:10004
+#: gitk:3091 gitk:3158 gitk:10090
 msgid "Close"
 msgstr "Затваряне"
 
-#: gitk:3067
+#: gitk:3112
 msgid "Gitk key bindings"
 msgstr "Клавишни комбинации"
 
-#: gitk:3070
+#: gitk:3115
 msgid "Gitk key bindings:"
 msgstr "Клавишни комбинации:"
 
-#: gitk:3072
+#: gitk:3117
 #, tcl-format
 msgid "<%s-Q>\t\tQuit"
 msgstr "<%s-Q>\t\tСпиране на програмата"
 
-#: gitk:3073
+#: gitk:3118
 #, tcl-format
 msgid "<%s-W>\t\tClose window"
 msgstr "<%s-W>\t\tЗатваряне на прозореца"
 
-#: gitk:3074
+#: gitk:3119
 msgid "<Home>\t\tMove to first commit"
 msgstr "<Home>\t\tКъм първото подаване"
 
-#: gitk:3075
+#: gitk:3120
 msgid "<End>\t\tMove to last commit"
 msgstr "<End>\t\tКъм последното подаване"
 
-#: gitk:3076
+#: gitk:3121
 msgid "<Up>, p, k\tMove up one commit"
 msgstr "<Up>, p, k\tЕдно подаване нагоре"
 
-#: gitk:3077
+#: gitk:3122
 msgid "<Down>, n, j\tMove down one commit"
 msgstr "<Down>, n, j\tЕдно подаване надолу"
 
-#: gitk:3078
+#: gitk:3123
 msgid "<Left>, z, h\tGo back in history list"
 msgstr "<Left>, z, h\tНазад в историята"
 
-#: gitk:3079
+#: gitk:3124
 msgid "<Right>, x, l\tGo forward in history list"
 msgstr "<Right>, x, l\tНапред в историята"
 
-#: gitk:3080
+#: gitk:3125
 #, tcl-format
 msgid "<%s-n>\tGo to n-th parent of current commit in history list"
 msgstr "<%s-n>\tКъм n-тия родител на текущото подаване в историята"
 
-#: gitk:3081
+#: gitk:3126
 msgid "<PageUp>\tMove up one page in commit list"
 msgstr "<PageUp>\tСтраница нагоре в списъка с подаванията"
 
-#: gitk:3082
+#: gitk:3127
 msgid "<PageDown>\tMove down one page in commit list"
 msgstr "<PageDown>\tСтраница надолу в списъка с подаванията"
 
-#: gitk:3083
+#: gitk:3128
 #, tcl-format
 msgid "<%s-Home>\tScroll to top of commit list"
 msgstr "<%s-Home>\tКъм началото на списъка с подаванията"
 
-#: gitk:3084
+#: gitk:3129
 #, tcl-format
 msgid "<%s-End>\tScroll to bottom of commit list"
 msgstr "<%s-End>\tКъм края на списъка с подаванията"
 
-#: gitk:3085
+#: gitk:3130
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
 msgstr "<%s-Up>\tРед нагоре в списъка с подавания"
 
-#: gitk:3086
+#: gitk:3131
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
 msgstr "<%s-Down>\tРед надолу в списъка с подавания"
 
-#: gitk:3087
+#: gitk:3132
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
 msgstr "<%s-PageUp>\tСтраница нагоре в списъка с подавания"
 
-#: gitk:3088
+#: gitk:3133
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
 msgstr "<%s-PageDown>\tСтраница надолу в списъка с подавания"
 
-#: gitk:3089
+#: gitk:3134
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
 msgstr "<Shift-Up>\tТърсене назад (визуално нагоре, исторически — последващи)"
 
-#: gitk:3090
+#: gitk:3135
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
 msgstr ""
 "<Shift-Down>\tТърсене напред (визуално надолу, исторически — предхождащи)"
 
-#: gitk:3091
+#: gitk:3136
 msgid "<Delete>, b\tScroll diff view up one page"
 msgstr "<Delete>, b\tСтраница нагоре в изгледа за разлики"
 
-#: gitk:3092
+#: gitk:3137
 msgid "<Backspace>\tScroll diff view up one page"
 msgstr "<Backspace>\tСтраница надолу в изгледа за разлики"
 
-#: gitk:3093
+#: gitk:3138
 msgid "<Space>\t\tScroll diff view down one page"
 msgstr "<Space>\t\tСтраница надолу в изгледа за разлики"
 
-#: gitk:3094
+#: gitk:3139
 msgid "u\t\tScroll diff view up 18 lines"
 msgstr "u\t\t18 реда нагоре в изгледа за разлики"
 
-#: gitk:3095
+#: gitk:3140
 msgid "d\t\tScroll diff view down 18 lines"
 msgstr "d\t\t18 реда надолу в изгледа за разлики"
 
-#: gitk:3096
+#: gitk:3141
 #, tcl-format
 msgid "<%s-F>\t\tFind"
 msgstr "<%s-F>\t\tТърсене"
 
-#: gitk:3097
+#: gitk:3142
 #, tcl-format
 msgid "<%s-G>\t\tMove to next find hit"
 msgstr "<%s-G>\t\tКъм следващата поява"
 
-#: gitk:3098
+#: gitk:3143
 msgid "<Return>\tMove to next find hit"
 msgstr "<Return>\tКъм следващата поява"
 
-#: gitk:3099
+#: gitk:3144
 msgid "g\t\tGo to commit"
 msgstr "g\t\tКъм последното подаване"
 
-#: gitk:3100
+#: gitk:3145
 msgid "/\t\tFocus the search box"
 msgstr "/\t\tФокус върху полето за търсене"
 
-#: gitk:3101
+#: gitk:3146
 msgid "?\t\tMove to previous find hit"
 msgstr "?\t\tКъм предишната поява"
 
-#: gitk:3102
+#: gitk:3147
 msgid "f\t\tScroll diff view to next file"
 msgstr "f\t\tСледващ файл в изгледа за разлики"
 
-#: gitk:3103
+#: gitk:3148
 #, tcl-format
 msgid "<%s-S>\t\tSearch for next hit in diff view"
 msgstr "<%s-S>\t\tТърсене на следващата поява в изгледа за разлики"
 
-#: gitk:3104
+#: gitk:3149
 #, tcl-format
 msgid "<%s-R>\t\tSearch for previous hit in diff view"
 msgstr "<%s-R>\t\tТърсене на предишната поява в изгледа за разлики"
 
-#: gitk:3105
+#: gitk:3150
 #, tcl-format
 msgid "<%s-KP+>\tIncrease font size"
 msgstr "<%s-KP+>\tПо-голям размер на шрифта"
 
-#: gitk:3106
+#: gitk:3151
 #, tcl-format
 msgid "<%s-plus>\tIncrease font size"
 msgstr "<%s-plus>\tПо-голям размер на шрифта"
 
-#: gitk:3107
+#: gitk:3152
 #, tcl-format
 msgid "<%s-KP->\tDecrease font size"
 msgstr "<%s-KP->\tПо-малък размер на шрифта"
 
-#: gitk:3108
+#: gitk:3153
 #, tcl-format
 msgid "<%s-minus>\tDecrease font size"
 msgstr "<%s-minus>\tПо-малък размер на шрифта"
 
-#: gitk:3109
+#: gitk:3154
 msgid "<F5>\t\tUpdate"
 msgstr "<F5>\t\tОбновяване"
 
-#: gitk:3574 gitk:3583
+#: gitk:3621 gitk:3630
 #, tcl-format
 msgid "Error creating temporary directory %s:"
 msgstr "Грешка при създаването на временната директория „%s“:"
 
-#: gitk:3596
+#: gitk:3643
 #, tcl-format
 msgid "Error getting \"%s\" from %s:"
 msgstr "Грешка при получаването на „%s“ от %s:"
 
-#: gitk:3659
+#: gitk:3706
 msgid "command failed:"
 msgstr "неуспешно изпълнение на команда:"
 
-#: gitk:3808
+#: gitk:3855
 msgid "No such commit"
 msgstr "Такова подаване няма"
 
-#: gitk:3822
+#: gitk:3869
 msgid "git gui blame: command failed:"
 msgstr "„git gui blame“: неуспешно изпълнение на команда:"
 
-#: gitk:3853
+#: gitk:3900
 #, tcl-format
 msgid "Couldn't read merge head: %s"
-msgstr "Върхът за сливане не може да бъде прочетен: %s"
+msgstr "Върхът за сливане не може да се прочете: %s"
 
-#: gitk:3861
+#: gitk:3908
 #, tcl-format
 msgid "Error reading index: %s"
 msgstr "Грешка при прочитане на индекса: %s"
 
-#: gitk:3886
+#: gitk:3933
 #, tcl-format
 msgid "Couldn't start git blame: %s"
-msgstr "Командата „git blame“ не може да бъде стартирана: %s"
+msgstr "Командата „git blame“ не може да се стартира: %s"
 
-#: gitk:3889 gitk:6778
+#: gitk:3936 gitk:6825
 msgid "Searching"
 msgstr "Търсене"
 
-#: gitk:3921
+#: gitk:3968
 #, tcl-format
 msgid "Error running git blame: %s"
 msgstr "Грешка при изпълнението на „git blame“: %s"
 
-#: gitk:3949
+#: gitk:3996
 #, tcl-format
 msgid "That line comes from commit %s,  which is not in this view"
 msgstr "Този ред идва от подаването %s, което не е в изгледа"
 
-#: gitk:3963
+#: gitk:4010
 msgid "External diff viewer failed:"
 msgstr "Неуспешно изпълнение на външната програма за разлики:"
 
-#: gitk:4067
+#: gitk:4114
 msgid "All files"
 msgstr "Всички файлове"
 
-#: gitk:4091
+#: gitk:4138
 msgid "View"
 msgstr "Изглед"
 
-#: gitk:4094
+#: gitk:4141
 msgid "Gitk view definition"
 msgstr "Дефиниция на изглед в Gitk"
 
-#: gitk:4098
+#: gitk:4145
 msgid "Remember this view"
 msgstr "Запазване на този изглед"
 
-#: gitk:4099
+#: gitk:4146
 msgid "References (space separated list):"
 msgstr "Указатели (списък с разделител интервал):"
 
-#: gitk:4100
+#: gitk:4147
 msgid "Branches & tags:"
 msgstr "Клони и етикети:"
 
-#: gitk:4101
+#: gitk:4148
 msgid "All refs"
 msgstr "Всички указатели"
 
-#: gitk:4102
+#: gitk:4149
 msgid "All (local) branches"
 msgstr "Всички (локални) клони"
 
-#: gitk:4103
+#: gitk:4150
 msgid "All tags"
 msgstr "Всички етикети"
 
-#: gitk:4104
+#: gitk:4151
 msgid "All remote-tracking branches"
 msgstr "Всички следящи клони"
 
-#: gitk:4105
+#: gitk:4152
 msgid "Commit Info (regular expressions):"
 msgstr "Информация за подаване (рег. изр.):"
 
-#: gitk:4106
+#: gitk:4153
 msgid "Author:"
 msgstr "Автор:"
 
-#: gitk:4107
+#: gitk:4154
 msgid "Committer:"
 msgstr "Подал:"
 
-#: gitk:4108
+#: gitk:4155
 msgid "Commit Message:"
 msgstr "Съобщение при подаване:"
 
-#: gitk:4109
+#: gitk:4156
 msgid "Matches all Commit Info criteria"
 msgstr "Съвпадение по всички характеристики на подаването"
 
-#: gitk:4110
+#: gitk:4157
 msgid "Matches no Commit Info criteria"
 msgstr "Не съвпада по никоя от характеристиките на подаването"
 
-#: gitk:4111
+#: gitk:4158
 msgid "Changes to Files:"
 msgstr "Промени по файловете:"
 
-#: gitk:4112
+#: gitk:4159
 msgid "Fixed String"
 msgstr "Дословен низ"
 
-#: gitk:4113
+#: gitk:4160
 msgid "Regular Expression"
 msgstr "Регулярен израз"
 
-#: gitk:4114
+#: gitk:4161
 msgid "Search string:"
 msgstr "Низ за търсене:"
 
-#: gitk:4115
+#: gitk:4162
 msgid ""
 "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 "
 "15:27:38\"):"
@@ -711,204 +711,208 @@ msgstr ""
 "Дата на подаване („2 weeks ago“ (преди 2 седмици), „2009-03-17 15:27:38“, "
 "„March 17, 2009 15:27:38“):"
 
-#: gitk:4116
+#: gitk:4163
 msgid "Since:"
 msgstr "От:"
 
-#: gitk:4117
+#: gitk:4164
 msgid "Until:"
 msgstr "До:"
 
-#: gitk:4118
+#: gitk:4165
 msgid "Limit and/or skip a number of revisions (positive integer):"
 msgstr ""
 "Ограничаване и/или прескачане на определен брой версии (неотрицателно цяло "
 "число):"
 
-#: gitk:4119
+#: gitk:4166
 msgid "Number to show:"
 msgstr "Брой показани:"
 
-#: gitk:4120
+#: gitk:4167
 msgid "Number to skip:"
 msgstr "Брой прескочени:"
 
-#: gitk:4121
+#: gitk:4168
 msgid "Miscellaneous options:"
 msgstr "Разни:"
 
-#: gitk:4122
+#: gitk:4169
 msgid "Strictly sort by date"
 msgstr "Подреждане по дата"
 
-#: gitk:4123
+#: gitk:4170
 msgid "Mark branch sides"
 msgstr "Отбелязване на страните по клона"
 
-#: gitk:4124
+#: gitk:4171
 msgid "Limit to first parent"
 msgstr "Само първия родител"
 
-#: gitk:4125
+#: gitk:4172
 msgid "Simple history"
 msgstr "Опростена история"
 
-#: gitk:4126
+#: gitk:4173
 msgid "Additional arguments to git log:"
 msgstr "Допълнителни аргументи към „git log“:"
 
-#: gitk:4127
+#: gitk:4174
 msgid "Enter files and directories to include, one per line:"
 msgstr "Въведете файловете и директориите за включване, по елемент на ред"
 
-#: gitk:4128
+#: gitk:4175
 msgid "Command to generate more commits to include:"
 msgstr ""
-"Команда за генерирането на допълнителни подавания, които да бъдат включени:"
+"Команда за генерирането на допълнителни подавания, които да се включат:"
 
-#: gitk:4252
+#: gitk:4299
 msgid "Gitk: edit view"
 msgstr "Gitk: редактиране на изглед"
 
-#: gitk:4260
+#: gitk:4307
 msgid "-- criteria for selecting revisions"
 msgstr "— критерии за избор на версии"
 
-#: gitk:4265
+#: gitk:4312
 msgid "View Name"
 msgstr "Име на изглед"
 
-#: gitk:4340
+#: gitk:4387
 msgid "Apply (F5)"
 msgstr "Прилагане (F5)"
 
-#: gitk:4378
+#: gitk:4425
 msgid "Error in commit selection arguments:"
 msgstr "Грешка в аргументите за избор на подавания:"
 
-#: gitk:4433 gitk:4486 gitk:4948 gitk:4962 gitk:6232 gitk:12524 gitk:12525
+#: gitk:4480 gitk:4533 gitk:4995 gitk:5009 gitk:6279 gitk:12679 gitk:12680
 msgid "None"
 msgstr "Няма"
 
-#: gitk:5045 gitk:5050
+#: gitk:5092 gitk:5097
 msgid "Descendant"
 msgstr "Наследник"
 
-#: gitk:5046
+#: gitk:5093
 msgid "Not descendant"
 msgstr "Не е наследник"
 
-#: gitk:5053 gitk:5058
+#: gitk:5100 gitk:5105
 msgid "Ancestor"
 msgstr "Предшественик"
 
-#: gitk:5054
+#: gitk:5101
 msgid "Not ancestor"
 msgstr "Не е предшественик"
 
-#: gitk:5348
+#: gitk:5395
 msgid "Local changes checked in to index but not committed"
 msgstr "Локални промени добавени към индекса, но неподадени"
 
-#: gitk:5384
+#: gitk:5431
 msgid "Local uncommitted changes, not checked in to index"
 msgstr "Локални промени извън индекса"
 
-#: gitk:7158
+#: gitk:7179
+msgid "Error starting web browser:"
+msgstr "Грешка при стартирането на уеб браузър:"
+
+#: gitk:7240
 msgid "and many more"
 msgstr "и още много"
 
-#: gitk:7161
+#: gitk:7243
 msgid "many"
 msgstr "много"
 
-#: gitk:7352
+#: gitk:7438
 msgid "Tags:"
 msgstr "Етикети:"
 
-#: gitk:7369 gitk:7375 gitk:8854
+#: gitk:7455 gitk:7461 gitk:8940
 msgid "Parent"
 msgstr "Родител"
 
-#: gitk:7380
+#: gitk:7466
 msgid "Child"
 msgstr "Дете"
 
-#: gitk:7389
+#: gitk:7475
 msgid "Branch"
 msgstr "Клон"
 
-#: gitk:7392
+#: gitk:7478
 msgid "Follows"
 msgstr "Следва"
 
-#: gitk:7395
+#: gitk:7481
 msgid "Precedes"
 msgstr "Предшества"
 
-#: gitk:7990
+#: gitk:8076
 #, tcl-format
 msgid "Error getting diffs: %s"
 msgstr "Грешка при получаването на разликите: %s"
 
-#: gitk:8679
+#: gitk:8765
 msgid "Goto:"
 msgstr "Към ред:"
 
-#: gitk:8700
+#: gitk:8786
 #, tcl-format
-msgid "Short SHA1 id %s is ambiguous"
-msgstr "Съкратената сума по SHA1 %s не е еднозначна"
+msgid "Short commit ID %s is ambiguous"
+msgstr "Съкратената контролна сума %s не е еднозначна"
 
-#: gitk:8707
+#: gitk:8793
 #, tcl-format
 msgid "Revision %s is not known"
 msgstr "Непозната версия %s"
 
-#: gitk:8717
+#: gitk:8803
 #, tcl-format
-msgid "SHA1 id %s is not known"
-msgstr "Непозната сума по SHA1 %s"
+msgid "Commit ID %s is not known"
+msgstr "Непозната контролна сума %s"
 
-#: gitk:8719
+#: gitk:8805
 #, tcl-format
 msgid "Revision %s is not in the current view"
 msgstr "Версия %s не е в текущия изглед"
 
-#: gitk:8861 gitk:8876
+#: gitk:8947 gitk:8962
 msgid "Date"
 msgstr "Дата"
 
-#: gitk:8864
+#: gitk:8950
 msgid "Children"
 msgstr "Деца"
 
-#: gitk:8927
+#: gitk:9013
 #, tcl-format
 msgid "Reset %s branch to here"
 msgstr "Зануляване на клона „%s“ към текущото подаване"
 
-#: gitk:8929
+#: gitk:9015
 msgid "Detached head: can't reset"
 msgstr "Несвързан връх: невъзможно зануляване"
 
-#: gitk:9034 gitk:9040
+#: gitk:9120 gitk:9126
 msgid "Skipping merge commit "
 msgstr "Пропускане на подаването на сливането"
 
-#: gitk:9049 gitk:9054
+#: gitk:9135 gitk:9140
 msgid "Error getting patch ID for "
 msgstr "Грешка при получаването на идентификатора на "
 
-#: gitk:9050 gitk:9055
+#: gitk:9136 gitk:9141
 msgid " - stopping\n"
 msgstr " — спиране\n"
 
-#: gitk:9060 gitk:9063 gitk:9071 gitk:9085 gitk:9094
+#: gitk:9146 gitk:9149 gitk:9157 gitk:9171 gitk:9180
 msgid "Commit "
 msgstr "Подаване"
 
-#: gitk:9064
+#: gitk:9150
 msgid ""
 " is the same patch as\n"
 "       "
@@ -916,7 +920,7 @@ msgstr ""
 " е същата кръпка като\n"
 "       "
 
-#: gitk:9072
+#: gitk:9158
 msgid ""
 " differs from\n"
 "       "
@@ -924,7 +928,7 @@ msgstr ""
 " се различава от\n"
 "       "
 
-#: gitk:9074
+#: gitk:9160
 msgid ""
 "Diff of commits:\n"
 "\n"
@@ -932,147 +936,147 @@ msgstr ""
 "Разлика между подаванията:\n"
 "\n"
 
-#: gitk:9086 gitk:9095
+#: gitk:9172 gitk:9181
 #, tcl-format
 msgid " has %s children - stopping\n"
 msgstr " има %s деца — спиране\n"
 
-#: gitk:9114
+#: gitk:9200
 #, tcl-format
 msgid "Error writing commit to file: %s"
 msgstr "Грешка при запазването на подаването във файл: %s"
 
-#: gitk:9120
+#: gitk:9206
 #, tcl-format
 msgid "Error diffing commits: %s"
 msgstr "Грешка при изчисляването на разликите между подаванията: %s"
 
-#: gitk:9166
+#: gitk:9252
 msgid "Top"
 msgstr "Най-горе"
 
-#: gitk:9167
+#: gitk:9253
 msgid "From"
 msgstr "От"
 
-#: gitk:9172
+#: gitk:9258
 msgid "To"
 msgstr "До"
 
-#: gitk:9196
+#: gitk:9282
 msgid "Generate patch"
 msgstr "Генериране на кръпка"
 
-#: gitk:9198
+#: gitk:9284
 msgid "From:"
 msgstr "От:"
 
-#: gitk:9207
+#: gitk:9293
 msgid "To:"
 msgstr "До:"
 
-#: gitk:9216
+#: gitk:9302
 msgid "Reverse"
 msgstr "Обръщане"
 
-#: gitk:9218 gitk:9428
+#: gitk:9304 gitk:9514
 msgid "Output file:"
 msgstr "Запазване във файла:"
 
-#: gitk:9224
+#: gitk:9310
 msgid "Generate"
 msgstr "Генериране"
 
-#: gitk:9262
+#: gitk:9348
 msgid "Error creating patch:"
 msgstr "Грешка при създаването на кръпка:"
 
-#: gitk:9285 gitk:9416 gitk:9504
+#: gitk:9371 gitk:9502 gitk:9590
 msgid "ID:"
 msgstr "Идентификатор:"
 
-#: gitk:9294
+#: gitk:9380
 msgid "Tag name:"
 msgstr "Име на етикет:"
 
-#: gitk:9297
+#: gitk:9383
 msgid "Tag message is optional"
 msgstr "Съобщението за етикет е незадължително"
 
-#: gitk:9299
+#: gitk:9385
 msgid "Tag message:"
 msgstr "Съобщение за етикет:"
 
-#: gitk:9303 gitk:9474
+#: gitk:9389 gitk:9560
 msgid "Create"
 msgstr "Създаване"
 
-#: gitk:9321
+#: gitk:9407
 msgid "No tag name specified"
 msgstr "Липсва име на етикет"
 
-#: gitk:9325
+#: gitk:9411
 #, tcl-format
 msgid "Tag \"%s\" already exists"
 msgstr "Етикетът „%s“ вече съществува"
 
-#: gitk:9335
+#: gitk:9421
 msgid "Error creating tag:"
 msgstr "Грешка при създаването на етикет:"
 
-#: gitk:9425
+#: gitk:9511
 msgid "Command:"
 msgstr "Команда:"
 
-#: gitk:9433
+#: gitk:9519
 msgid "Write"
 msgstr "Запазване"
 
-#: gitk:9451
+#: gitk:9537
 msgid "Error writing commit:"
 msgstr "Грешка при запазването на подаването:"
 
-#: gitk:9473
+#: gitk:9559
 msgid "Create branch"
 msgstr "Създаване на клон"
 
-#: gitk:9489
+#: gitk:9575
 #, tcl-format
 msgid "Rename branch %s"
 msgstr "Преименуване на клона „%s“"
 
-#: gitk:9490
+#: gitk:9576
 msgid "Rename"
 msgstr "Преименуване"
 
-#: gitk:9514
+#: gitk:9600
 msgid "Name:"
 msgstr "Име:"
 
-#: gitk:9538
+#: gitk:9624
 msgid "Please specify a name for the new branch"
 msgstr "Укажете име за новия клон"
 
-#: gitk:9543
+#: gitk:9629
 #, tcl-format
 msgid "Branch '%s' already exists. Overwrite?"
-msgstr "Клонът „%s“ вече съществува. Да бъде ли презаписан?"
+msgstr "Клонът „%s“ вече съществува. Да се презапише ли?"
 
-#: gitk:9587
+#: gitk:9673
 msgid "Please specify a new name for the branch"
 msgstr "Укажете ново име за клона"
 
-#: gitk:9650
+#: gitk:9736
 #, tcl-format
 msgid "Commit %s is already included in branch %s -- really re-apply it?"
 msgstr ""
-"Подаването „%s“ вече е включено в клона „%s“ — да бъде ли приложено отново?"
+"Подаването „%s“ вече е включено в клона „%s“ — да се приложи ли отново?"
 
-#: gitk:9655
+#: gitk:9741
 msgid "Cherry-picking"
 msgstr "Отбиране"
 
-#: gitk:9664
+#: gitk:9750
 #, tcl-format
 msgid ""
 "Cherry-pick failed because of local changes to file '%s'.\n"
@@ -1081,7 +1085,7 @@ msgstr ""
 "Неуспешно отбиране, защото във файла „%s“ има локални промени.\n"
 "Подайте, занулете или ги скатайте и пробвайте отново."
 
-#: gitk:9670
+#: gitk:9756
 msgid ""
 "Cherry-pick failed because of merge conflict.\n"
 "Do you wish to run git citool to resolve it?"
@@ -1089,20 +1093,20 @@ msgstr ""
 "Неуспешно отбиране поради конфликти при сливане.\n"
 "Искате ли да ги коригирате чрез „git citool“?"
 
-#: gitk:9686 gitk:9744
+#: gitk:9772 gitk:9830
 msgid "No changes committed"
 msgstr "Не са подадени промени"
 
-#: gitk:9713
+#: gitk:9799
 #, tcl-format
 msgid "Commit %s is not included in branch %s -- really revert it?"
-msgstr "Подаването „%s“ не е включено в клона „%s“. Да бъде ли отменено?"
+msgstr "Подаването „%s“ не е включено в клона „%s“. Да се отменени ли?"
 
-#: gitk:9718
+#: gitk:9804
 msgid "Reverting"
 msgstr "Отмяна"
 
-#: gitk:9726
+#: gitk:9812
 #, tcl-format
 msgid ""
 "Revert failed because of local changes to the following files:%s Please "
@@ -1111,7 +1115,7 @@ msgstr ""
 "Неуспешна отмяна, защото във файла „%s“ има локални промени.\n"
 "Подайте, занулете или ги скатайте и пробвайте отново."
 
-#: gitk:9730
+#: gitk:9816
 msgid ""
 "Revert failed because of merge conflict.\n"
 " Do you wish to run git citool to resolve it?"
@@ -1119,53 +1123,53 @@ msgstr ""
 "Неуспешно отмяна поради конфликти при сливане.\n"
 "Искате ли да ги коригирате чрез „git citool“?"
 
-#: gitk:9773
+#: gitk:9859
 msgid "Confirm reset"
 msgstr "Потвърждаване на зануляването"
 
-#: gitk:9775
+#: gitk:9861
 #, tcl-format
 msgid "Reset branch %s to %s?"
 msgstr "Да се занули ли клонът „%s“ към „%s“?"
 
-#: gitk:9777
+#: gitk:9863
 msgid "Reset type:"
 msgstr "Вид зануляване:"
 
-#: gitk:9780
+#: gitk:9866
 msgid "Soft: Leave working tree and index untouched"
 msgstr "Слабо: работното дърво и индекса остават същите"
 
-#: gitk:9783
+#: gitk:9869
 msgid "Mixed: Leave working tree untouched, reset index"
 msgstr "Смесено: работното дърво остава същото, индексът се занулява"
 
-#: gitk:9786
+#: gitk:9872
 msgid ""
 "Hard: Reset working tree and index\n"
 "(discard ALL local changes)"
 msgstr ""
 "Силно: зануляване и на работното дърво, и на индекса\n"
-"(ВСИЧКИ локални промени ще бъдат безвъзвратно загубени)"
+"(ВСИЧКИ локални промени ще се загубят безвъзвратно)"
 
-#: gitk:9803
+#: gitk:9889
 msgid "Resetting"
 msgstr "Зануляване"
 
-#: gitk:9876
+#: gitk:9962
 #, tcl-format
 msgid "A local branch named %s exists already"
 msgstr "Вече съществува локален клон „%s“."
 
-#: gitk:9884
+#: gitk:9970
 msgid "Checking out"
 msgstr "Изтегляне"
 
-#: gitk:9943
+#: gitk:10029
 msgid "Cannot delete the currently checked-out branch"
-msgstr "Текущо изтегленият клон не може да бъде изтрит"
+msgstr "Текущо изтегленият клон не може да се изтрие"
 
-#: gitk:9949
+#: gitk:10035
 #, tcl-format
 msgid ""
 "The commits on branch %s aren't on any other branch.\n"
@@ -1174,16 +1178,16 @@ msgstr ""
 "Подаванията на клона „%s“ не са на никой друг клон.\n"
 "Наистина ли искате да изтриете клона „%s“?"
 
-#: gitk:9980
+#: gitk:10066
 #, tcl-format
 msgid "Tags and heads: %s"
 msgstr "Етикети и върхове: %s"
 
-#: gitk:9997
+#: gitk:10083
 msgid "Filter"
 msgstr "Филтриране"
 
-#: gitk:10293
+#: gitk:10390
 msgid ""
 "Error reading commit topology information; branch and preceding/following "
 "tag information will be incomplete."
@@ -1191,201 +1195,237 @@ msgstr ""
 "Грешка при прочитането на топологията на подаванията. Информацията за клона "
 "и предшестващите/следващите етикети ще е непълна."
 
-#: gitk:11270
+#: gitk:11367
 msgid "Tag"
 msgstr "Етикет"
 
-#: gitk:11274
+#: gitk:11371
 msgid "Id"
 msgstr "Идентификатор"
 
-#: gitk:11357
+#: gitk:11454
 msgid "Gitk font chooser"
 msgstr "Избор на шрифт за Gitk"
 
-#: gitk:11374
+#: gitk:11471
 msgid "B"
 msgstr "Ч"
 
-#: gitk:11377
+#: gitk:11474
 msgid "I"
 msgstr "К"
 
-#: gitk:11495
+#: gitk:11593
 msgid "Commit list display options"
 msgstr "Настройки на списъка с подавания"
 
-#: gitk:11498
+#: gitk:11596
 msgid "Maximum graph width (lines)"
 msgstr "Максимална широчина на графа (в редове)"
 
-#: gitk:11502
+#: gitk:11600
 #, no-tcl-format
 msgid "Maximum graph width (% of pane)"
 msgstr "Максимална широчина на графа (% от панела)"
 
-#: gitk:11505
+#: gitk:11603
 msgid "Show local changes"
 msgstr "Показване на локалните промени"
 
-#: gitk:11508
-msgid "Auto-select SHA1 (length)"
-msgstr "Автоматично избиране на SHA1 (дължина)"
-
-#: gitk:11512
+#: gitk:11606
 msgid "Hide remote refs"
 msgstr "Скриване на отдалечените указатели"
 
-#: gitk:11516
+#: gitk:11610
+msgid "Copy commit ID to clipboard"
+msgstr "Копиране на контролната сума към буфера за обмен"
+
+#: gitk:11614
+msgid "Copy commit ID to X11 selection"
+msgstr "Копиране на контролната сума в селекцията на X11"
+
+#: gitk:11619
+msgid "Length of commit ID to copy"
+msgstr "Дължина на контролната сума, която се копира"
+
+#: gitk:11622
 msgid "Diff display options"
 msgstr "Настройки на показването на разликите"
 
-#: gitk:11518
+#: gitk:11624
 msgid "Tab spacing"
 msgstr "Широчина на табулатора"
 
-#: gitk:11521
+#: gitk:11628
+msgid "Wrap comment text"
+msgstr "Пренасяне на думите в коментарите"
+
+#: gitk:11633
+msgid "Wrap other text"
+msgstr "Пренасяне на другия текст"
+
+#: gitk:11638
 msgid "Display nearby tags/heads"
 msgstr "Извеждане на близките етикети и върхове"
 
-#: gitk:11524
+#: gitk:11641
 msgid "Maximum # tags/heads to show"
 msgstr "Максимален брой етикети/върхове за показване"
 
-#: gitk:11527
+#: gitk:11644
 msgid "Limit diffs to listed paths"
 msgstr "Разлика само в избраните пътища"
 
-#: gitk:11530
+#: gitk:11647
 msgid "Support per-file encodings"
 msgstr "Поддръжка на различни кодирания за всеки файл"
 
-#: gitk:11536 gitk:11683
+#: gitk:11653 gitk:11820
 msgid "External diff tool"
 msgstr "Външен инструмент за разлики"
 
-#: gitk:11537
+#: gitk:11654
 msgid "Choose..."
 msgstr "Избор…"
 
-#: gitk:11542
+#: gitk:11661
+msgid "Web browser"
+msgstr "Уеб браузър"
+
+#: gitk:11666
 msgid "General options"
 msgstr "Общи настройки"
 
-#: gitk:11545
+#: gitk:11669
 msgid "Use themed widgets"
 msgstr "Използване на тема за графичните обекти"
 
-#: gitk:11547
+#: gitk:11671
 msgid "(change requires restart)"
 msgstr "(промяната изисква рестартиране на Gitk)"
 
-#: gitk:11549
+#: gitk:11673
 msgid "(currently unavailable)"
 msgstr "(в момента недостъпно)"
 
-#: gitk:11560
+#: gitk:11685
 msgid "Colors: press to choose"
 msgstr "Цветове: избира се с натискане"
 
-#: gitk:11563
+#: gitk:11688
 msgid "Interface"
 msgstr "Интерфейс"
 
-#: gitk:11564
+#: gitk:11689
 msgid "interface"
 msgstr "интерфейс"
 
-#: gitk:11567
+#: gitk:11692
 msgid "Background"
 msgstr "Фон"
 
-#: gitk:11568 gitk:11598
+#: gitk:11693 gitk:11735
 msgid "background"
 msgstr "фон"
 
-#: gitk:11571
+#: gitk:11696
 msgid "Foreground"
 msgstr "Знаци"
 
-#: gitk:11572
+#: gitk:11697
 msgid "foreground"
 msgstr "знаци"
 
-#: gitk:11575
+#: gitk:11700
 msgid "Diff: old lines"
 msgstr "Разлика: стари редове"
 
-#: gitk:11576
+#: gitk:11701
 msgid "diff old lines"
 msgstr "разлика, стари редове"
 
-#: gitk:11580
+#: gitk:11705
+msgid "Diff: old lines bg"
+msgstr "Разлика: фон на стари редове"
+
+#: gitk:11707
+msgid "diff old lines bg"
+msgstr "разлика, фон на стари редове"
+
+#: gitk:11711
 msgid "Diff: new lines"
 msgstr "Разлика: нови редове"
 
-#: gitk:11581
+#: gitk:11712
 msgid "diff new lines"
 msgstr "разлика, нови редове"
 
-#: gitk:11585
+#: gitk:11716
+msgid "Diff: new lines bg"
+msgstr "Разлика: фон на нови редове"
+
+#: gitk:11718
+msgid "diff new lines bg"
+msgstr "разлика, фон на нови редове"
+
+#: gitk:11722
 msgid "Diff: hunk header"
 msgstr "Разлика: начало на парче"
 
-#: gitk:11587
+#: gitk:11724
 msgid "diff hunk header"
 msgstr "разлика, начало на парче"
 
-#: gitk:11591
+#: gitk:11728
 msgid "Marked line bg"
 msgstr "Фон на отбелязан ред"
 
-#: gitk:11593
+#: gitk:11730
 msgid "marked line background"
 msgstr "фон на отбелязан ред"
 
-#: gitk:11597
+#: gitk:11734
 msgid "Select bg"
 msgstr "Избор на фон"
 
-#: gitk:11606
+#: gitk:11743
 msgid "Fonts: press to choose"
 msgstr "Шрифтове: избира се с натискане"
 
-#: gitk:11608
+#: gitk:11745
 msgid "Main font"
 msgstr "Основен шрифт"
 
-#: gitk:11609
+#: gitk:11746
 msgid "Diff display font"
 msgstr "Шрифт за разликите"
 
-#: gitk:11610
+#: gitk:11747
 msgid "User interface font"
 msgstr "Шрифт на интерфейса"
 
-#: gitk:11632
+#: gitk:11769
 msgid "Gitk preferences"
 msgstr "Настройки на Gitk"
 
-#: gitk:11641
+#: gitk:11778
 msgid "General"
 msgstr "Общи"
 
-#: gitk:11642
+#: gitk:11779
 msgid "Colors"
 msgstr "Цветове"
 
-#: gitk:11643
+#: gitk:11780
 msgid "Fonts"
 msgstr "Шрифтове"
 
-#: gitk:11693
+#: gitk:11830
 #, tcl-format
 msgid "Gitk: choose color for %s"
 msgstr "Gitk: избор на цвят на „%s“"
 
-#: gitk:12206
+#: gitk:12350
 msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
@@ -1393,15 +1433,15 @@ msgstr ""
 "Тази версия на Tcl/Tk не се поддържа от Gitk.\n"
 " Необходима ви е поне Tcl/Tk 8.4."
 
-#: gitk:12416
+#: gitk:12571
 msgid "Cannot find a git repository here."
 msgstr "Тук липсва хранилище на Git."
 
-#: gitk:12463
+#: gitk:12618
 #, tcl-format
 msgid "Ambiguous argument '%s': both revision and filename"
 msgstr "Нееднозначен аргумент „%s“: има и такава версия, и такъв файл"
 
-#: gitk:12475
+#: gitk:12630
 msgid "Bad arguments to gitk:"
 msgstr "Неправилни аргументи на gitk:"
-- 
2.47.1

