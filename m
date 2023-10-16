Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210F37CA9
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="nVm75ayQ"
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C200FA2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:41:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1395379b3a.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697492465; x=1698097265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCX2AS2VHuFbyaf/eiNqvbjxuzwuJfGZx94YH+A2mew=;
        b=nVm75ayQd0KkwUy7blDKl/1Jk0WWDDPHV0D7zYauFPb5pY9zEiWn69zWxdMES6vNUv
         H6JfVxc0FiA5+5AwVrp5EwlNvQ+l5t0gDrtuuZQpDd4N4ekOng8mXNEJvS+SPoJE/R1K
         FAcsoE3QDMzMTqQJG4ANwhyZyygmuJFAk46L5ofoDV4+dH/lk0ytHewRc/M/wpUlVcfr
         JMp7zqWsLqDAL40PNBLVmVR1X3MR4QDapnPECdq7ppDLPfEI+R+9VzImxqC2M78pQh2L
         RCBMcaJLTPfVx1Zz9NcgRGsG3LlMqRD2EXNoX9A6sElgLmTZa9xKN2b/kGeYQ+NttqmB
         mY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697492465; x=1698097265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCX2AS2VHuFbyaf/eiNqvbjxuzwuJfGZx94YH+A2mew=;
        b=d4nipn35qBPYX4JXrtjl14pdQ3DW/rZ5XnAb9s0X0avDhcnHqvJP/BFwCUKlABrPaN
         9GeghfaY5Fa3YWA5pHz2n5/ODVeuL8F2QY0067GuE0nBrjSb8GF1WBTTbxVaI0Cdu5Um
         8cQFVJCEFIUlyCTlDvI9qpQqLCqtGUNcYHn2lnVSpB5jMe+kkzEyLVugpb0R+WOYZLRb
         Iz0SPYE38kdUxvFfpUEVk6du1BlhmffkCqwWq93DCXwmIUf1OXP1Oox8/msIy64UxRWu
         w4ogqQKu4KfHRxqLLrsEEPVZw+eRiL3OnFUwi0M4wYjWYNkaX6UCS2WHK3sacN508WpD
         lCZw==
X-Gm-Message-State: AOJu0YzyfgnQCo9EhgPmuanZgPvGfxM99sTdHMs47HasR0PdUyxhxt+z
	mA6bkf/6bP1j/o+KC0lEOdivDFUGGeBimAhn55I=
X-Google-Smtp-Source: AGHT+IFwLUptQl6Xl+6aeAj0BKUAAcXe9ioHUIMbpmNRRmKcFjlVAnIKFFy2fpWQukZ4Sjnr1aEpxg==
X-Received: by 2002:a05:6a00:1749:b0:68b:a137:373d with SMTP id j9-20020a056a00174900b0068ba137373dmr50096pfc.17.1697492465033;
        Mon, 16 Oct 2023 14:41:05 -0700 (PDT)
Received: from localhost.localdomain (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id x1-20020aa78f01000000b0068ffd56f705sm34574pfr.118.2023.10.16.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:41:04 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
Date: Mon, 16 Oct 2023 14:40:45 -0700
Message-ID: <20231016214045.146862-2-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.297.g36452639b8
In-Reply-To: <20231016214045.146862-1-jacob@initialcommit.io>
References: <20231015034238.100675-2-jacob@initialcommit.io>
 <20231016214045.146862-1-jacob@initialcommit.io>
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

If a user runs the bugreport command more than once within a minute, a
filename conflict with an existing file occurs and the program errors,
since the new output filename was already used for the previous file. If
the user waits anywhere from 1 to 60 seconds (depending on when during
the minute the first command was run) the command works again with no
error since the default filename is now unique, and multiple bug reports
are able to be created with default settings.

This is a minor thing but can cause confusion for first time users of
the bugreport command, who are likely to run it multiple times in quick
succession to learn how it works, (like I did). Or users who quickly
fill in a few details before closing and creating a new one.

Add a '+i' into the bugreport filename suffix where 'i' is an integer
starting at 1 and growing as needed until a unique filename is obtained.

This leads to default output filenames like:

git-bugreport-%Y-%m-%d-%H%M+1.txt
git-bugreport-%Y-%m-%d-%H%M+2.txt
...
git-bugreport-%Y-%m-%d-%H%M+i.txt

This means the user will end up with multiple bugreport files being
created if they run the command multiple times quickly, but that feels
more intuitive and consistent than an error arbitrarily occuring within
a minute, especially given that the time window in which the error
currently occurs is variable as described above.

If --diagnose is supplied, match the incremented suffix of the
diagnostics zip file to the bugreport.

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/bugreport.c | 83 +++++++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index d2ae5c305d..ed65735873 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -11,6 +11,7 @@
 #include "diagnose.h"
 #include "object-file.h"
 #include "setup.h"
+#include "dir.h"
 
 static void get_system_info(struct strbuf *sys_info)
 {
@@ -97,20 +98,41 @@ static void get_header(struct strbuf *buf, const char *title)
 	strbuf_addf(buf, "\n\n[%s]\n", title);
 }
 
+static void build_path(struct strbuf *buf, const char *dir_path,
+		       const char *prefix, const char *suffix,
+		       time_t t, int *i, const char *ext)
+{
+	struct tm tm;
+
+	strbuf_reset(buf);
+	strbuf_addstr(buf, dir_path);
+	strbuf_complete(buf, '/');
+
+	strbuf_addstr(buf, prefix);
+	strbuf_addftime(buf, suffix, localtime_r(&t, &tm), 0, 0);
+
+	if (*i > 0)
+		strbuf_addf(buf, "+%d", *i);
+
+	strbuf_addstr(buf, ext);
+
+	(*i)++;
+}
+
 int cmd_bugreport(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf report_path = STRBUF_INIT;
 	int report = -1;
 	time_t now = time(NULL);
-	struct tm tm;
 	enum diagnose_mode diagnose = DIAGNOSE_NONE;
 	char *option_output = NULL;
-	char *option_suffix = "%Y-%m-%d-%H%M";
+	char *option_suffix = "";
+	int option_suffix_is_from_user = 0;
 	const char *user_relative_path = NULL;
 	char *prefixed_filename;
-	size_t output_path_len;
 	int ret;
+	int i = 0;
 
 	const struct option bugreport_options[] = {
 		OPT_CALLBACK_F(0, "diagnose", &diagnose, N_("mode"),
@@ -126,16 +148,16 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, bugreport_options,
 			     bugreport_usage, 0);
 
+	if (!strlen(option_suffix))
+		option_suffix = "%Y-%m-%d-%H%M";
+	else
+		option_suffix_is_from_user = 1;
+
 	/* Prepare the path to put the result */
 	prefixed_filename = prefix_filename(prefix,
 					    option_output ? option_output : "");
-	strbuf_addstr(&report_path, prefixed_filename);
-	strbuf_complete(&report_path, '/');
-	output_path_len = report_path.len;
-
-	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
-	strbuf_addstr(&report_path, ".txt");
+	build_path(&report_path, prefixed_filename, "git-bugreport-",
+		   option_suffix, now, &i, ".txt");
 
 	switch (safe_create_leading_directories(report_path.buf)) {
 	case SCLD_OK:
@@ -146,20 +168,6 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 		    report_path.buf);
 	}
 
-	/* Prepare diagnostics, if requested */
-	if (diagnose != DIAGNOSE_NONE) {
-		struct strbuf zip_path = STRBUF_INIT;
-		strbuf_add(&zip_path, report_path.buf, output_path_len);
-		strbuf_addstr(&zip_path, "git-diagnostics-");
-		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
-		strbuf_addstr(&zip_path, ".zip");
-
-		if (create_diagnostics_archive(&zip_path, diagnose))
-			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
-
-		strbuf_release(&zip_path);
-	}
-
 	/* Prepare the report contents */
 	get_bug_template(&buffer);
 
@@ -169,14 +177,37 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	get_header(&buffer, _("Enabled Hooks"));
 	get_populated_hooks(&buffer, !startup_info->have_repository);
 
-	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
-	report = xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	again:
+		/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
+		report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
+		if (report < 0 && errno == EEXIST && !option_suffix_is_from_user) {
+			build_path(&report_path, prefixed_filename,
+				   "git-bugreport-", option_suffix, now, &i,
+				   ".txt");
+			goto again;
+		} else if (report < 0) {
+			die_errno(_("unable to open '%s'"), report_path.buf);
+		}
 
 	if (write_in_full(report, buffer.buf, buffer.len) < 0)
 		die_errno(_("unable to write to %s"), report_path.buf);
 
 	close(report);
 
+	/* Prepare diagnostics, if requested */
+	if (diagnose != DIAGNOSE_NONE) {
+		struct strbuf zip_path = STRBUF_INIT;
+		i--; /* Undo last increment to match zipfile suffix to bugreport */
+		build_path(&zip_path, prefixed_filename, "git-diagnostics-",
+			   option_suffix, now, &i, ".zip");
+
+		if (create_diagnostics_archive(&zip_path, diagnose))
+			die_errno(_("unable to create diagnostics archive %s"),
+				  zip_path.buf);
+
+		strbuf_release(&zip_path);
+	}
+
 	/*
 	 * We want to print the path relative to the user, but we still need the
 	 * path relative to us to give to the editor.
-- 
2.42.0.297.g36452639b8

