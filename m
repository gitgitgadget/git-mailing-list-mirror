Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB9D202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 19:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934915AbdKQTlV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 14:41:21 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35464 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdKQTlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 14:41:19 -0500
Received: by mail-qk0-f176.google.com with SMTP id p19so708393qke.2
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BZ8GnIr66K8OsDhSiUG1wBB3iwECb8amTi1ldNhEY6o=;
        b=i3BSCIfd7WsFnuX9mDNDWcreS0iUULGRS2Kr4WNT4TZRR3ksCuSRGaHGeBn+wTfLfO
         NLZlOY5tjl5yMq0At1Ft4tdeW0HzDC7/fz3V2e7/WJCMUIRQFQ6/ZmmSwT12rxdc7x0Y
         FztvhN6kpBYsH6FejA9wcidlXygNi60zpOTnQFp9VgAqWS70l77XA7xyHGopsm8jiuEv
         jWDsQg/bvcOk244BBDzZ7QEjIrDm66dVp2Yhk3JCRplI+J0mNtnwtMrNpNh704zwrmvn
         aKwf+mbvialrDz3aOzWq8g/ukKPr5xP+/xv53vMwfzuTxwIf+tIQO6J10nbOEGbta8s8
         wd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BZ8GnIr66K8OsDhSiUG1wBB3iwECb8amTi1ldNhEY6o=;
        b=g9zY9EVglQqJkzw8arltFVjRcETt3lo1G8Jh5J0JArJHFSuFW2burOTqAQETsSSb9X
         K91CMJMg2Bg+24eRHErWSe424dpEynVqFVePQq3js4vLP1ubU0wAPzhoTgW2160eohLI
         E1JkimaSdUAcBg66l3ZfHjuIR1AfHVUXiSDV1sfxj9zjyYlmXaSKQYQKgF2ubfvT+UYo
         ViygIlzR77wBdtiERcw6B7NZZlTOFyBFtjac//IFrRK0esfSIVTd5d/6/CW6DNCoteqC
         hd5nfEnjt+8IyhTHLOpOX+A2znWNZgqRwXnhaRZ5IWIb1Yv4WX+BzXf3brj8boLnKLeN
         z5Tw==
X-Gm-Message-State: AJaThX4nRiQuFORjBdImMWsLXZjlnIreCB/3he5yUdPNpWqQzG9AMUsI
        dXG14YRjv7Mf+w5B9Y1OWXcg+93ehaVu1doj0Rs=
X-Google-Smtp-Source: AGs4zMYzrGh5ptIcDCStK9RI5P6x04d1XlOffOr+dCPrY3544EK1BFtttE3y881GrCCssH+a+4C+eUyXTcrYL1Hte3o=
X-Received: by 10.55.114.69 with SMTP id n66mr9699785qkc.306.1510947679009;
 Fri, 17 Nov 2017 11:41:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Fri, 17 Nov 2017 11:41:18 -0800 (PST)
In-Reply-To: <20171117135109.18071-1-lars.schneider@autodesk.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Nov 2017 14:41:18 -0500
X-Google-Sender-Auth: 0rF8Y66o2z9Gj7eIIRs37NYwE5k
Message-ID: <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
To:     Lars Schneider <lars.schneider@autodesk.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 17, 2017 at 8:51 AM,  <lars.schneider@autodesk.com> wrote:
> When a graphical GIT_EDITOR is spawned by a Git command that opens
> and waits for user input (e.g. "git rebase -i"), then the editor window
> might be obscured by other windows. The user may be left staring at the
> original Git terminal window without even realizing that s/he needs to
> interact with another window before Git can proceed. To this user Git
> appears hanging.
>
> Show a message in the original terminal and get rid of it when the
> editor returns.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/editor.c b/editor.c
> @@ -40,6 +40,32 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
> +               static const char *close_notice = NULL;
> +
> +               if (isatty(2) && !close_notice) {

If you reverse this condition to say (!close_notice && isatty(2)),
then you save an isatty() invocation each time if close_notice is
already assigned.

However, it's not clear how much benefit you gain from stashing this
away in a static variable. Premature optimization?

> +                       char *term = getenv("TERM");
> +
> +                       if (term && strcmp(term, "dumb"))
> +                               /*
> +                                * go back to the beginning and erase the
> +                                * entire line if the terminal is capable
> +                                * to do so, to avoid wasting the vertical
> +                                * space.
> +                                */
> +                               close_notice = "\r\033[K";
> +                       else
> +                               /* otherwise, complete and waste the line */
> +                               close_notice = "done.\n";
> +               }
> +
> +               if (close_notice) {
> +                       fprintf(
> +                               stderr,
> +                               "Launched your editor ('%s'). Adjust, save, and close the "
> +                               "file to continue. Waiting for your input... ", editor
> +                       );

Here's what this looks like for me:

--- 8< ---
Launched your editor
('/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'). Adjust,
save, and close the file to continue. Waiting for your input...
Waiting for Emacs...
--- 8< ---

Very, very noisy, so much so that it's almost unreadable. There are at
least three reasons for the noise:

* The raw message itself is already overly long. Do we really need to
assume that newcomers are so clueless that they need it spelled out to
such a level of detail? "Launched editor" should be enough for most
people, and one would hope that "Launched editor; waiting for
input..." would be enough for the rest.

* Does not take into consideration that EDITOR might be very long;
perhaps you could just print the basename and strip arguments (i.e.
"/my/long/path/edit -x --foo --zap" becomes "edit"). Or, just omit the
editor altogether.

* emacsclient already prints its own message ("Waiting for Emacs...",
which runs together with Git's message). Perhaps treat emacsclient as
a special case and skip printing this message if emacsclient is in
use: if (strstr(...,"emacsclient"))

And, of course, with a "dumb" terminal, it's even noisier with the
extra "done." at the end:

--- 8< ---
Launched your editor
('/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'). Adjust,
save, and close the file to continue. Waiting for your input...
Waiting for Emacs...
done.
--- 8< ---

As Junio pointed out in [1], emacsclient has already emitted a
newline, so the clear-line sequence is ineffective; likewise, for a
dumb terminal, "done." ends up on its own line. Aside from the noise,
this also suggests making a special case for emacsclient.

And, as Junio pointed out in [2], with a message so long, once it has
wrapped, the clear-line sequence does not work as intended. For those
of us with 80-column terminals, we're left with a bunch of noise on
the screen.

> +                       fflush(stderr);
> +               }
>
>                 p.argv = args;
>                 p.env = env;
> @@ -53,11 +79,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>                 sig = ret - 128;
>                 sigchain_pop(SIGINT);
>                 sigchain_pop(SIGQUIT);
> +
>                 if (sig == SIGINT || sig == SIGQUIT)
>                         raise(sig);
>                 if (ret)
>                         return error("There was a problem with the editor '%s'.",
>                                         editor);
> +               if (close_notice)
> +                       fputs(close_notice, stderr);

Should printing of close_notice be done before the error()? Otherwise,
you get this:

--- 8< ---
Launched your editor (...) ...There was a problem...
--- 8< ---

>         }

[1]: https://public-inbox.org/git/xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com/
[2]: https://public-inbox.org/git/xmqqy3n4rbnr.fsf@gitster.mtv.corp.google.com/
