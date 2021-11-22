Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8879CC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhKVWxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhKVWx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:53:29 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D02C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:50:22 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id b17so39923469uas.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWfpVktlLj2ChmFSAsFnZLahkindA0MsNtnDc7HXRDo=;
        b=GPWlUVnYsfF9MECNPIUiWb6n9NBjJBvqB1oneRFxk29tY5lEFt2+/XW+jro7bPxNVv
         ghSTWwWU4M+/WEmj61nbb336IWfEf/4ojHP5AJRI2APjXUL8zPMX70SxVfqHhl88J/5R
         h3dGMkaXcoku4iUWNVzg1afryDjx0nzAcp8swblG7xORxxKq3U4EQK6C5wf9yUywWaV2
         hA2uRyVgZSmKyOzwh99lk0xYr/lQoaqpJNNBcwx+6K+OV8ypBoQ2j1t2ttFuGOtwjUNv
         RVJQc2P+Pdj1pn9O2tzfkVLKAtatnBZC6gDZ1mFHYnmXVG3zQUBU23VNUALmeLxPyCZQ
         izew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWfpVktlLj2ChmFSAsFnZLahkindA0MsNtnDc7HXRDo=;
        b=yYt1/9z3c9VyboUNOGFs5MDoqF1mHcXzCYleem9Ln/d4/wmc2LpJ6W3QGpqBbC5OrF
         McVdkxOnzGLrLAvV1sbj92x+PMcAucAVg3QAdebfCutuNEBa3EPv/auaDKJTPp4MJXhd
         au1o3vdezva/Mw+/vetx3a0gJ8M1jENsK3CoqMRUq2y6KOaYva3z2bq70nE1VPqO/qNp
         4WyNPnSJ5YWAyN4S9yNCFIReXQvv0WnbGpOekCRlcCqjLpmAh+sMRa9mjPaP/hZOa983
         fjWvnebjkE49OuGmMYWNGQc6FfXCyER6JQsD8p/tR0hOqYuNe+1cIPzHn0bGSpNp2Zjs
         E7DA==
X-Gm-Message-State: AOAM532KFxiwl8FKhZuNXtBn1e91FnZuNzAOHJ/ww3CioN69lp7j6U97
        GX+ahmIns3b6L6E+GzxzOw7wRFnUmkxjh6RSIs+Hg60pVq4=
X-Google-Smtp-Source: ABdhPJywQ1UfsNgfhYJ180x8bldvNorDMGucu0IW8gqquCFBuCmU93cGCI/1VC2wKhGg3Wf/48pEE7oT8Y+CgRaEEYA=
X-Received: by 2002:ab0:66cd:: with SMTP id d13mr864226uaq.140.1637621422098;
 Mon, 22 Nov 2021 14:50:22 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1b8gkhg.fsf@gitster.g> <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2111222319100.63@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 22 Nov 2021 14:50:08 -0800
Message-ID: <CAPUEsph+F5inaga266xdFoc6KibjFo7hYh0ycdAkM9Q8yk5Ryg@mail.gmail.com>
Subject: Re: preparing for 2.34.1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 2:28 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I was tempted to suggest an `isatty(2)`, but that probably comes with its
> own problems, too.

I went with isatty(1) in the suggested minimal bugfix[1] since I think
it is safe to assume that no one that doesn't have stdout connected to
a terminal should even care if the invoking editor dies and messes
with their terminal, and hopefully whoever is hacking git commands
that invoke an editor to read its output, is actually not doing it
through a tty but a pipe.

What problems do you foresee with isatty?, the current code already
checks for errors on accessing the console, but as Phillip
suggested[2] in that thread a signal might be generated for some of
those errors when the terminal is shared with other processes.

Carlo

CC: +Phillip

[1] https://lore.kernel.org/git/20211122222850.674-1-carenas@gmail.com/
[2] https://lore.kernel.org/git/04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com/T/#u
