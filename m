Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA661F461
	for <e@80x24.org>; Thu, 29 Aug 2019 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH2Uam (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 16:30:42 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39123 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfH2Uam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 16:30:42 -0400
X-Originating-IP: 1.186.12.40
Received: from localhost (unknown [1.186.12.40])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EE4C7FF803;
        Thu, 29 Aug 2019 20:30:39 +0000 (UTC)
Date:   Fri, 30 Aug 2019 02:00:37 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
Message-ID: <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com>
References: <pull.325.git.gitgitgadget@gmail.com>
 <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
 <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
 <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/08/19 04:07PM, Derrick Stolee wrote:
> On 8/29/2019 2:54 PM, Phillip Wood wrote:
> > Hi Stolee
> > 
> > On 29/08/2019 18:01, Derrick Stolee via GitGitGadget wrote:
> >> +   
> >> +    if (argc == 3 && !strcmp(argv[1], "-b")) {
> >> +        /*
> >> +         * User ran 'git checkout -b <branch>' and expects
> > 
> > What if the user ran 'git checkout -b<branch>'? Then argc == 2.
> 
> Good catch. I'm tempted to say "don't do that" to keep this
> simple. They won't have incorrect results, just slower than
> the "with space" option.
> 
> However, if there is enough interest in correcting the "-b<branch>"
> case, then I can make another attempt at this.
 
You can probably do this with:

  !strncmp(argv[1], "-b", 2)

The difference is so little, might as well do it IMO.

-- 
Regards,
Pratyush Yadav
