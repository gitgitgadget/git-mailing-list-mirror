Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8EA1202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbdJSVD4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:03:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:48013 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbdJSVDz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:03:55 -0400
Received: by mail-qt0-f194.google.com with SMTP id z50so16167265qtj.4
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eMhHqD2vK0vI5gUp/srYLpxFYet2fPveR59ne7XpX3Y=;
        b=tOi7LKJJTwMZraG7PS9tMxjDy45BRA9rTpIiZvWU2nuFHMU074t+bbJPdgG2E6hQL8
         hOBTu5YTNdwvaxsZ9PcKTIYRjU8a3f0cILK31UuSnSZ3z+b2+2C8Md+S6MVpLMnHHCVU
         Hc+C9gDJjnQ2Zh3i7oFooGTLTNongiEGFesoWsUnZbpWxKmLQUljiu0c8xYejFzi1o/4
         RbQKj6EVPeXC2Z2ZAwCzt5nUPpDpkhSXYSCyR3IM0pq5z/bkKU/k7FRp1n1Ln2R+08VA
         jWkDtJCIVs4YY7nVe7eikB9DAazcxYAPrJI3rQRoO7rAOAnVL1OGH2mUSTvn/PCdHW2R
         QA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eMhHqD2vK0vI5gUp/srYLpxFYet2fPveR59ne7XpX3Y=;
        b=J94msLBwolqFK80h75V8ivAqWX9v5M3XZwobgn73lwDEuY2xMGSN66ioFcmFVSPKn1
         FpCGhg5jL/gWS6Cz7oAz1ED6C/b2vSYPz6K4krYEqWskFivvTh3PCRzwz/DrCxaZIgxx
         IByRQ1c9NkBVnl0kvuzrSWPGe3/a2z4VYCSr2UYQv6APLDqVxHBCCv74UsfOK5xku8Jm
         +/2fbpIHTas+ot/HsNZUjE56XrOlIrFhpBEOGO8PylVRs5fxAeMw1ILoUKZUxkFGMv8M
         UNejMYbCAQ8dwGdWA9dL9vUxRe4Ib/nsJStrBC4bPU4eLBnS9bZQABhDElmSR5drNIPW
         YvRA==
X-Gm-Message-State: AMCzsaXbvkew05qxba1jl1WSfKPLwFWB18MHGYy9x7DZX3gHYa/umYWn
        NwZ4rQuFbu326Ht8P6DdBJ9A8ot++7JhcMxZufgCIg==
X-Google-Smtp-Source: ABhQp+SuIKmfzNQsa27zQ49hyiJNkQ9yB+2/G7CX4NXT6poqc9j9T3jTmkJoc0glx7vkNK8Vf9tGcnulF05KV1FiqkI=
X-Received: by 10.237.53.137 with SMTP id c9mr4403828qte.125.1508447035050;
 Thu, 19 Oct 2017 14:03:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 14:03:54 -0700 (PDT)
In-Reply-To: <20171019202630.plnm6g4x3cuggxoj@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net> <20171019202630.plnm6g4x3cuggxoj@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 14:03:54 -0700
Message-ID: <CAGZ79kaszx26d8D0UrEj948Fam5b41hQWXcpC0V-5Rrom6M15w@mail.gmail.com>
Subject: Re: [PATCH 3/5] t4015: test the output of "diff --color-moved -b"
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 1:26 PM, Jeff King <peff@peff.net> wrote:
> Commit fa5ba2c1dd (diff: fix infinite loop with
> --color-moved --ignore-space-change, 2017-10-12) added a
> test to make sure that "--color-moved -b" doesn't run
> forever, but the test in question doesn't actually have any
> moved lines in it.
>
> Let's scrap that test and add a variant of the existing
> "--color-moved -w" test, but this time we'll check that we
> find the move with whitespace changes, but not arbitrary
> whitespace additions.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

> +
> +       git diff HEAD --no-renames --color-moved --color |
> +               grep -v "index" |
> +               test_decode_color >actual &&

The -v index grep makes it future proof (for a new hash)!
I like that. What I do not like is the pipe at the end of
git-diff as we certainly want to inspect the return code
(or for a segfault ;)

> +       git diff HEAD --no-renames -b --color-moved --color |
> +               grep -v "index" |
> +               test_decode_color >actual &&

Do we need (or rather want) to give --color additionally,
instead of having --color-moved imply it? I guess this is
extra carefulness from the "color always" series?


>  test_expect_success 'clean up whitespace-test colors' '
>         git config --unset color.diff.oldMoved &&
>         git config --unset color.diff.newMoved
> @@ -1549,13 +1613,4 @@ test_expect_success 'move detection with submodules' '
>         test_cmp expect decoded_actual
>  '
>
> -test_expect_success 'move detection with whitespace changes' '
> -       test_when_finished "git reset --hard" &&
> -       test_seq 10 >test &&
> -       git add test &&
> -       sed s/3/42/ <test >test.tmp &&
> -       mv test.tmp test &&
> -       git -c diff.colormoved diff --ignore-space-change -- test
> -'

Ok, this is covered above in testing for the unchanged lines (1-5)
