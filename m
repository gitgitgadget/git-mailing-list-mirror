Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075DD1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeBGNxT (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:53:19 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:41699 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeBGNxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:53:18 -0500
Received: by mail-ua0-f171.google.com with SMTP id f5so569067ual.8
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DZtkl//fRnc/H9S6EyTBfzzDGtq/j/wwrYvJ0DPJ7Ok=;
        b=oXyxFKkpueQ74cinZECVTP41DvtN57w8YI6rVWe18u4z67C6NfEA3jVCSR7CEffRu+
         5mK/59vf9xnfCEhmwHZf40Nd865jR/PUjhOIMcdI0N2yIYlqPPyZnvcv/Vsaw0321ly5
         yGMY5ylCDO7BPYJByRHc2+miUuPLtfZWpZfPLZncPqtkmrzIvwLChY/x3PjGtykzmOpD
         BVz2vf626p1eA8W/JealcU8rUVfzV3Kznx5tTHN5mGdqwet4k+D2Z+85EnUU8IkziuHT
         Fe1sQpbxxpgSInAQdUsouLjbnSZjEvlUDJYRBMJDjFYv+I7oZbCCaJltdXowtnOZ71Yw
         NRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DZtkl//fRnc/H9S6EyTBfzzDGtq/j/wwrYvJ0DPJ7Ok=;
        b=hLiTmw5+g1rK/QPWnWLAJecYBUmib7RG9z4fJpVyuj54yBI17zNKuYsJ9bixDFti71
         GzMevycmUs9nYcszvXbcOPFcoKJx7JnVMeEom4Ip9J9zReLDz2qu186Qx0mo/i5nuHVp
         D1UzkInuaL1KDqev+2nB3H4BiXO0ngCj0mUA4ew/Dbb3GR6IcnQEBJPsJzBYwhQI6Ddq
         q4UAtBf483jsiycF5vKjtxYw2Q/Aj1CbXn9gD0yvbKdKqLmXoIRjMqfCGzywWRo/rptp
         YIKszdG0vdIZzm06zsO/AZ9FKo1/yCbf+UcGge4isu7aJAa27852NsEec7M/UL3T0MyQ
         wy/g==
X-Gm-Message-State: APf1xPBoM7EVXIR9QXUsSPg/JdhxgmzPZs+r1mXy+LFVT97m6FTv+j63
        5Ll2UnT5N6XY9gmAmjolfJdrjcgvYLJzVm8SjVc=
X-Google-Smtp-Source: AH8x224xOKddpQwoSEfCkZdG0M758n6I/ynVflZNqsgTIa45/wUyw/xp7dETKBO26vm+fEnAFrLf4O4Rt2T189pgv20=
X-Received: by 10.176.72.178 with SMTP id x47mr5462572uac.24.1518011598005;
 Wed, 07 Feb 2018 05:53:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 7 Feb 2018 05:53:17 -0800 (PST)
In-Reply-To: <20180126182734.GB27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com> <20180126123708.21722-3-szeder.dev@gmail.com>
 <20180126182734.GB27618@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 7 Feb 2018 14:53:17 +0100
Message-ID: <CAM0VKjkf=51i1YPqdNm=pyPHaNNguXLu0T1iHDYv28jW92QTow@mail.gmail.com>
Subject: Re: [PATCH 02/10] t5812: add 'test_i18ngrep's missing filename parameter
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 7:27 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 26, 2018 at 01:37:00PM +0100, SZEDER G=C3=A1bor wrote:
>
>> The second 'test_i18ngrep' invocation in the test 'curl redirects
>> respect whitelist' is missing its filename parameter.  This has
>> remained unnoticed since its introduction in f4113cac0 (http: limit
>> redirection to protocol-whitelist, 2015-09-22), because it would only
>> cause the test to fail if Git was built with a sufficiently old
>> libcurl version.  The test's two ||-chained 'test_i18ngrep'
>> invocations are supposed to check that either one of the two patterns
>> is present in 'git clone's error message.  As it happens, the first
>> invocation covers the error message from any reasonably up-to-date
>> libcurl, thus the second invocation, the one without the filename
>> parameter, isn't executed at all.  Apparently no one has run the test
>> suite's httpd tests with such an old libcurl in the last 2+ years, or
>> at least they haven't bothered to notify us about the failed test.
>
> Interesting find.
>
> The "too old" curl is older than 7.19.4, which we actually fail to build
> with since v2.12.0. So they probably did not even get as far as the
> tests. ;)

Oh, OK, I was not aware of that.  The oldest non-maintenance release
with the missing filename parameter is v2.7.0, so that's still a 5
releases time frame to notice it.

Anyway, I'm preparing v2 of this series, and I'm not sure what to do
about this.

  - Should I simply drop the "your curl version is too old" pattern?  It
    would make sense, but it just doesn't feel quite right to remove it
    while the corresponding printf() is still there, even if it can't be
    triggered anymore.  However, cleaning up the curl version checks in
    http.c to remove this message is beyond the scope of this patch
    series.

  - Or leave it almost-as-is, only dropping the now unnecessary curly
    braces as Simon pointed out.  And perhaps a bit of update to the
    commit message.

I'd prefer the second option.

>> Fix this by consolidating the two patterns into a single extended
>> regexp, eliminating the need for an ||-chained second 'test_i18ngrep'
>> invocation.
>
> OK. Once upon a time I think we had trouble with "grep -E", since some
> older systems had only "egrep". But I see we've introduced some "grep
> -E" invocations as far back as 2013 and nobody has complained, so it's
> probably fine.

Yeah, first I went with the more traditional "\(this\|that\)" pattern,
but then noticed that 'grep -E' is already used in a couple of places,
and picked the format that uses less escape characters.
