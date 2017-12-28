Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084251F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbdL1EOI (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:08 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:42321 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdL1EOD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:03 -0500
Received: by mail-it0-f67.google.com with SMTP id p139so27006049itb.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zHx4NdqKpaJlru3Q6P9rVk51c7ZYqkKYZVByqf4UTuY=;
        b=RKLjh8cbA6OvRlRxYG1nuRqz74/70EGBs7QzwuiHF5vQnRfBvHTzerZ3P6MDxvNbxQ
         zlVyKWE4qtsPB2Gi8vsGfhLmw3lqQwABSwdSMsJvLDUzFwNKYpvW3SFUhHQJLNBAu6LM
         ccl0IJpZTdlKr/U1GU20tGLW6x0ck0vnbbg6Kgwy5a8EzG5OiCuVvU7VM6SIO0VhPNHz
         Pa2PPYBWU1RzA/OlLNH2b1q+8zWrWXXmS89lywudk4l3ROtpTcixaPbzXhWIIV22yboI
         kVZmQxfVhcSjm8aAzGeY/XHpVeawyc6jTiVfYq40RjmPHkOtXuRbVSfBGwq8bhhrkzB/
         wyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zHx4NdqKpaJlru3Q6P9rVk51c7ZYqkKYZVByqf4UTuY=;
        b=OhQ/f4lDPxEj8MYndIoe/yCoSMdDGCVGRtS21sVdnJ8Yaxxe7/8jen57/9HMZ4KV4k
         KZdPI1RSzX3nnLF8tPycu9AN90sKpSZ0hHsWaqE216Qc1Ife/HxN5KFYxZoJF3dgy0oF
         SJQk7uNrddSMIJdxgTsjW2OE7xXevAc4OKPPt77M5AUQOjn0cjXFdaeAaD9ED8ZlmlA+
         1V3kddvT/NVziqiegIda8VTfNB+vuSspdjdeYsA4VPsa9K3PrFDJY21+9p+owdKUpEdK
         f6T0eA+sz9ptmNt47zF37mOsyTsCHK0xywAgKoHRuKpYyF3JYiQpQ/V8gB6LXxHpk4LZ
         4rTA==
X-Gm-Message-State: AKGB3mJOkhqGRWFD6+YtjsUHpZ3xcJOizO9nJ/JMnYsiGSnCZUrauQXb
        WO9cV+FXvITTG91Ruwu6fkXQOg==
X-Google-Smtp-Source: ACJfBosvt23ydU++K3U/ti0tQgRrImuTaDA9hLrY6uo2x/6T03AnOq7uIQ49UZqgR2ERuL1cW7Y8yQ==
X-Received: by 10.36.55.138 with SMTP id r132mr39436144itr.34.1514434442505;
        Wed, 27 Dec 2017 20:14:02 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 03/34] merge-recursive: add explanation for src_entry and dst_entry
Date:   Wed, 27 Dec 2017 20:13:21 -0800
Message-Id: <20171228041352.27880-4-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I have to walk through the debugger and inspect the values found in
here in order to figure out their meaning, despite having known these
things inside and out some years back, then they probably need a comment
for the casual reader to explain their purpose.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/merge-recursive.c b/merge-recursive.c
index 98c84e73d..d78853d5e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -513,6 +513,25 @@ static void record_df_conflict_files(struct merge_options *o,
 
 struct rename {
 	struct diff_filepair *pair;
+	/*
+	 * Purpose of src_entry and dst_entry:
+	 *
+	 * If 'before' is renamed to 'after' then src_entry will contain
+	 * the versions of 'before' from the merge_base, HEAD, and MERGE in
+	 * stages 1, 2, and 3; dst_entry will contain the respective
+	 * versions of 'after' in corresponding locations.  Thus, we have a
+	 * total of six modes and oids, though some will be null.  (Stage 0
+	 * is ignored; we're interested in handling conflicts.)
+	 *
+	 * Since we don't turn on break-rewrites by default, neither
+	 * src_entry nor dst_entry can have all three of their stages have
+	 * non-null oids, meaning at most four of the six will be non-null.
+	 * Also, since this is a rename, both src_entry and dst_entry will
+	 * have at least one non-null oid, meaning at least two will be
+	 * non-null.  Of the six oids, a typical rename will have three be
+	 * non-null.  Only two implies a rename/delete, and four implies a
+	 * rename/add.
+	 */
 	struct stage_data *src_entry;
 	struct stage_data *dst_entry;
 	unsigned processed:1;
-- 
2.15.0.408.g8e199d483

