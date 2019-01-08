Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98F91F803
	for <e@80x24.org>; Tue,  8 Jan 2019 00:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfAHARN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 19:17:13 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56396 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAHARN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 19:17:13 -0500
Received: by mail-pf1-f202.google.com with SMTP id n17so1380068pfk.23
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ez49FlYV64KICg62+p9iVxLZxGlZlmhlMWil+tktMpk=;
        b=MA4oy3CPYaZ+0d+br8ryfRQ55Nu0n+/eGpuYDq24QZOiQqJejms5sUJLTexUOsII8Q
         h1a68FZCdloC9D8VAtGOI7g35ryK1UU7kRK2YilMDAZAQucc7v/gwBm3pcV/WPIFsaH+
         FBNx5kEEFEHz5lTZrdr6sfRMaFmbYR1AvUWW62QDyqZPP0AYMsWIjV1Zf5BrwP3K2DTX
         BBT9myc2/o7AZJi5Jk+vxBhL6Ws+KdSR554cinErmZ30If6XVMM6rdykzWUsFGasAi5O
         FXnF0YCPalU6PzIO2YlQzqeBbJGfynnDThJYk3mQQjHiwuZtK7x8WZnU5aVuyj/kJ/xT
         JaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ez49FlYV64KICg62+p9iVxLZxGlZlmhlMWil+tktMpk=;
        b=hQ5kCEJRaVoXyHdRh+imxWpSACokaAYaY7x7Wzg1Xr9oW4jhZBt2jDtSh2N4X7Mhnh
         pLjiULg/NdX9H6BNj3v0XRO/PSpaCumZ0pVBLTWA053mswFzdjdPuW3cVBjddvrQJ2ri
         6OP7wtLroq8KNELuuSbWjlQ6i9EtzN372vcOE+zYeherDEbAPYk/yFRpLpU1aMNgOQSJ
         tC0mrE2wEJiJxFCBGUP/h9flVLSIzxM7LdqwOV+2kO9BhLtxXe8gToT3sBt+Er/Hbf0l
         T27Ja9S9z9cC41ihfQ10zuoWH30AAkWMEDwEj/nFGIgTR45uuR8plGvUxKb8RcAnStV5
         4Jbw==
X-Gm-Message-State: AA+aEWY8W3xsuc2IfzpjyBD0VNZ+bvVD95jk+WnMmWFr4rysqymhfPJ4
        3KJZnyQg2oGIjLu76waB/pDz0z2pN/hMXHYVgF+r6472LPHHAOAhhjJen294DotZk/e9AVOQvBe
        ErjulF7LNv7r6lItJFIC9DPnLSwtW/m77jLCvdhUhrgAL42L1Uy9DYCc7QAGINQE=
X-Google-Smtp-Source: AFSGD/X3DKDNQs2Io0iiRMpyoi+Z3l40jZJ9/hfVLIFbwanRo53bMmTsUU0rl4WU4aA1HJIiKewv+r4qNAUtTQ==
X-Received: by 2002:a62:5042:: with SMTP id e63mr28171245pfb.51.1546906632428;
 Mon, 07 Jan 2019 16:17:12 -0800 (PST)
Date:   Mon,  7 Jan 2019 16:17:08 -0800
In-Reply-To: <cover.1545261186.git.steadmon@google.com>
Message-Id: <cover.1546906008.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1545261186.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 0/1] Expand abbreviated filters
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NOTE: this patch is based on top of md/list-objects-filter-by-depth

Currently, git clients pass filter specs verbatim over the network and
to subprocesses. We support various scaling suffixes for parameters on
these limits (via git_parse_ulong()), but other implementations may not
support the same suffixes. It would be better to only pass fully-
expanded numbers in this case, and keep the expansion logic completely
on the client side.

This patch updates the protocol-v2 doc to specify that clients SHOULD
expand abbreviations in filter specifications before passing them to
other processes. It adds a new function
"expand_list_objects_filter_spec()" in list-objects-filter-options.c
that implements the expansion logic, and updates users of the
filter_spec field to instead expand the spec first.

Changes since V1:
  * Changed "MUST" to "SHOULD" in protocol-v2.txt
  * Noted specific suffixes that receivers SHOULD accept

Josh Steadmon (1):
  filter-options: Expand abbreviated numbers

 Documentation/technical/protocol-v2.txt |  8 +++++++-
 builtin/clone.c                         |  6 +++++-
 builtin/fetch.c                         |  7 ++++++-
 fetch-pack.c                            | 15 ++++++++++++---
 list-objects-filter-options.c           | 20 ++++++++++++++++++--
 list-objects-filter-options.h           | 17 +++++++++++++++--
 t/t6112-rev-list-filters-objects.sh     | 17 +++++++++++++++++
 transport-helper.c                      | 13 +++++++++----
 upload-pack.c                           |  7 +++++--
 9 files changed, 94 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  d324e78369 ! 1:  d35827de35 filter-options: Expand abbreviated numbers
    @@ -20,10 +20,13 @@
      	using one of several filtering techniques. These are intended
      	for use with partial clone and partial fetch operations. See
     -	`rev-list` for possible "filter-spec" values.
    -+	`rev-list` for possible "filter-spec" values. Clients MUST
    -+	translate abbreviated numbers (e.g. "1k") into fully-expanded
    -+	numbers (e.g. "1024") on the client side, so that the server
    -+	does not need to implement unit parsing.
    ++	`rev-list` for possible "filter-spec" values. When communicating
    ++	with other processes, senders SHOULD translate scaled integers
    ++	(e.g. "1k") into a fully-expanded form (e.g. "1024") to aid
    ++	interoperability with older receivers that may not understand
    ++	newly-invented scaling suffixes. However, receivers SHOULD
    ++	accept the following suffixes: 'k', 'm', and 'g' for 1024,
    ++	1048576, and 1073741824, respectively.
      
      If the 'ref-in-want' feature is advertised, the following argument can
      be included in the client's request as well as the potential addition of
-- 
2.20.1.97.g81188d93c3-goog

