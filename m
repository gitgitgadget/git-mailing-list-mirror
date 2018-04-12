Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD2B1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeDLVO1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:14:27 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37769 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeDLVO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:14:26 -0400
Received: by mail-it0-f47.google.com with SMTP id 71-v6so671881ith.2
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=7Y1Uh7VXiaNmmA8+e5FItejsmVdIG+wJWat9708PxJM=;
        b=XSZIEOkfc6mdaj3KVfBF03MOsQGCuznmHCQZd8JperxxOH8EGT1o7XQHV6edtuPI4O
         18Y//cNV4ct2uj0fLP7uoa7r+OhX+SNivMyIMJbosGYQRAwh5BIp08JHPz0VEB/X6pnJ
         uC+frloncpaXlflazNOJUf7dd6LKF0JCfgD9fIcC3myW2fkYrndIco0bnZpsie0itovO
         x/YpHs7nZ/Ltsm9nnWVp7ywoQjy5eITb77NFR7rSXhPWKvJ5TWM8E5vNI+OkH6ZIeTVw
         sBE2xcuon6VYl1xtuaFg9bnJafE7iQjuonLJuCJ8R0lREpsRgbVLRDGQWdI1BvNYwp5N
         TrXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=7Y1Uh7VXiaNmmA8+e5FItejsmVdIG+wJWat9708PxJM=;
        b=OIn1YMtX+AEtNkkE9M5m7/7JUIZB6gHJF9sxLeBbc+T4bfnA9xiMhn91myhTcbwJ3D
         DkVPimO6qKfEKJxPRHVb68fXDqkHTyQn/VK3FgKjE0hec1a5FvKWk5neLKVLYDLAE2FB
         4TJB/4hhjYa1VtzbtaPWz3OWNRKNH66xDpW08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=7Y1Uh7VXiaNmmA8+e5FItejsmVdIG+wJWat9708PxJM=;
        b=tKZk4GXhu0iFuh/grtRcAKt3YLACWeQXXMD84LI0uqlh9gmcvb55Zu+GtJC9+AnVfE
         HK5FG7iKtEN9C/oXTvKfzloUTnb3Dakl+BBLk9LpHSXmU9pVo6hct4NGGe+Jg7K3vbyW
         4w32uCMi0WgTYxd00pYMRH0B7B2F5z7EjB8Y7F4kDOthmiZ++mZdoI7B2Y8hSGWBL4T8
         OMzuyWr6iYMAA0La1n2W/DhMFczgXo+6K+DSj7xjFhauFtHQXrNWXPBpE3I3PPF8H7Wk
         Cue5Oxf6xtp8wdluRoDVOPNHgTPBzCKa0Z7RkFG+eoQaSltsKFyoECOTOR+yoOrghIkw
         4sTQ==
X-Gm-Message-State: ALQs6tASiekkpX+BQyWAWf4KAw8uymb9wWBHhCE/VR32fz3kIm+shnVp
        PXNDy5yGEVpfFRTRT4lt5WVadOYoH2BF6Ue5t6+r7EIu
X-Google-Smtp-Source: AIpwx49pz8zlKUxw1BQkEEWBxLjYoSfRnzShfg7Gk4YrFAEhAY5CAMDe9AmLbo/maXmfRz5+pkfrI+whNaiCyZECdU4=
X-Received: by 2002:a24:7693:: with SMTP id z141-v6mr2629009itb.113.1523567665183;
 Thu, 12 Apr 2018 14:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Thu, 12 Apr 2018 14:14:24 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Apr 2018 14:14:24 -0700
X-Google-Sender-Auth: E0HvmOyXCaav0zVQPhQNpzWYzGU
Message-ID: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
Subject: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I just had an interesting experience that has happened before too,
but this time I decided to try to figure out *why* it happened.

I'm obviously in the latter part of the kernel merge window, and
things are slowly calming down. I do the second XFS merge during this
window, and it brings in updates just to the fs/xfs/ subdirectory, so
I expect that my test build for the full kernel configuration should
be about a minute.

Instead of recompiles pretty much *everything*, and the test build
takes 22 minutes.

This happens occasionally, and I blame gremlins. But this time I
decided to look at what the gremlins actually *are*.

The diff that git shows for the pull was very clear: only fs/xfs/
changes. But doing

  ls -tr $(git ls-files '*.[chS]') | tail -10

gave the real reason: in between all the fs/xfs/xyz files was this:

    include/linux/mm.h

and yeah, that rather core header file causes pretty much everything
to be re-built.

Now, the reason it was marked as changed is that the xfs branch _had_
in fact changed it, but the changes were already upstream and got
merged away. But the file still got written out (with the same
contents it had before the merge), and 'make' obviously only looks at
modification time, so make rebuilt everything.

Now, because it's still the merge window, I don't have much time to
look into this, but I was hoping somebody in git land would like to
give it a quick look. I'm sure I'm not the only one to have ever been
hit by this, and I don't think the kernel is the only project to hit
it either.

Because it would be lovely if the merging logic would just notice "oh,
that file doesn't change", and not even write out the end result.

For testing, the merge that triggered this git introspection is kernel
commit 80aa76bcd364 ("Merge tag 'xfs-4.17-merge-4' of
git://git.kernel.org/pub/scm/fs/xfs/xfs-linux"), which can act as a
test-case. It's a clean merge, so no kernel knowledge necessary: just
re-merge the parents and see if the modification time of
include/linux/mm.h changes.

I'm guessing some hack in update_file_flags() to say "if the new
object matches the old one, don't do anything" might work. Although I
didn't look if we perhaps end up writing to the working tree copy
earlier already.

Looking at the blame output of that function, most of it is really
old, so this "problem" goes back a long long time.

Just to clarify: this is absolutely not a correctness issue. It's not
even a *git* performance issue. It's literally just a "not updating
the working tree when things don't change results in better behavior
for other tools".

So if somebody gets interested in this problem, that would be great.
And if not, I'll hopefully remember to come back to this next week
when the merge window is over, and take a second look.

                     Linus
