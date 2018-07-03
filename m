Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194141F516
	for <e@80x24.org>; Tue,  3 Jul 2018 07:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeGCHa5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 03:30:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35660 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753554AbeGCHaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 03:30:55 -0400
Received: by mail-ua0-f196.google.com with SMTP id q12-v6so604484ual.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X+32m/aOEscOJ1wFOlgwGr3rtf1zxCQ703WflXvPMcA=;
        b=sFadG/UQCs5SaDlUshnYYAefUmMpHjsXMz3bWykoUyIlwbvarop4t96IndgULutlXn
         3Tislh/b3rpRJQBbtiDDFUUewZYc6XnPyR/RT23ZOPIQhFBu2WZ6kyczEjuskbqw7PtS
         6E2JxBFPHYLdAgcLMtdSlpRhH3zfgHaJ3gFunWBOTT3LLYWFrLHqIwbgH83du/hAPBdV
         GEcgjSU3lOpDpOOfnazQA4plMPBSuTQoRtsC5rLTA/TtU6yXz5bFXP32gI43zPnZtCW2
         7S+/ajQv7grENpfgwc15WEc+/5Geu59tsft2TmNEynU+NyeKxzQPC8qdQKgs4Alnl6HL
         MVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X+32m/aOEscOJ1wFOlgwGr3rtf1zxCQ703WflXvPMcA=;
        b=jrOuyi25KCi4Q+MCh+XgnAS9/WLfarlVsnh2PJ+rhKlVuGWLiH970snQiIY642XNvL
         m8w/tzXYS2ELRwIsDL6DFPEOFmPwQXRDRNFqIrDkLUlpTbLzZ7EAnZpkWOobzm1nHcRs
         +xnpsRYbcKoRY+S0VBhAv22uGiEVEwLOo/4lF55INCkEYHnN2u0tP2auMadnm1a2KPeX
         joo4q/q18n08oM4QMIG063UroxQiwfHjscnWTvKkFdZjshxisegohWEbE9sWHO/ehTTh
         O4slw9LpmuucAkOECH5MONnkTE2fKmPXWNM/RL4ADLKd5jzA+VYsEM1Cv94pYdNXDkT5
         169Q==
X-Gm-Message-State: APt69E2QE1sgpw6dik84B4UADuXHAPD4FniVgr20+/j3NjrFU4pX92/J
        VaL+Ta/GcGYLEy+tz6BGQC97qEBk2duLW2DjXYg=
X-Google-Smtp-Source: AAOMgpcnd2BeyHmlLCe8IC+V8XkOShQfPm+vT7YQ0Nx9MB4e970t0JH67wkf+d17i2+O/jpxYJgr5yumDBlzQ7h0dfU=
X-Received: by 2002:a9f:3666:: with SMTP id s35-v6mr8217221uad.94.1530603055018;
 Tue, 03 Jul 2018 00:30:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:30:54 -0700 (PDT)
In-Reply-To: <20180703035802.24060-3-jyn514@gmail.com>
References: <20180703035802.24060-1-jyn514@gmail.com> <20180703035802.24060-3-jyn514@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Jul 2018 00:30:54 -0700
Message-ID: <CABPp-BG95d4uWa_86qu5oVK9sYuVtDP3gv1JH4KXdzvMy0h_dA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ls-tree: add unit tests for arguments
To:     Joshua Nelson <jyn514@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joshua,

On Mon, Jul 2, 2018 at 8:58 PM, Joshua Nelson <jyn514@gmail.com> wrote:

The commit message could use some clarification; it currently makes
the reader think you're testing all arguments of ls-tree, when you're
only testing a few new ones.  Alternatively, you could squash this
with patch 1.

> Signed-off-by: Joshua Nelson <jyn514@gmail.com>
> ---
>  t/t3104-ls-tree-optional-args.sh | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 t/t3104-ls-tree-optional-args.sh

Please note that test files should be executable, not regular files.

>
> diff --git t/t3104-ls-tree-optional-args.sh t/t3104-ls-tree-optional-args.sh
> new file mode 100644
> index 000000000..5917563a7
> --- /dev/null
> +++ t/t3104-ls-tree-optional-args.sh
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +
> +test_description='ls-tree test (optional args)
> +
> +This test tries to run git-ls-tree with various combinations of options.'

This description seems like it's true for all the t310*.sh tests.  How
does t3104 differ from t310[0-3]*.sh?

> +
> +. ./test-lib.sh
> +
> +test_expect_success 'initial setup' '
> +echo hi > test && cp test test2 && git add test test2 && git commit -m initial'
> +
> +# cat appends newlines after every file

What is this comment in reference to?

> +test_expect_success 'succeed when given no args' 'git ls-tree'
> +
> +test_expect_success 'succeed when given only --' 'git ls-tree'

I was a little surprised that these tests only check that the command
runs to completion with a 0 exit status, and do not do any
verification of the output.  I wasn't necessarily expected full output
verification, but having a few different commits and searching for
something that'd only be shown in the relevant commit would be nice.

> +
> +test_expect_success 'add second commit' '
> +echo hi > test3 && git add test3 && git commit -m "commit 2"'
> +
> +test_expect_success 'succeed when given revision' '
> +git ls-tree HEAD~1'
> +
> +test_expect_success 'succeed when given revision and --' '
> +git ls-tree HEAD~1 --'
> +
> +test_expect_success 'succeed when given -- and file' '
> +git ls-tree -- test3'
> +
> +test_expect_success 'do nothing when given bad files' '
> +git ls-tree -- bad_files'

...and to reiterate the point above about verifying the output is
correct, how is 'doing nothing' here distinguishable from showing all
the files in the current commit if you're not checking any part of the
output?

> +
> +test_expect_success 'succeed when given file from past revision' '
> +git ls-tree HEAD~1 test'
> +
> +test_expect_success 'succeed when given only file' 'git ls-tree test'
> +
> +test_expect_success 'raise error when given bad args' '
> +test_must_fail  git ls-tree HEAD HEAD --'
> +
> +test_expect_success 'raise error when given bad revision' '
> +test_must_fail git ls-tree bad_revision --'
> +
> +test_done
> --
> 2.18.GIT

Lots of little things to fix up, but you're off to a great start.  I'm
excited to be able to have ls-tree work without me having to specify
HEAD all the time.  :-)
