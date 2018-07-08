Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B623B1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932383AbeGHUyR (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 16:54:17 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46104 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932162AbeGHUyR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 16:54:17 -0400
Received: by mail-yb0-f193.google.com with SMTP id s14-v6so6449046ybp.13
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 13:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVmElrL7PmRDLAlxoMWpwt0AM7HqE7mpc4AZMZUkX+E=;
        b=KU8Q30d88siExwVfzwrVSywARSU6/qZXs5c/cKvU8mhgtrAzoevmhX5z/pPGzM48uc
         Mb0ZyEyyRkI4PL2hUqKfGTtq2sDDrEajOUdEiSu+l2gULsP56krbYr3x15qRp5dFd/FH
         /9tnHccNGCvCs0ao38LlNyMrvFCD7wLs9v5P1F8uXjvzaWwD5YWXkHlsU+UuupTOt1pu
         EFPlVt/6F9DoqfUE2XYCz4ywaC47enEEIL2z0+aYVwZmrOMzKn0javZSntpbaMEmcCya
         5OKgCTY1pFl9csZ0KK8TWbR3dAYZJPpyZEJdzH+nWurNmpe9oZ7WjKOI8Oz0ps0holtf
         tUhA==
X-Gm-Message-State: APt69E3eAWTQu3M5f8M+No/2jzLLbfH4KtAcCohfeh4MgP8h8kA0+9rH
        xkdNHYjbtMqA2gVQeIwTUbnRb+YB3JAqhe7e/q0=
X-Google-Smtp-Source: AAOMgpf0sjP/Ieb1o6cYpP1iTdFMhmjsD1wbmbhSgE0V4atYa0wnQB748l9zwWOitGJgJuVGuTTYPtODbf4GfRJXjgM=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr9470483ybd.497.1531083256420;
 Sun, 08 Jul 2018 13:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180708144342.11922-1-dev+git@drbeat.li> <20180708144342.11922-5-dev+git@drbeat.li>
In-Reply-To: <20180708144342.11922-5-dev+git@drbeat.li>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Jul 2018 16:54:04 -0400
Message-ID: <CAPig+cSGj6Pt4OmRAQauZCiVG3PnjWeXm20RtYGbsjdZ5Tk4gg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] sequencer.c: avoid empty statements at top level
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 10:44 AM Beat Bolli <dev+git@drbeat.li> wrote:
> The marco GIT_PATH_FUNC expands to a complete statement including the
> semicolon. Remove two extra trailing semicolons.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

While you're at it, perhaps it would be a good idea to fix the example
in path.h which teaches the "wrong" way:

/*
 * You can define a static memoized git path like:
 *
 *    static GIT_PATH_FUNC(git_path_foo, "FOO");
 *
 * or use one of the global ones below.
 */
