Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 22B237D918
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 15:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgCKPaa (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 11:30:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33685 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKPa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 11:30:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so3417041ede.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cqrZm8Vvb0fGSVpl1B/b18OJcUhKsxw2q15GVnGgkkE=;
        b=anwlg6UiP//ZNqNf6+n/0QEJ3uJNV5j4cPG6qX6ZWip0UNi0fO5WIqn0BOn0CmkndT
         3ZGs7uqJ9QX2+j1QmMXYIcqNSQhmbYM7OoPwmmPeKp/+Ou9qg5eYAsoOJMOCEmOKBc1F
         sE3GBTM5pjemeaOcB30XCQBQBUUppwwe3idFuuWs0KQKwZeE7SBILjlZ8kQT0hMII5oL
         y0EPbSPyXg92tcNp93OTl1MQct3YbC455DXDXNd9mhiLrTeqblxxpRvgZscKAtsNzYgC
         5w5tLxoSwkZd4qbXTcQ17ujZ7CGcj0v5C8lYiJAJDVmZf0cun+zhWuGHmc572k1E9UG9
         J33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cqrZm8Vvb0fGSVpl1B/b18OJcUhKsxw2q15GVnGgkkE=;
        b=V90AC68qrTWa0CV+W4VKbfeo1/b+aMxY67T3EjExJo3NpRWb3WahRY4puaAjo5wetQ
         53YuvowiG10Wkm0pBR4r1RBwp0IDAeFGx0AAE78rZUvknDtRf0rdkTdrwTfOFbNehQJc
         IJUE5GhM/JpbluvYZi5rvd83XP0Q9CJMJfYYDOyX1cls3srOdTwM7kEN9C0ePoPdsxvh
         OXGLYPo9/CHkCJ4z1QjhmBhpiPHNtyTbwxTxBpSwPjhM9IMAecZnb0plj3iDsJC6w9e7
         PidtFtH1B+kw/kRvGAVOtIsokOEJi5d9z2ls/iwQQuG4WJCW/LP+ftHqgCEkko7U2ra0
         S57Q==
X-Gm-Message-State: ANhLgQ2dsJB6W3rRHl66X6brYnXzyFReE5/FkHJmksTYbvZmc1Y/6l31
        pXOm4rnhrSn0JlAV4kXGhLR27Jh8
X-Google-Smtp-Source: ADFU+vuluDKVDWO2/402DndUS2lgh4YGoCPZe9AbrBKPx6w1EflKofDslhV/Kg9Mql1bBoWXgPzIzw==
X-Received: by 2002:a50:f297:: with SMTP id f23mr3261110edm.347.1583940626918;
        Wed, 11 Mar 2020 08:30:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h61sm4484582edd.49.2020.03.11.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 08:30:26 -0700 (PDT)
Message-Id: <6d51cff41d9ee312a0d9ae3308546284ead1d4c6.1583940623.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
        <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 15:30:23 +0000
Subject: [PATCH v2 2/2] git-rebase.txt: highlight backend differences with
 commit rewording
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/6d51cff41d9ee312a0d9ae3308546284ead1d4c6.1583940623.git.gitgitgadget@gmail.com/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

From: Elijah Newren <newren@gmail.com>

As noted by Junio:
    Back when "git am" was written, it was not considered a bug that the
    "git am --resolved" option did not offer the user a chance to update
    the log message to match the adjustment of the code the user made,
    but honestly, I'd have to say that it is a bug in "git am" in that
    over time it wasn't adjusted to the new world order where we
    encourage users to describe what they did when the automation
    hiccuped by opening an editor.  These days, even when automation
    worked well (e.g. a clean auto-merge with "git merge"), we open an
    editor.  The world has changed, and so should the expectations.

Junio also suggested providing a workaround such as allowing --no-edit
together with git rebase --continue, but that should probably be done in
a patch after the git-2.26.0 release.  For now, just document the known
difference in the Behavioral Differences section.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8c1f4b82680..f7a6033607f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -699,6 +699,16 @@ suffer from the same shortcoming.  (See
 https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
 details.)
 
+Commit Rewording
+~~~~~~~~~~~~~~~~
+
+When a conflict occurs while rebasing, rebase stops and asks the user
+to resolve.  Since the user may need to make notable changes while
+resolving conflicts, after conflicts are resolved and the user has run
+`git rebase --continue`, the rebase should open an editor and ask the
+user to update the commit message.  The merge backend does this, while
+the apply backend blindly applies the original commit message.
+
 Miscellaneous differences
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
gitgitgadget
