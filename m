Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E481F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfKLXIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKLXIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so12834902pgk.11
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQYvtV+JsQmeOKbm1HxrV/8JaD7d505w2DEQdf+38eQ=;
        b=D8TJKCVkTEicdPQjg6CJzppBEZ1ygp37YZy48jQifRSGmXNa3DzuiLqCVHa/xAWpuX
         AQq2XAhoO1ZjbGfEKBy1q50tTB8IViDbydQihShdxxZ0rqy5wZKvRzFbYufiZ+muY9dN
         iQh4F6FKvSX5TsWpiiipmxVuPfSJTRUcXGOhTeTc5OCQ+/+xxBmlPI5tFTZcvmFNj1nu
         7m+BIWj2BXo1CCNZNIraTeTtqAZ+k9tnSHmEBYe9sTk8yFbMAaSNbctCIFzRBzxISZYw
         BIEOkfxnABc5Bo5pCBRwwgshtZBsHzJQm5+YxfqgYT2vJlCen+q7QMKP804AHaOQl4Iw
         CrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQYvtV+JsQmeOKbm1HxrV/8JaD7d505w2DEQdf+38eQ=;
        b=jWWqi6XO54frh+0aPw7zygLf8pqs18rNZZ6uIGdU/rV4yqt6jyjkd6S7twN+wxhlmK
         zDm3wNsdAmi6yulOu/KWHYz4no7xs3RX3x8lUPmcjR5inZ+oG8SvHhf+dSdaEP4Ffn1W
         92bHddTOf2Lij/h4sGh23TQKG+6bWpucrypzcCuqFDZfcQZ63T0bzD+uK+2kzvtkQ5zQ
         Guw/oTeu6ocBKT3YZSUitD+wICMbCIQDiLEpVpOjQWPl8rjsE4pqMMZja6EoKfAyTrLN
         hU6cvK7+mSADPP/JfxgleDxK0d3YSfG2nESF4YRS2V6WH/msIlqSaIROcuxFXt/efYfb
         az5g==
X-Gm-Message-State: APjAAAVNLb6nyzJZnNf4V96xdVNkNdSEXJKVlVLTsPqGlqtt1COTE6ai
        onwq7ka7X0ZcruTC9+BOXgCH2SGD
X-Google-Smtp-Source: APXvYqzj/ZvaqJBGQoFF0TlgV0+2eGLKWwUSDTW9oh0qxb6+vu1t7x5nv9Q7Olm13vU3rvz2sEmKpw==
X-Received: by 2002:a63:364d:: with SMTP id d74mr26188pga.408.1573600080215;
        Tue, 12 Nov 2019 15:08:00 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 136sm38570pfb.49.2019.11.12.15.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:07:59 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:07:58 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 06/14] t5520: remove spaces after redirect operator
Message-ID: <c451940c5b5876ce7900c45e40a81e78cf1af890.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style for tests in Git is to have the redirect operator attached to
the filename with no spaces. Fix test cases where this is not the case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 004d5884cd..7bb9031140 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -243,10 +243,10 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 
 test_expect_success '--rebase' '
 	git branch to-rebase &&
-	echo modified again > file &&
+	echo modified again >file &&
 	git commit -m file file &&
 	git checkout to-rebase &&
-	echo new > file2 &&
+	echo new >file2 &&
 	git add file2 &&
 	git commit -m "new file" &&
 	git tag before-rebase &&
@@ -542,10 +542,10 @@ test_expect_success '--rebase with rebased upstream' '
 	git checkout copy &&
 	git tag copy-orig &&
 	git reset --hard HEAD^ &&
-	echo conflicting modification > file &&
+	echo conflicting modification >file &&
 	git commit -m conflict file &&
 	git checkout to-rebase &&
-	echo file > file2 &&
+	echo file >file2 &&
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
@@ -591,7 +591,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
 	test_config branch.to-rebase.rebase true &&
-	echo dirty >> file &&
+	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
 	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
-- 
2.24.0.346.gee0de6d492

