Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E881F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 20:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdH2UI2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 16:08:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:40315 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdH2UI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 16:08:27 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B28ED845DD;
        Tue, 29 Aug 2017 16:08:26 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 53119845D1;
        Tue, 29 Aug 2017 16:08:26 -0400 (EDT)
Subject: Re: [RFC 0/7] transitioning to protocol v2
To:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jonathantanmy@google.com
References: <20170824225328.8174-1-bmwill@google.com>
 <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <20170825173550.GJ13924@aiede.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2ff0ead4-e13a-220e-f858-36ab206c1485@jeffhostetler.com>
Date:   Tue, 29 Aug 2017 16:08:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170825173550.GJ13924@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/25/2017 1:35 PM, Jonathan Nieder wrote:
> Hi,
> 
> Jeff King wrote:
>> On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:
> 
>>> Another version of Git's wire protocol is a topic that has been discussed and
>>> attempted by many in the community over the years.  The biggest challenge, as
>>> far as I understand, has been coming up with a transition plan to using the new
>>> server without breaking existing clients and servers.  As such this RFC is
>>> really only concerned with solidifying a transition plan.  Once it has been
>>> decided how we can transition to a new protocol we can get into decided what
>>> this new protocol would look like (though it would obviously eliminate the ref
>>> advertisement ;).
>>
> 
>> I don't think libgit2 implements the server side. That leaves probably
>> JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
>> and GitLab use.
> 
> I'd be happy if someone tests the patches against those. :)

I just wanted to jump in here and say I've done some initial
testing of this against VSTS and so far it seems fine.  And yes,
we have a custom git server.

VSTS doesn't support the "git://" protocol, so the double-null trick
isn't an issue for us.  But "https://" worked just fine.  I'm still
asking around internally whether we support passing SSH environment
variables.

Jeff

