Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14573165
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442610; cv=none; b=T6WF1HVbCRoVuhcB0i/xAiGI74WS/JQvT4Nni4QNZF/3D1BU0lJNrUpXpdDxUC7Hcm6KSOERvVeX+1ypp/FQ2g9hyUsvFY8n50qtj3A7A99yFylPeCck05diQGxqIs8CH5Lmq7KkeNd1jAqBfKPHFP/vOAgIJSQ05dd5i+ddoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442610; c=relaxed/simple;
	bh=1D4MC5cC5RfEjxxUP1SEYvcYc/5QpHXijH0NbJIjEnk=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=iUO5YmToZvcSB1qeS7iw5A9zuVQrUNHvbKcGSlXU2TXMNaW2XxZfrudPReSMOJF2UlfvRXkvZZCmimAfzQGR/hQAL4HkME0puIOfE0U/8XzNPHBUm53/g+FlskH5R5TsnvtIV0r+LBnfSaQbGnpDwJig5ML43EATFgqOtZDNKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0vkY5Aa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0vkY5Aa"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bde3d197so2027167e87.0
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 07:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708442605; x=1709047405; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AszmLTIYlGCfTdje2unWbQcJoVTQryYdFX8BeCi10LA=;
        b=h0vkY5AasIKflwT0eDdYJjogvdWLK4ENeIfEVg3DeoekFIaBSHcF6OrzAMPMEXs82b
         oDHzFwGr1mI4JtDnj1JY8/H7bLrOsm/us1B018f1sZzB3whtRPIZVe1zuLSpbHjk24FF
         Uzk0Le/D8D/3UqpAIbpmo91uqc0td6QXy0FVcc3gzgRbdmKfYMwCbtt03l62TfS1V9KQ
         iqt6JA3d2Q+k+lFQDJpf1aQpKbxRt3uW2pV6mgiUhIj464+dWYicxhg21HeRUojr/Nat
         oWgEIQ7n8zYGXdLTb8aI19NfeZ15W9MIo3ZvMozzi/3YI3Vyc99IYmazVkTXN6KAOf0F
         5+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708442605; x=1709047405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AszmLTIYlGCfTdje2unWbQcJoVTQryYdFX8BeCi10LA=;
        b=iUL9jGfNOFNaKpO1jKpKMjegC2y10Oh4/A373t2pkDtHgxeo3ZqRgEyIqtk9ofgm3x
         c8Vs/P1gTKg5rRslXsd67SGOHBRmCEiRMhGAfveXUkr0A0OV20xuanwQX76VloSiz051
         QX0WJjuiAcFHQWD7+cLZYLmxk7AYXUuEIvskW6yiXudPJyTSclNYEp4jyc7uT76eBN5s
         MHHOfDKOnSXNQattGqxNye9Hdqk+SFqGmfMzyM2Ps8GYLxeEqSo5Wu+bRJRRx28pBBRi
         vz3m3zQ32wi5wrE9QxOlIT2aUX2QZIKP7p2Tk6D2dABVgAZ72gzH/isXh/lcxXxCnoWs
         fVmQ==
X-Gm-Message-State: AOJu0Ywhxhj55j1J+pr6vozYDe9Gdh5RRd+7R2hqQ++6dtysRa/IvYhH
	D1mIy9+wHVhlp/gNmxec8SbPPkbWqkqleotYXGy1R1o55vpuSdlfnja4ncmF
X-Google-Smtp-Source: AGHT+IGynFQzVqN3W0JjfxNS8J3loQ4fTd66QHatJCnvPVaKSgWaSwDfkEyUvvIwMO/6mEjVT6EQFg==
X-Received: by 2002:ac2:4d87:0:b0:512:adef:f352 with SMTP id g7-20020ac24d87000000b00512adeff352mr4408594lfe.62.1708442604997;
        Tue, 20 Feb 2024 07:23:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b00512c13db038sm312812lfb.266.2024.02.20.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:23:24 -0800 (PST)
Message-ID: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
From: "Harmen Stoppels via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 15:23:21 +0000
Subject: [PATCH] rebase: make warning less passive aggressive
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harmen Stoppels <me@harmenstoppels.nl>,
    Harmen Stoppels <me@harmenstoppels.nl>

From: Harmen Stoppels <me@harmenstoppels.nl>

When you run `git rebase --continue` when no rebase is in progress, git
outputs `fatal: no rebase in progress?` which is not a question but a
statement. This commit makes it appear as a statement.

Signed-off-by: Harmen Stoppels <me@harmenstoppels.nl>
---
    rebase: make warning less passive aggressive

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1669%2Fhaampie%2Ffix%2Fpassive-agressive-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1669/haampie/fix/passive-agressive-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1669

 builtin/rebase.c | 2 +-
 po/bg.po         | 2 +-
 po/ca.po         | 2 +-
 po/de.po         | 2 +-
 po/el.po         | 2 +-
 po/es.po         | 2 +-
 po/fr.po         | 2 +-
 po/id.po         | 2 +-
 po/it.po         | 2 +-
 po/ko.po         | 2 +-
 po/pl.po         | 2 +-
 po/pt_PT.po      | 2 +-
 po/ru.po         | 2 +-
 po/sv.po         | 2 +-
 po/tr.po         | 2 +-
 po/uk.po         | 2 +-
 po/vi.po         | 2 +-
 po/zh_CN.po      | 2 +-
 po/zh_TW.po      | 2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a6..415783c4a21 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1254,7 +1254,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
 
 	if (options.action != ACTION_NONE && !in_progress)
-		die(_("No rebase in progress?"));
+		die(_("No rebase in progress"));
 
 	if (options.action == ACTION_EDIT_TODO && !is_merge(&options))
 		die(_("The --edit-todo action can only be used during "
diff --git a/po/bg.po b/po/bg.po
index 6b95addef41..e54a2abf94a 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -10782,7 +10782,7 @@ msgstr ""
 "„preserve“.\n"
 "Тази стойност вече не се поддържа, заменете я с „merges“."
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Изглежда в момента не тече пребазиране"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/ca.po b/po/ca.po
index bcb4da80fb9..2bcda556147 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -10390,7 +10390,7 @@ msgstr ""
 "Nota: la configuració «pull.rebase» també podria estar establerta a\n"
 "+-«preserve», que ja no s'admet; utilitzeu «merge» en el seu lloc"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "No hi ha un «rebase» en curs?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/de.po b/po/de.po
index 37d6c809983..7ea1dd5b1a0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10522,7 +10522,7 @@ msgstr ""
 "'preserve' gesetzt, was nicht länger unterstützt wird; nutzen Sie\n"
 "stattdessen 'merges'"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Kein Rebase im Gange?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/el.po b/po/el.po
index 703f46d0c7c..d68d2542a4f 100644
--- a/po/el.po
+++ b/po/el.po
@@ -15726,7 +15726,7 @@ msgid "It looks like 'git am' is in progress. Cannot rebase."
 msgstr ""
 
 #: builtin/rebase.c:1208 git-legacy-rebase.sh:406
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr ""
 
 #: builtin/rebase.c:1212 git-legacy-rebase.sh:417
diff --git a/po/es.po b/po/es.po
index 1ff5ff3911d..55fb9e0c81d 100644
--- a/po/es.po
+++ b/po/es.po
@@ -10109,7 +10109,7 @@ msgstr ""
 "configurada a 'preserve', el cual ya no es soportado; usa 'merges' en\n"
 "su lugar"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "¿No hay rebase en progreso?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/fr.po b/po/fr.po
index 736a90f6bb6..cae2b1dd12b 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -10495,7 +10495,7 @@ msgstr ""
 "Note : votre configuration `pull.rebase` peut aussi être 'preserve',\n"
 "qui n'est plus géré ; utilisez 'merges' à la place"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Pas de rebasage en cours ?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/id.po b/po/id.po
index 3e8b212b617..966ebb9a269 100644
--- a/po/id.po
+++ b/po/id.po
@@ -12843,7 +12843,7 @@ msgstr ""
 "yang tidak lagi didukung; gunakan 'merges' sebagai gantinya"
 
 #: builtin/rebase.c
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Tidak ada pendasaran ulang yang sedang berjalan?"
 
 #: builtin/rebase.c
diff --git a/po/it.po b/po/it.po
index c31560834d8..1b1ca2d2990 100644
--- a/po/it.po
+++ b/po/it.po
@@ -19666,7 +19666,7 @@ msgid "cannot combine '--root' with '--fork-point'"
 msgstr "impossibile combinare '--root' con '--fork-point'"
 
 #: builtin/rebase.c:1495
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Nessun rebase in corso?"
 
 #: builtin/rebase.c:1499
diff --git a/po/ko.po b/po/ko.po
index 5d190e52380..783d5c5e8ad 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -16245,7 +16245,7 @@ msgid "It looks like 'git am' is in progress. Cannot rebase."
 msgstr "'git am'이 진행 중인 것처럼 보입니다. 리베이스할 수 없습니다."
 
 #: git-rebase.sh:403
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "리베이스가 진행 중이지 않습니다"
 
 #: git-rebase.sh:414
diff --git a/po/pl.po b/po/pl.po
index 0ec127e14cc..5f361d558ba 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -20449,7 +20449,7 @@ msgid "cannot combine '--root' with '--fork-point'"
 msgstr "„--root” i „--fork-point” się wykluczają"
 
 #: builtin/rebase.c:1202
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Nie trwa żadne przestawianie?"
 
 #: builtin/rebase.c:1206
diff --git a/po/pt_PT.po b/po/pt_PT.po
index 32142531bbd..6adae673fd3 100644
--- a/po/pt_PT.po
+++ b/po/pt_PT.po
@@ -20608,7 +20608,7 @@ msgid "--preserve-merges was replaced by --rebase-merges"
 msgstr ""
 
 #: builtin/rebase.c:1230
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Algum rebase em curso?"
 
 #: builtin/rebase.c:1234
diff --git a/po/ru.po b/po/ru.po
index 3e56eb546ea..ebcd6dded70 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -9986,7 +9986,7 @@ msgid ""
 "which is no longer supported; use 'merges' instead"
 msgstr ""
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Нет перемещения в процессе?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/sv.po b/po/sv.po
index 786c2f749e7..d11bd0fc59c 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -10153,7 +10153,7 @@ msgstr ""
 "Observera: Din inställning för ”pull.rebase” kan också vara satt till\n"
 "”preserve”, som inte längre stöds; använd ”merges” istället"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Ingen ombasering pågår?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/tr.po b/po/tr.po
index 19d6661bbe6..d568956c686 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -10278,7 +10278,7 @@ msgstr ""
 "Not: `pull.rebase` yapılandırmanız, artık desteklenmeyen'\n"
 "'preserve' olarak ayarlı olabilir; yerine 'merges' kullanın"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Sürmekte olan bir yeniden temellendirme yok"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/uk.po b/po/uk.po
index 0507e387bab..cd09d641817 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -10341,7 +10341,7 @@ msgstr ""
 "значення \"preserve\",\n"
 "який більше не підтримується; натомість використовуйте \"merges\""
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Перебазування не відбувається?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/vi.po b/po/vi.po
index d673745ac5b..869fb735c83 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -9963,7 +9963,7 @@ msgstr ""
 "'preserve',\n"
 "cái mà giờ không còn được hỗ trợ nữa; dùng 'merges' để thay thế"
 
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "Không có tiến trình rebase nào phải không?"
 
 msgid "The --edit-todo action can only be used during interactive rebase."
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 39efaf1012a..60ca9ffb2cb 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -12723,7 +12723,7 @@ msgstr ""
 "取而代之请使用 'merges'"
 
 #: builtin/rebase.c
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "没有正在进行的变基？"
 
 #: builtin/rebase.c
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 312dd128a41..5794e3f36fc 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -12603,7 +12603,7 @@ msgstr ""
 "請改用 “merges”"
 
 #: builtin/rebase.c
-msgid "No rebase in progress?"
+msgid "No rebase in progress"
 msgstr "沒有正在進行的重定基底？"
 
 #: builtin/rebase.c

base-commit: 96c8a0712e569dd2812bf4fb5e72113caf326500
-- 
gitgitgadget
