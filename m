Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC6620286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbdIMVQU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:16:20 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38602 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbdIMVQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:16:19 -0400
Received: by mail-pg0-f65.google.com with SMTP id m30so638477pgn.5
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WxPXBxEJ9QsqNRlFlqsF3evPEtuRPiHjbaqnpNZ2Ggw=;
        b=HG4x9oSXyTootZ823TEWrnj7A/jhs9+W8WmYlgxUbMis3cipsKFj0NifBO2bzNzDX3
         s/VKlS5RgnygmQ682h1L8WjIe1TOZUvFcVgDYBjindz4aAiy3AX8Gi5QyLVVptrEtarB
         R4LfwMUHjRVSng6htqVkB8WJ8/BEbABoqDOQo1YWFTkUfagMLjOWWUAqlAN2UpRd5Ga+
         cKcSIH1gbSrJM65rXZulsnDIMk6iN3ZMlzAOE+q8HHbqnAjjiM9Knr9evulxhYXf4wnx
         fXbivAsUS9xhFG0moavUdB2aqe11c1NdQpjTfP03ul4D//u2U/K4BQ42Vl2CB6FxawFZ
         rbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxPXBxEJ9QsqNRlFlqsF3evPEtuRPiHjbaqnpNZ2Ggw=;
        b=umgBAfEGAke/1tHdDwkNhc+ixiPoxPqhZgAsXlnjYyA1MrPs4OPB4ZQyPyF3C+ydbg
         +QHQpK55iN6dze1/krlUTDqAeN27HvGoQTJ3yCao4prNA9ng3X/miw/tbPj4CwAsAPfT
         GGl79xow6jOkHxJEr28nZBrLWExqBgKbJT7OiRBKCPwED2coOmgQ/23CCl8nJDH2krW4
         dVt1CzuHfxVAfeBwBZqLTlzI9eTQQHJ15+wq8h8vYVKIJrT4/8NluIwXBiUm62xPtT31
         R4OeHxTpObvQTZzSQ0iiWE2fecmcWBYjU15QCr4e1aXC0nW/2TZAX9cE6b9kBGzN5PEv
         Q1Iw==
X-Gm-Message-State: AHPjjUi/UvfrnDVGfBO8AcrX6vo/bvfn9qdgQHr2uWHl84x1/Jv+y6zp
        IaeHMy9JLk3pIA==
X-Google-Smtp-Source: ADKCNb4AX5m5tQaB/H8WbEEJGDL9dACt1wJN7HgZKErRrRCihP9dsedGBQ6cdMLKcmYNbwoTvlzpuA==
X-Received: by 10.99.190.3 with SMTP id l3mr18845525pgf.79.1505337378964;
        Wed, 13 Sep 2017 14:16:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id g16sm26458221pfd.6.2017.09.13.14.16.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:16:18 -0700 (PDT)
Date:   Wed, 13 Sep 2017 14:16:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/7] convert less-trivial versions of "write_in_full() !=
 len"
Message-ID: <20170913211616.GL27425@aiede.mtv.corp.google.com>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171628.o4euxlzk4imlf4tv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913171628.o4euxlzk4imlf4tv@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> The prior commit converted many sites to check the return
> value of write_in_full() for negativity, rather than a
> mismatch with the input length. This patch covers similar
> cases, but where the return value is stored in an
> intermediate variable. These should get the same treatment,
> but they need to be reviewed more carefully since it would
> be a bug if the return value is stored in an unsigned type
> (which indeed, it is in one of the cases).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  entry.c              | 5 +++--
>  refs/files-backend.c | 2 +-
>  streaming.c          | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
