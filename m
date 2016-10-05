Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E031F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 16:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753052AbcJEQrW (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 12:47:22 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33022 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbcJEQrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 12:47:21 -0400
Received: by mail-yw0-f196.google.com with SMTP id g192so9855207ywh.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pDn8vBL/UP8K2BL3HlMKKElhAziJzm3EjHUBTiZZ854=;
        b=OEGlUnj5kt7eTASIBMsnSnCJH96Vo/tjSQYUNyoA8Gyr8G26RWSlWln5Uw2kVELiBW
         rPdJ19mqN3S7DjVLwXslft6hhNulKxY2tWNXFzMPU6dgyyzvC/3ATUyV6jZiNDXaXAu7
         H2q3Wm4y1siS3Xwglw+HnbbclOxTUSRFjygZWnzwIgK3rm43GpiumT1iAQM3bi1U6dGa
         X0IYWtEJppSP11yqyUlJSbxsXVKXrpodIE/HxydiGcwvmHDdEQUuffr85Wd3970C+qc5
         qmWXveB3iADRkphHPisF5OFJOgNrmXf9jCS/FCqjUUCzXB8rk+mrM577KXokAg9uUuIt
         wkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pDn8vBL/UP8K2BL3HlMKKElhAziJzm3EjHUBTiZZ854=;
        b=awj5fXR9Jvgn2G6dhQAHwhEshgVJM8/X9wrDDWVga4Quob5WEkFPhvD6JTXmUbb+UH
         0ZEF/0zs6GXiLKqtt9XNhyTkAUkkiTIGrIuit2kmvO6nP/mMZ9oKu0GbF2aFarZtDWgd
         a9DU5IK2XTuZl/8fzmD1Br3hScr1zDYqFGcFQgF+V+X/rOkz1bg7xgdyASSYnbyq5iiH
         POkhkrmkCJZC8/4zXS5eK3HT39sdZEu3qxFXbuM1C8NF87xdbCwjSclRmDKXjVIkl1pD
         sQIppVuSMYff6tepBZUxv4PMXdaZLJyVKqlKE8G83hf50Ksh8mf7P/D2BjmMYIEX2iSm
         e3pQ==
X-Gm-Message-State: AA6/9RkW9ty7f8zlCKPAXLz60ScOeRDUCp1LSxSGQiPAIXOCBI4V71XNd7iUulkwBaa7h4Gzgvjj7+C6G8O21w==
X-Received: by 10.13.244.129 with SMTP id d123mr7279546ywf.276.1475686040523;
 Wed, 05 Oct 2016 09:47:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Wed, 5 Oct 2016 09:47:00 -0700 (PDT)
In-Reply-To: <20161005144028.tjuvk3hkoqm3qjfd@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net> <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net> <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net> <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net> <CAGZ79kap2ndp=FK4YdqrL4tJ8_VDuuAcSCk1dtX5X2H3aaj6kQ@mail.gmail.com>
 <2ea2f077-ab02-2631-4ce9-93cdd22c3c6b@gmail.com> <20161005144028.tjuvk3hkoqm3qjfd@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 5 Oct 2016 09:47:00 -0700
Message-ID: <CA+P7+xrhs0j+9sK22+5qR9bM6bwkua1rDZDkCg6HrtL5BDZBNA@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2016 at 7:40 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 05, 2016 at 03:58:53PM +0200, Jakub Nar=C4=99bski wrote:
>
>> I would prefer the following:
>>
>> #   A --> B --> C --> D --> E --> F --> G --> H
>> #      0     1     2     3     4     5     6
>
> Yeah, that is also more visually pleasing.
>
> Here's a squashable update that uses that and clarifies the points in
> the discussion with Jacob.
>
> Junio, do you mind squashing this in to jk/alt-odb-cleanup?
>
> diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> index b393613..62170b7 100755
> --- a/t/t5613-info-alternate.sh
> +++ b/t/t5613-info-alternate.sh
> @@ -39,13 +39,16 @@ test_expect_success 'preparing third repository' '
>         )
>  '
>
> -# Note: These tests depend on the hard-coded value of 5 as "too deep". W=
e start
> -# the depth at 0 and count links, not repositories, so in a chain like:
> +# Note: These tests depend on the hard-coded value of 5 as the maximum d=
epth
> +# we will follow recursion. We start the depth at 0 and count links, not
> +# repositories. This means that in a chain like:
>  #
> -#   A -> B -> C -> D -> E -> F -> G -> H
> -#      0    1    2    3    4    5    6
> +#   A --> B --> C --> D --> E --> F --> G --> H
> +#      0     1     2     3     4     5     6

Yea this looks much better (when I view it locally, gmail still looks
aweful here but...)

>  #
> -# we are OK at "G", but break at "H".
> +# we are OK at "G", but break at "H", even though "H" is actually the 8t=
h
> +# repository, not the 6th, which you might expect. Counting the links al=
lows
> +# N+1 repositories, and counting from 0 to 5 inclusive allows 6 links.
>  #

... This is much more clear wording that helps me understand this a
lot more. Thanks!

Regards,
Jake

>  # Note also that we must use "--bare -l" to make the link to H. The "-l"
>  # ensures we do not do a connectivity check, and the "--bare" makes sure
> @@ -59,11 +62,11 @@ test_expect_success 'creating too deep nesting' '
>         git clone --bare -l -s G H
>  '
>
> -test_expect_success 'validity of fifth-deep repository' '
> +test_expect_success 'validity of seventh repository' '
>         git -C G fsck
>  '
>
> -test_expect_success 'invalidity of sixth-deep repository' '
> +test_expect_success 'invalidity of eighth repository' '
>         test_must_fail git -C H fsck
>  '
>
