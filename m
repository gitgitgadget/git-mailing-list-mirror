Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1C13AA40
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416878; cv=none; b=fQa0U8QjDPGkuHYiZInl5y1QrgK3oSIaSsAkCUw85ZuLQfZ6FpWMMIWpx42NfIw6EGLCWuRQFczy1Zi2PsSWmMqE9nILZEHdvvt96woIUTZHp0eBqc0S0py9p42cZeyLC67U/DuUbNcb1LlD/hEQmoK2fYca7bsTV4QhK+vhWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416878; c=relaxed/simple;
	bh=TBtX/Broh3g7T8wMLA8EEWUAxN/+ewl1gfOhAqJG/Ow=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M6+M7npdFl7QgTb1JlwqZ+9HPP2rn7gRJIrOozcxSwYiZ+VkfaeKv7eNIun2J9bNTKIdDl2pRnFEO727qzZr5FfjJeVr3NwUKYUhiLxX+LUNgxVzN/kupRrg2s8C4lIfhznDGAFXoDK8+gmAAcmUQodHkt2lOBCfOJIvazG1wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1pYI4g7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1pYI4g7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso59333871fa.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714416874; x=1715021674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTJNbBkjW/kccpTcOOm9K8ugSTmx5uBgbqj3ngqJ5pM=;
        b=G1pYI4g70w98zK425Mh0OfDjr46+hgIbqVXxBrrGT4DdwhOHZ7Idg9McFpzSR87Uez
         VVGghVaXDYHdeXixmUh6M7FrDQB0zTnQAg+tb4FktWdoMAIS9QKIZI+zYWnTkRZ3udm+
         C/OT1Y+3rq8JBWYEpkzHU810pPVT7C5zmYehtR+zizZZ9UIht5I/I0uOrB+I6ZZilNzT
         9kPRSaZ7Dc99HmddZK6YWTiM4IJ6uVlzRFgFiqayAys/FZTobAmp3yU6YNQ0fmiLR1nz
         tT0Pf2xsZW2SgFNPP1OxQ120BSs8TU9z6KfMpYmu487bp33NJ4cEzaWEFfXQiLaegTxf
         Uj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416874; x=1715021674;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTJNbBkjW/kccpTcOOm9K8ugSTmx5uBgbqj3ngqJ5pM=;
        b=B1Ts8FhYS3ftdAvZAh0rPEWiVLPYLUnqqP6K4OkjazCxBUuuMKVYAQxUnELUQIVp1B
         dij2mWcBDvUzG3/6Nr7aCqdXTKwZ+iW+yxeavoh834Pp38UH7qMUOSj3gnaaBNo6w42R
         nHHcuvnp1y4a7bkR2ExmT47FiEE5vLgLuh5mpp94Ey9m0+vGwGCikng6vAeSojDU2bU6
         WziYLdx3VJlU1487eaD4INgzSifmpa+H18jdbybpoPnET7i04kImOWHqT77OTbGD+mKM
         G4DplAs4W0tegzCVV961vLE7oeBzdwWozeth4wkPqfZqZ4xcMyqDzzqWVXWdMgz8ppx8
         EM8w==
X-Gm-Message-State: AOJu0YxxuXEMITvraX0uci+d/9zeEBaMBYrwIRvqPR8VpJESrefjnEUx
	gg1K4351E5VKrnPqA3/OsgcUy5NM//G/OtDYm4vlxhOI0cv9cCED6m1xyg==
X-Google-Smtp-Source: AGHT+IE0fTu6v6cCj4OIj/sx5jIqijYK5QEPVLjE1K8McKogge0kRS+3pcvlHgbVUuv1d1+kks2eZw==
X-Received: by 2002:a2e:7d09:0:b0:2e0:3ad2:b36f with SMTP id y9-20020a2e7d09000000b002e03ad2b36fmr3898501ljc.13.1714416874012;
        Mon, 29 Apr 2024 11:54:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600c474500b0041bd85cd3f2sm9963084wmo.19.2024.04.29.11.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:54:33 -0700 (PDT)
Message-Id: <d5335e30b0bf8f126f5bd3ac71d8a0afb3fa86f6.1714416865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
References: <pull.1723.v2.git.1714409638089.gitgitgadget@gmail.com>
	<pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
From: "John Passaro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Apr 2024 18:54:23 +0000
Subject: [PATCH v3 3/3] po: update git-tag translations
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>,
    John Passaro <john.a.passaro@gmail.com>

From: John Passaro <john.a.passaro@gmail.com>

Update translation files to translate the updated git-tag help headline
with its new --trailer option.

Also perform some related cleanup. Most notably, update git-tag headline
in files where it references a stale version: i.e. where we are still
attempting to translate the former one-line description of git-tag that
described the argument as "[<head>]", instead of current "[<commit> |
<object>]".

In both cases, reuse translations found elsewhere in the file.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 po/bg.po    |  2 ++
 po/ca.po    |  4 +++-
 po/de.po    |  2 ++
 po/el.po    |  9 ++++++---
 po/es.po    | 14 ++++++++------
 po/fr.po    |  2 ++
 po/id.po    |  2 ++
 po/it.po    |  6 ++++--
 po/ko.po    | 10 ++++++----
 po/pl.po    |  6 ++++--
 po/ru.po    |  1 +
 po/sv.po    |  2 ++
 po/tr.po    |  2 ++
 po/uk.po    |  2 ++
 po/vi.po    |  2 ++
 po/zh_CN.po |  2 ++
 po/zh_TW.po |  2 ++
 17 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index a7cbc617a53..d2fe6c87186 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -13555,9 +13555,11 @@ msgstr "причина за обновяването"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a|-s|-u ИДЕНТИФИКАТОР_НА_КЛЮЧ] [-f] [-m СЪОБЩЕНИЕ|-F ФАЙЛ] [-e]\n"
+"        [(--trailer ЛЕКСЕМА[(=|:)СТОЙНОСТ])…]\n"
 "        ЕТИКЕТ [ПОДАВАНЕ|ОБЕКТ]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/ca.po b/po/ca.po
index bcb4da80fb9..8c8f52985b7 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -13114,10 +13114,12 @@ msgstr "raó de l'actualització"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <fitxer>] [-e]\n"
-"        <tagname> [<comissió> | <objecte>]"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <nom-d'etiqueta> [<comissió> | <objecte>]"
 
 msgid "git tag -d <tagname>..."
 msgstr "git tag -d <nom-d'etiqueta>..."
diff --git a/po/de.po b/po/de.po
index 29465665976..5380f294920 100644
--- a/po/de.po
+++ b/po/de.po
@@ -13297,9 +13297,11 @@ msgstr "Grund für die Aktualisierung"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <Key-ID>] [-f] [-m <Beschreibung> | -F <Datei>] [-e]\n"
+"        [(--trailer <Token>[(=|:)<Wert>])...]\n"
 "        <Tagname> [<Commit> | <Objekt>]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/el.po b/po/el.po
index 703f46d0c7c..210304b75da 100644
--- a/po/el.po
+++ b/po/el.po
@@ -18093,11 +18093,14 @@ msgstr ""
 
 #: builtin/tag.c:25
 msgid ""
-"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> "
-"[<head>]"
+"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <αναγνωριστικό κλειδί>] [-f] [-m <μήνυμα> | -F "
-"<αρχείο>] <όνομα ετικέτας> [<head>]"
+"<αρχείο>]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <όνομα ετικέτας> [<υποβολή> | <αντικείμενο>]"
 
 #: builtin/tag.c:26
 msgid "git tag -d <tagname>..."
diff --git a/po/es.po b/po/es.po
index 1ff5ff3911d..b7b15ad6e4b 100644
--- a/po/es.po
+++ b/po/es.po
@@ -12682,10 +12682,12 @@ msgstr "razón de la actualización"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
-"        <tagname> [<head>]"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <tagname> [<commit> | <object>]"
 msgstr ""
-"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
-"        <tagname> [<head>]"
+"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <archivo>]\n"
+"        [(--trailer <token>[(=|:)<valor>])...]\n"
+"        <nombre-de-tag> [<commit> | <objeto>]"
 
 msgid "git tag -d <tagname>..."
 msgstr "git tag -d <nombre-de-tag>..."
@@ -12697,8 +12699,8 @@ msgid ""
 "[<pattern>...]"
 msgstr ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--"
-"points-at <object>]\n"
-"        [--format=<format>] [--merged <commit>] [--no-merged <commit>] "
+"points-at <objeto>]\n"
+"        [--format=<formato>] [--merged <commit>] [--no-merged <commit>] "
 "[<pattern>...]"
 
 msgid "git tag -v [--format=<format>] <tagname>..."
@@ -18461,7 +18463,7 @@ msgstr "%%(body) no toma ningún argumento"
 
 #, c-format
 msgid "expected %%(trailers:key=<value>)"
-msgstr "se esperaba %%(trailers:key=<value>)"
+msgstr "se esperaba %%(trailers:key=<valor>)"
 
 #, c-format
 msgid "unknown %%(trailers) argument: %s"
diff --git a/po/fr.po b/po/fr.po
index 837a695485a..2f7a345c74a 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -13266,9 +13266,11 @@ msgstr "raison de la mise à jour"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <id-clé>] [-f] [-m <msg> | -F <fichier>] [-e]\n"
+"        [(--trailer <symbole>[(=|:)<valeur>])...]\n"
 "        <nom-d-étiquette> [<commit> | <objet>]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/id.po b/po/id.po
index 2dc4b79e8a5..85b5631b3c7 100644
--- a/po/id.po
+++ b/po/id.po
@@ -16230,9 +16230,11 @@ msgstr "alasan pembaruan"
 #: builtin/tag.c
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <id kunci>] [-f] [-m <pesan> | -F <berkas>] [-e]\n"
+"        [(--trailer <token>[(=|:)<nilai>])...]\n"
 "        <nama tag> [<komit> | <objek>]"
 
 #: builtin/tag.c
diff --git a/po/it.po b/po/it.po
index c31560834d8..c4ceb8b2444 100644
--- a/po/it.po
+++ b/po/it.po
@@ -22486,10 +22486,12 @@ msgstr "motivo dell'aggiornamento"
 #: builtin/tag.c:25
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
-"\t\t<tagname> [<head>]"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <ID chiave>] [-f] [-m <messaggio> | -F <file>]\n"
-"\t\t<nome tag> [<head>]"
+"        [(--trailer <token>[(=|:)<valore>])...]\n"
+"        <nome tag> [<commit> | <oggetto>]"
 
 #: builtin/tag.c:27
 msgid "git tag -d <tagname>..."
diff --git a/po/ko.po b/po/ko.po
index 5d190e52380..7484304eddb 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -14397,11 +14397,13 @@ msgstr "업데이트의 이유"
 
 #: builtin/tag.c:24
 msgid ""
-"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> "
-"[<head>]"
+"git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <tagname> [<commit> | <object>]"
 msgstr ""
-"git tag [-a | -s | -u <키-ID>] [-f] [-m <메시지> | -F <파일>] <태그이름>\n"
-"\t\t[<헤드>]"
+"git tag [-a | -s | -u <키-ID>] [-f] [-m <메시지> | -F <파일>]\n"
+"        [(--trailer <토큰>[(=|:)<값>])...]\n"
+"        <태그이름> [<커밋> | <오브젝트>]"
 
 #: builtin/tag.c:25
 msgid "git tag -d <tagname>..."
diff --git a/po/pl.po b/po/pl.po
index 0ec127e14cc..287354b17b4 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -23549,10 +23549,12 @@ msgstr "powód aktualizacji"
 #: builtin/tag.c:25
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
-"        <tagname> [<head>]"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
+"        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <id-klucza>] [-f] [-m <komunikat> | -F <plik>]\n"
-"        <tag> [<czoło>]"
+"        [(--trailer <klucz>[(=|:)<wartość>])...]\n"
+"        <nazwa-tagu> [<zapis> | <obiekt>]"
 
 #: builtin/tag.c:27
 msgid "git tag -d <tagname>..."
diff --git a/po/ru.po b/po/ru.po
index 3e56eb546ea..d357bc30c2c 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -12490,6 +12490,7 @@ msgstr "причина обновления"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 
diff --git a/po/sv.po b/po/sv.po
index ad1aad94fff..1f878ee28bc 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -12835,9 +12835,11 @@ msgstr "skäl till uppdateringen"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <nyckel-id>] [-f] [-m <medd> | -F <fil>] [-e]\n"
+"        [(--trailer <symbol>[(=|:)<värde>])...]\n"
 "        <taggnamn> [<incheckning> | <objekt>]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/tr.po b/po/tr.po
index 0e220e1c1cd..8c506c34a9e 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -12975,10 +12975,12 @@ msgstr "güncelleme nedeni"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <anahtar-kimliği>] [-f] [-m <ileti> | -F <dosya>] [-"
 "e]\n"
+"        [(--trailer <jeton>[(=|:)<değer>])...]\n"
 "        <etiket-adı> [<işleme> | <nesne>]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/uk.po b/po/uk.po
index 528a3dc6f76..e3b6441e3c1 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -13086,10 +13086,12 @@ msgstr "причина оновлення"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <ідентифікатор-ключа>] [-f] [-m <допис> | -F <файл>] [-"
 "e]\n"
+"        [(--trailer <токен>[(=|:)<значення>])...]\n"
 "        <назва-тегу> [<коміт> | <об’єкт>]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/vi.po b/po/vi.po
index 965e79e9658..0b206309f9b 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -12915,9 +12915,11 @@ msgstr "lý do cập nhật"
 
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <tập-tin>] [-e]\n"
+"        [(--trailer <thẻ>[(=|:)<giá-trị>])...]\n"
 "        <tên-thẻ> [<lần chuyển giao> | <đối tượng> ]"
 
 msgid "git tag -d <tagname>..."
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 4838c19b0be..aaedddcd864 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -16033,9 +16033,11 @@ msgstr "更新的原因"
 #: builtin/tag.c
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <私钥 ID>] [-f] [-m <消息> | -F <文件>] [-e]\n"
+"        [(--trailer <键>[(=|:)<值>])...]\n"
 "        <标签名> [<提交> | <对象>]"
 
 #: builtin/tag.c
diff --git a/po/zh_TW.po b/po/zh_TW.po
index f554381a7af..168591c141e 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -15911,9 +15911,11 @@ msgstr "更新的原因"
 #: builtin/tag.c
 msgid ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 msgstr ""
 "git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+"        [(--trailer <token>[(=|:)<value>])...]\n"
 "        <tagname> [<commit> | <object>]"
 
 #: builtin/tag.c
-- 
gitgitgadget
