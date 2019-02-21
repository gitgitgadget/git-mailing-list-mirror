Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CB81F453
	for <e@80x24.org>; Thu, 21 Feb 2019 10:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfBUKvG (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 05:51:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40299 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUKvG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 05:51:06 -0500
Received: by mail-it1-f193.google.com with SMTP id i2so22085938ite.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 02:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EWguzgz4l+yIUBrRtYoXy6+tubL33wI2+URcVlBFNyc=;
        b=eyDIm0HrI+6wx4gMWI1UpCCH16xNCXrzx1AYbWu/sUgeLVa152sQ802ZADKo8Vk9oe
         QuukX2/sxtm5fGo3PnPEIvaAvil2VyIJ8fYFJoi984fTDcKre4h71uo7uz1D9qHfSj0a
         ISD5oR6MN9uws1vOtsoT38EGEq1W6zva+3G7a0hpSibsx6Ez/fm/dzRQwh2KQVWSDDfE
         kdIoRDAfhxgGSd1cHhMn4MHqXDAyhGOIosaGUGss/BNB5RqtSRDsYObdo9jh4jxxsMZb
         GXoUvgyEaGCVjW7RcldQ9pLTSsU6wE9X992Zcu54Yv6b/KL9Ws0cH8Wsxqep+v1/ZnMN
         OwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EWguzgz4l+yIUBrRtYoXy6+tubL33wI2+URcVlBFNyc=;
        b=incHTDZDwd76Qw0mgVsPcVQcggXDi5f6QIhYulvXtmllvtGYZcW/F9+wfyf/ryJpVi
         1HAlBzUZxiELkagolAC/6YrKMDMmRVI6f7VO8dT5GVhXNzQlB3y0LbuBJ2JKhnnX6anN
         KtYJUam/CSUh2o6nrIRcypCvFj+FjCs0/+l2W/ACls4EC+Xhdab4Yh0FWgk3kV/rZZy4
         7m8EySzrJiiJWR4eunxWRPC0ll53U4j0DSP5kLgXhxg8Fvc78oV45cj/pUAfeeIARqUy
         8dqWmXL2i1AXaMgcXiF7uQccHkPxHte/kQecKFCVFREm/ZMML4gCsi5QV0lY9w9Nsv8S
         2m6Q==
X-Gm-Message-State: AHQUAuaUhurXWicFZv7I5c4rMa+z5t1LiPy9UCBSDtAxYHMn71IUuJHG
        LGGgiBt+tLjQax0hE/sv5n1FcdJSTj8KBTM3ohs=
X-Google-Smtp-Source: AHgI3IbXQOH79GEYdIsBzvO79v2F0hssMLG+k8HePIr1oMjuW1/PV8fuRV4ozZ1oqjm5QkLjkrqyWpM/9eUJLqNZeQU=
X-Received: by 2002:a02:9c21:: with SMTP id q30mr20086205jak.30.1550746264985;
 Thu, 21 Feb 2019 02:51:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
In-Reply-To: <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Feb 2019 17:50:38 +0700
Message-ID: <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> When adding wotktrees git can die in get_common_dir_noenv while
> examining existing worktrees because the commondir file does not exist.
> Rather than testing if the file exists before reading it handle ENOENT.

I don't think we could go around fixing every access to incomplete
worktrees like this. If this is because of racy 'worktree add', then
perhaps a better solution is make it absolutely clear it's not ready
for anybody to access.

For example, we can suffix the worktree directory name with ".lock"
and make sure get_worktrees() ignores entries ending with ".lock".
That should protect other commands while 'worktree add' is still
running. Only when the worktree is complete that 'worktree add' should
rename the directory to lose ".lock" and run external commands like
git-checkout to populate the worktree.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2:
> - do not test file existence first, just read it and handle ENOENT.
> - handle zero size file correctly
> ---
>  setup.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index ca9e8a949ed8..dd865f280d34 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -270,12 +270,20 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>  {
>         struct strbuf data = STRBUF_INIT;
>         struct strbuf path = STRBUF_INIT;
> -       int ret = 0;
> +       int ret;
>
>         strbuf_addf(&path, "%s/commondir", gitdir);
> -       if (file_exists(path.buf)) {
> -               if (strbuf_read_file(&data, path.buf, 0) <= 0)
> +       ret = strbuf_read_file(&data, path.buf, 0);
> +       if (ret <= 0) {
> +               /*
> +                * if file is missing or zero size (just being written)
> +                * assume default, bail otherwise
> +                */
> +               if (ret && errno != ENOENT)
>                         die_errno(_("failed to read %s"), path.buf);
> +               strbuf_addstr(sb, gitdir);
> +               ret = 0;
> +       } else {
>                 while (data.len && (data.buf[data.len - 1] == '\n' ||
>                                     data.buf[data.len - 1] == '\r'))
>                         data.len--;
> @@ -286,8 +294,6 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>                 strbuf_addbuf(&path, &data);
>                 strbuf_add_real_path(sb, path.buf);
>                 ret = 1;
> -       } else {
> -               strbuf_addstr(sb, gitdir);
>         }
>
>         strbuf_release(&data);
> --
> 2.20.1
>


-- 
Duy
