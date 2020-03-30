Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5003C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B130A206F6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 18:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC3SPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:15:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36300 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgC3SPq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 14:15:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so23134389wme.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2020 11:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZdtuBRdGr47+qpZIPxZlu21Y0Otzp+9F7XwfsUfnmUY=;
        b=R8fob/CLSs3mjjeFVvBRDYLdlHPpA1ujPrCukX7qOvoOrdbO07JtcP/1MbZTVHanhV
         1A7/XT6hdfcnwAQ266ZbF1ILikWiTFosoXoggLOlrf6YkrygDnNOaESxQqvmWjcHP44r
         1pluEKGKKOQALFJ+ThXjb/DMlgYBA1wPz56Rc7bTGm8soLkNmDNYzM8moR4wqDVbzcB+
         gSo2EAahkJAvhIe3j+RFNfD6j2IYoG9b54txhczvbWfQIIw+BfQjnA9UQPXQ6KGf6RGy
         YgUm9FcuqWf3GMrNBz8SLxZUDgBahr/2bb2qAbl3WoxF3gEbdLl2tC0qL7iCHAsFeulE
         /NIA==
X-Gm-Message-State: ANhLgQ3ov4vSuKoYrHi1bjkGSVry369/fuWQiJuRRzWqWTON+ARwR3Y4
        012BDIN6QSLjq5NlnUZj5FnXJ8l/p1YuXO44wVo=
X-Google-Smtp-Source: ADFU+vsNiinQlDe8mWwlPsH1eB6CjD1+85oxt6xxVjOZeLyEx4CcVWoX1RypI19FMmx+M08qaPT/G1xZaoya+Xx1VDg=
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr515983wme.107.1585592144828;
 Mon, 30 Mar 2020 11:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
 <20200330124236.6716-1-alban.gruin@gmail.com> <20200330124236.6716-2-alban.gruin@gmail.com>
In-Reply-To: <20200330124236.6716-2-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Mar 2020 14:15:33 -0400
Message-ID: <CAPig+cQDCqUh9zpUHreS1GqG7hFgV9ChzZj0mtnMbcmVeY0ofQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] sequencer: don't abbreviate a command if it
 doesn't have a short form
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, jan.steffens@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 30, 2020 at 8:43 AM Alban Gruin <alban.gruin@gmail.com> wrote:
> When the sequencer is requested to abbreviate commands, it will replace
> those that does not have a short form (eg. `noop') by a comment mark.

s/does/do/

> `noop' serves no purpose, except when fast-forwarding (ie. by running
> `git rebase').  Removing it will break this command when
> `rebase.abbreviateCommands' is set to true.
>
> This changes todo_list_to_strbuf() to check if a command has an actual
> short form, and to ignore it if not.

Perhaps: s/This changes/Change/

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
