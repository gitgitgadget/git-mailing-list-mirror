Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454F51F404
	for <e@80x24.org>; Tue, 20 Mar 2018 21:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeCTVLI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 17:11:08 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:45472 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeCTVLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 17:11:07 -0400
Received: by mail-qk0-f177.google.com with SMTP id s9so3297341qke.12
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o3YNfReEBEThBM43OjMrfEpntzmGnhGDjL+4smv8f1A=;
        b=ZW46bp32QO9Ct/6ngRsbFReHlPE1MHLUJRU6GsYO+j5GT5m3HRFcwMfkpBr8dsLBI3
         AyWdcNQ5nrKNYEuxbKqart18Mqwjmwfw4lzjTkIRh9J9pt6N60Q4/yuUD0nLDPg2/dbD
         3D8fBf2U+yKdnOVt8500z+25yO6TOxeby5KlivURNcDGk2r5N0LvofAqDOy8hvOvyZBH
         W26g2YBtuAhJGxBpHbNwwupze47e8BV5oaXbw4L96mxtZoDiJG9QYgtfphNjhj7iEEAo
         eEmWevCgRxITE9czj2y3M5jTValr9E1+jrl2qR4WavQTWT1dp50mUO4VEcgIxZfmGd6m
         JYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o3YNfReEBEThBM43OjMrfEpntzmGnhGDjL+4smv8f1A=;
        b=PNMU6RF7DOEbIb141+Ya55ZpeRm+uGSZ7shi4YIagqJTOes7M9kprsnI8BIrgOYbUg
         Y36p0BoN+SPg8OoxLO88JBIuJrXJy3U9gbIhw1xWm2o+7Ehae7BHzxP4R/h8MfYHKGoU
         hR6Qbr+Anb9vA2Dc0MW05zp7NQELz5QPrnaZ2ifd4jfQPVBet5f/WKOG2RCM7bTP6n+E
         I1t42Fck4jQxzzoQyNWUPD/VHR7qMRDWCLusXQ/mBpSCQiuTsl038jCCP5h9uZHl0mZQ
         ydXPUN53Q3+5fkAYXC2oVpE3UGEAeUzxiZZMrb7iUZtwLaG7rPJ1xeiHcsbHqmaURvUZ
         4Vig==
X-Gm-Message-State: AElRT7EAHdrhhKt3VkIi09g2q4QuGmC2zZY5pwt53gEDhojen8osD3eG
        15HcUWgW9Fg1rqgWSPTnFQjyk98kUGauOycRu4c=
X-Google-Smtp-Source: AG47ELsSzxvJxJ0ZrVmdB0PfyNKnP7z/i3C79QCTfLjT8jH9XndiaYaFhQuxBlkwGKUlyIHMe631L0aChiJ08LgoGbc=
X-Received: by 10.55.159.140 with SMTP id i134mr22326470qke.220.1521580266406;
 Tue, 20 Mar 2018 14:11:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 14:11:05 -0700 (PDT)
In-Reply-To: <20180320204507.12623-1-wink@saville.com>
References: <20180320204507.12623-1-wink@saville.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 17:11:05 -0400
X-Google-Sender-Auth: kje5Vzj1-s9RprsddYByE0MdBUQ
Message-ID: <CAPig+cRw4MSfcKJcgT-srCE7sDYi3qA0TrNApXBDBsgodVb3Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] rebase-interactive
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 4:45 PM, Wink Saville <wink@saville.com> wrote:
> Patch 0001 creates a library of functions which can be
> used by git-rebase--interactive and
> git-rebase--interactive--preserve-merges. The functions are
> those that exist in git-rebase--interactive.sh plus new
> functions created from the body of git_rebase_interactive
> that will be used git_rebase_interactive in the third patch
> and git_rebase_interactive_preserve_merges in the second
> patch. None of the functions are invoked so there is no
> logic changes and the system builds and passes all tests
> on travis-ci.org.
>
> Patch 0002 creates git-rebase--interactive--preserve-merges.sh
> with the function git_rebase_interactive_preserve_merges. The contents
> of the function are refactored from git_rebase_interactive and
> uses existing and new functions in the library. A small modification
> of git-rebase is also done to invoke the new function when the -p
> switch is used with git-rebase. When this is applied on top of
> 0001 the system builds and passes all tests on travis-ci.org.
>
> The final patch, 0003, removes all unused code from
> git_rebase_interactive and uses the functions from the library
> where appropriate. And, of course, when applied on top of 0002
> the system builds and passes all tests on travis-ci.org.

A problem with this approach is that it loses "blame" information. A
git-blame of git-rebase--interactive--lib.sh shows all code in that
file as having arisen spontaneously from thin air; it is unable to
trace its real history. It would be much better to actually _move_
code to the new file (and update callers if necessary), which would
preserve provenance.

Ideally, patches which move code around should do so verbatim (or at
least as close to verbatim as possible) to ease review burden.
Sometimes changes to code are needed to make it relocatable before
movement, in which case those changes should be made as separate
preparatory patches, again to ease review.

As it is, without detailed spelunking, it is not immediately clear to
a reviewer which functions in git-rebase--interactive--lib.sh are
newly written, and which are merely moved (or moved and edited) from
git-rebase--interactive.sh. This shortcoming suggests that the patch
series could be re-worked to do the refactoring in a more piecemeal
fashion which more clearly holds the hands of those trying to
understand the changes. (For instance, one or more preparatory patches
may be needed to make the code relocatable, followed by verbatim code
relocation, possibly iterating these steps if some changes depend upon
earlier changes, etc.)

Thanks.
