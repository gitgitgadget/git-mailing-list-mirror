Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4780C1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeHHVUT (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33702 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeHHVUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id g6-v6so2946136wrp.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S1zFOGRsLEpY9XtE8LmBr807XC1F8+6/8VsVNpICtCk=;
        b=XQz1drH9umOKwaLGRdG+VESUVT7XHzIn97qR++O3/ROEPnn7ou44alW3MzkqgMt3rE
         Peq9EsSnUaQpa0SGje+nqqohpS1U6Bt40ZNk6iX9u0jhvYYqbel1QnJLdgIULNZ6ijTo
         qbV1Kn/l/9cgyD8wnHmWV62QmxUDMroEKfJrON3bpDHBnhWOEe/umYc99tQCoXAibW+h
         YvLDDuorpqzLeFKkZey+EEYb+eXleMzWvgji1D6QShl/rg/M4yWgVk48j/eA+WblGrLM
         eFDRcdrY+VFcrlGmYbzDVUrVefAXj/5HmiivSc4GXAfYtBEwsUP+ik5TKX5Fs45AxZoc
         bWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1zFOGRsLEpY9XtE8LmBr807XC1F8+6/8VsVNpICtCk=;
        b=D82/vsx3q4MheMHDqYEyswlhx1Vu7Y0w7iWva92ZEQtqwveZMUXPXVJXCaNgzN6iKi
         oX05w6Oh0nJrk1056r+KkgKSKNCGnTl69rRYPQmpsNYgkux8TTh5wv/iRXTYmHeIaEES
         eE9gsxEF+Rap7OrtPffunU1nrangBWhiPC3vEgOcPc2ZYmPtL5cZbG1nYzrp4KUeaUBr
         sbt5jqKTFESffIb7vNS0zQopgazfPrZj4W6uvsMxXMAtib+Z1DVyOO0Jed38NH643a78
         BGBIKihkbiYK5b1kkNHtlJgEGR4qkrKPKeDkRr+GRBXDKTJ1sSLIFsXxp2qFZzL6ZT69
         qJHA==
X-Gm-Message-State: AOUpUlF3ydK7ZbgleV/CAlBvj8vJzRSNbQ7QIUT8d78psd/ib9mYP0dp
        A4+aIYDoEF5Mia+STUdZnOOXbJSr
X-Google-Smtp-Source: AA+uWPxt9hlboYkpFM36Y0oDAxOvrHPrtS793RisURDLty6R+NNcEP8c/383GtRkdFKvgfRFaoNoBQ==
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr2696555wrr.105.1533754756935;
        Wed, 08 Aug 2018 11:59:16 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.15
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:16 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 02/26] stash: improve option parsing test coverage
Date:   Wed,  8 Aug 2018 21:58:41 +0300
Message-Id: <57c8f7ebbd3cf5631bbec51c0cae9cb9978ae2c0.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many parameters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1f871d3cc..af7586d43 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,36 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'giving too many ref arguments does not modify files' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	echo foo >file2 &&
+	git stash &&
+	echo bar >file2 &&
+	git stash &&
+	test-tool chmtime =123456789 file2 &&
+	for type in apply pop "branch stash-branch"
+	do
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many revisions" err &&
+		test 123456789 = $(test-tool chmtime -g file2) || return 1
+	done
+'
+
+test_expect_success 'drop: too many arguments errors out (does nothing)' '
+	git stash list >expect &&
+	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
+	test_i18ngrep "Too many revisions" err &&
+	git stash list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show: too many arguments errors out (does nothing)' '
+	test_must_fail git stash show stash@{0} stash@{1} 2>err 1>out &&
+	test_i18ngrep "Too many revisions" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'stash create - no changes' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -479,6 +509,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch 2>err &&
+	test_i18ngrep "No branch name specified" err
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.18.0.573.g56500d98f

