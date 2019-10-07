Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261041F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 17:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfJGR1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 13:27:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGR1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 13:27:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so16308681wrd.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 10:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndQoA6nJjVBzA7qcNK5hcV4NARc5b47AfODoNbiBn54=;
        b=FhJz5hqPHyC1nNTl40k9ZwuMNEjYaXna9d0YDRnIlnlqUgsbTriyJ3yGip/NEOWuxN
         AXM3Epe3rr7uxVIfcDbWpU/5+BVSmy7OiykC3bxvPf7U4aR2bBnylQA9DXDJ10dEPWv7
         U3HGSUS5VqbifVOT7Dj2BH2EPCp3liK/l0OKf4s5tIEqa+2Ng4mXsQwWPllP3Xo5TNj/
         X1+Ap0OZmyfm5kjwcOxmG8YQBw1AFKy4Y16y7uqGu+BhwWd36ryEVT9BWQBFAPOKmNZq
         oOGrqbggPH/GQozrxO7ayzKEY9EwOLFIJ+qG1pdNSEyqoDVsaTPg6NBjaf8O/7IAgiT8
         J36g==
X-Gm-Message-State: APjAAAXbzo3Wj2VRogXNMVdCPvWGAB1+hBUXFxSEpFzkpAvIJLM+888A
        dFG5Fv4WjZaWGLix2MqFmNVkubbEI0V9h7/B9q7vt4eM
X-Google-Smtp-Source: APXvYqx00zC9ltMN20xSMCRHXAA/aAU+IetpTZB+qBTH/FYHsrUIIhGCBWgQTSrXRPjiTOYJgzjmEAHT9VVCdwJszNQ=
X-Received: by 2002:a5d:4f0d:: with SMTP id c13mr24010180wru.317.1570469233505;
 Mon, 07 Oct 2019 10:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.314.v2.git.gitgitgadget@gmail.com> <pull.314.v3.git.gitgitgadget@gmail.com>
 <399fe02cb155770fc2d937607014677874075458.1570465059.git.gitgitgadget@gmail.com>
In-Reply-To: <399fe02cb155770fc2d937607014677874075458.1570465059.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 7 Oct 2019 13:27:01 -0400
Message-ID: <CAPig+cRtL1YPxTHfZ+uYek6hBbRmKJgSNiPNX_zM-Tc_7LnhWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] quote: handle numm and empty strings in sq_quote_buf_pretty
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, garimasigit@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 12:17 PM Garima Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> quote: handle numm and empty strings in sq_quote_buf_pretty

What is "numm"?

What does it mean to "handle" these things? A possible rewrite of the
subject to explain the problem more precisely rather than using
generalizations might be:

    sq_quote_buf_pretty: don't drop empty arguments

> The sq_quote_buf_pretty() function does not emit anything
> when the incoming string is empty, but the function is to
> accumulate command line arguments, properly quoted as
> necessary, and the right way to add an argument that is an
> empty string is to show it quoted, i.e. ''. We warn the caller
> with the BUG macro is they pass in a NULL.

s/is they/if they/

By including the final sentence in this paragraph, the reader is
confused into thinking that warning the caller with BUG() is the
overall purpose of this patch and is the "fix" for the stated problem.
At minimum, the final sentence should be yanked out to its own
paragraph or, better yet, dropped altogether since it's of little
importance in the overall scheme of the patch.

As a reader of this commit message, I find it difficult to understand
what problem it's trying to solve since the problem and solution and
existing behavior are presented in a circuitous way which doesn't make
any of them stand out clearly. Here's a possible rewrite:

    sq_quote_buf_pretty: don't drop empty arguments

    Empty arguments passed on a command-line should be represented by
    a zero-length quoted string, however, sq_quote_buf_pretty()
    incorrectly drops these arguments altogether. Fix this problem by
    ensuring that such arguments are emitted as '' instead.

> Reported by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
> diff --git a/quote.c b/quote.c
> @@ -48,6 +48,16 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
> +       /* In case of null tokens, warn the user of the BUG in their call. */
> +       if (!src)
> +               BUG("Cannot append a NULL token to the buffer");

The comment merely repeats what the code itself already says clearly,
thus adds no value and ought to be dropped.

Moreover, this entire check seems superfluous since the program will
crash anyhow as soon as 'src' is dereferenced (just below), thus the
programmer will find out soon enough about the error. I'd suggest
dropping this check entirely since it's not adding any value.

> +       /* Avoid dropping a zero-length token by adding '' */
> +       if (!*src) {
> +               strbuf_addstr(dst, "''");
> +               return;
> +       }

Ditto regarding dropping the useless comment which merely repeats what
the code itself already says clearly.

> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> @@ -37,4 +37,11 @@ test_expect_success 'looping aliases - internal execution' '
> +test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '

Is "parses" the correct word? Should it be "formats" or something?

Also, the bit about "using sq_quote_buf_pretty" lets an implementation
detail bleed unnecessarily into the test suite, and that detail could
become outdated at some point (say, if some function ever replaces
that one, for instance). It should be sufficient for the test title
merely to mention that it is checking that empty arguments are handled
properly. So, perhaps:

    test_expect_success 'run-command formats empty args properly' '

> +    GIT_TRACE=1 git frotz a "" b " " c 2>&1 |
> +    sed -ne "/run_command:/s/.*trace: run_command: //p" >actual &&
> +    echo "git-frotz a '\'''\'' b '\'' '\'' c" >expect &&
> +    test_cmp expect actual
> +'
