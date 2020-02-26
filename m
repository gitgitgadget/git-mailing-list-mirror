Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206DDC4BA0A
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 06:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E762521D7E
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 06:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgBZGyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 01:54:15 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42459 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgBZGyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 01:54:14 -0500
Received: by mail-wr1-f54.google.com with SMTP id p18so1521290wre.9
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 22:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCE9yFmNIHKGhXekCnapvnj1ZP8jv1DpwdNEjwI9+7Q=;
        b=pNq76ahXDXpWSKosCFyq4cYvHIhwWq7H7hhxDmL6vL5OB7mmmnzGIuTvQB/Qk00uTd
         /uaop5zbA7bSuQAEXJ1IJfYkEzibXupGL0DU1kj0bSzMEzKq6kjeC+EGJIjTJAtCGSm4
         9YMZAV0GU+7OCxd5Q62+szyrV6h4glvWEIHx/b+7MI1Sl1ZjUIYRqrJHy/+JUzRJ7MMy
         Dz4QDbZ5y4ZQvIEwXmo5a2ViXQfGgg5q25ZFWHuTy8Dwo3lDcwYUGkYGo1NfnatY3NlD
         bDMvHx5xBnAThtEgAtD8C3gO3eApShObm5NGd7KIao8EZFbjVF5FYjYb8ZyGGbOGy61f
         pmsg==
X-Gm-Message-State: APjAAAWRKGJPHmBO/a/Lz7O9Q7NKs9obzxQxeEJTjiXLgRrajXaTjIbw
        uxgaB2uF7sOLVL9T4P1Fy64ewTE7+3njWASpcwexdJqp
X-Google-Smtp-Source: APXvYqxaP3Wf5hF23Rnmbe7yzDLqEXV4xJ9Xd737DzvMDiXkTPBzFjA/58IxZOB0ukvS8z+tNZCztMVz7CA7J48hrXI=
X-Received: by 2002:a5d:5752:: with SMTP id q18mr3686339wrw.277.1582700052943;
 Tue, 25 Feb 2020 22:54:12 -0800 (PST)
MIME-Version: 1.0
References: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8tml1lv.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 26 Feb 2020 01:54:01 -0500
Message-ID: <CAPig+cR3H2qvCddWuWPNex=K-x0FyzKehpbOiv7W-s_4EAW1bQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #05; Tue, 25)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 5:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> * es/worktree-avoid-duplication-fix (2020-02-24) 3 commits
>  (merged to 'next' on 2020-02-25 at 74c612837a)
> + worktree: don't allow "add" validation to be fooled by suffix matching
> + worktree: add utility to find worktree by pathname
> + worktree: improve find_worktree() documentation
>
> "git worktree add" used to get confused that the director to be
> used to add a new worktreey, when given as a relative path, is
> different from an existing one. This has been corrected.

It looks like you inserted some text between the "r" and "y" of
"directory", resulting in "director" and "worktreey".

The description of the patch series could perhaps be a bit clearer.
How about this instead?

    In rare cases "git worktree add <path>" could think that <path>
    was already a registered worktree even when it wasn't and refuse
    to add the new worktree. This has been corrected.
