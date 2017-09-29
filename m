Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929FA20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 00:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbdI2Ax4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 20:53:56 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:52477 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdI2Axz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 20:53:55 -0400
Received: by mail-pg0-f44.google.com with SMTP id i195so1836263pgd.9
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaBpodoEiVR+LkzIT0JmcFD7lhgAfgQfPtwX0HlhIFU=;
        b=pbqaGVEAXrih9Qu0YOg3m14fdrYlz84kzvE2XGgJiB8VpRSS+kxcuNNwj5OXe2AITv
         hlGPOJoRjalPdts8kwhjP+rGvWPMVBJ4SRPi6c56GI47CwEUE9RxgNc3hvhBY0TA/mH3
         5vhakJqs9mDIHW2NTGkYOC+WhVLHP05cJnQQV0EhC0ApapOs7ywXxWLAzPQBzEaTjBq9
         SR4sDStIbbhKcYY6RvgyODd5z6nlDm4sy66UmF8jjTsJA7LjA9H8+0zrgkHNdOnNy7o3
         KeQe4yJYW4AsSSNy872TkbkzjTRdogX7PT2Scaphvhfgbuulfr2My1IKBGjHq16QA9SX
         lXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaBpodoEiVR+LkzIT0JmcFD7lhgAfgQfPtwX0HlhIFU=;
        b=IM8gzVFnqjCKdaoHHlqloHeoFkHYDmeHPPUL2zouPiz7beWaIyK1KXnFAFQKaW12AG
         A9zzPvpVtebCBi3nmKnNjURGzDCMVIZSXH88+hbvjEbUMRG6fGU7+lq3bDYiYfSkpBAk
         gYzav24iVEFbVOMVbB3OaSlcpq63RuadP3kuD9gratFdK9VJpilWrweo4ZT4s1yS1Ufh
         IDUttEwpPB4BurPyB/8htU+om0ywLyT8eDzHSPjTexkyjGK7akXMzjtEcCcNXzLkLvCz
         mS9g/ieomlecZ+ovbUrWJTbd/EoryMfbfyptlwnMtyKJ+o+m1A8rM+qoRsBa7Q0/x7oK
         roDQ==
X-Gm-Message-State: AHPjjUhyO3lXCr/O5mCiUu7sB8oFQlJHvPYU80I+GfPILIfpOle4LXfn
        YsE1vdFpjIIZNpzpN/HGZzeIaw==
X-Google-Smtp-Source: AOwi7QD9HjUuoexVnHXaV2yCoWeXaU9rRuRPvu8imcKkFctVa9TS8QUtYvbUg7BBl1vjTdiBs6h5oQ==
X-Received: by 10.98.155.139 with SMTP id e11mr5851058pfk.290.1506646434683;
        Thu, 28 Sep 2017 17:53:54 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:90bd:4d6a:ace4:8d67])
        by smtp.gmail.com with ESMTPSA id h1sm4194833pgp.37.2017.09.28.17.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Sep 2017 17:53:53 -0700 (PDT)
Date:   Thu, 28 Sep 2017 17:53:52 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>,
        git@jeffhostetler.com
Subject: Re: RFC: Design and code of partial clones (now, missing commits
 and trees OK)
Message-Id: <20170928175352.9a490564d47172568ea2f416@google.com>
In-Reply-To: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Sep 2017 13:43:43 -0700
Jonathan Tan <jonathantanmy@google.com> wrote:

> For those interested in partial clones and/or missing objects in repos,
> I've updated my original partialclone patches to not require an explicit
> list of promises. Fetch/clone still only permits exclusion of blobs, but
> the infrastructure is there for a local repo to support missing trees
> and commits as well.
> 
> They can be found here:
> 
> https://github.com/jonathantanmy/git/tree/partialclone2

I've pushed a new version:

https://github.com/jonathantanmy/git/tree/partialclone3

Besides some small changes as requested by comments on the GitHub
repository, I've also updated the code to do the following:
 - clarified terminology - in particular, I've tried to avoid
   "promised", only using "promisor object" to denote objects that the
   local repo knows that the promisor remote has, whether the local repo
   has it or not
 - restored bulk checkout functionality (so now you can clone with
   --blob-max-bytes=0)
 - a fix to fetch-pack to restore a global flag after it uses it, so
   commands like "git log -S" still work (but to test this, I used
   --blob-max-bytes=200000 with the Git repository, because batch
   fetching is not implemented for commands like these)

In its current form, the code is already useful for situations like:
 - a large repository with many blobs in which the client only needs to
   checkout, at most, and does not need to search through history
   locally, and
 - a repository with a few large blobs, where the client still can
   search through history as long as the client is online
