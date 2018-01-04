Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA85D1F404
	for <e@80x24.org>; Thu,  4 Jan 2018 20:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeADUGa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:06:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADUG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:06:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F220B6032D; Thu,  4 Jan 2018 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515096389;
        bh=f/Jxj8PiHEsWa0IbZ356nd49+jxA2IlfiQrcDDcUj0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbl5FIUUjEDU2pKpR1chaxROh593eNI7YNtjkmv/qKg4J7Eg++D3al+Y1zOYl1f1o
         Y8IILO7I1ddhozjocR5A9PZDvJJ5eXSVyhzZ8wyikHHuUqJb4+ye9EwderIo1aa0en
         LKeEYZkMDEiW7dFq5064bqZwijRQvZCQaDxAJhJo=
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E32C602B9;
        Thu,  4 Jan 2018 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515096388;
        bh=f/Jxj8PiHEsWa0IbZ356nd49+jxA2IlfiQrcDDcUj0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfkxlL2+lxq3ZMhYr3BbUsqAu8A8DI3KQevjC1jnqgzBmbxO9FOops8OtAShBefXZ
         HQQh9WNDmMGg4dp8ju6qQhQKmD6L5ExzOfsQ7w3XLZe8lbjCJO7aILD33z51weARck
         +Y4qP2SzTAFK08MVvcHEBZvdI9xolTH+g3MPavo0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E32C602B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Date:   Thu, 04 Jan 2018 13:06:27 -0700
Message-ID: <45915667.ye9M3CbBo5@mfick-lnx>
User-Agent: KMail/4.13.3 (Linux/3.13.0-125-generic; KDE/4.13.3; x86_64; ; )
In-Reply-To: <20171226203153.GA21429@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <20171226180436.GA28565@thunk.org> <20171226203153.GA21429@Carl-MBP.ecbaldwin.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, December 26, 2017 01:31:55 PM Carl Baldwin 
wrote:
...
> What I propose is that gerrit and github could end up more
> robust, featureful, and interoperable if they had this
> feature to build from.

I agree (assuming we come up with a well defined feature)

> With gerrit specifically, adopting this feature would make
> the "change" concept richer than it is now because it
> could supersede the change-id in the commit message and
> allow a change to evolve in a distributed non-linear way
> with protection against clobbering work.

We (the Gerrit maintainers) would like changes to be able to 
evolve non-linearly so that we can eventually support 
distributed Gerrit reviews, and the amended-commit pointer 
is one way I have thought to resolve this.

> I have no intention to disparage either tool. I love them
> both. They've both made my career better in different
> ways. I know there is no guarantee that github, gerrit,
> or any other tool will do anything to adopt this. But,
> I'm hoping they are reading this thread and that they
> recognize how this feature can make them a little bit
> better and jump in and help. I know it is a lot to hope
> for but I think it could be great if it happened.

We (the Gerrit maintainers) do recognize it, and I am glad 
that someone is pushing for solutions in this space.  I am 
not sure what the right solution is, and how to modify 
workflows to deal better with this.  I do think that starting 
by making your local repo track pointers to amended-commits, 
likely with various git hooks and notes (as also proposed by 
Johannes Schindelin), would be a good start.   With that in 
place, then you can attack various specific workflows.

If you want to then attack the Gerrit workflow, it would be 
good if you could prevent pushing new patchests that are 
amended versions of patchsets that are out of date.  While 
it would be great if Gerrit could reject such pushes, I 
wonder if to start, git could detect and it prevent the push 
in this situation?  Could a git push hook analyze the ref 
advertisements and figure this out (all the patchsets are in 
the advertisement)?  Can a git hook look at the ref 
advertisement?

-Martin


-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

