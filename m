Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D0220248
	for <e@80x24.org>; Sun,  3 Mar 2019 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfCCJmD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 04:42:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41387 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfCCJmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 04:42:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so1794643eds.8
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 01:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1M1I7Q4pyOBVWqdwVh287zRUgR7rGYJ3e0yOaK2M+sk=;
        b=ihbeO4nsCe+/RogbgftYE3A7Lzx14XfA/iuYntXyYP1qDpscJb6QNUApqgx7aqs2Ux
         1D/OCHpKo3ETkh0IrHrMUCAbk/77ySHDrHnwDa0HawHUjADPFkvVOzczwYQiH5L7AQtt
         WfKbIilBn6nZhbzmhdzTO1YcsiFySYN6ceUu5CO7ehl7YlyhwoUrLdF+Uus0Gv9nX1nn
         GfV3SlVqWhKRRp9qshD6HUn6mNYvVQ1IY3LFLVDSf8MKyQ1M0550yVDufQBtKYiKBR/f
         eR8lFczQaq83aZlMNTWIsuEoW3k6TCi1IDMaynkTQ92U/8IiYObprLrXbhngzaEDybFZ
         DgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1M1I7Q4pyOBVWqdwVh287zRUgR7rGYJ3e0yOaK2M+sk=;
        b=bhB/w0QKCbuJThqsHPfttr3m4ZtUCu20AIquUPvcbo6acCzxJIxHl3uPtz+kdzC7BQ
         3PxpsKAb2hHB1O85XiOeHGEEmnbsGE3br0QiHHkVtk1PCIfZYPUOPwaDNiaP38xFEGdk
         NdvAuQr5fxPOIgm9j045L1eJHYAvRkp6/JTgyn/Ex1GSGad7NNJWPjLcnCoNoZUBx7qH
         mie5AOQUP7Hgj/INhKCs3Y5b98kB3bXfh5y+ErvPzpLYSeppghMzQ6xWSJdx4AYh9TFS
         /bHLkmSgsL6uRP8Q9WrPoCKAK34rdGLvFJ5HYbX4sAUwK63/y1tf7oiaG1oCXYxspHLy
         r3WA==
X-Gm-Message-State: APjAAAWPyoIGKyp/1/rhT7b5U6aghfpvVH7TEDJhTTpXGTMWzZlQfWEJ
        /yMgznygeMVIoY3psk0bvvIpKY40wA9v4TS01XHLoU9A
X-Google-Smtp-Source: APXvYqxBHvrH7ObvCqMSTsK/t1TmNYpkaZjxITq+bAytB7T8tbx8REdT71u4m+nmbWycNuLKcrjEBlFGy2t+TIx/h3s=
X-Received: by 2002:a17:906:7f88:: with SMTP id f8mr9100035ejr.108.1551606121044;
 Sun, 03 Mar 2019 01:42:01 -0800 (PST)
MIME-Version: 1.0
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a4f-f02a6509-a3ba-41b0-b768-3d8ba116f526-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016915f49a4f-f02a6509-a3ba-41b0-b768-3d8ba116f526-000000@eu-west-1.amazonses.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 10:41:49 +0100
Message-ID: <CAP8UFD1--37Z7AqiBQ2F2b3aR+pv_w1Y9CpSEYF4gHhs7KkEwg@mail.gmail.com>
Subject: Re: [PATCH RFC 06/20] cat-file: remove mark_query from expand_data
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 5:07 PM Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
>
> Get rid of mark_query field in struct expand_data.
> expand_data may be global further as we use it in ref-filter also,
> so we need to remove cat-file specific fields from it.
>
> All globals that I add through this patch will be deleted in the end,
> so treat it just as the middle step.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  builtin/cat-file.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 60f3839b06f8c..9bcb02fad1f0d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -29,6 +29,8 @@ struct batch_options {
>  };
>
>  static const char *force_path;
> +/* Will be deleted at the end of this patch */

When this patch is committed, there is no patch anymore, only a
commit. And of course the variable will be deleted in a following
commit. So instead I'd rather see something like:

/* Will be deleted in a following commit */

or maybe:

/* TODO: delete this in a following commit */
