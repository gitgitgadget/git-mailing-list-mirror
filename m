Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83A61F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfG2UIf (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39865 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbfG2UIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so10040951wrt.6
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s8x/aF7+M7okFuPWVldB+ez6mGXAol2RuujBgyVBXLU=;
        b=RjrRxD1oN4LEipLClt9dDAoJRBZ3w6svMvCkO2eF9omvNUnjHTvxhDE/s41+jUjhKA
         7T/Db+PjRzuJbupogc7QfRQiDflf1vXAmpIgjNcqxB77T74mNRSw2pt8nXek621rtAPq
         iO0F/KYLY2SsVoK2XC14fxaMlcvTgmseeekRihG8Runb0uRrPHLRP7NPjfJALZ65Y6Vb
         +E/bJTDGnvCWb50Qt7oILMwUvKnc8eyAW42tsDI0qkac2uJVLpT6HQYixF2eIdQFmv3q
         QCq//2wq+MJt/21PF0lAJvHSR+FdDtMB4BkjOGhvKqIt6A//SzHsmFehrg+xQjlRxctO
         PeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s8x/aF7+M7okFuPWVldB+ez6mGXAol2RuujBgyVBXLU=;
        b=p/SXgRwNNZdWt7MTCYvxUuyv4i1doiKRns9RuI90VazteX/ulP2WBEBoQUSW7uaGLh
         G0Rdh64Uafihi/gJkl8LYaRyYdCz5WTuNeYDQkm0e6MRs5Q0AsIR50Y8lZkTnDBkXj6o
         4CMHbJdhkCS9I2bfuzveqKffdo+WZax66RFXEK2waJ7250CVTjZMXdC9qvOPWdXQP6bS
         pDpfTWkhLZ9lRK+6fT2RN5S4K5zi5o5GEQt0yPkh44+OeeVSodWcOJEl3qZMZUTGAua2
         M/5FoToL3mZaZNENAMY1mjJBuabn2j6hwsBp0XOScgJVAPu+OsHFuqK9QassCOuN5+hZ
         kP7Q==
X-Gm-Message-State: APjAAAUmW14DLD8B8erlVErgQGGgyMvHBaoN0MZ0DBmLimIYBCeyCGb1
        GwUrmHbnYQBSMwONBWF5ha/hBa0P
X-Google-Smtp-Source: APXvYqzIarLZWhm6tuZmUF3AdT1f9vI+nbP7zHXnIidQryAhLxC0Q5mVcMxREa5YneRWmwIa056D5g==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr34285381wru.312.1564430889717;
        Mon, 29 Jul 2019 13:08:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r4sm36189911wrq.82.2019.07.29.13.08.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:09 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:09 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:49 GMT
Message-Id: <b07e83440d10da5116ed8507efdef87c02eba32e.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 13/23] contrib/buildsystems: handle the curl library option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Upon seeing the '-lcurl' option, point to the libcurl.lib.

While there, fix the elsif indentation.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 1a12f4d556..d613277595 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -341,10 +341,12 @@ sub handleLinkLine
             $appout = shift @parts;
         } elsif ("$part" eq "-lz") {
             push(@libs, "zlib.lib");
-	} elsif ("$part" eq "-lcrypto") {
+        } elsif ("$part" eq "-lcrypto") {
             push(@libs, "libeay32.lib");
         } elsif ("$part" eq "-lssl") {
             push(@libs, "ssleay32.lib");
+        } elsif ("$part" eq "-lcurl") {
+            push(@libs, "libcurl.lib");
         } elsif ($part =~ /^-/) {
             push(@lflags, $part);
         } elsif ($part =~ /\.(a|lib)$/) {
-- 
gitgitgadget

