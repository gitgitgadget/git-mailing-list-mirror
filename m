Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F54320248
	for <e@80x24.org>; Fri,  5 Apr 2019 00:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDEAqd (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 20:46:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDEAqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 20:46:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so5880282wra.12
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 17:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpG8/SqlNIuL0ilOOBykgSCG6GJh9mlHSO1IDUXjwec=;
        b=KHVw4r2FRcQY1jpA6owNr+LXWHxvI5fywxpxzy1my68Jp1n3Bppb+E115rmD6T0p/8
         kz3RRNtBIP58rmSRQPzMmkL9JqPfWyzoECHY+7FABX4e24du7fi/kEeHyggUZ3KFXy9Z
         2AemMuynnaMwynduvQU0512kxTGUnildlbxm+v/uVoctuR0ZDonzlkXEab0W/k2Ps/an
         V2MphuzEX7/tisuW0ZfClZ2+F3cvdAky7mmC/6mi2hHlfuq1poKCh40PxBK2qLm2lThQ
         aOpHh1XoaXqgTMfZOXZnTHtY6vy/2coJXA7AJIizMOIxi0MuPVlNZvqfaHEq0WbWAERf
         ZXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpG8/SqlNIuL0ilOOBykgSCG6GJh9mlHSO1IDUXjwec=;
        b=dCy3pycAqJFtDlJD3TP4TrTYDi+OxnSxqHA+YGdn4Tf+7jH6UXr6X0LY2SMz5v9CdC
         kHq9T5hJvuT5uJgscgsqf78t14Cug57I8FXnQ58OdPGkQfBI8BBcjo/uUHMWkbroVqcq
         BEueV3StZcFkZZtJxMVEkMhyALl7hWn1VtiIkdPxRbH3qQs9FQ3DPCXZHrNvhhH4nkyB
         kg80za9WWKGx8D6NPySjQXwPWChavDNlQfYbKnvXz+xiwegYyQWpSkXM83osodjVbq19
         ZfH3dNmdiMUyHLCtseiGZtc2GdaqZKVJjMhhFH8S4xvVNId2VAb82e2qTtEGzt0qRsLc
         kzFA==
X-Gm-Message-State: APjAAAVungOwoDCZ3iveFX6dVGS8fslsfwYkdiLRsGo3xwvs3NfcNNg3
        pU+BX+uzEZFkG9ZqlDIZt6U=
X-Google-Smtp-Source: APXvYqwDrj2OhCWrMlz2uMQLYtBXkMYuSVGatKi/SEVJyRJFsA2cBOa+SmZJyFHspmFs2UHf5oAang==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr6034688wrn.193.1554425190777;
        Thu, 04 Apr 2019 17:46:30 -0700 (PDT)
Received: from localhost.localdomain (x4db96230.dyn.telefonica.de. [77.185.98.48])
        by smtp.gmail.com with ESMTPSA id d17sm28137301wrw.88.2019.04.04.17.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 17:46:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/4] Progress display fixes
Date:   Fri,  5 Apr 2019 02:45:35 +0200
Message-Id: <20190405004539.31467-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190401115217.3423-1-szeder.dev@gmail.com>
References: <20190401115217.3423-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series fixes two progress display issues by breaking
progress bars longer than the width of the terminal and by properly
cleaning up the previously shown progress bar.

Changes since v2, following Eric's and Peff's suggestions:

  - Remove return statements that just became unnecessary in patch
    1/4.

  - Use size_t helper variables to store intermediate results of
    calculations based on length of strings.

SZEDER Gábor (4):
  progress: make display_progress() return void
  progress: assemble percentage and counters in a strbuf before printing
  progress: clear previous progress update dynamically
  progress: break too long progress bar lines

 progress.c | 73 ++++++++++++++++++++++++++++++++++++++----------------
 progress.h |  2 +-
 2 files changed, 53 insertions(+), 22 deletions(-)

Interdiff:
diff --git a/progress.c b/progress.c
index e28ccdafd2..97e18671e5 100644
--- a/progress.c
+++ b/progress.c
@@ -115,32 +115,30 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 	if (show_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
 			const char *eol = done ? done : "\r";
-			int clear_len = counters_sb->len < last_count_len ?
+			size_t clear_len = counters_sb->len < last_count_len ?
 					last_count_len - counters_sb->len : 0;
-			int progress_line_len = progress->title_len +
+			size_t progress_line_len = progress->title_len +
 						counters_sb->len + 2;
 			int cols = term_columns();
 
 			if (progress->split) {
 				fprintf(stderr, "  %s%-*s", counters_sb->buf,
-					clear_len, eol);
+					(int) clear_len, eol);
 			} else if (!done && cols < progress_line_len) {
 				clear_len = progress->title_len + 1 < cols ?
 					    cols - progress->title_len - 1 : 0;
 				fprintf(stderr, "%s:%*s\n  %s%s",
-					progress->title, clear_len, "",
+					progress->title, (int) clear_len, "",
 					counters_sb->buf, eol);
 				progress->split = 1;
 			} else {
 				fprintf(stderr, "%s: %s%-*s", progress->title,
-					counters_sb->buf, clear_len, eol);
+					counters_sb->buf, (int) clear_len, eol);
 			}
 			fflush(stderr);
 		}
 		progress_update = 0;
 	}
-
-	return;
 }
 
 static void throughput_string(struct strbuf *buf, uint64_t total,
Range-diff:
1:  dea36bd2a7 ! 1:  cb68e5b0ec progress: make display_progress() return void
    @@ -18,7 +18,9 @@
         its introduction in cf84d51c43 (add throughput to progress display,
         2007-10-30).
     
    -    Let's make display_progress() return void, too.
    +    Let's make display_progress() return void, too.  While doing so
    +    several return statements in display() become unnecessary, remove
    +    them.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
    @@ -45,7 +47,6 @@
      			}
      			progress_update = 0;
     -			return 1;
    -+			return;
      		}
      	} else if (progress_update) {
      		if (is_foreground_fd(fileno(stderr)) || done) {
    @@ -54,11 +55,9 @@
      		}
      		progress_update = 0;
     -		return 1;
    -+		return;
      	}
    - 
    +-
     -	return 0;
    -+	return;
      }
      
      static void throughput_string(struct strbuf *buf, uint64_t total,
2:  97de2a98a0 ! 2:  017d095142 progress: assemble percentage and counters in a strbuf before printing
    @@ -50,7 +50,6 @@
     -				fflush(stderr);
     -			}
     -			progress_update = 0;
    --			return;
     +
     +			strbuf_reset(counters_sb);
     +			strbuf_addf(counters_sb,
    @@ -76,10 +75,6 @@
      			fflush(stderr);
      		}
      		progress_update = 0;
    --		return;
    - 	}
    - 
    - 	return;
     @@
      	progress->delay = delay;
      	progress->throughput = NULL;
3:  edfe0157a7 ! 3:  c5a4def5ac progress: clear previous progress update dynamically
    @@ -48,10 +48,10 @@
     -			fprintf(stderr, "%s: %s%s", progress->title,
     -				counters_sb->buf, eol);
     +			const char *eol = done ? done : "\r";
    -+			int clear_len = counters_sb->len < last_count_len ?
    ++			size_t clear_len = counters_sb->len < last_count_len ?
     +					last_count_len - counters_sb->len : 0;
     +			fprintf(stderr, "%s: %s%-*s", progress->title,
    -+				counters_sb->buf, clear_len, eol);
    ++				counters_sb->buf, (int) clear_len, eol);
      			fflush(stderr);
      		}
      		progress_update = 0;
4:  d53de231ee ! 4:  2f44dff84e progress: break too long progress bar lines
    @@ -70,27 +70,27 @@
      static volatile sig_atomic_t progress_update;
     @@
      			const char *eol = done ? done : "\r";
    - 			int clear_len = counters_sb->len < last_count_len ?
    + 			size_t clear_len = counters_sb->len < last_count_len ?
      					last_count_len - counters_sb->len : 0;
     -			fprintf(stderr, "%s: %s%-*s", progress->title,
    --				counters_sb->buf, clear_len, eol);
    -+			int progress_line_len = progress->title_len +
    +-				counters_sb->buf, (int) clear_len, eol);
    ++			size_t progress_line_len = progress->title_len +
     +						counters_sb->len + 2;
     +			int cols = term_columns();
     +
     +			if (progress->split) {
     +				fprintf(stderr, "  %s%-*s", counters_sb->buf,
    -+					clear_len, eol);
    ++					(int) clear_len, eol);
     +			} else if (!done && cols < progress_line_len) {
     +				clear_len = progress->title_len + 1 < cols ?
     +					    cols - progress->title_len - 1 : 0;
     +				fprintf(stderr, "%s:%*s\n  %s%s",
    -+					progress->title, clear_len, "",
    ++					progress->title, (int) clear_len, "",
     +					counters_sb->buf, eol);
     +				progress->split = 1;
     +			} else {
     +				fprintf(stderr, "%s: %s%-*s", progress->title,
    -+					counters_sb->buf, clear_len, eol);
    ++					counters_sb->buf, (int) clear_len, eol);
     +			}
      			fflush(stderr);
      		}
-- 
2.21.0.539.g07239c3a71.dirty

