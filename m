Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D248E1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 10:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfFEKIc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 06:08:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35017 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfFEKIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 06:08:32 -0400
Received: by mail-it1-f194.google.com with SMTP id n189so2642151itd.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0JTMgmNs3htx53hibRqoUova+ThI/qrSNaDw1nA9r4=;
        b=MynDQ2aBkcwTaFkBApPEOwNkrjaFS0TzOv0ERYI82F498dZhPPzJTL5feDShQlK5SV
         boZ3dhfOsHl2aZ9525Nv6LwoGzHUSqzM4VxvlacbRM+aQaAQw4tgNnZW3nSLEh4GRNDr
         nMjCwS0upoEiz8eyybG75uJlu89rtVQ7+welDa3VlV5D8kciMYBUK/Xo+4sqCG4ewIAd
         NKJh3maoumMRvclpjXHu2sNOV0h6Yu4QmUJbCXCZepDUBvmPs5uRHhcIr3v6xfkJsbq/
         Lf1cislkB0oLk+SYitPltQjp8CbFV0PJr02eoA183ubNvBMWiQk7Cf4l+OAEkvmWENVj
         YcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0JTMgmNs3htx53hibRqoUova+ThI/qrSNaDw1nA9r4=;
        b=e3P8o8+at/uIANAt6KL71p/fEQMH8rqP/bdB6PfwqkGkUwKAt6zGcizN60v2ikcm0p
         xz/z2zZfgl4fWHgJ/nD4DTjnyvNjxvsnO88IrJw0nISauEu43VRo5e+A/UkTIzoHFyZx
         P0v6Ntl4q0TowOP5oOa+DPgarazP9t0/xzKGcU8WfvzKFc6kfwEcj81qoQOmoeQrLbBW
         QuEr3smdR4vjddbPMXT/TghgR4GcOAe/Ayx4nUd8+CfsGIo35XFl22y71GoptwLdmFRc
         OpPPS8PhWh8HSIqVda2QeK1yGwMqD6nOBxKCgSFpcsXQAtJq2KNdpSRI4NHF3InC5MRl
         8lMA==
X-Gm-Message-State: APjAAAWHFlk2lZ//e2yoFjT2k2oxXKg1OqLd90ojNC4CZQ7JLDYjtnEF
        Tlt2VTNTVo5CTiOLVZ8gS44Tcd+6+hHmUob8Zes5KQ==
X-Google-Smtp-Source: APXvYqzKyoQtbr9wcVbiTvfq6C/AWWTHdYJkV7+TRybsC6o8M/laduj6ZbigNWZ+yYeaCvKX84PIreo4QbWv8N0VgQk=
X-Received: by 2002:a24:2448:: with SMTP id f69mr18550884ita.157.1559729311570;
 Wed, 05 Jun 2019 03:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
 <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
In-Reply-To: <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Jun 2019 17:08:04 +0700
Message-ID: <CACsJy8BaYhcnj_nofxmDB3txBCgSe0aDeR+LYPNqkHYg4OroHg@mail.gmail.com>
Subject: Re: [PATCH v2] config: learn the "onbranch:" includeIf condition
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 1, 2019 at 2:34 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> Currently, if a user wishes to have individual settings per branch, they
> are required to manually keep track of the settings in their head and
> manually set the options on the command-line or change the config at
> each branch.
>
> Teach config the "onbranch:" includeIf condition so that it can
> conditionally include configuration files if the branch that is checked
> out in the current worktree matches the pattern given.

Just wondering, anybody wants special settings on detached head (and
if so, what syntax should it be)?

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7e2a6f61f5..93aa4323c6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -144,6 +144,13 @@ refer to linkgit:gitignore[5] for details. For convenience:
>         This is the same as `gitdir` except that matching is done
>         case-insensitively (e.g. on case-insensitive file sytems)
>
> +`onbranch`::
> +       The data that follows the keyword `onbranch:` is taken to be a pattern
> +       with standard globbing wildcards and two additional ones, `**/` and
> +       `/**`, that can match multiple path components. If we are in a worktree
> +       where the name of the branch that is currently checked out matches the
> +       pattern, the include condition is met.

Supporting transforming "foo/" to "foo/**" would be nice (gitdir and
gitdir/i do this). Useful when you organize your branches into
"subdirs".

> @@ -264,6 +265,24 @@ static int include_by_gitdir(const struct config_options *opts,
>         return ret;
>  }
>
> +static int include_by_branch(const char *cond, size_t cond_len)
> +{
> +       int flags;
> +       int ret;
> +       struct strbuf pattern = STRBUF_INIT;
> +       const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
> +       const char *shortname;
> +
> +       if (!refname || !(flags & REF_ISSYMREF) ||
> +                       !skip_prefix(refname, "refs/heads/", &shortname))

We probably don't even need to check more than !refname. Symbolic refs
from HEAD must be refs/heads/* or it's an error (fsck will complain).
But it's probably also ok to stay strict.

> +               return 0;
> +
> +       strbuf_add(&pattern, cond, cond_len);
> +       ret = !wildmatch(pattern.buf, shortname, WM_PATHNAME);
> +       strbuf_release(&pattern);
> +       return ret;
> +}
-- 
Duy
