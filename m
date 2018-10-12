Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C6B1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 01:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJLIcY (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 04:32:24 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:50647 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbeJLIcY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 04:32:24 -0400
Received: by mail-it1-f201.google.com with SMTP id h20-v6so11381688ita.0
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hb4F94ckwYP1Cd/8ERmbnmwF6fbW9XoyrYe/5QQfqxE=;
        b=k/WspKtzdRqekEzKdMeH05Cv2pO5WfHInELAJh79bm/vtYDY40PWUwcxQXO9lBa4oo
         vGTktrIIpzNLOnRU5HwLcCctILGp28xI5TB5u75yviO8SSi0sygvSD0bRO0oF7VXrlNx
         Yk23lm8XPrmLAh0hgMKDzKkkfJgHiZYWolR9XzCQH0Kf3yrEeteYjBFc8w/n2zRoYSlG
         Dzkppym1O7mL+7cyqIAGCOfY5DukWitleMax0uAGL7HHrLkjnbb/fYrt6qVpE4g9MXS9
         eP4aZNnwz/oJGnQdYxQxuGV0U0TpUpNagJTeX81qAUJUut/jpp+bNIQLX/NBj0dYvamu
         nigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hb4F94ckwYP1Cd/8ERmbnmwF6fbW9XoyrYe/5QQfqxE=;
        b=MP29Utvd11trHHtFpkEH2KJvX/kH6kNv3Su2s04nbHnftFNVeFzG+41ANf1KvzQUn3
         JfY5ijNKUcQmJvNLFjnPnchtrVo+N9RNR7qBfSXHDC/Wu3uDOa1cN4h4062huiN4ktY+
         ZfOYiWV2EOzsgvTdrFX/atIfzF+pJ9a2el2wnd/40ZHaihNZsS3CxfY+GNLUCDqCxOyE
         4X4n8V8IqQ3jKxuo6R4spC4d+byrz0hKh8SGJagARrhWtWlh3tf8UkNHzj3E8SYjO92o
         mo6Vo5ctgQCCypXbIN8R3JekL+L7H058AZ3rk04ueoeLSyINZpXj24lP474aWnTyu8Ow
         Wyig==
X-Gm-Message-State: ABuFfohfyGlFmDZ+VrgWDGG0ax3SWVDddzX/B4lSyn+GORTiA8qOgLNM
        Ik3eiNvtIBls0NW4udZl4l8THCpfig5AHlwzY7wqgadv+IlK8pLKGXVBSVZeTAt3haLJkP6XKz7
        NZizTftDA+CpFVJ0ndE70iMcCGhBMVps6NY6rcTpG/xbe6yGnDYGqU8c2pSVsjEY=
X-Google-Smtp-Source: ACcGV621hDz0bxj5Rvj1oyL0NXKkkFJuCE4m382VcbJluWw3Cs9Q0K4vgPKDzKNDGopEC4dvSZnQmp4EW4zAJw==
X-Received: by 2002:a24:5517:: with SMTP id e23-v6mr6363756itb.1.1539306153290;
 Thu, 11 Oct 2018 18:02:33 -0700 (PDT)
Date:   Thu, 11 Oct 2018 18:02:14 -0700
In-Reply-To: <cover.1538516853.git.steadmon@google.com>
Message-Id: <cover.1539305180.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 0/1] Advertise multiple supported proto versions
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

This is an alternate approach to the previous series. We add a registry
of supported wire protocol versions that individual commands can use to
declare supported versions before contacting a server. The client will
then advertise all supported versions, while the server will choose the
first recognized version from the advertised list.

Compared to the previous series, this approach is more convenient for
protocol_v2, which is intended to work on a single server endpoint.
However, it has the drawback that every command that acts as a client
must register its supported versions; it is not always obvious which (if
any) network operations a given command will perform.

Thank you to Stefan for his review of the previous series and for
helping me think through the requirements for this new approach.

Josh Steadmon (1):
  protocol: advertise multiple supported versions

 builtin/archive.c      |   3 ++
 builtin/clone.c        |   4 ++
 builtin/fetch-pack.c   |   4 ++
 builtin/fetch.c        |   5 ++
 builtin/ls-remote.c    |   5 ++
 builtin/pull.c         |   5 ++
 builtin/push.c         |   4 ++
 builtin/send-pack.c    |   3 ++
 connect.c              |  47 ++++++++---------
 protocol.c             | 115 ++++++++++++++++++++++++++++++++++++++---
 protocol.h             |  17 ++++++
 remote-curl.c          |  28 ++++++----
 t/t5570-git-daemon.sh  |   2 +-
 t/t5700-protocol-v1.sh |   8 +--
 t/t5702-protocol-v2.sh |  16 +++---
 transport-helper.c     |   6 +++
 16 files changed, 217 insertions(+), 55 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

