Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11AD71F576
	for <e@80x24.org>; Wed, 24 Jan 2018 09:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeAXJaw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 04:30:52 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38994 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932606AbeAXJau (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 04:30:50 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so2296820pgv.6
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 01:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uP8L/xVv1s/8DagT+btU7VkvR5iSyTZE1jSf7bmAmbA=;
        b=aNq/ctYf38xGszw/tPKERh8zRg+c5wAjgS24NbSO4m8TrFaKex7sRPgiGZB6/VW8Ab
         BE2OuOSISCdw+n5GBddRe1AUYOj/R2bOlQsYyw83ZidY+AOoV91WucWakdgIMQNxIRQc
         +qSWsZHzZerWz4KNDzpcpKaC0UIcSkArH6kCgoForKejGuXytPxFEBzgKa/YR5KazzTo
         5Ei/ce7qJuZPMbyYZGuX0rfQMltK+l0BfZAywCi/bNdeYhdMu71igd6vXDAHPXoIeRrg
         pYwa44ZXlO0ir1h6TqaUD/VopftAgiLNbNh2WuBXKHFgo8o+T7/kVD8bPDkrYkkT6OWK
         yXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uP8L/xVv1s/8DagT+btU7VkvR5iSyTZE1jSf7bmAmbA=;
        b=EOtmLZ6wBfFpNUpG6z8NYA8+XAsFPkJrIwKeUYT+9nqEPJ/hze7zJz0t5Yh3CknrQe
         WxPNyCG6fxfnptXYHxOcJZy2NQhvtkmlUZR8Rs45IkEvX+122pC5H7bDLnzBfWlXkUC/
         ERx0Dnj3BS1R2eEtwTJ20sYV6qEwe7zhqT8fQpE4fUyRLi/6C7OGO/HXcleUAbmmlcJR
         2qgcnk4H/0UJD5vzn4nBmcgkajyaHUmxZGrFWrSTbDt46XlYnyE0sMW8igokyD1uvEJP
         mfosP5KnYDnJ3JBh+AUBjMTvqVe7VjBcDVF25NL6nIM4J47gKQ+mMlykc/OjcdziwS53
         YxfQ==
X-Gm-Message-State: AKwxytdRrYy879VI08b1cPTKQ6Lgr2ckfijzfRZEpo8cjTLbK6FIKYPh
        LZBrsgqUniHNMwICCQqj6OqQfQ==
X-Google-Smtp-Source: AH8x225P0JX4bzNmJdsPFs7U/Uu830KtL4mSWhVYafeVYD1kGdZTyFeE56BFjyMTYMAhBjxKiVEgLg==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10-v6mr7384510plo.395.1516786249674;
        Wed, 24 Jan 2018 01:30:49 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id k195sm28411514pgc.61.2018.01.24.01.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 01:30:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 24 Jan 2018 16:30:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/5] update-index doc: note a fixed bug in the untracked cache
Date:   Wed, 24 Jan 2018 16:30:22 +0700
Message-Id: <20180124093023.9071-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
In-Reply-To: <20180124093023.9071-1-pclouds@gmail.com>
References: <20180118095036.29422-1-pclouds@gmail.com>
 <20180124093023.9071-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Document the bug tested for in my "status: add a failing test showing
a core.untrackedCache bug" and fixed in Duy's "dir.c: fix missing dir
invalidation in untracked code".

Since this is very likely something others will encounter in the
future on older versions, and it's not obvious how to fix it let's
document both that it exists, and how to "fix" it with a one-off
command.

As noted in that commit, even though this bug gets the untracked cache
into a bad state, we have not yet found a case where this is user
visible, and thus it makes sense for these docs to focus on the
symlink case only.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-update-index.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index bdb0342593..128e0c671f 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -464,6 +464,22 @@ command reads the index; while when `--[no-|force-]untracked-cache`
 are used, the untracked cache is immediately added to or removed from
 the index.
 
+Before 2.16, the untracked cache had a bug where replacing a directory
+with a symlink to another directory could cause it to incorrectly show
+files tracked by git as untracked. See the "status: add a failing test
+showing a core.untrackedCache bug" commit to git.git. A workaround for
+that was (and this might work for other undiscoverd bugs in the
+future):
+
+----------------
+$ git -c core.untrackedCache=false status
+----------------
+
+This bug has also been shown to affect non-symlink cases of replacing
+a directory with a file when it comes to the internal structures of
+the untracked cache, but no case has been found where this resulted in
+wrong "git status" output.
+
 File System Monitor
 -------------------
 
-- 
2.16.0.47.g3d9b0fac3a

