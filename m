Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320B31F404
	for <e@80x24.org>; Wed, 28 Feb 2018 02:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeB1Cab (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 21:30:31 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42736 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeB1Caa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 21:30:30 -0500
Received: by mail-ua0-f196.google.com with SMTP id b23so593232uak.9
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 18:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TgcWtzH8c/MMV1q8hZO/sJ1bo5fHPlls/G9szDOd0Tw=;
        b=UhdQP+Y7bz8CkPIdPFvhKwBx4x5+JSsFN3INF0YIhRdK9WdMqZxzzFcViiOIykJIFK
         WclAB+FZYeTGawZyTsHcwEmbKJw0UDgBfw+Pezl6QK9nKOsuycOpedjbFjUf1MyHIhZV
         AZjvXB5s+XCIBA5mT3+DampqVRQrVbV1RtkvNDujZ4XPNsoLfbj+1lg59MUhzVq0rnaU
         grrgcUAJuspCv4aNYgm7Okx3cQO+wlGf2HXiQNfVrFm3jfC/942HpJ3dmbNgPx8AdPUh
         fgIpodiEIzF4Re7YXH8PECVrP2sgu7a8gjQ2AHtVFenpz9Ezlgdb2uoDcTMAZe2FE7g4
         +NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TgcWtzH8c/MMV1q8hZO/sJ1bo5fHPlls/G9szDOd0Tw=;
        b=XJKIs8oPrcgvBfdG+AhnjcyjvnJaFqVHC+EH/+u7Dn6xdXh0NvDx1Il2uBR7HFIKP7
         N0oUD5fqGPYS5zB1O5t6HMcBNTW4ru3Jpr0Bx59nN5Yd61UaxpYxNZEcGMsbHb9L55SW
         Jw1INcSvn4E0JbracMoQxpyutn9dK+zaOR4jXDNsHet26VuqjHJaCZJy1+XPGCiT6RLz
         PYj+QEE+GedUSXGSwe1VRR2xpezac9p2YRXEWn18+MikUlKrLoDbmzcPp0WJXRM0HLcz
         AdLqZTK9ocvEAMGn+7G0WfSlTcsZnYwlF+wKwfuUVv7OJCE0izLlkgOPgtm1XO5B+XV6
         YI+w==
X-Gm-Message-State: APf1xPCLHxSaQ9jIwF0Xtyifc3LR4GrLQR3e7v3YwXFM0YQM/h4CB5p1
        FNyAgG6J27nffg58YDukHYehsY8aoXOziqE5udM=
X-Google-Smtp-Source: AG47ELs9sH0SHmOiNzjocDWnPzRNF+L1SN8yPBNe3yuwbKzoadTIAjNgIbc4A/7SY4spDm9ODiBDLeuJVAIuvIvoVko=
X-Received: by 10.159.59.229 with SMTP id y37mr11049025uah.48.1519785029980;
 Tue, 27 Feb 2018 18:30:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Tue, 27 Feb 2018 18:30:29 -0800 (PST)
In-Reply-To: <20180222064836.GA10719@sigill.intra.peff.net>
References: <20180222064836.GA10719@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 28 Feb 2018 03:30:29 +0100
Message-ID: <CAM0VKjmtHEGmDi8x_AC8JoNj7rtcanSJX1n0b-f1CEX04Xn8CA@mail.gmail.com>
Subject: Re: [PATCH] t: send verbose test-helper output to fd 4
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 7:48 AM, Jeff King <peff@peff.net> wrote:
> This is a repost of the two patches from:
>
>   https://public-inbox.org/git/20180209185710.GA23403@sigill.intra.peff.net/
>
> (now just one patch, since sg/test-i18ngrep graduated and we can do it
> all in one step). The idea got positive feedback, but nobody commented
> on patches and I didn't see them in "What's cooking".
>
> -- >8 --
> Test helper functions like test_must_fail may produce
> messages to stderr when they see a problem. When the tests
> are run with "--verbose", this ends up on the test script's
> stderr, and the user can read it.
>
> But there's a problem. Some tests record stderr as part of
> the test, like:
>
>   test_must_fail git foo 2>output &&
>   test_i18ngrep expected.message output
>
> In this case the error text goes into "output". This makes
> the --verbose output less useful (it also means we might
> accidentally match it in the second, though in practice we
> tend to produce these messages only on error, so we'd abort
> the test when the first command fails).
>
> Let's instead send this user-facing output directly to
> descriptor 4, which always points to the original stderr (or
> /dev/null in non-verbose mode). And it's already forbidden
> to redirect descriptor 4, since we use it for BASH_XTRACEFD,
> as explained in 9be795fbce (t5615: avoid re-using descriptor
> 4, 2017-12-08).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib-functions.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 67b5994afb..aabee13e5d 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -625,22 +625,22 @@ test_must_fail () {
>         exit_code=$?
>         if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
>         then
> -               echo >&2 "test_must_fail: command succeeded: $*"
> +               echo >&4 "test_must_fail: command succeeded: $*"
>                 return 1
>         elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sigpipe
>         then
>                 return 0
>         elif test $exit_code -gt 129 && test $exit_code -le 192
>         then
> -               echo >&2 "test_must_fail: died by signal $(($exit_code - 128)): $*"
> +               echo >&4 "test_must_fail: died by signal $(($exit_code - 128)): $*"
>                 return 1
>         elif test $exit_code -eq 127
>         then
> -               echo >&2 "test_must_fail: command not found: $*"
> +               echo >&4 "test_must_fail: command not found: $*"
>                 return 1
>         elif test $exit_code -eq 126
>         then
> -               echo >&2 "test_must_fail: valgrind error: $*"
> +               echo >&4 "test_must_fail: valgrind error: $*"
>                 return 1
>         fi
>         return 0
> @@ -678,7 +678,7 @@ test_expect_code () {
>                 return 0
>         fi
>
> -       echo >&2 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
> +       echo >&4 "test_expect_code: command exited with $exit_code, we wanted $want_code $*"
>         return 1
>  }

The parts above changing the fds used for error messages in
'test_must_fail' and 'test_expect_code' will become unnecessary if we
take my patch from

  https://public-inbox.org/git/20180225134015.26964-1-szeder.dev@gmail.com/

because that patch also ensures that error messages from this function
will go to fd 4 even if the stderr of the functions is redirected in the
test.  Though, arguably, your patch makes it more readily visible that
those error messages go to fd 4, so maybe it's still worth having.

> @@ -742,18 +742,18 @@ test_i18ngrep () {
>                 shift
>                 ! grep "$@" && return 0
>
> -               echo >&2 "error: '! grep $@' did find a match in:"
> +               echo >&4 "error: '! grep $@' did find a match in:"
>         else
>                 grep "$@" && return 0
>
> -               echo >&2 "error: 'grep $@' didn't find a match in:"
> +               echo >&4 "error: 'grep $@' didn't find a match in:"
>         fi
>
>         if test -s "$last_arg"
>         then
> -               cat >&2 "$last_arg"
> +               cat >&4 "$last_arg"
>         else
> -               echo >&2 "<File '$last_arg' is empty>"
> +               echo >&4 "<File '$last_arg' is empty>"
>         fi
>
>         return 1
> @@ -764,7 +764,7 @@ test_i18ngrep () {
>  # not output anything when they fail.
>  verbose () {
>         "$@" && return 0
> -       echo >&2 "command failed: $(git rev-parse --sq-quote "$@")"
> +       echo >&4 "command failed: $(git rev-parse --sq-quote "$@")"
>         return 1
>  }

I'm not so sure about these changes to 'test_18ngrep' and 'verbose'.  It
seems that they are the result of a simple s/>&2/>&4/ on
'test-lib-functions.sh'?  The problem described in the commit message
doesn't really applies to them, because their _only_ output to stderr
are the error messages intended to the user, so no sane test would
redirect and check their stderr.  (OK, technically the command run by
'verbose' could output anything to stderr, but 'verbose' was meant for
commands failing silently in the first place; that's why my patch linked
above left 'verbose' unchanged.)

Also note that there are a lot of other test helper functions that
output something primarily intended to the user on failure (e.g.
'test_path_is_*' and the like), though those messages go stdout instead
of stderr.  Perhaps the messages of those functions should go to stderr
as well (or even fd 4)?
