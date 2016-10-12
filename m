Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D14207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 15:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbcJLPiq (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 11:38:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34951 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933301AbcJLPio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 11:38:44 -0400
Received: by mail-lf0-f67.google.com with SMTP id x79so7719141lff.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nwYk0gEFNThERkFlpZTkWU7nheVeewapRxkH57jaKA4=;
        b=zWRu/e1kSa1YIu9egRlhY/P/x7KeDGHCbTHu6wBWhMHclXI3oTKFNI48cujlIwaeos
         YgueGh0VdPeIEs0v1YLV65I+g3pfJqzMrJ7p+w8C/po6dsZ0ZdgiylBMIPTVGSb2jD0u
         ETjb+/vlmkwzlW4bjlwtU7qYnZX1kYvpGUrQUKufMQqYwm6rTIgLnTyGNFq9uvmMZ8X/
         EmVRasfRbSq1YcLpkVBIEIi5HdrmnRl3GeiHcnMbsfoV/Qt1m5SXN5nNjsZLe+C2bIu2
         evqqiCclykDUtENukoc/7x5sUHS/V7I9eEi7SIK5S8bjjx6SkYfIp2PG9W5h9GSzhbis
         SX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nwYk0gEFNThERkFlpZTkWU7nheVeewapRxkH57jaKA4=;
        b=TKGjvgECq+IWg8Tos+KCTGWKnNgj3Yv/0gDPpe2SAPCdy55HnvlpHmT/5NwIfjUc2+
         UPq1o92nHsl8FArGmEsHq0wUWi9pnTfEtNJbXrW0Rh6sRJM4p/IfCQsQz94lIUmjHMav
         1N3wDjZ62qi66ESjPRUakat1TVa7sDOD4TQhwSpQhhnIkd7UpD3qAPlvh8r2hL+jiYhT
         3KsSyIN8WF6L/4zpXzVwszHVowg9wkATi1sxrm7B4UwxmvnsK6QbjeebtMCJ+/im9zO9
         pkkdKOm2u/DLFgkPewvUmir6dAQdbxDg5oTf2EFWsClSBSgTLzj0+ZZSZp+deovx+NKV
         2kHg==
X-Gm-Message-State: AA6/9RkqSGLXqzZt3QzQG5tjQg7Zv0o/SSQ1P3geOrAQqc+/57Wd0vgadX1QPsTt3xWArR+mcsVSMBRrF2bBKQ==
X-Received: by 10.25.155.211 with SMTP id d202mr1963309lfe.129.1476286695426;
 Wed, 12 Oct 2016 08:38:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.44.141 with HTTP; Wed, 12 Oct 2016 08:38:14 -0700 (PDT)
In-Reply-To: <8e12e0954f0a23d7c7905c58a3f7d8084d9338be.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <8e12e0954f0a23d7c7905c58a3f7d8084d9338be.1476232683.git.jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 12 Oct 2016 17:38:14 +0200
Message-ID: <CAP8UFD03sOgVVb5-VEgHxHaXBBUPJ9UTB0=Y=th8YnUCk+Aa4Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] trailer: use singly-linked list, not doubly
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 3:23 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Use singly-linked lists (instead of doubly-linked lists) in trailer to
> keep track of arguments (whether implicit from configuration or explicit
> from the command line) and trailer items.
>
> This change significantly reduces the code length and simplifies the code.

It's true that the code can be simplified a lot by using a
singly-linked list, but if we already had and used some generic
functions or macros to handle doubly-linked list, I doubt there would
be a significant simplification (as the generic code could not be
deleted in this case).

> There are now fewer pointers to be manipulated, but most trailer
> manipulations now require seeking from beginning to end, so there might
> be a slight net decrease in performance; however the number of trailers
> is usually small (10 to 15 at the most) so this should not cause a big
> impact.

By default we append new trailers at the end of the trailer list, so a
singly-linked list is theoretically not well suited at all for
handling trailer lists.

You say that at most there is a small number of trailers, and that may
be true indeed for the Linux kernel and most projects these days, but
I am not sure it is a good assumption to make in general.

For example if some projects use or start using "CC:  *" trailers and
tools to automatically append such trailers (perhaps using 'git
interpret-trailers' for that purpose by the way) based on people who
touched the same code, then it could very well be a common thing to
have 20 or more trailers on patches/commits for these projects.

There could also be automated testing tools that add their own
"Tested-by: *" trailers, and projects that require many people to add
their "Reviewed-by: *" trailers to each patch/commit. And in general
with millions of users, it is not very safe to make assumptions that
they will all be "reasonable" in the way they use a feature.

Another thing is that when Git started, I doubt many people would have
thought that there would often be more than just one or two
"Signed-off-by: *" trailer, and now 10 or 15 doesn't seem unthinkable.
In fact 'git interpret-trailers' has been made precisely because there
are more and more trailers, so there is more and more a need for a
tool to properly add and manage them.

We recently had a discussion on the list to increase the default
abbreviation length because it was not foreseen at the beginning of
Git that people would need a larger number of characters as projects
grow.

So even for the Linux kernel, I am not sure that it is safe to assume
that the number of trailers will not grow much over the years,
especially if we work on the tool that can make it easy to easily and
automatically add them.

Thanks,
Christian.
