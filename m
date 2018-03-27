Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42781F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeC0XUc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:20:32 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45680 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeC0XU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:20:27 -0400
Received: by mail-yb0-f193.google.com with SMTP id k199-v6so181573ybk.12
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ksU8ye8AXKBpAPdgYUVoFZdiiQ74iOoNoYxjngo4f1s=;
        b=jgxJZLLd/fdGEWl+f4vA/1iGtMHz06wHYlrhDe6tAQjm3UMfRwfrbxZHPZiKZXWHH0
         zqpum/hFo7E8wNEHcwDLRlOw48vqLsGMFflv9CKsGgn2GNwjLMc0M9IWfq5lGeCrncCa
         +nWVm5QLlVKitEZcK1xwpN6oqNhvoB56/89orlVe6aHf3rtURbq0JHH22SWso9lbyeac
         joOXWE3VSloVBlW6bH4S6BDbl+TcjgNOiAgU1E9yuUqUGGSMwOj00Qc3OgQW+d0QJCyz
         /GUNjRB3x2wJwhW7V9qs+xWjC4bJrKHinMwa/2D5TvjSk0eE5YOBk5GtTt+R70KyJmNA
         OpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ksU8ye8AXKBpAPdgYUVoFZdiiQ74iOoNoYxjngo4f1s=;
        b=FS52KIT4/CTfmvNhW7Fcur8gEDxclJJzQgnUh/9SOdgVP/9+EmTRB1H7Sg2ZT2QxxS
         ORxhrVb0dcnd74kGW5z4Rifa9+pkeCrwQo1dBSX7Qd9VTU6rmNSb8rc6aMLmxzaBpZkV
         DkDrQ0CY3CB8ldMSuRp7SNNDG+7+xdKphFMdhs6JnW31p4g08gycRfT4LwF1A66e0UDV
         TMW2wySX+zK3BfiDhLAWUPj9gqlmDwttYoeD+ZT59tizwZ7bldzUqse2CYHKv6LAUyHn
         p1erKdUpbp18C/cjOxKj+hN9ATWs+2hBHCGBKR3uZJI2F1qKWIW/Xu+f6LTWO8qpyPsq
         IC8A==
X-Gm-Message-State: AElRT7Gup39iIyNRqL5a7qzhQUYBcjKTYr2iF6e9glNK9iL2K5kDXAPN
        YB0shpvQzpD+lGmqE7gt+VvTWF9jjqqCedEFXVYQXg==
X-Google-Smtp-Source: AIpwx4/FDViHwY0y5BYkG8+BzzOYyR35zOsjTvwx6K1Xt2ecKzyVf/Kdbz4Ufaz95QSE8uPN2B2XtRzh+cPv5Mh5fJY=
X-Received: by 2002:a25:e80d:: with SMTP id k13-v6mr879627ybd.334.1522192826036;
 Tue, 27 Mar 2018 16:20:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 16:20:25
 -0700 (PDT)
In-Reply-To: <20180327225850.166523-1-jonathantanmy@google.com>
References: <20180327213918.77851-3-sbeller@google.com> <20180327225850.166523-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 16:20:25 -0700
Message-ID: <CAGZ79kY-E5FZRJAg6QG0DX1TzWXgo9LqJ-b7JojpkD6_BdF-wQ@mail.gmail.com>
Subject: Re: [PATCH] grep: remove "repo" arg from non-supporting funcs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>, seanwbehan@riseup.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 3:58 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> As part of commit f9ee2fcdfa ("grep: recurse in-process using 'struct
> repository'", 2017-08-02), many functions in builtin/grep.c were
> converted to also take "struct repository *" arguments. Among them were
> grep_object() and grep_objects().
>
> However, at least grep_objects() was converted incompletely - it calls
> gitmodules_config_oid(), which references the_repository.
>
> But it turns out that the conversion was extraneous anyway - there has
> been no user-visible effect - because grep_objects() is never invoked
> except with the_repository.
>
> Revert the changes to grep_objects() and grep_object() (which conversion
> is also extraneous) to show that both these functions do not support
> repositories other than the_repository.

I'd rather convert gitmodules_config_oid instead of reverting the other
functions into a world without an arbitrary repository object.

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Patch 1/5 of your series is obviously correct.
>
> I investigated the change to grep_objects() in patch 2/5, and here is a
> patch summarizing my findings. Consider including this patch before 2/5
> (or before 1/5). You'll probably need to write
> "submodule_free(the_repository);" instead of what you have currently,
> but other than that, I don't think this affects your patch set much.

Thanks for looking at the patches!
I'd think this patch is orthogonal to the series, as this is about the effort
of converting parts of git-grep whereas this series is fixing a bug (by
converting parts of the submodule config machinery))?

Thanks,
Stefan
