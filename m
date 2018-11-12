Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0411F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeKMCCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:02:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52541 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:02:17 -0500
Received: by mail-it1-f195.google.com with SMTP id t190-v6so13360708itb.2
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 08:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FibR5ciKwTMWUrfRsT0oIKBiN4SozREmNYc7/9yCtJo=;
        b=tmiuytaXAagQ9dJLDsV9ZMls1tT9bBwrfJtoCcDOPT7T77NiSLhorw/YgRs3ejTuWN
         Sp6mIXLojS8gVYFccBKz8xRgSxBr5IhZW0sIhEh7+HTMu949mlN3/p9bUlmWOrVTUS3K
         0Y20XcYTV5KFEkCAmCQIoVGoGPaE/idFIZxlB5D1HSVB5hnBcJZNo+ka3uKZIOWqQtT8
         yfZ7APWRaGClNfKJy7jwRVxGnxhYKVJZQuSNIsLI0IkLDimfvrk7FBxpQ3hksdwRKzNB
         5jwyOZ0/82MtX2EaluwZ+t99ilN2LeUndMDskGf49nL4Q2VasIB8RBj11G2W/mW+vfTg
         mPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FibR5ciKwTMWUrfRsT0oIKBiN4SozREmNYc7/9yCtJo=;
        b=by+wYNtqhAKBx+9G7jyH6jPV8qcezm3fkgvIrnsOUpHfKw/QueS8EEe4bA87F0GMEO
         uG4Zl6E83aLWnXoTSJmIwb3kWhIcDMahBGJk6Mfe3qxHMgxA+AF/ng03nxcbrocxG03y
         lc6a/xuDEOroNUswHgic1lW04HQDO6kZ9DjXJUC5jP4iw/aDRsVZvXxAjy0AIEglfQdc
         GnaRIW5P8tI2092Ir2wNF7EaDyqmFMcSktERjYKURAJ7A6UQiNV380vDrRksVshRIXlW
         T1pu9+efRZATrAWAz/X/qMwt+NvCbLj+ritLDSOlrOqAGywhBuYq36av0xZFeM4acBUE
         VmBA==
X-Gm-Message-State: AGRZ1gLUqygUudlgrHQgHDB9WpQ4QfSh4kzPQWoT4+7qLAuunYCiTiMc
        vmbHScjO/vMqudlu2p/KSOxEUbMvVU+yDJhgErM=
X-Google-Smtp-Source: AJdET5cTVRdaHakDbVt+bMvgq7grz4AEnVKtRvHsXk3JZ5UP2ip5Zl24g5jHbLTXgwb3FvH1wR3HjzK1VOGXLuqWSwM=
X-Received: by 2002:a24:f589:: with SMTP id k131mr254022ith.10.1542038903513;
 Mon, 12 Nov 2018 08:08:23 -0800 (PST)
MIME-Version: 1.0
References: <875zxa6xzp.fsf@evledraar.gmail.com> <20181111095254.30473-1-pclouds@gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
 <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv> <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 17:07:56 +0100
Message-ID: <CACsJy8C3rOFv0kQeJrWufQQzbnfU4mSxJtphEYBGMmrroFFN-A@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     git@matthieu-moy.fr
Cc:     per.lundberg@hibox.tv,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 10:09 AM Matthieu Moy <git@matthieu-moy.fr> wrote:
> May I remind an idea I sugested in an old thread: add an intermediate level
> where ignored files to be overwritten are renamed (eg. foo -> foo~ like Emacs'
> backup files):
>
> https://public-inbox.org/git/vpqd3t9656k.fsf@bauges.imag.fr/
>
> One advantage of the "rename" behavior is that it's safer that the current,
> but still not very disturbing for people who like the current behavior. This
> makes it a good candidate for a default behavior.

I have something else in the bag that does something like this. The
idea is that we go ahead and do destructive things but we let the user
undo.

Some more background in [1] but basically we hash "every" change and
store in the object database (in this case we store "foo" content
before overwriting it). We maintain a list of these hashes so that
undo is possible, but of course we don't keep infinite change history,
eventually too old changes will be pruned. [1] talks about index
changes (e.g. "git add -p") but it could apply to worktree changes as
well (and I'm also eyeing $GIT_DIR/config changes).

The upside: a similar undo mechanism that works for more than just
this case and it allows undoing multiple times while foo~ only allow
once. The downside: hashing is definitely heavier than renaming foo to
foo~. So this will feature be opt-in in most cases. But for
"dangerous" overwrite like this case, I think we value the file
content more and make it opt-out.

[1] https://public-inbox.org/git/CACsJy8A3QCYY6QeJQYkbCKYh=7Q7pj=rer_OQHLGoAMqTNomNA@mail.gmail.com/
-- 
Duy
