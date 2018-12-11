Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D2D20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 03:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeLKD07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 22:26:59 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:37851 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeLKD07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 22:26:59 -0500
Received: by mail-ed1-f53.google.com with SMTP id h15so11312945edb.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CV4vJQwwqTI8gdSytuJqWr0051QPz51UOx0H0cSubIo=;
        b=DW2SQwqiEol5LqFDTji5q4xKKpMXOkGKAJrAgT/1ZV0KSMsOjA8JVc9TGwoaDyPdEj
         bO48oOAMLoWgooYQVSg7S4D6DETtqSgpdzMwDIVKbbO74EqIRBWbh74cHN2KrOoAbAfE
         rSv41vCd+z5EnE5OWU/qeW1PmCleg/rEsd3urP0tF4G+VyufDhAskyJwsOIdZ3hMNHJT
         6AZQ1/Drq4gzSDXJXxsb/1yuNw7BB26cv8GHbMvSJE/rJn8KUKf+kt9OhR4Jh/swwhju
         JYjd3mL47ii8vQ/BqMAjp7ZWhtRETa+ni0TM5t+NJ/KNE9Uk5bzhSOSmdZ8QXGqwMcxc
         dNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CV4vJQwwqTI8gdSytuJqWr0051QPz51UOx0H0cSubIo=;
        b=bQj09/Yn2MecXH67/Q9vRYoqHr6VA2Jr56vFX5imR9CfaJJvNMMjF0sfZqlRGTYRDk
         bwUgnrARPeByo/m2lGNmRYXpNmMdGTavnXFvBqiaymEibKxVD+UMYL7cHgluoPtKoe5k
         Tq8fASo1SqCIUYSMlt+GcikFgKTQE2cGAPnf9QtYoAmuwgpAs5woasHL4Z7zRjyuGWfX
         tZLO2Y3a9CR1V8Z2wybcrkX6qX+qHbRUjZcIidQg6R3xK3iBxrAMpf+TTgDQVvVxmEgv
         RQv9DotjQd5ZdracktM4tOz5gkbdLzKGRDced2LjKTDC63weF/LaGDCSMN0U1L8JM2dS
         jxDA==
X-Gm-Message-State: AA+aEWZaLKrNxYOkHsXFwyBKdBDgWGkrVxLp7fAdakCV6v6aVPhEvhF2
        IvwA3X5lh/QO7wXPSC3GbFA+i4F1QKe0f2zet5u48w==
X-Google-Smtp-Source: AFSGD/W47JNz94B5vDvKyTxgDe8cBK7Zx0bEHAp+FBXZPy/K/usHnbocmtuN7ABgxGCZaQXUDnyxSvejpYmHt2ZR7jU=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr12980234edd.215.1544498817106;
 Mon, 10 Dec 2018 19:26:57 -0800 (PST)
MIME-Version: 1.0
References: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com> <20181208071634.GA18272@sigill.intra.peff.net>
In-Reply-To: <20181208071634.GA18272@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 19:26:46 -0800
Message-ID: <CAGZ79kbd=2_eHdbVYwmNoAYupwnP3YDn6nT0m=v1CL0AkWXk=Q@mail.gmail.com>
Subject: Re: Difficulty with parsing colorized diff output
To:     Jeff King <peff@peff.net>
Cc:     george.w.king@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> (For the Git project itself, we long ago realized that putting raw color
> codes into the source is a big pain when working with diffs, and we
> instead use tools like t/test-lib-functions.sh's test_decode_color).

And also we hid the colors behind #defines and such.

> > * Context lines do not begin with reset code, but do end with a reset
> > code. It would be preferable in my opinion if they had both (like
> > every other line), or none at all.
>
> Context lines do have both. It's just that the default color for context
> lines is empty. ;)

The content itself can contain color codes.

Instead of unconditionally resetting each line, we could parse each
content line to determine if we actually have to reset the colors.

>
> But yes, I think it might be reasonable to recognize when an opening
> color is empty, and turn the closing reset into a noop in that case (or
> I guess you are also advocating the opposite: turn an empty color into a
> noop \x1b[m or similar).


>
> I think most of the coloring, including context lines, is coming from
> diff.c:emit_diff_symbol_from_struct(). Instead of unconditionally
> calling:
>
>   context = diff_get_color_opt(o, DIFF_CONTEXT);
>   reset = diff_get_color_opt(o, DIFF_RESET);
>
> I suspect we could have a helper like this:
>
>   static const char *diff_get_reset(const char *color)
>   {
>         if (!color || !*color)
>                 return "";
>         return diff_colors[DIFF_RESET];
>   }
>   ...
>   context = diff_get_color_opt(o, DIFF_CONTEXT);
>   reset = diff_get_reset(context);

Another easier way to do so would be to drop
the line

    needs_reset = 1; /* 'line' may contain color codes. */

in diff.c::emit_line_0
I run the test suite and it passes (I thought we had a test
enforcing we'd reset any user provided coloring).

> > * Added lines have excess codes after the plus sign. The entire prefix
> > is, `\x1b[32m+\x1b[m\x1b[32m` translating to GREEN PLUS RESET GREEN.
> > Emitting codes after the plus sign makes the parsing more complex and
> > idiosyncratic.

Then we have broken code in diff.c::emit_line_ws_markup
in the last case ("else {") which first emits the sign via
emit_line_0 and then the rest via ws_check_emit.
It sounds like we'd want to replace `reset` in the call
of emit_line_0 with
  set == set_sign ? NULL : reset
and set in the call to ws_check_emit with
  set == set_sign ? NULL : set

Manually looking at some diff output  of said diff we'd get
  <RED>- emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign,
reset,<RESET>
  <GREEN>+<RESET> <GREEN>emit_line_0(o, set_sign ? set_sign : set,
NULL, !!set_sign, set == set_sign ? NULL : reset,<RESET>

and the issue is that we do not color the beginning white space
of the emission from ws_check_emit but maybe we should.

Another idea would be to allow Git to output its output
as if it was run through test_decode_color, slightly related:
https://public-inbox.org/git/20180804015317.182683-8-sbeller@google.com/
i.e. we'd markup the output instead of coloring it.
