Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AAAC4321E
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C57360E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhJ3Veq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJ3Vef (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA93C061570;
        Sat, 30 Oct 2021 14:32:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso6299276wmd.4;
        Sat, 30 Oct 2021 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdB4czh+ZsIDFo2JracuRuKv5/cF7cmLOVxKeV3jbt0=;
        b=EJPA6dUdFn+grcr0hA9RnqysqYgLSvXfCuA6VXhuarRgnWiQCTHVoxw5CEngGnsvrK
         J6w2nrYBf/SWzZdU3MVSeMDw1hq+3QKvpeF26EVS1Dz6upmuGQErR2fJZ0X6SYR/qpqc
         4qNf6OIfomBsn6eBPaG0Iadj6yOQDbaskj6TpfSURCgIU3UVksRFQa0l8znrXDdKJUdY
         hURj8NeWRZsf7DSVqAVN03jOzQEnwAcpr7JhRD+YVE0oqFmxn16OWdvbbCxA1iPpJ9lR
         5CFIGg33eEncW8J4EKmpJ6a6kLQjHJxI28Bjl8tSkBovRn8Fix+XpzxN44xYuzVxu+5k
         ukTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdB4czh+ZsIDFo2JracuRuKv5/cF7cmLOVxKeV3jbt0=;
        b=soaoWPciGufcOl1uETSqlV9VVxgd2MXlb1QdLrOfavBQ7GZMWUelKgGoLmZVI81fk9
         cwl7H15IRt7YBGAzkw9p8xMn6eZlxGEQ8pC7a7+SipZKZITlubDgsVHdTX+X44OSp1Uw
         W0N1S+ZJeo3+G/HjcKe39yUgs7KTztBLVnJtPcjMWTT5DdQQuIIJiL4aC+8hndKPO1LD
         PYaW/IVP1Hc42jb1rUUHE1LtrXTE4PfMeyfXXgKUR/tqxh6a5erdAetxqoarcC2rT5kj
         3J+JeRwJZ5hmoFqO+zmiFZSXmp8kd+3unw10SKwN98zhwoZJ0a1BzaKr8PGeJkrWXs15
         fpWA==
X-Gm-Message-State: AOAM533jZ6BA6Lma3YPN5ZAmLvYZKaRA2V/2MG2a2d1JtIKuQ9TawqUY
        58J1iq1df+iQEDzNmYdwnBsRCNLQCTQ=
X-Google-Smtp-Source: ABdhPJzd3wZxRMcq5skeKPIiwNj2gjCs5mtmXWvglp62/X0eB0GgrFmRVnlk+yIPwlrv8EuYb0A8cg==
X-Received: by 2002:a1c:7f0a:: with SMTP id a10mr29620154wmd.60.1635629523102;
        Sat, 30 Oct 2021 14:32:03 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:02 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 09/22] statfs.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:19 +0200
Message-Id: <20211030213131.140429-10-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LSB deprecated these syscalls in favor of [f]statvfs(3).

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/statfs.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/statfs.2 b/man2/statfs.2
index 77abd7e4b..92dd83460 100644
--- a/man2/statfs.2
+++ b/man2/statfs.2
@@ -32,8 +32,8 @@ statfs, fstatfs \- get filesystem statistics
 .nf
 .BR "#include <sys/vfs.h>    " "/* or <sys/statfs.h> */"
 .PP
-.BI "int statfs(const char *" path ", struct statfs *" buf );
-.BI "int fstatfs(int " fd ", struct statfs *" buf );
+.BI "[[deprecated]] int statfs(const char *" path ", struct statfs *" buf );
+.BI "[[deprecated]] int fstatfs(int " fd ", struct statfs *" buf );
 .fi
 .SH DESCRIPTION
 The
-- 
2.33.1

