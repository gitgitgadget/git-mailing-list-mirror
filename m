Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC3DC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhK3AWm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 29 Nov 2021 19:22:42 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:46044 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhK3AWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:22:42 -0500
Received: by mail-pf1-f181.google.com with SMTP id x131so18666149pfc.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 16:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XtYhYvu0yLLXu/5DWQrkpTIJY7UnZymogIT5FSDf62o=;
        b=MZfhrE8Wv+AdPGyVKhHJRt8eB1Hqu3q1LM4mzb4d0nV+3aROXdhZq5mJJLsd+MHPO5
         76pRIMCh+g326TIjzA9VL4F2TVOPNOhyNA058MeguZ/JG+kbDu8Js9ibM+m3Hbhr+l0l
         jNI/vEMrKgDCzpwFiPxfDOk4crkloRMFuyowOzp0oK4l5ybqH1Q/pUeCK/zJL97B2NUr
         zJRKHjhLDsNGeim0oWomb0FjhabBhwYU0DmeDawMN6RIf/LvlAJecxW8J6QdvLrNU4KP
         qcpMBZsTPdsoLiksB+3UwxcRZ83gRl6AnwXSKfnXbtQWsPVtXWqdvuGMbEoc2L4bWll5
         CeQg==
X-Gm-Message-State: AOAM530Vzqzv69sIsMCtNHkodJZEDR11wYw5PMvtlxhSveI9mH0F3XyS
        sd2JeLwsMKie0lPitLH9YU2XFT0yODgwUl4rRJVHFUA6diaq7g==
X-Google-Smtp-Source: ABdhPJwCmxIu9W+mQbLF9+oUqcLtWcENm95ba3xoIQjdJU5uzprxmEKd1qxkH8Ok///+EpvaD2CzkL+qo+21044TdTw=
X-Received: by 2002:a65:4d4b:: with SMTP id j11mr8721094pgt.181.1638231563545;
 Mon, 29 Nov 2021 16:19:23 -0800 (PST)
MIME-Version: 1.0
References: <VUYC3R.9YCVE0AMVVIF@anselmschueler.com>
In-Reply-To: <VUYC3R.9YCVE0AMVVIF@anselmschueler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Nov 2021 19:19:12 -0500
Message-ID: <CAPig+cRRxYmFqYimTHSi9uzmWU0FRXQ2hGXJK6jYLJcsFce_Rw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IHBhdGNoOiBjaGFuZ2Ug4oCcRXZlcnl0aGluZyB1cC10by1kYXRl4oCdIHRvIOKAnA==?=
        =?UTF-8?B?QWxyZWFkeSB1cCB0byBkYXRlLuKAnSAoTm8tb3AgbWVzc2FnZXMgZm9yIGdpdC1wdXNoIGFuZCBnaXQt?=
        =?UTF-8?B?cHVsbCk=?=
To:     =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 7:04 PM Anselm Schüler <mail@anselmschueler.com> wrote:
> Why are the no-op messages for git-push and git-pull (i.e. when remote
> and local are identical) so different, while describing something very
> similar? IMO the messages should be either identical or very similar.
> git-pull results in “Already up to date.”, while git-push results
> in “Everything up-to-date”.
>
> It should be considered that other messages reading “Already up to
> date.” seem to use a translation system, it might be better to use
> that system here, too. Unfortunately, I don’t know how to do that
> (currently). At any rate, this patch could serve as a temporary
> “fix”.

This question/issue is raised from time to time, and the short answer
is that send-pack is plumbing, thus there likely will be resistance to
an arbitrary change of text. Denton goes into a bit more detail in his
reply[1].

[1]: https://lore.kernel.org/git/20191122180433.GA57478@generichostname/
