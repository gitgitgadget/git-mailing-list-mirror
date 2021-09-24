Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B928C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AFF61241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbhIXS5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345354AbhIXS5h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:57:37 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7CC06161E
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:56:03 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k10so10991700vsp.12
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+f0/DlJZ4gaRdwIMicxuYNM6Zg3WStt8cjxabiM54M=;
        b=Jz2sA0gTwCACOmHZJm8wgs5+Aoxt/aD1nZ/1+DvQXFK/1JoQy5e5FECnOzB0dHA/Gr
         RS2+JFsICZPuHT3tEBvtDXqu0GOhDZeeBh0w0EBXjigjICn/97e36jZFjjL7/3bWKy3+
         4DWKdHJxKtfYWFUOau2odaEl4P/O+cUsC3mAiu2cuSmBBt/sQEM+JwkafEb40VoVIApD
         KzO4YHq90UdOiBqU6IhuZDGzMMAFQ746VKf89mMswGq6fMxQ7mlfaCczVfoRmjQpEfzQ
         ylodm29xJdiZ7Lf6Sz0Qush1ZL8stuJrzTr9f85LBRhLUjPUqyzPUDmMfSTOqfPj1Lmm
         SYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+f0/DlJZ4gaRdwIMicxuYNM6Zg3WStt8cjxabiM54M=;
        b=mCoZOn/8K3xEgSv2t0Ip6/xIUkOvzC2+JTpcxchKY8DWVe5q9PraiPYVMujbkPZrrN
         na0HvwbRfsoJVPQiUlfxhxdK7Wj1Dp41hZyuyW4TmHWOCJISt9wviuJ5yRNXt4AVHf/O
         5nycC4kjnkpVeZQMJQR6ZWGGNZM/U/XV4sOiE+Rj3C6fJrIPE/WFD4iGbtSmlPqn5mGP
         3VHP83VycX64ExIvx6Svj/S9YP4BvyRr9vxZ/5tV06ky4df5Da5INnJ18i8dIdgF7d7O
         8YOolk6w0c4pnOu8b8CzC0qmz4gVVSoeBg2NI9r3k2iXuXnHYMenp4rF5r8X/bM3dDx3
         zPcA==
X-Gm-Message-State: AOAM532BChdQBfaktbxgxWzBCAnQ9vTFu/TcydV7U9nwJ0tm+bt/6lPI
        N2qBCK74TQ94tFUeXABxLk/Jqp/YYqFM+cM5GHs=
X-Google-Smtp-Source: ABdhPJypeAR9YGWa99MAqle0Ox+pjNJzFPQ3lkT5hp/oL8B1DuYkjuArBFzmS2Ctt5fgPfCiCuXggdLXPu/W7wbcz5Y=
X-Received: by 2002:a05:6102:518:: with SMTP id l24mr11170236vsa.57.1632509762696;
 Fri, 24 Sep 2021 11:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210924121352.42138-1-bagasdotme@gmail.com> <xmqq35ptx3l5.fsf@gitster.g>
In-Reply-To: <xmqq35ptx3l5.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 24 Sep 2021 11:55:51 -0700
Message-ID: <CAPUEspj0y04wwG3cjA-AGXc5AAibYGkEUq-wr0B66+hLrf7_6w@mail.gmail.com>
Subject: Re: [PATCH] send-email: clarify dual-mode behavior
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Thiago Perrotta <tbperrotta@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 10:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > +'git send-email' [<options>] <file|directory>...
> > +'git send-email' [<options>] <revision range>
>
> ... this is not improving Thiago's [3/3], I suspect.

I think it does; after all, the original (which I know you proposed)
did confuse Bagas who thought it might be missing the tagging of being
optional.

The other reasons why this might be better are :
* because of the points and examples you provided, a vague [<options>]
is better than something that might imply all options taken from
format-patch make sense here, which IMHO might be difficult to
understand as logical to you as an experienced user.
* avoids "promoting" this mode, which is known to be problematic as it
could lead to patch bombs without the proper review.  it might even be
worth adding mentions to --compose or --annotate to avoid that.

Carlo
