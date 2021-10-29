Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A000C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E9860524
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhJ2VSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhJ2VSC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:18:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A150DC0613F5
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o14so18538815wra.12
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JK/p/K1jhs9XlO6KJsRjjD9f+ZsiTBmMm/Hvj1ieh+U=;
        b=YY+R0w3ow3HGY8t9rcaww3tkDG6PnHTBBo+8kw+ggnMOciLtAaCa2IbmhIoo8Io8DQ
         Fm4CxLIARPLlmw4lnd47iZS9mgR1Lvl+MRbO16WaYlF3wpogjKHrCn4/kO1t/UYtDImH
         yhP22VbM8LnXw9U1w81GoOqk7Js48FoWKKJLGgcsmvWBjmcZEZB749hBpPpiYJtzSQVC
         gJP4/SxCsjrEvlLU2Y6nWQQXDVQtZJSOPw8O0XPAnK6heUJfiKsMMoAZPjRX9CJez0wX
         ZPmSGjoJ3lJNt7UTrEUyx787PySuERY5OgwL5mVAEgL2Jle2myShqOSdyvA5qIrLxE7r
         xrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JK/p/K1jhs9XlO6KJsRjjD9f+ZsiTBmMm/Hvj1ieh+U=;
        b=4t5YiZNUvfq8B+/oAWCtWmPile025FzW8qYc0SvwPEVOWuFhRrkRa5caAjuwGUi125
         yOPMTWtLvHaxA3k2mcrHrE6pwihUaVf241GPf4xloZO/my8e9XE1MDqsCQYmmTQQ6VFU
         qjdo7ttAQLQd2AOn9l9hShWZadefz3onC81J1bvPyEyx2dgWHE0At35ND2xzwHb3WWBz
         WcZIapHbqqj3qh588NiFLhIUyQfMCIMCA0uJ8t1CvJYvkP+viFgu8oFCqFdHKSboyCGd
         Pfwf3/98pZ1QLlk6oqYKZRRNQRWMZET/OXm30zG9iibqOE3LfhdYtJfigKSht7veTWfE
         qTGQ==
X-Gm-Message-State: AOAM533pjm3kB9PbUT0fHFI3AmIaxnF65eeM+S26Kc0Qj3fEVOkUXMAL
        C5amV/GuuenOZbkMzuSGDmAbtwUZmHaQ9g==
X-Google-Smtp-Source: ABdhPJxj3ntQ0W+sesPn2UzDIeklUiMl8Cjm5lGbN43oHmIw8Z6ZTpvZ7GU+QtCI+Th63xbtBFMzfA==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr21429434wmm.161.1635542131158;
        Fri, 29 Oct 2021 14:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm6641302wmq.15.2021.10.29.14.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:15:30 -0700 (PDT)
Message-Id: <ea9ba5d0114d43ab275de47e20e066880aabb931.1635542128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
References: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 21:15:26 +0000
Subject: [PATCH 3/4] oneline: test for --newlineafter feature
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 5865daa8f8d..847426f8af0 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -576,6 +576,16 @@ test_expect_success 'clean log decoration' '
 	test_cmp expected actual1
 '
 
+test_expect_success 'oneline with --newlineafter=decorations' '
+	git checkout -b newlineafter &&
+	>baz &&
+	git add baz &&
+	git commit -m "decorations" &&
+	git log --pretty=format:"%h%d%n%>(18) %s%n" --max-count=1 >expect &&
+	git log --oneline --decorate --max-count=1 --newlineafter=decorations >actual &&
+	test_cmp expect actual
+'
+
 cat >trailers <<EOF
 Signed-off-by: A U Thor <author@example.com>
 Acked-by: A U Thor <author@example.com>
-- 
gitgitgadget

