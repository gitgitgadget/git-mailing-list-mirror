Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA371F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 11:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfACLnY (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 06:43:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53590 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfACLnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 06:43:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so29013403wmb.3
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 03:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3k5fYVHBJn3jIbXm3JaJL6VJ336Wljgd+xhCF6/SqE=;
        b=GTRWqjASdFDM+BUQ3HzJlck50J/nsvnSARrYDExGN6ZQcT3UTeQQRJcAG58JqaGc0A
         UZMkx4uzay93UmtX0CrSt/U6dhqUPDqq3iZUbwWp7T+JGtLyjrvc0zwGOehETn9Hfin0
         AZhfF8PV79EffcwJH7ofH2u/QihMSelqzejfEZigCm8yhH38ThvJlZxWXTIXsm1Lq9ae
         bCE8sCmUco/zaAeyvysQPuRnzTCbuLrSu0x1RYPpXTBdIpEGjwtcnZ7Oy0uow8RMds+K
         AVWAdYvhCqi0ZqX4Ufr4uPfcoqdq4DoN/Z19KrfdN8SSLzkLc1V+pPKpFH+oFEHRue1s
         Qrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3k5fYVHBJn3jIbXm3JaJL6VJ336Wljgd+xhCF6/SqE=;
        b=NrdfCZaKv9l0EDdvyVTalmVaLopMtNoNqcPdVpu16x7xF6cq0D5WMSjrNf4mK4QR8A
         oxyWTuObsLcNTkQ916sl9YC2UhaqPzHniAUjA6rRAeyLj+c6AIn7n67zigZlRLt0QO5N
         9momc9KDk2EgOwRtoegIEQbQ2o8NB9wEZ2FjaMbaTn5Oc4Orr2cVpE/RmAxjHCMlt1an
         ELVvYJHbhfX5d4rPCGmy/L9yrgWl/dDbmtNKhWgKSxF3ZjTMXMMpNqWGge2IMOATb56W
         U5cBqiCqkbQywTPlXq6zE6KJbwC8TqZE1CUfXbiAr98sAkKKCBpn6ejye5tNG+P5J3fF
         5uQQ==
X-Gm-Message-State: AA+aEWbV6YOq4a91Wn/WmVNicOAHrxUi3j7vG3P/oV88Sfs+nIkls5F4
        ULXYKYcLS0ulzrFHeJYDfEnrQK28
X-Google-Smtp-Source: AFSGD/VdJQPsgLDHtxUEY7q0qy7Kn2ixi1s2VDq8OM1FufKOrM2afHuVN9m620nB6CeT8vldxOsigQ==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr40733339wmg.48.1546515800635;
        Thu, 03 Jan 2019 03:43:20 -0800 (PST)
Received: from localhost.localdomain (94-21-23-250.pool.digikabel.hu. [94.21.23.250])
        by smtp.gmail.com with ESMTPSA id v133sm41170394wmf.19.2019.01.03.03.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 03:43:19 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Max Kirillov <max@max630.net>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] test-lib: check Bash version for '-x' without using shell arrays
Date:   Thu,  3 Jan 2019 12:43:17 +0100
Message-Id: <20190103114317.11523-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
References: <xmqqa7kjknwp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of our test scripts, 't1510-repo-setup.sh' [1], still can't be
reliably run with '-x' tracing enabled, unless it's executed with a
Bash version supporting BASH_XTRACEFD (since v4.1).  We have a lengthy
condition to check the version of the shell running the test script,
and disable tracing if it's not executed with a suitable Bash version
[2].

This condition uses non-portable shell array accesses to easily get
Bash's major and minor version number.  This didn't seem to be
problematic, because the simple commands expanding those array
accesses are only executed when the test script is actually run with
Bash.  When run with Dash, the only shell I have at hand that doesn't
support shell arrays, there are no issues, as it apparently skips
right over the non-executed simple commands without noticing the
non-supported constructs.

Alas, it has been reported that NetBSD's /bin/sh does complain about
them:

  ./test-lib.sh: 327: Syntax error: Bad substitution

where line 327 contains the first ${BASH_VERSINFO[0]} array access.

To my understanding both shells are right and conform to POSIX,
because the standard allows both behaviors by stating the following
under '2.8.1 Consequences of Shell Errors' [3]:

  "An expansion error is one that occurs when the shell expansions
  define in wordexp are carried out (for example, "${x!y}", because
  '!' is not a valid operator); an implementation may treat these as
  syntax errors if it is able to detect them during tokenization,
  rather than during expansion."

Avoid this issue with NetBSD's /bin/sh (and potentially with other,
less common shells) by hiding the shell array syntax behind 'eval'
that is only executed with Bash.

[1] 5827506928 (t1510-repo-setup: mark as untraceable with '-x',
    2018-02-24)
[2] 5fc98e79fc (t: add means to disable '-x' tracing for individual
    test scripts, 2018-02-24)
[3] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_01

Reported-by: Max Kirillov <max@max630.net>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Changes since v1:

 - Hide the shell array syntax behind 'eval'.
   (I'm fine with both versions, take your pick.)
 - Corrected typo in commit message that Eric pointed out.
 - Added a link to the relevant section in POSIX.

 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0f1faa24b2..c34831a4de 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -323,12 +323,12 @@ do
 		# this test is marked as such, and ignore '-x' if it
 		# isn't executed with a suitable Bash version.
 		if test -z "$test_untraceable" || {
-		     test -n "$BASH_VERSION" && {
+		     test -n "$BASH_VERSION" && eval '
 		       test ${BASH_VERSINFO[0]} -gt 4 || {
 			 test ${BASH_VERSINFO[0]} -eq 4 &&
 			 test ${BASH_VERSINFO[1]} -ge 1
 		       }
-		     }
+		     '
 		   }
 		then
 			trace=t
-- 
2.20.1.151.gec613c4b75

