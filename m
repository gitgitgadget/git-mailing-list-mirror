Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6BF1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 17:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934867AbeAKRoK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 12:44:10 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:44282 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934821AbeAKRoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 12:44:07 -0500
Received: by mail-wm0-f51.google.com with SMTP id t8so7104444wmc.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDwIs5Ly5sXgeqMSDmXBjotEeFzsc68QZ5V7WgN0/+w=;
        b=I9HxIml7GyBN81EVD4OGYyyP0whUQIMooZRHmHdVdx9DXYEHtZ+Vqq7VF9R+PIqPmA
         f5lKgjZxUp1cCt8sDUIQM89mOfNZ1F0nt3Ywg1FG2EknL4gHps3Z51mGEGoETxpVYYsB
         8qJ7SAaGIoRUlzXqT5w6YnNtEOHM2uQHO/gPUT7gY0unew8+MtYJr4/4oe7192QZ54q/
         jRPlDf9+IPnFPnLpM+bTwLHioJOUfN66nqw9rPTz/s90vXYs7h0Nd6lKPz0b9yPURTer
         XCKozIKh4kDswU6z2dXNEr4N5KnonGVk0+bZ8U3wUGSY8vXxcYLyAzCl/uTFZ0k5zEQk
         Fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDwIs5Ly5sXgeqMSDmXBjotEeFzsc68QZ5V7WgN0/+w=;
        b=aIXrESWUKCsmjpgJvp8UgIfWCmGxuTYffUdNxQfMg4NqCyGYZMaVKTHsOfxAVeT1dJ
         6VhAYICPBbdfDDFAKNqtyT8V0pIBqM33axibCh9SMnxzf63XDVSNpypRY2o//t4c+UIt
         1G2htwjtyUzo3eLRKTtkgBYGt+UIoSkU4wza3wGKVIkHCuUEmbjrlQAXfNNYxZYwUAbU
         PQPL7l/QzJdnF0LdEbP6jKA4157nSw9SlL7o5OMDi6gfru7c5k9UVNhP84OUgNj7/+CK
         yizAHr66/Mgue5bZ+daEcnpEPBicaDJfbugK1rjgRl7CRA0YX1x3hOcfkH+cOfeCDiGa
         o+Og==
X-Gm-Message-State: AKGB3mIv584PrWEc4rpDg0DNRJvwP9/ZXa2VYBW7C9/qC2swv9xfKtw2
        CCkVJv0eiejxrrHbXF+d/bZQGZvG
X-Google-Smtp-Source: ACJfBovudzoRhfuydo2gi6PlQHmP20aEOGo2CA7//8+Tt+wTLj4/XrWIBYuU+GjtT8M4Jcxhvizd+g==
X-Received: by 10.80.134.232 with SMTP id 37mr31687523edu.135.1515692645319;
        Thu, 11 Jan 2018 09:44:05 -0800 (PST)
Received: from localhost (cable-82-119-28-222.cust.telecolumbus.net. [82.119.28.222])
        by smtp.gmail.com with ESMTPSA id j3sm11697873edh.55.2018.01.11.09.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jan 2018 09:44:04 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 72 new messages
Date:   Thu, 11 Jan 2018 18:44:01 +0100
Message-Id: <20180111174401.8006-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 72 new messages came from git.pot update in 18a907225 (l10n:
git.pot: v2.16.0 round 1 (64 new, 25 removed)) and 005c62fe4 (l10n:
git.pot: v2.16.0 round 2 (8 new, 4 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 227 +++++++++++++++++++++++++++------------------------------------
 1 file changed, 98 insertions(+), 129 deletions(-)

diff --git a/po/de.po b/po/de.po
index b24b28875..6f04621b9 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1716,7 +1716,7 @@ msgstr "Konnte Git-Verzeichnis nicht von '%s' nach '%s' migrieren."
 #: editor.c:61
 #, c-format
 msgid "hint: Waiting for your editor to close the file...%c"
-msgstr ""
+msgstr "Hinweis: Warte auf das Schließen der Datei durch Ihren Editor...%c"
 
 #: entry.c:177
 msgid "Filtering content"
@@ -2087,12 +2087,12 @@ msgstr "Ungültiges Datumsformat: %s"
 
 #: list-objects-filter-options.c:30
 msgid "multiple object filter types cannot be combined"
-msgstr ""
+msgstr "Mehrere Arten von Objekt-Filtern können nicht kombiniert werden."
 
 #: list-objects-filter-options.c:41 list-objects-filter-options.c:68
-#, fuzzy, c-format
+#, c-format
 msgid "invalid filter-spec expression '%s'"
-msgstr "Ungültige Datei: '%s'"
+msgstr "Ungültiger filter-spec Ausdruck '%s'."
 
 #: lockfile.c:151
 #, c-format
@@ -2356,9 +2356,9 @@ msgid "Adding %s"
 msgstr "Füge %s hinzu"
 
 #: merge-recursive.c:1958
-#, fuzzy, c-format
+#, c-format
 msgid "Dirty index: cannot merge (dirty: %s)"
-msgstr "Geänderter Index: kann Patches nicht anwenden (geändert: %s)"
+msgstr "Geänderter Index: kann nicht mergen (geändert: %s)"
 
 #: merge-recursive.c:1962
 msgid "Already up to date!"
@@ -3015,6 +3015,8 @@ msgid ""
 "The '%s' hook was ignored because it's not set as executable.\n"
 "You can disable this warning with `git config advice.ignoredHook false`."
 msgstr ""
+"Der '%s' Hook wurde ignoriert, weil er nicht als ausführbar markiert ist.\n"
+"Sie können diese Warnung mit `git config advice.ignoredHook false` deaktivieren."
 
 #: send-pack.c:141
 #, c-format
@@ -3137,14 +3139,12 @@ msgid "%s: Unable to write new index file"
 msgstr "%s: Konnte neue Index-Datei nicht schreiben"
 
 #: sequencer.c:496
-#, fuzzy
 msgid "could not resolve HEAD commit"
-msgstr "Konnte HEAD-Commit nicht auflösen\n"
+msgstr "Konnte HEAD-Commit nicht auflösen."
 
 #: sequencer.c:516
-#, fuzzy
 msgid "unable to update cache tree"
-msgstr "Konnte Cache-Verzeichnis nicht aktualisieren\n"
+msgstr "Konnte Cache-Verzeichnis nicht aktualisieren."
 
 #: sequencer.c:600
 #, c-format
@@ -3178,14 +3178,14 @@ msgstr ""
 "  git rebase --continue\n"
 
 #: sequencer.c:702
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse commit %s"
-msgstr "Konnte Commit %s nicht parsen\n"
+msgstr "Konnte Commit %s nicht parsen."
 
 #: sequencer.c:707
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse parent commit %s"
-msgstr "Konnte Eltern-Commit %s nicht parsen\n"
+msgstr "Konnte Eltern-Commit %s nicht parsen."
 
 #: sequencer.c:836
 #, c-format
@@ -3316,14 +3316,14 @@ msgid "git %s: failed to refresh the index"
 msgstr "git %s: Fehler beim Aktualisieren des Index"
 
 #: sequencer.c:1270
-#, fuzzy, c-format
+#, c-format
 msgid "%s does not accept arguments: '%s'"
-msgstr "%%(body) akzeptiert keine Argumente"
+msgstr "%s akzeptiert keine Argumente: '%s'"
 
 #: sequencer.c:1279
-#, fuzzy, c-format
+#, c-format
 msgid "missing arguments for %s"
-msgstr "Objekt %s fehlt für %s"
+msgstr "Fehlende Argumente für %s."
 
 #: sequencer.c:1322
 #, c-format
@@ -4965,7 +4965,7 @@ msgstr "versionierte Dateien aktualisieren"
 
 #: builtin/add.c:299
 msgid "renormalize EOL of tracked files (implies -u)"
-msgstr ""
+msgstr "erneutes Normalisieren der Zeilenenden von versionierten Dateien (impliziert -u)"
 
 #: builtin/add.c:300
 msgid "record only the fact that the path will be added later"
@@ -5507,36 +5507,34 @@ msgstr "git bisect--helper --next-all [--no-checkout]"
 
 #: builtin/bisect--helper.c:13
 msgid "git bisect--helper --write-terms <bad_term> <good_term>"
-msgstr ""
+msgstr "git bisect--helper --write-terms <bad_term> <good_term>"
 
 #: builtin/bisect--helper.c:14
-#, fuzzy
 msgid "git bisect--helper --bisect-clean-state"
-msgstr "git bisect--helper --next-all [--no-checkout]"
+msgstr "git bisect--helper --bisect-clean-state"
 
 #: builtin/bisect--helper.c:46
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a valid term"
-msgstr "'%s' ist keine gültige Referenz."
+msgstr "'%s' ist kein gültiger Begriff."
 
 #: builtin/bisect--helper.c:50
-#, fuzzy, c-format
+#, c-format
 msgid "can't use the builtin command '%s' as a term"
-msgstr "Kann eingebauten Befehl '$term' nicht als Begriff verwenden"
+msgstr "Kann den eingebauten Befehl '%s' nicht als Begriff verwenden."
 
 #: builtin/bisect--helper.c:60
-#, fuzzy, c-format
+#, c-format
 msgid "can't change the meaning of the term '%s'"
-msgstr "Kann Bedeutung von '$term' nicht ändern."
+msgstr "Kann die Bedeutung von dem Begriff '%s' nicht ändern."
 
 #: builtin/bisect--helper.c:71
 msgid "please use two different terms"
 msgstr "Bitte verwenden Sie zwei verschiedene Begriffe."
 
 #: builtin/bisect--helper.c:78
-#, fuzzy
 msgid "could not open the file BISECT_TERMS"
-msgstr "konnte temporäre Datei '%s' nicht öffnen"
+msgstr "Konnte die Datei BISECT_TERMS nicht öffnen."
 
 #: builtin/bisect--helper.c:120
 msgid "perform 'git bisect next'"
@@ -5544,29 +5542,27 @@ msgstr "'git bisect next' ausführen"
 
 #: builtin/bisect--helper.c:122
 msgid "write the terms to .git/BISECT_TERMS"
-msgstr ""
+msgstr "die Begriffe nach .git/BISECT_TERMS schreiben"
 
 #: builtin/bisect--helper.c:124
 msgid "cleanup the bisection state"
-msgstr ""
+msgstr "den Zustand der binären Suche aufräumen"
 
 #: builtin/bisect--helper.c:126
 msgid "check for expected revs"
-msgstr ""
+msgstr "auf erwartete Commits prüfen"
 
 #: builtin/bisect--helper.c:128
 msgid "update BISECT_HEAD instead of checking out the current commit"
 msgstr "BISECT_HEAD aktualisieren, anstatt den aktuellen Commit auszuchecken"
 
 #: builtin/bisect--helper.c:143
-#, fuzzy
 msgid "--write-terms requires two arguments"
-msgstr "--abort akzeptiert keine Argumente"
+msgstr "--write-terms benötigt zwei Argumente."
 
 #: builtin/bisect--helper.c:147
-#, fuzzy
 msgid "--bisect-clean-state requires no arguments"
-msgstr "--continue erwartet keine Argumente"
+msgstr "--bisect-clean-state erwartet keine Argumente."
 
 #: builtin/blame.c:27
 msgid "git blame [<options>] [<rev-opts>] [<rev>] [--] <file>"
@@ -5857,9 +5853,9 @@ msgid "Branch copy failed"
 msgstr "Kopie des Branches fehlgeschlagen"
 
 #: builtin/branch.c:517
-#, fuzzy, c-format
+#, c-format
 msgid "Created a copy of a misnamed branch '%s'"
-msgstr "falsch benannten Branch '%s' umbenannt"
+msgstr "Kopie eines falsch benannten Branches '%s' erstellt."
 
 #: builtin/branch.c:520
 #, c-format
@@ -5908,7 +5904,7 @@ msgstr "Informationsmeldungen unterdrücken"
 
 #: builtin/branch.c:590
 msgid "set up tracking mode (see git-pull(1))"
-msgstr "den Übernahmemodus einstellen (siehe git-pull(1))"
+msgstr "Modus zum Folgen von Branches einstellen (siehe git-pull(1))"
 
 #: builtin/branch.c:592
 msgid "do not use"
@@ -7513,9 +7509,9 @@ msgstr ""
 "vorhandenen Autor überein"
 
 #: builtin/commit.c:1090
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid ignored mode '%s'"
-msgstr "Ungültiger Modus '%s' für unversionierte Dateien"
+msgstr "Ungültiger ignored-Modus '%s'."
 
 #: builtin/commit.c:1104 builtin/commit.c:1349
 #, c-format
@@ -7624,13 +7620,10 @@ msgstr ""
 "all)"
 
 #: builtin/commit.c:1382
-#, fuzzy
 msgid ""
 "show ignored files, optional modes: traditional, matching, no. (Default: "
 "traditional)"
-msgstr ""
-"unversionierte Dateien anzeigen, optionale Modi: all, normal, no. (Standard: "
-"all)"
+msgstr "ignorierte Dateien anzeigen, optionale Modi: traditional, matching, no. (Standard: traditional)"
 
 #: builtin/commit.c:1384 parse-options.h:155
 msgid "when"
@@ -7650,7 +7643,7 @@ msgstr "unversionierte Dateien in Spalten auflisten"
 
 #: builtin/commit.c:1406
 msgid "Unsupported combination of ignored and untracked-files arguments"
-msgstr ""
+msgstr "Nicht unterstützte Kombination von ignored und untracked-files Argumenten."
 
 #: builtin/commit.c:1469
 msgid "couldn't look up newly created commit"
@@ -7661,9 +7654,8 @@ msgid "could not parse newly created commit"
 msgstr "Konnte neu erstellten Commit nicht analysieren."
 
 #: builtin/commit.c:1516
-#, fuzzy
 msgid "unable to resolve HEAD after creating commit"
-msgstr "Konnte HEAD-Commit nicht auflösen\n"
+msgstr "Konnte HEAD nicht auflösen, nachdem der Commit erstellt wurde."
 
 #: builtin/commit.c:1518
 msgid "detached HEAD"
@@ -7975,7 +7967,7 @@ msgstr "Wert ist ein Pfad (Datei oder Verzeichnisname)"
 
 #: builtin/config.c:84
 msgid "value is an expiry date"
-msgstr ""
+msgstr "Wert ist ein Verfallsdatum"
 
 #: builtin/config.c:85
 msgid "Other"
@@ -8088,7 +8080,7 @@ msgstr "kein Tag entspricht exakt '%s'"
 #: builtin/describe.c:316
 #, c-format
 msgid "No exact match on refs or tags, searching to describe\n"
-msgstr ""
+msgstr "Keine exakte Übereinstimmung bei Referenzen oder Tags, Suche zum Beschreiben\n"
 
 #: builtin/describe.c:363
 #, c-format
@@ -8128,9 +8120,9 @@ msgstr ""
 "Suche bei %s aufgegeben\n"
 
 #: builtin/describe.c:494
-#, fuzzy, c-format
+#, c-format
 msgid "describe %s\n"
-msgstr "suche zur Beschreibung von %s\n"
+msgstr "Beschreibe %s\n"
 
 #: builtin/describe.c:497 builtin/log.c:500
 #, c-format
@@ -8138,9 +8130,9 @@ msgid "Not a valid object name %s"
 msgstr "%s ist kein gültiger Objekt-Name"
 
 #: builtin/describe.c:505
-#, fuzzy, c-format
+#, c-format
 msgid "%s is neither a commit nor blob"
-msgstr "'%s' ist kein Commit"
+msgstr "%s ist weder ein Commit, noch ein Blob."
 
 #: builtin/describe.c:519
 msgid "find the tag that comes after the commit"
@@ -9863,14 +9855,12 @@ msgid "Use mail map file"
 msgstr "\"mailmap\"-Datei verwenden"
 
 #: builtin/log.c:155
-#, fuzzy
 msgid "only decorate refs that match <pattern>"
-msgstr "nur Referenzen verwenden, die <Muster> entsprechen"
+msgstr "\"decorate\" nur bei Referenzen anwenden, die <Muster> entsprechen"
 
 #: builtin/log.c:157
-#, fuzzy
 msgid "do not decorate refs that match <pattern>"
-msgstr "keine Tags betrachten, die <Muster> entsprechen"
+msgstr "\"decorate\" nicht bei Referenzen anwenden, die <Muster> entsprechen"
 
 #: builtin/log.c:158
 msgid "decorate options"
@@ -10207,10 +10197,8 @@ msgstr ""
 "Kleinbuchstaben für Dateien mit 'assume unchanged' Markierung verwenden"
 
 #: builtin/ls-files.c:521
-#, fuzzy
 msgid "use lowercase letters for 'fsmonitor clean' files"
-msgstr ""
-"Kleinbuchstaben für Dateien mit 'assume unchanged' Markierung verwenden"
+msgstr "Kleinbuchstaben für 'fsmonitor clean' Dateien verwenden"
 
 #: builtin/ls-files.c:523
 msgid "show cached files in the output (default)"
@@ -11104,9 +11092,8 @@ msgid "git notes [--ref <notes-ref>] remove [<object>...]"
 msgstr "git notes [--ref <Notiz-Referenz>] remove [<Objekt>...]"
 
 #: builtin/notes.c:36
-#, fuzzy
 msgid "git notes [--ref <notes-ref>] prune [-n] [-v]"
-msgstr "git notes [--ref <Notiz-Referenz>] prune [-n | -v]"
+msgstr "git notes [--ref <Notiz-Referenz>] prune [-n] [-v]"
 
 #: builtin/notes.c:37
 msgid "git notes [--ref <notes-ref>] get-ref"
@@ -11516,9 +11503,8 @@ msgid "Compressing objects"
 msgstr "Komprimiere Objekte"
 
 #: builtin/pack-objects.c:2599
-#, fuzzy
 msgid "invalid value for --missing"
-msgstr "Ungültiger Wert für %s"
+msgstr "Ungültiger Wert für --missing."
 
 #: builtin/pack-objects.c:2902
 #, c-format
@@ -11675,9 +11661,8 @@ msgid "write a bitmap index together with the pack index"
 msgstr "Bitmap-Index zusammen mit Pack-Index schreiben"
 
 #: builtin/pack-objects.c:3010
-#, fuzzy
 msgid "handling for missing objects"
-msgstr "fehlende Objekte erlauben"
+msgstr "Behandlung für fehlende Objekte"
 
 #: builtin/pack-objects.c:3144
 msgid "Counting objects"
@@ -11704,9 +11689,8 @@ msgid "Removing duplicate objects"
 msgstr "Lösche doppelte Objekte"
 
 #: builtin/prune.c:11
-#, fuzzy
 msgid "git prune [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]"
-msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<head>...]"
+msgstr "git prune [-n] [-v] [--progress] [--expire <Zeit>] [--] [<Branch>...]"
 
 #: builtin/prune.c:106
 msgid "report pruned objects"
@@ -12315,14 +12299,12 @@ msgid "make rebase script"
 msgstr "Rebase-Skript erstellen"
 
 #: builtin/rebase--helper.c:32
-#, fuzzy
 msgid "shorten commit ids in the todo list"
-msgstr "SHA-1's in der TODO-Liste verkürzen"
+msgstr "Commit-IDs in der TODO-Liste verkürzen"
 
 #: builtin/rebase--helper.c:34
-#, fuzzy
 msgid "expand commit ids in the todo list"
-msgstr "SHA1's in der TODO-Liste erweitern"
+msgstr "Commit-IDs in der TODO-Liste erweitern"
 
 #: builtin/rebase--helper.c:36
 msgid "check the todo list"
@@ -12337,9 +12319,8 @@ msgid "rearrange fixup/squash lines"
 msgstr "fixup/squash-Zeilen umordnen"
 
 #: builtin/rebase--helper.c:42
-#, fuzzy
 msgid "insert exec commands in todo list"
-msgstr "SHA1's in der TODO-Liste erweitern"
+msgstr "\"exec\"-Befehle in TODO-Liste einfügen"
 
 #: builtin/receive-pack.c:30
 msgid "git receive-pack <git-dir>"
@@ -13254,12 +13235,12 @@ msgstr "Konnte neue Index-Datei nicht schreiben."
 
 #: builtin/rev-list.c:399
 msgid "object filtering requires --objects"
-msgstr ""
+msgstr "Das Filtern von Objekten erfordert --objects."
 
 #: builtin/rev-list.c:402
-#, fuzzy, c-format
+#, c-format
 msgid "invalid sparse value '%s'"
-msgstr "Ungültiger Farbwert: %.*s"
+msgstr "Ungültiger \"sparse\"-Wert '%s'."
 
 #: builtin/rev-list.c:442
 msgid "rev-list does not support display of notes"
@@ -13267,7 +13248,7 @@ msgstr "rev-list unterstützt keine Anzeige von Notizen"
 
 #: builtin/rev-list.c:445
 msgid "cannot combine --use-bitmap-index with object filtering"
-msgstr ""
+msgstr "--use-bitmap-index kann nicht mit dem Filtern von Objekten kombiniert werden."
 
 #: builtin/rev-parse.c:402
 msgid "git rev-parse --parseopt [<options>] -- [<args>...]"
@@ -13804,35 +13785,32 @@ msgid "no submodule mapping found in .gitmodules for path '%s'"
 msgstr "Keine Submodul-Zuordnung in .gitmodules für Pfad '%s' gefunden"
 
 #: builtin/submodule--helper.c:626
-#, fuzzy, c-format
+#, c-format
 msgid "could not resolve HEAD ref inside the submodule '%s'"
-msgstr "Fehler bei Rekursion in Submodul-Pfad '%s'"
+msgstr "Konnte HEAD-Referenz nicht innerhalb des Submodul-Pfads '%s' auflösen."
 
 #: builtin/submodule--helper.c:653
-#, fuzzy, c-format
+#, c-format
 msgid "failed to recurse into submodule '%s'"
-msgstr "Fehler bei Rekursion in Submodul-Pfad '%s'"
+msgstr "Fehler bei Rekursion in Submodul '%s'."
 
 #: builtin/submodule--helper.c:677
-#, fuzzy
 msgid "Suppress submodule status output"
-msgstr "dies an die Ausgabe der Submodul-Pfade voranstellen"
+msgstr "Ausgabe über Submodul-Status unterdrücken"
 
 #: builtin/submodule--helper.c:678
 msgid ""
 "Use commit stored in the index instead of the one stored in the submodule "
 "HEAD"
-msgstr ""
+msgstr "benutze den Commit, der im Index gespeichert ist, statt den im Submodul HEAD"
 
 #: builtin/submodule--helper.c:679
-#, fuzzy
 msgid "recurse into nested submodules"
-msgstr "Rekursion in Submodule durchführen"
+msgstr "Rekursion in verschachtelte Submodule durchführen"
 
 #: builtin/submodule--helper.c:684
-#, fuzzy
 msgid "git submodule status [--quiet] [--cached] [--recursive] [<path>...]"
-msgstr "git submodule--helper update_clone [--prefix=<Pfad>] [<Pfad>...]"
+msgstr "git submodule status [--quiet] [--cached] [--recursive] [<Pfad>...]"
 
 #: builtin/submodule--helper.c:708
 msgid "git submodule--helper name <path>"
@@ -14426,21 +14404,19 @@ msgstr ""
 
 #: builtin/update-index.c:1022
 msgid "write out the index even if is not flagged as changed"
-msgstr ""
+msgstr "Index rausschreiben, auch wenn dieser nicht als geändert markiert ist"
 
 #: builtin/update-index.c:1024
-#, fuzzy
 msgid "enable or disable file system monitor"
-msgstr "Splitting des Index aktivieren oder deaktivieren"
+msgstr "Dateisystem-Monitor aktivieren oder deaktivieren"
 
 #: builtin/update-index.c:1026
-#, fuzzy
 msgid "mark files as fsmonitor valid"
-msgstr "diese Datei immer als unverändert betrachten"
+msgstr "Dateien als \"fsmonitor valid\" markieren"
 
 #: builtin/update-index.c:1029
 msgid "clear fsmonitor valid bit"
-msgstr ""
+msgstr "\"fsmonitor valid\"-Bit löschen"
 
 #: builtin/update-index.c:1127
 msgid ""
@@ -14485,27 +14461,25 @@ msgid "Untracked cache enabled for '%s'"
 msgstr "Cache für unversionierte Dateien für '%s' aktiviert"
 
 #: builtin/update-index.c:1171
-#, fuzzy
 msgid "core.fsmonitor is unset; set it if you really want to enable fsmonitor"
 msgstr ""
-"core.splitIndex ist auf 'false' gesetzt. Entfernen oder ändern Sie dies,\n"
-"wenn sie wirklich das Splitting des Index aktivieren möchten."
+"core.fsmonitor nicht gesetzt. Setzen Sie es, wenn Sie den Dateisystem-Monitor\n"
+"wirklich aktivieren möchten."
 
 #: builtin/update-index.c:1175
 msgid "fsmonitor enabled"
-msgstr ""
+msgstr "Dateisystem-Monitor aktiviert"
 
 #: builtin/update-index.c:1178
-#, fuzzy
 msgid ""
 "core.fsmonitor is set; remove it if you really want to disable fsmonitor"
 msgstr ""
-"core.splitIndex ist auf 'true' gesetzt. Entfernen oder ändern Sie dies,\n"
-"wenn Sie wirklich das Splitting des Index deaktivieren möchten."
+"core.fsmonitor ist gesetzt. Löschen Sie es, wenn Sie den Dateisystem-Monitor\n"
+"wirklich deaktivieren möchten."
 
 #: builtin/update-index.c:1182
 msgid "fsmonitor disabled"
-msgstr ""
+msgstr "Dateisystem-Monitor deaktiviert"
 
 #: builtin/update-ref.c:10
 msgid "git update-ref [<options>] -d <refname> [<old-val>]"
@@ -14676,23 +14650,22 @@ msgid "keep the new working tree locked"
 msgstr "das neue Arbeitsverzeichnis gesperrt lassen"
 
 #: builtin/worktree.c:377
-#, fuzzy
 msgid "set up tracking mode (see git-branch(1))"
-msgstr "den Übernahmemodus einstellen (siehe git-pull(1))"
+msgstr "Modus zum Folgen von Branches einstellen (siehe git-branch(1))"
 
 #: builtin/worktree.c:380
-#, fuzzy
 msgid "try to match the new branch name with a remote-tracking branch"
-msgstr "Upstream-Branch '%s' nicht als Remote-Tracking-Branch gespeichert"
+msgstr ""
+"versuchen, eine Übereinstimmung des Branch-Namens mit einem\n"
+"Remote-Tracking-Branch herzustellen"
 
 #: builtin/worktree.c:388
 msgid "-b, -B, and --detach are mutually exclusive"
 msgstr "-b, -B und --detach schließen sich gegenseitig aus"
 
 #: builtin/worktree.c:453
-#, fuzzy
 msgid "--[no-]track can only be used if a new branch is created"
-msgstr "--local kann nur innerhalb eines Git-Repositories verwendet werden."
+msgstr "--[no]-track kann nur verwendet werden, wenn ein neuer Branch erstellt wird."
 
 #: builtin/worktree.c:553
 msgid "reason for locking"
@@ -14824,12 +14797,11 @@ msgstr "Leite nach %s um"
 
 #: list-objects-filter-options.h:54
 msgid "args"
-msgstr ""
+msgstr "Argumente"
 
 #: list-objects-filter-options.h:55
-#, fuzzy
 msgid "object filtering"
-msgstr "Art des Objektes"
+msgstr "Filtern nach Objekten"
 
 #: common-cmds.h:9
 msgid "start a working area (see also: git help tutorial)"
@@ -15106,7 +15078,7 @@ msgstr "?? Was reden Sie da?"
 
 #: git-bisect.sh:453
 msgid "bisect run failed: no command provided."
-msgstr ""
+msgstr "'bisect run' fehlgeschlagen: kein Befehl angegeben."
 
 #: git-bisect.sh:458
 #, sh-format
@@ -15235,9 +15207,8 @@ msgid "The pre-rebase hook refused to rebase."
 msgstr "Der \"pre-rebase hook\" hat den Rebase zurückgewiesen."
 
 #: git-rebase.sh:219
-#, fuzzy
 msgid "It looks like 'git am' is in progress. Cannot rebase."
-msgstr "\"git-am\" scheint im Gange zu sein. Kann Rebase nicht durchführen."
+msgstr "'git-am' scheint im Gange zu sein. Kann Rebase nicht durchführen."
 
 #: git-rebase.sh:363
 msgid "No rebase in progress?"
@@ -15283,9 +15254,9 @@ msgstr ""
 "etwas Schützenswertes vorhanden ist."
 
 #: git-rebase.sh:480
-#, fuzzy, sh-format
+#, sh-format
 msgid "invalid upstream '$upstream_name'"
-msgstr "ungültiger Upstream-Branch $upstream_name"
+msgstr "Ungültiger Upstream-Branch '$upstream_name'."
 
 #: git-rebase.sh:504
 #, sh-format
@@ -15303,9 +15274,9 @@ msgid "Does not point to a valid commit: $onto_name"
 msgstr "$onto_name zeigt auf keinen gültigen Commit"
 
 #: git-rebase.sh:542
-#, fuzzy, sh-format
+#, sh-format
 msgid "fatal: no such branch/commit '$branch_name'"
-msgstr "fatal: Branch $branch_name nicht gefunden"
+msgstr "fatal: Branch/Commit '$branch_name' nicht gefunden"
 
 #: git-rebase.sh:575
 msgid "Cannot autostash"
@@ -15321,9 +15292,9 @@ msgid "Please commit or stash them."
 msgstr "Bitte committen Sie die Änderungen oder benutzen Sie \"stash\"."
 
 #: git-rebase.sh:607
-#, fuzzy, sh-format
+#, sh-format
 msgid "HEAD is up to date."
-msgstr "HEAD ist jetzt bei"
+msgstr "HEAD ist aktuell."
 
 #: git-rebase.sh:609
 #, sh-format
@@ -15331,10 +15302,9 @@ msgid "Current branch $branch_name is up to date."
 msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
 
 #: git-rebase.sh:617
-#, fuzzy, sh-format
+#, sh-format
 msgid "HEAD is up to date, rebase forced."
-msgstr ""
-"Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzwungen."
+msgstr "HEAD ist aktuell, Rebase erzwungen."
 
 #: git-rebase.sh:619
 #, sh-format
@@ -15398,7 +15368,7 @@ msgstr "Kann $ref_stash nicht mit $w_commit aktualisieren."
 #: git-stash.sh:281
 #, sh-format
 msgid "error: unknown option for 'stash push': $option"
-msgstr ""
+msgstr "Fehler: unbekannte Option für 'stash push': $option"
 
 #: git-stash.sh:295
 msgid "Can't use --patch and --include-untracked or --all at the same time"
@@ -16107,9 +16077,8 @@ msgid "Could not init rewritten commits"
 msgstr "Konnte neu geschriebene Commits nicht initialisieren."
 
 #: git-rebase--interactive.sh:897
-#, fuzzy
 msgid "Could not generate todo list"
-msgstr "Konnte nicht nach %s schreiben"
+msgstr "Konnte TODO-Liste nicht erzeugen."
 
 #: git-rebase--interactive.sh:973
 #, sh-format
-- 
2.16.0.rc0.223.g4a4ac8367

