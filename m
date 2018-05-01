Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DD7215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbeEAMHf (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:07:35 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39366 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754987AbeEAMHb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:07:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id q3-v6so10641929wrj.6
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=f9vMYiFJePUjw0W8IeodO/WtIyikm7dUjhilsmQYHfQ=;
        b=AsCUfMrIinJ240Bx6Lx7sXGoxGq0IfoxFedkLMq0NdZFN48Rv366CflMZnzeqwQK8C
         n0r8wxRGMpJBXS5Sa9O6AiUk4ImcSus1q7EhnF74whjJdm7Y/E0ZvijPQV9K/XwZsOIU
         f5aeMYbTzdqXZq+dF/2qIf9euUbrC/a5PTvCGFTmImU1yG+et09nV3Rkgf8KXNw3GIZf
         CEkRP50n6pwJm28KNgN07YRdk+qM5b6i3mvUY9vVIXUUufMuuC8NX9LND/91VoHl+meA
         S2rZlHqTHkt6qgEx7BMVshc6haGXcMlucs223/iuVkYpd/qw4fTiwDFEw0wpm87f+gF+
         mMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f9vMYiFJePUjw0W8IeodO/WtIyikm7dUjhilsmQYHfQ=;
        b=dpkq3AYrQSD0SRw+/mavSXBFeeSq96y+9lqXRRh3usYu4epyC7aMiHP+M7NVSvgYCf
         OnWeK8LumGsCLyzPuLibadPk2gsO4s7MT9X4kR+K9oDfIBGY2L5/UB9l1uII22W2LKoy
         MWi6/V0WYUpoH/BR5z3miedHr8OTNoefsF6vVD2jboDKulpvVhi9jab/I1jd1RogL6Uj
         XV2Glmzy+VScurS0LuKU0rvd6OqHOJW6ObcpeS/ikT8GhqE0uFmUDErWGQfixid2SBmV
         ZzpJ764JkdisJCp1KuHvi3yzGPRIiYvDcRQpx2CoNJEymKOtOonnjnga1c5KmeUHw2m2
         GXjA==
X-Gm-Message-State: ALQs6tAvKDcNQzYWwA9nhuYRrJfBPEJsv48j9Gr07DiMx/yT/VXcDJvW
        h1qbfH6eioZGwSD91o4ITbhUuuUZ
X-Google-Smtp-Source: AB8JxZrSGHLOfLvHyZ0yWz9gbTq5vR7E9M8e3MUNX59Km9K+R/tPHNBtYErtOQPWY1oyleQ2J7b1gA==
X-Received: by 2002:adf:afe4:: with SMTP id y36-v6mr11434593wrd.107.1525176450447;
        Tue, 01 May 2018 05:07:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m134sm11738710wmg.4.2018.05.01.05.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:07:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/12] sha1-name.c: move around the collect_ambiguous() function
Date:   Tue,  1 May 2018 12:06:44 +0000
Message-Id: <20180501120651.15886-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent change will make use of this static function in the
get_short_oid() function, which is defined above where the
collect_ambiguous() function is now. Without this we'd then have a
compilation error due to a forward declaration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index cd3b133aae..9d7bbd3e96 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -372,6 +372,12 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static int collect_ambiguous(const struct object_id *oid, void *data)
+{
+	oid_array_append(data, oid);
+	return 0;
+}
+
 static int get_short_oid(const char *name, int len, struct object_id *oid,
 			  unsigned flags)
 {
@@ -421,12 +427,6 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 	return status;
 }
 
-static int collect_ambiguous(const struct object_id *oid, void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
 	struct oid_array collect = OID_ARRAY_INIT;
-- 
2.17.0.290.gded63e768a

