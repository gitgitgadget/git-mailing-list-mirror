Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CF020248
	for <e@80x24.org>; Thu, 21 Mar 2019 20:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfCUUvK (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 16:51:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42975 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUUvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 16:51:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so52611wrx.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0k/30Qji3F7aiTeYXbsR+HmU6OkBydkO610vgaIUJNY=;
        b=m91GsLrWSTxIsIHKIWnTyL1vaZ03ftP/BDO/EHWPQb2+PdNR6Yngffh6isi8xKzX21
         NKh6SdpFpIYL9c6aiX+mhhpY3BWH7lIH5LqjUB1/fjxUgSqEgKZ98cnlgvuZRyFbLPbw
         0T7uxY/nFtxdzzLO/2fxYIPii/sA+i+/i3CINm0DLsmJTohepYAZwWZJLjN+wZZT9MAC
         YdVAKRfIZojduJba9uZh1lLd8zJ0kvRrqZoxvzCCGztHbLfImuXCsPRtDNPqIOl0ovNt
         Dy1EF9mtmi+HBGOGiFKKKrEug6H0zzpS16JekGZVNlg9JMsaaB7zY3aeNZPNs3Ja8Exh
         eN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0k/30Qji3F7aiTeYXbsR+HmU6OkBydkO610vgaIUJNY=;
        b=aY5uy2TITTVausu2eyCm0LA00tbvO4teGdnDSAXvdOu82HuMvxavxQ+sGrYqBtmKaY
         9/rhwBrv8M59XlqDIgfIluLFN9FbdyJlvdJ6uxYVIoXL5ibIsNHsOdGWJwSMiPdwU+RB
         gLiseSibKk3FhE5zl6Ehga5bhK1ZFMj+zz8RNfh2QuKy2gH5PfwjpJgfXqelTdAZ7nNC
         34yGk0wpbRISJ/YHzimqlk/oUbUMJnx4zdpm7N7Exq5rZYh873T/YXYd1owi5j9qlJph
         h2aLEPbEcy0odnBMlgYHun6RJiIsfjmOKPgsHITZ9qCNQ2OLvgD3K5OKuIsOj+wSEBFS
         IeGg==
X-Gm-Message-State: APjAAAWSDXYrQtC3PlL8ZcoSXhXhzI0qNVfc584z27oRFVtePA8uxS3R
        2i3H5hx5JjlU8EDGUVynUEAGG6Rm
X-Google-Smtp-Source: APXvYqzqonRaVK81KIvSMk6esOsgBUD6nFQb+bDbb5AY5Hke4+9dlhu583TKpnJKa6EYJTrwMcQ1kw==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr4046103wrj.118.1553201467268;
        Thu, 21 Mar 2019 13:51:07 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b4sm6053978wmj.3.2019.03.21.13.51.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Mar 2019 13:51:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] gc docs: stop noting "repack" flags
Date:   Thu, 21 Mar 2019 21:50:46 +0100
Message-Id: <20190321205054.17109-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the mention of specific flags from the "gc" documentation, and
leave it at describing what we'll do instead. As seen in builtin/gc.c
we'll use various repack flags depending on what we detect we need to
do, so this isn't always accurate.

More importantly, a subsequent change is about to remove all this
documentation and replace it with an include of the gc.* docs in
git-config(1). By first changing this it's easier to reason about that
subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 774503e33d..95c3237f8e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -52,14 +52,13 @@ OPTIONS
 +
 If the number of loose objects exceeds the value of the `gc.auto`
 configuration variable, then all loose objects are combined into a
-single pack using `git repack -d -l`.  Setting the value of `gc.auto`
+single pack.  Setting the value of `gc.auto`
 to 0 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file
 or over `gc.bigPackThreshold` limit)
-are consolidated into a single pack by using the `-A` option of
-'git repack'.
+are consolidated into a single pack.
 If the amount of memory is estimated not enough for `git repack` to
 run smoothly and `gc.bigPackThreshold` is not set, the largest
 pack will also be excluded (this is the equivalent of running `git gc`
-- 
2.21.0.360.g471c308f928

