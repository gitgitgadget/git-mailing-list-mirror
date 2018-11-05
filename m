Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874FB1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbeKFDlF (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 22:41:05 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:33115 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbeKFDlF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 22:41:05 -0500
Received: by mail-ed1-f46.google.com with SMTP id d15-v6so5302313edr.0
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNrdngr+TeqQyhWdu+24xnrn7bI6nOUzdQCJaqMY6RY=;
        b=KhnsxDlJQ7osanLF9WPyLkG3ZsP0yUALC4OT0gkAOQ0tLHfat9O/VPPZaE8gLd8GBk
         wksURyc574bnYCtIL66KWrLT9RZHpUfI8UQ/98oersv9FQarpjeZmHVeUuBYcwr1l0Qa
         hO/DqaHSnGEUgQfnn9+45TFLq1tVVAvMJfRC5iDxruQVijSEh/87Zi9lKjtkTgo5s0Hl
         Vh3gcD2JPXTGTxBJggvNXMZ1M3n9Av6wRteABQZjC2HbS+rvDT/RZJupRTJ5vgruNUcx
         8fY7PJ6dsUGjd2UpBkZGhpNvPeJLjl9koHA3EYg5PJys3wzpoM0K1y3g1eoi3+Mmeios
         Ixng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNrdngr+TeqQyhWdu+24xnrn7bI6nOUzdQCJaqMY6RY=;
        b=VpwAP2Nm5VvbmQpOUIzxviYv611kD9LSxhPDpunNc9pjLa1p7N5cRa4gmCs/wePD92
         60RD8lqbGot7tnRFpRsaK72VgNtv9DU/SNPe/JesgbvHs+oAShAc6Gd4lAWKOM+nyfuV
         95hzRMMDTxh+oP4Cns7hYv6jLn4dRDLEJOKEXOfpwwsowdwaaSU22rR8TDKb69C9brBW
         qAQPRxWnIqPNvl7vFwoqf1isiXjiS8oCNh9c9kxFedX0IK3aYOqLTXbvpN5ShohKeJuS
         spZqA+Nsdyuovb38H3W2P+dZzVgZC0swnEdJoLxcucas/cAfVd/SiX+Aj6WJfN7h4j9W
         x6zA==
X-Gm-Message-State: AGRZ1gJMMd6sydRUFTZRn2Hur9FCbKa+Cpq2lqiGIqdqMgumYqpZkWwO
        5H7bHb3LesZ7qKPgfMYkuKAGdaEp73QipS8ueS/n9A==
X-Google-Smtp-Source: AJdET5eyow3CEbd/JoGw20+AFoWqmHcB1A1aIXHAaYwZ9k0vvVsCVvYZ16BU+5DLbl8uYvQDCskHLBF9UgEdyr3Gup8=
X-Received: by 2002:a50:8ce4:: with SMTP id r33-v6mr18734087edr.231.1541442009633;
 Mon, 05 Nov 2018 10:20:09 -0800 (PST)
MIME-Version: 1.0
References: <20181102212316.208433-1-sbeller@google.com> <xmqqzhurlzv2.fsf@gitster-ct.c.googlers.com>
 <xmqqk1lshx26.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1lshx26.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Nov 2018 10:19:58 -0800
Message-ID: <CAGZ79kbJvX1Y8-iiAzXKKam7hy=pg-5+p_rzDse42-oCswMXSQ@mail.gmail.com>
Subject: Re: [PATCH] diff: differentiate error handling in parse_color_moved_ws
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 10:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Stefan Beller <sbeller@google.com> writes:
> >
> >>
> >> -static int parse_color_moved_ws(const char *arg)
> >> +static unsigned parse_color_moved_ws(const char *arg)
> >>  {
> >>      int ret = 0;
> >>      struct string_list l = STRING_LIST_INIT_DUP;
> >> @@ -312,15 +312,19 @@ static int parse_color_moved_ws(const char *arg)
> >>                      ret |= XDF_IGNORE_WHITESPACE;
> >>              else if (!strcmp(sb.buf, "allow-indentation-change"))
> >>                      ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
> >> -            else
> >> +            else {
> >> +                    ret |= COLOR_MOVED_WS_ERROR;
> >>                      error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
> >> +            }
> >> ...
> >>      } else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
> >> -            options->color_moved_ws_handling = parse_color_moved_ws(arg);
> >> +            unsigned cm = parse_color_moved_ws(arg);
> >> +            if (cm & COLOR_MOVED_WS_ERROR)
> >> +                    die("bad --color-moved-ws argument: %s", arg);
> >> +            options->color_moved_ws_handling = cm;
> >
> > Excellent.
> >
> > Will queue.  Perhaps a test or two can follow to ensure a bad value
> > from config does not kill while a command line does?
>
> Wait.  This does not fix
>
>         git -c diff.colormovedws=nonsense diff
>
> that dies with an error message---it should ignore the config and at
> moat issue a warning.

$ git -c core.abbrev=41 diff
error: abbrev length out of range: 41
fatal: unable to parse 'core.abbrev' from command-line config
$ ./git -c  diff.colormovedws=nonsense diff HEAD
error: ignoring unknown color-moved-ws mode 'nonsense'
fatal: unable to parse 'diff.colormovedws' from command-line config

Ah, I see the issue there. We actually have to return 'success' to the
config machinery after the warning claiming ignoring the setting or
we'd have to reword the warning to state we're not ignoring the bogus
setting.

> The command line handling of
>
>         git diff --color-moved-ws=nonsense
>
> does correctly die, but it first says "error: ignoring" before
> saying "fatal: bad argument", which is suboptimal.

So to find the analogous here, maybe:

$ git diff --color=bogus
error: option `color' expects "always", "auto", or "never"

> So, not so excellent (yet) X-<.

So to reach excellence, we'd want to reword the warning
message and a test.

Thanks,
Stefan
