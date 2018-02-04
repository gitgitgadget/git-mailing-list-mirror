Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E041F576
	for <e@80x24.org>; Sun,  4 Feb 2018 06:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750796AbeBDGgU (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 01:36:20 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44381 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeBDGgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 01:36:19 -0500
Received: by mail-qk0-f195.google.com with SMTP id n188so17599383qkn.11
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 22:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nnhiOv3QWHg2P+7tpTw7ArfpPV46KXlxTL32PEeDFeQ=;
        b=rre7qQAB7gQCMF1+lwbzhf0kPNMGgr8+pthFr4p3SsFyGiq1GtnNlBzFbZJ3c64dUb
         kXSigGlwyQaXfh1lNPcIieBXGSumgxLKlViFqxvki6kFlSw4U4N6m9lnmzKTMn/jSI4t
         jJWIB36yHS26AcfiNJPx+VD47v70arpmjY5I4PI3tJzuoV2+syzjlmzA80T2nSr3REk2
         YFogHLRFbGGOMwTzkgJ2ErmfieEWmqB0VZ+vaZkDZAPioFX2HpJy1698BfDiTD8Svb18
         8VrEIqxOmu5JWU+UHvxoisp0f7VOnmh9dCNdMBkUT/+uc8YxGC2MFDETvkeux1/dWJiv
         IeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nnhiOv3QWHg2P+7tpTw7ArfpPV46KXlxTL32PEeDFeQ=;
        b=XAuL2DMAWwx1207eF0zipEsoWjX3Ehu4xWSI6T+pTTHbkLc/HmzgE1+PYb39tcndG6
         esHqb+DuOfI1uRp9nf4Fheo8THIz4Z0iV10LBazK0SkLFFIm+ldfgYsbHIDruydJ2yzx
         zD0ol59txQZZzqqpbaXMb417rQgbAr+jX7wsQhxjU6pTPbCJbuSbGHjTxlgNjtdXURT3
         WutHZGDNwCNRuXg35QhYZ15Nj/sIpQ33Dc4Kl/Dbzyu4te3bPUYrD6ls+UJhy/GaSM0k
         m5wyEPFH3M4AsRwf2u/3unQ6XCVJyrc0H/WPwwL2KXpCNDA4aV8JNNU6uquyuWYCC/jM
         TiJw==
X-Gm-Message-State: AKwxytckKQpWPrMW1TuQHpQWJG0YCYxwUFuauktvJ3iK8BL2zCcpa7gV
        e38G6FrUheWxuRHSSjfmjAb+x7iy28KPpdS4mds=
X-Google-Smtp-Source: AH8x225LbO+j9Ss6dlq1mAKn3OD1NWozGkasgkiCRG7emwf/j1yYKq7rc2gWDxcyIpEuKORhvGTsBF5s7YspOvKL1Vk=
X-Received: by 10.55.123.69 with SMTP id w66mr67807481qkc.326.1517726178358;
 Sat, 03 Feb 2018 22:36:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 3 Feb 2018 22:36:17 -0800 (PST)
In-Reply-To: <20180203230801.30345-1-mail@lucaswerkmeister.de>
References: <CAPig+cR1VXtc-wZxv3mZGsbTAzmtPbhnRPtBX97-8Rm9b6rpHQ@mail.gmail.com>
 <20180203230801.30345-1-mail@lucaswerkmeister.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Feb 2018 01:36:17 -0500
X-Google-Sender-Auth: nN5lF-y9_-su803F2xmrBcZuuhU
Message-ID: <CAPig+cS8hqaqwrzw9GXY9x0rgksPrCm_deHHw-AL6Tj8-bf1Og@mail.gmail.com>
Subject: Re: [PATCH v3] daemon: add --log-destination=(stderr|syslog|none)
To:     Lucas Werkmeister <mail@lucaswerkmeister.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 6:08 PM, Lucas Werkmeister
<mail@lucaswerkmeister.de> wrote:
> This new option can be used to override the implicit --syslog of
> --inetd, or to disable all logging. (While --detach also implies
> --syslog, --log-destination=stderr with --detach is useless since
> --detach disassociates the process from the original stderr.) --syslog
> is retained as an alias for --log-destination=syslog.
> [...]
> Signed-off-by: Lucas Werkmeister <mail@lucaswerkmeister.de>

Thanks for the re-roll. There are a few comments below. Except for one
apparent bug, I'm not sure the others are worth a re-roll...

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> @@ -110,8 +112,26 @@ OPTIONS
> +--log-destination=<destination>::
> +       Send log messages to the specified destination.
> +       Note that this option does not imply --verbose,
> +       thus by default only error conditions will be logged.
> +       The <destination> defaults to `stderr`, and must be one of:

I wonder if this should say instead:

    The default destination is `stderr` unless `syslog`
    is implied by `--inetd` or `--detach`, ...

> diff --git a/daemon.c b/daemon.c
> @@ -9,7 +9,12 @@
> -static int log_syslog;
> +static enum log_destination {
> +       LOG_DESTINATION_UNSET = -1,
> +       LOG_DESTINATION_NONE = 0,
> +       LOG_DESTINATION_STDERR = 1,
> +       LOG_DESTINATION_SYSLOG = 2,
> +} log_destination;

Doesn't log_destination need to be initialized to
LOG_DESTINATION_UNSET (see [1])? As it stands, being static, it's
initialized automatically to 0 (LOG_DESTINATION_NONE), which borks the
logic below.

> @@ -74,11 +80,14 @@ static const char *get_ip_address(struct hostinfo *hi)
>  static void logreport(int priority, const char *err, va_list params)
>  {
> +       switch (log_destination) {
> +       case LOG_DESTINATION_SYSLOG: {
>                 char buf[1024];
>                 vsnprintf(buf, sizeof(buf), err, params);
>                 syslog(priority, "%s", buf);
> +               break;
> +       }
> +       case LOG_DESTINATION_STDERR:
>                 /*
>                  * Since stderr is set to buffered mode, the
>                  * logging of different processes will not overlap
> @@ -88,6 +97,10 @@ static void logreport(int priority, const char *err, va_list params)
>                 vfprintf(stderr, err, params);
>                 fputc('\n', stderr);
>                 fflush(stderr);
> +               break;
> +       case LOG_DESTINATION_NONE:
> +       case LOG_DESTINATION_UNSET:
> +               break;

Since LOG_DESTINATION_UNSET should never occur, perhaps this should be
written as:

    case LOG_DESTINATION_NONE:
        break;
    case LOG_DESTINATION_UNSET:
        BUG("impossible destination: %d", log_destination);

> @@ -1297,9 +1309,22 @@ int cmd_main(int argc, const char **argv)
> +               if (skip_prefix(arg, "--log-destination=", &v)) {
> +                       if (!strcmp(v, "syslog")) {
> +                               log_destination = LOG_DESTINATION_SYSLOG;
> +                               continue;
> +                       } else if (!strcmp(v, "stderr")) {
> +                               log_destination = LOG_DESTINATION_STDERR;
> +                               continue;
> +                       } else if (!strcmp(v, "none")) {
> +                               log_destination = LOG_DESTINATION_NONE;
> +                               continue;
> +                       } else
> +                               die("Unknown log destination %s", v);

Mentioned previously[1], this probably ought to start with lowercase.
It also would be more readable to set off the unknown value with a
colon or quotes:

    die("unknown log destination '%s', v);

> @@ -1402,7 +1426,14 @@ int cmd_main(int argc, const char **argv)
> -       if (log_syslog) {
> +       if (log_destination == LOG_DESTINATION_UNSET) {
> +               if (inetd_mode || detach)
> +                       log_destination = LOG_DESTINATION_SYSLOG;
> +               else
> +                       log_destination = LOG_DESTINATION_STDERR;
> +       }
> +
> +       if (log_destination == LOG_DESTINATION_SYSLOG) {
>                 openlog("git-daemon", LOG_PID, LOG_DAEMON);
>                 set_die_routine(daemon_die);

[1]: https://public-inbox.org/git/CAPig+cTetjQ9LSH68Fe5OTcj9TwQ9GSbGzdrjzHOhTAVFvrPxw@mail.gmail.com/
