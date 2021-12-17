Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83306C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 18:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhLQSjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhLQSjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 13:39:46 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F804C061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 10:39:46 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id jo22so3209581qvb.13
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iqLRhQ5qUEMXWCesO8S9OsKj+D62U2tPxTWmqx/+seU=;
        b=XRRR+yToDR1gU/TBHLCWXllRcJdTSQbf08Qiqs5saqjrIPe8ivOuvx958Bx1195G1R
         +D/yc9HVeEZAV5s0Us1aOZ6cDaNRJEK+fMvBAAapY6dayM/kozcJ1jf1DHs7po+/nyj/
         TeelyynWRw1tXF8PYgSsYixyym0eRucL4lOh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iqLRhQ5qUEMXWCesO8S9OsKj+D62U2tPxTWmqx/+seU=;
        b=VntVLXkwOScXJ9IlZ5ocTMW3ohiFWbD+D4kw8qX9FbcylGtRwl4zgCaMe6L1xt0TKm
         iJlZzfk7isF8E0723jFwTob9/+t89BU6iGkhBJ8r8t7aBuNeM66pwnscdYbd91eapztI
         wYKC1rKoJIFkwjOxbTNwGq2TaZNozQ00LDEtd5MbVJlorHlHQ+/v1/h/Mly9+Al+kCcc
         pC1ScdjYFs9HM8zn4GouA4GhWid2i8EFkuo7DtNkcWNvTBwE7ZGqcyb4gk/8XZu/Tlxe
         aShVZstiVVzMjJ5LY6Nx/B5mM6d2Hdq9Ixer491Ii7uEZRRqxbO/DQpbvdt/eqblPeRL
         1kEw==
X-Gm-Message-State: AOAM533ropBuo95b8G7N5LfrlGTrVojQe4C9dIf3hMvtNI8Tj4zCPhyh
        JKCsYo/Q2ypLbksz75mRis4UEw==
X-Google-Smtp-Source: ABdhPJxlEzDtEtqRiXMSJK9GT/2HEJuZ4q/ohF9OQWupejwf8XDR9rHulQjx5BzsCh0xdQBpJSkLtA==
X-Received: by 2002:a05:6214:c6f:: with SMTP id t15mr3550163qvj.49.1639766384849;
        Fri, 17 Dec 2021 10:39:44 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id w8sm7864355qtc.36.2021.12.17.10.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:39:44 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:39:42 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        steadmon@google.com, chooglen@google.com, calvinwan@google.com,
        workflows@vger.kernel.org
Subject: Re: Review process improvements
Message-ID: <20211217183942.npvkb3ajnx6p5cbp@meerkat.local>
References: <YbvBvch8JcHED+A9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbvBvch8JcHED+A9@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 02:46:21PM -0800, Emily Shaffer wrote:
> Some of those discussions resulted in changes - for example,
> GitGitGadget was improved and added to git/git, and we enjoy easy,
> non-noisy CI runs via GitHub Actions. But some things we thought were a
> good idea never went into practice. In the next few months, the Google
> Git team is planning to implement some of the following changes, and
> we'd appreciate your thoughts ahead of time as well as your review later
> on:

I'd like to also mention that I'm hoping to add a few more features to b4 that
will hopefully improve the patch submission process for folks. This feature
set is far from being complete yet, but the gist will be as follows:

1. b4 submit --new: this will create a new tracking branch and define
   some metadata to go with it, such as a cover letter template. The cover
   letter can be edited using `b4 submit --edit-cover` at any time.

2. b4 submit --send: will generate a patch series from any commits created
   from the topical branch fork point and use the cover letter from the
   previous step. It will be able to send the patches using the traditional
   SMTP way, OR it will allow using a web-based submission service I'm setting
   up at kernel.org:

   - anyone will be able to submit valid patches through this service
   - one-off patch submissions will require an email confirmation roundtrip
   - any submitter can also register their ed25519/openssh patatt key with the
     submission service and just cryptographically sign their patches. As long
     as signatures validate, no roundtrip confirmation of patches will be
     required after the initial public key registration.
   - on the receiving end, the patches will be written to a dedicated
     lore.kernel.org feed *as-is*, but also sent to the recipients after doing
     the usual From/Reply-To substitution and moving the original From into
     the in-body git headers (i.e. same as GGG does).

3. b4 submit will properly include base-commit information to all submitted
   patches, as well as a unique change-id trailer (but in the basement of the
   cover letter, not in the commit message trailers as Gerrit does).

4. b4 submit --sync: will retrieve any received code review trailers
   (reviewed-by, acked-by, etc) and amend the corresponding commits in the
   topical branch, assuming we can match patch-id's (I've not tackled this
   yet, so I may be unduly optimistic here).

5. b4 submit --reroll: will prepare a v2 (v3, v4) of the series, reusing the
   same change-id trailer and adding a templated "Changes in v2" entry to the
   cover letter (that must be edited before --send works again).

6. b4 submit --send: will send the new version of the series.

I'm hoping that this will improve the experience of patch submitters *and*
help ensure that CI can be incorporated into the process by streamlining the
submission procedure and providing a public-inbox feed that can be easily
monitored. A service like GGG can fairly easily convert well-formed patch
series (at least those carrying valid base-commit info) into ephemeral
worktrees, or even into simulated pull requests if the goal is to do this via
a generic CI service.

The important goal is to keep development fully decentralized so that even if
the web submission endpoint provided by kernel.org becomes unavailable, plain
old SMTP submission mechanisms can still be used as a fallback.

(Unfortunately, I need to focus my efforts on some kernel.org infrastructure
changes at this time, so I'm not sure when I'll be able to complete these
features.)

> 1. Draft a MAINTAINERS file

So, I *don't* recommend that you go this route. The biggest problem with the
MAINTAINERS file as used by the Linux development community is that making
changes to it is a very high-latency process. It will be less of a problem for
the much smaller git developer community, but it will still result in folks
operating from a stale copy of the file for weeks after it is updated
upstream.

One of the goals behind the "lei" tool by public-inbox is that it allows
search-based subscriptions (including things like "what files are being
modified, what functions are mentioned in the git context", etc). Anyone can
define a set of parameters they are interested in monitoring and receive only
threads matching those pre-filtered messages. We are currently rolling this
out as an end-user maintained setup [1], but the goal is to also offer this to
maintainers as a centrally managed service:

- maintainers will be able to define the search queries they are interested in
  monitoring
- we will set up a feed on our end matching those queries
- we will offer the feed as a separate public-inbox repository, a public IMAP
  folder, a read-only mailing list, and, I'm hoping, a read-only POP box (the
  latter mostly so it can be configured to feed into GMail).

The hope is that this will allow what you're looking for -- a way to
pre-filter the flow of patches to maintainers by making it topical, without
making the lives of patch submitters unnecessarily difficult by increasing the
chances that they will send their patches to the wrong list.

[1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started

I'm not sure where this all fits into your plans, but I wanted to show what is
happening on our end just so we're working in parallel, as opposed to in our
own separate worlds. :)

Best regards,
-K
