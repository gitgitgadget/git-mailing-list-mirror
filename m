Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6391F462
	for <e@80x24.org>; Mon, 29 Jul 2019 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfG2Pdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 11:33:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42178 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387887AbfG2Pdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 11:33:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so59735513eds.9
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+t11DXCLyk/c/2CdbkSPdAq+E30cVZHAU/WTu5bW7qM=;
        b=tUHOKoN+Aip3lm544jwbkrEDmqm/xyhTRibXoDiOzgarHIsUkRAWFuxjex+3H6yADw
         2SjLSn3NLwcgWC0rfXvB8Alu1v0P3zQfP+bneAYeguFvppDzGpQsLblyiBVyeiTeIRHn
         r92yqvH4/wu+fjOUHuDPlMyU6og6HOPQOPpLvMT68815e3MdV5xSrLhsFIyOl4yCVRVg
         p75BeH8a08HqsFOhapU0UnByqTdaTEM55N+8QYGYd/GcVXldQFV66IkyChgja7IOI0v+
         Rhc8BkKV5TryI514XY9GXxmDS4HdHwR5zEWsQocuMyNkcZAsrX2zPvKOGO+0flTRtE0x
         V9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+t11DXCLyk/c/2CdbkSPdAq+E30cVZHAU/WTu5bW7qM=;
        b=CnwVF9d53cNTzscJC+g/aQEOrJBWFkd9UahV+WSbF1YmWFImlpdTsG9cUE6BQngX6v
         G2dB7LIXAzSQ2v9fyCPlu4vaF5+MsTsHATvwxQ989fE2N8cGQysyUm1BVcYvLJSTspLL
         2HdVfxjDHtyfdg/wYV3JdK8AkDpmMBFk1xgREZnyI0tBje+PTlSD/JWjyPXsNJGl3ae8
         ht/WwyqfsxX/v62hULotLfpW9+a5HaCqvGNKseWDVR3TZoDnJ2sZawLCQLdu0d5iQ0cK
         qYaVb1hOSNu7fKaA9iBH4WEGwjjNPWffBor+0xUEGYDYiQelDYtAYSAx091uvVanC3Hl
         3U0A==
X-Gm-Message-State: APjAAAWzJXwBTpUUFCKm/CHoYOyqWN1yoUZF9If9seKPPnlU975MtXtm
        l3vzSNsaxX96+rgyh0NUaWg=
X-Google-Smtp-Source: APXvYqwmA8HjF1qV3SMX8SNfG/rK+IzEJa3DT/kJztC9zV9wBJgKbO26eHuJIxUEtLyQVs6tkBcpCw==
X-Received: by 2002:a17:907:20a6:: with SMTP id pw6mr74770407ejb.111.1564414432622;
        Mon, 29 Jul 2019 08:33:52 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id jr20sm11505169ejb.88.2019.07.29.08.33.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:33:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Olivier Bornet <olivier.bornet@puck.ch>
Subject: Re: [PATCH] Documentation/git-fsck.txt: include fsck.* config variables
References: <20190729093928.GP20404@szeder.dev> <20190729095914.30573-1-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190729095914.30573-1-szeder.dev@gmail.com>
Date:   Mon, 29 Jul 2019 17:33:51 +0200
Message-ID: <87sgqo6ejk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 29 2019, SZEDER G=C3=A1bor wrote:

> The 'fsck.skipList' and 'fsck.<msg-id>' config variables might be
> easier to discover when they are documented in 'git fsck's man page.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  Documentation/git-fsck.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
> index e0eae642c1..d72d15be5b 100644
> --- a/Documentation/git-fsck.txt
> +++ b/Documentation/git-fsck.txt
> @@ -104,6 +104,11 @@ care about this output and want to speed it up furth=
er.
>  	progress status even if the standard error stream is not
>  	directed to a terminal.
>
> +CONFIGURATION
> +-------------
> +
> +include::config/fsck.txt[]

Before this include let's add:

    The below documentation is the same as what=E2=80=99s found in
    git-config(1):

As I did for a similar change in git-gc in b6a8d09f6d ("gc docs: include
the "gc.*" section from "config" in "gc"", 2019-04-07). Sometimes we
repeat ourselves, it helps the reader to know this isn't some slightly
different prose than what's in git-config.

> +
>  DISCUSSION
>  ----------
