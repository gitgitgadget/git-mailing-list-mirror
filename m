Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43CA1FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbcLHJp6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 04:45:58 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36229 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbcLHJp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 04:45:57 -0500
Received: by mail-io0-f195.google.com with SMTP id s82so2256260ioi.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y20pE782gnz1LY9CpRA87LdyXz3LUqeFQCxGxdck3eE=;
        b=LXJpxK4074W/XgXwOWzLBP5Eh+dcodNJy0i5bUZnWwa+DV8b3kRrY9Cxp+qneGqCAV
         dyTCJVc7jXvNMhmOt/khiKB7yxMII0BXsCz7qoXznkYxJVr5m85p8IG1S/r9ySheC23T
         OcOvdU6pOzJ/4AhlC/0lhwQLkFBruviapcxJGRAPtTFZJidAgPetzqqjF9ydx6RCD17p
         xNMgLQxT6dMEkGDgxB8pOU/MNTTh3LjOXVFvrjCL3g+G7DpMvKHykdgue0oM3X2w6y0x
         3bUNCMMrRCtSGdAztOjqxXSixAjlFCLZ/JMymKtb+WxFDYuSaqCQyW/wjcvrgcwA8H9e
         vdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y20pE782gnz1LY9CpRA87LdyXz3LUqeFQCxGxdck3eE=;
        b=nNIJnEX8Mtw33FufeDxayv2YYKShofyAg7vnOQNDeaDZ5hyhANpQpeKhTWyYRuc51s
         TnqbBwTlAAiqy/NkKIrHoDVsanQ2d/ftgUOky0oIAEJeP0WH8xNeQNkUWa/iWp/IaGME
         Y6b+GlwaZssmqPY0utfsZF3A/IJYt11vq20GZmxvOI4iFFWu572YraqFsqUujNn+gMFl
         4Zdlul8dOJnpRm8azi8t7t6GLoveaIf5kJqxwFvjf7NJeswHTq36M/kNsSXZrCpr3Gox
         jXhFEDiCMl8TstCxqH0Kecn4byNJy6/vsoAzOEB06D42tsGQ4pBMIGm5VZlZWXv2NBS1
         X7hw==
X-Gm-Message-State: AKaTC01fWVAAZmNUcaE8U6dHBzTPDsLo2GoZiwGHbUw4iSSrmMiiEF2zYvJeSaTxhBeToBWwXdwtDGywVZWFIA==
X-Received: by 10.107.132.74 with SMTP id g71mr63787206iod.19.1481190356151;
 Thu, 08 Dec 2016 01:45:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 01:45:25 -0800 (PST)
In-Reply-To: <20161208014623.7588-2-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-2-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 16:45:25 +0700
Message-ID: <CACsJy8ChzxZCygrh6eNjqCkwv+Z43FmJh2T_6u6_qNE9Byq+sQ@mail.gmail.com>
Subject: Re: [PATCHv6 1/7] submodule: use absolute path for computing relative
 path connecting
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
> The current caller of connect_work_tree_and_git_dir passes
> an absolute path for the `git_dir` parameter. In the future patch
> we will also pass in relative path for `git_dir`. Extend the functionality
> of connect_work_tree_and_git_dir to take relative paths for parameters.
>
> We could work around this in the future patch by computing the absolute
> path for the git_dir in the calling site, however accepting relative
> paths for either parameter makes the API for this function much harder
> to misuse.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  submodule.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6f7d883de9..66c5ce5a24 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1227,23 +1227,25 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>  {
>         struct strbuf file_name = STRBUF_INIT;
>         struct strbuf rel_path = STRBUF_INIT;
> -       const char *real_work_tree = xstrdup(real_path(work_tree));
> +       char *real_git_dir = xstrdup(real_path(git_dir));

Is it a bad idea to rename the argument git_dir to git_dir_input, or
something, then have a new "git_dir" variable here? It certainly helps
reduce diff size, but not sure if the end result looks better or
worse.

> +       char *real_work_tree = xstrdup(real_path(work_tree));
>
>         /* Update gitfile */
>         strbuf_addf(&file_name, "%s/.git", work_tree);
>         write_file(file_name.buf, "gitdir: %s",
> -                  relative_path(git_dir, real_work_tree, &rel_path));
> +                  relative_path(real_git_dir, real_work_tree, &rel_path));
>
>         /* Update core.worktree setting */
>         strbuf_reset(&file_name);
> -       strbuf_addf(&file_name, "%s/config", git_dir);
> +       strbuf_addf(&file_name, "%s/config", real_git_dir);
>         git_config_set_in_file(file_name.buf, "core.worktree",
> -                              relative_path(real_work_tree, git_dir,
> +                              relative_path(real_work_tree, real_git_dir,
>                                              &rel_path));
>
>         strbuf_release(&file_name);
>         strbuf_release(&rel_path);
> -       free((void *)real_work_tree);
> +       free(real_work_tree);
> +       free(real_git_dir);
>  }
>
>  int parallel_submodules(void)
> --
> 2.11.0.rc2.30.gc512cbd.dirty
>



-- 
Duy
