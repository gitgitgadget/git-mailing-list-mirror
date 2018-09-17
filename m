Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9591F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbeIRDyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:54:05 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:34616 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeIRDyE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:54:04 -0400
Received: by mail-yw1-f73.google.com with SMTP id p127-v6so8376841ywg.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e85kF+h3LIk58Of7HsAkVsp2JRMtN+KwRXGanYfiTtY=;
        b=Q4lB1BR11vReMx3x0l4i/G0166LMBVoahixcmFimxov4qGGntw+RqUg6D3DpBxL48K
         L1wQqmjFhx1os/PbFZQqvm22c9EQZV+86TXPwJFne8UKdbt64uLgCkbahcnWni+nMbnD
         nGA3zvkF5OOWigrbnvGz/tAgHuhPcqJgmGlW+tzuSdDDTm/xlKs0126PTDJxeDUDPbqd
         PPyfZNZkQ6HPepp2Gzynr1I2mx8rcDRbcY80PAStLoCpzzVHeMOU6/EV6fvCcK0g50j1
         iUw/YzGYcjg717Yn/gFXBIhoHaLe1lWuskO4whisPDcCLPiTVnCmFD0ZAhVtTXDhYk/Z
         VPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e85kF+h3LIk58Of7HsAkVsp2JRMtN+KwRXGanYfiTtY=;
        b=oek9CTbLkB3IFozqWek3hH+qLB0Xy+4UPxrqx5kaZy8nsdrnficFsISBZCmmoroJv1
         GuhDRkc3DxG8j8P9cDHiJq8H6FI/2nsr39W3LQkE77XWLLCFvzqHfYwmmawBXCnIX/Ch
         OQGI/VRyZAbw3appmh9z9HYYaDmTePlx713XVUUHzC6hWFUYdgG6mk0nzSR3GLx3m75m
         im9GZQwMuYGxRy7KTGFkCd0wzroYLy/Z5rEnWSvOXtJyIhgszgybL+RZaLxnNytNptxh
         wDx6WeNyYPegaX4IQc0m/b3//FQVEu8TQ3Xt5y5vCcA4P9VEOw3iewtTj42S76HnhbGT
         +94w==
X-Gm-Message-State: APzg51DZcMgjfofn3mDpNJVlMHyAyPt4fLRG3vwvyrfx4n/UfQdKa/ro
        6mKEVXpEj9TGI2tZuWuu+mPcrJKRQmXDffI3O4+x7Ou22d8hZCSFyQpGQQiApHSHxiOOtsbdKvv
        VdqafjMJipJFbqoYCQjyyCfzTanfqcxEPW9WtSYWPLn/GSJTqKX/U0Fzk4xY=
X-Google-Smtp-Source: ANB0VdZOrZgzgpsLiJhGetj5sH/7fbPcy7ucdFkM8SKqDTQ6eEXhWsl0uhVJPxDV1IbaEH299TXmSeLbIYoQ
X-Received: by 2002:a81:ae1c:: with SMTP id m28-v6mr3906905ywh.132.1537223085432;
 Mon, 17 Sep 2018 15:24:45 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:24:17 -0700
In-Reply-To: <cover.1537223021.git.matvore@google.com>
Message-Id: <c625bfe2205d51b3158ef71e4bf472708642c146.1537223021.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1537223021.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v2 1/6] CodingGuidelines: add shell piping guidelines
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com
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
 Documentation/CodingGuidelines | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfb..7f903c1aa 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -163,6 +163,35 @@ For shell scripts specifically (not exhaustive):
 
    does not have such a problem.
 
+ - In a piped sequence which spans multiple lines, put each statement
+   on a separate line and put pipes on the end of each line, rather
+   than the start. This means you don't need to use \ to join lines,
+   since | implies a join already. Also, do not indent subsequent
+   lines; if you need a sequence to visually stand apart from the
+   surrounding code, use a blank line before and/or after the piped
+   sequence.
+
+	(incorrect)
+	echo '...' > expected
+	git ls-files -s file.1 file.2 file.3 file.4 file.5 \
+		| awk '{print $1}' \
+		| sort >observed
+	test_cmp expected actual
+
+	(correct)
+	echo '...' > expected
+
+	git ls-files -s file.1 file.2 file.3 file.4 file.5 |
+	awk '{print $1}' |
+	sort >observed
+
+	test_cmp expected actual
+
+ - In a pipe, any non-zero exit codes returned by processes besides
+   the last will be ignored. If there is any possibility some
+   non-final command in the pipe will raise an error, prefer writing
+   the output of that command to a temporary file with '>' rather than
+   pipe it.
 
 For C programs:
 
-- 
2.19.0.444.g18242da7ef-goog

