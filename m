Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5DA1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBVTi1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:38:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39115 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeBVTi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:38:26 -0500
Received: by mail-pg0-f66.google.com with SMTP id w17so2395440pgv.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zk9qY1Sb0GTImtcgVAwzAoac8u7rJVr7x0nV+YKRmuY=;
        b=GvbR5TDurCKC6jUyVopMuyA2z18PsK2SqZaea8VsAO9nWfEjw+j9zKXkgKJfdfVzeq
         hhRRmahdM5DPEvvGmqHnxt2epMaaV/IhYJYK1dij77C5wcCpl97t53Gax6bFPbIN1WMj
         FyL8GUPJXvuvRHnw0DcCcTpCPWjxAjZK1NEzC02lh51+6spfzIlZIfuJtYJ0oF7goiQx
         88iwVeW1BxDGySC/ed9yWynAFg0e/ofth2/Gnx22Sy+DsHJbGJSkcm+yG39Bj8dwEFdH
         JLKBHUi9+O+TWHRG49hcUMjrEB2PsausPi4hWfwL/MyFT/kW6HhNPPRidAyTrwlHLx6I
         NONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zk9qY1Sb0GTImtcgVAwzAoac8u7rJVr7x0nV+YKRmuY=;
        b=dHdy/J01X0nvWUR4ZpveOZcInVADM/HOMRCsFlOzOimJ7VHrWBcyZBLVtSTYhcHF6v
         rNJd33oTSZNHN0l+QvBncE7d2YxwFhLz3JdVNt7xQAW+4Js1SJ0cy4ISl0NVNV6khtBE
         Cvwi7RH1gX52Nhn9G6IuzCg+NoLT+h2z62dyb+wKdJrewAyEEyhS1z/QUqln3//6YepS
         +oK5m1OphJGSyDZsSXUsmrkJu0LETZgKv2lu9WE4ZaLg3j8X5fP5ZUNBElWLzLkVawNk
         /lIvG5o20V5p1PaNHXmzyv6VkigcsQqdicfR8IsQsko73LIJaWg+EIpn7irS3unN6FWU
         w/MA==
X-Gm-Message-State: APf1xPBaaRpS30ZJd3fdIdjoCSjOWp8kx26KqGxqwpUoYxKkP9dQm03j
        79V2ttJLULvfqu6TrUH1ajg=
X-Google-Smtp-Source: AH8x224ugntbNC8laE13eqfb0xFDDYsjZBsWoQI1E73W/+bvQd42wM9hVfqj5QocAxNq/iYNL4PNHw==
X-Received: by 10.101.80.6 with SMTP id f6mr6429397pgo.272.1519328305865;
        Thu, 22 Feb 2018 11:38:25 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m83sm1229526pfk.107.2018.02.22.11.38.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:38:22 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:38:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222193814.GA256918@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222181400.GA19035@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Feb 22, 2018 at 10:07:15AM -0800, Brandon Williams wrote:
>> On 02/22, Jeff King wrote:
>>> On Wed, Feb 21, 2018 at 01:44:22PM -0800, Jonathan Tan wrote:
>>>> On Tue,  6 Feb 2018 17:12:41 -0800
>>>> Brandon Williams <bmwill@google.com> wrote:

>>>>> In order to allow for code sharing with the server-side of fetch in
>>>>> protocol-v2 convert upload-pack to be a builtin.
[...]
>>>> As Stefan mentioned in [1], also mention in the commit message that this
>>>> means that the "git-upload-pack" invocation gains additional
>>>> capabilities (for example, invoking a pager for --help).
>>>
>>> And possibly respecting pager.upload-pack, which would violate our rule
>>> that it is safe to run upload-pack in untrusted repositories.
>>
>> And this isn't an issue with receive-pack because this same guarantee
>> doesn't exist?
>
> Yes, exactly (which is confusing and weird, yes, but that's how it is).

To be clear, which of the following are you (most) worried about?

 1. being invoked with --help and spawning a pager
 2. receiving and acting on options between 'git' and 'upload-pack'
 3. repository discovery
 4. pager config
 5. alias discovery
 6. increased code surface / unknown threats

For (1), "--help" has to be the first argument.  "git daemon" passes
--strict so it doesn't happen there.  "git http-backend" passes
--stateless-rpc so it doesn't happen there.  "git shell" sanitizes
input to avoid it happening there.

A custom setup could provide their own entry point that doesn't do
such sanitization.  I think that in some sense it's out of our hands,
but it would be nice to harden as described upthread.

For (2), I am having trouble imagining a setup where it would happen.

upload-pack doesn't have the RUN_SETUP or RUN_SETUP_GENTLY flag set,
so (3) doesn't apply.

Although in most setups the user does not control the config files on
a server, item (4) looks like a real issue worth solving.  I think we
should introduce a flag to skip looking for pager config.  We could
use it for receive-pack, too.

Builtins are handled before aliases, so (5) doesn't apply.

(6) is a real issue: it is why "git shell" is not a builtin, for
example.  But I would rather that we use appropriate sanitization
before upload-pack is invoked than live in fear.  git upload-pack is
sufficiently complicated that I don't think the git.c wrapper
increases the complexity by a significant amount.

That leaves me with a personal answer of only being worried about (4)
and not the rest.  What do you think?  Is one of the other items I
listed above worrisome, or is there another item I missed?

Thanks,
Jonathan
