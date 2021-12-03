Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F5C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383196AbhLCVTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383182AbhLCVTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98571C061353
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so3170683wms.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cSH7cOtj50LHKXW2qAngoAwe/N6Nsz0dLhcE1QMcy0c=;
        b=TzxByrxq5PAGV1ckbWkYWOwftRUhNdzvX2xWjWnkqtlTGwsFR+S213AhHg7cix21Me
         zARoTx5Ek8FRTs0ZrPjLOwfGvubzq4Zk5z57PTAzcWl0yykDzbLBq0KBR5n906GEzWhw
         G10gu+MIl/SWUeAE0X68YBsWBj3babUyjfFwvqAupdNAkbhoajidLei7Fu8c2OhvFApt
         YhV7Lxd0gL0U9C/DZYYmLn2U4c8euwMkSigp21oryHXDZsAx9Pu0RwdGatahTmuc/v5L
         xi8rQVsF4OQ7A5TANHh8kuECasTQG7xzUGxm38VS2jxlD2DGZqa9bmIzsHCLqY1mb8+z
         wwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cSH7cOtj50LHKXW2qAngoAwe/N6Nsz0dLhcE1QMcy0c=;
        b=vat4H1UL+jyoqCMBWm+i//fzeSORi8Szm97R7A3aZ6tw82WF86ZgfnRBhwLS3ug/Lq
         NY9u/oqNAScjtTPuLJiI7B4DOQNZidhCsRaF/HxCeOrF48/kcW+AAe/FzXAFbcW7s3Gp
         ZTi6NUgxzTzgaqxHoPaLhzgjnZblnKbNgUw1PnOz1N0zFq+x3ZKt/mO71Pp1zJ5pH4dQ
         elvF9PnN+/IX9j74AcYwbXem3afPQWf0Tc3n0xC1x/nkoLFAjnPh6uuF6t9QexQ/NA24
         y+3xqc2EE0FlbhiWZJC42lX3M7r0r5pdViPRWV2SgxDAXfavJP3JU95weN7SQ5RjKvhl
         4FuQ==
X-Gm-Message-State: AOAM533/sYPFO2cxep4mqCX+mtAfUotxkWRyV/rAkWao5AcucZMlmDsw
        PSo/TXnfYTYlMxdGmGZ26X3r+DYoca8=
X-Google-Smtp-Source: ABdhPJyv8S1+2er+ZcHEBFKprNxlpU1hQqB8bzHOCr4znXemL+UoN2jutnhFbV+Y8c5sAbql1QUX6w==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr17724735wmi.173.1638566169941;
        Fri, 03 Dec 2021 13:16:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm4916450wrb.75.2021.12.03.13.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:09 -0800 (PST)
Message-Id: <9e53a6435e4e7bdde941875fac6742288947b5e0.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:16:00 +0000
Subject: [PATCH v5 2/7] commit-graph: return if there is no git directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Return early if git directory does not exist. This will protect against
test failures in the upcoming change to BUG in prepare_repo_settings if no
git directory exists.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 commit-graph.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2706683acfe..265c010122e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
 	struct object_directory *odb;
 
 	/*
+	 * Early return if there is no git dir or if the commit graph is
+	 * disabled.
+	 *
 	 * This must come before the "already attempted?" check below, because
 	 * we want to disable even an already-loaded graph file.
 	 */
-	if (r->commit_graph_disabled)
+	if (!r->gitdir || r->commit_graph_disabled)
 		return 0;
 
 	if (r->objects->commit_graph_attempted)
-- 
gitgitgadget

