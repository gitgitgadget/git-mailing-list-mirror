Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709451F453
	for <e@80x24.org>; Fri, 21 Sep 2018 01:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbeIUHaQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 03:30:16 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:56578 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388868AbeIUHaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 03:30:16 -0400
Received: by mail-qk1-f201.google.com with SMTP id v65-v6so9418924qka.23
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 18:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VQimIdG5xD6KlZPhDqknJpYIETASC9Buquo4jns5Vzg=;
        b=lv4wVOzYWrKHW8ljBPUdb/Xq0NbqAqkl60fK8Ec71o0xDE9oS5hWgcOS/nUZUyozYs
         f8DHZMbm2H9MXAS2e6sJeXa7RtpuW72Ovcz7hvTqO22gcwW+I7i5WBWxD9YVPK4AOzLT
         witdcyvR1sycbZ1F7XY8e+DkdpQYCfKe+1s+Etz56q8eBWRWxxkhL+E4dqjk/LyCa4rV
         3lFyT3ZUyEXOAJG9MP1GkP0rJ4qCKPIpiiLU2RggpmYx1xAF8z3A91kvZQ/8t26NUX7y
         9dO43pzTTBjS7R/ZFO0EdPws2hMVB/QKT9HOwSvj0KYsUoL+KEavqxft2XwQkJmIprPY
         G3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VQimIdG5xD6KlZPhDqknJpYIETASC9Buquo4jns5Vzg=;
        b=FycMoUgntPyxM3jm8vy3yKJhpRDOtHUgqpcHHMv5rlAxA3vWQBGyhrVsThT08ee7LM
         laExP4QMom9MOCXQz6rMZ6Xl+LZW9hA5xaR5tq90nTrCj6oGUV6MfIEoP4iG0crxynVa
         vQiXCvODjk7y8tB7Qv4N1mNLmSZ0wD1S7kz6InJW+oy01AJW0brjwMDamJ8895Rd0Ukr
         J0KKxO6rUHsIS69LyAyecvCBb4HRmmUpq/55QDWfZMyx6ynEvjyhhHDPNNR4NZYohVNO
         KRmKbYSwU8cBCiVxnD33p1j+dtpshUsVXo9E27grzrIJjLXFtyUhqTlYOL4+zuentANz
         OV9A==
X-Gm-Message-State: APzg51AFOH0I/MJerh6W9NohydMl++80AsMiC+vSdXjdcnHhf3GixVPy
        NifkoDRxbVSLLZ1zOtlj4DSEnuf+lewQ4JNhvUh0lIubwp9niYFnUgHgqAbeWvoxjUAoSoVsseA
        nUFoKnC0+WWb7CIxd190UNrVzjGfg/4Ime0mJo8igelyJkfqR45L135MsTyE=
X-Google-Smtp-Source: ANB0VdawVK6FzWoYtTIQxAs+DWEN6vEx3cqN2nnhu9Ku26QfUIW0iJRv6Izn30GHYLU1LPU4yoOBS3ptCc1m
X-Received: by 2002:a0c:e7c2:: with SMTP id c2-v6mr14361893qvo.10.1537494230777;
 Thu, 20 Sep 2018 18:43:50 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:43:27 -0700
In-Reply-To: <cover.1537493611.git.matvore@google.com>
Message-Id: <7dd9a1120726dee34aeebdfa4bf45a232c185500.1537493611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537493611.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v3 1/5] CodingGuidelines: add shell piping guidelines
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two guidelines:

 - pipe characters should appear at the end of lines, and not cause
   indentation
 - pipes should be avoided when they swallow exit codes that can
   potentially fail
---
 Documentation/CodingGuidelines | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfb..6d265327c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
 		do this
 	fi
 
+ - If a command sequence joined with && or || or | spans multiple
+   lines, put each command on a separate line and put && and || and |
+   operators at the end of each line, rather than the start. This
+   means you don't need to use \ to join lines, since the above
+   operators imply the sequence isn't finished.
+
+	(incorrect)
+	grep blob verify_pack_result \
+	| awk -f print_1.awk \
+	| sort >actual &&
+	...
+
+	(correct)
+	grep blob verify_pack_result |
+	awk -f print_1.awk |
+	sort >actual &&
+	...
+
  - We prefer "test" over "[ ... ]".
 
  - We do not write the noiseword "function" in front of shell
@@ -163,6 +181,15 @@ For shell scripts specifically (not exhaustive):
 
    does not have such a problem.
 
+ - In a piped chain such as "grep blob objects | sort", the exit codes
+   returned by processes besides the last are ignored. This means that
+   if git crashes at the beginning or middle of a chain, it may go
+   undetected. Prefer writing the output of that command to a
+   temporary file with '>' rather than pipe it.
+
+ - The $(git ...) construct also discards git's exit code, so if the
+   goal is to test that particular command, redirect its output to a
+   temporary file rather than wrap it with $( ).
 
 For C programs:
 
-- 
2.19.0.444.g18242da7ef-goog

