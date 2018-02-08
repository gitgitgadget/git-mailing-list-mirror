Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F311F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752184AbeBHP5T (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52768 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeBHP5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id g1so10339863wmg.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dm6NJNnW17ZsiO4xLDSMi5zXhWetvWauHBJWcwtTH+M=;
        b=cWPbyWe+jJqIrr/sq9Ne8W3/tUib1WSmTkDmYhQ17Y7bHGgaZde92jS7F99IZ5oz+3
         UvhTlq95a0AkBjJmcIKMaec6dAjhxQkI/ZBhItRxfo7Uqr+ypjDy20BmWINPqkYyjppY
         CvB++IJFC6U2kuHLEwlbPg5KT87A/nchNxl3yOPM2ApGvuREZ+oM+8KvpjCUsardcjio
         kiXqcdj71ItvRAcH7oDPBrQ4VE6vTED62DnEUHcAxnqV6TMabTzNU3kpfILCwSw7Ug/H
         zSM+U5osEglmbtzSV851BaC9PaMy7gLhQbU0znK84x73HXCB+6pDdLgzrKWrw4QzNMd/
         BPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm6NJNnW17ZsiO4xLDSMi5zXhWetvWauHBJWcwtTH+M=;
        b=PC8Sa0DszaQHr1rcyJu0XCqrwb3bNU5q7OPDxKeGn+ETbhPMunQnQ7hgiOiirITF+K
         nxSHcU9/p0OEl7ATYH/3Rib/bWWFCLBBMOAsLdxUFwk4pDWu74gxcTBqLp8QtbdkAS0y
         X14XzT/fnb0P72axYFmSrvRMgOt0zUYTezBZ4IZJhlJAhpnLaoY6AtcSSJSr+166PoBW
         lOckZ9SmV9NArogUeCqsn2jv4XlAHiZ4/zdKw4L+LN0l22PV3Z9qsq02sH262+CKT66i
         /TyL2Xoy3GqjCZUwq31f6cTPmfHinieZKsLSeIqAZ6Jlvf5QVA3poP0FfCUUb3ioYPuo
         e7wA==
X-Gm-Message-State: APf1xPCTuFqKzoElOj+VRLr/e0idk7d5JoaGo5+jSrbBkV2nB5KxuA62
        gfWJktlN/Q1Oypo4boKBktHO9oZu
X-Google-Smtp-Source: AH8x224cRla8DE4XmRuJZpXTEa/evOvY7uyGVcJlG6CxM4FpIUi1Dp+0umyG3wEBxpFkdSeWNlphWA==
X-Received: by 10.28.17.141 with SMTP id 135mr1383329wmr.80.1518105435196;
        Thu, 08 Feb 2018 07:57:15 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:14 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 8/9] t: validate 'test_i18ngrep's parameters
Date:   Thu,  8 Feb 2018 16:56:55 +0100
Message-Id: <20180208155656.9831-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the previous patches in this series fixed bogus
'test_i18ngrep' invocations:

  - Two invocations where the tested git command's standard output is
    directly piped into 'test_i18ngrep'.  While convenient, this is an
    antipattern, because the pipe hides the git command's exit code,
    and the test could continue even if the command exited with error.

  - Two invocations that had neither a filename parameter nor anything
    piped into their standard input, yet both managed to remain
    unnoticed for years.  A third similarly bogus invocation is
    currently lurking in 'pu' for a couple of weeks now.

Prevent similar mistakes in the future by validating 'test_i18ngrep's
parameters requiring that

  - The last parameter names an existing file to be read, effectively
    forbiding piping into 'test_i18ngrep'.

    Note that this change will also forbid cases where 'test_i18ngrep'
    would legitimately read its standard input, e.g. when its standard
    input is redirected from a file, or when a git command's standard
    output is first written to an intermediate file, which is then
    preprocessed by a non-git command before the results are piped
    into 'test_i18ngrep'.  See two of the previous patches for the
    only such cases we had in our test suite.  However, reliably
    preventing the piping antipattern is arguably more important than
    supporting these cases, which can be easily worked around by
    opening the file directly or using an intermediate file anyway.

  - There are at least two parameters, not including the optional '!'
    to negate the pattern.  This ought to catch corner cases when
    'test_i18ngrep' looks for the name of an existing file on its
    standard input; the above check would miss this case becase the
    filename as pattern would be the last parameter.

    Note that this is not quite perfect, as it doesn't account for any
    'grep --options' given as parameters.  However, doing so would be
    far too complicated, considering that patterns can start with
    dashes as well, and in the majority of the cases we don't use any
    such options anyway.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 92ed029371..a1676e0386 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -719,6 +719,18 @@ test_i18ncmp () {
 # under GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
+	eval "last_arg=\"\${$#}\""
+
+	test -f "$last_arg" ||
+	error "bug in the test script: test_i18ngrep requires a file" \
+	      "to read as the last parameter"
+
+	if test $# -lt 2 ||
+	   { test "x!" = "x$1" && test $# -lt 3 ; }
+	then
+		error "bug in the test script: too few parameters to test_i18ngrep"
+	fi
+
 	if test -n "$GETTEXT_POISON"
 	then
 	    : # pretend success
-- 
2.16.1.158.ge6451079d

