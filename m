Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED82D20248
	for <e@80x24.org>; Mon,  1 Apr 2019 12:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfDAMF2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 08:05:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39247 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDAMFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 08:05:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so4475055pfo.6
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELs3i3qYOh/vxl1tSVa7KwpVl9w1Vp1xjRodl4VcE5E=;
        b=em6WrTbTuOlHzUe5QMLukTW/cEelTlLrB7K4RZcIQ4nXh78hJdhDuiDkysLAVo9Hv0
         Qe0LliHv6a5zFyn9ix8rbhLXD4mCJiXiU5ukAbbTW7OzPPgYIurw1l3iyvjsmLgmXncx
         cJuONlhfhyABcVAoCQY9WkOuvj786E2keOO/2/9iLtzPUW0HddnOKNTK1j+G4UcUsi9z
         f2uJuRXIBZBdxu8+15pYLfL7jzzy1gTFbAITQ3X69JkAiOHlaM+nC0M6+gRIVdlpXtMF
         nvPjuHQYTC/SViiSqU4uOI+I8eTZMYZ/d1XZmWmbjCA2dwvhG6jx1qfyzwuc1Af3LpQU
         gvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELs3i3qYOh/vxl1tSVa7KwpVl9w1Vp1xjRodl4VcE5E=;
        b=kQ4QXYNRkQ8GBIgP+QbwNjjzmnVIv4SW65nUR3qb56c7PUVmtuiHtKSgMxA7VV5jUX
         z3DRY1hITzPd90v4KSat+HGN7MxWTt/zPIF63Ph1aOvg/+jNJIvlbw0zbxabBZCJcArC
         1MJv6nAa3zf+J561ay76R19xJ9bINSvDP6mnXoVYnd7KRT2nlvRKYoVrnxFhguYmdnrQ
         Oqg8bzEdNO2YjCLYp4H6C+WmRtag+uZ/igAzNTlS/m+Z6oAJWjF0YTZij4V7pAqAJVB5
         Ix1j3uKVWzsswMT5FMEA7w7h2g9s6oQF1EcQZMSGHIKlvIfGbD1nKCeIrCmaQ1RkarWh
         S+8g==
X-Gm-Message-State: APjAAAXI9ZiVUkXKs+NhMBq3R73jkh4Ne1ududXuC1rFo2fZeGfHycEo
        n1mz8nfJ3roqU6nt8B388W0=
X-Google-Smtp-Source: APXvYqyQT6lh6DVqj6vPkOOx+Y6ZTt9ZKk86p0zb5qgBh2KM9gb85uNWGdYl7Vt7u3Uj25KylQP1cQ==
X-Received: by 2002:a62:388d:: with SMTP id f135mr48036015pfa.103.1554120320289;
        Mon, 01 Apr 2019 05:05:20 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id f192sm17885874pfc.180.2019.04.01.05.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 05:05:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 01 Apr 2019 19:05:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2] read-tree.txt: clarify --reset and worktree changes
Date:   Mon,  1 Apr 2019 19:05:05 +0700
Message-Id: <20190401120505.12164-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190326120939.31657-1-pclouds@gmail.com>
References: <20190326120939.31657-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of --reset stays true to the first implementation in
438195cced (git-read-tree: add "--reset" flag, 2005-06-09). That is,
--reset discards unmerged entries. Or at least true to the commit
message because I can't be sure about read-tree's behavior regarding
local changes.

But in fcc387db9b (read-tree -m -u: do not overwrite or remove untracked
working tree files., 2006-05-17), it is clear that "-m -u" tries to keep
local changes, while --reset is singled out and will keep overwriting
worktree files. It's not stated in the commit message, but it's obvious
from the patch.

I went this far back not because I had a lot of free time, but because I
did not trust my reading of unpack-trees.c code. So far I think the
related changes in history agree with my understanding of the current
code, that "--reset" loses local changes.

This behavior is not mentioned in git-read-tree.txt, even though
old-timers probably can just guess it based on the "reset" name. Update
git-read-tree.txt about this.

Side note. There's another change regarding --reset that is not
obviously about local changes, b018ff6085 (unpack-trees: fix "read-tree
-u --reset A B" with conflicted index, 2012-12-29). But I'm pretty sure
this is about the first function of --reset, to discard unmerged entries
correctly.

PS. The patch changes one more line than necessary because the first
line uses spaces instead of tab.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 updates a bit to emphasize on worktree changes.

 Documentation/git-read-tree.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5c70bc2878..7061d6634e 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -38,8 +38,9 @@ OPTIONS
 	started.
 
 --reset::
-        Same as -m, except that unmerged entries are discarded
-        instead of failing.
+	Same as -m, except that unmerged entries are discarded instead
+	of failing. When used with `-u`, updates leading to loss of
+	working tree changes will not abort the operation.
 
 -u::
 	After a successful merge, update the files in the work
-- 
2.21.0.479.g47ac719cd3

