Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D0C43217
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F247A60E09
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhJ3Vei (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhJ3Veb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD49FC061570;
        Sat, 30 Oct 2021 14:32:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d3so22192204wrh.8;
        Sat, 30 Oct 2021 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L44slKEtEbRct9qaqwEFiskio2SRbqLpn8JU4z1rLzM=;
        b=pEtqa5iSym42YFTqImyvZToY9wGOoh6Ekt9/c3922NxNm0gG4AFlhQbzwH2RTOpjiG
         Rg6WBbimOqpj6PqC1loBoQ0I/VT8w6euBjPkTbP8tYDBwxyUh0i7VyBJTO5IYgkBi+Hv
         SEWmHwy+X0UJR5qt8uYc+do8tQIRFFVWrhExBdJ0k31FJJUJUAD/DJLn8DN7qG8ajqYN
         wgailD3SoCft/8L2dO5S8DQ957FZFxc73/WiUK0Vv6/Qo77+Be1xU6NrGqvoCdYTIL8O
         NJMgHj3NBhyGpnC2RlRI8hIg6cQQ8puuVR6o1UMrhbgrUe44Z2ooYSQBWivOOFza2baQ
         x+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L44slKEtEbRct9qaqwEFiskio2SRbqLpn8JU4z1rLzM=;
        b=sNN7AH/UM9FQB9+SBVSJDd8PDgcQBKAc4dHA19K0aIgK6bnt51pzEektN4+DcD92Jw
         ZpZljwfRP8KcVrw+pqpQiCDKoZU/58sNUXVPIBIaN0iL9DUIVDgy62IDe2JQuap2IRIg
         4jauSNRet2uHT7wjK9WJ1LWR0z3DBQZuNWgLd4ph/lCDlketoqsNUEE8FSXCnhgDHj0P
         D3stYeqHhQUjH0l46kCVBDX6FGVCat4MPb/5QDPG+htvyObIZq/FN9RIgBvRd2wgfdy/
         Y3nTKn68UWK9K5hKxevv9q1jb32BAT06BXp/2wpsWpBZ/rIixnt6Z0zvdXQP5SKTKXCJ
         x8fg==
X-Gm-Message-State: AOAM531QFfM6QS52o0HBOkR+YQgiXjseqRZJZfyQJsrjiLjW0XBIBB8I
        zL1NtpKR5q2FHIMMVvXFjyA=
X-Google-Smtp-Source: ABdhPJx8yY2NCSl9Gbi8xJiApsUpOv6X5wpVmrImljzzbCvJAtsu1ImAwRcI71OYXTuw6YFLsUxfDQ==
X-Received: by 2002:a5d:4e09:: with SMTP id p9mr10209740wrt.28.1635629519376;
        Sat, 30 Oct 2021 14:31:59 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:31:59 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 06/22] query_module.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:16 +0200
Message-Id: <20211030213131.140429-7-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This syscall was removed in Linux 2.6.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/query_module.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/query_module.2 b/man2/query_module.2
index ef8d803ee..4e657189c 100644
--- a/man2/query_module.2
+++ b/man2/query_module.2
@@ -14,8 +14,9 @@ query_module \- query the kernel for various bits pertaining to modules
 .nf
 .B #include <linux/module.h>
 .PP
-.BI "int query_module(const char *" name ", int " which ", void *" buf ,
-.BI "                 size_t " bufsize ", size_t *" ret );
+.BI "[[deprecated]] int query_module(const char *" name ", int " which \
+", void *" buf ,
+.BI "                                size_t " bufsize ", size_t *" ret );
 .fi
 .PP
 .IR Note :
-- 
2.33.1

