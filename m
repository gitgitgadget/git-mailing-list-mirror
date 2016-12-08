Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D091FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 10:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbcLHKlN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 05:41:13 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34685 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbcLHKlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 05:41:12 -0500
Received: by mail-io0-f193.google.com with SMTP id r94so2514744ioe.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 02:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VGRSdJvv+2MHn9lwW/DBnzFOZan+wK6lcCHrO5zWnuU=;
        b=RwAHQQhI9IQc1z7mppugjgU7A+zJKNmT01glUJgMPjoXjAP9T7aaK3DgvlIzHeY9rB
         HZW75WFOqLJiXNq/OhEig0QMh9kfch4Ye6lwlenoEp/PJ4v7RR4T7CtspA1UP71ZEBk0
         wuwOVZEmPdXJGLgaQCKFvfVob0AsHOKemSaMJUBKyvOnsjM5RJq1h3cGJvKFmNe0qQQj
         zC/36Qn48QBUHGARrD823msHDY5YlvI1GRMyFz11/r9rE+hBd0fWzxHOxqsYV1lbdQtw
         Ha2v8vJVL+2SJEYOZyCPc4UojMHEwQ13Bb+92+o21fd1cw2vvlzTa+KEHQm/CbXCaNcH
         6S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VGRSdJvv+2MHn9lwW/DBnzFOZan+wK6lcCHrO5zWnuU=;
        b=SQ0ySCoUj3PtDkFT9LeNo3Ke/imB1slC+WmLvCbNTbWk3yzexVyJdaUdikuL112nO5
         9A2PhsCvlmYs1jTqKgbz/+kncJrjGBpVNN9+r2zume3n+M8QvlYiQo7gjnm3Ue52KEDi
         PyEd3TEHcY3KPQ96A1zR9/kM5i1PJgm2EICcE0dez7ZNq0c2hpEC0y/HsdEMp3NPwBMT
         Bq9GjnaHcLT6knqWFO750TYTOGhqsw+UOYMlXH1SpoLN+s55qiMLMSDbkbnB1IjyIZiw
         CsU1+fM30CS2MKAHyt0TFAxJIalZNL6mrTgSlOIXTQgcdsG9M2vlIcmJipv8q2IgQ95k
         7Xfw==
X-Gm-Message-State: AKaTC00VWXMK10sn8haQUpMhB2Szl7o7RXA5gIjjJyxrbgdZWFkMfTw+XsOUswFTp3W08ZZ7QLn8WliQIsJyNQ==
X-Received: by 10.107.44.137 with SMTP id s131mr59488104ios.212.1481193671456;
 Thu, 08 Dec 2016 02:41:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 02:40:40 -0800 (PST)
In-Reply-To: <20161208014623.7588-6-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-6-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 17:40:40 +0700
Message-ID: <CACsJy8ANNz6FsJ4_5MOhj2Qqd+wHHu5UpVOAobqEiHU2KM26eg@mail.gmail.com>
Subject: Re: [PATCHv6 5/7] worktree: add function to check if worktrees are in use
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
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  worktree.c | 24 ++++++++++++++++++++++++
>  worktree.h |  7 +++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index 75db689672..2559f33846 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -406,3 +406,27 @@ const struct worktree *find_shared_symref(const char *symref,
>
>         return existing;
>  }
> +
> +static int uses_worktree_internal(struct worktree **worktrees)
> +{
> +       int i;
> +       for (i = 0; worktrees[i]; i++)
> +               ; /* nothing */
> +
> +       free_worktrees(worktrees);


Ayy.. caller allocates, callee frees. This might become a new
maintenance nightmare. Elsewhere I believe we (Junio and me) discussed
the possibility of returning the number of worktrees from
get_worktrees() too. get_worktrees() would take an "int *", if not
NULL, we return the number of worktrees in that pointer.

It's probably a better approach, although I'm afraid it'll add a bit
more work on you.

Alternatively, we could add a new flag to get_worktrees() to tell it
to return all worktrees if there is a least one linked worktree, or
return NULL if there's only main worktree. I'm not sure if this is
clever or very stupid.

> +       return i > 1;
> +}
> +
> +int uses_worktrees(void)

"has" may be a better verb than "uses". maybe "has_linked_worktrees"
since we always have and use the main worktree.

> +{
> +       return uses_worktree_internal(get_worktrees(0));
> +}
> +
> +int submodule_uses_worktrees(const char *path)
> +{
> +       struct worktree **worktrees = get_submodule_worktrees(path, 0);
> +       if (!worktrees)
> +               return 0;
> +
> +       return uses_worktree_internal(worktrees);
> +}
> diff --git a/worktree.h b/worktree.h
> index 157fbc4a66..76027b1fd2 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -33,6 +33,13 @@ extern struct worktree **get_worktrees(unsigned flags);
>  extern struct worktree **get_submodule_worktrees(const char *path,
>                                                  unsigned flags);
>
> +/*
> + * Returns 1 if more than one worktree exists.
> + * Returns 0 if only the main worktree exists.
> + */
> +extern int uses_worktrees(void);
> +extern int submodule_uses_worktrees(const char *path);
> +
>  /*
>   * Return git dir of the worktree. Note that the path may be relative.
>   * If wt is NULL, git dir of current worktree is returned.
> --
> 2.11.0.rc2.30.gc512cbd.dirty
>



-- 
Duy
