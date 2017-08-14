Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A551820899
	for <e@80x24.org>; Mon, 14 Aug 2017 21:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdHNVxH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 17:53:07 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36037 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHNVxH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 17:53:07 -0400
Received: by mail-yw0-f178.google.com with SMTP id u207so62802881ywc.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wzOfbhyTvUp2PTUhtBwps5ukGRWTD8CYfDGloT4mG/c=;
        b=DJ744yxEFsMUZThTIdI23qOWVT7GYE/4JB2SMs8BAD28Da/N1iMEIUaoM30GTVC1bw
         SQgIPqSgW+DBu/qo3ZVMNW4QmcrEiNs2/ZAbFWxO3IrM1EMYCkM2PrdlmN/eXCfhQwV6
         taIgAQsAYCWxjl/xub/P/GsmXF3kRYGUmbBqzE34CM0nQryUg6iFnA9Pc18T2HQM85bx
         utc+65fh3fDypo0ZCqm8pBI0uVOAeqvpLnTk73TAu8LCH2vg8yXQXGhdfw1vVrhV+d2H
         DvwluWO+/0uKo5r10l18H2CiGOqUa/PtI1p/Yb+/CZRSE7CuBRavk7+VGjiBQyB0KseG
         q0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wzOfbhyTvUp2PTUhtBwps5ukGRWTD8CYfDGloT4mG/c=;
        b=JjWA9mu2av4tq1v3MoRn1IIMuNUqzSrHqJSPt+QEyhCVBJlf4T9/Liekwntm6N8cb7
         /zgsuKk2KLAu88cwObfFhdG53Rwiy/DR6giPOXlM8LPZpwKR1ZnStY7ebFFN7/GHdmEa
         OfCu5cgXZrKYyiyGuz14TwusawXQgGiQC7tX6R77E3zSqVGNigMn/pBcsWQf9NUg0LnS
         /YIF6QF7UDGsXgfws2+hGtl5eAWkNu8XS3qB6Y8QuV+1QCgt5IddZIOt5J874V1nV/cD
         +nYZwiomC8d4QmEAxslBnypJclQBhOv5BNgrpvmb53ZTriAUL2b8k8IjkqPDJ9JYbrz+
         d5YA==
X-Gm-Message-State: AHYfb5jodBNyOUz7rBtpglAvh0wsHMXQVY8Z4n0bk8ZkboIwdPs4/iFJ
        atyPohtntJ5I3cwpOgcNZfLFmmP78u7ffizOAg==
X-Received: by 10.129.120.4 with SMTP id t4mr21251185ywc.422.1502747586208;
 Mon, 14 Aug 2017 14:53:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 14 Aug 2017 14:53:05 -0700 (PDT)
In-Reply-To: <20170814213046.107576-3-bmwill@google.com>
References: <20170808012554.186051-1-bmwill@google.com> <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 14:53:05 -0700
Message-ID: <CAGZ79kbv-zdCiShVOdpJsX1OEqUayMVq3zUYcfxJVA+JoFw3oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: add style build rule
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, Ben Peart <peartben@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 2:30 PM, Brandon Williams <bmwill@google.com> wrote:
> Add the 'style' build rule which will run git-clang-format on the diff
> between HEAD and the current worktree.  The result is a diff of
> suggested changes.

Notes from in-office discussion:

* 'git clang-format --style file -f --extensions c,h'
   to apply suggested changes. (Useful for contributors,
   maybe even as a precommit hook)
* you can also give a range of commits to git clang-format, as
   git clang-format --diff origin/master..HEAD to see if other
   local commits need tweaking.


>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index ba4359ef8..acfd096b7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2414,6 +2414,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>
> +.PHONY: style
> +style:
> +       git clang-format --style file --diff --extensions c,h
> +
>  check: common-cmds.h
>         @if sparse; \
>         then \
> --
> 2.14.1.480.gb18f417b89-goog
>
