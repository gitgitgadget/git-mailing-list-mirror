Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77BD20989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbcJKAWM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:12 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32913 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbcJKAWK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:10 -0400
Received: by mail-pa0-f49.google.com with SMTP id vu5so3992160pab.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=msCr/owRnpwWliEQ9EeCJ9r1L5UbeTZ8OGJDxTIjVxc=;
        b=nV3S+gL7RCOhh6n8ASD6GmdwGS0Z8+4uLjqM8lmpvlcgM7ya+u1H4101Oxs/h9Xq4I
         vt3BamjVfUtuv4dVUwvZ8DHDcU0Evoxv54yvt9KnrREX7usquH/8hK409mmCsn/JeIxY
         lP2ZlAaaSCFyFAyR4ShXlAMLV30eEOgouss6Yzelowmx/Oa+7PeNHjkI2rf4veUVz8HO
         CjchOBq2dGEnoJYc32EQhgE9AyH8KByieymkXRRgASLbs4BcAhHBlb0PkX057sDaXyQH
         8ZpBqrPojzJNlY33hfUIHTLBFCTfXRiH1w9SL1rzUOmCnxTTnwIk5vPFEsy+omZjHGd5
         vWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=msCr/owRnpwWliEQ9EeCJ9r1L5UbeTZ8OGJDxTIjVxc=;
        b=LMoKdEcWieDLFlerXwZWvNSpiporPxsjhLeXEiysSoi13bpc0oZXJwIqZK8/28d3Pr
         WUUhraDcn6BprPWXPYKv84KVXfx4U5meZZLu9AHUpKWs7xNt5bmGvMo/mz4f0a9vdv2N
         0xzoANqvdK8i4JbTCMQ2hNxvHYgiqS7k2Teaxn6j0Pg4ltM99y6XDmFvulza8Esf/IkB
         AE7DFOwc3pzJcesl8mRooXYAbPsDyyPf+tFcCI+9IITXTfHifw6f8m4Ro8awNQdkZcam
         X2OtJxboo+B6IHxRt1IkpEs6cRiPQHh1cOAjAD1BhJ0/Hq2g6gt5ta2GImphtYBz8zGu
         45oQ==
X-Gm-Message-State: AA6/9RmC9LCPwSDjic8Szmy7YSpsn06bzP3yls5Hm076pos5zHpzifm9UXoVFFYRQ8h2Qyzq
X-Received: by 10.66.245.204 with SMTP id xq12mr1719933pac.37.1476145329348;
        Mon, 10 Oct 2016 17:22:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id aa6sm486744pad.46.2016.10.10.17.22.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 26/28] attr: make git_attr_counted static
Date:   Mon, 10 Oct 2016 17:21:13 -0700
Message-Id: <20161011002115.23312-27-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not used outside the attr code, so let's keep it private.

Change-Id: I0d15e0f2ea944b31d68b9cf1a4edecac0ca2170d
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 2 +-
 attr.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index e34b4c4..ea6d5c1 100644
--- a/attr.c
+++ b/attr.c
@@ -108,7 +108,7 @@ static void report_invalid_attr(const char *name, size_t len,
 	strbuf_release(&err);
 }
 
-struct git_attr *git_attr_counted(const char *name, size_t len)
+static struct git_attr *git_attr_counted(const char *name, size_t len)
 {
 	unsigned hval = hash_name(name, len);
 	unsigned pos = hval % HASHSIZE;
diff --git a/attr.h b/attr.h
index 40abc16..f85a95f 100644
--- a/attr.h
+++ b/attr.h
@@ -10,9 +10,6 @@ struct git_attr;
  */
 extern struct git_attr *git_attr(const char *);
 
-/* The same, but with counted string */
-extern struct git_attr *git_attr_counted(const char *, size_t);
-
 extern int attr_name_valid(const char *name, size_t namelen);
 extern void invalid_attr_name_message(struct strbuf *, const char *, int);
 
-- 
2.10.1.382.ga23ca1b.dirty

