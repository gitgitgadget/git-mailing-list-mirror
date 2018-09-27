Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219A91F453
	for <e@80x24.org>; Thu, 27 Sep 2018 21:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeI1Drx (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:47:53 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:41809 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1Drx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:47:53 -0400
Received: by mail-vk1-f202.google.com with SMTP id d189-v6so1075628vka.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TIucuAgmYQb/kQCWkIDnpdggh0EYVE0IvPXrtszmnIQ=;
        b=LtKwr4h9RWFGxd55VSmxlIGdvjCJAqNAAaAppY4tGdDl+M3nX/08yPWuhLyjMJ+v1u
         UyUAy/pNNgNUb/fj5nJ1TC16OBxDB3ZqOBSARySUciD+XKE/zDVNg9ZyOaRaMvTxn2Ms
         T+b1MzBAWLOUaW1UfeoCJKnFOtus3DTWVSz9aq4JGnTSHWSVceXYmPWR0VDc+QaiK7e4
         nWJ5StAzFQMzBJ3ntkiucg+vxfnlDmjwMIUeSBebx9IFeoS7oNv6als4RM0e/17/mGAM
         ffcj7G+BBZ7m/4EpcCygJc9yrkI0RQ1O2BddJT2LR9ioqdrabjU3Tnm4+yGAonNwVtY9
         ibdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TIucuAgmYQb/kQCWkIDnpdggh0EYVE0IvPXrtszmnIQ=;
        b=pEFIRZvULBn1OSR86LlIoYybr9jHbCuS6bG8aa0OIVhprE8mKIKZWJQiFa4140+qNo
         lNELemzlNl+DVmrqyc6qtiagg2C3iiFNchXuqlfGLC4c+VCPhRcnp5aNp6G6h5uNT1j9
         WPcdcKCXlV1S0XX1JiP8NEv5nDuzN7ES+rwfpmijP8f0AwNgS359EWnorHd5snZkthdC
         GNObF0rWO8/lwtKigf0cj+L6QypaqfpDBJQRohG4byzJ6CPLQYGgTgIJdyqSL2lg50MT
         HVTlrG5BIjwjA4+nICaS4QPQze2nGQW79foGR6yreBNh3exOS0IKrgG71awfbC1sljMx
         zUEA==
X-Gm-Message-State: ABuFfoh2Hzen4qPyf4omMCzlUaQ7XqZNZpwUIMRadWo0o4Hfo+tW4hpY
        yXxAHb81Eh+7pq/7FWT6Et4VnM/L0Jc+
X-Google-Smtp-Source: ACcGV607EdHzt/bCk2oLe1RCqEjvbjtQRVKL5ePt11VETC8QsYuR/DfbqUgx0dpz7pzBtGaKqG5hyHZ2rkuR
X-Received: by 2002:a9f:300d:: with SMTP id h13-v6mr7217188uab.9.1538083656725;
 Thu, 27 Sep 2018 14:27:36 -0700 (PDT)
Date:   Thu, 27 Sep 2018 14:27:27 -0700
In-Reply-To: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180927212727.128214-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] Documentation/CodingGuidelines: How to document new APIs
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are different opinions on how to document an API properly.
Discussion turns out nobody disagrees with documenting new APIs on the
function level in the header file and high level concepts in
Documentation/technical, so let's state that in the guidelines.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This is how I would approach the documentation patch.
 
 Thanks,
 Stefan
 
 Documentation/CodingGuidelines | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
 
diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfbd..15bfb8bbb8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -358,7 +358,10 @@ For C programs:
    string_list for sorted string lists, a hash map (mapping struct
    objects) named "struct decorate", amongst other things.
 
- - When you come up with an API, document it.
+ - When you come up with an API, document the functions in the header
+   and highlevel concepts in Documentation/technical/. Note that this
+   directory still contains function level documentation as historically
+   everything was documented there.
 
  - The first #include in C files, except in platform specific compat/
    implementations, must be either "git-compat-util.h", "cache.h" or
-- 
2.19.0

