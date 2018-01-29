Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC861FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeA2WjH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:07 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:53558 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeA2WjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:39:05 -0500
Received: by mail-oi0-f74.google.com with SMTP id 24so409614oir.20
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=N7VczO8HRz4HLQGaXYdTM1T8/i3ZB18jFfPdfWaQiBU=;
        b=XHymRte5nf0T7KX/8Em2gHvG5xUAPw+Mejv7bvIt31OXB5QnII1NPoqQptI5orG5Ps
         /EveXE2tflr7EjVdkaSJtodRMM8GeGNb/DhynfbH4c9N9DN53LhUnRPmKLFJSM/7Bxza
         KOjvuXY6EDexcf1oMZO8xJIzAhNVK9/YI1QXnchU7pvioQBE7wVGb+f+oDEGmAtZOPXz
         2C7Hwt5gQh2+Xh5XSuO7iu7kBx55hEzxWobaMiTOlt86aYnZyO8qg9HOirJkT55C1tcW
         DztEiLcFUVKwk7AaAL0nwYKAgqCDCwlCjLIHPmX2jr8VYL4TwU8bMKnvJQNVtIbQZN6+
         y9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=N7VczO8HRz4HLQGaXYdTM1T8/i3ZB18jFfPdfWaQiBU=;
        b=NQ1Booiljio1M/oKRqmy3AAUpxUzFdNBwARXPj/+29zblgUZHW/E2BuOvu8EYpv9c6
         CS7AaTnpKzlm/07/fzGBVLB3wEGUsEv/k8XePNZECxQH8swqGDEht9zl4/Fe5SQd9Lna
         7GwbkLrf89+yoCx1c6BzVZLTj5pcvCWiJu0imwGQzBAsj/Y50PAY7m3cfNBY/MExJRBM
         t3jDeaXo0OaftSfp9stKd/xAIffcNIJ3ZyxG2FxqzHIwT5RPFZ3g9xUk/jIkpjrGACi4
         5r4vMZeqCPGdjIXzIE508foaqKHr6zECcpbMAu3i7QhgRlZsxXMhEq+OShC7tOpNyOVV
         tXHg==
X-Gm-Message-State: AKwxytdTU25wLJqTAva0qs5/s/1mdIP5s9nMABMUuI6oEU3QzGAYx/fd
        mC1f5jAMNT2OZHL3PU/R3z/G6T54fi25cwISZMXKMlcyCIHW4KOr2c1zs33N6DDlhbxhPqRoBhT
        pwO02yXgOMmPu0RT3wUgWAXpLuJfF7B3Jq2ajnTiBby8pyjlog7UfX4jZHA==
X-Google-Smtp-Source: AH8x224quepJfKoY5+nW6dmcNmadhFxMLhtpOIHgczMqlcd3hvbYZh96G2qUr1X8pn6ffj0zPHONi6Qia6U=
MIME-Version: 1.0
X-Received: by 10.202.228.143 with SMTP id b137mr16136975oih.14.1517265544972;
 Mon, 29 Jan 2018 14:39:04 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:27 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-37-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 36/37] trailer: rename 'template' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 trailer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/trailer.c b/trailer.c
index 5a4a2ecf9..c508c9b75 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1000,7 +1000,7 @@ static struct tempfile *trailers_tempfile;
 static FILE *create_in_place_tempfile(const char *file)
 {
 	struct stat st;
-	struct strbuf template = STRBUF_INIT;
+	struct strbuf filename_template = STRBUF_INIT;
 	const char *tail;
 	FILE *outfile;
 
@@ -1014,11 +1014,11 @@ static FILE *create_in_place_tempfile(const char *file)
 	/* Create temporary file in the same directory as the original */
 	tail = strrchr(file, '/');
 	if (tail != NULL)
-		strbuf_add(&template, file, tail - file + 1);
-	strbuf_addstr(&template, "git-interpret-trailers-XXXXXX");
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
 
-	trailers_tempfile = xmks_tempfile_m(template.buf, st.st_mode);
-	strbuf_release(&template);
+	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	strbuf_release(&filename_template);
 	outfile = fdopen_tempfile(trailers_tempfile, "w");
 	if (!outfile)
 		die_errno(_("could not open temporary file"));
-- 
2.16.0.rc1.238.g530d649a79-goog

