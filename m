Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F971F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 08:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeCUIys (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 04:54:48 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36333 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCUIyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 04:54:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id a20so4484322qtj.3
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yBPCocaEBl07+E00OQicdB03NrF57pYo3wx0cEFu/8U=;
        b=H9uwsv8NVVC2vx44k47BwH3NUgmepFtkQI/dr8uMHpqKL67A2rjks6A5pmkECQOBi9
         jorSfbJV3uqM4BqDsrMjGI6fG4J4HMu7qJS7DdnugOsqCxErwCE8mp1hXSPZEhjgrV+y
         Xy78hBhzhFbiWLoZZskiJ0NMHZMql7QpQYo6MUnJEEnIE3DFa95y46aNjKb0M5yOqcxn
         GHEj2PJ6yiVpS2JmKllLiw+3SQjpVVYeQ3lvS5hxsCT6Wpsz3Fh82UI2k8znqQesW4P5
         UngXO0g7LwbgmlMRa3rR69E4WqgsnTmruw1e4PfaYpUPSghJlaFt8Bccmx0EvtNalU0w
         SBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yBPCocaEBl07+E00OQicdB03NrF57pYo3wx0cEFu/8U=;
        b=NZ1mWel12BIoaTx5SOjeI3jlormBzi2MqZMkAd93AqZQe8xUOh6HnZ8QGLFiZMzk6t
         +9GbL/GlFVgcVMJ7ZIHmpV8tEaqxRSr0u66sguY8v0CpV9ianyRcEj1jvFmPrCYw9o5S
         Opw9qs24bZJoRDG6lpO7IJ8UYrZGWQc2qBGs/j+uqup12xK9eM0rt0nZNgWds9NerS1h
         RWkMfMcPLuXD9tie0TU3tP5buYhEZk7xQuXLZ0SMZnDl+MEEAi6c7pVA7qddlz8aTIwI
         6HCLCp+Q8cqQ+DksujJFp6Ef9rlbTGvTQHK1MZO1A9W/GOlYbnp1ts3D8LzPwyOE5iUJ
         CXUw==
X-Gm-Message-State: AElRT7GXOKq78/EZddDE6oANhCrJ5fGaVmZUY3sbrJtwmXLHLDtgoH93
        DXCh7V0utaVXbyBT5JN0KtpGjXU1Gj6NAl5pMCM=
X-Google-Smtp-Source: AG47ELsvBU7mGrBAyc9feC5FqRmxioZK3QS3ZalG668X726k/uSsxz31rkWDh5wma/WQ7fxVrLvG4C608+4gHi1DS3M=
X-Received: by 10.200.42.37 with SMTP id k34mr12928420qtk.101.1521622483764;
 Wed, 21 Mar 2018 01:54:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 21 Mar 2018 01:54:43 -0700 (PDT)
In-Reply-To: <CAKk8ispayA9ceLLRTQJd8_h_S7VaQqSoTBKGz+GjB3EbB7WO+g@mail.gmail.com>
References: <20180320204507.12623-1-wink@saville.com> <CAPig+cRw4MSfcKJcgT-srCE7sDYi3qA0TrNApXBDBsgodVb3Pg@mail.gmail.com>
 <CAKk8ispSvaAr3iRhC4X+gufeKm20AQzw9_mvuysT7SiDsZQYJw@mail.gmail.com>
 <CAPig+cSvvg=hXjXLKM2yYqqy=q+z_T_TVkuUJe0W=R_494CMkA@mail.gmail.com> <CAKk8ispayA9ceLLRTQJd8_h_S7VaQqSoTBKGz+GjB3EbB7WO+g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Mar 2018 04:54:43 -0400
X-Google-Sender-Auth: WgwxGG3NAz4RVgpHZl2tPyRGADY
Message-ID: <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] rebase-interactive
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

{cc:+junio}

On Tue, Mar 20, 2018 at 11:31 PM, Wink Saville <wink@saville.com> wrote:
> Anyway, I've played around and my current thoughts are to not create
> any new files and keep git_rebase__interactive and the new
> git_rebase__interactive__preserve_merges functions in
> git-rebase--interactive.sh. Doing that will preserve the blame for
> the existing functions.

"blame -C" detects code movement across files, so you needn't feel
constrained in that sense. (In fact, "blame -C -C" should detect the
copied -- not moved -- code in your patch 1/2, so my objection is not
entirely valid, although "-C -C" is potentially much slower.)

Nevertheless, leaving all the code in git-rebase--interactive.sh
sounds sensible if there is not a compelling reason to split it out,
especially since each refactoring (especially a big one) has the
potential to collide with in-flight or planned topics.

> But if I do indentation reformating as I extract functions that will
> be shared between git_rebase__interactive and
> git_rebase__interactive__preserve_merges then we still lose the
> blame information unless the "-w" parameter is passed to blame. I
> could choose to not do the indentation, but that doesn't seem like a
> good idea.

Don't worry about indentation changes during refactoring and code
movement; it's frequently necessary, and "blame" still works (with
"-w", as you point out).

> Thoughts or other ideas?

A few...

Although you may have the entire refactoring in your head -- you know
what you moved where and why and what changes were needed to make the
move possible -- reviewers don't have that luxury. A nearly 1000-line
patch, such as 1/3, which copies code (possibly verbatim or possibly
with edits -- reviewers don't know which) and which contains
newly-written code is a significant burden on reviewers. Crafting a
patch series such that it holds the hands of reviewers by laying out
each change in easily digested chunks helps significantly, both with
attracting more and better reviews, and with potential buy-in that the
changes are worthwhile.

However, I'm just one (potential) reviewer, and I don't want you
wasting your time embarking on large-scale changes based upon my
comments before hearing from Dscho (Johannes) and Junio if such
refactoring is even welcome.
