Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589ED1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbdGaRus (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 13:50:48 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32990 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdGaRup (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 13:50:45 -0400
Received: by mail-pg0-f50.google.com with SMTP id c14so48633085pgn.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4tqVAbrnf4Ohf1yO8GRxoA73WBTSw//JkQha75yxmIo=;
        b=n7ZrQ2Ui6lj3/vhM2vxpCn/Ftss2CdWfihbbDPUvYB2UkVnGy2e5zc+42tmNU99u0d
         qGPsgwgMWiml64ajtv4H3ip+Uc9mY28M/fEUPSnsmFxr56jCg6PufJ0lzNtPnps+YH1P
         FAxcpYAHoAJXbbwIZkacUiVnHEKE1bXigAaRFp6IlP/KsuqqNSoUjLfE/AIKPHSY8loZ
         wiWQQNHOIieH+BJ2DfSgEEL5YGEYAJT+HypsbH8A5iT+jMfPx15t/4l2gIvtGM2SyTbg
         AzWrmaZNkXXVSvrJ3bHBmU3B243iLZrhdBiifn1GHjfWKDpGG5l/5xyBulaYmcJs/Aml
         VDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4tqVAbrnf4Ohf1yO8GRxoA73WBTSw//JkQha75yxmIo=;
        b=p15/i9EUq+iw/sUbWKvvjeuyu+6kf/EsKzcrk95frvunwN49F+bK4HweXpGmR8ekx/
         HOq4foNrsgp6s30RwVAZBtOpiel9ZtAC9CYBFnxP2fjZ2+/VeSfn8raolK4GKJHacuR3
         YtIUc9UKcdNpOfy6D80oWNuRQkv+q3QG95MIPmsmT+udqfE9QG5AQZ91B9XseGIxTjPX
         h967CIaxD05Zo0xm25/jtxbwJcpdSBYtTtwL+ggwyEywodpFCwWx2MmsSN8v6h4lGVGv
         rwJ+BuqZ8/vZG3gRnQ31aVXWnjKZ28nUzm0SD4HU48DrsGYwL7pnHaLhtJh9XRUDSfBQ
         KmUw==
X-Gm-Message-State: AIVw112K2u2Y1JdSU1KUW5pGKJn00QluuE4Cr8oQj1LPpzTik9ljuYqs
        /9Uk38EppMdTGycdMNm7SZVVJZfkAg==
X-Received: by 10.84.174.3 with SMTP id q3mr18368640plb.289.1501523444868;
 Mon, 31 Jul 2017 10:50:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.238 with HTTP; Mon, 31 Jul 2017 10:50:44 -0700 (PDT)
In-Reply-To: <xmqq379ck1fd.fsf@gitster.mtv.corp.google.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
 <f4334503b677bbbeb19660e501ad2d7213428953.1500321658.git.martin.agren@gmail.com>
 <20170731033812.tvclfckx3ascxa2m@sigill.intra.peff.net> <xmqq379ck1fd.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 31 Jul 2017 19:50:44 +0200
Message-ID: <CAN0heSq2obte0Sp-oYMF+Q-VUZd6_d3BSnAaxwVNC20Fqh6daw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] t7006: add tests for how git tag paginates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31 July 2017 at 18:37, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> But here...
>>
>>> +test_expect_success TTY 'git tag -a respects pager.tag' '
>>> +    test_when_finished "git tag -d newtag" &&
>>> +    rm -f paginated.out &&
>>> +    test_terminal git -c pager.tag tag -am message newtag &&
>>> +    test -e paginated.out
>>> +'
>>
>> I think this behavior is just buggy, and it might be better introduced
>> as a test_expect_failure on "git tag -a does not respect pager.tag".
>>
>> Kind of a minor nit, as the series should end up in the right place
>> either way, but it can be helpful if you end up digging back in history
>> to the introduction of the test.
>
> Yes, I think that is essentially the same reaction I had to patches
> 7 and 8, where it carries the "buggy" behaviour forward and then
> fixes it.  The way the series lays groundwork to introduce a
> mechanism that can be used to address this behaviour in its earlier
> patches strongly suggests to the users that this is considered a bug
> by the author of the series to the user from early on, so adding
> this as "expect failure" and then flip it to "expect success" when
> the bug is fixed would be a more natural sequence of changes.

Thanks both for very helpful comments. I admit I viewed it less as
"fix buggy behavior" and more like "redefine wanted behavior". So I
wanted to postpone the redefinition of the behavior until all the
restructuring was done. Looking at this as a bug-fix does make
carefully moving the bug forward look rather silly.

I haven't responded to each of your suggestions individually where the
answers would have been a mere "thanks, will do". They're still much
appreciated and will help make v3 much better. Thanks.

Martin
