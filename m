Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E2AA1FC96
	for <e@80x24.org>; Wed, 30 Nov 2016 00:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756264AbcK3ASk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 19:18:40 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36655 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbcK3ASi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 19:18:38 -0500
Received: by mail-qk0-f170.google.com with SMTP id n21so193380137qka.3
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 16:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GBU2LluW5A7OpIWIN34smj7Vh06yi6TDm33ZawRZ1Gg=;
        b=iKrXD3px+PBMQubFJhSk9IPH8DTqXgLAmeLCl+QL9Hp7DUjUVx8qEzOMsf7d3Rj9Fc
         KHhWXte+sdLzjhykEqVY+A5xEQdBkw7t1tA+TbWbsjz4Ggwg3zLLjhk6H2CKZFApT37+
         0axRrA1YHppVXjGTbgj9W33CYM1gLgGy9ovi66JTVzgyfBkNraLZo7q4p+CcF7MkNGBs
         d0THvZvmSvrIh0zH1XWYFOKn6yPOycoebGWqCTciSLI0SVa1qSj3rRSREXuUpyYwEDiu
         Lbdkspem5ZpJE4G6hkzbCDSNSCsd802imN7x8HzF0IQuFoTiUkaQ/YYCQgY+5pxBDEW8
         i4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GBU2LluW5A7OpIWIN34smj7Vh06yi6TDm33ZawRZ1Gg=;
        b=RUf8olQOQqRokCf+qs/pWjuFMkwzbhoFygbBW5H2J215M2AKbLaQ1yt7FMVUBFZ99Y
         l7lAKnyJNz4TPHj134U+DLk3JnZRz4I6gTgYgUUnZ5wZYjNRjYtBdSYVLbMmwU822h7H
         HzaLxGvN6SYMl/YpAAmNjcn8mI0QkixjXH9yvFIHapf5vdZ8/hzPZlBSMZWlXDnCYLHe
         o9+1twEb+ExK2DuyC6Dn/L1Ze5XfcMZhhWdGpAFndR9GO59OSyCUZOhgjTZPcTHQPFbQ
         vkMk42bUj/2fwnuBVVnG/scDOVDWH5RwQoGNOFrRQc9Q5MTNVX9zSXsuOc18b6761LaU
         6GwA==
X-Gm-Message-State: AKaTC030j7bfwcEX0pIcNlsjE7znmDfbD4ec9JG/1yzOw4u87Z6sZ7HNnR50+qslTpw/C+Cy9oWdRTbBdG1sERW/
X-Received: by 10.55.67.81 with SMTP id q78mr26444079qka.53.1480465117482;
 Tue, 29 Nov 2016 16:18:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 29 Nov 2016 16:18:36 -0800 (PST)
In-Reply-To: <xmqqfumaf5lf.fsf@gitster.mtv.corp.google.com>
References: <20161112022337.13317-1-pclouds@gmail.com> <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com> <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DQDPzZGJXLpTVHVFUeupPpp5e=b9z4m7xceJWrxPfF3Q@mail.gmail.com>
 <20161129135646.GA19797@ash> <xmqqfumaf5lf.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 Nov 2016 16:18:36 -0800
Message-ID: <CAGZ79kb21Ewm4Lnr87mpk-YdYiUaQUKtJQm+Voqq_4wfRExgYQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] git worktree (re)move
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 11:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Another way, as pointed out by j6t, is go with "move within filesystem
>> only", at least at the first step. Which is probably a good idea
>> anyway so we can concentrate on git-specific stuff before going to
>> minor and complicated copy/move details.
>
> Yup, that is a very sensible approach.

In case you decided to go another way than a plain rename, please
make it easy to reuse (e.g. move_directory_safely exposed to the
rest of the codebase). I'd find use for that in the series currently
queued as:

  sb/submodule-intern-gitdir

which moves git directories of submodules around (from inside the
submodule/.git to the superprojects .git/modules/<name>)

Thanks,
Stefan
