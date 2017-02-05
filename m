Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7501FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 14:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdBEOz1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 09:55:27 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33876 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdBEOz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 09:55:26 -0500
Received: by mail-it0-f66.google.com with SMTP id o185so6059149itb.1
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8TfX9nsYwmZz0r8e4tOnImlg1xEj9P4+qaPSI+8DhO4=;
        b=GS5Pyu6CiJ5GiPeYoA0ZJaOW8b+UyacC7cXWY13ClKWuiqdWEGMrnzVmVanNkqWzsA
         CTXRNO4E1W3AErEutPAtdOZgJNaCoxOGpO5zvY8mfuMg8tNXuXSFq9lBhiP4+1poKTWT
         otcZfymecz+5HNQXjAyJmFaCqVXop9Iv3WzvCFrjC6cgFD14ZtprWOJTJUT8Z4au+azV
         dKC2gujs4d2ZdabVVpt9QCzwaP1krqSvHQXFR7W9jWmA4Gx34nqdpv1ggU3cGumrfmQE
         RijMT8v7N1Z7VgnBrPvLc5AvpG+65p7OfVGKf8jGCbg/N/+SkANpCAaCGzHRwS0B7hlH
         gJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8TfX9nsYwmZz0r8e4tOnImlg1xEj9P4+qaPSI+8DhO4=;
        b=T+xlcmr4PCsevT1VpxzRzVDRAFuKSpb+2dwWXm5gABnhKUuEcO/RuGPcVCfBCaPWeJ
         zoKQTc7vSXzgsumbIvMLcJi6FD7AwKa6FSj7M+IMNfvL6hIfZ0mPFhkBlhhmuMXpG2cv
         2LUXUIQXhQgLWAVWCGYHczYtfc9ZLSakxi2wYE+ltC3SoudgbS0WRoqGZyYR3fJNuXN+
         q+Ngnxe2+bUW3LICMKaUJEX7FIVtTeghpKLtuIiQipiDaxRXtM/zp79/KJu08liycMnK
         ynF9Js9OnHV2thEML812fDNtq1aCjWFBKkC1XnFZYnNeNQoUSvSBZk49+D1PRFs2PVC8
         DwjQ==
X-Gm-Message-State: AIkVDXJnQ/i9F2n6Tm6Q+bfF+9dq5eMUgQLV+QjpG/a2FOkusVn8RZPM1YoSn5s3V/ArHSWa2WDkD38GhDVxXA==
X-Received: by 10.36.116.71 with SMTP id o68mr4547069itc.60.1486306525493;
 Sun, 05 Feb 2017 06:55:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sun, 5 Feb 2017 06:55:25 -0800 (PST)
In-Reply-To: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 5 Feb 2017 20:25:25 +0530
Message-ID: <CAFZEwPOFPPyui=9mnccbOc-79q0URYhdGHSkcd0YyR6qe-c_zQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Siddharth,

On Sun, Feb 5, 2017 at 6:27 PM, Siddharth Kannan
<kannan.siddharth12@gmail.com> wrote:
> Search and replace "-" (written in the context of a branch name) in the argument
> list with "@{-1}". As per the help text of git rev-list, this includes the following four
> cases:
>
>   a. "-"
>   b. "^-"
>   c. "-..other-branch-name" or "other-branch-name..-"
>   d. "-...other-branch-name" or "other-branch-name...-"
>
> (a) and (b) have been implemented as in the previous implementations of
> this abbreviation. Namely, 696acf45 (checkout: implement "-" abbreviation, add
> docs and tests, 2009-01-17), 182d7dc4 (cherry-pick: allow "-" as
> abbreviation of '@{-1}', 2013-09-05) and 4e8115ff (merge: allow "-" as a
> short-hand for "previous branch", 2011-04-07)
>
> (c) and (d) have been implemented by using the strbuf API, growing it to the
> right size and placing "@{-1}" instead of "-"
>
> Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
> ---
> This is a patch for one of the microprojects of SoC 2017. [1]
>
> I have implemented this using multiple methods, that I have re-written again and
> again for better versions ([2]). The present version I feel is the closest that
> I could get to the existing code in the repository. This patch only uses
> functions that are commonly used in the rest of the codebase.
>
> I still have to write tests, as well as update documentation as done in 696acf45
> (checkout: implement "-" abbreviation, add docs and tests, 2009-01-17).
>
> I request your comments on this patch. Also, I have the following questions
> regarding this patch:
>
> 1. Is the approach that I have used to solve this problem fine?
> 2. Is the code I am writing in the right function? (I have put it right
> before the revisions data structure is setup, thus these changes affect only
> git-log)
>
> [1]: https://git.github.io/SoC-2017-Microprojects/
> [2]: https://github.com/git/git/compare/6e3a7b3...icyflame:7e286c9.patch (Uses
> strbufs for the starting 4 characters, and last 4 characters and compares those
> to the appropriate strings for case (c) and case (d). I edited this patch to use
> strstr instead, which avoids all the strbuf declarations)
>
>  builtin/log.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 55d20cc..a5aac99 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -132,7 +132,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>                          struct rev_info *rev, struct setup_revision_opt *opt)
>  {
>         struct userformat_want w;
> -       int quiet = 0, source = 0, mailmap = 0;
> +       int quiet = 0, source = 0, mailmap = 0, i = 0;
>         static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
>
>         const struct option builtin_log_options[] = {
> @@ -158,6 +158,51 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>
>         if (quiet)
>                 rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
> +
> +       /*
> +        * Check if any argument has a "-" in it, which has been referred to as a
> +        * shorthand for @{-1}.  Handles methods that might be used to list commits
> +        * as mentioned in git rev-list --help
> +        */
> +
> +       for(i = 0; i < argc; ++i) {
> +               if (!strcmp(argv[i], "-")) {
> +                       argv[i] = "@{-1}";
> +               } else if (!strcmp(argv[i], "^-")) {
> +                       argv[i] = "^@{-1}";
> +               } else if (strlen(argv[i]) >= 4) {
> +
> +                       if (strstr(argv[i], "-...") == argv[i] || strstr(argv[i], "-..") == argv[i]) {
> +                               struct strbuf changed_argument = STRBUF_INIT;
> +
> +                               strbuf_addstr(&changed_argument, "@{-1}");
> +                               strbuf_addstr(&changed_argument, argv[i] + 1);
> +
> +                               strbuf_setlen(&changed_argument, strlen(argv[i]) + 4);
> +
> +                               argv[i] = strbuf_detach(&changed_argument, NULL);
> +                       }
> +
> +                       /*
> +                        * Find the first occurence, and add the size to it and proceed if
> +                        * the resulting value is NULL
> +                        */
> +                       if (!(strstr(argv[i], "...-") + 4)  ||
> +                                       !(strstr(argv[i], "..-") + 3)) {
> +                               struct strbuf changed_argument = STRBUF_INIT;
> +
> +                               strbuf_addstr(&changed_argument, argv[i]);
> +
> +                               strbuf_grow(&changed_argument, strlen(argv[i]) + 4);
> +                               strbuf_setlen(&changed_argument, strlen(argv[i]) + 4);
> +
> +                               strbuf_splice(&changed_argument, strlen(argv[i]) - 1, 5, "@{-1}", 5);
> +
> +                               argv[i] = strbuf_detach(&changed_argument, NULL);
> +                       }
> +               }
> +       }
> +
>         argc = setup_revisions(argc, argv, rev, opt);
>
>         /* Any arguments at this point are not recognized */
> --


It is highly recommended to follow the pre existing style of code and
commits. In the micro project list, I think it is mentioned that this
similar thing is implemented in git-merge so you should try and dig
the commit history of that file to find the similar change.

If you do this, then you will find out that there is a very short and
sweet way to do it. I won't directly point out the commit.

strbuf API should be used when you need to modify the contents of the
string. I think you have a little confusion.

If you declare the string as,

const char *str = "foo";

then, you can also do,

str = "bar";

But you can't do,

str[1] = 'z';

I hope you get what I am saying, if not, search for it.

Regards,
Pranit Bauva
