Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06678207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 22:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbcI3WSN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:18:13 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32854 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbcI3WSM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:18:12 -0400
Received: by mail-qk0-f195.google.com with SMTP id n66so7139920qkf.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kanM/AUxwbRmP8RVTNV9lpXEya7BbsIDv36Crktn3q4=;
        b=y231WPSgE8pVZNTL18KIggVLilcIqcd/Xivb8Rhmwpk+jOCP2Fd5I5PBx9YYdqZG/P
         BYI5UXPmvKjzVvxceZuKdmG11qoxkc6W2qDSDV9uH2FWNeKpoRrLV32ZiM4DqUpf5o8y
         zkC1NHYHHcqMG8JzLwBZiJj/2yRWDf3i9ZoL86U6twKS/q1tqBMFtR+kEid6GHQDPfx+
         clqsRa/yVUBC4rB8OigCvV4sL3Z5E3biqqa82r7ycXPsQuCXaogaaZKbd2xdW5dMJrVQ
         OTXio+9FvjAdyWmDB+nWWCAytXvbBkiRte9uzN9ppNM7aicXv/qo9rzn9yhdLCoQkmm8
         tWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kanM/AUxwbRmP8RVTNV9lpXEya7BbsIDv36Crktn3q4=;
        b=hTp+j20PO5XaG9u/ofo46+ZBpJohNoq+XE8onswg5pqyxEaEMjAvzWCa0pd7yF2OZ8
         W5pSku68E0UL6I15nPyns25mDy1oqUNEUy2g1Ivj9x36UTOgxSdL30EAgEgZaCtwwJve
         P7+lJdwSqcPymJVJ180Z5eGpY9RGD+1cHHpW9KtF/drR4ci7imRIJIMCm7ZScdnbtr0+
         RHfes+84TMpdfGJwdjSjVhUMTL4b1JrJZfGEb0Ifly2pqrtg0nqyp0BsEvt6uxq4RlSE
         st3S6ooBRjTAxT3PCmZiUbcEpR9CEJGdaNDWiYrKcRghDiZ8qhCRJvtQEVwz0S7h5AKB
         ez2g==
X-Gm-Message-State: AA6/9Rn9JEDvXmMY2PCXivue/GqDgngCMgtb+nTUOPzP4+7VCwenuAFTUb6nx32fI8MZr6tG
X-Received: by 10.55.144.193 with SMTP id s184mr8956069qkd.286.1475273891806;
        Fri, 30 Sep 2016 15:18:11 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id x21sm11347615qkb.19.2016.09.30.15.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:18:11 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Santiago Torres <santiago@nyu.edu>
Subject: [PATCH v3 0/5] Add --format to tag verification
Date:   Fri, 30 Sep 2016 18:18:01 -0400
Message-Id: <20160930221806.3398-1-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Santiago Torres <santiago@nyu.edu>

This is the third iteration of [1][2], and as a result of the discussion
in [3].

In this re-roll we:

* Fixed all the signed-off-by's

[0002]
* Renamed the function format_ref to pretty_print_ref instead, which
  is a more descriptive name 

[0004] 
* Added the respective line for the new --format parameter in the
  documentation.

[0005] 
* Added mention of the --format flag in the documentation files. 
* Fixed the function signatures, now they take an opaque void *cb_data pointer
  so it can be used in a more general way (by e.g., delete_tag).

This patch applies to 2.10.0 and master.

[1] http://public-inbox.org/git/20160922185317.349-1-santiago@nyu.edu/
[2] http://public-inbox.org/git/20160926224233.32702-1-santiago@nyu.edu/
[3] http://public-inbox.org/git/20160607195608.16643-1-santiago@nyu.edu/

Lukas Puehringer (4):
  gpg-interface, tag: add GPG_VERIFY_QUIET flag
  ref-filter: add function to print single ref_array_item
  tag: add format specifier to gpg_verify_tag
  builtin/tag: add --format argument for tag -v

Santiago Torres (1):
  builtin/verify-tag: add --format to verify-tag

 Documentation/git-tag.txt        |  2 +-
 Documentation/git-verify-tag.txt |  2 +-
 builtin/tag.c                    | 34 +++++++++++++++++++++++-----------
 builtin/verify-tag.c             | 13 +++++++++++--
 gpg-interface.h                  |  1 +
 ref-filter.c                     | 10 ++++++++++
 ref-filter.h                     |  3 +++
 tag.c                            | 22 +++++++++++++++-------
 tag.h                            |  4 ++--
 9 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.10.0

