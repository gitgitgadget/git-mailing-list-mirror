Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F291FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 17:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbdJTRwR (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 13:52:17 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55706 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753115AbdJTRwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 13:52:16 -0400
Received: by mail-wm0-f44.google.com with SMTP id u138so24247297wmu.4
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pF4F8mBsrW8lbtuCUyBYRN8sv1X0JBOovf5rLW64hic=;
        b=iO8sioK4ukVgYS0kjUJU1Ry+6S1Q4CTEGY28TRD2P/fwgwETqwVZechGIAZsjYppaw
         XTR5Z4FnUC5FALLKp4/JWi/BbmUhXR5dLV1hZ3JbUvhrNO7uzY/z1Lgr7nHv8y6jck0g
         xmLf0qy6Xi6MosIyBE6A0OdTyXNvtkBOpsZhdoMGOTNxAV0H1M434TnH0Vljv2e5vQ1s
         nG7uMpDY3B8hRIFqqonBovGCaQX7gGr6zQodHZ00qiqWUUOQgolg0eY6aAILq9c1p5yt
         j3SbT2ag1hZ0qB+hh5oeSjfS5ep9tnyMcuPwfvM0b2Hr8nacHHSO7hgV9UbWgb3giPEz
         TUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pF4F8mBsrW8lbtuCUyBYRN8sv1X0JBOovf5rLW64hic=;
        b=gRrBnagwSdOemznc1Ps5fjZglqNeNzOcFID4U15m+KOrukHxaRTbRNC+T4JEtRVj5Z
         DMDFPYvdUKqKyv3F9XxmfIMgxW7rjlAZdnPMj7Xun9Vocz3AHbaMUAmFd7rA9zOiZu90
         eSn3quj64OX2Nrx5z1w7lsdWVBTbpNkqIJ2yoOf+PD1zzYC13zY8dRdenD0sjN0No2vE
         BV6kORk949zg4/X+2/Qq6sg5I5uOQyzyllPi3YcQBGd9a5Hp4D4++ACEQ/zbJoTxmL/F
         w49drWybJiUqwsp2Ezh8HFJIauaZPXANt4zMC4613gGc061nXh6ejInj4Jgi8L1m0BsQ
         pzew==
X-Gm-Message-State: AMCzsaWXRG0g44gifJNYh755m2nq6EXH4nwPG0qr1sE9NhG5PtkHN/90
        kgjBiP98p/bmUMRpFZHfKYY2YzKm
X-Google-Smtp-Source: ABhQp+QhgTXBRqHFaAb2Fa8OuRWQBkM3ZCSd9ERS4NlJbDzKgVDkcYa+C7QTufFJAP6EYciOMPg8Pw==
X-Received: by 10.80.218.202 with SMTP id s10mr7440333edj.212.1508521934900;
        Fri, 20 Oct 2017 10:52:14 -0700 (PDT)
Received: from localhost (cable-82-119-19-179.cust.telecolumbus.net. [82.119.19.179])
        by smtp.gmail.com with ESMTPSA id j18sm1733128edh.36.2017.10.20.10.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2017 10:52:13 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Andre Hinrichs <andre.hinrichs@gmx.de>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: fix typos
Date:   Fri, 20 Oct 2017 19:52:11 +0200
Message-Id: <20171020175211.11161-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andre Hinrichs <andre.hinrichs@gmx.de>

Signed-off-by: Andre Hinrichs <andre.hinrichs@gmx.de>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/po/de.po b/po/de.po
index 0619c4988..a05aca5f3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -2389,7 +2389,7 @@ msgstr "Sie haben Ihren Merge von Notizen nicht abgeschlossen (%s existiert)."
 #: notes-utils.c:42
 msgid "Cannot commit uninitialized/unreferenced notes tree"
 msgstr ""
-"Kann uninitialisiertes/unreferenzierte Notiz-Verzeichnis nicht committen."
+"Kann uninitialisiertes/unreferenziertes Notiz-Verzeichnis nicht committen."
 
 #: notes-utils.c:101
 #, c-format
@@ -4805,7 +4805,7 @@ msgstr "nichts zum Commit vorgemerkt, aber es gibt unversionierte Dateien\n"
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to track)\n"
 msgstr ""
-"nichts zu committen (Erstellen/Kopieren Sie Dateien und benutzen\n"
+"nichts zu committen (erstellen/kopieren Sie Dateien und benutzen\n"
 "Sie \"git add\" zum Versionieren)\n"
 
 #: wt-status.c:1661 wt-status.c:1666
@@ -7141,7 +7141,7 @@ msgstr "Abstand zum linken Rand"
 
 #: builtin/column.c:32
 msgid "Padding space on right border"
-msgstr "Abstand zur rechten Rand"
+msgstr "Abstand zum rechten Rand"
 
 #: builtin/column.c:33
 msgid "Padding space between columns"
@@ -7573,7 +7573,7 @@ msgstr "Konnte neu erstellten Commit nicht nachschlagen."
 
 #: builtin/commit.c:1451
 msgid "could not parse newly created commit"
-msgstr "Konnte neulich erstellten Commit nicht analysieren."
+msgstr "Konnte neu erstellten Commit nicht analysieren."
 
 #: builtin/commit.c:1496
 msgid "detached HEAD"
@@ -8482,7 +8482,7 @@ msgstr "%s hat nicht alle erforderlichen Objekte gesendet\n"
 #, c-format
 msgid "reject %s because shallow roots are not allowed to be updated"
 msgstr ""
-"%s wurde zurückgewiesen, da Ursprungs-Commits von Repositoriesmit "
+"%s wurde zurückgewiesen, da Ursprungs-Commits von Repositories mit "
 "unvollständiger Historie (shallow) nicht aktualisiert werden dürfen."
 
 #: builtin/fetch.c:877 builtin/fetch.c:973
@@ -10539,7 +10539,7 @@ msgstr "--continue erwartet keine Argumente"
 
 #: builtin/merge.c:1192
 msgid "There is no merge in progress (MERGE_HEAD missing)."
-msgstr "Es ist keine Merge im Gange (MERGE_HEAD fehlt)."
+msgstr "Es ist kein Merge im Gange (MERGE_HEAD fehlt)."
 
 #: builtin/merge.c:1208
 msgid ""
@@ -10917,7 +10917,7 @@ msgstr "nur Tags verwenden, um die Commits zu benennen"
 
 #: builtin/name-rev.c:398
 msgid "only use refs matching <pattern>"
-msgstr "nur Referenzen verwenden die <Muster> entsprechen"
+msgstr "nur Referenzen verwenden, die <Muster> entsprechen"
 
 #: builtin/name-rev.c:400
 msgid "ignore refs matching <pattern>"
@@ -12395,7 +12395,7 @@ msgstr "alle Tags und verbundene Objekte beim Anfordern importieren"
 
 #: builtin/remote.c:165
 msgid "or do not fetch any tag at all (--no-tags)"
-msgstr "oder fordere gar keine Zweige an (--no-tags)"
+msgstr "oder fordere gar keine Tags an (--no-tags)"
 
 #: builtin/remote.c:167
 msgid "branch(es) to track"
@@ -12498,7 +12498,7 @@ msgstr[0] ""
 "gelöscht;\n"
 "um diesen zu löschen, benutzen Sie:"
 msgstr[1] ""
-"Hinweis: Einige Branches außer der refs/remotes/ Hierarchie wurden nicht "
+"Hinweis: Einige Branches außerhalb der refs/remotes/ Hierarchie wurden nicht "
 "entfernt;\n"
 "um diese zu entfernen, benutzen Sie:"
 
@@ -14247,7 +14247,7 @@ msgstr "Cache für unversionierte Dateien aktivieren oder deaktivieren"
 #: builtin/update-index.c:1008
 msgid "test if the filesystem supports untracked cache"
 msgstr ""
-"prüfen ob das Dateisystem einen Cache für unversionierte Dateien unterstützt"
+"prüfen, ob das Dateisystem einen Cache für unversionierte Dateien unterstützt"
 
 #: builtin/update-index.c:1010
 msgid "enable untracked cache without testing the filesystem"
@@ -14942,7 +14942,7 @@ msgid ""
 "Error: Your local changes to the following files would be overwritten by "
 "merge"
 msgstr ""
-"Fehler Ihre lokalen Änderungen in den folgenden Dateien würden durch den "
+"Fehler: Ihre lokalen Änderungen in den folgenden Dateien würden durch den "
 "Merge\n"
 "überschrieben werden"
 
@@ -15242,7 +15242,7 @@ msgstr "Konnte den Index nicht aktualisieren."
 
 #: git-stash.sh:568
 msgid "Cannot apply a stash in the middle of a merge"
-msgstr "Kann \"stash\" nicht anwenden, solang ein Merge im Gange ist"
+msgstr "Kann \"stash\" nicht anwenden, solange ein Merge im Gange ist"
 
 #: git-stash.sh:576
 msgid "Conflicts in index. Try without --index."
@@ -15268,7 +15268,7 @@ msgstr "Index wurde nicht aus dem Stash zurückgeladen."
 #: git-stash.sh:641
 msgid "The stash entry is kept in case you need it again."
 msgstr ""
-"Der Stash-Eintrag wird behalten, im Falle Sie benötigen diesen nochmal."
+"Der Stash-Eintrag wird für den Fall behalten, dass Sie diesen nochmal benötigen."
 
 #: git-stash.sh:650
 #, sh-format
@@ -16468,7 +16468,7 @@ msgstr "Fehlerhafter regulärer Ausdruck für Suche %s: %s\n"
 
 #: git-add--interactive.perl:1505
 msgid "No hunk matches the given pattern\n"
-msgstr "Kein Patch-Block entspricht dem angegebenen Pattern\n"
+msgstr "Kein Patch-Block entspricht dem angegebenen Muster\n"
 
 #: git-add--interactive.perl:1517 git-add--interactive.perl:1539
 msgid "No previous hunk\n"
-- 
2.15.0.rc1.299.gda03b47c3

