Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9395A215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756452AbeEASkv (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46658 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756398AbeEASko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id o2-v6so8663518wrj.13
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=f9vMYiFJePUjw0W8IeodO/WtIyikm7dUjhilsmQYHfQ=;
        b=m1+NE9VdUkHQNRl5uExwy253oWaeLH1a1NVCWw7ooZG9ao1GqCyNEGyOr4T0oF9o6H
         B/nSmY5JHW5ZMW0c/lZWjracP4nyhD3RMioCFZ5l9c6Gp1SGvKD9ILmTXNmMXIiw0XkL
         rBN4DEvj1T8f62wA7SkGpDuMLhPYSIuLEJ97+FgiN7ChUd5HUDJdUyOZ0Fh7RYTv548B
         A0U7w8m5dqoHWI0dIX/bb2QsP37mPz+BOidGxthdvmaK8ksPlFJ7GY2c5ZT27bbvgbKE
         aGoqB95CKVys3eIW+sl/80VULFJKLhinfT4BvfjlbjqULzYOqGlDHcOQKP/sJYF6zstu
         pVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f9vMYiFJePUjw0W8IeodO/WtIyikm7dUjhilsmQYHfQ=;
        b=fTUNzNguV+gDRzKtZS8pkwCSJ+k5yHwRoiL1diScp6kKD7UlO+WOIzjpWmbVQcKJUA
         lODAlaXCssaXOZTThWClskt+4gJq5DhoUnjKwfkEy5kdCZ/osryGl14GB38q4eAGgG8U
         GJ/KRqVaMAETzWqjFSM2CVfof70gSt1mod1gPNidmm3UNzojqLZw9FYJDn1SnxTmA8KI
         d9kSDyFgzZ+9iIaqzIHiP3bm598Iy7ddytdPLvPCprlccAgGF2VtQ2wKcSvUFv0mGUyb
         u2IsGyi71NUkt8nCYqqjvqDw6piwVu7eHnrCsVN/cthUYiq86Q/2L3flAOpBuLbu2hLM
         gITA==
X-Gm-Message-State: ALQs6tB0YMGFrppffdkshSk3jUPpXi1z1pDK0bfCBc59hEi8cY6qFUmp
        6ayqM3H6j4x8A8bj90+rKtdCgMin
X-Google-Smtp-Source: AB8JxZq3IDLLm6LOqp/Xtpwxtr0p0DOK2kRFxQNcwaQapBusnwqNiHSjwuyMVkjpPTAX2YDT5o+y7Q==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr13127597wrb.145.1525200043390;
        Tue, 01 May 2018 11:40:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:42 -0700 (PDT)
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
Subject: [PATCH v3 05/12] sha1-name.c: move around the collect_ambiguous() function
Date:   Tue,  1 May 2018 18:40:09 +0000
Message-Id: <20180501184016.15061-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
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

