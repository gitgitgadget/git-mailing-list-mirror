Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D761F954
	for <e@80x24.org>; Mon, 20 Aug 2018 13:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeHTQeZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 12:34:25 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52025 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeHTQeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 12:34:25 -0400
Received: by mail-yw1-f73.google.com with SMTP id v14-v6so9553228ywv.18
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Qcz/NYynuVi8GI4pe1/k5Dx26+K6Ko8D9Qc8bSJ8uj0=;
        b=nngeqRGnqe125ibwt4yyJstr/nLTMLr9TbXKlEpdSWg+XgQXHWWdi3jG/cHL3qSNT/
         wnsVBhBlQmF5kgRkn2lQx3Axk0cobIxdlDKf+An/6oeyXZOhi2POmU0YLTu+wfEeKQkn
         pxkF2uMsCv7TeJ59E9rcu5BL4ktjLp9HoeufKwOwG6aYVr/zQpg45MeT8kO5Gom15jGV
         ZoIV12/H78lLW3AhxbUwzdHmqQV9I6wOSjvzAG9ww1uJNX7T0Lm/aTl3ayzPRk4bhRoX
         5904tmW5NEqfD2brSMP/47rotXbbv+epQSRlm6K14bWP5gjZRm5b4XKqKbr8zGBs/GSY
         ALeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Qcz/NYynuVi8GI4pe1/k5Dx26+K6Ko8D9Qc8bSJ8uj0=;
        b=stCG9DSUFS03U6Rs7MhliCF16bzpd+eZCgMT+ca2L2ZT4KTQ2xHEGqsb8zIyIGsuj8
         htI7f4VnLBas13fzSf6QROZ6vse80q/lF5BaeNvcSIvA9KFrHZIv/r4Vsl1oZ9AGjUPC
         0QPAgy3GGZZ+homH0BYTUZJjTYfeeF9mPjXdIBAT/0C1P09USG3ESNGgVJiHhwbqHVnn
         WVU56Z87GqZRct6hzk3PKodo6uLSQNElaZDDbwkLfm979UwjwuJHWD8l6EioCAnN3wcg
         yalmv492aInX/y4XiXx4q5sahZErgZek9LipDFHlwl8tmS/nNb/VJZCrQT7dmW7w7khB
         BQGQ==
X-Gm-Message-State: AOUpUlFfUFIf8nN2w1SR6PZze0OQsIgcXj4uEf82IHpalDmJIjnGHzZk
        sjrdOvhG2MPlZQaSYgjWuh8ToM7aPZE=
X-Google-Smtp-Source: AA+uWPxKQRO39lmmcF9LrBflmIwmfBiOkAmQQJru82p+/v5Z+bqAgbHxoQ8uKjd8id7kytiDKGN+GZsORQR4
MIME-Version: 1.0
X-Received: by 2002:a0d:c207:: with SMTP id e7-v6mr13904297ywd.154.1534771128110;
 Mon, 20 Aug 2018 06:18:48 -0700 (PDT)
Date:   Mon, 20 Aug 2018 06:04:25 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <msg.1534770125.matvore@google.com>
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com> <CACsJy8AE+MwBzzUFRGLKVp6vaAg2W_KO-qbUU2LQpd=rMQw2sA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
From:   Matthew DeVore <matvore@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were many instances in this file where it seemed like BUG would be
better, so I created a new commit before this one to switch them over. The
interdiff is below.

BTW, why are there so many instances of "die" without "_"? I expect all
errors that may be caused by a user to be localized.

I'm going by the output of this: grep -IrE '\Wdie\([^_]' --exclude-dir=t

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 8e3caf5bf..09b2b05d5 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -44,8 +44,7 @@ static enum list_objects_filter_result filter_blobs_none(

  	switch (filter_situation) {
  	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);

  	case LOFS_BEGIN_TREE:
  		assert(obj->type == OBJ_TREE);
@@ -99,8 +98,7 @@ static enum list_objects_filter_result filter_trees_none(

  	switch (filter_situation) {
  	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);

  	case LOFS_BEGIN_TREE:
  	case LOFS_BLOB:
@@ -151,8 +149,7 @@ static enum list_objects_filter_result  
filter_blobs_limit(

  	switch (filter_situation) {
  	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);

  	case LOFS_BEGIN_TREE:
  		assert(obj->type == OBJ_TREE);
@@ -257,8 +254,7 @@ static enum list_objects_filter_result filter_sparse(

  	switch (filter_situation) {
  	default:
-		die("unknown filter_situation");
-		return LOFR_ZERO;
+		BUG("unknown filter_situation: %d", filter_situation);

  	case LOFS_BEGIN_TREE:
  		assert(obj->type == OBJ_TREE);
@@ -439,7 +435,7 @@ void *list_objects_filter__init(
  	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);

  	if (filter_options->choice >= LOFC__COUNT)
-		die("invalid list-objects filter choice: %d",
+		BUG("invalid list-objects filter choice: %d",
  		    filter_options->choice);

  	init_fn = s_filters[filter_options->choice];
