Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1CEC18E7C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C747360E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhJ3Vel (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhJ3Vec (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:32 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF0C061570;
        Sat, 30 Oct 2021 14:32:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so3411685wmd.1;
        Sat, 30 Oct 2021 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dS95TUq21YHJvgnG2glGxHrkK8HEP8zJox0rvDijSfI=;
        b=BUPFbG29HyBTqsogP7GzU1EmQ6idqDhT4h4nf7ZgAc/LQQ8DCUj9dxCcpE+vquqi7f
         MD0iAtPmLZlkLoPfi8lE8LLcx9ahxSwm/5djytXgj0ksQ5wscNt+wS9fq1DXYMrcl0qD
         tmkU4CJYWNg5g9KhCBQ4dk8okbnoDOcH5tDSoBljo1f0MDePpBWsMiJd7Zwg33whFJm0
         2JqEBCIG21E5ZquC1EdPJykpBzBGEfy86yFFGExnRJjehlDiyKLinvwif9ZzLMcI6Mmg
         f1+qJj1QXo5lAdXxPcUX5JJLXhMVHvZK7q3MwC/GpQxZYSEEf1SueL9ebRJZyJyXMQrw
         9qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dS95TUq21YHJvgnG2glGxHrkK8HEP8zJox0rvDijSfI=;
        b=JFAYOiuUzZz5sqwsV6SCiYxuykGmsZ2OnenzuCImZWXREUNagl63raIyUA5Iai4u9k
         hZzJg0lWGEOwKYodRinU0ci6qLoyzUFGgd1mu1AV/Q7lsNblCLw88/IOAj0W1DMXR2kz
         heyzRa3FOsk9ROvfPHJ4tSgjJziXJ9mhcmYYjttWYUYSPjyhZQaNFeIcxdaWUqxsMrLv
         Z81O6JZQrM4ONTcZglmXLBC/vGDlC3Mht6A1y75fFhReHU1Gga6fDEHtRgxwivLAyh8o
         Gtvry5SuDMQgLOAG8PLCb62C4Iy+CB/gJhur2omaCgxSfJ43y5mODpp7cxhNjaMvtsFZ
         XIHQ==
X-Gm-Message-State: AOAM530HdJUkmUJguS2WOzAnRqKBkAXIOr0wXCr731RbMj1Qtw8kg5nK
        JQOm02DiRhZ5Peq2wrXSIog=
X-Google-Smtp-Source: ABdhPJwQvu8gOihcpy8JFvwtQBv1aEDqFadgzj51Eb99Ar9veqc0H3+uJnWF+Bw8LY0HyYlVrxCsyA==
X-Received: by 2002:a05:600c:1989:: with SMTP id t9mr20837155wmq.48.1635629520392;
        Sat, 30 Oct 2021 14:32:00 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:00 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 07/22] remap_file_pages.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:17 +0200
Message-Id: <20211030213131.140429-8-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This syscall was marked as deprecated in Linux 3.16.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/remap_file_pages.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/remap_file_pages.2 b/man2/remap_file_pages.2
index 2ed31bbff..69b37bb8b 100644
--- a/man2/remap_file_pages.2
+++ b/man2/remap_file_pages.2
@@ -33,8 +33,9 @@ remap_file_pages \- create a nonlinear file mapping
 .BR "#define _GNU_SOURCE" "         /* See feature_test_macros(7) */"
 .B #include <sys/mman.h>
 .PP
-.BI "int remap_file_pages(void *" addr ", size_t " size ", int " prot ,
-.BI "                     size_t " pgoff ", int " flags );
+.BI "[[deprecated]] int remap_file_pages(void *" addr ", size_t " size \
+", int " prot ,
+.BI "                                    size_t " pgoff ", int " flags );
 .fi
 .SH DESCRIPTION
 .BR Note :
-- 
2.33.1

