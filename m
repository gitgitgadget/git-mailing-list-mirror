Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EF81F403
	for <e@80x24.org>; Thu,  7 Jun 2018 01:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeFGBtN (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 21:49:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62978 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbeFGBtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 21:49:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB7D6EE97E;
        Wed,  6 Jun 2018 21:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=MaWwTXDImOi3reK/Wx8O115GZyw=; b=bvNU8yz
        /kQmOwdx79ZTszDuJD8bc4kAEFX2OhyPjQTGUd6ICJckfYfTVlpu95VT89WmCOas
        k5qQ4BJBKuFl426q6NZrfIe2LbiSFuqSEwCJht2lZmefW9qS6MLjcD3Hjbqq2TY2
        I2oHFt/XiwyJfMR8pbY7qUPb0qt+iOKRdHJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=aDqZUknpmFzQaX4MzskVi3KRLlHDBQRrS
        0imSA0HBhWwCuyr/cxrhRIDRT2HTlkjldz8JtbfGVQdo6g2KmzsdrsmBpQbGbulP
        TocRAlvffrEwQ5QXzhk9VdHDUY2Nkrgbxpnh0hUWIsyHtO4DYA47E5zlceL8yE9o
        0osYARCaKQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1002EE97D;
        Wed,  6 Jun 2018 21:49:11 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B104EE979;
        Wed,  6 Jun 2018 21:49:11 -0400 (EDT)
Date:   Wed, 6 Jun 2018 21:49:09 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Message-ID: <20180607014909.GL3094@zaya.teonanacatl.net>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
 <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: F98284A2-69F4-11E8-A738-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:
[...]
> I don't run the p4 or svn tests, so ... :-D

Heh, lucky you. :)

I try to run them all as part of the fedora builds since
they cover much more than I'd ever use.  That's the main
reason I noticed the bare python.  That would trip me up
when it came time to build on a near-future fedora where
python isn't installed by default and I only wanted to
require python3 for the build/runtime scripts.

> On 06/06/18 22:03, Jeff King wrote:
>> really the only user in the whole code base outside of a few fringe
>> commands). Leaving aside any perl vs python flame-war, I think there's
>> value in keeping the number of languages limited when there's not a
>> compelling reason to do otherwise.
> 
> I agree that fewer languages is (generally) a good idea.

Yep, that's certainly even better and if Jeff H. can use
perl relatively easily (or one of the many perl folks here
can help with that part of the test), that's great.  The
best way to solve many problems is avoid having them. :)

Thanks,

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Chaos, panic, and disorder - my job is done here.

