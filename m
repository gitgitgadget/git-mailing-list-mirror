Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2771B1F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEEQYb (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:24:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34725 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:24:30 -0400
Received: by mail-it1-f193.google.com with SMTP id p18so12505920itm.1
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zCDDeaQj1lN6Q5/L/3iC9LpWJ5qMts2LP8tENdpS1l0=;
        b=Avm/7PSfccvWdYLE4oZs6j22E+c5uaDct4LXlBYOe6hqSis7wPCcW88cAIerkRa9Sx
         TlPNnhLZJqQ8qdOBbz7hxitCxclDJti4a1UUaEkyX3c0gB/aonQ2EZdFNGtWywfPUfWC
         NZYWo1vFeYXZGouFZ0A4imw/oDKHcr6ugZUIHlTjaH4qQbkyMXRv8PMzjWWx9btP3uy3
         NCF0Wc1WL5SmvAEi+jvc1qW0UgibswyoJPLNY/OgmkQWxxvD9070Z6auc8smY+fg6rAH
         Denak0yYEWq8md3zXmgGIcodeuAJH23Rjd+7NuBi2fBANi3GKX0SjyN+skRAQc2qC+mh
         OC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zCDDeaQj1lN6Q5/L/3iC9LpWJ5qMts2LP8tENdpS1l0=;
        b=VK5kHGWau1ze4Z8izL7ZECDO+1E/QykdqOjd4cxi7epBxs08CSV6hUy1YX3zPXhTFA
         dIO4KkZ7ytQDEfjrl8h+ZDrj3kw90f/SmXrwXZEwmX2/N5iJFNck3fYGdW9WSTM0pJt+
         0D7n4aBgwV+mZcXErbAgbpoUWyWzaHt3fncHg9iK7tqEDX23HbZLJQ9YoZrBxaTD8gpA
         AqHyFv/l8JFi78VfavTtuRJt3e4EJXG9oKMijblwh08fOsy9iV/j+C1u6g/cXZZ1n5HE
         omkum47YKFIUrc05HqMia56L5hlQd1QixHXkRELDM6qp20m/wvlKSZ6GMzSvCydOrj97
         mEbw==
X-Gm-Message-State: APjAAAWDufXfQ9PbHWRXuhxAHTo8u5U0mlfVQphMg7PM3RG47V/4Y9tF
        jkeI2oaU4ATHo5WHw0znLXdQ/buw
X-Google-Smtp-Source: APXvYqzjkRjWE0opyaFMo4j9YXsTxcjoO/8Xrt6h7dmftvQAyD9F7/Isfv0UqCuIXiEop+gnD0WhUg==
X-Received: by 2002:a24:99c3:: with SMTP id a186mr13057148ite.52.1557073469736;
        Sun, 05 May 2019 09:24:29 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id q135sm3825619itb.39.2019.05.05.09.24.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:24:29 -0700 (PDT)
Date:   Sun, 5 May 2019 12:24:26 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/7] teach branch-specific options for format-patch
Message-ID: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, format-patch only accepts branch.<name>.description as a
branch-specific configuration variable. However, there are many other
options which would be useful to have on a branch-by-branch basis,
namely cover letter subject and To: and Cc: headers.

Teach format-patch to recognise these branch-specific configuration
options.

Note that this patchset[1] was created using these new configuration
options:

	[branch "submitted/fix-revisions-txt"]
		coverSubject = "cleanup revisions.txt"
		cc = "Andreas Heiduk <asheiduk@gmail.com>"
		cc = "Duy Nguyen <pclouds@gmail.com>"
		cc = "Junio C Hamano <gitster@pobox.com>"

So this is a live example of this patchset working in practice.

[1]: https://public-inbox.org/git/cover.1557072286.git.liu.denton@gmail.com/

Denton Liu (7):
  t4014: clean up style
  Doc: add more detail for git-format-patch
  branch.c: extract read_branch_config function
  format-patch: make cover letter subject configurable
  format-patch: move extra_headers logic later
  string-list: create string_list_append_all
  format-patch: read branch-specific To: and Cc: headers

 Documentation/config/branch.txt    |  10 +
 Documentation/git-format-patch.txt |  33 +-
 branch.c                           |  14 +-
 branch.h                           |   5 +
 builtin/log.c                      | 147 ++++--
 string-list.c                      |   9 +
 string-list.h                      |   7 +
 t/t4014-format-patch.sh            | 708 +++++++++++++++++------------
 t/t9902-completion.sh              |   5 +-
 9 files changed, 590 insertions(+), 348 deletions(-)

-- 
2.21.0.1049.geb646f7864

