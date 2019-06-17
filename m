Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5731F462
	for <e@80x24.org>; Mon, 17 Jun 2019 16:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFQQzX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 12:55:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32974 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQQzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 12:55:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so6021571pfq.0
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 09:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4iB11MsL3DmDTzL1VisMppQFASEY3lNUQnwA88ZK91w=;
        b=v90UzvfBt+wgwAJISf7hqBkQ+judmIQ4CNudBgBoypLlQVBxC0JWdYh1fNYzsa3q3K
         kKcRjpQJyo36YCAM52umO+/MEEzyCMDzkIAeCELtzDdTVOSzXPx2HsryU9ZleXR4VtYk
         1H0Zq9gSE1r+sRP9jqfKKbiQP1Kmd8DIfHR8CRjNnvHvLZ/TSDCbiWfEBRbw0JpgyuAY
         vLk2I0/v4VT286vjNGOsAJ/9RYS009OUPMrKrss1zlBdFTgHwFsiQw0l+EZ4GtfZIqSg
         rhG8EiQ62ab/U0cGq6fV0MU76wX+PWPVGnBZZ1d9gqvmO/637qo1yrXl9WyCJ7HrY6rJ
         LP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4iB11MsL3DmDTzL1VisMppQFASEY3lNUQnwA88ZK91w=;
        b=Q1UGC0hR4wFo/tBhCgKiiP+YRJK3eT2Z/PEybJj8Wj6mLrjQpSeGgRAMbIOgARvUrD
         xiMKEX78c49QdNMpI/MTPRKEEca8FIWi/tFm+dCT753pLINdpB3qZY8ugZ1vxvRLaBpJ
         ANKiEv1wo7NoSvqOZ8LSRiZKiIt89m9pM89cHXh6WG1L/j6SIBFPdu2RSp2OhXH71Uod
         mQ3Sw/4t4NDROmb67guqc4ZQEC0X6FVYSVczcHIqaKRQNH8TZKoVh7dXR0fdEnjxNuxc
         4apMJieyKitJd+6UjDXacfFH0Px9ozZfCKeOdlm2nsvTIUXJO41ltdWNKqg0P8UOGB1e
         gw3Q==
X-Gm-Message-State: APjAAAWCcIFH9GgNcuTrLtHGsX8vRemHqS7z4bjpJh9ST0FvJnEc4oVR
        QKQzXQzX294S4RVlEeCYJELKNqMCckc=
X-Google-Smtp-Source: APXvYqzXv7BIMgPtR3dqEIA+hDB/srQOKtYDSaRXX0CoH5/6tDryBOXv9F4r8zev5FRCFOlXaiOhLQ==
X-Received: by 2002:a17:90a:b78b:: with SMTP id m11mr27503368pjr.106.1560790521780;
        Mon, 17 Jun 2019 09:55:21 -0700 (PDT)
Received: from localhost.localdomain ([175.159.181.117])
        by smtp.gmail.com with ESMTPSA id t14sm13690018pfl.62.2019.06.17.09.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jun 2019 09:55:21 -0700 (PDT)
From:   Boxuan Li <liboxuan@connect.hku.hk>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, gitster@pobox.com,
        Boxuan Li <liboxuan@connect.hku.hk>
Subject: [RFC PATCH] userdiff: ship built-in driver config file
Date:   Tue, 18 Jun 2019 00:54:50 +0800
Message-Id: <20190617165450.81916-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The userdiff.c has been rewritten to avoid hard-coded built-in
driver patterns. Now we ship
$(sharedir)/git-core/templates/userdiff that can be read using
git_config_from_file() interface, using a very narrow callback
function that understands only diff.*.xfuncname,
diff.*.wordregex, and diff.*.regIcase.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
A few notes and questions:
1. In [diff "tex"] section, \x80 and \xff cannot be parsed by git config parser.
I have no idea why this is happening. I changed them to \\x80 and \\xff as a workaround, which
resulted in t4034 failure (See https://travis-ci.org/li-boxuan/git/jobs/546729906#L4679).
2. I am not sure how and where I can free the memory allocated to "builtin_drivers".
3. When I run `git format-patch HEAD~1`, core dump happens occasionally. Seems
no test case caught this problem. Till now, I have no luck finding out the reason.

Any hint or review would be appreciated.
---
 templates/this--userdiff | 164 ++++++++++++++++++++++
 userdiff.c               | 284 +++++++++++++++------------------------
 2 files changed, 275 insertions(+), 173 deletions(-)
 create mode 100644 templates/this--userdiff

diff --git a/templates/this--userdiff b/templates/this--userdiff
new file mode 100644
index 0000000000..85114a7229
--- /dev/null
+++ b/templates/this--userdiff
@@ -0,0 +1,164 @@
+[diff "ada"]
+	xfuncname = "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
+	xfuncname = "!^[ \t]*with[ \t].*$\n"
+	xfuncname = "^[ \t]*((procedure|function)[ \t]+.*)$\n"
+	xfuncname = "^[ \t]*((package|protected|task)[ \t]+.*)$"
+	wordRegex = "[a-zA-Z][a-zA-Z0-9_]*"
+	wordRegex = "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
+	wordRegex = "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"
+	regIcase = true
+
+[diff "fortran"]
+	xfuncname = "!^([C*]|[ \t]*!)\n"
+	xfuncname = "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
+	xfuncname = "^[ \t]*((END[ \t]+)?(PROGRAM|MODULE|BLOCK[ \t]+DATA"
+	xfuncname = "|([^'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$"
+	wordRegex = "[a-zA-Z][a-zA-Z0-9_]*"
+	wordRegex = "|\\.([Ee][Qq]|[Nn][Ee]|[Gg][TtEe]|[Ll][TtEe]|[Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]|[Aa][Nn][Dd]|[Oo][Rr]|[Nn]?[Ee][Qq][Vv]|[Nn][Oo][Tt])\\."
+	; numbers and format statements like 2E14.4, or ES12.6, 9X.
+	; Don't worry about format statements without leading digits since
+	; they would have been matched above as a variable anyway.
+	wordRegex = "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
+	wordRegex = "|//|\\*\\*|::|[/<>=]="
+	regIcase = true
+
+[diff "fountain"]
+	xfuncname = "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$"
+	wordRegex = "[^ \t-]+"
+	regIcase = true
+
+[diff "golang"]
+	; Functions
+	xfuncname = "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
+	; Structs and interfaces
+	xfuncname = "^[ \t]*(type[ \t].*(struct|interface)[ \t]*(\\{[ \t]*)?)"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
+	wordRegex = "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&\\^=?|&&|\\|\\||<-|\\.{3}"
+
+[diff "html"]
+	xfuncname = "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$"
+	wordRegex = "[^<>= \t]+"
+
+[diff "java"]
+	xfuncname = "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
+	xfuncname = "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	wordRegex = "|[-+*/<>%&^|=!]="
+	wordRegex = "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"
+
+[diff "matlab"]
+	xfuncname = "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"
+
+[diff "objc"]
+	; Negate C statements that can look like functions
+	xfuncname = "!^[ \t]*(do|for|if|else|return|switch|while)\n"
+	; Objective-C methods
+	xfuncname = "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[ \t]*[A-Za-z_].*)$\n"
+	; C functions
+	xfuncname = "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$\n"
+	; Objective-C class/protocol definitions
+	xfuncname = "^(@(implementation|interface|protocol)[ \t].*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	wordRegex = "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
+
+[diff "pascal"]
+	xfuncname = "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
+	xfuncname = "implementation|initialization|finalization)[ \t]*.*)$"
+	xfuncname = "\n"
+	xfuncname = "^(.*=[ \t]*(class|record).*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
+	wordRegex = "|<>|<=|>=|:=|\\.\\."
+
+[diff "perl"]
+	xfuncname = "^package .*\n"
+	xfuncname = "^sub [[:alnum:]_':]+[ \t]*"
+		xfuncname = "(\\([^)]*\\)[ \t]*)?" ; prototype
+		; Attributes.  A regex can't count nested parentheses,
+		; so just slurp up whatever we see, taking care not
+		; to accept lines like "sub foo; # defined elsewhere".
+		;
+		; An attribute could contain a semicolon, but at that
+		; point it seems reasonable enough to give up.
+		xfuncname = "(:[^;#]*)?"
+		xfuncname = "(\\{[ \t]*)?" ; brace can come here or on the next line
+		xfuncname = "(#.*)?$\n" ; comment
+	xfuncname = "^(BEGIN|END|INIT|CHECK|UNITCHECK|AUTOLOAD|DESTROY)[ \t]*"
+		xfuncname = "(\\{[ \t]*)?" ; brace can come here or on the next line
+		xfuncname = "(#.*)?$\n"
+	xfuncname = "^=head[0-9] .*" ; POD
+	wordRegex = "[[:alpha:]_'][[:alnum:]_']*"
+	wordRegex = "|0[xb]?[0-9a-fA-F_]*"
+	; taking care not to interpret 3..5 as (3.)(.5)
+	wordRegex = "|[0-9a-fA-F_]+(\\.[0-9a-fA-F_]+)?([eE][-+]?[0-9_]+)?"
+	wordRegex = "|=>|-[rwxoRWXOezsfdlpSugkbctTBMAC>]|~~|::"
+	wordRegex = "|&&=|\\|\\|=|//=|\\*\\*="
+	wordRegex = "|&&|\\|\\||//|\\+\\+|--|\\*\\*|\\.\\.\\.?"
+	wordRegex = "|[-+*/%.^&<>=!|]="
+	wordRegex = "|=~|!~"
+	wordRegex = "|<<|<>|<=>|>>"
+
+[diff "php"]
+	xfuncname = "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
+	xfuncname = "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
+	wordRegex = "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"
+
+[diff "python"]
+	xfuncname = "^[ \t]*((class|def)[ \t].*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
+	wordRegex = "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"
+
+[diff "ruby"]
+	xfuncname = "^[ \t]*((class|module|def)[ \t].*)$"
+	wordRegex = "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
+	wordRegex = "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"
+
+[diff "bibtex"]
+	xfuncname = "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$"
+	wordRegex = "[={}\"]|[^={}\" \t]+"
+
+[diff "tex"]
+	xfuncname = "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"
+	wordRegex = "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\\x80-\\xff]+"
+
+[diff "cpp"]
+	; Jump targets or access declarations
+	xfuncname = "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
+	; functions/methods, variables, and compounds at top level
+	xfuncname = "^((::[[:space:]]*)?[A-Za-z_].*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
+	wordRegex = "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"
+
+[diff "csharp"]
+	; Keywords
+	xfuncname = "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
+	; Methods and constructors
+	xfuncname = "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	; Properties
+	xfuncname = "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	; Type definitions
+	xfuncname = "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
+	; Namespace
+	xfuncname = "^[ \t]*(namespace[ \t]+.*)$"
+	wordRegex = "[a-zA-Z_][a-zA-Z0-9_]*"
+	wordRegex = "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	wordRegex = "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
+
+[diff "css"]
+	xfuncname = "![:;][[:space:]]*$\n"
+	xfuncname = "^[_a-z0-9].*$"
+	; This regex comes from W3C CSS specs. Should theoretically also
+	; allow ISO 10646 characters U+00A0 and higher,
+	; but they are not handled in this regex.
+	wordRegex = "-?[_a-zA-Z][-_a-zA-Z0-9]*" ; identifiers
+	wordRegex = "|-?[0-9]+|\\#[0-9a-fA-F]+" ; numbers
+	regIcase = true
diff --git a/userdiff.c b/userdiff.c
index 3a78fbf504..3e7052e13c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -2,178 +2,121 @@
 #include "config.h"
 #include "userdiff.h"
 #include "attr.h"
+#include "exec-cmd.h"
+#include "repository.h"
 
 static struct userdiff_driver *drivers;
 static int ndrivers;
 static int drivers_alloc;
+static struct config_set gm_config;
+static int config_init;
+struct userdiff_driver *builtin_drivers;
+static int builtin_drivers_size;
 
-#define PATTERNS(name, pattern, word_regex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED },		\
-	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
-#define IPATTERN(name, pattern, word_regex)			\
-	{ name, NULL, -1, { pattern, REG_EXTENDED | REG_ICASE }, \
-	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
-static struct userdiff_driver builtin_drivers[] = {
-IPATTERN("ada",
-	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
-	 "!^[ \t]*with[ \t].*$\n"
-	 "^[ \t]*((procedure|function)[ \t]+.*)$\n"
-	 "^[ \t]*((package|protected|task)[ \t]+.*)$",
-	 /* -- */
-	 "[a-zA-Z][a-zA-Z0-9_]*"
-	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
-	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
-IPATTERN("fortran",
-	 "!^([C*]|[ \t]*!)\n"
-	 "!^[ \t]*MODULE[ \t]+PROCEDURE[ \t]\n"
-	 "^[ \t]*((END[ \t]+)?(PROGRAM|MODULE|BLOCK[ \t]+DATA"
-		"|([^'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
-	 /* -- */
-	 "[a-zA-Z][a-zA-Z0-9_]*"
-	 "|\\.([Ee][Qq]|[Nn][Ee]|[Gg][TtEe]|[Ll][TtEe]|[Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]|[Aa][Nn][Dd]|[Oo][Rr]|[Nn]?[Ee][Qq][Vv]|[Nn][Oo][Tt])\\."
-	 /* numbers and format statements like 2E14.4, or ES12.6, 9X.
-	  * Don't worry about format statements without leading digits since
-	  * they would have been matched above as a variable anyway. */
-	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
-	 "|//|\\*\\*|::|[/<>=]="),
-IPATTERN("fountain", "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
-	 "[^ \t-]+"),
-PATTERNS("golang",
-	 /* Functions */
-	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
-	 /* Structs and interfaces */
-	 "^[ \t]*(type[ \t].*(struct|interface)[ \t]*(\\{[ \t]*)?)",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.eE]+i?|0[xX]?[0-9a-fA-F]+i?"
-	 "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&\\^=?|&&|\\|\\||<-|\\.{3}"),
-PATTERNS("html", "^[ \t]*(<[Hh][1-6]([ \t].*)?>.*)$",
-	 "[^<>= \t]+"),
-PATTERNS("java",
-	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
-	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]="
-	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
-PATTERNS("matlab",
-	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
-	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
-PATTERNS("objc",
-	 /* Negate C statements that can look like functions */
-	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
-	 /* Objective-C methods */
-	 "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]*\\)[ \t]*[A-Za-z_].*)$\n"
-	 /* C functions */
-	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$\n"
-	 /* Objective-C class/protocol definitions */
-	 "^(@(implementation|interface|protocol)[ \t].*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
-PATTERNS("pascal",
-	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
-		"implementation|initialization|finalization)[ \t]*.*)$"
-	 "\n"
-	 "^(.*=[ \t]*(class|record).*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
-	 "|<>|<=|>=|:=|\\.\\."),
-PATTERNS("perl",
-	 "^package .*\n"
-	 "^sub [[:alnum:]_':]+[ \t]*"
-		"(\\([^)]*\\)[ \t]*)?" /* prototype */
-		/*
-		 * Attributes.  A regex can't count nested parentheses,
-		 * so just slurp up whatever we see, taking care not
-		 * to accept lines like "sub foo; # defined elsewhere".
-		 *
-		 * An attribute could contain a semicolon, but at that
-		 * point it seems reasonable enough to give up.
-		 */
-		"(:[^;#]*)?"
-		"(\\{[ \t]*)?" /* brace can come here or on the next line */
-		"(#.*)?$\n" /* comment */
-	 "^(BEGIN|END|INIT|CHECK|UNITCHECK|AUTOLOAD|DESTROY)[ \t]*"
-		"(\\{[ \t]*)?" /* brace can come here or on the next line */
-		"(#.*)?$\n"
-	 "^=head[0-9] .*",	/* POD */
-	 /* -- */
-	 "[[:alpha:]_'][[:alnum:]_']*"
-	 "|0[xb]?[0-9a-fA-F_]*"
-	 /* taking care not to interpret 3..5 as (3.)(.5) */
-	 "|[0-9a-fA-F_]+(\\.[0-9a-fA-F_]+)?([eE][-+]?[0-9_]+)?"
-	 "|=>|-[rwxoRWXOezsfdlpSugkbctTBMAC>]|~~|::"
-	 "|&&=|\\|\\|=|//=|\\*\\*="
-	 "|&&|\\|\\||//|\\+\\+|--|\\*\\*|\\.\\.\\.?"
-	 "|[-+*/%.^&<>=!|]="
-	 "|=~|!~"
-	 "|<<|<>|<=>|>>"),
-PATTERNS("php",
-	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
-	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
-	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"),
-PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
-	 /* -- */
-PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
-	 /* -- */
-	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
-	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
-PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
-	 "[={}\"]|[^={}\" \t]+"),
-PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
-PATTERNS("cpp",
-	 /* Jump targets or access declarations */
-	 "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])\n"
-	 /* functions/methods, variables, and compounds at top level */
-	 "^((::[[:space:]]*)?[A-Za-z_].*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
-PATTERNS("csharp",
-	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
-	 /* Properties */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
-	 /* Type definitions */
-	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
-	 /* Namespace */
-	 "^[ \t]*(namespace[ \t]+.*)$",
-	 /* -- */
-	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
-IPATTERN("css",
-	 "![:;][[:space:]]*$\n"
-	 "^[_a-z0-9].*$",
-	 /* -- */
-	 /*
-	  * This regex comes from W3C CSS specs. Should theoretically also
-	  * allow ISO 10646 characters U+00A0 and higher,
-	  * but they are not handled in this regex.
-	  */
-	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
-	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
-),
-{ "default", NULL, -1, { NULL, 0 } },
-};
-#undef PATTERNS
-#undef IPATTERN
+static int userdiff_config_init(void)
+{
+	int ret = -1;
+	if (!config_init) {
+		git_configset_init(&gm_config);
+		if (the_repository && the_repository->gitdir)
+			ret = git_configset_add_file(&gm_config, git_pathdup("userdiff"));
+
+		// if .git/userdiff does not exist, set config_init to be -1
+		if (ret == 0)
+			config_init = 1;
+		else
+			config_init = -1;
+
+		builtin_drivers = (struct userdiff_driver *) malloc(sizeof(struct userdiff_driver));
+		*builtin_drivers = (struct userdiff_driver) { "default", NULL, -1, { NULL, 0 } };
+		builtin_drivers_size = 1;
+	}
+	return 0;
+}
+
+static char* join_strings(const struct string_list *strings)
+{
+	char* str;
+	int i, len, length = 0;
+	if (!strings)
+		return NULL;
+
+	for (i = 0; i < strings->nr; i++)
+		length += strlen(strings->items[i].string);
+
+	str = (char *) malloc(length + 1);
+	length = 0;
+
+	for (i = 0; i < strings->nr; i++) {
+		len = strlen(strings->items[i].string);
+		memcpy(str + length, strings->items[i].string, len);
+		length += len;
+	}
+	str[length] = '\0';
+	return str;
+}
+
+static struct userdiff_driver *userdiff_find_builtin_by_namelen(const char *k, int len)
+{
+	int i, key_length, word_regex_size, ret, reg_icase, cflags;
+	char *xfuncname_key, *word_regex_key, *ipattern_key;
+	char *xfuncname_value, *word_regex_value, *word_regex, *name;
+	struct userdiff_driver *builtin_driver;
+	char word_regex_extra[] = "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+";
+	userdiff_config_init();
+	name = (char *) malloc(len + 1);
+	memcpy(name, k, len);
+	name[len] = '\0';
+
+	// look up builtin_driver
+	for (i = 0; i < builtin_drivers_size; i++) {
+		struct userdiff_driver *drv = builtin_drivers + i;
+		if (!strncmp(drv->name, name, len) && !drv->name[len])
+			return drv;
+	}
+
+	// if .git/userdiff does not exist and name is not "default", return NULL
+	if (config_init == -1) {
+		return NULL;
+	}
+
+	// load xfuncname and wordRegex from userdiff config file
+	key_length = len + 16;
+	xfuncname_key = (char *) malloc(key_length);
+	word_regex_key = (char *) malloc(key_length);
+	ipattern_key = (char *) malloc(key_length - 1);
+	snprintf(xfuncname_key, key_length, "diff.%s.xfuncname", name);
+	snprintf(word_regex_key, key_length, "diff.%s.wordRegex", name);
+	snprintf(ipattern_key, key_length - 1, "diff.%s.regIcase", name);
+
+	xfuncname_value = join_strings(git_configset_get_value_multi(&gm_config, xfuncname_key));
+	word_regex_value = join_strings(git_configset_get_value_multi(&gm_config, word_regex_key));
+
+	ret = git_configset_get_bool(&gm_config, ipattern_key, &reg_icase);
+	// if "regIcase" is not found, do not use REG_ICASE flag
+	if (ret == 1)
+		reg_icase = 0;
+	cflags = reg_icase ? REG_EXTENDED | REG_ICASE : REG_EXTENDED;
+
+	free(xfuncname_key);
+	free(word_regex_key);
+	free(ipattern_key);
+
+	if (!xfuncname_value || !word_regex_value)
+		return NULL;
+
+	word_regex_size = strlen(word_regex_value) + strlen(word_regex_extra) + 1;
+	word_regex = (char *) malloc(word_regex_size);
+	snprintf(word_regex, word_regex_size,
+			"%s%s", word_regex_value, word_regex_extra);
+
+	builtin_drivers_size++;
+	builtin_drivers = realloc(builtin_drivers, builtin_drivers_size * sizeof(struct userdiff_driver));
+	builtin_driver = builtin_drivers + builtin_drivers_size - 1;
+	*builtin_driver = (struct userdiff_driver) {
+			name, NULL, -1, { xfuncname_value, cflags }, word_regex };
+	return builtin_driver;
+}
 
 static struct userdiff_driver driver_true = {
 	"diff=true",
@@ -197,12 +140,7 @@ static struct userdiff_driver *userdiff_find_by_namelen(const char *k, int len)
 		if (!strncmp(drv->name, k, len) && !drv->name[len])
 			return drv;
 	}
-	for (i = 0; i < ARRAY_SIZE(builtin_drivers); i++) {
-		struct userdiff_driver *drv = builtin_drivers + i;
-		if (!strncmp(drv->name, k, len) && !drv->name[len])
-			return drv;
-	}
-	return NULL;
+	return userdiff_find_builtin_by_namelen(k, len);
 }
 
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
-- 
2.21.0 (Apple Git-120)

