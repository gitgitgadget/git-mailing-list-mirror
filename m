Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 045A920323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbdCVWOU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:14:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33967 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdCVWOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:14:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so28801829pfb.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xd1QGHUoXQBRdmOs3yvwBjBAZN5q50R07q93ipa44ZA=;
        b=c0GfIb871ZinL4FMIVMf8dFnCQFToECkh1SxQRRXbToUpES9t+esEkGj2WrKA8BI48
         32SotCVdTMO82+gUsNHBunuwjwa36UZNUIutvGK3DXNHX4vB+/01vE9Tqa2oHbo8Q1Ug
         QFFhRN8nMLJwpZNvt4SVunkzHHr9/sc8lZp9cPgCQ02P2ZftLMrZ31V7JjCaz8i7QcNm
         QPfH3hnUtbqhiTVP8BPgfvoqnNk/582qCBIA1ZFnokYfxY1/uUaLMfbS11fXwiFYqeJd
         xLv6KXyQKFZK6CyXY51hFqFP1E3XBH1zZHWV8zgn3XHo2785v8Y7e+OcEXuttYmRxMzM
         W4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xd1QGHUoXQBRdmOs3yvwBjBAZN5q50R07q93ipa44ZA=;
        b=SOY3BVnGxUSVEjTk1uLkZBHTnh8HtH7LUDYAj2ZtWp8r83EEOpky0BGHl9o7G7gCjo
         X+uEgDVGlMFnbQoo8cSxiVdAcEgTooC1bto9JHvYEi1xDWdVHZo/V5mF0Sk4UthG2HGE
         FK6G0OamslSh3ukYAmOMgTgWWHDvizEA4uFKIO8uViuBynUXnhCOC+o3dT+8ua02OBNp
         3/rXZehQvylfTSOW0YiGa3mJTj2KLotGoYKUn+bQtcHp73LbnBpblL4Ao0w8AMSyMwpt
         2MR8zLqcqpRsv5V+a1zPDWa7Nw9YHDZchhGksZ0cjTitM0F9jiQ+N27PzpPGE2zp1tBm
         leYw==
X-Gm-Message-State: AFeK/H0H3ax3435R3BzDYNLBW9kMXq1G5gqDBC8NrmOdR7a1SsxOv64nNaC74168yw/K4w==
X-Received: by 10.99.96.72 with SMTP id u69mr2769816pgb.194.1490220857068;
        Wed, 22 Mar 2017 15:14:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id h14sm5854122pgn.41.2017.03.22.15.14.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:14:16 -0700 (PDT)
Date:   Wed, 22 Mar 2017 15:14:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial
 population
Message-ID: <20170322221414.GE26108@aiede.mtv.corp.google.com>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
 <20170322214948.12015-1-sbeller@google.com>
 <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
 <CAGZ79kbFjCQB_k8E1dMVop_EGF6TpnY04U1NV60VmSs1zHOnZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbFjCQB_k8E1dMVop_EGF6TpnY04U1NV60VmSs1zHOnZw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Wed, Mar 22, 2017 at 2:59 PM, Jeff King <peff@peff.net> wrote:

>>   sq=\'
>>   test_expect_success '...' '
>>         cat >expect <<-EOF
>>         Execution of ${sq}false $submodulesha1${sq} ...
>>   '
>>
>> but I'm not sure if that is any more readable.
>
> If I recall correctly, I made a big fuss about single quotes used correctly when
> writing that patch (which is why I may have lost track of the actual work there)
> to be told the one and only blessed way to use single quotes in our test suite.
>
> Your proposal to use ${sq} sounds good to me, though we did not
> follow through with it for some other reason. I can reroll with that, though.

I don't know what you're referring to by only and blessed way, but it
might be the following.  If you want to use single-quotes on a command
line using $sq, you would have to use eval:

	eval "some_command ${sq}single-quoted argument${sq}"

which is generally more complicated than doing the '\'' dance:

	some_command '\''single-quoted argument'\''

But the example in this thread is different. In the here-document you
are in an interpolated context so the ${sq} method or '\'' would work
equally well.

Hope that helps,
Jonathan
