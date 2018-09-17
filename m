Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD07B1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeIRDy1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:54:27 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:44578 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeIRDy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:54:27 -0400
Received: by mail-io1-f73.google.com with SMTP id s15-v6so20010761iob.11
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tq+5eDyXTpqj2Y1KIL3XxtjpYr2WUJuF+yR07+VeAho=;
        b=OQxei+FN1NGFXS+cRddCTpca6kwCKgHxItkWJHQJHrSHRAkrSDnxvNzO3RHvxrVTbp
         MvJ3KGhYIUdEUPJ1xOIxoIfXto65sPMugpVrRwBSk7I/7SO+/DQMUB3taM3DJkpm3fVQ
         J5BaZMj+3D1SElrw9ocg64N4FnTMlsXfOCV7S/wzRGV7lGe0nD/tM0dbX3MY69QWsLZc
         +Ip5V5PsiCkTIOo1cB4kf8o5hnMGBqGtmpqXiHSA3Uh6BBEpqTEn+7CRDsBXZoGJvDKP
         rydBg1lJLACkAU77xO7loI0w/qYvJv7jeNEnqJa5JqHjKM7RXychSfYRI32IvaeOWWJu
         BmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tq+5eDyXTpqj2Y1KIL3XxtjpYr2WUJuF+yR07+VeAho=;
        b=U3b4Ey+wGfyDbLkeEQ3fJJkDU+BKQTeXdY9TVMujvTYg9/ieBENP+ia2fnynZoKbic
         kc5Btf4XKD9/+4qS22DJhhqR892T3PPDHQBUa6E9Jo9ha6tfKG0toTxlU1z52JCcIDa9
         cP1PnoMlZbeACgyujI2Z7Nbq0K9ecMLUBqKNsC1I5qV2TguBkNby187hpxYxYE8HSUy3
         4T8T3iel2gxp1CAKt8AbNpzhAEzv+Yl21jFoin9kHCV/EyR9PhXbn3qOD7DyFoXByAIM
         bvsZMVuP9b7xwD7xnFf0C35+DNnrJNzAeSHpeTk9WrcxqNb5LtpEAwshJzkHuM3BUUsd
         L9tQ==
X-Gm-Message-State: APzg51DVVQNmVJb+F6PQ7TeqS4hNICkBhLeQJf/625uNoM7Fyqtu0n0Y
        /HKmEv1sl86CVfoSdkc/Hoq0TIqFvl+RSnGVX8Ud29fAokrMGckyCbiI57tQWf89tPMRXxEIzaG
        q3P5MpmeN3JP9Oy1om8O3Q7ulj7/Tadwpvl4U7bzsO2K11J433Bwxeh/wBMg=
X-Google-Smtp-Source: ANB0VdYcMUgyV846qlH3YgXjpEwDOp0VYEIRxC2zuDwhuwxlITSgz/0CGqjyoeAQMkIkX1fJ1I41SXN4gIb3
X-Received: by 2002:a24:d917:: with SMTP id p23-v6mr5014982itg.35.1537223108394;
 Mon, 17 Sep 2018 15:25:08 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:24:20 -0700
In-Reply-To: <cover.1537222670.git.matvore@google.com>
Message-Id: <44ee2bd27b510d4216525e24aa1734a1f5edbd95.1537222670.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537222670.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 4/6] tests: Add linter check for pipe placement style
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index c83fd1886..4eceabbd5 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -78,7 +78,7 @@ check-chainlint:
 	done && exit $$err
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
-	test-lint-filenames
+	test-lint-filenames test-lint-pipes
 
 test-lint-duplicates:
 	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
@@ -101,6 +101,16 @@ test-lint-filenames:
 		test -z "$$bad" || { \
 		echo >&2 "non-portable file name(s): $$bad"; exit 1; }
 
+test-lint-pipes:
+	@# Do not use \ to join lines when the next line starts with a
+	@# pipe. Instead, end the prior line with the pipe, and allow that to
+	@# join the lines implicitly.
+	@bad="$$(${PERL_PATH} -n0e 'm/(\n[^\n|]+\\\n[\t ]+\|[^\n]*)/ and \
+	      print qq{$$ARGV:$$1\n\n}' $(T))"; \
+		test -z "$$bad" || { \
+		printf >&2 "pipe at start of line in file(s):\n%s\n" "$$bad"; \
+		exit 1; }
+
 aggregate-results-and-cleanup: $(T)
 	$(MAKE) aggregate-results
 	$(MAKE) clean
-- 
2.19.0.444.g18242da7ef-goog

