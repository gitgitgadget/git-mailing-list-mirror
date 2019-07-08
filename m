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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7F91F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfGHQiH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50480 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfGHQiF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so186943wml.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZK6F8I9MMRXb1nyoGtw4TkkqOifbnYF7o0+q1l/W/JM=;
        b=bwB5LeaSfPBqluihCsf/uv/pUZgqxLT+TdFUrv7RK4uCnqk/aLEX/96YKt29DCNJEm
         qUEEQORVepdkscK+N1ykKB9ilHTXcQ7Trrp7gMSRqUrHEIvy607Tmkzyx7TLD//aURn+
         o6lkkRArRdZxIKbs3mZZFYwjzMARxhZhwmNTqvvMg9iSnmvs4wrO8n8yedz/va3UQfco
         J/i7DAw8nD8R9JGIwU8gWdX6DAEwR3dK7NyGc0I8zGcQPmhw7k4jvCVOVF514eLXxjMG
         6e8vxUDM5mRgs0JQXgMPbyG8hHK6lBA0TKlN9suGlRPA/nr+Kq7Pe23mXuJZhghL0laS
         Fe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZK6F8I9MMRXb1nyoGtw4TkkqOifbnYF7o0+q1l/W/JM=;
        b=K9pUlJch07jLc0rNkMHaq0dwdsqxFjCnqUbR8CuaiMr0p9rQwv0hEETKOrd8F1SJmF
         AhU5nRK6OU/jnLBh2VoJE1ZJO0bRA3d2bjkmy4G2u02GXhM2/IN5nJszNJJUs2aOHRxb
         /pwjRKiTAUldc8VPDcCNR4tsdB7PlHvXF6bvpHl7UWwyVMJywb03+JtmRvZem4s6NMTv
         DMv/nS0LFFufYNxcAYXow/TLHpycw8woMHhPH0je1l4iku3DUPmYJaEA5wRy7e2KEalj
         KCWyPYnmaELITfk1kd+DNvaszDGMhcLnMRT0CInG8udvzpC3/cxm0M9jT7sFzmRrDRHP
         O0mw==
X-Gm-Message-State: APjAAAUO9uKZPpOIleOiOlhZDR8YLdM84310bUnEjkagCJ+4jzqklUN/
        2ErANFt885E1Bj7atAKosCSufyIc
X-Google-Smtp-Source: APXvYqxlhDUDsDNf+3SWBEP5F7/ru5MAs/FQ6HZ0iOkzhMA0VXC7SogmsbMw8pHIWZK6zlrVO+kLcw==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4550838wmb.98.1562603882343;
        Mon, 08 Jul 2019 09:38:02 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id m16sm16424996wrv.89.2019.07.08.09.38.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:01 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 08/14] range-diff: fix function parameter indentation
Date:   Mon,  8 Jul 2019 17:33:09 +0100
Message-Id: <20190708163315.29912-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the indentation of the function parameters for a couple of
functions, to match the style in the rest of the file.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 48b0e1b4ce..9242b8975f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -148,7 +148,7 @@ static int read_patches(const char *range, struct string_list *list)
 }
 
 static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-		     const struct patch_util *b, const char *keydata)
+			  const struct patch_util *b, const char *keydata)
 {
 	return strcmp(a->diff, keydata ? keydata : b->diff);
 }
@@ -373,7 +373,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 }
 
 static void patch_diff(const char *a, const char *b,
-			      struct diff_options *diffopt)
+		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
 		   get_filespec("a", a), get_filespec("b", b));
-- 
2.22.0.510.g264f2c817a

