Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFEAC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505E46127C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 15:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhFRPRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:17:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:15089 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232676AbhFRPRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 11:17:34 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1luGDL-00079h-F6; Fri, 18 Jun 2021 16:15:23 +0100
Subject: Re: [PATCH] doc: warn people against --max-pack-size
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
 <YL8RfGijMY95miHI@coredump.intra.peff.net> <xmqqfsxsq1l4.fsf@gitster.g>
 <YL8bQMOAHxApjVVe@coredump.intra.peff.net>
 <d73194b2-2fc9-80d3-d13c-fb5db3757e01@iee.email>
 <YMye+mkRPD0BkULX@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <de7239bc-d68e-c9f5-1c97-87df24cfe7b1@iee.email>
Date:   Fri, 18 Jun 2021 16:15:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMye+mkRPD0BkULX@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/06/2021 14:26, Jeff King wrote:
> On Thu, Jun 17, 2021 at 06:02:27PM +0100, Philip Oakley wrote:
>
>> On 08/06/2021 08:24, Jeff King wrote:
>>> +The minimum size allowed is limited to 1 MiB. The default is unlimited.
>>> +Common unit suffixes of 'k', 'm', or 'g' are supported.
>> Do we want to include the workaround of scaling in kibibytes (as
>> originally mentioned by Bagas) for the default as 1024k? This also
>> avoids the easy mistake that the size is in multiples MiB.
> I'm not quite sure what you're asking. If you mean: should we tell
> people that they can't use "4.9m" and should instead use "5017k"
> instead, then I don't have a strong opinion.

Sorry, I should have included an example based on the patch

> +The minimum size allowed is limited to 1 MiB. The default is unlimited.
> +Common unit suffixes of 'k', 'm', or 'g' are supported.

e.g.

+The default is unlimited. Common unit suffixes of 'k', 'm', or 'g' are
+supported. The minimum size allowed is limited to 1 MiB (`1024k`). 

I swapped the sentence order to allow the scaled example of the minimum
to be after the explanation of the suffixes
>
> It might help some people. But OTOH it's not clear to me that this is a
> common question, so it might clutter up the documentation. Either way,
> it's orthogonal to the patch in question, and should come on top if
> somebody cares to work on it.
>
> I'd also be fine with somebody actually implementing fractional unit
> support (it would probably go into git_parse_signed() and
> git_parse_unsigned()). It doesn't seem worth the effort to me, but if
> somebody feels strongly enough to implement it cleanly, I wouldn't say
> no. :)
I'd agree about not offering fractional values, but showing the use of
smaller units was an easy tweak.

Philip
