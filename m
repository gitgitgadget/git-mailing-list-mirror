Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB9F1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 10:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeIXQHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 12:07:40 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:23140 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXQHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 12:07:40 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 4NkrgLWW7VlGZ4NkxgJ4sd; Mon, 24 Sep 2018 11:06:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1537783580;
        bh=sZ0MdzRN9XU7qoXANY6Zn6ksck5KQhi8YrdT7hzO9Xk=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=G8VkMQCkTfDSQ/WgU5A7W3OkyXI9AVT6IzCyANd+l9TfQl3RJjBsZyS3tF0+J1On+
         RGJPOIjqZnfKeLqusC0w/WlMqhvCqHKRooNyDvxa+tawvU3em43pFpXWf9kcnVocAk
         focKbJ9eVIOYh2ug8b2gsWeRwgPLeBwCl37RqHzw=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=ugi3KpegOajN2ndcFm4A:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 0/3] diff --color-moved-ws: allow mixed spaces and tabs in indentation change
Date:   Mon, 24 Sep 2018 11:06:01 +0100
Message-Id: <20180924100604.32208-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBECOW0T45mzv/T5OJx99sLabTROkhqCGyisLOsWXz7s4xvOwVzwlWuPT0FuB95w+LYYTjWpYBkeV/f23ixV4lw6939+qbPVp2XAcA4wVCezqDQsH1p8
 faJpCjeIGuJqN3t2+f5FfWK/ewNplXVzogCVSWcGrEL9mA2jYPAXp5FqRbfU5eGRNWWiIDgm1gq+XZTphJziJXIw97kCnl61xbOKvIm3kh4CdVZbfAaV8U/5
 JjECKt2Qnm5yFRHAzucBPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When trying out the new --color-moved-ws=allow-indentation-change I
was disappointed to discover it did not work if the indentation
contains a mix of spaces and tabs. This series adds a new option that
does. It's and RFC as there are some open questions about how to
proceed, see the last patch for details. Once there's a clearer way
forward I'll reroll with some documentation changes.

Phillip Wood (3):
  xdiff-interface: make xdl_blankline() available
  diff.c: remove unused variables
  diff: add --color-moved-ws=allow-mixed-indentation-change

 diff.c                     | 124 ++++++++++++++++++++++++++++++++-----
 diff.h                     |   1 +
 t/t4015-diff-whitespace.sh |  89 ++++++++++++++++++++++++++
 xdiff-interface.c          |   5 ++
 xdiff-interface.h          |   5 ++
 5 files changed, 208 insertions(+), 16 deletions(-)

-- 
2.19.0

