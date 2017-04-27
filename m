Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66E9207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162608AbdD0WTg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:19:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33832 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034384AbdD0WTe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:19:34 -0400
Received: by mail-pf0-f180.google.com with SMTP id e64so1925930pfd.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c4XeaJCyeU7OBPaYNnYSUmLOYeGCG6LVL+EMSwXi6nc=;
        b=fUgncYStXIpbdhta5mcZS/ODM4fZegYe50uf6/CcBJbs1iUmho50sXcQwXD/+FwWj6
         JH/mnrD8eqKpNPoA1/jjWvQC4ySoM/0LRPrbmhHBYCw3mF2qr45Dh2gXrZnN7svB8KFh
         8T0FRylomaP3IALuBqYRKLqPJO9vhNo82QLwivb4OZiftoVc6f0kbJbkWml/hkXE5m/M
         0zej5ZbndkTCAmwmv8IPOvynZCljhi6kSKewhW/D+sU4rKjeKXolT/Vxq8DxNulcPrS1
         g2Z0QJ+Lcpdlo3nMam+bXq1cYCD5YHtc/hzPuS+AeUe0asYFQxGobC1lhe3UuY1LQUPL
         wOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c4XeaJCyeU7OBPaYNnYSUmLOYeGCG6LVL+EMSwXi6nc=;
        b=pjUNO2lVTLs5W5ACBLnhAER1gZolLnGwOMD2NUgAcHkkUezf/w1kbTAAdT0pQ3xKv9
         wD3cwyRWUIh2khf8r0ZWf9dLm0xNITx2awyjKHiQCJpaMqvbLeOwYjWV4OpDXDnHj/tx
         wjzxKtm/7oIZBn8ATVz85UmK1w8XRZnRKEA/dxvj71+hVSBm960S+hBUbAumqXkMBsQl
         /OgRH2/qmACveFeK11IB4/Az+69PTbbbVjQUVjBACqTThXXXj3Gjyc467JrlG3Z9TGCV
         T0+40QUEoAXmRuJazFWKYgN9og8S6tESJhP4duJXlkA0dPpPnMAiJ3Bv2xi4+IhP4ZJy
         7V2g==
X-Gm-Message-State: AN3rC/7fGGuQ+YdVNbT2GnZgUqIwD9kdNF8zCH17OyGa0h5iIMciLS5j
        8/Toq7PkyVGSIgO/
X-Received: by 10.98.22.78 with SMTP id 75mr8298154pfw.131.1493331573759;
        Thu, 27 Apr 2017 15:19:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6199:b109:ce03:97f2])
        by smtp.gmail.com with ESMTPSA id 129sm5934478pgj.23.2017.04.27.15.19.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 15:19:32 -0700 (PDT)
Date:   Thu, 27 Apr 2017 15:19:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/5] clone: add a --no-tags-submodules to pass
 --no-tags to submodules
Message-ID: <20170427221931.GC146047@google.com>
References: <20170426231236.27219-1-avarab@gmail.com>
 <20170426231236.27219-5-avarab@gmail.com>
 <CAGZ79kbsRv058PVwaWNtxKOH2LFnGk=VFTtt39FTqujkbz5E5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79kbsRv058PVwaWNtxKOH2LFnGk=VFTtt39FTqujkbz5E5A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/27, Stefan Beller wrote:
> On Wed, Apr 26, 2017 at 4:12 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > From: Brandon Williams <bmwill@google.com>
> >
> > Add a --no-tags-submodules which does for --no-tags what the existing
> > --shallow-submodules does for --depth, i.e. doing:
> >
> >     git clone --recurse-submodules --no-tags --no-tags-submodules <url>
> >
> > Will clone the superproject and all submodules with --no-tags
> > semantics.
> 
> My gut reaction to this is that it is ugly and maybe we should rather have
> a --no-tags[=<repo-spec>].

See my gut reaction to that is: that's ugly :).  The --no-tags option
should just be propagated down (like I mentioned in another thread).

> We have had the discussion for e.g. git-push, for which we would like to
> have a way to specify to push the superproject, or some submodules or
> all of them, or just the superproject and changed submodules,
> such that there we have a "git push --recurse-submodules= \
> [check|on-demand|only|no]" which comes close to what I mean by
> "repo-spec".

This makes more sense to me in terms of pushing...its still not my
favorite ui design but its what we have.

-- 
Brandon Williams
