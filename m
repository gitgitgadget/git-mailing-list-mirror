Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8063520248
	for <e@80x24.org>; Tue, 19 Mar 2019 14:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCSOhy (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 10:37:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42829 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSOhx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 10:37:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id j89so16792642edb.9
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5oLLaelHefo/BwrhAWBg1V6CGCG/WgoBFYhvgwdn3HY=;
        b=bY+jBTOgcnFeCmJ6ConVXpTltJrgRJH2RA74CxacMKwSGQm1XP0tMOIw0gMvqZNLqV
         9NTrS2RvUgBYM+xk/XTnY2sfdCQZnoj0Sf5QrAQVgdnfqSyBdAZjtXssiGIGZ4vpUkvi
         UTh5calarPzeY8XtB5tXGD8o4KZIY916qwWbBMwrauX2BOwxp1cOpnhmtagFW+B0M5b1
         /uaBJPUo0UyFNqCGl9XGF1q/pLRYwD/R7L5+Jb1c7YLZJnKeTCmMmkeHKkLgq5Zrex3m
         c7BzjXKsFWUEjm94c/MJGj7rnENqxe+MTq3/TVuVil6Vqp4NkJ+csK9xgmtld/LSJ8AB
         Y3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5oLLaelHefo/BwrhAWBg1V6CGCG/WgoBFYhvgwdn3HY=;
        b=L7jqyzZJtcHknUSLuzlPzRsDjRMkl391FnSyuMKBlAlXjMeJm6BSgPQtA9s85eTkzG
         p1dUrl2ZJusDLhaGW27wXYR/bmk5WP/O6FiXghgupLj25yIlWvbADzygFF3RXDllxcgK
         dgx7HVCuayLq10Cf7LAfu/RksTbQBJk9EvhqVrE+gMsHskEfTjeKctMNTOxkPLVYaIKb
         m21w221hJWT7k+tHn9OoXR0XVHq0kI9G8+jsKVt24YOhr5qn2zfpTXTn/3/hsIUja2ys
         dIjOpBSwjkCDO6NDESVR3TDS1CtngrFehkW0QH1iup+f9wd7KmWlz1SijWfoqlaKv0Le
         8zjg==
X-Gm-Message-State: APjAAAWvGwHV+9sYFO72ZHvyCG67K4PqsAxOIjWdRD+hXau8qvElUP3N
        hIiLoFgLi50UnPcuBBJCW7sVdLj2
X-Google-Smtp-Source: APXvYqwF4Orq8FUw/6c31hUkWbk9pS2QovVmJIgA9Xao9Ru3RDyZeUCEejk+NV1ZqVBKd152wEaV8Q==
X-Received: by 2002:a50:b152:: with SMTP id l18mr2955756edd.289.1553006271972;
        Tue, 19 Mar 2019 07:37:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 35sm1259131edh.43.2019.03.19.07.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:37:51 -0700 (PDT)
Date:   Tue, 19 Mar 2019 07:37:51 -0700 (PDT)
X-Google-Original-Date: Tue, 19 Mar 2019 14:37:46 GMT
Message-Id: <ced7f1cb3486885aef018d91fae37958282a351e.1553006268.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.v2.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
        <pull.166.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/4] midx: verify: add midx packfiles to the packed_git
 list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Fix "git multi-pack-index verify" to handle repos with thousands
of packfiles.

Midx verify adds the individual "packed_git" structures to the
multi_pack_index.packs array, but it does not add them to the
"repository.objects.packed_git" list.  During the verification
code, each packfile is opened and scanned.  And "pack_open_fds"
is incremented.  If "pack_open_fds" equals the "pack_max_fds"
open_packed_git_1() calls close_one_pack() to LRU-style close
an already open packfile.  But because the packfiles were never
added to the "packed_git" list, close_one_pack() does nothing.
If there are very many packfiles, Git runs out of file descriptors
and fails.

Note that this was observed on Windows when build with GCC and
in a repository with more than (2048-25) packfiles.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 midx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/midx.c b/midx.c
index 24141a7c62..b2f33bcd90 100644
--- a/midx.c
+++ b/midx.c
@@ -975,6 +975,9 @@ int verify_midx_file(const char *object_dir)
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(m, i))
 			midx_report("failed to load pack in position %d", i);
+
+		if (m->packs[i])
+			install_packed_git(the_repository, m->packs[i]);
 	}
 
 	for (i = 0; i < 255; i++) {
-- 
gitgitgadget

