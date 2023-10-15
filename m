Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3501C20
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="bxbHnit9"
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1E5DD
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:43:07 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b67c84999so2243596eaf.3
        for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697341387; x=1697946187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgpirPUs1/aLlsdSbhL37G4kCfsWU4Sonlc+dqNu3Co=;
        b=bxbHnit9z3du/SNSg1NEQ+AX9/i8GzjJ3twj6JRsj+5gKv+UsAofln0/BUppOdWaiv
         +mb+AUNFoI7kGdkSMeXoR4GcbK0BLzvSIM+63dWFvPYcvJeJX4Wrv7WiXZYTRcdNVJvr
         +mMqJ9zaaurmaMr4L6n08VbhLw+jUPRRwgwTrCfvbLiwTCxnEkeq9NxREvGBfA/eg8d8
         GTxQN4O83zwUYX6YzUT0zYSgNcBwTwJnUrUqeM1753xVBcCy/S5kevimTU4ts2xJqAG4
         GWQUCSu2+KsGBTF8DWjGipCMfIRF47iKP1FtdwPtUORJzE8Jw/T+JtQfU21kx25ztI+4
         +kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697341387; x=1697946187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgpirPUs1/aLlsdSbhL37G4kCfsWU4Sonlc+dqNu3Co=;
        b=Kh3JBtYNB2zZVji4eYLoeHmqGVytGEw8lAB5Hz0ZQpIFIs/OGp9oqM2TbOJsMbWNci
         D7nmE+Gi8biv+Tofeeg46ky/qqkrhHfQnHW7OKobUlvMdN0YF7MwikkisnRTxbWzG1ks
         /VWpDITynly6AgBRK81V4fLTQ+AfCJ0k073iw9etJM/NVOZey+z4fX77HgXjIbxRpvpQ
         IQShjdoaKWZoqAb3Y+Mw8KV4bkv1nbvh6Cifvz8Tf9PGBO2WDpQ4JrqTotQ3SxhZLZqS
         Kc/fZTemuU40qx8bmM5X74tJ3+xmIcbldEeP8vEvLJtm/mlfqmz/2tUI+IP7rGbZNR3d
         YfWA==
X-Gm-Message-State: AOJu0YzQCCfZuu5yTefHp2y+4HGMONQCzi0KOM0ECzz1/qsO+4ByGTb0
	THCddOX8YlEZGZ+H6yOIhR6I/JFjD+sZ6VXhp04=
X-Google-Smtp-Source: AGHT+IHJ4G7yV3EldxoLNAabx+ayulwtYrvfmp894QKlzkiwiTGpji8qoJEF/p8+KA7GoKmqsfDIvw==
X-Received: by 2002:a05:6358:52c5:b0:135:85ec:a080 with SMTP id z5-20020a05635852c500b0013585eca080mr38365343rwz.32.1697341386788;
        Sat, 14 Oct 2023 20:43:06 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id bq10-20020a056a02044a00b0059ce3d1def5sm510777pgb.45.2023.10.14.20.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 20:43:06 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH v2 1/3] bugreport: include +i in outfile suffix as needed
Date: Sat, 14 Oct 2023 20:42:35 -0700
Message-ID: <20231015034238.100675-2-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.298.gd89efca819.dirty
In-Reply-To: <20231015034238.100675-1-jacob@initialcommit.io>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <20231015034238.100675-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the -s flag is absent, git bugreport includes the current hour and
minute values in the default bugreport filename (and diagnostics zip
filename if --diagnose is supplied).

If a user runs the bugreport command more than once within a calendar
minute, a filename conflict with an existing file occurs and the program
errors, since the new output filename was already used for the previous
file. If the user waits anywhere from 1 to 60 seconds (depending on
_when during the calendar minute_ the first command was run) the command
works again with no error since the default filename is now unique, and
multiple bug reports are able to be created with default settings.

This is a minor thing but can cause confusion especially for first time
users of the bugreport command, who are likely to run it multiple times
in quick succession to learn how it works, (like I did).

Add a '+i' into the bugreport filename suffix to make the filename
unique, where 'i' is an integer starting at 1 and able to grow up to 9
in the unlikely event a user runs the command 9 times in a single
minute. This leads to default output filenames like:

git-bugreport-%Y-%m-%d-%H%M+1.txt
git-bugreport-%Y-%m-%d-%H%M+2.txt
...
git-bugreport-%Y-%m-%d-%H%M+9.txt

This means the user will end up with multiple bugreport files being
created if they run the command multiple times quickly, but that feels
more intuitive and consistent than an error arbitrarily occuring within
a calendar minute, especially given that the time window in which the
error currently occurs is variable as described above.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/bugreport.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..71ee7d7f4b 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -3,7 +3,6 @@
 #include "editor.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "strbuf.h"
 #include "help.h"
 #include "compat/compiler.h"
 #include "hook.h"
@@ -11,6 +10,7 @@
 #include "diagnose.h"
 #include "object-file.h"
 #include "setup.h"
+#include "dir.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -101,12 +101,13 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf report_path = STRBUF_INIT;
+	struct strbuf option_suffix = STRBUF_INIT;
+	struct strbuf default_option_suffix = STRBUF_INIT;
 	int report = -1;
 	time_t now = time(NULL);
 	struct tm tm;
 	enum diagnose_mode diagnose = DIAGNOSE_NONE;
 	char *option_output = NULL;
-	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
 	size_t output_path_len;
@@ -118,11 +119,14 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 			       PARSE_OPT_OPTARG, option_parse_diagnose),
 		OPT_STRING('o', "output-directory", &option_output, N_("path"),
 			   N_("specify a destination for the bugreport file(s)")),
-		OPT_STRING('s', "suffix", &option_suffix, N_("format"),
+		OPT_STRING('s', "suffix", &option_suffix.buf, N_("format"),
 			   N_("specify a strftime format suffix for the filename(s)")),
 		OPT_END()
 	};
 
+	strbuf_addstr(&default_option_suffix, "%Y-%m-%d-%H%M");
+	strbuf_addstr(&option_suffix, default_option_suffix.buf);
+
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
@@ -134,9 +138,20 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	output_path_len = report_path.len;
 
 	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	strbuf_addftime(&report_path, option_suffix.buf, localtime_r(&now, &tm), 0, 0);
 	strbuf_addstr(&report_path, ".txt");
 
+	if (strbuf_cmp(&option_suffix, &default_option_suffix) == 0) {
+		int i = 1;
+		int pos = report_path.len - 4;
+		while (file_exists(report_path.buf) && i < 10) {
+			if (i > 1)
+				strbuf_remove(&report_path, pos, 2);
+			strbuf_insertf(&report_path, pos, "+%d", i);
+			i++;
+		}
+	}
+
 	switch (safe_create_leading_directories(report_path.buf)) {
 	case SCLD_OK:
 	case SCLD_EXISTS:
@@ -151,7 +166,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		struct strbuf zip_path = STRBUF_INIT;
 		strbuf_add(&zip_path, report_path.buf, output_path_len);
 		strbuf_addstr(&zip_path, "git-diagnostics-");
-		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+		strbuf_addftime(&zip_path, option_suffix.buf, localtime_r(&now, &tm), 0, 0);
 		strbuf_addstr(&zip_path, ".zip");
 
 		if (create_diagnostics_archive(&zip_path, diagnose))
@@ -188,6 +203,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 
 	free(prefixed_filename);
 	strbuf_release(&buffer);
+	strbuf_release(&default_option_suffix);
 
 	ret = !!launch_editor(report_path.buf, NULL, NULL);
 	strbuf_release(&report_path);
-- 
2.42.0.298.gd89efca819.dirty

