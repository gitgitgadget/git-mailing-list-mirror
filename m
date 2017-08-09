Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746111F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdHIRwN (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:52:13 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:38014 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdHIRwL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:52:11 -0400
Received: by mail-lf0-f42.google.com with SMTP id y15so31130442lfd.5
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oKE9LYQy5gYB0QUAW4Gdci/MeStPpexonh/6vVif0cI=;
        b=nJDPg9n6DRdUBW5X2+3skA1DrGAhyar8MDvH3g5Dso/wkoZhMQmHH3+nWg9RARcWWu
         +A910qzGQMaiUZy8Lwov7zwfKTTKnz4AljjbDGJpTUmMHE4TMhUBeBIIUs7CoWkoBi9w
         NiSMXNPSlyf1sgTJPsRuZ53MSX0lI8pPq3pj0nUMIyV2qR3A3XIV0L0vvmZAzMQ3hW76
         k9ZqEItF24I+PSneOp52qYOzHJMv+y/ZdkN/3oWgWzatE2odjRl+HAlUejhB4ycIgM8n
         GqMTgjFcz8md+3f0kQ3qE7+5DF0c7VINMfHyVHEelRfeOJDcnatqEzuzVJj/y03Xfdol
         KIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oKE9LYQy5gYB0QUAW4Gdci/MeStPpexonh/6vVif0cI=;
        b=LZ7TYHTTfWlYQSmCu5PWS/Fr/AGDLXQIhYld8tZTYBrRvIBq7B+/+gCDF+1R8YEyFS
         lcj4G6++YRsGwcCV2E9GMXY3wVKzvXVlO7jYiKwu+VoqtYbmdw98hW6LrntwDAOno4JN
         gj41f8U+C2tvrMssCEj0vIcrZtLFpJk4sbCvyVdtGOAaHz7V0OP1enMI7538eMKEuSwo
         yawrjkUZV9ecLvdS/Ds/HT1BfDYYySueL6946SbBMufakwQh+Tp5d0BQ95/iosjj8OD9
         vHRjgJog8NSTlQ+IDlXj0U6Mk5dy4J3srObw7OzpeQMsz+wFPSFizT638SmQQ9ZfMHib
         lfZA==
X-Gm-Message-State: AHYfb5gySc4bv0VxnrSa3pRfAY4Tr66mE+Fi8C/a949qYYRbZpg2ywaP
        RNd6cxgouoQP45J4xLwRBlQB4SWONJHgPa5WOw==
X-Received: by 10.46.69.6 with SMTP id s6mr3081634lja.40.1502301130412; Wed,
 09 Aug 2017 10:52:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 10:52:09 -0700 (PDT)
In-Reply-To: <20170809122402.7y4g5g5y2kkrky5e@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net> <20170809122402.7y4g5g5y2kkrky5e@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 10:52:09 -0700
Message-ID: <CAGZ79kZxtq9Fe1usBgyNSpL1qAXiE-cVvBeWZf1_bP8bjMLwWw@mail.gmail.com>
Subject: Re: [PATCH 2/5] interpret-trailers: add an option to show only the trailers
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:24 AM, Jeff King <peff@peff.net> wrote:
> In theory it's easy for any reader who wants to parse
> trailers to do so. But there are a lot of subtle corner
> cases around what counts as a trailer, when the trailer
> block begins and ends, etc. Since interpret-trailers already
> has our parsing logic, let's let callers ask it to just
> output the trailers.
>
> They still have to parse the "key: value" lines, but at
> least they can ignore all of the other corner cases.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
...
> +test_expect_success 'only-trailers omits non-trailer in middle of block' '
> +       cat >expected <<-\EOF &&
> +               Signed-off-by: nobody <nobody@nowhere>
> +               Signed-off-by: somebody <somebody@somewhere>
> +               sign: A U Thor <author@example.com>
> +       EOF
> +       git interpret-trailers --only-trailers >actual <<-\EOF &&
> +               subject
> +
> +               it is important that the trailers below are signed-off-by
> +               so that they meet the "25% trailers Git knows about" heuristic
> +
> +               Signed-off-by: nobody <nobody@nowhere>
> +               this is not a trailer

Please see 60ef86a162 (trailer: support values folded to multiple lines,
2016-10-21), maybe we also want to test for

VeryLongTrailerKey: long text with spaces and breaking
    the line.

For those parsing the trailer do we unbreak the line?
Such that one line equals one trailer? or is the user of the parsed
output expected to take care of this themselves?
