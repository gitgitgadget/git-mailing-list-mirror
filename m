Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D351F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 09:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJKRUf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:20:35 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:41643 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKRUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:20:34 -0400
Received: by mail-ed1-f52.google.com with SMTP id x31-v6so7657689edd.8
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXyIO3vqlc0wqtHQ3Ukc8Yx2BNIFMmJiQmeF13nZs0g=;
        b=eIAmScSWX3hWC9TN2oeof2eFqEEt/SkSEE/HPQmTc8xB1gu7aIIN1JBFptaELX3uFL
         pZ71S9wdOeQJEmK+5rrICc/xV4BQW3uPePOqpRJpOe1iuvHDvnQZRmcJ+92IGiRgNX5+
         5XEdU+mAKiNlwqSEZWR50/RhgrGoYLbA+8t6x99vIbokWSu1J59TfIHQtyeAnETa/ZbN
         hk4ZbpN40vQ60B5ap70dOYu8BzvVxG8wEIa2E40fgGltM8m3btXFu3j5tKbz13cmMD48
         73JEb5rxqGedTte/T3CT2ZgU+zugT6d7wla5QL+wfZmb1JmtCQIltx2vqULUJ0RZ0WAU
         U3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXyIO3vqlc0wqtHQ3Ukc8Yx2BNIFMmJiQmeF13nZs0g=;
        b=Mxue51PUGT+1h5wfQLK1iJvBVHw217MEf+pwuX7U7hziuYQS/0YenY6q3e/0k4OnAo
         lUU/N9NGhOVFAHjZ6cAVK/fmzvxfSpKMtIYFTxDVgun5MJ1HFVKPxyVzp8HOD2Y8ig4j
         6CXonI2PfaVBgmjP3oiO+nHgO1AhflqKh92YBYGvGuidgfcb4U8UVl/8/j+BbJ1FYdTS
         8/XtoUG0eWwpeWdOEsuO+nOViD7/qx6OMR5ieSSi//h2qDVuXGAeI8mfr/D8sErqXBGl
         A/ORnJb5jilJTY4GYAbfpD+mwj/uAKQ8JFwcBbebH26yNyF8NJD8aRreByEw6AeAvHys
         4r3A==
X-Gm-Message-State: ABuFfogyjdoRmsEDBXCk/aCmMNR4YOQ1jFoxtFwLirv1700780/w78bp
        SwvLMDL/CjSHrA9q0xK0N+4=
X-Google-Smtp-Source: ACcGV60rYUdArKCOhm/Iu0HI5MULlam1IKHfeNVrAGSsrqKdg7c5JJYy7gkuzIFZVN3rf/CjMVYRBg==
X-Received: by 2002:a50:a1c6:: with SMTP id 64-v6mr1719554edk.88.1539251641091;
        Thu, 11 Oct 2018 02:54:01 -0700 (PDT)
Received: from localhost.localdomain (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id y8-v6sm9793574edd.43.2018.10.11.02.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Oct 2018 02:53:59 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 7/6] split-index: BUG() when cache entry refers to non-existing shared entry
Date:   Thu, 11 Oct 2018 11:53:57 +0200
Message-Id: <20181011095357.19061-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20181011094309.18626-1-szeder.dev@gmail.com>
References: <20181011094309.18626-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the split index feature is in use, then a cache entry is:

  - either only present in the split index, in which case its 'index'
    field must be 0,

  - or it should refer to an existing entry in the shared index, i.e.
    the 'index' field can't be greater than the size of the shared
    index.

If a cache entry were to refer to a non-existing entry in the shared
index, then that's a sign of something being wrong in the index state,
either as a result of a bug in dealing with the split/shared index
entries, or perhaps a (potentially unrelated) memory corruption issue.

prepare_to_write_split_index() already has a condition to catch cache
entries with such bogus 'index' field, but instead of calling BUG() it
just sets cache entry's 'index = 0', and the entry will then be
written to the new split index.

Don't write a new index file from bogus index state, and call BUG()
upon encountering an cache entry referring to a non-existing shared
index entry.

Running the test suite repeatedly with 'GIT_TEST_SPLIT_INDEX=yes'
doesn't trigger this condition.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

A follow-up to:

  https://public-inbox.org/git/20180927134324.GI27036@localhost/


 split-index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/split-index.c b/split-index.c
index 875f538802..5820412dc5 100644
--- a/split-index.c
+++ b/split-index.c
@@ -254,8 +254,8 @@ void prepare_to_write_split_index(struct index_state *istate)
 				continue;
 			}
 			if (ce->index > si->base->cache_nr) {
-				ce->index = 0;
-				continue;
+				BUG("ce refers to a shared ce at %d, which is beyond the shared index size %d",
+				    ce->index, si->base->cache_nr);
 			}
 			ce->ce_flags |= CE_MATCHED; /* or "shared" */
 			base = si->base->cache[ce->index - 1];
-- 
2.19.1.465.gaff195083f

