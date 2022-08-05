Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4EDC25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbiHER7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbiHER6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:58:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFD5B042
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:58:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z17so4056158wrq.4
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=vFumYQ/yr4+j+ikOYObOI/Rr2Og35Us5Vt8w/I/+8f4=;
        b=LDtbRcq3sUQoaavru4m/KOCMKlWN9kOQrbA3YS+kLnyHx2Ye2+sJeqfMAaXK6GkyQI
         ZSAYAK4upXMx67oIG+rWYrVa57t5jTKkhDGqQPKjXCArk2U3Jp86GsK0jooOypAAwfo0
         bnDJg3CV3A8jdoDH7jHtI5rFLchKjTx/fN+mxFYrrYdcnohfiNdIRQIcRACJWklAanXM
         DGLL3avfTWtbwUlB4j5U6MwI+yJFojl2yudCYYjoQOxAzGwiJrb1HJr0THDCKUl1PoH6
         6h3RMfT4MLdFPrlA3hBQ1k+6nm+Gx52NuAH4ldfidXL1GAoCkE8JxP2zYJavpu+X/LM4
         Q4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=vFumYQ/yr4+j+ikOYObOI/Rr2Og35Us5Vt8w/I/+8f4=;
        b=Qrr+DwCg/RJaZ4OurY2qJlnnjoOvbylIaWUv7GsWRVQoCvmdFT6IJOUOSc8PRtOZEQ
         s8KSpkkXYJtq8vt6HGeJod3EqR407NkeY9W9xRioO90163LIEox+kTfrRn9eXcAOuje9
         n/m9wax4ogG47zRUUcGEFuwVvZre149YjqO2dje4aqgLQQ9Slkbe6S5zkYYBxQIQMJal
         9kVFmVHSNsfCzS1zpI7m10Q1vdRlFdFggFQIW9ywFZxl08YETRL8MDhZhUgg/EjiFfvx
         tqGwwAuSagHIv5ccUd00o/rfh2nJrcvXGX91801UDNswoI6Wn3mT28nZdE/SD2JkeaaA
         EhKQ==
X-Gm-Message-State: ACgBeo2raFP3akJ30EVuW+J5cAQ7N089uicefbJUhvtLOnwspqE1x2yc
        HEoaPlo/tJO17uhPy0c7M0AHTPLLZqk=
X-Google-Smtp-Source: AA6agR6XudlW7ncJAyhr4S40fBEi16g0DRihIR09ug4mMqbTXfvXe0ybNoQKvZ/z2d8gIRlEt+5bYw==
X-Received: by 2002:a5d:4e8a:0:b0:21f:610:6866 with SMTP id e10-20020a5d4e8a000000b0021f06106866mr4738865wru.606.1659722329926;
        Fri, 05 Aug 2022 10:58:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003a504f9fcefsm5198962wmq.11.2022.08.05.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:49 -0700 (PDT)
Message-Id: <1522889352ff5cb823132052d9ab62b5f2d7b8b0.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:33 +0000
Subject: [PATCH v3 01/11] refs: allow "HEAD" as decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The normalize_glob_ref() method was introduced in 65516f586b693 (log:
add option to choose which refs to decorate, 2017-11-21) to help with
decoration filters such as --decorate-refs=<filter> and
--decorate-refs-exclude=<filter>. The method has not been used anywhere
else.

At the moment, it is impossible to specify HEAD as a decoration filter
since normalize_glob_ref() prepends "refs/" to the filter if it isn't
already there.

Allow adding HEAD as a decoration filter by allowing the exact string
"HEAD" to not be prepended with "refs/". Add a test in t4202-log.sh that
would previously fail since the HEAD decoration would exist in the
output.

It is sufficient to only cover "HEAD" here and not include other special
refs like REBASE_HEAD. This is because HEAD is the only ref outside of
refs/* that is added to the list of decorations. However, we may want to
special-case these other refs in normalize_glob_ref() in the future.
Leave a NEEDSWORK comment for now.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs.c         | 11 ++++++++---
 t/t4202-log.sh |  6 ++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 90bcb271687..3fdfa86a5b9 100644
--- a/refs.c
+++ b/refs.c
@@ -455,11 +455,16 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	if (*pattern == '/')
 		BUG("pattern must not start with '/'");
 
-	if (prefix) {
+	if (prefix)
 		strbuf_addstr(&normalized_pattern, prefix);
-	}
-	else if (!starts_with(pattern, "refs/"))
+	else if (!starts_with(pattern, "refs/") &&
+		   strcmp(pattern, "HEAD"))
 		strbuf_addstr(&normalized_pattern, "refs/");
+	/*
+	 * NEEDSWORK: Special case other symrefs such as REBASE_HEAD,
+	 * MERGE_HEAD, etc.
+	 */
+
 	strbuf_addstr(&normalized_pattern, pattern);
 	strbuf_strip_suffix(&normalized_pattern, "/");
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6e663525582..6b7d8e269f7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1025,6 +1025,12 @@ test_expect_success 'decorate-refs and simplify-by-decoration without output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'decorate-refs-exclude HEAD' '
+	git log --decorate=full --oneline \
+		--decorate-refs-exclude="HEAD" >actual &&
+	! grep HEAD actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
gitgitgadget

