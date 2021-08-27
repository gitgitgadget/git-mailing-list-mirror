Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA41C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F6960FD8
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 11:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhH0Lwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 07:52:30 -0400
Received: from shark2.2a.pl ([213.77.90.2]:52414 "EHLO shark.2a.pl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233376AbhH0Lwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 07:52:30 -0400
Received: from wrasse.2a.pl (wrasse.2a.pl [213.77.90.7])
        by shark.2a.pl (Postfix) with ESMTP id 392E21750840;
        Fri, 27 Aug 2021 13:51:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 2a.pl
Received: from shark.2a.pl ([213.77.90.2])
        by wrasse.2a.pl (wrasse.2a.pl [213.77.90.7]) (amavisd-new, port 10024)
        with ESMTP id qjQXZNCcBxRb; Fri, 27 Aug 2021 13:51:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.1.26])
        by shark.2a.pl (Postfix) with ESMTPSA id 083391750827;
        Fri, 27 Aug 2021 13:51:35 +0200 (CEST)
From:   Krzysztof =?utf-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
To:     Christopher Yeleighton via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christopher Yeleighton <ne01026@shark.2a.pl>
Subject: [PATCH v2] pretty-options.txt: describe supported encoding
Date:   Fri, 27 Aug 2021 13:51:34 +0200
Message-ID: <2247912.lYO0ccLKhl@localhost.localdomain>
In-Reply-To: <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
References: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com> <0877bb5d-da4b-125d-7beb-c3138903f468@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git log recognises only system encodings supported by iconv(1), but not 
POSIX character maps used by iconv(1p). Document it.

Signed-off-by:  <ne01026@shark.2a.pl>

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-
options.txt
index 27ddaf84a19..4f8376d681b 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -36,9 +36,13 @@ people using 80-column terminals.
        The commit objects record the encoding used for the log message
        in their encoding header; this option can be used to tell the
        command to re-code the commit log message in the encoding
-       preferred by the user.  For non plumbing commands this
-       defaults to UTF-8. Note that if an object claims to be encoded
-       in `X` and we are outputting in `X`, we will output the object
+       preferred by the user.
+       The encoding must be a system encoding supported by iconv(1),
+       otherwise this option will be ignored.
+       POSIX character maps used by iconv(1p) are not supported.
+       For non-plumbing commands this defaults to UTF-8.
+       Note that if an object claims to be encoded in `X`
+       and we are outputting in `X`, we shall output the object
        verbatim; this means that invalid sequences in the original
        commit may be copied to the output.
 


