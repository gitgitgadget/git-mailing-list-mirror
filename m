Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF601F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeJEPee (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:34:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37936 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJEPee (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:34:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so10929550ede.5
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0legS6hBs9PdUD5k5TW34uIAyEqh62H02PtYJ82BZ+Q=;
        b=IwZprxRiBbEC/R6PonnG0rouI/7Pa9X9l+VoGeILo81aBOg/r4z1W0CZ8GxJhHM3aV
         39rItbIJ/CST9VdghemGWs59SMjjt4mdXUeNVtiqzRzg045H0pmI3YeENf2Z+131H92b
         mzRp8epVxrb9cyVjDPSU5AMZ0HGwshjE3qrBRPAWpow1+omTr0vwMFIatTtDuqNXzmI+
         dlV/pVEWIHWKcxqJX7Mad7/qKCrXuGn2pXaJEOgirxc0FT5nUkiZEMTw9aEfx8CAjB0H
         bleFVi+sx5CtkHiXn7FoxGYvXRAafhsC0UkvTZg8XmVzT0C4icmpBidiCriTjVHa9QIt
         Cb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0legS6hBs9PdUD5k5TW34uIAyEqh62H02PtYJ82BZ+Q=;
        b=lFitUyRubcQQh60UxHe1jaq8UMcSeFy5HGXLcDx6Jh3C0MpDUNCx2VkdDvYhnFsjt4
         trCpBg0CrW9GBRvXDmrY+B5HTJ25KjTf6OgotYHxmx3IhKRXC7gQ4f9Y252oIuXha8Qy
         2tlYV5tVOcA12N1gqU7f+RI3y+vVLzgpJ9af5zjQFOx1eFJ57ArR8bXg7Wwq0aHTixic
         jD0dR7rRrBI4fwF+VIJ/pFemlK7GpbxyJdqg6ca3vDBkzKzDaoTqhLZfG14OjOreQLIe
         zVHXTYwj/mifgItLx6e0c9kh8bkHCMPST0bRLeZe8nfRZ86RmP3xgzfrhHyhR4TJi7WU
         SjkA==
X-Gm-Message-State: ABuFfohWrNaS6vYM9dkO1zXrSVFrhHpGDBnJsrZdBCT+QkQFTfzPkNYz
        gWhfT7iprYrNi46XkajqFdwA1qSMlk4ac0AEh3w=
X-Google-Smtp-Source: ACcGV60xJAVC4sSxVrf0DX15TcfN+0eSrSs6/QG19dBRYxBP0ilE3FK+ySmsD7D4iHqujDZ9otSNuMn42A7VnpRiLy4=
X-Received: by 2002:aa7:c581:: with SMTP id g1-v6mr4449073edq.79.1538728612172;
 Fri, 05 Oct 2018 01:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.43.git.gitgitgadget@gmail.com> <b358178548bdc9134d4e4b83b1d0384ebb257a72.1538578818.git.gitgitgadget@gmail.com>
 <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s9424ig.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 5 Oct 2018 01:36:40 -0700
Message-ID: <CA+P7+xqttkfXc7QF8z=RkcaS_k4dp_mj-EX3xEji8BsT0SKyKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rebase -i: introduce the 'break' command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gitgitgadget@gmail.com, Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 5, 2018 at 1:17 AM Junio C Hamano <gitster@pobox.com> wrote:
> If one wants to emulate this with the versions of Git that are
> currently deployed, would it be sufficient to insert "exec false"
> instead of "break"?
>
> The reason I am asking is *not* to imply that we do not need this
> new feature.  It is because I vaguely recall seeing a request to add
> 'pause' to the insn set and "exec false" was mentioned as a more
> general alternative long time ago.  I am trying to see if this is a
> recurring request/wish, because it would reinforce that this new
> feature would be a good addition if that is the case.
>
> I suspect that "exec false" would give a message that looks like a
> complaint ("'false' failed so we are giving you control back to fix
> things" or something like that), and having a dedicated way to pause
> the execution without alarming the user is a good idea.
>
> I think the earlier request asked for 'pause' (I didn't dig the list
> archive very carefully, though), and 'stop' may also be a possible
> verb, but I tend to agree with this patch that 'break' is probably
> the best choice, simply because it begins with 'b' in the
> abbreviated form, a letter that is not yet used by others (unlike
> 'pause' or 'stop' that would want 'p' and 's' that are already
> taken)..
>

Yea. I use "exec false" all the time for this purpose, but it's a bit
confusing, and it does cause rebase to indicate that a command failed.

I think adding a builtin command to do this is a good idea, and I
think break is a reasonable verb, (especially considering the
shorthand "b").

Regards,
Jake
