Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B1EC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjAIEdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbjAIEcW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:32:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35BFE0D9
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:18:47 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v30so10794318edb.9
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A45kSiRSSU+m4DDL2PMCOgqF0CTwxjXZmfkLb/fYh4g=;
        b=F6JfgJZnZr4LNSm6D31rET3ltlqAutX26DosKac9edLOW75wilNhKHbUBktORposy7
         dJvgv1JXArjJtcUdENMP0powD1JouNkE1S1wY92NB/rlxerJAfYrDWWi1rzq2miv1MA9
         mOf10rbIZFyq+LcIqddiBKAVDCzyTvOLUrK0OwSvRxZJIXU/5CgMcvCyrIfcpcMJtQNv
         l4bwF03B5wQlLpSPv02PD2gS/xhB8/gEQwfbCxG1LMEq4IAa1nIipNffMaWdK1+cdwk/
         g6nxnc1qGsvfFFiOzSWMXbl0vqJdry/aDaaUugG9U3QLR2O0CbOh2yReg/Is06iYPDj1
         bSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A45kSiRSSU+m4DDL2PMCOgqF0CTwxjXZmfkLb/fYh4g=;
        b=X8FuvRQuYEGvYEFyqUxo5tCTzIO2pTTaMRLZmRbj0sge3qxhUzIHWSLrrVCXp2gYHn
         vJkBYup0XWGKbXmRTINQ7XeW57+5ROxMiAMslXm6fSkKx0iYU/8UpcRi7dlNvxoXA8gw
         d2KA7P9dF1aYEuk6CVINwPjHGnBNljlNeE66Qz4snTyUtFBdt1r6gWsBCx017OyytHf0
         O9v+7kYwCkjZVSS6mPH0AqYT+nAJWroyAAn2kbyoFVPgl8AR+c20FpG+8i4J7a7tVKm4
         ET1VeM1w7vFHL3+ye6vG+CIIAVGB0ItjzzX9Oj4L9mI7N5EbNpppr9RNCHSJ6Hp9HG6I
         8DDw==
X-Gm-Message-State: AFqh2krYyi2P8QwHMSco9O+vyVnAwGiVRaQNuxwztjWGD5FkgAmc6lPr
        GKrSNr3aIgm/9DNj/b+npBGMl4emJgjStKgYVLN334t+zcY=
X-Google-Smtp-Source: AMrXdXu23jxGw9W/cllKFSVHJryt1gBYB+0tzBcbYdTjSBhTaedNcqBH8q/I7CTjGvN4FWggKBG2J3LGOV1rIy4RIGA=
X-Received: by 2002:a50:eac2:0:b0:46d:a8f2:93e8 with SMTP id
 u2-20020a50eac2000000b0046da8f293e8mr7070298edp.423.1673237926264; Sun, 08
 Jan 2023 20:18:46 -0800 (PST)
MIME-Version: 1.0
References: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
 <xmqqfsclzlqx.fsf@gitster.g>
In-Reply-To: <xmqqfsclzlqx.fsf@gitster.g>
From:   muzimuzhi Z <muzimuzhi@gmail.com>
Date:   Mon, 9 Jan 2023 12:18:34 +0800
Message-ID: <CAEg0tHT5PD4K89E3fcNq_WbaLPHozLi-PsJFDsQrzkGi7Na9jg@mail.gmail.com>
Subject: [PATCH] doc: fix non-existing config name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace non-existent `branch.<name>.fetch` to `remote.<repository>.fetch`, in
the first example in `git-fetch` doc, which was introduced in
d504f69 (modernize fetch/merge/pull examples, 2009-10-21).

Rename placeholder `<name>` to `<repository>`, to be consistent with all other
uses in git docs, except that `git-config.txt` uses `remote.<name>.fetch` in
its "Variables" section.

Also add missing monospace markups.

Signed-off-by: muzimuzhi <muzimuzhi@gmail.com>
---
 Documentation/git-fetch.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 63d9569..fba66f1 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -251,10 +251,10 @@ EXAMPLES
 $ git fetch origin
 ------------------------------------------------
 +
-The above command copies all branches from the remote refs/heads/
-namespace and stores them to the local refs/remotes/origin/ namespace,
-unless the branch.<name>.fetch option is used to specify a non-default
-refspec.
+The above command copies all branches from the remote `refs/heads/`
+namespace and stores them to the local `refs/remotes/origin/` namespace,
+unless the `remote.<repository>.fetch` option is used to specify a
+non-default refspec.

 * Using refspecs explicitly:
 +
-- 
2.39.0
