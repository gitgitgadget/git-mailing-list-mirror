Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237EB1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHVTbp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41606 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeHVTbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26-v6so1788203lfc.8
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SFMfJ/zzVJgrfxCXq51YFM8I8ZYPWxsLNwXIouP79mc=;
        b=fXFWg+dshFg0gOju1W8xEs2jFwJstGu/AFw9lyceNrQ6r4W4NNfIlK5BhUDv68nhdg
         5bBzzlKNu5v6f1LY+Rf29HT+1hpEGEuLCXX6Hn1GVXC++/vEd8Ryw5blIU6l0IQSA4Qo
         Lz+BAk3XmES+x6Ib1hfHMODKUEyS/kYrhlJocsCeB5dTEtdmDswldgpUlIjuQYGfJ/Fa
         IsDMORmTUigK6r73TMNpzKkmiQY1NMg/yvuHcMV+6dlXIBw6ll92BIfGDFjQokiwkMPy
         gBj5RLoqOe67Z3jtbUdYFGE2hp8D/4jzIBBxuObxZsJ38vTM2TW4z1zJSAICGXr4jwGC
         6E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SFMfJ/zzVJgrfxCXq51YFM8I8ZYPWxsLNwXIouP79mc=;
        b=OOT7S6ScpGHIwl8dQ9Dd6xU7NKjqdk9FocwxHgOcewFNo8KYLROfO9FwS0pasO/IQS
         Os6idE3BbjZprN/FQHnvfsV5EsNWaLHXgSzem62z5XnQbXeGIrc9k0l49IqFvoRSWNrv
         766uX1KgMHjUMsR3Z8j+qePv1lS+sWvzeB5Ikvk+JGb08o4FoCEGMNRS7s192LR80PPq
         BQf/w1NgXLieZAHTLUdTiShaLVUVDEbiyCWaB5XYfT+se9mwnSVcbPbyAFDU89Xa+vHk
         l+y3iyhZXlu/VPykO2KUeXX2+rAVR2LJ/RZBfuZbZ/DmbdWehBxiBwMKDdUgTCbL7/U5
         0ejg==
X-Gm-Message-State: AOUpUlEYRq3i9r8owuechF5EUgcZwjzEaJW9c7kz6+ZQ9YXVJ1TtncA5
        RmOpLYlGB764R8vaw7TmBmx4WQof
X-Google-Smtp-Source: AA+uWPzH0bAFBCq3WoOdlH73GQ5fljtEuWD4uPxdLQtMuzH+2odg0Nnsq85U85HdwmGkA46El60eiQ==
X-Received: by 2002:ac2:50c7:: with SMTP id h7-v6mr9834595lfm.47.1534953973322;
        Wed, 22 Aug 2018 09:06:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:12 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/11] config.txt: move gitcvs part out to a separate file
Date:   Wed, 22 Aug 2018 18:05:58 +0200
Message-Id: <20180822160605.21864-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 68 +--------------------------------
 Documentation/gitcvs-config.txt | 67 ++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/gitcvs-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 393f6843f5..9309695a9e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1675,73 +1675,7 @@ gc.rerereUnresolved::
 	You can also use more human-readable "1.month.ago", etc.
 	The default is 15 days.  See linkgit:git-rerere[1].
 
-gitcvs.commitMsgAnnotation::
-	Append this string to each commit message. Set to empty string
-	to disable this feature. Defaults to "via git-CVS emulator".
-
-gitcvs.enabled::
-	Whether the CVS server interface is enabled for this repository.
-	See linkgit:git-cvsserver[1].
-
-gitcvs.logFile::
-	Path to a log file where the CVS server interface well... logs
-	various stuff. See linkgit:git-cvsserver[1].
-
-gitcvs.usecrlfattr::
-	If true, the server will look up the end-of-line conversion
-	attributes for files to determine the `-k` modes to use. If
-	the attributes force Git to treat a file as text,
-	the `-k` mode will be left blank so CVS clients will
-	treat it as text. If they suppress text conversion, the file
-	will be set with '-kb' mode, which suppresses any newline munging
-	the client might otherwise do. If the attributes do not allow
-	the file type to be determined, then `gitcvs.allBinary` is
-	used. See linkgit:gitattributes[5].
-
-gitcvs.allBinary::
-	This is used if `gitcvs.usecrlfattr` does not resolve
-	the correct '-kb' mode to use. If true, all
-	unresolved files are sent to the client in
-	mode '-kb'. This causes the client to treat them
-	as binary files, which suppresses any newline munging it
-	otherwise might do. Alternatively, if it is set to "guess",
-	then the contents of the file are examined to decide if
-	it is binary, similar to `core.autocrlf`.
-
-gitcvs.dbName::
-	Database used by git-cvsserver to cache revision information
-	derived from the Git repository. The exact meaning depends on the
-	used database driver, for SQLite (which is the default driver) this
-	is a filename. Supports variable substitution (see
-	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;`).
-	Default: '%Ggitcvs.%m.sqlite'
-
-gitcvs.dbDriver::
-	Used Perl DBI driver. You can specify any available driver
-	for this here, but it might not work. git-cvsserver is tested
-	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
-	reported *not* to work with 'DBD::mysql'. Experimental feature.
-	May not contain double colons (`:`). Default: 'SQLite'.
-	See linkgit:git-cvsserver[1].
-
-gitcvs.dbUser, gitcvs.dbPass::
-	Database user and password. Only useful if setting `gitcvs.dbDriver`,
-	since SQLite has no concept of database users and/or passwords.
-	'gitcvs.dbUser' supports variable substitution (see
-	linkgit:git-cvsserver[1] for details).
-
-gitcvs.dbTableNamePrefix::
-	Database table name prefix.  Prepended to the names of any
-	database tables used, allowing a single database to be used
-	for several repositories.  Supports variable substitution (see
-	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
-	characters will be replaced with underscores.
-
-All gitcvs variables except for `gitcvs.usecrlfattr` and
-`gitcvs.allBinary` can also be specified as
-'gitcvs.<access_method>.<varname>' (where 'access_method'
-is one of "ext" and "pserver") to make them apply only for the given
-access method.
+include::gitcvs-config.txt[]
 
 gitweb.category::
 gitweb.description::
diff --git a/Documentation/gitcvs-config.txt b/Documentation/gitcvs-config.txt
new file mode 100644
index 0000000000..02da427fd9
--- /dev/null
+++ b/Documentation/gitcvs-config.txt
@@ -0,0 +1,67 @@
+gitcvs.commitMsgAnnotation::
+	Append this string to each commit message. Set to empty string
+	to disable this feature. Defaults to "via git-CVS emulator".
+
+gitcvs.enabled::
+	Whether the CVS server interface is enabled for this repository.
+	See linkgit:git-cvsserver[1].
+
+gitcvs.logFile::
+	Path to a log file where the CVS server interface well... logs
+	various stuff. See linkgit:git-cvsserver[1].
+
+gitcvs.usecrlfattr::
+	If true, the server will look up the end-of-line conversion
+	attributes for files to determine the `-k` modes to use. If
+	the attributes force Git to treat a file as text,
+	the `-k` mode will be left blank so CVS clients will
+	treat it as text. If they suppress text conversion, the file
+	will be set with '-kb' mode, which suppresses any newline munging
+	the client might otherwise do. If the attributes do not allow
+	the file type to be determined, then `gitcvs.allBinary` is
+	used. See linkgit:gitattributes[5].
+
+gitcvs.allBinary::
+	This is used if `gitcvs.usecrlfattr` does not resolve
+	the correct '-kb' mode to use. If true, all
+	unresolved files are sent to the client in
+	mode '-kb'. This causes the client to treat them
+	as binary files, which suppresses any newline munging it
+	otherwise might do. Alternatively, if it is set to "guess",
+	then the contents of the file are examined to decide if
+	it is binary, similar to `core.autocrlf`.
+
+gitcvs.dbName::
+	Database used by git-cvsserver to cache revision information
+	derived from the Git repository. The exact meaning depends on the
+	used database driver, for SQLite (which is the default driver) this
+	is a filename. Supports variable substitution (see
+	linkgit:git-cvsserver[1] for details). May not contain semicolons (`;`).
+	Default: '%Ggitcvs.%m.sqlite'
+
+gitcvs.dbDriver::
+	Used Perl DBI driver. You can specify any available driver
+	for this here, but it might not work. git-cvsserver is tested
+	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
+	reported *not* to work with 'DBD::mysql'. Experimental feature.
+	May not contain double colons (`:`). Default: 'SQLite'.
+	See linkgit:git-cvsserver[1].
+
+gitcvs.dbUser, gitcvs.dbPass::
+	Database user and password. Only useful if setting `gitcvs.dbDriver`,
+	since SQLite has no concept of database users and/or passwords.
+	'gitcvs.dbUser' supports variable substitution (see
+	linkgit:git-cvsserver[1] for details).
+
+gitcvs.dbTableNamePrefix::
+	Database table name prefix.  Prepended to the names of any
+	database tables used, allowing a single database to be used
+	for several repositories.  Supports variable substitution (see
+	linkgit:git-cvsserver[1] for details).  Any non-alphabetic
+	characters will be replaced with underscores.
+
+All gitcvs variables except for `gitcvs.usecrlfattr` and
+`gitcvs.allBinary` can also be specified as
+'gitcvs.<access_method>.<varname>' (where 'access_method'
+is one of "ext" and "pserver") to make them apply only for the given
+access method.
-- 
2.19.0.rc0.335.ga73d156e9c

