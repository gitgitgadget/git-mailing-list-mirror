Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A89B1FC44
	for <e@80x24.org>; Mon,  8 May 2017 17:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754908AbdEHRNn (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 13:13:43 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34527 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754846AbdEHRNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 13:13:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id u28so26305229pgn.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/HZvF4ho0sQ9ltqmxrRQpgPaIsl5PcMSoQKRISoZvS4=;
        b=fWMZ9QNP2wWYBNgaEEh9tyvtmxDZFvsZplsvP92WKfuEc69knyR8FuY2KIM+DlStNK
         41fVGaL7kIAv4hjguhLybYLqsYwtqyyXkkxNZMq/i2UMwdXNcUNTFzoI78VHIdJpC1q9
         LhBtIaRCayHP3xfMQ0XupOUUhXabY7jNcBlO+x+wTK3ZX1ggoSwA3ZsH0uIVPofelRsy
         93vGNHeZbjCNOVdU1q1ZuNPyuXOv1ypyHJPeNzyVyfelu5a7RDFw6hZjuLwjpD036qDf
         WiuBTOY2kISWuShBV4pQhYJOg0G3ZgxsADBTscSg6dOaIFQ+2XtIrqcbWFqVx3vrc1nk
         ltlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/HZvF4ho0sQ9ltqmxrRQpgPaIsl5PcMSoQKRISoZvS4=;
        b=kIdMurv63oPga8PR+uQc5J715MCYQfszgEzcq+cNGBM3sx84CGtshW6COVn3wS3ZzZ
         xNvTdAVO5lCCBRdcVcbEfsHb6BvNMk7elc6+LJBJwAuc42G1QqJn5ntiXYjMtFiw+xYu
         asHHuw/x2riFEWmBedXO3O3J5jNBhNsnnDH56LmEfVkCAN5yJN9KoKYsMIMzC0Zgd/tp
         MLbAimCo/yFyuVaLryQyLx/a31PCHvlqA19sGmHhS748neirFGbQC5buC1D8qSH79kaJ
         7CJWfEZbugJYDmPxdnVw98SIScVKFfQHowqEA+3E8ZUpF7WQ7B+JWV7qppRAusexIUkb
         k6KQ==
X-Gm-Message-State: AN3rC/4Ti3rtblws9KYYxkKavoTsnyl1gy6n5LY2CtXptfuFJJhz3OH6
        9juXz24TAaUpoiZoNE+xHrGJv6r3+WgqBlQ=
X-Received: by 10.99.56.66 with SMTP id h2mr19971057pgn.40.1494263621668; Mon,
 08 May 2017 10:13:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 10:13:41 -0700 (PDT)
In-Reply-To: <20170508160339.4551-1-marcnarc@xiplink.com>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com> <20170508160339.4551-1-marcnarc@xiplink.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 10:13:41 -0700
Message-ID: <CAGZ79kbLKQ0jS0xfQO1MSp5T2_m9dShx0oYeTDAjDdUcydm3uQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Make diff plumbing commands respect the indentHeuristic.
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 9:03 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> The only change from v3 is in 3/4, to expand t4061 to test various
> combinations of --(no-)indent-heuristic and diff.indentHeuristic.
>
> I kindof went all-in and tried to cover every possible combination for
> all four affected commands.
>
> An inter-diff is below.
>
>                 M.
>
> Jeff King (1):
>   add--interactive: drop diff.indentHeuristic handling
>
> Marc Branchaud (2):
>   diff: make the indent heuristic part of diff's basic configuration
>   diff: have the diff-* builtins configure diff before initializing
>     revisions
>
> Stefan Beller (1):
>   diff: enable indent heuristic by default
>
>  builtin/diff-files.c             |   2 +-
>  builtin/diff-index.c             |   2 +-
>  builtin/diff-tree.c              |   2 +-
>  diff.c                           |   8 +-
>  git-add--interactive.perl        |   4 -
>  t/t4051-diff-function-context.sh |   3 +-
>  t/t4061-diff-indent.sh           | 184 +++++++++++++++++++++++++++++++++++----
>  7 files changed, 177 insertions(+), 28 deletions(-)
>
>
> diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
> index 56d7d7760..2affd7a10 100755
> --- a/t/t4061-diff-indent.sh
> +++ b/t/t4061-diff-indent.sh
> @@ -152,26 +152,28 @@ test_expect_success 'prepare' '
>         EOF
>  '
>
> +# --- diff tests ----------------------------------------------------------
> +
>  test_expect_success 'diff: ugly spaces' '
>         git diff --no-indent-heuristic old new -- spaces.txt >out &&
>         compare_diff spaces-expect out
>  '
>
> +test_expect_success 'diff: --no-indent-heuristic overrides config' '
> +       git -c diff.indentHeuristic=true diff --no-indent-heuristic old new -- spaces.txt >out2 &&
> +       compare_diff spaces-expect out2
> +'
> +
>  test_expect_success 'diff: nice spaces with --indent-heuristic' '
> -       git diff --indent-heuristic old new -- spaces.txt >out-compacted &&
> +       git -c diff.indentHeuristic=false diff --indent-heuristic old new -- spaces.txt >out-compacted &&
>         compare_diff spaces-compacted-expect out-compacted
>  '
>
> -test_expect_success 'diff: nice spaces with diff.indentHeuristic' '
> +test_expect_success 'diff: nice spaces with diff.indentHeuristic=true' '

Adding the '=true' seems weird to me (I'd think the true is implied,
similar to C,
where we do "if (!null_pointer)" instead of an explicit "!=null".
However we do have these '=true' sprinkled all over the tests,
so I guess it is a valid dialect in our test suite.

The tests (just looked at the interdiff) look good to me.

Thanks,
Stefan
