Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7DC1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 21:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeDEVQ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 17:16:26 -0400
Received: from mail-ua0-f181.google.com ([209.85.217.181]:37928 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDEVQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 17:16:21 -0400
Received: by mail-ua0-f181.google.com with SMTP id q38so16367911uad.5
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 14:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8qAVPoEO0WAOq5EkHCck5v5H9xV7DevLEFz4W3E+BTQ=;
        b=AUxJNEXCgWgyQa4DlcyWTZWwFOzcrffwym7MvG5CqdF2/lvr2h7P73cVihQRZEqFFI
         RkAQQY5uL+HfxMrIyDMU/HJmVlZcZJ7lFGA1CFBvK87fsLEO40Cbkc0rBGjfp0y2/C/N
         G/ldcAebAbZ4UMEi31H5CfvhJR+WV+LXDDkZgZ96YkP/LNXSMU0TsmHpny3tPjVnnpia
         MBSUTFq4MkiaMua4ZP0UKRy+PN9z1zdt/OceIsnQD5OgCH08feB/eCTK1qrv/HCF0Hqq
         r5NbwrkWwbVr1q4W69YeP/XLZ31AbK+hl+/L+20DUd+OAxM9uoobCdvhTh+5tSq2rPeE
         13Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8qAVPoEO0WAOq5EkHCck5v5H9xV7DevLEFz4W3E+BTQ=;
        b=GivRvzcdrSY4wOFv/ECP95ksV0ky/lsOSKLOqrlzvDm388/DFN6e3jl/CAfkoacYdc
         pvq2zRR9R/0xnsmpKJaStS0V4vRs0Y9sOd3Hw/NMv5FsB0G1kVzHyA1hG2mjUf1B3jEQ
         SeIJpG0VSAVgfzHIbyXpgdlJWWkNmzX7c8YZ6R/IZny/O+1R78EG4mu0yS8odSr9yncR
         3S9KDcz97MZsC6rty8t74zcMc46+myWCH+BzHEDfmKyFkSpX7deBLKvZn5PYBkDRQJng
         Bx6I2ZImc/PHkP9FpOhz+UcxOnNV5VHMgYHWepSPbaenk4X22ScU9PXdZ473SrlBJv/2
         7frA==
X-Gm-Message-State: ALQs6tD2mIAsfl+l0CNnA6aSwlNDf+Q2DrnYxdRbNQjvXRzAK6Fpq28+
        bCpW/mzmLMUBsnPy/VKqfhzdzNCHBrDD7utf2ks=
X-Google-Smtp-Source: AIpwx49qo6z9fYSih83NoHAOFoNXfzSsRMwDlqsYe1Ofu4uDaxZt3fBbjcvb/FmD3drjtr2p7wSWPis+VvAS9Rh4TUw=
X-Received: by 10.176.90.38 with SMTP id l35mr15542495uad.79.1522962980260;
 Thu, 05 Apr 2018 14:16:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Thu, 5 Apr 2018 14:16:19 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804052144310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com> <nycvar.QRO.7.76.6.1804052144310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 5 Apr 2018 14:16:19 -0700
Message-ID: <CABPp-BHhdxuV9a_4OfgaRu89Kx2039OLeS1vW-KdzpLxb-ZF3g@mail.gmail.com>
Subject: Re: [PATCH] Make running git under other debugger-like programs easy
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Thu, Apr 5, 2018 at 12:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I wonder whether a better approach would be to add an optional argument to
> that `debug` function (which is intended to have `git` as first argument,
> anyway, or at least a command/function that does not start with a dash):
>
> debug_aux () {
>         shift
>         "$@" <&6 >&5 2>&7
> }
>
> debug () {
>         case "$1" in
>         -d)
>                 shift &&
>                 GIT_TEST_GDB="$1" debug_aux "$@"
>                 ;;
>         --debugger=*)
>                 GIT_TEST_GDB="${1#*=}" debug_aux "$@"
>                 ;;
>         *)
>                 GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
>                 ;;
>         esac
> }
>
> ... and then in wrap-for-bin.sh, we would replace the last lines
>
> if test -n "$GIT_TEST_GDB"
> then
>         unset GIT_TEST_GDB
>         exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> else
>         exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> fi
>
> by
>
> case "$GIT_TEST_GDB" in
> '')
>         exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
>         ;;
> 1)
>         unset GIT_TEST_GDB
>         exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
>         ;;
> *)
>         GIT_TEST_GDB_$$="$GIT_TEST_GDB"
>         unset GIT_TEST_GDB
>         exec $GIT_TEST_GDB_$$ "${GIT_EXEC_PATH}/@@PROG@@" "$@"
>         ;;
> esac
>
> or some such.

That all looks great to me.  But at this point, it seems like it's a
full rewrite and your patch to submit (which I'd be happy to endorse
in lieu of my own)...or do you want me to submit with you as author
and me as committer?

Also, a side question: if we go this route, do we want to rename
GIT_TEST_GDB to reflect its expanded usage?

> Then your magic "GIT_WRAPPER" invocation would become a bit more explicit:
>
>     debug --debugger=nemiver git $ARGS
>     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS

No, for most (60-80%?) of my invocations, I wouldn't be able to use
the debug function; only a minority of my uses are from within the
testsuite.  The rest are from the command line (I have
git/bin-wrappers/ in my $PATH), so the above suggestions would mean
that my invocation would become:

GIT_TEST_GDB="nemiver" git $ARGS
GIT_TEST_GDB="valgrind --tool-memcheck --track-origins=yes" git $ARGS

> (In any case, "GIT_WRAPPER" is probably a name in want of being renamed.)

Well, with your suggestion, it'd just be whatever that environment
variable is named.  I'm perfectly happy with something other than
GIT_WRAPPER (or GIT_TEST_GDB).  I'm not so good at coming up with such
myself, but maybe something like GIT_DEBUGGER or GIT_DEBUG_WITH?

Thanks,
Elijah
