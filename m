Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8352095D
	for <e@80x24.org>; Tue, 21 Mar 2017 14:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932152AbdCUO3W (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 10:29:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35766 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdCUO3V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 10:29:21 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so22696612wrb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SHQAoK1fVdm5uUVWiYLEpK8Sbeo/36LBqsGN5nqu1NQ=;
        b=rheTfwgq7b/ZsDAUkUUYXZZBKsgAM8Dh60P7/4eT+o+y3QQODvNbzWxwvIXCXL8+Hx
         oIH+kNEW9vjfni2XY/btjU2dz+NCzpZaCJjVjwRbGFU+31G/c1GbNE/s36CSlmWBZrso
         RTqLSL8EG224z9yqRv5t7RtwPhu4LSUNvPi1mQL12dOFO30GQ2KPbFCWGsjYqHm8/2FK
         gmWxK48Tq0AUC6I7Ctys7gFq5nIJuyRHEmi4EtunUDHg//uNQmMp0onQ7k/NT1CudOuX
         uXuNzVPv2H0xn6XDvPQYqgPtil9c1dzjMiH5bG0r7rTiIxK6QrlspN0oQxazv9SDREYW
         S2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SHQAoK1fVdm5uUVWiYLEpK8Sbeo/36LBqsGN5nqu1NQ=;
        b=gESjEcGOmZTiPcOJHwWfmrKZFp/DtFq96pRG8Ldmig3nMnOpDQ1VpZqS9Uv9Eyj4W4
         lw5QhoM6vGmCv1KVDBgS4N96SaqvmZx6rmDmQFkrFsB7uYNuKUbnJg84hkN+5IcdH359
         SgnOM/jVTu9uyDC1lHJx0BXCX+Xfvae7wHg5y9ArrnsmE/TZ6iRr8AlapLRxmaidVCKg
         d0mrGiMCmXe4vEUkvejZDLL93Utf5IQf2RippzOC7JHtq7yuTVUGhRIELxDjjClDqgKO
         GIjYbwVvqnjiDgEdGWnTu0Qf/J7GwsCg9qRnh1xjbtQLrc43qNc13n8Fe/+WivJnvmRl
         5x/g==
X-Gm-Message-State: AFeK/H3ldz1LcOZvrjN5ty2QyUGwwohF7Gt6p1Oh72caH6An6cX1bZcNBQmbyNzA0hztSg==
X-Received: by 10.223.170.210 with SMTP id i18mr33461350wrc.114.1490106130144;
        Tue, 21 Mar 2017 07:22:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s17sm25317092wrc.25.2017.03.21.07.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 07:22:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] doc/SubmittingPatches: show how to get a CLI commit summary
Date:   Tue, 21 Mar 2017 14:21:54 +0000
Message-Id: <20170321142154.16993-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321142154.16993-1-avarab@gmail.com>
References: <20170321142154.16993-1-avarab@gmail.com>
In-Reply-To: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
References: <xmqq37ea2ykh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the section which describes how to get a commit summary to show
how do to that with "git show", currently the documentation only shows
how to do that with gitk.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/SubmittingPatches | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9ef624ce38..d8c88153c1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -134,8 +134,17 @@ with the subject enclosed in a pair of double-quotes, like this:
     noticed that ...
 
 The "Copy commit summary" command of gitk can be used to obtain this
-format.
+format, or this invocation of "git show":
 
+    git show -s --date=short --pretty='format:%h ("%s", %ad)' <commit>
+
+To turn that into a handy alias:
+
+    git config --global alias.git-commit-summary "show -s --date=short --pretty='format:%h (\"%s\", %ad)'"
+
+And then to get the commit summary:
+
+    git git-commit-summary <commit>
 
 (3) Generate your patch using Git tools out of your commits.
 
-- 
2.11.0

