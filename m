Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504D2C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 12:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiBIMEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiBIMDg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA04DF28A2A
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 03:29:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i14so3428699wrc.10
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zwm7yAr5uxxPyhSHbnlsf3Ggf5b20WknGDuolvpAObU=;
        b=awSaR/HhmWEh8Dbxhj7x3Z38IiPu2SsQ1WZ6POJ+cwvzqvOxdw9bgcJLwsk3OAaEvx
         J/CEhDupYZ+jJnWHomXW0STSp307NqyzkPDtIp5DtFIWxp/AUaAcPDquD+VyKb/uqX2N
         rjgONDpArDZDZtBlb4mcENuEWDuc8G6eG40cdZZVCKUEoXZvfbVVzAGIHdGgSsQOb5es
         i33/xTMYSsfrwVXw5d1ItQMqbU4hlft97d7g8MOWo0xq75kb9RSWrJa7oVbDnbyrKmfD
         TD6/drcWBsYNnhvEYz9piIRQ9y9Hau9VK1ErMACjtrpbVxswASr1suN8D9F1eww1cPNe
         NbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zwm7yAr5uxxPyhSHbnlsf3Ggf5b20WknGDuolvpAObU=;
        b=tCZP5aR9w+/5AI7Ce3De+/UjYPtahe5nnvo7RAVkoQ2cNachNXIXXsQrQefcgoUL4T
         vT3oP/uNjKGbMemNYMys2o30FN4K+5shWaJacrsSn+TJN8/kzpkW/LSTGZZEHngJb3Dd
         bq1qIW83Hlsit7wHJGyhGB1ie0qsMaRyEKxX68Co3QENAZmgRzTq2q4ziGj9SBUn8l9A
         mhIUKZrOezu41jNXvgKadb7WeDKIPmlrIrwHWT5pYeoDj2IfJzbEAw5UaPcbdgY4/6mU
         SC7A/tFxtt8k1wcla/+Bo4314aWfWrm1Xckrku5wLODe6a4XzKakjYhs674oktg1mmja
         YbYw==
X-Gm-Message-State: AOAM531AX19OjVQ7Td6Rj6DCLJ7FOI3A3ey8hAycc/ypnFY+8LLyiXC9
        qwi0Qytf8kkCy4QlzZWtPlSqd79eu2U=
X-Google-Smtp-Source: ABdhPJx1a2wgHat8/ENiyC7UO69FRBPMqpYXmBjUmjvbmp/xykAoU2AWLLl+nENdU0yTWV9Qzffs3Q==
X-Received: by 2002:a5d:4c90:: with SMTP id z16mr1696461wrs.72.1644406182411;
        Wed, 09 Feb 2022 03:29:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm15508402wrv.24.2022.02.09.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 03:29:42 -0800 (PST)
Message-Id: <fd57cd70862f7b6cdec812e300d0f21d44b6f0be.1644406180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1213.git.git.1644406180.gitgitgadget@gmail.com>
References: <pull.1213.git.git.1644406180.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 11:29:40 +0000
Subject: [PATCH 2/2] t1410: mark bufsize boundary test as REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This test fiddles with files under .git/logs to recreate a condition
that is unlikely to warrant special attention under reftable, as
reflog blocks are zlib compressed.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1410-reflog.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 36f6693d9d3..68f69bb5431 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -341,7 +341,7 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 # Each line is 114 characters, so we need 75 to still have a few before the
 # last 8K. The 89-character padding on the final entry lines up our
 # newline exactly.
-test_expect_success SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
+test_expect_success REFFILES,SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
 	git checkout -b reflogskip &&
 	zf=$(test_oid zero_2) &&
 	ident="abc <xyz> 0000000001 +0000" &&
-- 
gitgitgadget
