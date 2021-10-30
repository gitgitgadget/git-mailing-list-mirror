Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8072C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4560E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhJ3Ves (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhJ3Veh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921AC061570;
        Sat, 30 Oct 2021 14:32:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d27so4236786wrb.6;
        Sat, 30 Oct 2021 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Qo38nGzAOtZYXWdI7QrhvHBzDoFbfNIAcLf32qIAS0=;
        b=WKnlE4BgU+RUV+ZadWXPYvK64/Bh5xfuJIB6RXK8g64v23GOT+HNxQu5iv2331vZrQ
         CcfVgo/xEhBh08C5xoqZFVv+yPbKoPzt2/JzzNAx31AAZ6DOvzcC9ZybfstXHfoxxH06
         CDxJZXBtxOkKI2wKVcsvHWJLQp3gaFgqEXGpfAsjqFcsvdSiMYSJwxxmvwvqMcr/aoMv
         ertI0ho8j9RYIaQaloUYmyH85n7jaP1o0cgyuhTpRskYtTlRVYulSNcFyowU1LVCpBGN
         KInB17vCqr+wTwRePmvhu5fj5T3MlUWKpWmYrPb61nIQBNa7kHrU5FYWmT6xK4HX6Fdp
         zKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Qo38nGzAOtZYXWdI7QrhvHBzDoFbfNIAcLf32qIAS0=;
        b=u10AvbjAauky7c2YCw/LArWVSBig4biT4NDTLZ8fHFVsJeurDvHg/hjhximCgwNf2A
         /3RtmIrZqsqdT+iuFBYcBRQdOTCUuVZJvCp9s9A1CDQbzoAW2+Lj8eDx16Lh+zT4m7dK
         G+G63Ppu7DhP2UjFh1y+mNq/VBe81hoAXs2+mKq8ZQJPTPYwEXVybL5dpRKkaivKYGBf
         G2jWA/96ajwTVuuH0V1rL//8TryN9jHJAJLJDmulhi+GvIzLlytwiz9DcYX/77isdmEB
         Lsmf6Eq1F2ssOQa/NZHIIETV8FqPyKfoNdhaZt0+mqFRM7UDYixpirnGfsVlQn/lf/pq
         ykIg==
X-Gm-Message-State: AOAM533vwofFxsqklTc9RQZfY8j+EzYg1kwTJPlyRpnI9KYCzqwnNGpP
        rdFzLyXELVmTYCNvXZnYnTV80kGa7D8=
X-Google-Smtp-Source: ABdhPJwvK4aVBjcHC3Nx5wqTLjHmuD9i09b33vC1iRkHMr8+qS7B0Va5D8ZQY9u8RjKnFQqbLGx3Nw==
X-Received: by 2002:a5d:4107:: with SMTP id l7mr7527111wrp.209.1635629525128;
        Sat, 30 Oct 2021 14:32:05 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:04 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 11/22] ustat.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:21 +0200
Message-Id: <20211030213131.140429-12-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glibc 2.28 removed the wrapper for this syscall.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/ustat.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/ustat.2 b/man2/ustat.2
index cb26ab23e..6079861ad 100644
--- a/man2/ustat.2
+++ b/man2/ustat.2
@@ -36,7 +36,7 @@ ustat \- get filesystem statistics
 .BR "#include <unistd.h>" "    /* libc[45] */"
 .BR "#include <ustat.h>" "     /* glibc2 */"
 .PP
-.BI "int ustat(dev_t " dev ", struct ustat *" ubuf );
+.BI "[[deprecated]] int ustat(dev_t " dev ", struct ustat *" ubuf );
 .fi
 .SH DESCRIPTION
 .BR ustat ()
-- 
2.33.1

