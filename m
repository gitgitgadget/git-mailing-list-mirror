Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84CA1F404
	for <e@80x24.org>; Thu,  8 Mar 2018 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750783AbeCHVtw (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 16:49:52 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39029 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHVtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 16:49:51 -0500
Received: by mail-vk0-f66.google.com with SMTP id f6so874024vkh.6
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3a1I2nkkh4wahCmBGXW5F+2BQolwY5xW82X9EpGWWbU=;
        b=RrynIsvzuPi9lXWXO2M5LdKAlWxUIKUdrD3D+X9Utlp6/YUc0v8FAsgNO9OE9VWN7u
         d9d+gSuGz2IdqUbHgLU7/xxw5+rNVHSzpLb/giageqAkLrHDxiJMrTKcjBitOFqzQVpN
         /Hziuxx35RqueWWRs51WJSCX7NfxuLhAW3fF+yTCTQT/QhtbQa8GnlB4KWeoKT7U6MS+
         E0CuUkmOlmXbRumpT3eaNZ6z798TBhl+goYdxymau3SSRYTLHFKZIdLqwGdXUnCg9daG
         tg1zOOAo99qq9cWnVMs3Rycevuo01qwGsVmoaV98Tk3eLj4lf16c3vbJntDfTPbuZrz1
         6rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3a1I2nkkh4wahCmBGXW5F+2BQolwY5xW82X9EpGWWbU=;
        b=FQbFnzp4zoGIRqZAuwXGD5Pl8mUHi/toAeFiHyiN09TB08tEtnzgIE24TXtXIDzkUe
         nNOUHhRy79uuCV2Op100m69r2+tsqK3kf6wtEuLAlQlmGzNHaR4yNqn3QdQHLhEqJQEY
         q9tWWmjo0tX48TARptxqMJRfLrcpjyhdjtu0KdClXJw5cSVX0amhrFOju6HaRFHb20E/
         1UsiKQ+MQdN29/EPKXbHJXcnscAlKmPydW8jJSI2xrYtEV/iIkayCoQMhki2iJGg1AHG
         gi7GNTXnZp/k7tlds8O3iW/d9cb8UZJLHe2NFX+Ve5Gx65NlJbJK0Xozb9WCgcXxs8Ns
         supg==
X-Gm-Message-State: AElRT7E11WZPB/A5pT6XVXh6IqxtiC2kb51ng0KulxzAk1EDRhudNyDM
        mkr4yzkGsb5V++Q9TqLQSjjKQaIfZqmzNJzRrScVug==
X-Google-Smtp-Source: AG47ELtFyoK9rb3r27A492vW9YhA+Taw3+yHw+nFYwWiJgaO/+YCTHLIwMFXDAgBNWhWDX5aE1qOejDot/g0TcLKi9M=
X-Received: by 10.31.171.5 with SMTP id u5mr21135065vke.120.1520545790837;
 Thu, 08 Mar 2018 13:49:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Thu, 8 Mar 2018 13:49:50 -0800 (PST)
In-Reply-To: <CAPig+cTtV2unsixsMCWytdJMiYYytgdvbavfENhBrwvXq_79Bw@mail.gmail.com>
References: <20180308123844.15163-1-szeder.dev@gmail.com> <20180308123844.15163-2-szeder.dev@gmail.com>
 <CAPig+cTtV2unsixsMCWytdJMiYYytgdvbavfENhBrwvXq_79Bw@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 8 Mar 2018 22:49:50 +0100
Message-ID: <CAM0VKjmKcFVOLA-fFnSm=tVapa5qgUoU3Sa7RjSrqoHp5qXZiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] t9400-git-cvsserver-server: don't rely on the output
 of 'test_cmp'
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 8, 2018 at 7:51 PM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Thu, Mar 8, 2018 at 7:38 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:

>> Unroll that for loop, so we can check the files' contents the usual
>> way and rely on 'test_cmp's exit code failing the && chain.  Extract
>> updating a file via CVS and verifying its contents using 'test_cmp'
>> into a helper function requiring the file's name as parameter to avoid
>> much of the repetition resulting from unrolling the loop.
>
> An alternative approach used elsewhere in the test suite[1] would be
> simply to 'exit' if test_cmp fails:
>
>     for i in merge no-lf empty really-empty; do
>         GIT_CONFIG=3D"$git_config" cvs update -p "$i" >$i.out
>         test_cmp $i.out ../$i || exit 1
>     done &&
>
> (And, like the existing patch, this removes the need for capturing
> test_cmp's output into a "failures" file.)
>
> [1]: For example, the "setup" test of t2204-add-ignored.sh.

But 't/README' sayeth:

    Don't:

     - exit() within a <script> part.

And it's right: 'exit' terminates the shell process it's invoked in,
i.e. the whole test script (well, unless it's invoked in a subshell)
without executing the remaining tests and the usual housekeeping and
reporting.

Consider the following test script:

  -- >8 --

#!/bin/sh

test_description=3D'exit 1?'

. ./test-lib.sh

test_expect_success 'exit 1' '
        exit 1
'

test_expect_success 'second test' '
        true
'

test_done

  -- >8 --

It's output:

  $ ./t9999-exit.sh
  FATAL: Unexpected exit with code 1
  $ sed -e 's/exit 1/false/' -i t9999-exit.sh
  $ ./t9999-exit.sh not ok 1 - false
  #
  #             false
  #
  ok 2 - second test
  # failed 1 among 2 test(s)
  1..2
