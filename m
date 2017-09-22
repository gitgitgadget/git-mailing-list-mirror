Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB696202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 22:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbdIVW6F (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 18:58:05 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:48824 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdIVW6E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 18:58:04 -0400
Received: by mail-pf0-f180.google.com with SMTP id n24so1214579pfk.5
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 15:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9dVAOSV/VCueslNcLSKgbgbnYUYpAj3WWtMNw7V5Zg=;
        b=intHRUUiq/IYg+AO1DonNyMWJkbF7exm9/ObUw4lTxJBxtWMGIwpC65+T5r0G+H/oR
         i2ZTJxBlIjqELNxqD6bS6atHsjMDtdYpAJ63JucRFeiit+OVeMQzKEedkuFEWHQ6Rnv9
         T/EsHCwHgjj7XWB6mKuaKBYGbvfFg0fD7X3QwM1WP5zfYQiB9gija03PqtV4/1v1oarl
         gIMyPquklVFPHj7St13mHTTSDgqXsQLjAc/2TK0Rxk/IR8RVuIt3R15UAxu68H8jKws4
         eNGyiF1OcuKL+T9VZMavzPx2hBaMxFUAbGWdxMpqSu9MnQswmFh5tFB7zzV7NFAtcOUR
         H81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9dVAOSV/VCueslNcLSKgbgbnYUYpAj3WWtMNw7V5Zg=;
        b=bZcwFLrwvgUZz+QtOmL7Fe5+nBIHL+B/GwRBpraNagH2qzZDu1bCv/fWWYqZ8nm/kX
         1xZBPvzi6313GChDel3JDhVS5TeuLSS2lKNv8XE5G9v3POnRjyrPe4mKnpFLvz6dLA4d
         TJX6DpGSafsn4LHoPtFZQayijlQ70iwO9a2TMO1iue8szfSUzFkdz3aPW6BXWp84GE5V
         sowYBPqRscTy0x/OeuPOtWTLxQzPxSy7OZHTvBg62wWHhgCkfbT7tT4LLraCMTxN1Yah
         YTQegUfAlBZChaSKiO7d+VwQIjm/TCJPTYn5sy4WMDxp+BfpOnQOZXZJ5sGj9lu2oyl4
         XN6A==
X-Gm-Message-State: AHPjjUjpKEfCFbbNTeFSpGxJUiS6y0Hsb+C6KDHFSx9rGQ5g//McDqC+
        uKt9LdDJNSzaSCYeCqY0akmI6g==
X-Google-Smtp-Source: AOwi7QBJ0b9UkD84O8dXtBHIxfqCQxzdf3GRRC/3Ut0TYqOoJk7PJ2ga03QQKz14s4E7zXltC7tBsA==
X-Received: by 10.99.95.204 with SMTP id t195mr538814pgb.135.1506121083946;
        Fri, 22 Sep 2017 15:58:03 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:840f:cadd:b54e:2e8c])
        by smtp.gmail.com with ESMTPSA id z83sm1004604pfd.10.2017.09.22.15.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2017 15:58:03 -0700 (PDT)
Date:   Fri, 22 Sep 2017 15:58:02 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK) (part 3)
Message-Id: <20170922155802.ab79717818578a23cc31f6fe@google.com>
In-Reply-To: <7977bab0-09c3-0e43-4d6f-f2bf87a3fd9e@jeffhostetler.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <af717446-95bf-c5a5-cd27-aaf20531db0f@jeffhostetler.com>
        <20170921160416.1c4c6e2c@twelve2.svl.corp.google.com>
        <7977bab0-09c3-0e43-4d6f-f2bf87a3fd9e@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 17:32:00 -0400
Jeff Hostetler <git@jeffhostetler.com> wrote:

> I guess I'm afraid that the first call to is_promised() is going
> cause a very long pause as it loads up a very large hash of objects.

Yes, the first call will cause a long pause. (I think fsck and gc can
tolerate this, but a better solution is appreciated.)

> Perhaps you could augment the OID lookup to remember where the object
> was found (essentially a .promisor bit set).  Then you wouldn't need
> to touch them all.

Sorry - I don't understand this. Are you saying that missing promisor
objects should go into the global object hashtable, so that we can set a
flag on them?

> > The oidset will deduplicate OIDs.
> 
> Right, but you still have an entry for each object.  For a repo the
> size of Windows, you may have 25M+ objects your copy of the ODB.

We have entries only for the "frontier" objects (the objects directly
referenced by any promisor object). For the Windows repo, for example, I
foresee that many of the blobs, trees, and commits will be "hiding"
behind objects that the repository user did not download into their
repo.
