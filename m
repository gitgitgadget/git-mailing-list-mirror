Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40B611F462
	for <e@80x24.org>; Tue,  4 Jun 2019 16:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfFDQH6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 12:07:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:46149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbfFDQH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 12:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559664474;
        bh=dUu+Xzm6/Fo1HGEF+cnmjywlrh9cJQG6jAtvuo6/oSw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IxY+wwI2lsISqdXP7Kr+cUQfTOxU5zrNq4MIhmm0BA0baEvBzZgrYMOLG08IhG0Zy
         o6G4PTtnfZkqRseAgzWiWg4Ge9NmjuN+6G253r8Kpg/XMASpMIXNSvZnJ2cZny7NsJ
         hURqBJZHk8Bf8XlAxcBcrT51d5AG2el2AaLXU4wE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqn7e-1gtt8t3xiM-00eOKs; Tue, 04
 Jun 2019 18:07:54 +0200
Date:   Tue, 4 Jun 2019 18:07:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, Taylor Blau <me@ttaylorr.com>,
        Patryk Obara <patryk.obara@gmail.com>
Subject: Re: [PATCH] clang-format: use git grep to generate the ForEachMacros
 list
In-Reply-To: <20190603224814.GA15851@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906041807140.1775@tvgsbejvaqbjf.bet>
References: <20190603224814.GA15851@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ohuZbubjuusRiVWm/8ApTAxfEqISvqoi9BcNUiNEdE89rPUstwP
 fLk1Nulx9h1U8Bib78TwyAZAq7cDMyayTczDpXTe7MVVZokqLOgwSbf19zKodRp4iy7TlER
 jtwJywKmkw9oQkuBSXodunge6zBJEhMVTdiqdE8qLcXCNNnAR06Y6ZJ/lI5xMIarGY3yq8y
 3boU4gOVp1Micusrpqnww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KfXe2iTYh2c=:Ale0z2Eg3+szY3tAxSV+1W
 Gdh9zGgQc26LQz+SERozujBAi2QBNb6iI0ypCR+AczE9mE6Sb+fFwrARQsQJZQaXHypzDVWN7
 Ko3VAGXHSyMxcxRkVoMcG+VZ1TkMqPgWADlQxS96r2AIrcq7nuYfQck1ThLbvcQI2S3dW2AiE
 bCEjOS6fkcDhI4rbMkbfzkd7RWpz5/Wd+tmsju71Sgrd9bDEikS1+JklV6L724WgSjwRcmuJq
 SWqCfBmJDXc6icFvwUA9RdnXkTihd6Ejrti49JqNjUBfpLVCOFcKokHwfVEKGLuqnyABdzYfL
 u00wyyT10jNVZU/hwuqJOC6HK1v1fOM+xq5Xer2+K3lzOKXkK5oAxmS7A153TUbD7Ev1y8plz
 hvLnUVfDGUTcQ0cAwT2qIUxd2ccjI8m/8dojX7DFSk4KKxne4pRoFYChARpOYEjaZTDxpcu1e
 5Sp4ewEeYl+wPn/ao/ibaT6B/Gk/6l7teHKxQ3V4OQHQj75jY5T/yThswReyb/qaF5e+l/mrT
 9ynNiymwov+mXGgqEuazko3lQNZ5fJqFZe2mX12/UA+hp5AqDP51qzN8rsSg+WYk/vFCQvqzj
 tGK89HAbvTmpq7w3khK3d8Jn5YvUxHiSiwXvsZLhi60ChnB7Sr0tHYv5WXgD1WgrXuf8meIp+
 kv0VZVnlBWWcz+ak6meyPQtUxl+j/YnGnsQKnW8bqIdN6I2/MXC/VOarOOMlzYLsnp/LqZE0/
 /n6Z7/sHY1cgGxVrR9lJfNpl9oG314oC9n1C39Wr2hB7M0cTJVre/3ZAlOQLHhJZgNBwyRv3R
 vPRIluqPl5Ecsfg3PKYWGV8O5FdBdIAmaxYfKLe5KXbueooHZ8VT1Jiz2ZTbT9oEIcivjO9EL
 w8G9r+bsos+d0E5SHVfj6NlVaFQDZfYRcwacaPssHWQxAcBbBhXfgRMvlHKOEl33sJ3PwJArY
 SKi+psnRqV23amKO8FkukHJlj0ZogjxA694ZS2TfAOQpDiWry5+nB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miguel,

On Tue, 4 Jun 2019, Miguel Ojeda wrote:

> The ForEachMacros list can reasonably be generated grepping
> the C source code for macros with 'for_each' in their name.
>
> Taken almost verbatim from the .clang-format file in the Linux kernel.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
> We wrote this for the Linux kernel a while ago, and it has been working
> fine there, so I thought it would be nice to use the same approach here.

Makes sense to me!

Thanks,
Johannes

>  .clang-format | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/.clang-format b/.clang-format
> index 41d4cd23fd..c592dda681 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -148,8 +148,21 @@ SpacesInSquareBrackets: false
>  Cpp11BracedListStyle: false
>
>  # A list of macros that should be interpreted as foreach loops instead =
of as
> -# function calls.
> -ForEachMacros: ['for_each_string_list_item', 'for_each_wanted_builtin',=
 'for_each_builtin', 'for_each_ut']
> +# function calls. Taken from:
> +#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' \
> +#   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\=
1'," \
> +#   | sort | uniq
> +ForEachMacros:
> +  - 'for_each_abbrev'
> +  - 'for_each_builtin'
> +  - 'for_each_string_list_item'
> +  - 'for_each_ut'
> +  - 'for_each_wanted_builtin'
> +  - 'list_for_each'
> +  - 'list_for_each_dir'
> +  - 'list_for_each_prev'
> +  - 'list_for_each_prev_safe'
> +  - 'list_for_each_safe'
>
>  # The maximum number of consecutive empty lines to keep.
>  MaxEmptyLinesToKeep: 1
> --
> 2.17.1
>
>
