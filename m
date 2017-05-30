Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33F52027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdE3Rc0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:26 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33354 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdE3RcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:25 -0400
Received: by mail-pf0-f181.google.com with SMTP id e193so78480547pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tnZ5CAWKEQm7etQXzYCENtD+LWRGHPqT6cyzejw+TLM=;
        b=s3v0peo1HdGTrqrKXHToaFYWs1C5u9oHKERBlDUxDNvx+ziPFFpn2OUspMubs2yUi7
         Nlm3occFmK06L5pX3X9kCJqhiVO9LKTkwL5Nynfwk/m1cSFm7ezyNLrOBH404m4HI66L
         k1GlARwEiIf+pYZbO5qhUaH0cfgAa3Ci70Oz+nw15HaeSvfP9pmzwniqGqJrux9Ny7de
         Lb1PlhLgRW0dqHG0+IS7O3AWIVyWbfSvuw+GXCSkQUtrSDUrQPfzMcu5+6n+4rgQTEn+
         WGyjV1EKWO+hmtPKDMOjD07hibVNUZszfx19Zv1DuR74iham9fYmNZTIpA+Gsn9j2oLp
         gNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tnZ5CAWKEQm7etQXzYCENtD+LWRGHPqT6cyzejw+TLM=;
        b=tiq+FkD0QrW0lkS4x9jqgggHFMlCbhyL5Gg1J0QkDRDaGsNW7MzwpgJuRG5fVljjed
         /xCXaIxboFLIs1hPjquFUTLk0EV2QnShqZPBrBDqYWjN3pPobrobPTjPLK1ZDRegT8B8
         5BdzskOFfzLuNmtfIs6MYKU9CnjWhUg7/+2Pw6VJkCSZCGy/VoHEIZtunahdRy8+HE0V
         FSPPKoG3LRjmAPm/JUgEGCgvWwgyR/kPar69B9CfjaYN+QocsYiPdpxKbMugUl4mmuCv
         7eMWEYGYJYvEHhYVI2Iv+BdwvGhiEGGVkzUnDdf7jGkmrS+00zpaKn9Hc3Tnc4n4WsQI
         dOfA==
X-Gm-Message-State: AODbwcDEduLbFIFpU17woBQ2dGmx8vBIfjQXXopw+4LWC7fvU15fYL8q
        mj3iYDbHHNpA9yLc
X-Received: by 10.84.212.2 with SMTP id d2mr144860pli.26.1496165539311;
        Tue, 30 May 2017 10:32:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:32:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 33/33] diff: rename diff_fill_sha1_info to diff_fill_oid_info
Date:   Tue, 30 May 2017 10:31:09 -0700
Message-Id: <20170530173109.54904-34-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 diff.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index dd325e616..c758a0d73 100644
--- a/diff.c
+++ b/diff.c
@@ -3239,7 +3239,7 @@ static void run_diff_cmd(const char *pgm,
 		fprintf(o->file, "* Unmerged path %s\n", name);
 }
 
-static void diff_fill_sha1_info(struct diff_filespec *one)
+static void diff_fill_oid_info(struct diff_filespec *one)
 {
 	if (DIFF_FILE_VALID(one)) {
 		if (!one->oid_valid) {
@@ -3298,8 +3298,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		return;
 	}
 
-	diff_fill_sha1_info(one);
-	diff_fill_sha1_info(two);
+	diff_fill_oid_info(one);
+	diff_fill_oid_info(two);
 
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
@@ -3344,8 +3344,8 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_sha1_info(p->one);
-	diff_fill_sha1_info(p->two);
+	diff_fill_oid_info(p->one);
+	diff_fill_oid_info(p->two);
 
 	builtin_diffstat(name, other, p->one, p->two, diffstat, o, p);
 }
@@ -3368,8 +3368,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	diff_fill_sha1_info(p->one);
-	diff_fill_sha1_info(p->two);
+	diff_fill_oid_info(p->one);
+	diff_fill_oid_info(p->two);
 
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
@@ -4616,8 +4616,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		if (DIFF_PAIR_UNMERGED(p))
 			continue;
 
-		diff_fill_sha1_info(p->one);
-		diff_fill_sha1_info(p->two);
+		diff_fill_oid_info(p->one);
+		diff_fill_oid_info(p->two);
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
-- 
2.13.0.219.gdb65acc882-goog

