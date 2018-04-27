Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B59D1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758704AbeD0RF1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:05:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37551 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758554AbeD0RFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:05:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id c14-v6so2428363wrd.4
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=oD+F90q9g+yWI24wcaHc6m6tO6OE9c3GCUJcwgWT+SM=;
        b=Vqisx44uF/G9YkrtSY+asAMsgmSrC7swjZp+6AgbYVz3E6zVChJjj7Rof2M6caXNtP
         rV3TdJMJcb9Jhb7afAEC3tgqn4o5LmmvgiYTH/Er7k5S+vHyqnIDghmA7ftsF4mik5zC
         C7vQ1oDvNkXY8DrtkezbXbtsSedyZrT/pKlEsuUyP4hn5T3szPi+qEyFeoXLrizUap9n
         9ZLtUh49AOq3C20DlscsRhX8JTAysDu+0CjZ8T2rk0TqZcq082YceTNSIju89rgO5ib0
         MUqST4eFJHd194QH8Pe6DmXI9SHBIHQx/P/qsWekJzLIwz75ENQjbVEU+aHt52JLkZof
         HsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oD+F90q9g+yWI24wcaHc6m6tO6OE9c3GCUJcwgWT+SM=;
        b=Zd4ySphlXXPHJWwR+z+E34PoXrXzfwPPVjgW/rfSJOrwx8vi3e9as0QVyiZ7Ez3QO9
         AfU4qvihytIip+v1o9bNk5aHRserCVDFjJ0JGa3Ca8Tc3Qtr1ozx4GgaHwzpRVqA5X8y
         1Wbz1jlx6BFBpOpncTZu8r2EWLMNtMFIlXhkNJWJGuEYyjOzd+BI4vcZQvJ7B2PCheMC
         QCCIOUtf9nowrrQBMb9H9Q14MeMS4S5A4WcGmnk5y1Fj1IG6HmnQfKBLu7ON23IM+/80
         wG1eBESIfana8OoiRvSsuVtTgGPXX6kJQLaZU3l9gzg4f43bDUBQT9/RLJf6PzQRvwAW
         ZI7g==
X-Gm-Message-State: ALQs6tDWCiqWYd1qC5ar2HKZOEcZ7wKfzamRk73Btd8/+iM4Sexoutkr
        ugft13FGv1IQec6c0IW/Kn22BXoc
X-Google-Smtp-Source: AB8JxZpCkgyyhejhdHQFMmB8pbx4nZ/0+LFj01jU/BQrpB9OLZh0poivBATIKO9fVXwM7F3eCSLCtw==
X-Received: by 2002:adf:8d90:: with SMTP id o16-v6mr2358702wrb.81.1524848722714;
        Fri, 27 Apr 2018 10:05:22 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.gmail.com with ESMTPSA id o10-v6sm1765745wrg.90.2018.04.27.10.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 10:05:22 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 2/6] doc: align 'diff --no-index' in text with synopsis
Date:   Fri, 27 Apr 2018 19:04:36 +0200
Message-Id: <20180427170440.30418-3-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180427170440.30418-1-asheiduk@gmail.com>
References: <20180427170440.30418-1-asheiduk@gmail.com>
In-Reply-To: <20180410183224.10780-1-asheiduk@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two '<path>' parameters are not optional but the option
'--no-index' is. Also move the `--options` part to the same
place where the other variants show them.

All three items are already correct in the synopsis.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
Reviewed-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-diff.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b0c1bb95c8..6593b58299 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git diff' [options] --cached [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
 'git diff' [options] <blob> <blob>
-'git diff' [options] [--no-index] [--] <path> <path>
+'git diff' [options] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
@@ -29,7 +29,7 @@ two blob objects, or changes between two files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' --no-index [--options] [--] [<path>...]::
+'git diff' [--options] --no-index [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
-- 
2.16.2

