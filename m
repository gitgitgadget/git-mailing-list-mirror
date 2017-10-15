Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1307C20372
	for <e@80x24.org>; Sun, 15 Oct 2017 21:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbdJOVhG (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 17:37:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33789 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdJOVhF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 17:37:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id 14so5934019oii.0
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZAXp97BGiZfNzHnPrh0gUGM4Bd6qnQTVbwcUcpu6p78=;
        b=hXGcloynrngFGB1acWm+ZJsVwwEq5qwDhW0+5PvEMUAkK+8Jux6MOKt63P5K3dMkou
         qOdd76s+JSPn8WIzk1VmuebJTobR2G3Jbkd8lnzMa5/uhHz/Xx8ENlVtP1PMsayfkWgq
         refK2bdrLUC+bt/4iqvOn5xNBcnqiiKEPUTQ0xCs+bWErZKeEw70vmAhTYiXbx8XS0y5
         uXOFG+cSc0I6u/014VGClVqRqIkUNVUmP3/YLpsD126Z3jEMJZR0XM0u3pB7GRM1dRZs
         mFV5hfbv1y3Ty5UW6oz8YsP1NO71TafMJhjgAXTMsxf6h1R78y6BzCMjrh7tVlVXZt7i
         Qxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZAXp97BGiZfNzHnPrh0gUGM4Bd6qnQTVbwcUcpu6p78=;
        b=U99Q0ZkRtKFSVgvcSYaT7DDXHLMLYVuM/XgNVgjNk1BTuIt78Psh8gZEqeE9lDwUK6
         lgyewBSghW9s8t6vgqC39LbXzbQw5oWbMWZoz79Aivz4UUbY/Ijv0eln+YdyPqKFa48z
         w8gqeZAJcNiEaSwi2Hcwa3HjRjz3Y4deIPXqhtuH9TEnPTVskTkeM5Q9c+x5B2YSyudU
         fwWjTdoiXoseu6Nov+/P2TZ/fKIjbOWr/KgOmAtWNqw3gTNESfEyh4CqkT/ruaPr9Rtr
         7rJbojquca7R0CjRXGiVCNJRxN9n3CpM2XJIj/Nce6hHvU7xbGEeBpzwLUPJZQejb+r7
         a+4A==
X-Gm-Message-State: AMCzsaVO/jV9w3fBaRrlh4T3ZHPZC/IWrSJQTaigtS4f8IU1dtz86f7j
        I+4jFPdfPA+bHU9Vfl3XyewegmKXZqPMLuRIExc=
X-Google-Smtp-Source: ABhQp+Sh2EAgdiHrThqzhqeuArXdmfs39vNWZNP5Yxx7gZTTCgoW73bY41FYdqt1fK63gGLufWfTwkSUtJqmES6TzvY=
X-Received: by 10.157.86.186 with SMTP id o55mr4404149oth.88.1508103424907;
 Sun, 15 Oct 2017 14:37:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.4.104 with HTTP; Sun, 15 Oct 2017 14:37:04 -0700 (PDT)
In-Reply-To: <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat> <87zi8sxvkg.fsf@linux-m68k.org>
 <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com> <20171015200635.e2u4qkxlz2xwpfov@sigill.intra.peff.net>
From:   Joris Valette <joris.valette@gmail.com>
Date:   Sun, 15 Oct 2017 23:37:04 +0200
Message-ID: <CA+o7MD84O5uTOz0xAGmd=xL+Hw8UsVCu5v_HEEeMWvAhSRQCeA@mail.gmail.com>
Subject: Re: Consider escaping special characters like 'less' does
To:     Jeff King <peff@peff.net>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-10-15 22:06 GMT+02:00 Jeff King <peff@peff.net>:
> Git's diff generation will never do such escaping by default, because it
> means creating a patch that cannot be applied to get back the original
> content.

Indeed this would be a problem. That's where my knowledge of git's
source code ends, but in that case, can't the output be discriminated
against the command that was executed?
Command that outputs an applicable patch -> don't escape
Command that outputs a diff to see changes -> escape

> There _are_ already options to create diffs that cannot be applied, like
> --textconv. So it would be possible to add a similar option for
> escaping. But I don't think we really need or want a separate option,
> when you can already do one of:
>
>   1. If your files have special binary characters that are hard to see,
>      you can use the existing textconv system to do whatever escaping
>      you like. And then the Git will diff the result of the escaping,
>      which means you get readable diffs when they change.
>
>   2. Put the raw output of git's diff through a filter that escapes. We
>      already do this most of the time by piping through less. The most
>      noticeable exception is "add --patch". There you can set up a
>      program to filter as well. There's more information in a recent
>      thread here:
>
>        https://public-inbox.org/git/20171012184736.rglkbyryauwuvn2a@sigill.intra.peff.net/
>
> It doesn't seem out of the question to me to have an out-of-the-box
> default for interactive.diffFilter which does some basic escaping (we
> could even implement it inside the perl script for efficiency).

Yes I read this thread, but I was left unsatisfied because I would
like something out-of-the-box.
Your suggestion might be the best solution then: implement some
default escaping for interactive.diffFilter.

Joris
