Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80546202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbdGMT1p (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:27:45 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36369 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbdGMT1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:27:44 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so34134853pgb.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n6o8eUgrkNIs1WqrrUMgo3pPANgtpGXfQ2eCD7tq6ds=;
        b=XSnDbkni2F/oEU2h/xTVsZzsbzglapl3CF0zBMmI6YE8zI9lL6JU4qk+lObeTxTkbB
         XGcc6qjbNAz3cc4Xk+n67fER/fiBtSQXVS1HhDmjqIo2didoGx8frwp1nDAo5u8GhZ3K
         /6brlJB04mwRv63xJP+KFeY4tazKArPrTIm//KMGQSPGGeVBFY5iV+vYtLiHSxf5hwH/
         obYb9Z1ihTjuI08ll87ZwHxD+QkZzV0NxeyyzaLNS70Ekz8Lfw8mCd9LXILimHLVG5z5
         UM4TICWInPTfYwME52/AeGR9hu7VvQFLA0iPV1nieGTlNzXuftf5DZnZsrkxWKMcVvlB
         BGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n6o8eUgrkNIs1WqrrUMgo3pPANgtpGXfQ2eCD7tq6ds=;
        b=j9KiLseJLGDQ/hro6rJ1yixJzIki1IBvsY1eWJ4f6yYPsKWosapoEsl0zyeHnC2He8
         HAG60hA96Yil1v0Ed0EsG0dr6iS/NoG0HuNy49yKk30KO3Y/WHO7Id+pGwL5XLuFkZps
         HBxXGoLQ8+389HIeDVt5NAnT57t6KDqf34fdOCI7u6gRFlwe+45xtSfwgTifTMFXK+GJ
         3XkpOZEVNjWCAdu2oxMaJhrkwqAqeEo/EMqx9nJWOcmQCxg5NMohT5aaMk5JIxpAXIx+
         mSl4t+tL78FmougeloVl+7XUgib7SezFTGH3JLLPurG2HmjaJmrUbljMr6JIlTIEEaRQ
         xwuw==
X-Gm-Message-State: AIVw112HnWwdVrvuMcjDtaxkzj4ShtSMLJ3O9Seoddyp99qAma3xVBUN
        bxGNKaoiCpu9mQ==
X-Received: by 10.99.56.21 with SMTP id f21mr10667084pga.235.1499974063272;
        Thu, 13 Jul 2017 12:27:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id d89sm15295380pfl.7.2017.07.13.12.27.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:27:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 03/15] t: use test_decode_color rather than literal ANSI codes
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
        <CAGZ79kaE7wjFR-=DiPU5xwknS1nxDHR5+S6+UGPFTF0uNBA3dQ@mail.gmail.com>
        <20170713184541.ferc3eif7j4mazpg@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 12:27:41 -0700
In-Reply-To: <20170713184541.ferc3eif7j4mazpg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 14:45:41 -0400")
Message-ID: <xmqqeftkw30y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > @@ -59,7 +54,8 @@ EOF
>> >  # to this test since it does not contain any decoration, hence --first-parent
>> >  test_expect_success 'Commit Decorations Colored Correctly' '
>> >         git log --first-parent --abbrev=10 --all --decorate --oneline --color=always |
>> > -       sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" >out &&
>> > +       sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
>> > +       test_decode_color >out &&
>> 
>> Just some thoughts:
>> 
>> This extension of the pipe-chain is not making it worse as gits exit code
>> is already hidden.
>
> Yes, I noticed the existing pipe-chain. We can fix it while we're here,
> though I think it's not a big deal in practice.
>
>> The sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" is sort of funny, because
>> I would have expected it to break in the future with e.g. the sha1 to longer
>> hash conversion. But as we specify --abbrev=10, this seems future proof.
>> In an ideal world this would be encapsulated in a function (c.f. t/diff-lib.sh).

Actually, --abbrev=10 does not guarantee that the hex part is always
10 bytes long, so it is not future-proofing, but I expect it would
work out fine in practice.

> I agree it's a bit gross. Possibly:
>
>   git log --format='%C(auto)%d %s'
>
> would be easier for the test to parse (I'm pretty sure that didn't exist
> back when this test was written).

Yeah, that may make the test easier to read, too.

Thanks.
