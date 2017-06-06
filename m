Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5D720D09
	for <e@80x24.org>; Tue,  6 Jun 2017 22:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdFFWwz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:52:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34357 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdFFWwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:52:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id u1so711992pfg.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fZjFrKZkCl+S+/cMZ7X1vZ2KvRHsHOjGFhB303Rll8=;
        b=fVKo+9AGEjmhv3YF7NgLLECjPck5sqG+10WGxf6wR6KjHuktxfoCfFPNZTomoGucBE
         42BKNItNYp3pffcQn3fU8sC2A0BOixMMzNKRST4uFw8Otu1aTNWXys4aRzN8ZqwLtAIL
         ia9/u/CG54aGsaQQ3GhVrHZybmpYTJNQ9gSaBnErj8zjRMhN8qEedV5EelZjtdI2hT7a
         ix1fd3mtDcRo5//Uz4eZeoQXxi2VITKeeLK3J01TlCHDiZCW/7d5C1aJyCmiDy078wHe
         lUTHopooWAnLWym2yQQy6HereX6qm+v4hsZAcnhvMGRRGuDxwIiCevVS1G7mrGGgcXsh
         +CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fZjFrKZkCl+S+/cMZ7X1vZ2KvRHsHOjGFhB303Rll8=;
        b=aYbdXcQHWvEKacuuc5aIPh0doBdgDzcEkgV3Z7GQ8W1HB86d0z1wCEBPmxOAarasU0
         qpuQkp5ANBwFwGj3Bhn0zLaz7zQbogfS5IyZhmZ3/dNweWj//kLooDG00eKcL1TQ6ygo
         FSEsoabEZeE77VukMapNQGdzR/anD4jFKgI+McCcKTpwLMl2N3SJbqjx/AG3zbLhBBvn
         uSn2tbcALmc7fxJnMVK+ivoF2dES8ikIt+zCk3dBNjAStN/lRZHXWcdNAx73tXUYdM8H
         Z8YGuvjiAvDtXQHvB30Hg2N3Zn1hlP9Katlz97T9QWl7NXrBJf3HWAW6TFqvftYq0/sR
         JVSQ==
X-Gm-Message-State: AODbwcCQa1oV2fyz+A/2fTMyxRqxJ4Zgiz1Gh2nDoQjWwFizgSGmJDxE
        ltky0CwEIMDX4A==
X-Received: by 10.84.140.164 with SMTP id 33mr24348607plt.142.1496789573620;
        Tue, 06 Jun 2017 15:52:53 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5be:2d73:26a4:30ee])
        by smtp.gmail.com with ESMTPSA id t20sm27949265pgo.29.2017.06.06.15.52.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 15:52:52 -0700 (PDT)
Date:   Tue, 6 Jun 2017 15:52:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests
 for console output
Message-ID: <20170606225249.GD21733@aiede.mtv.corp.google.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net>
 <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
 <20170602175455.GA30988@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
 <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Tue, Jun 6, 2017 at 3:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:

>> In my mind, it would have made sense to ask well-respected cryptographers
>> about their opinions and then try to figure out a consensus among them (as
>> opposed to what I saw so far, a lot of enthusastic talk by developers with
>> little standing in the cryptography community, mostly revolving around
>> hash size and speed as opposed to security). And then try to implement
>> that consensus in Git.
>
> Sounds good to me. That is why I personally think point (4) from
> Jonathans list above over-emphasizes performance/size over security.

The very least the only kind of replies my example task (4) led to
were of this kind, so you can get a clear sense of whether the
community values performance over security. :)

I happen to think that performance and security both matter and are
related (since if performance regresses enough, then people end up
using the faster but insecure thing).  This has shown up in the
history of SSL, for example.  But I am very happy to see people
focusing more on the security properties than the performance
properties --- that is a correct prioritization.

Jonathan
