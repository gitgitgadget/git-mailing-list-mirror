Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4DC433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9155C613C5
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhEBGxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 02:53:49 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:38700 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBGxt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 02:53:49 -0400
Received: by mail-ej1-f47.google.com with SMTP id b25so3234308eju.5
        for <git@vger.kernel.org>; Sat, 01 May 2021 23:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4ZIy4jk8G3Vni+vaTJwQQG6uQGqO6AafKx6iBs3g8g=;
        b=FcBadS1wMGzc95ly2tNki56Vvz7F/DcfLTtGViBTwQinLXmupQCGRKwlY/YvDMSEAM
         pJ7dEXJj5uXM0nKAW2RDjDnOh1YRbacC2armp0/L3xv3HvE5tuUZheA434JvNePWikG7
         N+dpgf2S8dJcylOyvm40kKOAjH7LgAONmNxXYjM6iby0+qsJvJjgLjck8rUv8+UaSFzX
         /S1Lt/MKcMr9SEYAIDIpqgYwb2gou1e71jvKk9DvCqcVuhV4lX3k1PESMOBwhHgMC+UK
         /JqQ2o1sbAMe8GeLo+ohlRzrbhVMwM26bda7oMc65GLdSNa28QbjiCnnK6nThzcuGjz4
         lKJg==
X-Gm-Message-State: AOAM530y4VZRqJaepYJIS275AvQU5eEC6TFWiwpUYVIOtsIBcm2m09Ty
        94P3VcMjL/9K8pmHj9XaYMOgVazW59Vo7EW4EcIXlrQiQtM=
X-Google-Smtp-Source: ABdhPJxkCWS+WDR+IjDA9rA5ol4T9zNz4YZnnvnaNr88afxLsLfI6npQfThtva+sQzLaO2D/hUw91J0y9qfUFTbOjA4=
X-Received: by 2002:a17:906:edcf:: with SMTP id sb15mr11589592ejb.202.1619938376394;
 Sat, 01 May 2021 23:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <gitgitgadget/git/pull/934@github.com> <gitgitgadget/git/pull/934/c830744540@github.com>
 <CACZqfqA8u8cRM5xSdnArUW7tGOJX9dVO41FsmQU4-d2NyiNCiA@mail.gmail.com>
In-Reply-To: <CACZqfqA8u8cRM5xSdnArUW7tGOJX9dVO41FsmQU4-d2NyiNCiA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 May 2021 02:52:45 -0400
Message-ID: <CAPig+cS+b-SV6SUkhWMui7_vTEeJYumDDDM10DdrkNqpgm=z_A@mail.gmail.com>
Subject: Re: [gitgitgadget/git] git-merge: rewrite already up to date message (#934)
To:     Josh Soref <jsoref@gmail.com>
Cc:     "gitgitgadget/git" 
        <reply+AAQFMLC42KHLQTLKSC5H3XV6TILQ3EVBNHHDGQXBRY@reply.github.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 2, 2021 at 1:49 AM Josh Soref <jsoref@gmail.com> wrote:
> Eric Sunshine wrote:
> > diff --git a/notes-merge.c b/notes-merge.c
> > @@ -628,7 +628,7 @@ int notes_merge(struct notes_merge_options *o,
> >   if (o->verbosity >= 2)
> > - printf("Already up to date!\n");
> > + printf_ln("Already up to date.");
>
> Should this have `_(...)` decorations?

Yes, indeed. I'll fix it in a re-roll and mention it in the commit message.
