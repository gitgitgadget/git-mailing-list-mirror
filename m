Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A6B1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 05:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeC1Fzt (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 01:55:49 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50846 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeC1Fzq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 01:55:46 -0400
Received: by mail-wm0-f49.google.com with SMTP id l201so2599578wmg.0
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQsDUHpZr0WV3UiV5WK/1RxBZyuwpPXwLziHQ38VCRY=;
        b=mRLTKxrCfObPDyxrXvWUQu0DgJV2XqakjiWg1cYHIuv/ELhDYPLEECmGrKzNNW/SfQ
         A+Obe9U8UCPWi8du15Z6v9peSf51DP0b7hivb1ZQCpruxPWwz7e4WhCG7DdhakeCGoFU
         rSpNBIo1+oSMfn0WFLK1yNzx9VhlSmGA0pfe3frP9eZfpeUusm8sHLc+J2lcSIjNcXOG
         rhBD3AYg+MkAdmgeaePeRWrZb+qhLFk7VeqpYSzu1uiIQHulDrcKIPzFLk7LJB3vK51h
         RVm0f2I81OsMTzrC2tJ39WzinR0lhxbQqZLcoVWIptg5RVdu8rdenBATQD1qUScRwICp
         1woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQsDUHpZr0WV3UiV5WK/1RxBZyuwpPXwLziHQ38VCRY=;
        b=M+K3EN6b2wM9DjGtq4f+jDIeVzQYruf0QwsK6WEL73aSr8RYswsixOdGpRk+PF+6O0
         M6j6GyjXz8ERKqFg7vMHPW6B2ZBWmr3EKBOOAMk7qiw+tMDcLz/h2WkBZQcEGrgKtC0U
         wAfX+wX72M81z1h/yDp4Jm/b/upTGFqpx9vdjuT7FtLps5iy3zopnX8BjqE7/sAgXjzi
         bJXCvErMo0nXC1BoEvJCaL5lqsGEF2Yg+TFX5hl4fPHismtMzingHXMU662Ra0CfKhtZ
         5hJ/6cVINhIpXK6+30urkN3uGY2GqDablIHn+JtUo5pT8QQqlBHwrp7HLTiJu0xuPVAJ
         oUEA==
X-Gm-Message-State: AElRT7Ei1q937+4xVaeLWKVZ0FIkY4ZTqOfEzu6z+3VN5AweTtMM5ZmN
        DBffXFOuglvxQVEVOgDIKTFx1g==
X-Google-Smtp-Source: AIpwx492lt8tn+/bqbLIL2ScOX5cIScPzuTKDhMsAS4IVCdWkz0d8pVJ95f1P1RbnrOu2vhXCVEueA==
X-Received: by 10.80.222.131 with SMTP id c3mr2003903edl.220.1522216543772;
        Tue, 27 Mar 2018 22:55:43 -0700 (PDT)
Received: from localhost (cable-62-117-25-183.cust.telecolumbus.net. [62.117.25.183])
        by smtp.gmail.com with ESMTPSA id t4sm1871642edt.33.2018.03.27.22.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 22:55:42 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 132 new messages
Date:   Wed, 28 Mar 2018 07:55:31 +0200
Message-Id: <20180328055531.4769-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187df
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 132 new message came from git.pot update in abc8de64d (l10n:
git.pot: v2.17.0 round 1 (132 new, 44 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 455 +++++++++++++++++++++++++------------------------------
 1 file changed, 209 insertions(+), 246 deletions(-)

diff --git a/po/de.po b/po/de.po
index 852c02a9b..793bd2a80 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1654,15 +1654,14 @@ msgstr "externes Diff-Programm unerwartet beendet, angehalten bei %s"
 #: diff.c:4146
 msgid "--name-only, --name-status, --check and -s are mutually exclusive"
 msgstr ""
 "--name-only, --name-status, --check und -s schließen sich gegenseitig aus"
 
 #: diff.c:4149
-#, fuzzy
 msgid "-G, -S and --find-object are mutually exclusive"
-msgstr "-b, -B und --detach schließen sich gegenseitig aus"
+msgstr "-G, -S und --find-object schließen sich gegenseitig aus"
 
 #: diff.c:4237
 msgid "--follow requires exactly one pathspec"
 msgstr "--follow erfordert genau eine Pfadspezifikation"
 
 #: diff.c:4403
@@ -1695,15 +1694,15 @@ msgid ""
 "you may want to set your %s variable to at least %d and retry the command."
 msgstr ""
 "Sie könnten die Variable %s auf mindestens %d setzen und den Befehl\n"
 "erneut versuchen."
 
 #: dir.c:1866
-#, fuzzy, c-format
+#, c-format
 msgid "could not open directory '%s'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte Verzeichnis '%s' nicht öffnen."
 
 #: dir.c:2108
 msgid "failed to get kernel name and information"
 msgstr "Fehler beim Sammeln von Namen und Informationen zum Kernel"
 
 #: dir.c:2232
@@ -1731,27 +1730,25 @@ msgstr "Hinweis: Warte auf das Schließen der Datei durch Ihren Editor...%c"
 msgid "Filtering content"
 msgstr "Filtere Inhalt"
 
 #: entry.c:435
 #, c-format
 msgid "could not stat file '%s'"
-msgstr "konnte Datei '%s' nicht lesen"
+msgstr "Konnte Datei '%s' nicht lesen."
 
 #: fetch-object.c:17
-#, fuzzy
 msgid "Remote with no URL"
-msgstr "git archive: Externes Archiv ohne URL"
+msgstr "Remote-Repository ohne URL"
 
 #: fetch-pack.c:253
 msgid "git fetch-pack: expected shallow list"
 msgstr "git fetch-pack: erwartete shallow-Liste"
 
 #: fetch-pack.c:265
-#, fuzzy
 msgid "git fetch-pack: expected ACK/NAK, got a flush packet"
-msgstr "git fetch-pack: ACK/NAK erwartet, '%s' bekommen"
+msgstr "git fetch-pack: ACK/NAK erwartet, Flush-Paket bekommen"
 
 #: fetch-pack.c:284 builtin/archive.c:63
 #, c-format
 msgid "remote error: %s"
 msgstr "Fehler am anderen Ende: %s"
 
@@ -1883,15 +1880,14 @@ msgstr "Server unterstützt allow-reachable-sha1-in-want"
 
 #: fetch-pack.c:979
 msgid "Server supports ofs-delta"
 msgstr "Server unterstützt ofs-delta"
 
 #: fetch-pack.c:985
-#, fuzzy
 msgid "Server supports filter"
-msgstr "Server unterstützt ofs-delta"
+msgstr "Server unterstützt Filter"
 
 #: fetch-pack.c:993
 #, c-format
 msgid "Server version is %.*s"
 msgstr "Server-Version ist %.*s"
 
@@ -2104,19 +2100,18 @@ msgstr "Name besteht nur aus nicht erlaubten Zeichen: %s"
 #: ident.c:416 builtin/commit.c:582
 #, c-format
 msgid "invalid date format: %s"
 msgstr "Ungültiges Datumsformat: %s"
 
 #: list-objects-filter-options.c:36
-#, fuzzy
 msgid "multiple filter-specs cannot be combined"
-msgstr "Mehrere Arten von Objekt-Filtern können nicht kombiniert werden."
+msgstr "Mehrere filter-specs können nicht kombiniert werden."
 
 #: list-objects-filter-options.c:126
 msgid "cannot change partial clone promisor remote"
-msgstr ""
+msgstr "Kann Remote-Repository für partielles Klonen nicht ändern."
 
 #: lockfile.c:151
 #, c-format
 msgid ""
 "Unable to create '%s.lock': %s.\n"
 "\n"
@@ -2964,20 +2959,20 @@ msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n"
 #: remote.c:2139
 #, c-format
 msgid "Your branch is up to date with '%s'.\n"
 msgstr "Ihr Branch ist auf demselben Stand wie '%s'.\n"
 
 #: remote.c:2143
-#, fuzzy, c-format
+#, c-format
 msgid "Your branch and '%s' refer to different commits.\n"
-msgstr "Ihr Branch ist %2$d Commit vor '%1$s'.\n"
+msgstr "Ihr Branch und '%s' zeigen auf unterschiedliche Commits.\n"
 
 #: remote.c:2146
 #, c-format
 msgid "  (use \"%s\" for details)\n"
-msgstr ""
+msgstr "  (benutzen Sie \"%s\" für Details)\n"
 
 #: remote.c:2150
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
 msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
 msgstr[0] "Ihr Branch ist %2$d Commit vor '%1$s'.\n"
@@ -3048,15 +3043,14 @@ msgid ""
 msgstr ""
 "Der '%s' Hook wurde ignoriert, weil er nicht als ausführbar markiert ist.\n"
 "Sie können diese Warnung mit `git config advice.ignoredHook false` "
 "deaktivieren."
 
 #: send-pack.c:141
-#, fuzzy
 msgid "unexpected flush packet while reading remote unpack status"
-msgstr "Konnte Status des Entpackens der Gegenseite nicht parsen: %s"
+msgstr "Unerwartetes Flush-Paket beim Lesen des Remote-Unpack-Status."
 
 #: send-pack.c:143
 #, c-format
 msgid "unable to parse remote unpack status: %s"
 msgstr "Konnte Status des Entpackens der Gegenseite nicht parsen: %s"
 
@@ -3088,15 +3082,15 @@ msgstr "die Gegenseite unterstützt keinen atomaren Versand (\"--atomic push\")"
 
 #: send-pack.c:440
 msgid "the receiving end does not support push options"
 msgstr "die Gegenseite unterstützt keine Push-Optionen"
 
 #: sequencer.c:158
-#, fuzzy, c-format
+#, c-format
 msgid "invalid commit message cleanup mode '%s'"
-msgstr "Ungültiger \"cleanup\" Modus %s"
+msgstr "Ungültiger \"cleanup\"-Modus '%s' für Commit-Beschreibungen."
 
 #: sequencer.c:267
 msgid "revert"
 msgstr "Revert"
 
 #: sequencer.c:269
@@ -3144,13 +3138,13 @@ msgstr "Konnte nicht nach '%s' schreiben."
 #: sequencer.c:353
 #, c-format
 msgid "could not write eol to '%s'"
 msgstr "Konnte EOL nicht nach '%s' schreiben."
 
 #: sequencer.c:356 sequencer.c:2128 sequencer.c:2252
-#, fuzzy, c-format
+#, c-format
 msgid "failed to finalize '%s'"
 msgstr "Fehler beim Fertigstellen von '%s'."
 
 #: sequencer.c:379 sequencer.c:1340 sequencer.c:2148 builtin/am.c:259
 #: builtin/commit.c:722 builtin/merge.c:1047
 #, c-format
@@ -3217,15 +3211,14 @@ msgstr ""
 "\n"
 "Im Anschluss führen Sie zum Fortfahren aus:\n"
 "\n"
 "  git rebase --continue\n"
 
 #: sequencer.c:915
-#, fuzzy
 msgid "'prepare-commit-msg' hook failed"
-msgstr "commit-msg Hook überprüfen"
+msgstr "'prepare-commit-msg' Hook fehlgeschlagen."
 
 #: sequencer.c:922
 msgid ""
 "Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n"
 "You can suppress this message by setting them explicitly. Run the\n"
@@ -3296,38 +3289,36 @@ msgstr "losgelöster HEAD"
 
 #: sequencer.c:1029
 msgid " (root-commit)"
 msgstr " (Basis-Commit)"
 
 #: sequencer.c:1050
-#, fuzzy
 msgid "could not parse HEAD"
-msgstr "Konnte HEAD nicht lesen"
+msgstr "Konnte HEAD nicht parsen."
 
 #: sequencer.c:1052
-#, fuzzy, c-format
+#, c-format
 msgid "HEAD %s is not a commit!"
-msgstr "%s %s ist kein Commit!"
+msgstr "HEAD %s ist kein Commit!"
 
 #: sequencer.c:1056 builtin/commit.c:1491
 msgid "could not parse HEAD commit"
 msgstr "Konnte Commit von HEAD nicht analysieren."
 
 #: sequencer.c:1107 sequencer.c:1673
-#, fuzzy
 msgid "unable to parse commit author"
-msgstr "Konnte Commit '%s' nicht parsen."
+msgstr "Konnte Commit-Autor nicht parsen."
 
 #: sequencer.c:1117 builtin/am.c:1630 builtin/merge.c:643
 msgid "git write-tree failed to write a tree"
 msgstr "\"git write-tree\" schlug beim Schreiben eines \"Tree\"-Objektes fehl"
 
 #: sequencer.c:1134 sequencer.c:1186
-#, fuzzy, c-format
+#, c-format
 msgid "unable to read commit message from '%s'"
-msgstr "Konnte Commit-Beschreibung von %s nicht lesen."
+msgstr "Konnte Commit-Beschreibung von '%s' nicht lesen."
 
 #: sequencer.c:1154 builtin/am.c:1650 builtin/commit.c:1594 builtin/merge.c:826
 #: builtin/merge.c:851
 msgid "failed to write commit object"
 msgstr "Fehler beim Schreiben des Commit-Objektes."
 
@@ -3808,15 +3799,15 @@ msgstr "Konnte Commit '%s' nicht parsen."
 
 #: sequencer.c:3401
 msgid "the script was already rearranged."
 msgstr "Das Script wurde bereits umgeordnet."
 
 #: setup.c:122
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is outside repository"
-msgstr "%s: '%s' liegt außerhalb des Repositories"
+msgstr "'%s' liegt außerhalb des Repositories."
 
 #: setup.c:171
 #, c-format
 msgid ""
 "%s: no such path in the working tree.\n"
 "Use 'git <command> -- <path>...' to specify paths that do not exist locally."
@@ -3835,15 +3826,15 @@ msgstr ""
 "mehrdeutiges Argument '%s': unbekannter Commit oder Pfad existiert nicht\n"
 "im Arbeitsverzeichnis\n"
 "Benutzen Sie '--', um Pfade und Commits zu trennen, ähnlich wie:\n"
 "'git <Befehl> [<Commit>...] -- [<Datei>...]'"
 
 #: setup.c:233
-#, fuzzy, c-format
+#, c-format
 msgid "option '%s' must come before non-option arguments"
-msgstr "das Parsen nach dem ersten Argument, was keine Option ist, stoppen"
+msgstr "Die Option '%s' muss vor den Argumenten kommen, die keine Optionen sind."
 
 #: setup.c:252
 #, c-format
 msgid ""
 "ambiguous argument '%s': both revision and filename\n"
 "Use '--' to separate paths from revisions, like this:\n"
@@ -3851,131 +3842,126 @@ msgid ""
 msgstr ""
 "mehrdeutiges Argument '%s': sowohl Commit als auch Dateiname\n"
 "Benutzen Sie '--', um Pfade und Commits zu trennen, ähnlich wie:\n"
 "'git <Befehl> [<Commit>...] -- [<Datei>...]'"
 
 #: setup.c:388
-#, fuzzy
 msgid "unable to set up work tree using invalid config"
-msgstr "Konnte aktuelles Arbeitsverzeichnis nicht bekommen."
+msgstr "Konnte Arbeitsverzeichnis mit ungültiger Konfiguration nicht einrichten."
 
 #: setup.c:395
 msgid "this operation must be run in a work tree"
-msgstr ""
+msgstr "Diese Operation muss in einem Arbeitsverzeichnis ausgeführt werden."
 
 #: setup.c:506
 #, c-format
 msgid "Expected git repo version <= %d, found %d"
 msgstr "Erwartete Git-Repository-Version <= %d, %d gefunden"
 
 #: setup.c:514
 msgid "unknown repository extensions found:"
 msgstr "Unbekannte Repository-Erweiterungen gefunden:"
 
 #: setup.c:533
-#, fuzzy, c-format
+#, c-format
 msgid "error opening '%s'"
-msgstr "Fehler beim Öffnen von '%s'"
+msgstr "Fehler beim Öffnen von '%s'."
 
 #: setup.c:535
-#, fuzzy, c-format
+#, c-format
 msgid "too large to be a .git file: '%s'"
-msgstr "Konnte Eingabe-Datei '%s' nicht lesen"
+msgstr "Zu groß, um eine .git-Datei zu sein: '%s'"
 
 #: setup.c:537
-#, fuzzy, c-format
+#, c-format
 msgid "error reading %s"
-msgstr "Fehler beim Einpacken von %s."
+msgstr "Fehler beim Lesen von '%s'."
 
 #: setup.c:539
-#, fuzzy, c-format
+#, c-format
 msgid "invalid gitfile format: %s"
-msgstr "Ungültiges Datumsformat: %s"
+msgstr "Ungültiges gitfile-Format: %s"
 
 #: setup.c:541
-#, fuzzy, c-format
+#, c-format
 msgid "no path in gitfile: %s"
-msgstr "Kann Patch-Datei %s nicht öffnen"
+msgstr "Kein Pfad in gitfile: %s"
 
 #: setup.c:543
-#, fuzzy, c-format
+#, c-format
 msgid "not a git repository: %s"
-msgstr "Kein Git-Repository"
+msgstr "Kein Git-Repository: %s"
 
 #: setup.c:642
 #, c-format
 msgid "'$%s' too big"
-msgstr ""
+msgstr "'$%s' zu groß"
 
 #: setup.c:656
-#, fuzzy, c-format
+#, c-format
 msgid "not a git repository: '%s'"
-msgstr "Kein Git-Repository"
+msgstr "Kein Git-Repository: '%s'"
 
 #: setup.c:685 setup.c:687 setup.c:718
-#, fuzzy, c-format
+#, c-format
 msgid "cannot chdir to '%s'"
-msgstr "kann nicht in Verzeichnis %s wechseln"
+msgstr "Kann nicht in Verzeichnis '%s' wechseln."
 
 #: setup.c:690 setup.c:746 setup.c:756 setup.c:795 setup.c:803 setup.c:818
-#, fuzzy
 msgid "cannot come back to cwd"
-msgstr "Kann nicht zurück zum Arbeitsverzeichnis wechseln"
+msgstr "Kann nicht zum aktuellen Arbeitsverzeichnis zurückwechseln."
 
 #: setup.c:816
-#, fuzzy, c-format
+#, c-format
 msgid "not a git repository (or any of the parent directories): %s"
-msgstr "Kein Git-Repository (oder irgendein Elternverzeichnis): %s"
+msgstr "Kein Git-Repository (oder irgendeines der Elternverzeichnisse): %s"
 
 #: setup.c:827
-#, fuzzy, c-format
+#, c-format
 msgid "failed to stat '%*s%s%s'"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%*s%s%s' nicht lesen."
 
 #: setup.c:1057
 msgid "Unable to read current working directory"
 msgstr "Konnte aktuelles Arbeitsverzeichnis nicht lesen."
 
 #: setup.c:1069 setup.c:1075
-#, fuzzy, c-format
+#, c-format
 msgid "cannot change to '%s'"
 msgstr "Kann nicht nach '%s' wechseln."
 
 #: setup.c:1088
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "not a git repository (or any parent up to mount point %s)\n"
 "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."
 msgstr ""
 "Kein Git-Repository (oder irgendein Elternverzeichnis bis zum Einhängepunkt "
 "%s)\n"
 "Stoppe bei Dateisystemgrenze (GIT_DISCOVERY_ACROSS_FILESYSTEM nicht gesetzt)."
 
 #: setup.c:1172
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "problem with core.sharedRepository filemode value (0%.3o).\n"
 "The owner of files must always have read and write permissions."
 msgstr ""
 "Problem mit Wert für Dateimodus (0%.3o) von core.sharedRepository.\n"
 "Der Besitzer der Dateien muss immer Lese- und Schreibrechte haben."
 
 #: setup.c:1215
-#, fuzzy
 msgid "open /dev/null or dup failed"
-msgstr "Öffnen von /dev/null fehlgeschlagen"
+msgstr "Öffnen von /dev/null oder dup fehlgeschlagen."
 
 #: setup.c:1230
-#, fuzzy
 msgid "fork failed"
-msgstr "\"fseek\" fehlgeschlagen"
+msgstr "fork fehlgeschlagen"
 
 #: setup.c:1235
-#, fuzzy
 msgid "setsid failed"
-msgstr "\"stash\" fehlgeschlagen"
+msgstr "setsid fehlgeschlagen"
 
 #: sha1_file.c:592
 #, c-format
 msgid "path '%s' does not exist"
 msgstr "Pfad '%s' existiert nicht"
 
@@ -4569,33 +4555,33 @@ msgstr "ungültiges '..' Pfadsegment"
 msgid "failed to read '%s'"
 msgstr "Fehler beim Lesen von '%s'"
 
 #: worktree.c:291
 #, c-format
 msgid "'%s' at main working tree is not the repository directory"
-msgstr ""
+msgstr "'%s' im Hauptarbeitsverzeichnis ist nicht das Repository-Verzeichnis."
 
 #: worktree.c:302
 #, c-format
 msgid "'%s' file does not contain absolute path to the working tree location"
-msgstr ""
+msgstr "'%s' Datei enthält nicht den absoluten Pfad zum Arbeitsverzeichnis."
 
 #: worktree.c:314
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' does not exist"
-msgstr "Pfad '%s' existiert nicht"
+msgstr "'%s' existiert nicht."
 
 #: worktree.c:320
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is not a .git file, error code %d"
-msgstr "'%s' ist nicht gesperrt"
+msgstr "'%s' ist keine .git-Datei, Fehlercode %d"
 
 #: worktree.c:328
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' does not point back to '%s'"
-msgstr "'%s' zeigt auf keinen Commit"
+msgstr "'%s' zeigt nicht zurück auf '%s'"
 
 #: wrapper.c:223 wrapper.c:393
 #, c-format
 msgid "could not open '%s' for reading and writing"
 msgstr "Konnte '%s' nicht zum Lesen und Schreiben öffnen."
 
@@ -5109,13 +5095,13 @@ msgstr "Noch keine Commits in "
 #: wt-status.c:1813
 msgid "HEAD (no branch)"
 msgstr "HEAD (kein Branch)"
 
 #: wt-status.c:1844
 msgid "different"
-msgstr ""
+msgstr "unterschiedlich"
 
 #: wt-status.c:1846 wt-status.c:1854
 msgid "behind "
 msgstr "hinterher "
 
 #: wt-status.c:1849 wt-status.c:1852
@@ -5523,12 +5509,14 @@ msgstr "Keine Änderungen -- Patches bereits angewendet."
 msgid "Patch failed at %s %.*s"
 msgstr "Anwendung des Patches fehlgeschlagen bei %s %.*s"
 
 #: builtin/am.c:1838
 msgid "Use 'git am --show-current-patch' to see the failed patch"
 msgstr ""
+"Benutzen Sie 'git am --show-current-patch', um den\n"
+"fehlgeschlagenen Patch zu sehen."
 
 #: builtin/am.c:1882
 msgid ""
 "No changes - did you forget to use 'git add'?\n"
 "If there is nothing left to stage, chances are that something else\n"
 "already introduced the same changes; you might want to skip this patch."
@@ -5674,18 +5662,17 @@ msgstr "den aktuellen Patch auslassen"
 msgid "restore the original branch and abort the patching operation."
 msgstr ""
 "ursprünglichen Branch wiederherstellen und Anwendung der Patches abbrechen"
 
 #: builtin/am.c:2287
 msgid "abort the patching operation but keep HEAD where it is."
-msgstr ""
+msgstr "Patch-Operation abbrechen, aber HEAD an aktueller Stelle belassen"
 
 #: builtin/am.c:2290
-#, fuzzy
 msgid "show the patch being applied."
-msgstr "Keine Änderungen -- Patches bereits angewendet."
+msgstr "den Patch, der gerade angewendet wird, anzeigen"
 
 #: builtin/am.c:2294
 msgid "lie about committer date"
 msgstr "Autor-Datum als Commit-Datum verwenden"
 
 #: builtin/am.c:2296
@@ -5750,15 +5737,14 @@ msgstr "Konnte Ausgabe nicht umleiten."
 
 #: builtin/archive.c:37
 msgid "git archive: Remote with no URL"
 msgstr "git archive: Externes Archiv ohne URL"
 
 #: builtin/archive.c:58
-#, fuzzy
 msgid "git archive: expected ACK/NAK, got a flush packet"
-msgstr "git archive: habe ACK/NAK erwartet, aber EOF bekommen"
+msgstr "git archive: ACK/NAK erwartet, Flush-Paket bekommen"
 
 #: builtin/archive.c:61
 #, c-format
 msgid "git archive: NACK %s"
 msgstr "git archive: NACK %s"
 
@@ -7434,17 +7420,14 @@ msgstr ""
 msgid "--shallow-exclude is ignored in local clones; use file:// instead."
 msgstr ""
 "--shallow-exclude wird in lokalen Klonen ignoriert; benutzen Sie stattdessen "
 "file://"
 
 #: builtin/clone.c:1099
-#, fuzzy
 msgid "--filter is ignored in local clones; use file:// instead."
-msgstr ""
-"Die Option --depth wird in lokalen Klonen ignoriert; benutzen Sie "
-"stattdessen file://"
+msgstr "--filter wird in lokalen Klonen ignoriert; benutzen Sie stattdessen file://"
 
 #: builtin/clone.c:1102
 msgid "source repository is shallow, ignoring --local"
 msgstr ""
 "Quelle ist ein Repository mit unvollständiger Historie (shallow),\n"
 "ignoriere --local"
@@ -7769,15 +7752,14 @@ msgstr ""
 
 #: builtin/commit.c:1112
 msgid "Only one of -c/-C/-F/--fixup can be used."
 msgstr "Es kann nur eine Option von -c/-C/-F/--fixup verwendet werden."
 
 #: builtin/commit.c:1114
-#, fuzzy
 msgid "Option -m cannot be combined with -c/-C/-F."
-msgstr "Die Option -m kann nicht mit -c/-C/-F/--fixup kombiniert werden."
+msgstr "Die Option -m kann nicht mit -c/-C/-F kombiniert werden."
 
 #: builtin/commit.c:1122
 msgid "--reset-author can be used only with -C, -c or --amend."
 msgstr ""
 "Die Option --reset--author kann nur mit -C, -c oder --amend verwendet werden."
 
@@ -7813,13 +7795,13 @@ msgstr "Branchinformationen anzeigen"
 #: builtin/commit.c:1282
 msgid "show stash information"
 msgstr "Stashinformationen anzeigen"
 
 #: builtin/commit.c:1284 builtin/commit.c:1447
 msgid "compute full ahead/behind values"
-msgstr ""
+msgstr "voraus/hinterher-Werte berechnen"
 
 #: builtin/commit.c:1286
 msgid "version"
 msgstr "Version"
 
 #: builtin/commit.c:1286 builtin/commit.c:1449 builtin/push.c:542
@@ -8656,13 +8638,13 @@ msgid "prune remote-tracking branches no longer on remote"
 msgstr ""
 "Remote-Tracking-Branches entfernen, die sich nicht mehr im Remote-Repository "
 "befinden"
 
 #: builtin/fetch.c:141
 msgid "prune local tags no longer on remote and clobber changed tags"
-msgstr ""
+msgstr "lokale Tags entfernen, die sich nicht mehr im Remote-Repository befinden, und geänderte Tags aktualisieren"
 
 #: builtin/fetch.c:142 builtin/fetch.c:165 builtin/pull.c:126
 msgid "on-demand"
 msgstr "bei-Bedarf"
 
 #: builtin/fetch.c:143
@@ -8848,12 +8830,14 @@ msgid "Could not fetch %s"
 msgstr "Konnte nicht von %s anfordern"
 
 #: builtin/fetch.c:1325 builtin/fetch.c:1498
 msgid ""
 "--filter can only be used with the remote configured in core.partialClone"
 msgstr ""
+"--filter kann nur mit den Remote-Repositories verwendet werden,\n"
+"die in core.partialClone konfiguriert sind."
 
 #: builtin/fetch.c:1350
 msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
 msgstr ""
@@ -9793,20 +9777,20 @@ msgstr "lokales Objekt %s ist beschädigt"
 #: builtin/index-pack.c:1397
 #, c-format
 msgid "packfile name '%s' does not end with '.pack'"
 msgstr "Name der Paketdatei '%s' endet nicht mit '.pack'"
 
 #: builtin/index-pack.c:1422
-#, fuzzy, c-format
+#, c-format
 msgid "cannot write %s file '%s'"
-msgstr "Kann Paketbeschreibungsdatei '%s' nicht schreiben"
+msgstr "Kann %s Datei '%s' nicht schreiben."
 
 #: builtin/index-pack.c:1430
-#, fuzzy, c-format
+#, c-format
 msgid "cannot close written %s file '%s'"
-msgstr "Kann eben erstellte Paketbeschreibungsdatei '%s' nicht schließen"
+msgstr "Kann eben geschriebene %s Datei '%s' nicht schließen."
 
 #: builtin/index-pack.c:1454
 msgid "error while closing pack file"
 msgstr "Fehler beim Schließen der Paketdatei"
 
 #: builtin/index-pack.c:1468
@@ -11884,13 +11868,13 @@ msgstr "Bitmap-Index zusammen mit Pack-Index schreiben"
 #: builtin/pack-objects.c:3036
 msgid "handling for missing objects"
 msgstr "Behandlung für fehlende Objekte"
 
 #: builtin/pack-objects.c:3039
 msgid "do not pack objects in promisor packfiles"
-msgstr ""
+msgstr "keine Objekte aus Packdateien von partiell geklonten Remote-Repositories packen"
 
 #: builtin/pack-objects.c:3178
 msgid "Counting objects"
 msgstr "Zähle Objekte"
 
 #: builtin/pack-refs.c:6
@@ -11924,13 +11908,13 @@ msgstr "gelöschte Objekte melden"
 #: builtin/prune.c:110
 msgid "expire objects older than <time>"
 msgstr "Objekte älter als <Zeit> verfallen lassen"
 
 #: builtin/prune.c:112
 msgid "limit traversal to objects outside promisor packfiles"
-msgstr ""
+msgstr "Traversierung auf Objekte außerhalb von Packdateien aus partiell geklonten Remote-Repositories einschränken"
 
 #: builtin/prune.c:126
 msgid "cannot prune in a precious-objects repo"
 msgstr "kann \"prune\" in precious-objects Repository nicht ausführen"
 
 #: builtin/pull.c:54 builtin/pull.c:56
@@ -13464,16 +13448,14 @@ msgstr "Konnte Index-Datei nicht zu Commit '%s' setzen."
 
 #: builtin/reset.c:390
 msgid "Could not write new index file."
 msgstr "Konnte neue Index-Datei nicht schreiben."
 
 #: builtin/rev-list.c:397
-#, fuzzy
 msgid "cannot combine --exclude-promisor-objects and --missing"
-msgstr ""
-"--use-bitmap-index kann nicht mit dem Filtern von Objekten kombiniert werden."
+msgstr "--exclude-promisor-objects und --missing können nicht kombiniert werden."
 
 #: builtin/rev-list.c:455
 msgid "object filtering requires --objects"
 msgstr "Das Filtern von Objekten erfordert --objects."
 
 #: builtin/rev-list.c:458
@@ -13955,13 +13937,13 @@ msgstr "Referenz nicht gefunden: %s"
 #, c-format
 msgid "Expecting a full ref name, got %s"
 msgstr "Vollständiger Referenzname erwartet, %s erhalten"
 
 #: builtin/submodule--helper.c:59
 msgid "submodule--helper print-default-remote takes no arguments"
-msgstr ""
+msgstr "'submodule--helper print-default-remote' erwartet keine Argumente."
 
 #: builtin/submodule--helper.c:96
 #, c-format
 msgid "cannot strip one component off url '%s'"
 msgstr "Kann eine Komponente von URL '%s' nicht extrahieren"
 
@@ -14055,108 +14037,94 @@ msgstr "git submodule status [--quiet] [--cached] [--recursive] [<Pfad>...]"
 
 #: builtin/submodule--helper.c:742
 msgid "git submodule--helper name <path>"
 msgstr "git submodule--helper name <Pfad>"
 
 #: builtin/submodule--helper.c:806
-#, fuzzy, c-format
+#, c-format
 msgid "Synchronizing submodule url for '%s'\n"
-msgstr "Synchronisiere Submodul-URL für '$displaypath'"
+msgstr "Synchronisiere Submodul-URL für '%s'\n"
 
 #: builtin/submodule--helper.c:812
-#, fuzzy, c-format
+#, c-format
 msgid "failed to register url for submodule path '%s'"
-msgstr ""
-"Fehler beim Eintragen der URL für Submodul-Pfad '%s' in die Konfiguration."
+msgstr "Fehler beim Registrieren der URL für Submodul-Pfad '%s'."
 
 #: builtin/submodule--helper.c:826
-#, fuzzy, c-format
+#, c-format
 msgid "failed to get the default remote for submodule '%s'"
-msgstr ""
-"Fehler bei Änderung des Aktualisierungsmodus für Submodul-Pfad '%s' in der\n"
-"Konfiguration."
+msgstr "Fehler beim Lesen des Standard-Remote-Repositories für Submodul '%s'."
 
 #: builtin/submodule--helper.c:837
-#, fuzzy, c-format
+#, c-format
 msgid "failed to update remote for submodule '%s'"
-msgstr ""
-"Fehler bei Änderung des Aktualisierungsmodus für Submodul-Pfad '%s' in der\n"
-"Konfiguration."
+msgstr "Fehler beim Aktualisieren des Remote-Repositories für Submodul '%s'."
 
 #: builtin/submodule--helper.c:885
-#, fuzzy
 msgid "Suppress output of synchronizing submodule url"
-msgstr "Ausgaben bei Initialisierung eines Submoduls unterdrücken"
+msgstr "Ausgaben bei der Synchronisierung der Submodul-URLs unterdrücken"
 
 #: builtin/submodule--helper.c:887
-#, fuzzy
 msgid "Recurse into nested submodules"
 msgstr "Rekursion in verschachtelte Submodule durchführen"
 
 #: builtin/submodule--helper.c:892
-#, fuzzy
 msgid "git submodule--helper sync [--quiet] [--recursive] [<path>]"
-msgstr "git submodule status [--quiet] [--cached] [--recursive] [<Pfad>...]"
+msgstr "git submodule--helper sync [--quiet] [--recursive] [<Pfad>]"
 
 #: builtin/submodule--helper.c:946
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Submodule work tree '%s' contains a .git directory (use 'rm -rf' if you "
 "really want to remove it including all of its history)"
 msgstr ""
-"Arbeitsverzeichnis von Submodul in '$displaypath' enthält ein .git-"
-"Verzeichnis\n"
-"(benutzen Sie 'rm -rf' wenn Sie dieses wirklich mitsamt seiner Historie "
-"löschen\n"
-"möchten)"
+"Arbeitsverzeichnis von Submodul in '%s' enthält ein .git-Verzeichnis\n"
+"(benutzen Sie 'rm -rf', wenn Sie dieses wirklich mitsamt seiner Historie\n"
+"löschen möchten)"
 
 #: builtin/submodule--helper.c:958
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Submodule work tree '%s' contains local modifications; use '-f' to discard "
 "them"
 msgstr ""
-"Arbeitsverzeichnis von Submodul in '$displaypath' enthält lokale Änderungen; "
-"verwenden Sie '-f', um diese zu verwerfen"
+"Arbeitsverzeichnis von Submodul in '%s' enthält lokale Änderungen;\n"
+"verwenden Sie '-f', um diese zu verwerfen."
 
 #: builtin/submodule--helper.c:966
-#, fuzzy, c-format
+#, c-format
 msgid "Cleared directory '%s'\n"
-msgstr "Verzeichnis '$displaypath' bereinigt."
+msgstr "Verzeichnis '%s' bereinigt.\n"
 
 #: builtin/submodule--helper.c:968
-#, fuzzy, c-format
+#, c-format
 msgid "Could not remove submodule work tree '%s'\n"
-msgstr ""
-"Konnte Arbeitsverzeichnis des Submoduls in '$displaypath' nicht löschen."
+msgstr "Konnte Arbeitsverzeichnis des Submoduls in '%s' nicht löschen.\n"
 
 #: builtin/submodule--helper.c:977
-#, fuzzy, c-format
+#, c-format
 msgid "could not create empty submodule directory %s"
-msgstr ""
-"Konnte kein leeres Verzeichnis für Submodul in '$displaypath' erstellen."
+msgstr "Konnte kein leeres Verzeichnis für Submodul in '%s' erstellen."
 
 #: builtin/submodule--helper.c:993
-#, fuzzy, c-format
+#, c-format
 msgid "Submodule '%s' (%s) unregistered for path '%s'\n"
-msgstr "Submodul '%s' (%s) für Pfad '%s' in die Konfiguration eingetragen.\n"
+msgstr "Submodul '%s' (%s) für Pfad '%s' ausgetragen.\n"
 
 #: builtin/submodule--helper.c:1022
 msgid "Remove submodule working trees even if they contain local changes"
-msgstr ""
+msgstr "Arbeitsverzeichnisse von Submodulen löschen, auch wenn lokale Änderungen vorliegen"
 
 #: builtin/submodule--helper.c:1023
-#, fuzzy
 msgid "Unregister all submodules"
-msgstr "Rekursion in Submodule durchführen"
+msgstr "alle Submodule austragen"
 
 #: builtin/submodule--helper.c:1028
-#, fuzzy
 msgid ""
 "git submodule deinit [--quiet] [-f | --force] [--all | [--] [<path>...]]"
-msgstr "git submodule status [--quiet] [--cached] [--recursive] [<Pfad>...]"
+msgstr "git submodule deinit [--quiet] [-f | --force] [--all | [--] [<Pfad>...]]"
 
 #: builtin/submodule--helper.c:1042
 msgid "Use '--all' if you really want to deinitialize all submodules"
 msgstr ""
 "Verwenden Sie '--all', wenn Sie wirklich alle Submodule deinitialisieren\n"
 "möchten."
@@ -14453,15 +14421,14 @@ msgstr "annotiertes Tag, benötigt eine Beschreibung"
 
 #: builtin/tag.c:392
 msgid "tag message"
 msgstr "Tag-Beschreibung"
 
 #: builtin/tag.c:394
-#, fuzzy
 msgid "force edit of tag message"
-msgstr "Bearbeitung des Commits erzwingen"
+msgstr "Bearbeitung der Tag-Beschreibung erzwingen"
 
 #: builtin/tag.c:395
 msgid "annotated and GPG-signed tag"
 msgstr "annotiertes und GPG-signiertes Tag"
 
 #: builtin/tag.c:399
@@ -14900,37 +14867,34 @@ msgstr "git verify-tag [-v | --verbose] [--format=<Format>] <Tag>..."
 
 #: builtin/verify-tag.c:37
 msgid "print tag contents"
 msgstr "Tag-Inhalte ausgeben"
 
 #: builtin/worktree.c:17
-#, fuzzy
 msgid "git worktree add [<options>] <path> [<commit-ish>]"
-msgstr "git worktree add [<Optionen>] <Pfad> [<Branch>]"
+msgstr "git worktree add [<Optionen>] <Pfad> [<Commit-Angabe>]"
 
 #: builtin/worktree.c:18
 msgid "git worktree list [<options>]"
 msgstr "git worktree list [<Optionen>]"
 
 #: builtin/worktree.c:19
 msgid "git worktree lock [<options>] <path>"
 msgstr "git worktree lock [<Optionen>] <Pfad>"
 
 #: builtin/worktree.c:20
-#, fuzzy
 msgid "git worktree move <worktree> <new-path>"
-msgstr "git worktree lock [<Optionen>] <Pfad>"
+msgstr "git worktree move <Arbeitsverzeichnis> <neuer-Pfad>"
 
 #: builtin/worktree.c:21
 msgid "git worktree prune [<options>]"
 msgstr "git worktree prune [<Optionen>]"
 
 #: builtin/worktree.c:22
-#, fuzzy
 msgid "git worktree remove [<options>] <worktree>"
-msgstr "git worktree lock [<Optionen>] <Pfad>"
+msgstr "git worktree remove [<Optionen>] <Arbeitsverzeichnis>"
 
 #: builtin/worktree.c:23
 msgid "git worktree unlock <path>"
 msgstr "git worktree unlock <Pfad>"
 
 #: builtin/worktree.c:60
@@ -15060,87 +15024,86 @@ msgstr "'%s' ist bereits gesperrt"
 msgid "'%s' is not locked"
 msgstr "'%s' ist nicht gesperrt"
 
 #: builtin/worktree.c:645
 msgid "working trees containing submodules cannot be moved or removed"
 msgstr ""
+"Arbeitsverzeichnisse, die Submodule enthalten, können nicht verschoben oder\n"
+"entfernt werden."
 
 #: builtin/worktree.c:672 builtin/worktree.c:811
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is a main working tree"
-msgstr "'%s' ist kein Arbeitsverzeichnis"
+msgstr "'%s' ist ein Hauptarbeitsverzeichnis"
 
 #: builtin/worktree.c:677
-#, fuzzy, c-format
+#, c-format
 msgid "could not figure out destination name from '%s'"
-msgstr "Konnte Git-Verzeichnis nicht von '%s' nach '%s' migrieren."
+msgstr "Konnte Zielname aus '%s' nicht bestimmen."
 
 #: builtin/worktree.c:683
-#, fuzzy, c-format
+#, c-format
 msgid "target '%s' already exists"
-msgstr "Tag '%s' existiert bereits"
+msgstr "Ziel '%s' existiert bereits."
 
 #: builtin/worktree.c:690
-#, fuzzy, c-format
+#, c-format
 msgid "cannot move a locked working tree, lock reason: %s"
-msgstr "Kann Änderungen im Arbeitsverzeichnis nicht löschen"
+msgstr "Kann gesperrtes Arbeitsverzeichnis nicht verschieben, Sperrgrund: %s"
 
 #: builtin/worktree.c:692
-#, fuzzy
 msgid "cannot move a locked working tree"
-msgstr "Kann Zustand des Arbeitsverzeichnisses nicht aufzeichnen"
+msgstr "Kann gesperrtes Arbeitsverzeichnisses nicht verschieben."
 
 #: builtin/worktree.c:695
 #, c-format
 msgid "validation failed, cannot move working tree: %s"
-msgstr ""
+msgstr "Validierung fehlgeschlagen, kann Arbeitszeichnis nicht verschieben: %s"
 
 #: builtin/worktree.c:700
-#, fuzzy, c-format
+#, c-format
 msgid "failed to move '%s' to '%s'"
-msgstr "Fehler beim Öffnen von '%s': %s"
+msgstr "Fehler beim Verschieben von '%s' nach '%s'"
 
 #: builtin/worktree.c:748
-#, fuzzy, c-format
+#, c-format
 msgid "failed to run 'git status' on '%s'"
-msgstr "Fehler beim Schreiben nach '%s'"
+msgstr "Fehler beim Ausführen von 'git status' auf '%s'"
 
 #: builtin/worktree.c:752
 #, c-format
 msgid "'%s' is dirty, use --force to delete it"
-msgstr ""
+msgstr "'%s' ist verändert, benutzen Sie --force zum Löschen"
 
 #: builtin/worktree.c:757
-#, fuzzy, c-format
+#, c-format
 msgid "failed to run 'git status' on '%s', code %d"
-msgstr "Konnte 'git status' in Submodul '%s' nicht ausführen."
+msgstr "Fehler beim Ausführen von 'git status' auf '%s'. Code: %d"
 
 #: builtin/worktree.c:768 builtin/worktree.c:782
-#, fuzzy, c-format
+#, c-format
 msgid "failed to delete '%s'"
-msgstr "Fehler beim Ausführen von '%s'"
+msgstr "Fehler beim Löschen von '%s'"
 
 #: builtin/worktree.c:794
-#, fuzzy
 msgid "force removing even if the worktree is dirty"
-msgstr "Verschieben/Umbenennen erzwingen, auch wenn das Ziel existiert"
+msgstr "Löschen erzwingen, auch wenn das Arbeitsverzeichnis geändert wurde"
 
 #: builtin/worktree.c:815
-#, fuzzy, c-format
+#, c-format
 msgid "cannot remove a locked working tree, lock reason: %s"
-msgstr "Kann Änderungen im Arbeitsverzeichnis nicht löschen"
+msgstr "Kann gesperrtes Arbeitsverzeichnis nicht löschen, Sperrgrund: %s"
 
 #: builtin/worktree.c:817
-#, fuzzy
 msgid "cannot remove a locked working tree"
-msgstr "Kann Zustand des Arbeitsverzeichnisses nicht aufzeichnen"
+msgstr "Kann gesperrtes Arbeitsverzeichnis nicht löschen."
 
 #: builtin/worktree.c:820
 #, c-format
 msgid "validation failed, cannot remove working tree: %s"
-msgstr ""
+msgstr "Validierung fehlgeschlagen, kann Arbeitsverzeichnis nicht löschen: %s"
 
 #: builtin/write-tree.c:14
 msgid "git write-tree [--missing-ok] [--prefix=<prefix>/]"
 msgstr "git write-tree [--missing-ok] [--prefix=<Präfix>/]"
 
 #: builtin/write-tree.c:27
@@ -15202,12 +15165,17 @@ msgid ""
 "git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
 "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 "           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
 "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
 "           <command> [<args>]"
 msgstr ""
+"git [--version] [--help] [-C <Pfad>] [-c <Name>=<Wert>]\n"
+"           [--exec-path[=<Pfad>]] [--html-path] [--man-path] [--info-path]\n"
+"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
+"           [--git-dir=<Pfad>] [--work-tree=<Pfad>] [--namespace=<Name>]\n"
+"           <Befehl> [<Argumente>]"
 
 #: git.c:15
 msgid ""
 "'git help -a' and 'git help -g' list available subcommands and some\n"
 "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 "to read about a specific subcommand or concept."
@@ -15217,53 +15185,53 @@ msgstr ""
 "oder 'git help <Konzept>', um mehr über einen spezifischen Befehl oder\n"
 "Konzept zu erfahren."
 
 #: git.c:95
 #, c-format
 msgid "no directory given for --git-dir\n"
-msgstr ""
+msgstr "Kein Verzeichnis für --git-dir angegeben.\n"
 
 #: git.c:109
 #, c-format
 msgid "no namespace given for --namespace\n"
-msgstr ""
+msgstr "Kein Namespace für --namespace angegeben.\n"
 
 #: git.c:123
 #, c-format
 msgid "no directory given for --work-tree\n"
-msgstr ""
+msgstr "Kein Verzeichnis für --work-tree angegeben.\n"
 
 #: git.c:137
-#, fuzzy, c-format
+#, c-format
 msgid "no prefix given for --super-prefix\n"
-msgstr "%s unterstützt kein --super-prefix"
+msgstr "Kein Präfix für --super-prefix angegeben.\n"
 
 #: git.c:159
 #, c-format
 msgid "-c expects a configuration string\n"
-msgstr ""
+msgstr "-c erwartet einen Konfigurationsstring.\n"
 
 #: git.c:197
 #, c-format
 msgid "no directory given for -C\n"
-msgstr ""
+msgstr "Kein Verzeichnis für -C angegeben.\n"
 
 #: git.c:212
-#, fuzzy, c-format
+#, c-format
 msgid "unknown option: %s\n"
-msgstr "unbekannte Option: %s"
+msgstr "Unbekannte Option: %s\n"
 
 #: git.c:687
 #, c-format
 msgid "expansion of alias '%s' failed; '%s' is not a git command\n"
-msgstr ""
+msgstr "Erweiterung von Alias '%s' fehlgeschlagen; '%s' ist kein Git-Befehl.\n"
 
 #: git.c:699
-#, fuzzy, c-format
+#, c-format
 msgid "failed to run command '%s': %s\n"
-msgstr "Fehler beim Öffnen von '%s': %s"
+msgstr "Fehler beim Ausführen von Befehl '%s': %s\n"
 
 #: http.c:342
 #, c-format
 msgid "negative value for http.postbuffer; defaulting to %d"
 msgstr "negativer Wert für http.postbuffer; benutze Standardwert %d"
 
@@ -15958,13 +15926,13 @@ msgstr ""
 "Der Stash-Eintrag wird für den Fall behalten, dass Sie diesen nochmal "
 "benötigen."
 
 #: git-stash.sh:656
 #, sh-format
 msgid "Dropped ${REV} ($s)"
-msgstr "Gelöscht ${REV} ($s)"
+msgstr "${REV} ($s) gelöscht"
 
 #: git-stash.sh:657
 #, sh-format
 msgid "${REV}: Could not drop stash entry"
 msgstr "${REV}: Konnte \"stash\"-Eintrag nicht löschen"
 
@@ -16948,126 +16916,119 @@ msgstr "Keine Änderungen.\n"
 
 #: git-add--interactive.perl:1331
 msgid "Patch update"
 msgstr "Patch Aktualisierung"
 
 #: git-add--interactive.perl:1383
-#, fuzzy, perl-format
+#, perl-format
 msgid "Stage mode change [y,n,q,a,d%s,?]? "
-msgstr "Modusänderung der Staging-Area hinzufügen [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung der Staging-Area hinzufügen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1384
-#, fuzzy, perl-format
+#, perl-format
 msgid "Stage deletion [y,n,q,a,d%s,?]? "
-msgstr "Löschung der Staging-Area hinzufügen [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung der Staging-Area hinzufügen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1385
-#, fuzzy, perl-format
+#, perl-format
 msgid "Stage this hunk [y,n,q,a,d%s,?]? "
-msgstr "Diesen Patch-Block der Staging-Area hinzufügen [y,n,q,a,d,/%s,?]? "
+msgstr "Diesen Patch-Block der Staging-Area hinzufügen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1388
-#, fuzzy, perl-format
+#, perl-format
 msgid "Stash mode change [y,n,q,a,d%s,?]? "
-msgstr "Modusänderung stashen [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung stashen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1389
-#, fuzzy, perl-format
+#, perl-format
 msgid "Stash deletion [y,n,q,a,d%s,?]? "
-msgstr "Löschung stashen [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung stashen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1390
-#, fuzzy, perl-format
+#, perl-format
 msgid "Stash this hunk [y,n,q,a,d%s,?]? "
-msgstr "Diesen Patch-Block stashen [y,n,q,a,d,/%s,?]? "
+msgstr "Diesen Patch-Block stashen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1393
-#, fuzzy, perl-format
+#, perl-format
 msgid "Unstage mode change [y,n,q,a,d%s,?]? "
-msgstr "Modusänderung aus der Staging-Area entfernen [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung aus der Staging-Area entfernen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1394
-#, fuzzy, perl-format
+#, perl-format
 msgid "Unstage deletion [y,n,q,a,d%s,?]? "
-msgstr "Löschung aus der Staging-Area entfernen [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung aus der Staging-Area entfernen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1395
-#, fuzzy, perl-format
+#, perl-format
 msgid "Unstage this hunk [y,n,q,a,d%s,?]? "
-msgstr "Diesen Patch-Block aus der Staging-Area entfernen [y,n,q,a,d,/%s,?]? "
+msgstr "Diesen Patch-Block aus der Staging-Area entfernen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1398
-#, fuzzy, perl-format
+#, perl-format
 msgid "Apply mode change to index [y,n,q,a,d%s,?]? "
-msgstr "Modusänderung auf Index anwenden [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung auf Index anwenden [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1399
-#, fuzzy, perl-format
+#, perl-format
 msgid "Apply deletion to index [y,n,q,a,d%s,?]? "
-msgstr "Löschung auf Index anwenden [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung auf Index anwenden [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1400
-#, fuzzy, perl-format
+#, perl-format
 msgid "Apply this hunk to index [y,n,q,a,d%s,?]? "
-msgstr "Diesen Patch-Block auf Index anwenden [y,n,q,a,d,/%s,?]? "
+msgstr "Diesen Patch-Block auf Index anwenden [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1403
-#, fuzzy, perl-format
+#, perl-format
 msgid "Discard mode change from worktree [y,n,q,a,d%s,?]? "
-msgstr "Modusänderung im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1404
-#, fuzzy, perl-format
+#, perl-format
 msgid "Discard deletion from worktree [y,n,q,a,d%s,?]? "
-msgstr "Löschung im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1405
-#, fuzzy, perl-format
+#, perl-format
 msgid "Discard this hunk from worktree [y,n,q,a,d%s,?]? "
-msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
+msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1408
-#, fuzzy, perl-format
+#, perl-format
 msgid "Discard mode change from index and worktree [y,n,q,a,d%s,?]? "
-msgstr ""
-"Modusänderung vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1409
-#, fuzzy, perl-format
+#, perl-format
 msgid "Discard deletion from index and worktree [y,n,q,a,d%s,?]? "
-msgstr ""
-"Löschung vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1410
-#, fuzzy, perl-format
+#, perl-format
 msgid "Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "
-msgstr ""
-"Diesen Patch-Block vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d,/"
-"%s,?]? "
+msgstr "Diesen Patch-Block vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1413
-#, fuzzy, perl-format
+#, perl-format
 msgid "Apply mode change to index and worktree [y,n,q,a,d%s,?]? "
-msgstr ""
-"Modusänderung auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d,/%s,?]? "
+msgstr "Modusänderung auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1414
-#, fuzzy, perl-format
+#, perl-format
 msgid "Apply deletion to index and worktree [y,n,q,a,d%s,?]? "
-msgstr "Löschung auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d,/%s,?]? "
+msgstr "Löschung auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1415
-#, fuzzy, perl-format
+#, perl-format
 msgid "Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "
-msgstr ""
-"Diesen Patch-Block auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d,/"
-"%s,?]? "
+msgstr "Diesen Patch-Block auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d%s,?]? "
 
 #: git-add--interactive.perl:1515
 msgid "No other hunks to goto\n"
-msgstr ""
+msgstr "Keine anderen Patch-Blöcke verbleibend\n"
 
 #: git-add--interactive.perl:1522
 msgid "go to which hunk (<ret> to see more)? "
 msgstr "zu welchem Patch-Block springen (<Enter> für mehr Informationen)? "
 
 #: git-add--interactive.perl:1524
@@ -17085,13 +17046,13 @@ msgid "Sorry, only %d hunk available.\n"
 msgid_plural "Sorry, only %d hunks available.\n"
 msgstr[0] "Entschuldigung, nur %d Patch-Block verfügbar.\n"
 msgstr[1] "Entschuldigung, nur %d Patch-Blöcke verfügbar.\n"
 
 #: git-add--interactive.perl:1564
 msgid "No other hunks to search\n"
-msgstr ""
+msgstr "Keine anderen Patch-Blöcke zum Durchsuchen\n"
 
 #: git-add--interactive.perl:1568
 msgid "search for regex? "
 msgstr "Suche nach regulärem Ausdruck? "
 
 #: git-add--interactive.perl:1581
@@ -17110,24 +17071,24 @@ msgstr "Kein vorheriger Patch-Block\n"
 #: git-add--interactive.perl:1612 git-add--interactive.perl:1631
 msgid "No next hunk\n"
 msgstr "Kein folgender Patch-Block\n"
 
 #: git-add--interactive.perl:1637
 msgid "Sorry, cannot split this hunk\n"
-msgstr ""
+msgstr "Entschuldigung, kann diesen Patch-Block nicht aufteilen.\n"
 
 #: git-add--interactive.perl:1643
 #, perl-format
 msgid "Split into %d hunk.\n"
 msgid_plural "Split into %d hunks.\n"
 msgstr[0] "In %d Patch-Block aufgeteilt.\n"
 msgstr[1] "In %d Patch-Blöcke aufgeteilt.\n"
 
 #: git-add--interactive.perl:1653
 msgid "Sorry, cannot edit this hunk\n"
-msgstr ""
+msgstr "Entschuldigung, kann diesen Patch-Block nicht bearbeiten.\n"
 
 #: git-add--interactive.perl:1699
 msgid "Review diff"
 msgstr "Diff überprüfen"
 
 #. TRANSLATORS: please do not translate the command names
@@ -17203,12 +17164,14 @@ msgstr ""
 
 #: git-send-email.perl:386
 msgid ""
 "`batch-size` and `relogin` must be specified together (via command-line or "
 "configuration option)\n"
 msgstr ""
+"'batch-size' und 'relogin' müssen gemeinsam angegeben werden (über Kommandozeile\n"
+"oder Konfigurationsoption)\n"
 
 #: git-send-email.perl:456
 #, perl-format
 msgid "Unknown --suppress-cc field: '%s'\n"
 msgstr "Unbekanntes --suppress-cc Feld: '%s'\n"
 
-- 
2.16.2.395.g2e18187df

