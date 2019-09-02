Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D55B1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 17:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfIBR6m (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 13:58:42 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:38198 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfIBR6m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 13:58:42 -0400
Received: by mail-vs1-f45.google.com with SMTP id 62so9667297vsl.5
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6lcPx1kmWQtenyVfEnDCyCI/JmKTvV4toVVkprwhN8=;
        b=cFeOInZhAiMUNOs6ilkrxbByDTSAC4GnZpg2se40V17ivoz/5SmwKtpwEnStJ/cakH
         nE9d2+pn2jfg678DzjlH3nJEIHP5m8/jt/Fy5pDlYhhYsoy1pa+pBcKw/xw7DNlny6eX
         kZGc2/k8zhDCfRKKiccVwBL5ioNAEcCDWyJ9aRqKS9mIZ00LZJiVWKDrVl5pfBKZv77g
         T8geo4iURQ10QSCn988mWPjD7uaajeI0NV20RihF2lBvR/ol1T+r+c+KsBpTF9GbPoaz
         ptLD4VfEQgH8KXQWtx476AfeFsb33K+tCEMcpKZy/Z+8mMhsoeMfC84xQOUr+UQeZyK2
         J+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6lcPx1kmWQtenyVfEnDCyCI/JmKTvV4toVVkprwhN8=;
        b=HQoBymN+0zWXyQw/vbHn0I5RGq2+yHtyQsbpPs8BzTjb3h9MKzQ7lGMwDPTWZgHnnJ
         oU3kB+FMbebJLO/X0zBhSNvLkax1+5ELFn15izVazU2XPhW60JENd8qSzsIvu4WzatnG
         gcCQRbojMTUybYaqzL9k2GvasOCxlBYkKoN6yn1EwEdDNM8l0tXOVENgdcfqz3bXMXD4
         6t1Dhbn7IewT7dh28RidkLxyW+e2ZhCmkVkT7zwcSIiOFmGoVWKdo4mpvwk0lFKTtQCA
         UVSL1TiME8cr9nsVeFCVNDJCK9RMn8dyuYo4vArjIfh0aIlz+2f2qs1hStJooDlhwGOS
         ihKA==
X-Gm-Message-State: APjAAAWZZ9X/IYcAT5UFqGxSlcTIGU/TlT9SlweNsz9+HiWPBR6AMYAz
        Dnlelpc7S9HvcgBzlnE4lPgTv6tPNzPcR/wozWU=
X-Google-Smtp-Source: APXvYqy6Ca1H9pbZDxnak26VBfPIU7LuOQN22f1Cc9HMscBQ3xvUUGdNVl9Cd/HdXhPSlKZFtcEQVJ0HIcl12su3JfY=
X-Received: by 2002:a05:6102:143:: with SMTP id a3mr15327151vsr.63.1567447120854;
 Mon, 02 Sep 2019 10:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=+ThYVyZUiU1wnt0yL+MzF1RXvHnbwo9NWyh95cLyhNRQ@mail.gmail.com>
 <CAKPyHN1LJa8Zq6rZbOMZ-KxkqQYauQcvjv+rTrHt1_zwPZLZ-A@mail.gmail.com> <xmqqa7bmvbwz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7bmvbwz.fsf@gitster-ct.c.googlers.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 19:58:29 +0200
Message-ID: <CAKPyHN3FYR0FbDxnE4ru7OoK4w3OEE0g8tpoOqH-e+e1iTmcuA@mail.gmail.com>
Subject: Re: git-gui: Long lines in commit message gets hidden, no scrollbar appears
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 2, 2019 at 7:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
> > the old reasoning was, that you should not create commit messages
> > which are too wide.
>
> True, and that reasoning would justify hiding scrollbar when not
> necessary to gain vertical space.  Can we arrange the scrollbar to
> appear only when needed?

up to now, git-gui does not hide any scrollbars, if they are not
needed. IMHO, I would keep it that way, as I don't like the flicker
when it appears and disappears. Imagine you are typing in the bottom
line and than you typed too much. The scrollbar appears, your input
line jumps one up line (or is hidden behind the scrollbar), than you
remove the too long line, the scrollbar disappears again and your
input line jumps down again.

Bert
