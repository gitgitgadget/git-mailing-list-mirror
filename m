Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4292A20798
	for <e@80x24.org>; Wed, 11 Jan 2017 23:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761949AbdAKX6C (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 18:58:02 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:35441 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757779AbdAKX6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 18:58:01 -0500
Received: by mail-io0-f179.google.com with SMTP id j18so6244857ioe.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LGYD0qm+PYpZYaRfxbEFaPC+L3hQHyp/SxP+BmK+TZg=;
        b=WV5G7TXz6phs0ZUr4I4tHxmHt0j+cEdCKgQtKtAD9H6iX8JkQWn1WwJVAhMfwPQNFs
         fyNiFlZ3hqfq0ZZplLMnZ+YJzmuIJp9CN8YPxTrsuYovp4oWvOKXXoX7ZU70SFs9QVlV
         ALIcwv+tSPUMeK42yiEsh4sGKgTw73qnLZYy0Mn14LnQbvx8zOAPKokrxtLD7RVKXYrW
         YTuXaa7e9DZYDD3G1h1ESo/h0z/lpX+uoMqFsztfocQx4FQhU+4wFJdogxkEioldX8ou
         juf+2ECoupitj7FWgeoPXrjd23b/52HIq8YT4pU6VgYW6DpX+qzfOwwBct+2e53i5nih
         EtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LGYD0qm+PYpZYaRfxbEFaPC+L3hQHyp/SxP+BmK+TZg=;
        b=FhLxJI5PSZbLWE8xhQCQL9O3oRGJkCevMIzsCAqN3ljPxbK5HYazIQXv4sIgLEZcDl
         ODbYffM7a8SGOpw38g4Z73r4eQOVUcR5gmSXPOMsFPN51BQjojEQjJgREYrW3hq7+Eqx
         GNP+3VcukQgq5yPj7WTehJWYIhJtLuG2B2EnWqRPsiPbgBhRXEmM5FGQcoI5kmvxP8CP
         7rnzy5AbYH48C7JFxegzAZg/bKQzAmcw9qpr5P2l22j4I5XhJFeW6bRnogQ5yqampaAU
         yGVLeZZM0mH+ktm9nYhyWdiqocr//HF0O7C42bBx4HQhnU3zLLgWD7fNG+0pxV38HY1x
         oGNA==
X-Gm-Message-State: AIkVDXLOUyTTQxwcWYjB+iDHMcvmt2PuEsJvAWJHsq5SB3KWoNKmvH/A4GjQMBSKB0QnqcLZDnTxhSJ2YNGRi7y0
X-Received: by 10.107.16.14 with SMTP id y14mr10172873ioi.164.1484179080331;
 Wed, 11 Jan 2017 15:58:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 11 Jan 2017 15:57:59 -0800 (PST)
In-Reply-To: <xmqqh955mb1p.fsf@gitster.mtv.corp.google.com>
References: <20170110014542.19352-1-sbeller@google.com> <20170110014542.19352-5-sbeller@google.com>
 <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com> <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
 <xmqqh955mb1p.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 11 Jan 2017 15:57:59 -0800
Message-ID: <CAGZ79kb30nG-TAnXuUKM+exxoh816sRogwhU-hjaL+onmFR-qQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] unpack-trees: support super-prefix option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Preparing the expected output "expect" outside test_expect_success
>>> block is also old-school.  Move it inside the new test?
>>
>> I looked into that. What is our current stance on using single/double quotes?
>
> Using dq around executable part, i.e.
>
>         test_expect_success title "
>                 echo \"'foo'\"
>         "
>
> is a million-times more grave sin even if the test initially does
> not refer to any variable in its body.  Somebody will eventually
> need to add a line that refers to a variable and either forgets to
> quote \$ in front or properly quotes it.

agreed.

>  The former makes the
> variable interpolated while the arguments to the test_expect_success
> is prepared (which is a bug) and the latter makes the result quite
> ugly, like so:
>
>         test_expect_success title "
>                 sq=\' var=foo &&
>                 echo \"\${sq}\$value\${sq}\"
>         "
>
> Enclosing the body always in sq-pair does mean something ugly like
> this from the beginning once you need to use sq inside:
>
>         test_expect_success title '
>                 sq='\'' &&
>                 echo "${sq}foo${sq}"
>         '

This one fails
error: bug in the test script: broken &&-chain:
                sq=' &&
                echo "${sq}foo${sq}"
both other occurrences of using ${sq} are defining sq outside
(one as sq=\' and the other as sq="'")

So I think we either have to keep sq out of the test,
    sq="'"
    test_expect_success title '
         echo "${sq}foo${sq}"
    '

or do the echo/printf trick inside:

    test_expect_success title '
         sq=$(echo -e "\x27") &&
         echo "${sq}foo${sq}"
    '

Eh, I just realize the '\'' works inside here-doc, too.
Nevermind then, I'll resend it with just quoted sq in the here-doc then.

Thanks,
Stefan
