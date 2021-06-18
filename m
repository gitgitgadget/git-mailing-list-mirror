Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F860C49EA2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C848610C7
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 15:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhFRPaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhFRP3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 11:29:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56AC0611C0
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 08:21:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c84so5871423wme.5
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesisquare-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=cRt7pk5ONq/UI+RtoFADIHMuBsInD6Fp7ONAUVr4Am8=;
        b=KP+SWk6NhG35QuKn983rlzAb0VAglVXmIf8WR22e71PFu31PrPzfDHqcYvGvW4y4pa
         RmOSSfWxHXq9X14r7T5yJr0rkyPml+5yKc8xaFDo3aLmPbH/YHQMibms2LPuvZTABKPW
         8eFVqM8k3MYCIHFjWoLZgxUr1Lcn8/6qdelXZQg7aQ9wNeQBCtKbplnZnsX5py0rlSfV
         KcmCuhyl7uDWGGQ6A53i0lU+RZjli7U9CAS/ynAqcd/opoz2d7phB6v+tpaPmSeqoqty
         u5N0Dk77oYCVrHWQ+ksvTNGIIv14jtb5W958xarA5tRyaIDVvQqhq4S70j15iAb5ShyI
         QUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cRt7pk5ONq/UI+RtoFADIHMuBsInD6Fp7ONAUVr4Am8=;
        b=lbh31q1zHqvsdaj4FLwNC9buaIXcM9MHpzPhf5qtwxraPghcnxl/yz+8X+fJ+FQIIz
         fxSrMZYyLksfESHakvJ23w3ynGLGVzj3BQQfSn3xzhBkP5FK6mUyAl63BGqKhg0N5imJ
         gG6pTr0IT6CFzw6gYJjgqvP5B0JDKHCmlp2HdlR96EgHK5fcMd4UtZ0iByuTLVapeohp
         p8U/NLUq+bK9j9ATdl7YpAmXgoIdbBwrWo1jCALyf3GRZnbjWi8fdy+6Y1CDofwNq3FN
         pQwxPleWJCQKnLwRenRKP0rQxKcwk2sHNd4A/YS2r3eG/BGeb/qYjKTLdOQXfJnqJUVz
         3ORQ==
X-Gm-Message-State: AOAM531VhPvxpsr8TDN/bqtjgRanoBhZo0ramZv4gxi1QDexrLrUAzYu
        K+CSa7JvRbxDr/72QKOiwJ9vghabS1aEaREEHDS//nmKUmWVxQ==
X-Google-Smtp-Source: ABdhPJxDXBRwn1x+XqYxjsw9GuwjyXjQtcXCf916WiMakSSr/DsN0ERPG32/C0h5LhgXkdfUnIvmRHyAf7h9u/hvm1s=
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr3582296wmq.36.1624029708896;
 Fri, 18 Jun 2021 08:21:48 -0700 (PDT)
MIME-Version: 1.0
From:   Marco Giuliano <marco.giuliano@tesisquare.com>
Date:   Fri, 18 Jun 2021 17:21:23 +0200
Message-ID: <CANLwWg4hG=iv9qjOmGHSJ7z7Y+vvvP+x0o3DfR5bH5A-C6_7aQ@mail.gmail.com>
Subject: Nonexistent changes appear rebasing but only with rebase.backend=apply
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All

I'm facing a strange anomaly during rebase.
I'll try to explain what happens because unfortunately I cannot share
more information since it's confidential and unfortunately an
anonymized export does not reproduce the issue.

I have the following repository status:

   * commit 2 (BRANCH X)
   |
   |  * commit 4 (BRANCH Y) (HEAD)
   |  |
   |  * commit 3
   | /
   |/
   * commit 1
   |
   |
 (...)

What I'm trying to do is rebasing branch Y on branch X, with the command:
git rebase X

The anomaly is that, among other expected conflicts, also two files
(fileA, fileB) appear modified in both branches, but those two files
have not been modified in any of the 4 commits you see in the graph
above!
The anomaly appears only with the config setting rebase.backend=apply,
while not with rebase.backend=merge (*).

This might not be caused by rebase command itself, but rather by some
previous operations which might have accidentally "broken" something
and that the rebase simply makes them appear.
You need to know that commit 4 is the result of several squash and
reordering of multiple commits; is it possible that some of those
operations have created some "leftovers" ?

I know this is difficult without seeing the actual repository, but
could you just give me some advice or point me to the place where I
can investigate ?

(*)
When the anomaly first appeared, I was using git for windows, version
< 2.26.0 (unfortunately I cannot recover the exact number); I decided
to upgrade git to 2.31.1 and the anomaly disappeared. Investigating
the release notes, I noticed that rebase.backend default value changed
from apply to rebase from version 2.26.0.
I also copied the repository on linux (with git 2.31.0), and the
behavior is the same.

Thanks in advance for any help,
Best Regards,
Marco
