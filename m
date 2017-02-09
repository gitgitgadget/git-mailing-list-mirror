Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421011FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdBINu1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:50:27 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33894 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbdBINuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 08:50:25 -0500
Received: by mail-oi0-f52.google.com with SMTP id s203so2288742oie.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 05:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z0PEDQ/FXqkpNuTaV9vmviY3Q72d83YpZBPPRiAA/yo=;
        b=W5DccjWUz1ZkqiJxLFW43HEEsb2SLL9oQsgvocXSdhxRj3+98M5jlFoZyC8FVGIBKg
         lF2E5qr7QDplbrslGj0clnPsXrAstF+3va2xMh15hQYIBizDHysQ9UZKmy2G0YJ/QHAQ
         423vtOgc3o6qURwzbNhdq37E+shaPDRvsvg3fHc2A2SmmvhdUQlLxwvG0Kihh62I94Uk
         i83Dh/X0XPFyEkQiYIjj3QFV9KkcVcq48aL4kO0J4dc7vG1UtpVTwx7AL4bxZN7zvsp7
         /XrOSgVXLI60gBEE+t+mTtVNttNgo/WLeyQFRBjP39HtHp44uHSk2gxe6Q5X/cFYpm0i
         WDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z0PEDQ/FXqkpNuTaV9vmviY3Q72d83YpZBPPRiAA/yo=;
        b=Z4LHRMYruqkzTNlzIe73wH2snSaxdFayYB6VxF7homjJ4pALvOtIMxkxsV3OmL0lIh
         y3d/rom2+siVugRlR8VW8LjpOejjuZsFxWh7yUVLfs4ibY6bWZ6uQpMSGlghID6ruQKY
         FGI+koEa1DctmlkTBlF+BBNinWQye9eJkW+3Z17ddwpsBjhLtRvbepmOklqnCCqJdULs
         gZEKWarcvWkXs8k7pFO3H3BmoGUGPcPHZcNBjp7iklmQ8cRIjBCPY9DsYGUl6WaFLuRx
         leexzgBaG0BpQ23snQM+FUXg7sHHpzyEb7Q505rrq6X+MHRrnY3V4NAXWtIIGr95Qtwv
         wPhw==
X-Gm-Message-State: AMke39lSHlAwF3WC2fRkE7p1PurcsIPkxARIr4DoEE3xu8uUgfJNlwLrte4/mwitC/Kq1GdP+blI12a6r9nInQ==
X-Received: by 10.202.79.138 with SMTP id d132mr1406917oib.169.1486648145745;
 Thu, 09 Feb 2017 05:49:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 9 Feb 2017 05:48:34 -0800 (PST)
In-Reply-To: <xmqqwpd0v15j.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan> <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
 <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com> <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
 <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1702072112160.25002@i7.lan>
 <CACsJy8AQmg+oRYATU8_gR6zY-=sPN3m9PKtk-kytkSKGK+GG1g@mail.gmail.com>
 <xmqqy3xgwpiq.fsf@gitster.mtv.corp.google.com> <xmqqwpd0v15j.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 Feb 2017 20:48:34 +0700
Message-ID: <CACsJy8DuP5jGFGJYNeAx+6DPFkRpCiPSrTipjP9A_PD=1uNX3Q@mail.gmail.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 4:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> With or without the patch in this thread, parse_pathspec() behaves
> the same way for either CWD or FULL if you feed a non-empty
> pathspec with at least one positive element.  IOW, if a caller feeds
> a non-empty pathspec and there is no "negative" element involved, it
> does not matter if we feed CWD or FULL.

Yes. Now that you put it that way, it may make more sense to rename
the options to PATHSPEC_DEFAULT_* instead of PATHSPEC_PREFER_*.

>  - builtin/checkout.c::cmd_checkout(), when argc==0, does not call
>    parse_pathspec().  This codepath will get affected by Linus's
>    change ("cd t && git checkout :\!perf" would try to check out
>    everything except t/perf, but what is a reasonable definition of
>    "everything" in the context of this command).  We need to
>    decide, and I am leaning towards preferring CWD for this case.

So far I have seen arguments with single negative pathspec as
examples. What about "cd t; git checkout :^perf :^../Documentation"?
CWD is probably not the best base to be excluded from. Maybe the
common prefix of all negative pathspecs? But things start to get a bit
unintuitive on that road. Or do will still bail out on multiple
negative pathspecs with no positive one?

Also, even with single negative pathspec, what about "cd t; git
checkout :^../ewah"?

> So, I am tempted to suggest us doing the following:
>
>  * Leave a NEEDSWORK comment to archive.c::path_exists() that is
>    used for checking the validation of pathspec elements.  To fix it
>    properly, we need to be able to skip a negative pathspec to be
>    passed to this function by the caller, and to do so, we need to
>    expose a helper from the pathspec API that gets a single string
>    and returns what magic it has, but that is of lower priority.

Side note. There's something else I'm not happy with pathspec handling
in "git archive". Try "cd t; git archive HEAD -- ../Documentation" and
you'll get a very unfriendly error message. But well, no time for it.

>  * Retire the PATHSPEC_PREFER_CWD bit and replace its use with the
>    lack of the PATHSPEC_PREFER_FULL bit.
>
>  * Keep most of the above callsites that currently do not pass
>    CWD/FULL as they are, except the ones that should take FULL (see
>    above).
>
> Comments?

This comes from my experience reading files-backend.c. I didn't
realize '0' in files_downcast(ref_store, 0, "pack_refs"); meant
'submodule not allowed' because apparently I was too lazy to read
prototype. But if was files_downcast(ref_store, NO_SUBMODULE,
"pack_refs"), it would save people's time.

With that in mind, should we keep _CWD the name, so people can quickly
see and guess that it prefers _CWD than _FULL? _CWD can be defined as
zero. It there's mostly as a friendly reminder.

Other than that, yes if killing one flag helps maintenance, I'm for it.

PS. You may notice I favored ^ over ! already. ! was a pain point for
me too but I was too lazy to bring it up and fight for it. Thanks
Linus.
-- 
Duy
