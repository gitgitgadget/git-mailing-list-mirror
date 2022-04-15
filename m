Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B386C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 22:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356345AbiDOWhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDOWhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 18:37:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A8B717D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:35:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s137so8794874pgs.5
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rV1y33j5ZqmQ9/uKB6izngNNTFzXHD6SPL4jDWbVHRI=;
        b=HVcPpbrQxL9W+a4H3+2n0O8E9TqwAzneBV7ACE7fx0QUVGdVQlgheU7nhbY47l39ZK
         9XZITBkD4hVAMoHBvpLVzUtHnzZz+MPcVaxtOXTqFvlaOAkdqFHhU9fJJ5KSgjXRlN17
         QEwRYSiZ7DPoZtbpUYHWU+zPrB07P866ZWTKAgUxJfs/TzuOrtvM4A7Q6Zc0TXyNk8pj
         nIxO/T0Ip1tc7UWW2D7g9fAIWl5o4HJuDM6tfmmFORYSNYo5a6eL1fkJ03pX7oEnXWjM
         gp/BPNMQBUkCAyZVXlA3d365GcN7ZMvR5Z+JxsLRz/+KNngZ3ayK5ymwJqDz510bEggO
         P0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rV1y33j5ZqmQ9/uKB6izngNNTFzXHD6SPL4jDWbVHRI=;
        b=ixpefuboqvHfKpuAc8/fgGOFfx7A3v0Vj5LKp483C2YUbMAtemkb3v5aNSGRQjG2on
         m3TKNeBz1Sa9suWEZ1doPjDpLwrLuFf6ycUmcRLxuRwJxlSq7zkkD11tpwXjMQzFk/cF
         4LWok7R4//MZent4Fby+PHJGLZOaUzM/Q7i11zwr094+ABaHmcNRUfAaZs5cQ7rFEL4b
         D3nE49zrN2OAnofahi64VBNqZQMFhztwRQ2+dCB5qUrzE5IfURJYo6KmnzTypmvX+Xro
         KPsk60GBSSQJvSUCN1tvGPXZyYiVNn1C3ZKB0lj057kcVv11HacY7TLGjUdFl4eTaWlK
         hctQ==
X-Gm-Message-State: AOAM531Q09h0lfRKqSIgQ/FiPnBGL0XREaTnQsWFuZQHIS7NO+0e4cBA
        QtgudOyixfIUWYInS+c9pSZwD+JLiuwwKc79
X-Google-Smtp-Source: ABdhPJy7HsoIeDRYupIKdQ79k85u/4mNIRNEuEnSvOE6KQI6dcZw6WoS6Bnl9iDkvVtEFfThVxzVQw==
X-Received: by 2002:aa7:8215:0:b0:4f7:125a:c88c with SMTP id k21-20020aa78215000000b004f7125ac88cmr1198655pfi.70.1650062112107;
        Fri, 15 Apr 2022 15:35:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1cac:aa81:faef:d183])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00505a61ec387sm3785619pfa.138.2022.04.15.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 15:35:11 -0700 (PDT)
Date:   Fri, 15 Apr 2022 15:35:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2022, #04; Thu, 14)
Message-ID: <YlnzGecOaayPM6ve@google.com>
References: <xmqq8rs7yzul.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8rs7yzul.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After quite some time, I'll provide an update on the "submodules UX
rework" effort Google has been working on.

On Thu, Apr 14, 2022 at 05:06:26PM -0700, Junio C Hamano wrote:
> [Stalled]
> * es/superproject-aware-submodules (2022-03-09) 3 commits
>  . rev-parse: short-circuit superproject worktree when config unset
>  . introduce submodule.hasSuperproject record
>  . t7400-submodule-basic: modernize inspect() helper
> 
>  A configuration variable in a repository tells if it is (or is not)
>  a submodule of a superproject.
> 
>  Expecting a reroll.
>  cf. <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
>  source: <20220310004423.2627181-1-emilyshaffer@google.com>

Yes, a reroll is planned. The most recent attempt (locally) also rerolled a
follow-on series adding a shared "config.superproject" readable by both
a superproject and its submodules, in order to demonstrate some
real-world application and an example of how to use this config telling
us whether or not we're a submodule. The series has gotten away from me
- as I've been working on internal team planning type things.

Beyond this work, there is some other work in progress, still in design
stages downstream:

Glen Choo is continuing work on design for 'git checkout -b'/'git switch
-c' when submodules are involved and 'submodule.recurse' is set.

Glen Choo sent an update to continue converting 'git submodule update'
into C; this appears to have no reviews.
https://lore.kernel.org/git/20220315210925.79289-1-chooglen%40google.com

Josh Steadmon is working on design for 'git pull --rebase
--recurse-submodules' in basic (non-conflicting) cases; this means he's
also working on 'git rebase --recurse-submodules' in these same basic
cases. This work is still fairly early in the design stage, but will be
something to look forward to.

Beyond those pieces, I thought it might be interesting for me to share
what's coming up for my team from April through June. So here's a grab
bag of what's next for us:
 - Improving 'git fetch --recurse-submodules':
   * To retry a failed submodule more than once (in fact, the existing
     behavior seems to have a bug: if we fail to clone a submodule in
     the "retry queue", we give up and don't try to clone any of the
     other retryable submodules after that one)
   * Cloning submodules that were added in a commit which is newly
     fetched with 'git fetch'
 - Parallelizing 'git checkout --recurse-submodules' (at least when
   partial clones are involved). Without this change, we see that the
   initial checkout of a partial-cloned repo with many submodules takes
   a long, long, long time.
 - Parallelizing 'git status --recurse-submodules' when many submodules
   are involved (and probably tidying the output)

And some more odds and ends. After those few bits, and the in-progress
work already seen on the list, we have some users lined up to try the
workflow, because we're pretty sure that puts us in a position to try
out basic Git usage with many submodules. So hopefully we have some
interesting feedback and bug fixes coming from that, as well.

 - Emily
