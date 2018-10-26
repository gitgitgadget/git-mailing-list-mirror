Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0636D1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJ0DgC (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 23:36:02 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:43938 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ0DgC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 23:36:02 -0400
Received: by mail-qk1-f201.google.com with SMTP id n64-v6so2049118qkd.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=am5J/KuXZnc6YCu4ESifmjQ2DTb9L5kGnd+faYUBbw8=;
        b=mUVLmcCdmBdSixVErlf/+5PdWNzTrg3PmeBw9WPiWEGTync/zDfpn5r3kHQNVioQJ9
         QRmNCx2QoF+SxsfFafQvuCrOhhN4pUlgF4pFLAVqNxMSIxTccK0ZVJUAjErZIIYzhr4O
         F6fRccygJxYaQq5y/qL4zdMWgMyhFHVlSbKEKdaAsqNTvfc0cvPYuhArlenTLhTP1ulQ
         OytWF8M5q+ZfbmAN4YKa+wdeK8z4iXgzDyZCG1bpFNTsRjdpmGtCdfjLjJxjCdxkxkA4
         nWTkRBmMe37u8gv0X3ht+k4zbv7l3a9rnlTRklIhCHfzSq4cI/HSsmwgLWy2n1Bb2yA2
         JPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=am5J/KuXZnc6YCu4ESifmjQ2DTb9L5kGnd+faYUBbw8=;
        b=j4mpdfXN6mSKSZe1y6p0BBqAWJvKi3aImoRI1slwHtpwagAFvGBRxrU+KXzdt5SJ+E
         l31sj0mQQ0NAs9ebZ6CAu7hjNw8PjtTbqyzpTnMVuJNLY3NT081TCOcaxuiMogYukQqR
         KkTipyhG/q023OJTzV1rcignlps54OFj6PBwDsbE0JPm0HJU9jKk1Hj3Vnx3pv/2gB9d
         RwNTgFW8AotnPy9gb8kYYPssCyJWkh+Xz0rWDPIFEmcRs/khQ/vtUfq4j2jzXXKgeeBY
         p7kLJqYB9sDiXKJ+xiDzhlJ2q+GkXpKTp0lJHKhXr7D9heHGUls+GBboHYE4nPb/Jr1R
         WteA==
X-Gm-Message-State: AGRZ1gLoTJDu8qvt/9lxj94zD4TntKYR3+KJhg72+KQ8LVBIi2BvwcP3
        TykSvG38SLSoNTw4MUDpCoucaCahqYAPKbAcaY8b
X-Google-Smtp-Source: AJdET5cY2pXAfpHdpAhLq6oSJ/saOPOUdNgbWe7IX/X+c7EeiHy2+A/nWWaHdUleIfKKVKq274cVQwibmu7yspvwBtlc
X-Received: by 2002:a0c:9e2e:: with SMTP id p46mr3766151qve.22.1540580270585;
 Fri, 26 Oct 2018 11:57:50 -0700 (PDT)
Date:   Fri, 26 Oct 2018 11:57:47 -0700
In-Reply-To: <20181025233231.102245-6-sbeller@google.com>
Message-Id: <20181026185747.259713-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-6-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 05/10] submodule: store OIDs in changed_submodule_names
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Probably better not to include such lines, especially since the review
by me is not yet complete.

Having said that, patches 1-5 look good to me. Patches 1-3 are identical
to the previous version, which I have already reviewed. In patch 4,
Stefan made the code change I suggested [1].

In this patch, compared to the previous version which I have already
reviewed [2], the code is unchanged aside from some variable renaming. I
suggested a commit title change which Stefan has done.

[1] https://public-inbox.org/git/20181017212624.196598-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/20181017214534.199890-1-jonathantanmy@google.com/
