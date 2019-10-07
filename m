Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FAA1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 16:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfJGQwu (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 12:52:50 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36423 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfJGQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 12:52:49 -0400
Received: by mail-lf1-f46.google.com with SMTP id x80so9800614lff.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1C5+ALNFuUYlX41fRuSN4R8AzLZZN9BaTQcUj+LR8mA=;
        b=E/GXcay5vVkPGrRpWhpC0AxHEnehcZwCbD8Pk11hgBRZlJui7edR1HUH4uUFORXqJd
         Uz9U58qpttP89Cfim9E0JyhQxp0WkqzPWkyKPfDoz0acxT8dtuWQwolfdcguCoE5MPA9
         jaUyPbtN83fE9G20BYLPizJTqRGkF2YQaZkXerC9ac+xUnukU+6i6AKBB0nlt3ac0K6T
         ENWnKzTJM8e5vGq/nZtHFfQA8tKi39EnmYpUdDiru1PS5kxSR/yI6F+u2SGFOBOYt2u6
         Oq5s0GT5OV9SJCVlA9O5bl097XkS9Ldl1U5Qmf6XymJP5PfUMoSD4xigkZwidwIXmSHK
         nHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1C5+ALNFuUYlX41fRuSN4R8AzLZZN9BaTQcUj+LR8mA=;
        b=ED+YIGqdgrDanSI/H5g9ugMIM6UzXBg4N346zW1BCXPZtQ001vrC/yaeLZtvjQ/AMy
         pE5QJ/uTSFz4P9tV8vvNoVMZ5vc0Y6Nff66OCVGIvemkIxt97CwRqabBnwl3rv05i6dM
         rW8JpXk1v84vu+o/UwW/bqVP3H7l2EP/6Xxmd6GhbniPQrBI2lYW4peNKhTvjdHB5uBw
         KoAaxfUykuYHXpAgpOSPbLWev4DOSVrX+75oQjK6x2ANo7sqEfGFPYG7ed7kMJe5JAck
         VIlg+r0WI+9hQrjqUB8BHYTiaQTHeNXNLXxs4M8KBdCeTt5g00zJjY6qMWtJNBrStXbn
         9+Aw==
X-Gm-Message-State: APjAAAVYpucZOnSZOFf0AqZJFdDavC3DeQ45eiCxe49/BHaGBaEixRWM
        MyAoVT3ADxOCcLeAQjGQF+fDAaSkHzFPXFxluXRKbIV301U=
X-Google-Smtp-Source: APXvYqydFVCtI3nN0y8Pn9WkoezuhKlkhu1XlBPO/5OfTcbKiS4ODVw9BGbZjEHE7K9Pzn15iEcJuZJ04SvBzF94QIk=
X-Received: by 2002:a19:f801:: with SMTP id a1mr15800472lff.166.1570467167551;
 Mon, 07 Oct 2019 09:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com> <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
 <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com> <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
 <20190926193004.jspiirmb4ejxznjo@yadavpratyush.com> <CAGr--=Jiu-haHMX2fc8AB1uGWT1OMw5=M3_CuGWVzrYmO0uq3A@mail.gmail.com>
In-Reply-To: <CAGr--=Jiu-haHMX2fc8AB1uGWT1OMw5=M3_CuGWVzrYmO0uq3A@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Mon, 7 Oct 2019 18:52:31 +0200
Message-ID: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I kinda got this working, but only when focusing the commit message widget.

I did not manage to get it working when invoking "do_add_all", (e.g.
when pressing CTRL/CMD+i). I added this:

bind $ui_comm <$M1B-Key-i> {do_add_all;select_staged_file;break}
bind $ui_comm <$M1B-Key-I> {do_add_all;select_staged_file;break}

But it seems that the "select_staged_file" procedure is invoked
_before_ "do_add_all" finishes. So that's not working. All changes
gets staged, but no staged change is selected.

And I'm quite stuck. Do I send the unfinished patch, so maybe I can
get some advice? Or is it better to just wait until I have the perfect
patch ready?

Birger
