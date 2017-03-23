Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4491320958
	for <e@80x24.org>; Thu, 23 Mar 2017 20:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbdCWUap (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 16:30:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65444 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932259AbdCWUao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 16:30:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFD0468502;
        Thu, 23 Mar 2017 16:30:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sdEKIFsdZojKS6TpSzNBnBEvXd4=; b=Don/XR
        yVYgmouw5FEdnKmcgVe1+eCjnuFvmRGbnoWEpXH3hiKorQi2/Vr5j2t3H4h4peb4
        0vbHsE32WyBcK0OfA4LTzccS7S2ATjcEVmY6O6cB32OH0qk8DHVdgaDsPLckJegk
        NhHCOGGRg7+QZKD8BCnPShKuAc3+A9VxmBvcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S3DdZt4Okxq+4x0JP3SBpAkCbwZJDgCI
        5mmWufCwudgrQXIAHODpTbIbKeXPQV5ZfpRLPXqPRpDBhrfln5LfVV/N15WNiOHM
        5ZIpny0lkI0r1TUkReryPr/L7AmHVmaI163Ro81L0wbA0Da6F2xvhCbkLkA+yOs0
        rh1LNNxEq+I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D86E268501;
        Thu, 23 Mar 2017 16:30:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41C1C684FF;
        Thu, 23 Mar 2017 16:30:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
        <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703231716320.3767@virtualbox>
        <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
        <xmqqbmsrdcz4.fsf@gitster.mtv.corp.google.com>
        <20170323191721.7r5vrixtnx3cngdc@sigill.intra.peff.net>
        <FE4A3F88-0B86-4069-B141-2DFB9C4E269E@gmail.com>
        <20170323193823.gxodwqv4eshgtqbc@sigill.intra.peff.net>
        <3CC8E237-86EA-4F35-A03E-15BED5869403@gmail.com>
        <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 13:30:41 -0700
In-Reply-To: <20170323202002.lfpuglqawz4ooruw@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 16:20:03 -0400")
Message-ID: <xmqq7f3fbury.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95D76E6A-1007-11E7-9731-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> We can blacklist these branches with a regex in the travis.yml:
>> https://docs.travis-ci.com/user/customizing-the-build#Building-Specific-Branches
>
> I had a feeling it might be something like that. So we would all need to
> agree on the convention for WIP branch names. If other people like the
> idea, I'm happy to make a patch, but I don't want to impose my own weird
> conventions on everyone else.

I can go with any convention, but I'd be more pleased if you made
sure that "do not build this with CI" and "this is WIP" are kept as
two separate concepts, as I can see having some WIP that I do want
to get tested.

Perhaps a substring "/noci-" anywhere in the branch name, or
something silly like that?

> I don't blame Travis at all. But if the tool does not produce reliable
> results, then I will start to ignore it.

Yes, that is a real issue.  I was wondering if we can have a knob
that can be controled with the repository setting to limit which
"build jobs" are run, so that you can use that web UI to set an
"environment variable" that lists only .3 and .4 (which correspond
to these two OSX builds) and .travis.yml takes notice of the
variable setting, or something.
