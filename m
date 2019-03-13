Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F32020248
	for <e@80x24.org>; Wed, 13 Mar 2019 02:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfCMCS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 22:18:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35848 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCMCS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 22:18:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id e16so258309wme.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ChKcj8iAqblXiQA6TY3WDOXeerD0Y6YX0Q9qNAI/wDM=;
        b=CTKjftUqk7NfbRNRqT73l689Olr3cV1ZPonFerFCj0KUkgJtaeFffW5kvWr9VHn0N0
         AWmuGR5/tlZCGYt+VPrM0BLsI5Fq/gIa8r0PZsUsp87UYPQ8ClfxAj8v81Qf7SiJ5DRC
         yBu1CS95mp0BeJbH4znXZSZJQhhJTPoTG/hm5wYcu17NJRZ9OUAJYwa6gGW5uLQ8vgbg
         wJf7SRXQFxAvyimOviErTk5CihbgxT4lWLLjMgD5Cx5ACNoSVowSXW8HT7j6od7WjhxR
         Yw8XoFJUzhor+7Cns/EjPUKRQy43zAcQLZK5qVoX0vh3+1fsgjiCR1akZvAvudYnfi40
         /xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ChKcj8iAqblXiQA6TY3WDOXeerD0Y6YX0Q9qNAI/wDM=;
        b=tXGm6/HPtD9NkLhEaFyhq01R8vvC8dd7B1AZDHpOMrFw3NKWcbOcon9tSvIpudUQF2
         fPhkbWBPzfkpyXOHQJibNzxK5p+Mwn+crjZwlssCSoJYIGnOWh64reojB7uuTomP344/
         aXNWEdTHjzYySuAYJrT/Q6BB2Igujg+Lxgs80ysJ+eLmYRZxn6bVHFzzI8y4EXHfuJdh
         3IbUxES3NZFy4Kz5b43pTLO1bZhJ7ff/wotO7M0UdtzueDAHVmApcr5WkUjVoMG2xDt9
         wB2SpBttWrvG2BhFkwBAkuZHsP12U9gemnE/dMRzfjq/1ZSRpMTr7pQnvjXn0lhq9AX6
         ij3Q==
X-Gm-Message-State: APjAAAW7wjdG0ZFNZNBjt+ps7eo/5Ybf4ytI4eiq7lQQBsO8kV3iv+Vt
        uUO54pI3G2F50JEN9dzJIQPNnfqu/xc=
X-Google-Smtp-Source: APXvYqw85+qc8GRTsabrYfocbPLUvOwpu0j0CEF+lhVl29Tet8/C21lNaHw8cRPVhivdvLCX6AehNg==
X-Received: by 2002:a1c:449:: with SMTP id 70mr453999wme.118.1552443506229;
        Tue, 12 Mar 2019 19:18:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y140sm1135850wmd.18.2019.03.12.19.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:18:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
References: <20190312213246.GA6252@sigill.intra.peff.net>
        <xmqqef7bfrxv.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 13 Mar 2019 11:18:25 +0900
In-Reply-To: <xmqqef7bfrxv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 13 Mar 2019 11:07:08 +0900")
Message-ID: <xmqq1s3bfrf2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> -Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
>> +Nevertheless, you can use [Git Git Gadget](https://gitgitgadget.github.io/) to
>
> The pointed-at page calls the tool a single word with three capital
> Gs without SP in it.  We should match it here and in the other
> document.

For now, here is what I have locally.  Again, thanks all.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 12 Mar 2019 17:32:46 -0400
Subject: [PATCH] point pull requesters to GitGitGadget

In the contributing guide and PR template seen by people who open pull
requests on GitHub, we mention the submitGit tool, which gives an
alternative to figuring out the mailing list. These days we also have
the similar GitGitGadget tool, and we should make it clear that this
is also an option.

We could continue to mention _both_ tools, but it's probably better to
pick one in order to avoid overwhelming the user with choice. After all,
one of the purposes here is to reduce friction for first-time or
infrequent contributors. And there are a few reasons to prefer GGG:

  1. submitGit seems to still have a few rough edges. E.g., it doesn't
     munge timestamps to help threaded mail readers handled out-of-order
     delivery.

  2. Subjectively, GGG seems to be more commonly used on the list these
     days, especially by list regulars.

  3. GGG seems to be under more active development (likely related to
     point 2).

So let's actually swap out submitGit for GGG. While we're there, let's
put another link to the GGG page in the PR template, because that's
where users who are learning about it for the first time will want to go
to read more.

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Roberto Tyley <roberto.tyley@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .github/CONTRIBUTING.md          | 2 +-
 .github/PULL_REQUEST_TEMPLATE.md | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
index 64e605a02b..e7b4e2f3c2 100644
--- a/.github/CONTRIBUTING.md
+++ b/.github/CONTRIBUTING.md
@@ -5,7 +5,7 @@ Git community does not use github.com for their contributions. Instead, we use
 a mailing list (git@vger.kernel.org) for code submissions, code
 reviews, and bug reports.
 
-Nevertheless, you can use [submitGit](http://submitgit.herokuapp.com/) to
+Nevertheless, you can use [GitGitGadget](https://gitgitgadget.github.io/) to
 conveniently send your Pull Requests commits to our mailing list.
 
 Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
index adba13e5ba..952c7c3a2a 100644
--- a/.github/PULL_REQUEST_TEMPLATE.md
+++ b/.github/PULL_REQUEST_TEMPLATE.md
@@ -1,7 +1,7 @@
 Thanks for taking the time to contribute to Git! Please be advised that the
 Git community does not use github.com for their contributions. Instead, we use
 a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
-bug reports. Nevertheless, you can use submitGit to conveniently send your Pull
-Requests commits to our mailing list.
+bug reports. Nevertheless, you can use GitGitGadget (https://gitgitgadget.github.io/)
+to conveniently send your Pull Requests commits to our mailing list.
 
 Please read the "guidelines for contributing" linked above!
-- 
2.21.0-155-ge902e9bcae

