Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFE31F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeHJVfG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:35:06 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:35569 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeHJVfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:35:05 -0400
Received: by mail-oi0-f73.google.com with SMTP id v4-v6so10138536oix.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rESlQViwual54a72SmAQyy8YAMol0qAr+KfRwA4Xsbk=;
        b=HwC53dhYj3ahesxEs7pc6iTr//EE3flpMDl48X36mhjGo3RQw3Apr8knPQp4e9Kj0i
         Ae16SZBELSy9GELdY/aOyfdVgMRCt6wGmY5exeyfYU2LaPDdHFggFzpM5BNX6+GOgjxC
         s2GsQFZNVk6JwZUke1LxtMbl1RrxSRE9nQGmvnozDdIXATBZ+4znrSh7uOO4NjMkICbZ
         Ahli7OeNWKeNsCR0q7x8BRLd9Vfx9xACDTHYqMZTIyBBUfv5autEYUs0q4ZT4do31yhC
         oVU0P9ag8nYkbdcKTwagUNdwzTCy30KXDnmaomUTzYErmxkIMiC5fY/ZCgTxu6aKRlBv
         XT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rESlQViwual54a72SmAQyy8YAMol0qAr+KfRwA4Xsbk=;
        b=pzFdWMTAkq25wOYF9nB/CcbLO0je+katpoofVwgFIJstwA42oaKbU3F4majNiSWH/b
         5JP3+OUOAWT5PSdZr1Dui3Allx/GWPbWGZjPvP0wiXgckVM1HJVvW0kVmUWA0JznNxbW
         FR2pPIso+meND4O0BVRtRoRjCGRdElcviOMH23657z/levTPk251IhIn5S3EzgWvrH3S
         6SmuR7Ib+sa2+qfMV5muybTXUmN240UXD0g26qv7oGn5lUGnKNV40rvy/Glkqb9ELxfQ
         D4wTb3CA4SH/0w9dPEf3htECKuvkZXgKlcZVxWHUs0i6Vw3+L8wLfWz4unbRSKQroJtG
         BzmA==
X-Gm-Message-State: AOUpUlEKZXel/wpvcPQiub2pomhpimLWonZT0nQwaKb+c22222Qq1y5G
        3X7cCn9zAp5/wk2JZK4Ngw4Xz9t9h/gqigwIiTBK
X-Google-Smtp-Source: AA+uWPxwyzwkAoJmv9HrkRdozUP5S+YyddIh5ik+2B4Q0iu2mhgPOKfwwVennvhvacmHKV308I51l5OE3ZGI16LFxBod
X-Received: by 2002:aca:4749:: with SMTP id u70-v6mr4730926oia.25.1533927838140;
 Fri, 10 Aug 2018 12:03:58 -0700 (PDT)
Date:   Fri, 10 Aug 2018 12:03:52 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <20180810190352.62705-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [RFC PATCH 0/5] filter: support for excluding all trees and blobs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Matthew DeVore (5):
>   revision: invert meaning of the USER_GIVEN flag
>   list-objects-filter: implement filter only:commits
>   list-objects: store common func args in struct
>   list-objects: refactor to process_tree_contents
>   rev-list: handle missing tree objects properly

Firstly, run every patch with "make DEVELOPER=1" - there is at least one
"mixed declarations and code", which the Git coding style does not
allow.

I've already replied to patches 1, 2, and 5. Patches 3 and 4 look OK to
me and seem like good changes (patch 4, in addition to reducing
indentation, also reduces the scope of the local variables - so it is a
good change).

One last thing is that I'm not sure that this order of patches is the
best order - in particular, if I run the tests at the 5th patch using a
binary compiled at the 4th patch, I notice that cloning with
"--filter=only:commits" fails with a cryptic error "fatal: bad tree
object e891efadd67ca0c01b1c518a2fd91130d40f5904". This makes bisecting
for errors difficult, but perhaps with this problem manifesting in only
a few commits, it is not so bad.

The ideal order is to put patches 3-5 before 1-2. I've tried the
rearrangement myself and found many instances where I had to rewrite
code because one patch introduces "ctx" and the other, NOT_USER_GIVEN.
So as a reviewer, I'm on the fence about suggesting that the patches be
reordered.
