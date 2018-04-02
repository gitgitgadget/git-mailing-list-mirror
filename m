Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5F41F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeDBRfx (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:35:53 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:45882 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeDBRfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:35:51 -0400
Received: by mail-yw0-f179.google.com with SMTP id r29so5220502ywa.12
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CvB+jAkBTlnxGeDzlF+OJE+prJ1Na1EoWpre2zXVg+Q=;
        b=arEk3Gsv4uc7YRzPw6DwFPjGj0hjrt/r921jGaFX2dq0aOzPptw/+XY4HFXD5FDigj
         lPObHRXPAe1VIE4LBc3e7mfCQx+rNy7sROdAiKVk+V1DbTFehLHewrpFbnlobeq+ASeO
         jIrIb2hUQ+Tf15Ax6kaMkGX4lw5PB4sZHUvGLaiDGBEgCG6XX5/yo45Qq6eGO3jlDgKQ
         2JtfMLoanb5HgZUt21KLB51tXYUZXU5dbXKYc9xDzqka0kc6VJ2O16dwhKS39MHAKSgX
         /t8u8srUvfV5aNtWTOdruUaNix5lPFmcdffxQ0mt0Yx34Vjnft13A7IWj0RsRaQTyWpX
         KN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CvB+jAkBTlnxGeDzlF+OJE+prJ1Na1EoWpre2zXVg+Q=;
        b=k3sML44rs/pFtgMDS6DlvmJ+UMmypGkdSZKTsgP5O+HHEc9OvU4iivcpI0Mp8G7Tuw
         4frpIDpRx0lzar7Itzwo7kAo34LklO5ikp2RS7opc3cLkZw3Y0ef2UIGwduLvA3E8Y4P
         M78JIXgDOxNM1cyjzNJf2B5gktVPbCwhimb3QOz8AnkTVXl40wily8iMo/GfwfneLPj9
         Y3HGhE9UKlfFhMjzQ4Q7FJwI1Hs1GLiGBMy1saJtUP0GxpMNA0HeBskZZRlRR4e47rKo
         Qg3O86RFsnOFeyLeaF2ecpNiBenZWBYZDdXrGra14qW0LBLWsALiVmYoHibd7bfWBe+4
         OWXQ==
X-Gm-Message-State: AElRT7EfhfZP4qFNL6U8WSF9W7MlFha/UgPJw3ckNbKDDI3d3AcZ5Vud
        XJIfkK5Ev4hi9SlLt0BUnNqgDdhMeVW/Rvt8d2S2+g==
X-Google-Smtp-Source: AIpwx4+RU37jl1JY/zSnMLSPZgy4D87nOEL9DgnDtVp5x1E4mp92aqsOwUI6aGssJp1vRWvuhySE38tyjvzniSdh+b0=
X-Received: by 10.129.108.67 with SMTP id h64mr5975296ywc.500.1522690550702;
 Mon, 02 Apr 2018 10:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 2 Apr 2018 10:35:49 -0700 (PDT)
In-Reply-To: <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <867eptkeeq.fsf@gmail.com>
 <f5d8934e-afc2-39d4-b7d5-e5ba5e5021a1@gmail.com> <861sfxekeo.fsf@gmail.com> <d3060103-7fab-3b6c-e968-cb49f3f23acb@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Apr 2018 10:35:49 -0700
Message-ID: <CAGZ79kaoDNNcu8zqaTnoXWfJ0FnLwqvZfOHUniG-izndAjvDVw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 2, 2018 at 8:02 AM, Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> I would be happy to review any effort to extend the commit-graph
>>> format to include such indexes, as long as the performance benefits
>>> outweigh the complexity to create them.
>>>
>>> [2]
>>> http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.719.8396&rep=rep1&type=pdf
>>
>> The complexity of calculating FELINE index is O(|V| log(|V|) + |E|), the
>> storage complexity is 2*|V|.
>>
>
> This would be very easy to add as an optional chunk, since it can use one
> row per commit.

Given this discussion, I wonder if we want to include generation numbers
as a first class citizen in the current format. They could also go as
an optional
chunk and we may want to discuss further if we want generation numbers or
FELINE numbers or GRAIL or SCARAB, which are all graph related speedup
mechanism AFAICT.
In case we decide against generation numbers in the long run,
the row of mandatory generation numbers would be dead weight
that we'd need to carry.

I only glanced at the paper, but it looks like a "more advanced 2d
generation number" that seems to be able to answer questions
that gen numbers can answer, but that paper also refers
to SCARAB as well as GRAIL as the state of the art, so maybe
there are even more papers to explore?

Stefan
