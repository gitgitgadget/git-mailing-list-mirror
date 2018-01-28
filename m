Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1BBB1F576
	for <e@80x24.org>; Sun, 28 Jan 2018 06:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeA1Gkp (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 01:40:45 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38805 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeA1Gko (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 01:40:44 -0500
Received: by mail-qk0-f194.google.com with SMTP id t134so1932820qke.5
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 22:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pGRp9Ghh0tALTpn8FDHNvHqcBD4rtLJFj+clnW28ZKs=;
        b=LJb2r0UtNZHaDgQAZ92qk1hSnlI7Yno/4f14wNOtdXzuBkJwg64WktRruDGM/MeYeK
         JNh35756VpK+2ihLtiqLEIqC1ouAnI/1QDgUJCm653nc1FFmZey7oHX9uh8i0WDmzWe/
         GXCifnMSCMJp+dkc1NFqSsQHDij7U/Z+GSR1+c5BcpsNi0cm4AqEtXxthLQ6JbBi9PvH
         /n9j2sVa+Xf7d/1eGM26vRR07xmFM8AXAVIz+n0+58qc9XgNCHp2AVj+V/oOK8axN8zp
         iYGCzRE+AZcPThPchPrwAxjv4oVwJZCbYRAS2Wz2HwO+LsG7ViJl9ZCpSPYl0NnE78Kt
         PquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pGRp9Ghh0tALTpn8FDHNvHqcBD4rtLJFj+clnW28ZKs=;
        b=C/UJHnEWbZZLcxwEwUlLyMpofYXWZAHr3UqG3JbeMB1nnFHOIlv73GZGsc1NQrPfXw
         yr482gsBq0UeKikVatrxYlRkvEoFe1XRpOEjSV7g7GG7aFw97fdEVATbJjSp34aywVHE
         6UxqFLmh/7YoWd2UPBRGPHtE5xPTHnzV/Jqcy4qQl67tYs8RwRnCZRm4t4cozCJ6MXwg
         rdh+JgpNkqT6Grg9E5JLmw3isItjyX4weAIsXowfKed3sIkNEaaypZcSYFalmGpKm+HN
         fTPD4aAMVpsvXMqiHDQjKRjqda4ot+Drrv8MfDua+zbsbWtUAM1oR6DmzK2MD+SrgV0N
         3sSg==
X-Gm-Message-State: AKwxytcOclJNK3Ul0IsysqKKwIsX9Js1KZNqKsjlX44IHP2kRZh9K9k6
        VdoYq16xnDevKii8dPpkHL4UBe5NqBs7c4z4LCRIzA==
X-Google-Smtp-Source: AH8x227uxfKnSTvjbJsCBKaFVFl3NMsaQBAT5vYPbJlc1ZX6O2sLmJGANyJr3tc1cKoOG9vCKNWn+skrurluVFcSsgk=
X-Received: by 10.55.203.85 with SMTP id d82mr29648439qkj.286.1517121643537;
 Sat, 27 Jan 2018 22:40:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 27 Jan 2018 22:40:43 -0800 (PST)
In-Reply-To: <20180127183132.19724-1-mail@lucaswerkmeister.de>
References: <xmqqtvvbds42.fsf@gitster.mtv.corp.google.com> <20180127183132.19724-1-mail@lucaswerkmeister.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Jan 2018 01:40:43 -0500
X-Google-Sender-Auth: WEHJtUDAYhRm2C98TbkyAKTNIqU
Message-ID: <CAPig+cTetjQ9LSH68Fe5OTcj9TwQ9GSbGzdrjzHOhTAVFvrPxw@mail.gmail.com>
Subject: Re: [PATCH v2] daemon: add --send-log-to=(stderr|syslog|none)
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 27, 2018 at 1:31 PM, Lucas Werkmeister
<mail@lucaswerkmeister.de> wrote:
> This makes it possible to use --inetd while still logging to standard
> error. --syslog is retained as an alias for --send-log-to=3Dsyslog. A mod=
e
> to disable logging explicitly is also provided.
>
> The combination of --inetd with --send-log-to=3Dstderr is useful, for
> instance, when running `git daemon` as an instanced systemd service
> (with associated socket unit). In this case, log messages sent via
> syslog are received by the journal daemon, but run the risk of being
> processed at a time when the `git daemon` process has already exited
> (especially if the process was very short-lived, e.g. due to client
> error), so that the journal daemon can no longer read its cgroup and
> attach the message to the correct systemd unit (see systemd/systemd#2913
> [1]). Logging to stderr instead can solve this problem, because systemd
> can connect stderr directly to the journal daemon, which then already
> knows which unit is associated with this stream.

The purpose of this patch would be easier to fathom if the problem was
presented first (systemd race condition), followed by the solution
(ability to log to stderr even when using --inetd), followed finally
by incidental notes ("--syslog is retained as an alias..." and ability
to disable logging).

Not sure, though, if it's worth a re-roll.

> Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> Notes:
>     This was originally =E2=80=9Cdaemon: add --no-syslog to undo implicit
>     --syslog=E2=80=9D, but Junio pointed out that combining --no-syslog w=
ith
>     --detach isn=E2=80=99t especially useful and suggested --send-log-to=
=3D
>     instead. Is Helped-by: the right credit for this or should it be
>     something else?

Helped-by: is fine, though typically your Signed-off-by: would be last.

I understand that Junio suggested the name --send-log-to=3D, but I
wonder if the more concise --log=3D would be an possibility.

More below...

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> @@ -110,8 +111,26 @@ OPTIONS
> +--send-log-to=3D<destination>::
> +       Send log messages to the specified destination.
> +       Note that this option does not imply --verbose,
> +       thus by default only error conditions will be logged.
> +       The <destination> defaults to `stderr`, and must be one of:

Perhaps also update the documentation of --inetd to mention that its
implied --syslog can be overridden by --send-log-to=3D.

> diff --git a/daemon.c b/daemon.c
> @@ -74,11 +79,14 @@ static const char *get_ip_address(struct hostinfo *hi=
)
>
>  static void logreport(int priority, const char *err, va_list params)
>  {
> -       if (log_syslog) {
> +       switch (log_destination) {
> +       case LOG_TO_SYSLOG: {
>                 char buf[1024];
>                 vsnprintf(buf, sizeof(buf), err, params);
>                 syslog(priority, "%s", buf);
> -       } else {
> +               break;
> +       }
> +       case LOG_TO_STDERR: {

There aren't many instances of:

    case FOO: {

in the code-base, but those that exist don't use braces around cases
which don't need it, so perhaps drop it from the STDERR and NONE
cases. (Probably not worth a re-roll, though.)

>                 /*
>                  * Since stderr is set to buffered mode, the
>                  * logging of different processes will not overlap
> @@ -88,6 +96,11 @@ static void logreport(int priority, const char *err, v=
a_list params)
>                 vfprintf(stderr, err, params);
>                 fputc('\n', stderr);
>                 fflush(stderr);
> +               break;
> +       }
> +       case LOG_TO_NONE: {
> +               break;
> +       }
>         }

Consecutive lines with braces at the same indentation level is rather
odd (but see previous comment).

>  }
>
> @@ -1289,7 +1302,7 @@ int cmd_main(int argc, const char **argv)
>                 }
>                 if (!strcmp(arg, "--inetd")) {
>                         inetd_mode =3D 1;
> -                       log_syslog =3D 1;
> +                       log_destination =3D LOG_TO_SYSLOG;

Hmm, so an invocation "--inetd --send-log-to=3Dstderr" works as
expected, but "--send-log-to=3Dstderr --inetd" doesn't; output goes to
syslog despite the explicit request for stderr. Counterintuitive. This
should probably distinguish between 'log_destination' being unset and
set explicitly; if unset, then, and only then, have --inetd imply
syslog. Perhaps something like this:

    static enum log_destination {
        LOG_TO_UNSET =3D -1
        LOG_TO_NONE,
        LOG_TO_STDERR,
        LOG_TO_SYSLOG,
    } log_destination =3D LOG_TO_UNSET;

    if (!strcmp(arg, "--inetd")) {
        inetd_mode =3D 1;
        if (log_destination =3D=3D LOG_TO_UNSET)
            log_destination =3D LOG_TO_SYSLOG;
        ...
    }
    ...
    if (log_destination =3D=3D LOG_TO_UNSET)
        log_destination =3D LOG_TO_STDERR

>                         continue;
>                 }
> @@ -1297,9 +1310,25 @@ int cmd_main(int argc, const char **argv)
> +               if (skip_prefix(arg, "--send-log-to=3D", &v)) {
> +                       if (!strcmp(v, "syslog")) {
> +                               log_destination =3D LOG_TO_SYSLOG;
> +                               continue;
> +                       }
> +                       else if (!strcmp(v, "stderr")) {

Style: cuddle 'else' with the braces: } else if (...) {

> +                               log_destination =3D LOG_TO_STDERR;
> +                               continue;
> +                       }
> +                       else if (!strcmp(v, "none")) {
> +                               log_destination =3D LOG_TO_NONE;
> +                               continue;
> +                       }
> +                       else
> +                               die("Unknown log destination %s", v);

Even though there is a mix of capitalized and lowercase-only error
messages in daemon.c, newly written code avoids capitalization so
perhaps downcase "unknown".
