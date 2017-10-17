Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EEB1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 16:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbdJQQ0b (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 12:26:31 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:48012 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932914AbdJQQ01 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 12:26:27 -0400
Received: by mail-wm0-f52.google.com with SMTP id t69so5023061wmt.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsCUcRZVG1+Hz7H6xZc52B0ejyroujLYkzM91BYsRBk=;
        b=OhapSEG33FzOMfJAeMGY1ixkI4RW3jVhvDeA/sjQq6llUPEwJ4XC2r/Gq5qzNHjpi5
         hjJa27i6j7nMyBp1b3oMMENraC+PCnggUcSPoeh7DDIQGxk3jnQR59qI8ki3BELMdCF8
         rqIUtRWewRHvFmQH6IjLfnx61qAnuB3Lz1eMWsynHObMrac0pFmujAGvuVzMwEyrxpL3
         AmySKvet2kd+64zsn9o2dkTFUY94HoDmvbqwjhsMzMRTqki65YKD1lRuCp3cVzDCxQvm
         ObwuaYyL5dQJhu5B18aRtB1Cdn+AIsqitGHcWERd4v5tF/DSzML0t5znUzqxsTAHS6fd
         ou5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FsCUcRZVG1+Hz7H6xZc52B0ejyroujLYkzM91BYsRBk=;
        b=XpV0X+N7FzYvD2ZqtvLbHRU3u3CfwoOoXFLc3IBlXdTAL0tTFIxMwdzrk1TGvolYm7
         vtAhfPDx9wDL8FtoiuowEwThfLbMnQRVriAwrloJ1ahayyFSNfoaglbDAepAB2UxyN14
         Mnqht0RJj6ucrTh1DgxqucZXDWyv4DUiOSxkOsrfYQ3G5WS7XyoQLdKj3WLIM//fTJ/p
         cXIEAH0NTh74Z7m2dVh8sDIImOjCQTYVA4uxrTBsuUFjmvway6zd6sfP8M1gU3ecHiYR
         +B3cdaBviiHJ4kdP/kX7NHdQ8KV1UJhV+sXLcvWwWBG1WyrjTsHZF3rjHNKkZox2NDXc
         9itQ==
X-Gm-Message-State: AMCzsaUT25i8YRXgJEXWIRfbhuJ32ZWi+lhbJk7zIPrbD38zrs594JGD
        XOLuU82yfgCqmPgNb0JySYmiENjo
X-Google-Smtp-Source: AOwi7QB/MR79RneQ3lqoPxHMOQ1QO1X8pupJtK98na7Zn5KZVZ/1Z/w6tzT//+L9fP6Dgx+rn+58Gg==
X-Received: by 10.80.165.151 with SMTP id a23mr17766670edc.200.1508257585095;
        Tue, 17 Oct 2017 09:26:25 -0700 (PDT)
Received: from localhost (cable-94-139-29-181.cust.telecolumbus.net. [94.139.29.181])
        by smtp.gmail.com with ESMTPSA id m8sm7041055edl.74.2017.10.17.09.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 09:26:24 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 70 new messages
Date:   Tue, 17 Oct 2017 18:26:22 +0200
Message-Id: <20171017162622.28764-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 70 new messages came from git.pot update in 25eab542b
(l10n: git.pot: v2.15.0 round 1 (68 new, 36 removed)) and 9c07fab78
(l10n: git.pot: v2.15.0 round 2 (2 new, 2 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 253 ++++++++++++++++++++++++++-------------------------------------
 1 file changed, 106 insertions(+), 147 deletions(-)

diff --git a/po/de.po b/po/de.po
index c76fe575c..0619c4988 100644
--- a/po/de.po
+++ b/po/de.po
@@ -92,21 +92,20 @@ msgid ""
 "\n"
 "  git checkout -b <new-branch-name>\n"
 "\n"
 msgstr ""
 "Hinweis: Checke '%s' aus.\n"
 "\n"
-"Sie befinden sich im Zustand eines 'lösgelösten HEAD'. Sie können sich\n"
+"Sie befinden sich im Zustand eines 'losgelösten HEAD'. Sie können sich\n"
 "umschauen, experimentelle Änderungen vornehmen und diese committen, und\n"
 "Sie können alle möglichen Commits, die Sie in diesem Zustand machen,\n"
 "ohne Auswirkungen auf irgendeinen Branch verwerfen, indem Sie einen\n"
 "weiteren Checkout durchführen.\n"
 "\n"
 "Wenn Sie einen neuen Branch erstellen möchten, um Ihre erstellten Commits\n"
-"zu behalten, können Sie das (jetzt oder später) durch einen weiteren "
-"Checkout\n"
+"zu behalten, können Sie das (jetzt oder später) durch einen weiteren Checkout\n"
 "mit der Option -b tun. Beispiel:\n"
 "\n"
 "  git checkout -b <neuer-Branchname>\n"
 "\n"
 
 #: apply.c:58
@@ -1066,52 +1065,50 @@ msgstr ""
 #: branch.c:67
 #, c-format
 msgid "Not setting branch %s as its own upstream."
 msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
 
 #: branch.c:93
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track remote branch '%s' from '%s' by rebasing."
-msgstr ""
-"Branch %s konfiguriert zum Folgen von Remote-Branch %s von %s durch Rebase."
+msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Branch '%s' von '%s' durch Rebase."
 
 #: branch.c:94
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track remote branch '%s' from '%s'."
-msgstr "Branch %s konfiguriert zum Folgen von Remote-Branch %s von %s."
+msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Branch '%s' von '%s'."
 
 #: branch.c:98
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track local branch '%s' by rebasing."
-msgstr "Branch %s konfiguriert zum Folgen von lokalem Branch %s durch Rebase."
+msgstr "Branch '%s' konfiguriert zum Folgen von lokalem Branch '%s' durch Rebase."
 
 #: branch.c:99
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track local branch '%s'."
-msgstr "Branch %s konfiguriert zum Folgen von lokalem Branch %s."
+msgstr "Branch '%s' konfiguriert zum Folgen von lokalem Branch '%s'."
 
 #: branch.c:104
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track remote ref '%s' by rebasing."
-msgstr "Branch %s konfiguriert zum Folgen von Remote-Referenz %s durch Rebase."
+msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Referenz '%s' durch Rebase."
 
 #: branch.c:105
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track remote ref '%s'."
-msgstr "Branch %s konfiguriert zum Folgen von Remote-Referenz %s."
+msgstr "Branch '%s' konfiguriert zum Folgen von Remote-Referenz '%s'."
 
 #: branch.c:109
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track local ref '%s' by rebasing."
-msgstr ""
-"Branch %s konfiguriert zum Folgen von lokaler Referenz %s durch Rebase."
+msgstr "Branch '%s' konfiguriert zum Folgen von lokaler Referenz '%s' durch Rebase."
 
 #: branch.c:110
-#, fuzzy, c-format
+#, c-format
 msgid "Branch '%s' set up to track local ref '%s'."
-msgstr "Branch %s konfiguriert zum Folgen von lokaler Referenz %s."
+msgstr "Branch '%s' konfiguriert zum Folgen von lokaler Referenz '%s'."
 
 #: branch.c:119
 msgid "Unable to write upstream branch configuration"
 msgstr "Konnte Konfiguration zu Upstream-Branch nicht schreiben."
 
 #: branch.c:156
@@ -1623,13 +1620,13 @@ msgid "  Unknown dirstat parameter '%s'\n"
 msgstr "  Unbekannter \"dirstat\" Parameter '%s'\n"
 
 #: diff.c:281
 msgid ""
 "color moved setting must be one of 'no', 'default', 'zebra', 'dimmed_zebra', "
 "'plain'"
-msgstr ""
+msgstr "\"color moved\"-Einstellung muss eines von diesen sein: 'no', 'default', 'zebra', 'dimmed_zebra', 'plain'"
 
 #: diff.c:341
 #, c-format
 msgid "Unknown value for 'diff.submodule' config variable: '%s'"
 msgstr "Unbekannter Wert in Konfigurationsvariable 'diff.dirstat': '%s'"
 
@@ -1706,15 +1703,14 @@ msgstr "Konnte Verzeichnisse für '%s' nicht erstellen."
 #: dir.c:2915
 #, c-format
 msgid "could not migrate git directory from '%s' to '%s'"
 msgstr "Konnte Git-Verzeichnis nicht von '%s' nach '%s' migrieren."
 
 #: entry.c:176
-#, fuzzy
 msgid "Filtering content"
-msgstr "Tag-Inhalte ausgeben"
+msgstr "Filtere Inhalt"
 
 #: entry.c:433
 #, c-format
 msgid "could not stat file '%s'"
 msgstr "konnte Datei '%s' nicht lesen"
 
@@ -2335,13 +2331,12 @@ msgstr ""
 #: merge-recursive.c:1917
 #, c-format
 msgid "Adding %s"
 msgstr "Füge %s hinzu"
 
 #: merge-recursive.c:1954
-#, fuzzy
 msgid "Already up to date!"
 msgstr "Bereits aktuell!"
 
 #: merge-recursive.c:1963
 #, c-format
 msgid "merging of trees %s and %s failed"
@@ -2677,15 +2672,15 @@ msgstr "%%(body) akzeptiert keine Argumente"
 #: ref-filter.c:180
 #, c-format
 msgid "%%(subject) does not take arguments"
 msgstr "%%(subject) akzeptiert keine Argumente"
 
 #: ref-filter.c:198
-#, fuzzy, c-format
+#, c-format
 msgid "unknown %%(trailers) argument: %s"
-msgstr "unbekanntes Argument für Option --mirror: %s"
+msgstr "unbekanntes %%(trailers) Argument: %s"
 
 #: ref-filter.c:221
 #, c-format
 msgid "positive value expected contents:lines=%s"
 msgstr "Positiver Wert erwartet contents:lines=%s"
 
@@ -2925,13 +2920,13 @@ msgstr ""
 
 #: remote.c:2080
 msgid "  (use \"git branch --unset-upstream\" to fixup)\n"
 msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n"
 
 #: remote.c:2083
-#, fuzzy, c-format
+#, c-format
 msgid "Your branch is up to date with '%s'.\n"
 msgstr "Ihr Branch ist auf dem selben Stand wie '%s'.\n"
 
 #: remote.c:2087
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
@@ -3551,98 +3546,95 @@ msgstr "%s: ungültiger Commit"
 #: sequencer.c:2368
 msgid "can't revert as initial commit"
 msgstr "Kann nicht als allerersten Commit einen Revert ausführen."
 
 #: sequencer.c:2471
 msgid "make_script: unhandled options"
-msgstr ""
+msgstr "make_script: unbehandelte Optionen"
 
 #: sequencer.c:2474
 msgid "make_script: error preparing revisions"
-msgstr ""
+msgstr "make_script: Fehler beim Vorbereiten der Commits"
 
 #: sequencer.c:2510
-#, fuzzy, c-format
+#, c-format
 msgid "unusable todo list: '%s'"
-msgstr "Konnte '%s' nicht entfernen."
+msgstr "Unbenutzbare TODO-Liste: '%s'"
 
 #: sequencer.c:2516
-#, fuzzy, c-format
+#, c-format
 msgid "unable to open '%s' for writing"
 msgstr "Konnte '%s' nicht zum Schreiben öffnen."
 
 #: sequencer.c:2561
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "unrecognized setting %s for option rebase.missingCommitsCheck. Ignoring."
-msgstr ""
-"Nicht erkannte Einstellung $check_level für Option rebase."
-"missingCommitsCheck.\n"
-"Ignoriere."
+msgstr "Nicht erkannte Einstellung %s für Option rebase.missingCommitsCheck. Ignoriere."
 
 #: sequencer.c:2641
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Warning: some commits may have been dropped accidentally.\n"
 "Dropped commits (newer to older):\n"
 msgstr ""
 "Warnung: Einige Commits könnten aus Versehen entfernt worden sein.\n"
-"Entfernte Commits (neu zu alt):"
+"Entfernte Commits (neu zu alt):\n"
 
 #: sequencer.c:2648
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "To avoid this message, use \"drop\" to explicitly remove a commit.\n"
 "\n"
 "Use 'git config rebase.missingCommitsCheck' to change the level of "
 "warnings.\n"
 "The possible behaviours are: ignore, warn, error.\n"
 "\n"
 msgstr ""
 "Um diese Meldung zu vermeiden, benutzen Sie \"drop\", um exlizit Commits zu\n"
 "entfernen.\n"
 "\n"
-"Benutzen Sie 'git config rebase.missingCommitsCheck', um die Stufe der "
-"Warnungen\n"
-"zu ändern.\n"
-"Die möglichen Verhaltensweisen sind: ignore, warn, error."
+"Benutzen Sie 'git config rebase.missingCommitsCheck', um die Stufe der\n"
+"Warnungen zu ändern.\n"
+"Die möglichen Verhaltensweisen sind: ignore, warn, error.\n"
 
 #: sequencer.c:2660
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "You can fix this with 'git rebase --edit-todo' and then run 'git rebase --"
 "continue'.\n"
 "Or you can abort the rebase with 'git rebase --abort'.\n"
 msgstr ""
 "Sie können das mit 'git rebase --edit-todo' beheben. Führen Sie danach\n"
-"'git rebase --continue' aus."
+"'git rebase --continue' aus.\n"
+"Oder Sie können den Rebase mit 'git rebase --abort' abbrechen.\n"
 
 #: sequencer.c:2708
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse commit '%s'"
-msgstr "Konnte Commit %s nicht parsen\n"
+msgstr "Konnte Commit '%s' nicht parsen."
 
 #: sequencer.c:2727 sequencer.c:2742 wrapper.c:225 wrapper.c:395
 #: builtin/am.c:775
 #, c-format
 msgid "could not open '%s' for writing"
 msgstr "Konnte '%s' nicht zum Schreiben öffnen."
 
 #: sequencer.c:2756
-#, fuzzy, c-format
+#, c-format
 msgid "could not truncate '%s'"
-msgstr "Konnte '%s' nicht lesen."
+msgstr "Konnte '%s' nicht abschneiden."
 
 #: sequencer.c:2848
 msgid "the script was already rearranged."
-msgstr ""
+msgstr "Das Script wurde bereits umgeordnet."
 
 #: sequencer.c:2953
-#, fuzzy, c-format
+#, c-format
 msgid "could not finish '%s'"
-msgstr "Konnte '%s' nicht aufheben."
+msgstr "Konnte '%s' nicht abschließen."
 
 #: setup.c:171
 #, c-format
 msgid ""
 "%s: no such path in the working tree.\n"
 "Use 'git <command> -- <path>...' to specify paths that do not exist locally."
@@ -3817,15 +3809,15 @@ msgstr "In nicht ausgechecktem Submodul '%s'."
 #: submodule.c:340
 #, c-format
 msgid "Pathspec '%s' is in submodule '%.*s'"
 msgstr "Pfadspezifikation '%s' befindet sich in Submodul '%.*s'"
 
 #: submodule.c:799
-#, fuzzy, c-format
+#, c-format
 msgid "submodule entry '%s' (%s) is a %s, not a commit"
-msgstr "%s %s ist kein Commit!"
+msgstr "Submodul-Eintrag '%s' (%s) ist ein %s, kein Commit."
 
 #: submodule.c:1021 builtin/branch.c:641 builtin/submodule--helper.c:1149
 msgid "Failed to resolve HEAD as a valid ref."
 msgstr "Konnte HEAD nicht als gültige Referenz auflösen."
 
 #: submodule.c:1304
@@ -3894,15 +3886,14 @@ msgstr "FEHLER: zurückgegebene Zeichenkette für Pfad entspricht nicht cwd?"
 #: submodule.c:1995
 #, c-format
 msgid "ls-tree returned unexpected return code %d"
 msgstr "ls-tree mit unerwartetem Rückgabewert %d beendet"
 
 #: submodule-config.c:263
-#, fuzzy
 msgid "negative values not allowed for submodule.fetchjobs"
-msgstr "Negative Werte für submodule.fetchJobs nicht erlaubt"
+msgstr "Negative Werte für submodule.fetchjobs nicht erlaubt."
 
 #: submodule-config.c:436
 #, c-format
 msgid "invalid value for %s"
 msgstr "Ungültiger Wert für %s"
 
@@ -4230,20 +4221,19 @@ msgstr ""
 #: unpack-trees.c:163
 #, c-format
 msgid "Entry '%s' overlaps with '%s'.  Cannot bind."
 msgstr "Eintrag '%s' überschneidet sich mit '%s'. Kann nicht verbinden."
 
 #: unpack-trees.c:166
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Cannot update sparse checkout: the following entries are not up to date:\n"
 "%s"
 msgstr ""
-"Kann partiellen Checkout nicht aktualisieren: die folgenden Einträge sind "
-"nicht\n"
-"aktuell:\n"
+"Kann partiellen Checkout nicht aktualisieren: die folgenden Einträge\n"
+"sind nicht aktuell:\n"
 "%s"
 
 #: unpack-trees.c:168
 #, c-format
 msgid ""
 "The following working tree files would be overwritten by sparse checkout "
@@ -4505,19 +4495,18 @@ msgstr "Submodule geändert, aber nicht aktualisiert:"
 
 #: wt-status.c:853
 msgid "Submodule changes to be committed:"
 msgstr "Änderungen in Submodul zum Committen:"
 
 #: wt-status.c:935
-#, fuzzy
 msgid ""
 "Do not modify or remove the line above.\n"
 "Everything below it will be ignored."
 msgstr ""
-"Ändern Sie nicht die obige Zeile.\n"
-"Alles unterhalb von ihr wird entfernt."
+"Ändern oder entfernen Sie nicht die obige Zeile.\n"
+"Alles unterhalb von ihr wird ignoriert."
 
 #: wt-status.c:1048
 msgid "You have unmerged paths."
 msgstr "Sie haben nicht zusammengeführte Pfade."
 
 #: wt-status.c:1051
@@ -5662,15 +5651,14 @@ msgstr "git branch [<Optionen>] [-r] (-d | -D) <Branchname>..."
 
 #: builtin/branch.c:30
 msgid "git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"
 msgstr "git branch [<Optionen>] (-m | -M) [<alter-Branch>] <neuer-Branch>"
 
 #: builtin/branch.c:31
-#, fuzzy
 msgid "git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"
-msgstr "git branch [<Optionen>] (-m | -M) [<alter-Branch>] <neuer-Branch>"
+msgstr "git branch [<Optionen>] (-c | -C) [<alter-Branch>] <neuer-Branch>"
 
 #: builtin/branch.c:32
 msgid "git branch [<options>] [-r | -a] [--points-at]"
 msgstr "git branch [<Optionen>] [-r | -a] [--points-at]"
 
 #: builtin/branch.c:33
@@ -5755,31 +5743,28 @@ msgstr "Remote-Tracking-Branch %s entfernt (war %s).\n"
 #: builtin/branch.c:272
 #, c-format
 msgid "Deleted branch %s (was %s).\n"
 msgstr "Branch %s entfernt (war %s).\n"
 
 #: builtin/branch.c:417 builtin/tag.c:58
-#, fuzzy
 msgid "unable to parse format string"
-msgstr "Konnte Commit '%s' nicht parsen."
+msgstr "Konnte Formatierungsstring nicht parsen."
 
 #: builtin/branch.c:450
 #, c-format
 msgid "Branch %s is being rebased at %s"
 msgstr "Branch %s wird auf %s umgesetzt"
 
 #: builtin/branch.c:454
 #, c-format
 msgid "Branch %s is being bisected at %s"
 msgstr "Binäre Suche von Branch %s zu %s im Gange"
 
 #: builtin/branch.c:470
-#, fuzzy
 msgid "cannot copy the current branch while not on any."
-msgstr ""
-"Kann aktuellen Branch nicht umbenennen, solange Sie sich auf keinem befinden."
+msgstr "Kann den aktuellen Branch nicht kopieren, solange Sie sich auf keinem befinden."
 
 #: builtin/branch.c:472
 msgid "cannot rename the current branch while not on any."
 msgstr ""
 "Kann aktuellen Branch nicht umbenennen, solange Sie sich auf keinem befinden."
 
@@ -5790,20 +5775,19 @@ msgstr "Ungültiger Branchname: '%s'"
 
 #: builtin/branch.c:504
 msgid "Branch rename failed"
 msgstr "Umbenennung des Branches fehlgeschlagen"
 
 #: builtin/branch.c:506
-#, fuzzy
 msgid "Branch copy failed"
-msgstr "Umbenennung des Branches fehlgeschlagen"
+msgstr "Kopie des Branches fehlgeschlagen"
 
 #: builtin/branch.c:510
-#, fuzzy, c-format
+#, c-format
 msgid "Copied a misnamed branch '%s' away"
-msgstr "falsch benannten Branch '%s' umbenannt"
+msgstr "falsch benannten Branch '%s' wegkopiert"
 
 #: builtin/branch.c:513
 #, c-format
 msgid "Renamed a misnamed branch '%s' away"
 msgstr "falsch benannten Branch '%s' umbenannt"
 
@@ -5816,16 +5800,15 @@ msgstr "Branch umbenannt zu %s, aber HEAD ist nicht aktualisiert!"
 msgid "Branch is renamed, but update of config-file failed"
 msgstr ""
 "Branch ist umbenannt, aber die Aktualisierung der Konfigurationsdatei ist "
 "fehlgeschlagen."
 
 #: builtin/branch.c:530
-#, fuzzy
 msgid "Branch is copied, but update of config-file failed"
 msgstr ""
-"Branch ist umbenannt, aber die Aktualisierung der Konfigurationsdatei ist "
+"Branch wurde kopiert, aber die Aktualisierung der Konfigurationsdatei ist\n"
 "fehlgeschlagen."
 
 #: builtin/branch.c:546
 #, c-format
 msgid ""
 "Please edit the description for the branch\n"
@@ -5850,15 +5833,14 @@ msgstr "Informationsmeldungen unterdrücken"
 
 #: builtin/branch.c:583
 msgid "set up tracking mode (see git-pull(1))"
 msgstr "den Übernahmemodus einstellen (siehe git-pull(1))"
 
 #: builtin/branch.c:585
-#, fuzzy
 msgid "do not use"
-msgstr "zu verwendende Anordnung"
+msgstr "nicht verwenden"
 
 #: builtin/branch.c:587
 msgid "upstream"
 msgstr "Upstream"
 
 #: builtin/branch.c:587
@@ -5908,21 +5890,18 @@ msgstr "einen Branch und dessen Reflog verschieben/umbenennen"
 #: builtin/branch.c:604
 msgid "move/rename a branch, even if target exists"
 msgstr ""
 "einen Branch verschieben/umbenennen, auch wenn das Ziel bereits existiert"
 
 #: builtin/branch.c:605
-#, fuzzy
 msgid "copy a branch and its reflog"
-msgstr "einen Branch und dessen Reflog verschieben/umbenennen"
+msgstr "einen Branch und dessen Reflog kopieren"
 
 #: builtin/branch.c:606
-#, fuzzy
 msgid "copy a branch, even if target exists"
-msgstr ""
-"einen Branch verschieben/umbenennen, auch wenn das Ziel bereits existiert"
+msgstr "einen Branch kopieren, auch wenn das Ziel bereits existiert"
 
 #: builtin/branch.c:607
 msgid "list branch names"
 msgstr "Branchnamen auflisten"
 
 #: builtin/branch.c:608
@@ -6004,25 +5983,22 @@ msgstr "Noch kein Commit in Branch '%s'."
 #: builtin/branch.c:723
 #, c-format
 msgid "No branch named '%s'."
 msgstr "Branch '%s' nicht vorhanden."
 
 #: builtin/branch.c:738
-#, fuzzy
 msgid "too many branches for a copy operation"
-msgstr "zu viele Branches für eine Umbenennen-Operation angegeben"
+msgstr "zu viele Branches für eine Kopieroperation angegeben"
 
 #: builtin/branch.c:747
-#, fuzzy
 msgid "too many arguments for a rename operation"
-msgstr "zu viele Branches für eine Umbenennen-Operation angegeben"
+msgstr "zu viele Argumente für eine Umbenennen-Operation angegeben"
 
 #: builtin/branch.c:752
-#, fuzzy
 msgid "too many arguments to set new upstream"
-msgstr "zu viele Branches angegeben, um Upstream-Branch zu setzen"
+msgstr "zu viele Argumente angegeben, um Upstream-Branch zu setzen"
 
 #: builtin/branch.c:756
 #, c-format
 msgid ""
 "could not set upstream of HEAD to %s when it does not point to any branch."
 msgstr ""
@@ -6037,16 +6013,14 @@ msgstr "Kein solcher Branch '%s'"
 #: builtin/branch.c:763
 #, c-format
 msgid "branch '%s' does not exist"
 msgstr "Branch '%s' existiert nicht"
 
 #: builtin/branch.c:775
-#, fuzzy
 msgid "too many arguments to unset upstream"
-msgstr ""
-"zu viele Branches angegeben, um Konfiguration zu Upstream-Branch zu entfernen"
+msgstr "zu viele Argumente angegeben, um Konfiguration zu Upstream-Branch zu entfernen"
 
 #: builtin/branch.c:779
 msgid "could not unset upstream of HEAD when it does not point to any branch."
 msgstr ""
 "Konnte Konfiguration zu Upstream-Branch von HEAD nicht entfernen, da dieser\n"
 "auf keinen Branch zeigt."
@@ -6064,19 +6038,18 @@ msgstr "'HEAD' darf nicht manuell erstellt werden"
 msgid "-a and -r options to 'git branch' do not make sense with a branch name"
 msgstr ""
 "Die Optionen -a und -r bei 'git branch' können nicht gemeimsam mit einem "
 "Branchnamen verwendet werden."
 
 #: builtin/branch.c:806
-#, fuzzy
 msgid ""
 "the '--set-upstream' option is no longer supported. Please use '--track' or "
 "'--set-upstream-to' instead."
 msgstr ""
-"Die --set-upstream Option ist veraltet und wird entfernt. Benutzen Sie --"
-"track oder --set-upstream-to\n"
+"Die '--set-upstream' Option wird nicht länger unterstützt.\n"
+"Bitte benutzen Sie stattdessen '--track' oder '--set-upstream-to'."
 
 #: builtin/bundle.c:45
 #, c-format
 msgid "%s is okay\n"
 msgstr "%s ist in Ordnung\n"
 
@@ -8688,15 +8661,14 @@ msgstr "Platzhalter als Tcl-String formatieren"
 
 #: builtin/for-each-ref.c:37
 msgid "show only <n> matched refs"
 msgstr "nur <n> passende Referenzen anzeigen"
 
 #: builtin/for-each-ref.c:39 builtin/tag.c:414
-#, fuzzy
 msgid "respect format colors"
-msgstr "Erwartetes Format: %%(color:<Farbe>)"
+msgstr "Formatfarben beachten"
 
 #: builtin/for-each-ref.c:43
 msgid "print only refs which points at the given object"
 msgstr "nur auf dieses Objekt zeigende Referenzen ausgeben"
 
 #: builtin/for-each-ref.c:45
@@ -9287,15 +9259,15 @@ msgstr "Eine Übersicht über empfohlene Arbeitsabläufe mit Git"
 
 #: builtin/help.c:426
 msgid "The common Git guides are:\n"
 msgstr "Die allgemein verwendeten Git-Anleitungen sind:\n"
 
 #: builtin/help.c:444
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' is aliased to '%s'"
-msgstr "für `git %s' wurde der Alias `%s' angelegt"
+msgstr "Für '%s' wurde der Alias '%s' angelegt."
 
 #: builtin/help.c:466 builtin/help.c:483
 #, c-format
 msgid "usage: %s%s"
 msgstr "Verwendung: %s%s"
 
@@ -9724,54 +9696,49 @@ msgstr "vorhandene Dateien direkt bearbeiten"
 #: builtin/interpret-trailers.c:93
 msgid "trim empty trailers"
 msgstr "kürzt leere Anhänge"
 
 #: builtin/interpret-trailers.c:96
 msgid "where to place the new trailer"
-msgstr ""
+msgstr "wo der neue Anhang platziert wird"
 
 #: builtin/interpret-trailers.c:98
-#, fuzzy
 msgid "action if trailer already exists"
-msgstr "Arbeitsverzeichnis '%s' existiert bereits."
+msgstr "Aktion, wenn Anhang bereits existiert"
 
 #: builtin/interpret-trailers.c:100
 msgid "action if trailer is missing"
-msgstr ""
+msgstr "Aktion, wenn Anhang fehlt"
 
 #: builtin/interpret-trailers.c:102
-#, fuzzy
 msgid "output only the trailers"
-msgstr "kürzt leere Anhänge"
+msgstr "nur Anhänge ausgeben"
 
 #: builtin/interpret-trailers.c:103
-#, fuzzy
 msgid "do not apply config rules"
-msgstr "Konfigurationsvariablen nachschlagen"
+msgstr "Regeln aus Konfiguration nicht anwenden"
 
 #: builtin/interpret-trailers.c:104
 msgid "join whitespace-continued values"
-msgstr ""
+msgstr "durch Leerzeichen fortgesetzte Werte verbinden"
 
 #: builtin/interpret-trailers.c:105
-#, fuzzy
 msgid "set parsing options"
-msgstr "Merge-Optionen"
+msgstr "Optionen für das Parsen setzen"
 
 #: builtin/interpret-trailers.c:107
 msgid "trailer"
 msgstr "Anhang"
 
 #: builtin/interpret-trailers.c:108
 msgid "trailer(s) to add"
 msgstr "Anhang/Anhänge hinzufügen"
 
 #: builtin/interpret-trailers.c:117
-#, fuzzy
 msgid "--trailer with --only-input does not make sense"
-msgstr "Die Option --name-only kann nicht verwendet werden."
+msgstr "Die Optionen --trailer und --only-input können nicht gemeinsam verwendet werden."
 
 #: builtin/interpret-trailers.c:127
 msgid "no input file given for in-place editing"
 msgstr "keine Datei zur direkten Bearbeitung angegeben"
 
 #: builtin/log.c:46
@@ -10055,15 +10022,14 @@ msgstr "eine Signatur aus einer Datei hinzufügen"
 
 #: builtin/log.c:1498
 msgid "don't print the patch filenames"
 msgstr "keine Dateinamen der Patches anzeigen"
 
 #: builtin/log.c:1500
-#, fuzzy
 msgid "show progress while generating patches"
-msgstr "Forschrittsanzeige während des Schreibens von Objekten anzeigen"
+msgstr "Forschrittsanzeige während der Erzeugung der Patches"
 
 #: builtin/log.c:1575
 #, c-format
 msgid "invalid ident line: %s"
 msgstr "Ungültige Identifikationszeile: %s"
 
@@ -10099,15 +10065,14 @@ msgstr "Konnte Verzeichnis '%s' nicht erstellen."
 #: builtin/log.c:1729
 #, c-format
 msgid "unable to read signature file '%s'"
 msgstr "Konnte Signatur-Datei '%s' nicht lesen"
 
 #: builtin/log.c:1761
-#, fuzzy
 msgid "Generating patches"
-msgstr "Bearbeitung des Patches fehlgeschlagen"
+msgstr "Erzeuge Patches"
 
 #: builtin/log.c:1805
 msgid "Failed to create output files"
 msgstr "Fehler beim Erstellen der Ausgabedateien."
 
 #: builtin/log.c:1855
@@ -10423,15 +10388,14 @@ msgstr "den sich im Gange befindlichen Merge fortsetzen"
 
 #: builtin/merge.c:234 builtin/pull.c:177
 msgid "allow merging unrelated histories"
 msgstr "erlaube das Zusammenführen von nicht zusammenhängenden Historien"
 
 #: builtin/merge.c:240
-#, fuzzy
 msgid "verify commit-msg hook"
-msgstr "Hooks pre-commit und commit-msg umgehen"
+msgstr "commit-msg Hook überprüfen"
 
 #: builtin/merge.c:265
 msgid "could not run stash."
 msgstr "Konnte \"stash\" nicht ausführen."
 
 #: builtin/merge.c:270
@@ -10649,13 +10613,12 @@ msgstr "Commit %s hat eine gültige GPG-Signatur von %s\n"
 
 #: builtin/merge.c:1366
 msgid "refusing to merge unrelated histories"
 msgstr "Verweigere den Merge von nicht zusammenhängenden Historien."
 
 #: builtin/merge.c:1375
-#, fuzzy
 msgid "Already up to date."
 msgstr "Bereits aktuell."
 
 #: builtin/merge.c:1385
 #, c-format
 msgid "Updating %s..%s\n"
@@ -10669,13 +10632,12 @@ msgstr "Probiere wirklich trivialen \"in-index\"-Merge ...\n"
 #: builtin/merge.c:1433
 #, c-format
 msgid "Nope.\n"
 msgstr "Nein.\n"
 
 #: builtin/merge.c:1458
-#, fuzzy
 msgid "Already up to date. Yeeah!"
 msgstr "Bereits aktuell."
 
 #: builtin/merge.c:1464
 msgid "Not possible to fast-forward, aborting."
 msgstr "Vorspulen nicht möglich, breche ab."
@@ -12210,48 +12172,46 @@ msgstr "unpack-trees protokollieren"
 
 #: builtin/rebase--helper.c:8
 msgid "git rebase--helper [<options>]"
 msgstr "git rebase--helper [<Optionen>]"
 
 #: builtin/rebase--helper.c:22
-#, fuzzy
 msgid "keep empty commits"
-msgstr "redundante, leere Commits behalten"
+msgstr "leere Commits behalten"
 
 #: builtin/rebase--helper.c:23
 msgid "continue rebase"
 msgstr "Rebase fortsetzen"
 
 #: builtin/rebase--helper.c:25
 msgid "abort rebase"
 msgstr "Rebase abbrechen"
 
 #: builtin/rebase--helper.c:28
 msgid "make rebase script"
-msgstr ""
+msgstr "Rebase-Skript erstellen"
 
 #: builtin/rebase--helper.c:30
 msgid "shorten SHA-1s in the todo list"
-msgstr ""
+msgstr "SHA-1's in der TODO-Liste verkürzen"
 
 #: builtin/rebase--helper.c:32
 msgid "expand SHA-1s in the todo list"
-msgstr ""
+msgstr "SHA1's in der TODO-Liste erweitern"
 
 #: builtin/rebase--helper.c:34
 msgid "check the todo list"
-msgstr ""
+msgstr "die TODO-Liste prüfen"
 
 #: builtin/rebase--helper.c:36
-#, fuzzy
 msgid "skip unnecessary picks"
-msgstr "Fehler beim Auslassen von nicht erforderlichen \"pick\"-Befehlen."
+msgstr "nicht erforderliche \"pick\"-Befehle auslassen"
 
 #: builtin/rebase--helper.c:38
 msgid "rearrange fixup/squash lines"
-msgstr ""
+msgstr "fixup/squash-Zeilen umordnen"
 
 #: builtin/receive-pack.c:29
 msgid "git receive-pack <git-dir>"
 msgstr "git receive-pack <Git-Verzeichnis>"
 
 #: builtin/receive-pack.c:839
@@ -14442,13 +14402,13 @@ msgstr "Lösche worktrees/%s: konnte gitdir-Datei (%s) nicht lesen"
 
 #: builtin/worktree.c:76
 #, c-format
 msgid ""
 "Removing worktrees/%s: short read (expected %<PRIuMAX> bytes, read "
 "%<PRIuMAX>)"
-msgstr ""
+msgstr "Lösche worktrees/%s: read() zu kurz (%<PRIuMAX> Bytes erwartet, %<PRIuMAX> gelesen)"
 
 #: builtin/worktree.c:84
 #, c-format
 msgid "Removing worktrees/%s: invalid gitdir file"
 msgstr "Lösche worktrees/%s: ungültige gitdir-Datei"
 
@@ -14997,13 +14957,13 @@ msgstr "Sollte keinen Octopus-Merge ausführen."
 #: git-merge-octopus.sh:73
 #, sh-format
 msgid "Unable to find common commit with $pretty_name"
 msgstr "Konnte keinen gemeinsamen Commit mit $pretty_name finden."
 
 #: git-merge-octopus.sh:77
-#, fuzzy, sh-format
+#, sh-format
 msgid "Already up to date with $pretty_name"
 msgstr "Bereits aktuell mit $pretty_name"
 
 #: git-merge-octopus.sh:89
 #, sh-format
 msgid "Fast-forwarding to: $pretty_name"
@@ -15016,25 +14976,25 @@ msgstr "Versuche einfachen Merge mit $pretty_name"
 
 #: git-merge-octopus.sh:102
 msgid "Simple merge did not work, trying automatic merge."
 msgstr "Einfacher Merge hat nicht funktioniert, versuche automatischen Merge."
 
 #: git-rebase.sh:58
-#, fuzzy
 msgid ""
 "Resolve all conflicts manually, mark them as resolved with\n"
 "\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
 "You can instead skip this commit: run \"git rebase --skip\".\n"
 "To abort and get back to the state before \"git rebase\", run \"git rebase --"
 "abort\"."
 msgstr ""
-"Wenn Sie das Problem aufgelöst haben, führen Sie \"git rebase --continue\" "
-"aus.\n"
-"Falls Sie diesen Patch auslassen möchten, führen Sie stattdessen \"git "
-"rebase --skip\" aus.\n"
-"Um den ursprünglichen Branch wiederherzustellen und den Rebase abzubrechen,\n"
+"Lösen Sie alle Konflikte manuell auf, markieren Sie diese mit\n"
+"\"git add/rm <konfliktbehaftete_Dateien>\" und führen Sie dann\n"
+"\"git rebase --continue\" aus.\n"
+"Sie können auch stattdessen diesen Commit auslassen, indem\n"
+"Sie \"git rebase --skip\" ausführen.\n"
+"Um abzubrechen und zurück zum Zustand vor \"git rebase\" zu gelangen,\n"
 "führen Sie \"git rebase --abort\" aus."
 
 #: git-rebase.sh:160 git-rebase.sh:402
 #, sh-format
 msgid "Could not move back to $head_name"
 msgstr "Konnte nicht zu $head_name zurückgehen"
@@ -15606,13 +15566,12 @@ msgstr "Siehe git-${cmd}(1) für weitere Details."
 #: git-rebase--interactive.sh:140
 #, sh-format
 msgid "Rebasing ($new_count/$total)"
 msgstr "Führe Rebase aus ($new_count/$total)"
 
 #: git-rebase--interactive.sh:156
-#, fuzzy
 msgid ""
 "\n"
 "Commands:\n"
 "p, pick = use commit\n"
 "r, reword = use commit, but edit the commit message\n"
 "e, edit = use commit, but stop for amending\n"
@@ -15622,19 +15581,19 @@ msgid ""
 "d, drop = remove commit\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n"
 msgstr ""
 "\n"
 "Befehle:\n"
-" p, pick = Commit verwenden\n"
-" r, reword = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
-" e, edit = Commit verwenden, aber zum Nachbessern anhalten\n"
-" s, squash = Commit verwenden, aber mit vorherigem Commit vereinen\n"
-" f, fixup = wie \"squash\", aber diese Commit-Beschreibung verwerfen\n"
-" x, exec = Befehl (Rest der Zeile) mittels Shell ausführen\n"
-" d, drop = Commit entfernen\n"
+"p, pick = Commit verwenden\n"
+"r, reword = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
+"e, edit = Commit verwenden, aber zum Nachbessern anhalten\n"
+"s, squash = Commit verwenden, aber mit vorherigem Commit vereinen\n"
+"f, fixup = wie \"squash\", aber diese Commit-Beschreibung verwerfen\n"
+"x, exec = Befehl (Rest der Zeile) mittels Shell ausführen\n"
+"d, drop = Commit entfernen\n"
 "\n"
 "Diese Zeilen können umsortiert werden; Sie werden von oben nach unten\n"
 "ausgeführt.\n"
 
 #: git-rebase--interactive.sh:171
 msgid ""
-- 
2.15.0.rc1.299.gda03b47c3

