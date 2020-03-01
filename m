Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CC0C3F2CD
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 01:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004A9214DB
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 01:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCABQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 20:16:13 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34711 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCABQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 20:16:12 -0500
Received: by mail-wr1-f52.google.com with SMTP id z15so8072628wrl.1
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 17:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzIzU8x2F0gI4pra4VJv1T2GJU3hYWl2q5ck1V9TNiY=;
        b=U1VZu4rXWKfG1oAtcPMAzGRpwu1CcdDvZzqKJQEd2/rg0zYoSa3UHZEwVB+pW6o3zq
         cQMxlRr9fm9+iIe2XN8qpdO7auXNCFMqLNLOos4PZ1BCHSKLbhf0hXjgb/u3CX/8pdcW
         QY7OUrvwafpcQfP9zKAXsJRq39wUKbCfCUcvsZmuBUHe2AuKJkedd15AeIU3wRHoawj0
         zTm3wZJRNBo6VvibC1wtJRtSAnT/R37YxzzKTjW5+Kk0SNRdZaBcR+dl6IXAat7bLh9A
         714R/khfKHUxwANMvgLoW+4AAFzDDT+flxVtuSp19W8GerR1UzTdXAsBLh69Y7nwegmo
         Im8g==
X-Gm-Message-State: APjAAAV8k1bn7+Wi2VXZcBHDjUkY+rSk03/E3I6CMchsXibOwyCcuzRX
        3V7kRVcqC1T2uZSyq+YChU9+NWaI78UahYnuT4U=
X-Google-Smtp-Source: APXvYqz/OVI0LPR3JBm8AC+qh/24LXFkVLp9znD5/B+BI/6834fsUywGRuiqm0jEMKNfNb/pjWrckPQaEZqJ49zpq8I=
X-Received: by 2002:a5d:424e:: with SMTP id s14mr13728259wrr.226.1583025371071;
 Sat, 29 Feb 2020 17:16:11 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimjqcoh0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimjqcoh0.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 29 Feb 2020 20:16:00 -0500
Message-ID: <CAPig+cSZvVWbzKp6uEmPxZVgUQdzwgjjfz81PJRYdG+OQ__kdw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #06; Fri, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 5:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/worktree-avoid-duplication-fix (2020-02-24) 3 commits
>   (merged to 'next' on 2020-02-25 at 74c612837a)
>  + worktree: don't allow "add" validation to be fooled by suffix matching
>  + worktree: add utility to find worktree by pathname
>  + worktree: improve find_worktree() documentation
>
>  "git worktree add" used to get confused that the director to be
>  used to add a new worktreey, when given as a relative path, is
>  different from an existing one.  This has been corrected.

This description still has the problem with inserted text splitting
the "y" off "directory". Did we want to go with the revised
description suggested by [1]?

    In rare cases "git worktree add <path>" could think that <path>
    was already a registered worktree even when it wasn't and refuse
    to add the new worktree. This has been corrected.

[1]: https://lore.kernel.org/git/CAPig+cR3H2qvCddWuWPNex=K-x0FyzKehpbOiv7W-s_4EAW1bQ@mail.gmail.com/
