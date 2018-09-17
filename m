Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571F91F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeIRDy3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:54:29 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49865 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbeIRDy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:54:29 -0400
Received: by mail-pl1-f202.google.com with SMTP id b6-v6so8310618pls.16
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tq+5eDyXTpqj2Y1KIL3XxtjpYr2WUJuF+yR07+VeAho=;
        b=BFQdiQENgBU+iNIq99q1IOWSYm94kZQf02FpGQ3OoW1RrkDMZFJP4t8jq9aTzkhR01
         2A7dfk5OCGFY0amQpC8tLi+T+L7QpnwJLS7q9wTeFKCYMe5qzjxR09AWTWAzrg1AFex3
         8Kaaora26rHOEQlVd2fJOj9gkMfMIUIecRLuNFMxAxLdxSCTBUeSTa7+an9JOeE3G5k6
         9KCz27EybrMUkebQywubkSFvqECJv6mMxrJM4dcWXddArY2j9oLPFa/J5oLv5iZyICnc
         OyUASxLtbHTJCSMyDNZcbwPGZ1zKOFXskLwKDCKlxfv5d2p2+OqUihT2CmIryYkeSxQ+
         dh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tq+5eDyXTpqj2Y1KIL3XxtjpYr2WUJuF+yR07+VeAho=;
        b=sbBZWoOEa2tRUDEd1SUz7z9yHbBHR8ls+MqJt3hsD44n/PcvIZDV+t7aqjDtt0NNLd
         HLI8Jc5HpyE/h45D7yPPklLN1MXt894lg4qLJoH9U6KyMRBf4Xqb/x91HdFfHJADfNSs
         bWPgHFXanlvN8R9wW1ewbFlaC8CBD976eacwZiJ/NZ4NmkNMWsVuLUVGwwwaB0DyQnbd
         b9VaRKtbnORQnNqlwIWUCypvgeS94x5/ZEa+I0daOF/4mBHGNl2EFsUZBhL5Le/H36OM
         us7dRYL0MHc9AlKLVY77YdqWTDHx7UhUgTFPPVbB534doA/0Sw/wtFan4KI+xEb0Sd6+
         FU6Q==
X-Gm-Message-State: APzg51AgFvEp5b36Ovb+2krpuffAoHBWIFMEpkfIS9AUEbBRTqKGRV+6
        doZI6PcCjmecVGpDpaUZB+W5TQOsBIgg/0E5AP3li/H0BzYtDQkuyVWHCyejeTkVGJmcTCOqxaC
        R03LIb+RlQWINvfjPmIq3Sa/lCFJkKI+F3Yr3x1KJhFO7dSXOg/pd2i8Jjfo=
X-Google-Smtp-Source: ANB0VdbL06Lt29besoR8bVEHpQj6+jSaHKd07VfPxVfkZfRpiPAkP4hw066+M31YDaTUL0Xt5Tr+B8Ppt9Hh
X-Received: by 2002:a63:7b44:: with SMTP id k4-v6mr1225526pgn.77.1537223110403;
 Mon, 17 Sep 2018 15:25:10 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:24:21 -0700
In-Reply-To: <cover.1537223021.git.matvore@google.com>
Message-Id: <e4b548c65e93e5de70e043114a9a54bdc25160d4.1537223021.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 4/6] tests: add linter check for pipe placement style
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

