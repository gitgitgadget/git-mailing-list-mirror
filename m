Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEE420259
	for <e@80x24.org>; Thu,  8 Dec 2016 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbcLHKKc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 05:10:32 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:33035 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbcLHKK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 05:10:29 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so2397027ioi.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9dOgOAUYguWZ1IJKIfV44tBWB80mhLc+Qh0CvrAMLfA=;
        b=EvGYSgWAmru5OS7A1AigjYU1P9I/vd9KFq+Kn72u+mgwIf/ch288nVwfUGho8+DKBl
         5BOxiUTNKRLDnx2zfvFeNysVn0KpmdaXAA9f5Vky7KAFu8FzeNIPQS20jtarQKbdBUXX
         WZG7L6dIevfzphVZVutdBcx/CVAcoPqZNGN7eBkCdipvwiMZIu9jklpmPpshu1nUFHON
         qrsTsbYbIeJ08aIipCZ16LqQQM3tpnw2EGR/sTog2WIOYZr2igV3GavxPl1oEbJXv3E1
         Q7m6p5d7zxZBonToWWXgcOlE/ieyKvhrPqBCNNovBDAg759pJp+w1VFh0dUsNP3+L1K6
         4xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9dOgOAUYguWZ1IJKIfV44tBWB80mhLc+Qh0CvrAMLfA=;
        b=jcgFygT2pvpcd5zJUkcoP/jHEXeth8Xe6FXxoYsjLyZNzrBgYhq27uyfS69gah8hmF
         NSBlPDciCScPUalK55kUy6qqftX7kVz4PEdST/JrGViiTwNBo0TTruz/PzcBK9T9TcTZ
         Rbwg3mSYdKSiQlLYBdRZqiMkJaShKd357Mdz4mrpjp1lNkewEAEwnJpf9DPGIv3l9doF
         KjCCRP3XzLWXPRde0JOR5hj/qmVp/PGm8R3kX1yEb9E+f9r3KEoxxY4NxXkFZW+y7yGE
         Q9FwxHxq4mzN/aXjmMnc7h1phigP6OmgKfQS7IMBI7SE7jQ3mSqbTuPa5L3r7/Tuu+Bj
         xHZQ==
X-Gm-Message-State: AKaTC00k5Y0WGmesdFt4yVXuTLc22mg/trMZdNg/vw/IYMQNG2e6hhsqDgHLB+hpg/umY5NsBP9mo9rUDZ5aew==
X-Received: by 10.107.132.74 with SMTP id g71mr63856777iod.19.1481191828862;
 Thu, 08 Dec 2016 02:10:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 02:09:58 -0800 (PST)
In-Reply-To: <20161208014623.7588-5-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-5-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 17:09:58 +0700
Message-ID: <CACsJy8Bs78ywGq5p6yAFGi1KACAXFEeroyQSJye5-RL5gqOS+Q@mail.gmail.com>
Subject: Re: [PATCHv6 4/7] worktree: get worktrees from submodules
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
>
>         worktree = xcalloc(1, sizeof(*worktree));
>         worktree->path = strbuf_detach(&worktree_path, NULL);
> @@ -101,7 +101,8 @@ static struct worktree *get_main_worktree(void)

All the good stuff is outside context lines again.. Somewhere between
here we call add_head_info() which calls resolve_ref_unsafe(), which
always uses data from current repo, not the submodule we want it to
look at.

> @@ -167,7 +168,8 @@ static int compare_worktree(const void *a_, const void *b_)
>         return fspathcmp((*a)->path, (*b)->path);

fspathcmp() reads core.ignorecase from current repo. I guess it's
insane to have this key different between repos on the same machine,
so it should be ok. But I want to point this out just in case I'm
missing something.

> @@ -188,7 +190,7 @@ struct worktree **get_worktrees(unsigned flags)
>                         if (is_dot_or_dotdot(d->d_name))
>                                 continue;
>
> -                       if ((linked = get_linked_worktree(d->d_name))) {
> +                       if ((linked = get_linked_worktree(git_common_dir, d->d_name))) {
>                                 ALLOC_GROW(list, counter + 1, alloc);
>                                 list[counter++] = linked;
>                         }
> @@ -209,6 +211,30 @@ struct worktree **get_worktrees(unsigned flags)
>         return list;

Right before this line is mark_current_worktree(), which in turn calls
get_git_dir() and not suitable for peeking into another repository the
way submodule code does. get_worktree_git_dir() called within that
function shares the same problem.

>  }
>
> +struct worktree **get_worktrees(unsigned flags)
> +{
> +       return get_worktrees_internal(get_git_common_dir(), flags);
> +}
> +
> +struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
> +{
> +       char *submodule_gitdir;
> +       struct strbuf sb = STRBUF_INIT;
> +       struct worktree **ret;
> +
> +       submodule_gitdir = git_pathdup_submodule(path, "%s", "");
> +       if (!submodule_gitdir)
> +               return NULL;
> +
> +       /* the env would be set for the superproject */
> +       get_common_dir_noenv(&sb, submodule_gitdir);

Technically we need to read submodule_gitdir/.config and see if we can
understand core.repositoryformatversion, or find any unrecognized
extensions. But the problem is not specific to this code. And fixing
it is no small task. But perhaps we could call a dummy
validate_submodule_gitdir() here? Then when we implement that function
for real, we don't have to search the entire code base to see where to
put it.

Kinda off-topic though. Feel free to ignore the above comment.

> +       ret = get_worktrees_internal(sb.buf, flags);
> +
> +       strbuf_release(&sb);
> +       free(submodule_gitdir);
> +       return ret;
> +}
-- 
Duy
