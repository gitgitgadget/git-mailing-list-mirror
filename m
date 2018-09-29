Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36C8F1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeI2ViK (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 17:38:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54280 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbeI2ViK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 17:38:10 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so571360ita.4
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rOx3bZdnV2AcK4T6z1CGJforBZASd9zwHPR5Yjb8ABc=;
        b=nxUc+ATmXYgS2rRIqZ7mRj4G4HSslsP8DWYwrj4oqji0S/eUdV5EFlqOCT/sMzilDO
         W3mptRH71rA5eOGYyatLUWt2aEQ2SV/9Zifwxy1F2L7a3Z/YqhZ0tc9t4fFTcp/iM99Y
         Tex4Fsc32VfshesZZdzsI+/ZW8q4Cn/Tc18dSnnRreWIdAYEBrP2bNRklF5WWoVdOTh7
         6vBboFM2GUIhrC/rZFTWqEMLnMa1QNsCHw9y42h1MlFpIDgLvihCgYvyK2Zag2DjzzTs
         ZfjRBN53auI2uzHkTIMiRLY0jmSgYKkIQKWe7vAt8MMRHbpJNB8Ks922oO3tid3rFytk
         uXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rOx3bZdnV2AcK4T6z1CGJforBZASd9zwHPR5Yjb8ABc=;
        b=bfwypoo7L5V7Lt43EYw9+37umkkE1SeshnHxlrWSGPaWryU5xThqXBjNyV2O/7EOOt
         NAHMMR/VFAOnOOZIKZX54RZb/LmxXIkDShOI0Nw5OI0zPdBnH+EL/PVJaggo0HCrFTuM
         odNne0Z+OVCaAd4AiAJRZ+I9nfgClCwWCsE6iUaApok+RNIFgykVFdVN+sZHrrzN7Xj/
         mw3ifB4l70l7D5Va6v+waunNotPti5ORAJKjrLcsAhYqzUvKgV1GKLxZfGwnTAD2lOV/
         NTYKYVK9ANSIP2AnkTkdqN4pIbJsu2zf4mQYOGSQS2Q1ohgIdLoqz8Wq0tSiuAiGjgWa
         qSgg==
X-Gm-Message-State: ABuFfojO1IAfgQYPZN1NCJ0/+CyNAptyeaUxJD3yr1oQEKJMQcCWtgUW
        Mih77YmUa9/UD0u0d3rdt0O7IQvCn+P81DhzeLY=
X-Google-Smtp-Source: ACcGV61vcj0ZCmqEZM20R7/b+t55UzHcY/oBvJ2tNpWtMm7lz+y6tYEae1NLnZ7/5UCSiUAf3XUU88Uh06MHuhXv9+o=
X-Received: by 2002:a02:49d7:: with SMTP id p84-v6mr2573533jad.97.1538233762982;
 Sat, 29 Sep 2018 08:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180929140132.GA31238@msg.df7cb.de> <20180929145527.23444-1-avarab@gmail.com>
In-Reply-To: <20180929145527.23444-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Sep 2018 17:08:56 +0200
Message-ID: <CACsJy8A6MqAmSZ=bhatX0MZTWRjR9Ci9h9NhJEshtpmqpHr4JA@mail.gmail.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, myon@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 4:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This --recursive (-r) option does nothing, and is purely here to
> appease people who have "grep -r ..." burned into their muscle memory.

GNU grep -r recurses infinitely but Git grep also has --max-depth. How
do these interact? My knee-jerk reaction is -r equals --max-depth=3D-1
(i.e. overriding previous --mex-depth options on command line, or from
alias)

> Requested-by: Christoph Berg <myon@debian.org>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> On Sat, Sep 29, 2018 at 4:10 PM Christoph Berg <myon@debian.org> wrote:
> >
> > I often use "grep -r $pattern" to recursively grep a source tree. If
> > that takes too long, I hit ^C and tag "git" in front of the command
> > line and re-run it. git then complains "error: unknown switch `r'"
> > because "git grep" is naturally recursive.
> >
> > Could we have "git grep -r" accept the argument for compatibility?
> > Other important grep switches like "-i" are compatible, adding -r
> > would improve usability.
>
> I don't have an opinion on this either way, it doesn't scratch my
> itch, but hey, why not. Here's a patch to implement it.
>
>  Documentation/git-grep.txt | 6 ++++++
>  builtin/grep.c             | 3 +++
>  t/t7810-grep.sh            | 8 ++++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index a3049af1a3..a1aea8be4e 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -290,6 +290,12 @@ providing this option will cause it to die.
>         Do not output matched lines; instead, exit with status 0 when
>         there is a match and with non-zero status when there isn't.
>
> +-r::
> +--recursive::
> +       This option does nothing. git-grep is always recursive. This
> +       noop option is provided for compatibility with the muscle
> +       memory of people used to grep(1).
> +
>  <tree>...::
>         Instead of searching tracked files in the working tree, search
>         blobs in the given trees.
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 601f801158..02d4384225 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -785,6 +785,7 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
>         int use_index =3D 1;
>         int pattern_type_arg =3D GREP_PATTERN_TYPE_UNSPECIFIED;
>         int allow_revs;
> +       int unused_recursive; /* this is never used */
>
>         struct option options[] =3D {
>                 OPT_BOOL(0, "cached", &cached,
> @@ -802,6 +803,8 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
>                         N_("show non-matching lines")),
>                 OPT_BOOL('i', "ignore-case", &opt.ignore_case,
>                         N_("case insensitive matching")),
> +               OPT_BOOL('r', "recursive", &unused_recursive,
> +                       N_("does nothing, git-grep is always recursive, f=
or grep(1) muscle memory compatibility")),
>                 OPT_BOOL('w', "word-regexp", &opt.word_regexp,
>                         N_("match patterns only at word boundaries")),
>                 OPT_SET_INT('a', "text", &opt.binary,
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index be5c1bd553..c48d1fa34b 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -469,6 +469,14 @@ do
>                 git grep --count -h -e b $H -- ab >actual &&
>                 test_cmp expected actual
>         '
> +
> +       for flag in '' ' -r' ' --recursive'
> +       do
> +               test_expect_success "grep $flag . (testing that --recursi=
ve is a noop)" '
> +                       git grep$flag . >actual &&
> +                       test_line_count =3D 43 actual
> +       '
> +       done
>  done
>
>  cat >expected <<EOF
> --
> 2.19.0.605.g01d371f741
>


--=20
Duy
