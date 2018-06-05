Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C691F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeFETyv (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:54:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46637 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeFETyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:54:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so3688682wrp.13
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sg/1DFQGRRrX0ZrlygwRs79r5wXIC6vEflTdSBBU2U4=;
        b=lSk4iNXtHnQUi6yst3ZLi8myceksDfrV6fDf4HQxy+7EULeaGfjIgBtj5qUzGg3glK
         g631VDJkipK4tDt2/my4Bz63wJIlcrwQzv/c8GLW9uMJMBNZmLN4MY+quNGXjwb0FgrL
         uPfM5QGsnrHdfZ7vIRPAQiAo6zK8Hlx/PHepaNp8mOKamzGcS02JoL5YBIkLKszuzVvO
         omnGWAEYJsEkB9YuaJYko6NUMeQJ3BzHzk0LVORClKQwYfhAPd8JeNPMztSk4R+DcIKZ
         hay0DrHKMs6BIO44pr0npj6XZ/YjE6JVzQDbthRz+cC1OLb3JvktjlxJ6ii02Iv4T1Bd
         jgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sg/1DFQGRRrX0ZrlygwRs79r5wXIC6vEflTdSBBU2U4=;
        b=pjAxecia8/WFBexPQ7wRa2EKEh5RQHYj0c4YXabJWemE7lvzyk53keSOvOrxVDLJez
         s6KBgwdGsdoJLgQD4Gia8pSfrC9e2Ob1v555MkM0LWsfGMJ3MH+YTGycSX2RejXqMzQ7
         KwULRYyJlzFATykxfCKxvo/nWxk797alPXGI3AopN7SS9RnPiJ9OO+MW5m7pgIq3eHyb
         zZCzrShNIEIgN+4LYPnhoa8FHtRDwIW4pMLK3Q5hH+qmzRpfAaz18gpNv/M7pWxwZFTe
         CmQWDDGpAwB8hxkviBUHFPgOTBMULVa76FZGQFpCHyLbI7OGV867hTN2GRjY+SiByXzZ
         ecjA==
X-Gm-Message-State: APt69E3mDH6B5tyUMhf+xAoeHQRKh/ee0P3j6xchyWNAokBC76zbr84v
        ohTlnH3EJMmOKb7Vk0b3Sxgh3YZW
X-Google-Smtp-Source: ADUXVKJvZzlY7vHifPSzIZQzkLM6R9LiE/Q7KPlq6aC5ePO5a+QRLQ89BgkOGtt0De451CLbXjwLhA==
X-Received: by 2002:adf:8142:: with SMTP id 60-v6mr25837wrm.192.1528228488769;
        Tue, 05 Jun 2018 12:54:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o2-v6sm2252533wmo.24.2018.06.05.12.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 12:54:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] refspec: refactor & fix free() behavior
Date:   Tue,  5 Jun 2018 19:54:37 +0000
Message-Id: <20180605195440.8505-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605162939.GA158365@google.com>
References: <20180605162939.GA158365@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Martin & Brandon both liked this direction I've fixed it
up.

Martin: I didn't want to be the author of the actual fix for the bug
you found, so I rewrote your commit in 3/3. The diff is different, and
I slightly modified the 3rd paragraph of the commit message & added my
sign-off, but otherwise it's the same.

Martin Ågren (1):
  refspec: initalize `refspec_item` in `valid_fetch_refspec()`

Ævar Arnfjörð Bjarmason (2):
  refspec: s/refspec_item_init/&_or_die/g
  refspec: add back a refspec_item_init() function

 builtin/clone.c |  2 +-
 builtin/pull.c  |  2 +-
 refspec.c       | 13 +++++++++----
 refspec.h       |  5 ++++-
 4 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.17.0.290.gded63e768a

