Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1ECC1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 11:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeFDLFk (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 07:05:40 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:55468 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeFDLFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 07:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wu/Pev8/Qw+bvZR7vleqJJp9EtQrc/ca0rKt04RSv7M=; b=bPw60NfWT921h7jTLwKQW31fa
        Bj9MxlfLbkC8oXusHMM2/V8gjDZ8zY7vODgvkgQxEkKI7/7N+ns84x/9iRi27OKhgjnbG/Ki7wK86
        2lb2WcU0ydqn7feZBHmKn1dw5NKq3rCLI3tXLW2PG8q3z2q1WL3OOYdbBgTtjljLtBSgc+RhCXNcb
        THZ8bv3xqSmvtwDWklULoZcespZPbgjj+It44F+BOdus2g8z1w+IS2/S8a5uEK/G2VmJXFqWHvgnv
        nIzebyirLjuYDGK4r+Kp5R3Z/EPBzV1mH0CZHjlp601XFWKckt1xHcOxQ0tDpO4/JwFb6ZFvl6AWn
        NQK69riHw==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:45586 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPnIs-00AcNG-Bc; Mon, 04 Jun 2018 07:05:38 -0400
Date:   Mon, 4 Jun 2018 07:03:25 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Philip Oakley <philipoakley@iee.org>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/perf/run: Use proper "--get-regexp", not
 "--get-regex"
In-Reply-To: <0AE4648A05C445FBA049864F455B35A7@PhilipOakley>
Message-ID: <alpine.LFD.2.21.1806040659590.11594@localhost.localdomain>
References: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain> <20180603133039.GF26159@hank.intra.tgummerer.com> <alpine.LFD.2.21.1806030935010.21364@localhost.localdomain> <0AE4648A05C445FBA049864F455B35A7@PhilipOakley>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 3 Jun 2018, Philip Oakley wrote:

> From: "Robert P. J. Day" <rpjday@crashcourse.ca>
> > On Sun, 3 Jun 2018, Thomas Gummerer wrote:

> >> --get-regex works as the parse-option API allows abbreviations of
> >> the full option to be specified as long as the abbreviation is
> >> unambiguos.  I don't know if this is documented anywhere other
> >> than 'Documentation/technical/api-parse-options.txt' though.
>
> it's in `git help cli`:
>
> many commands allow a long option --option to be abbreviated only to
> their unique prefix (e.g. if there is no other option whose name
> begins with opt, you may be able to spell --opt to invoke the
> --option flag), but you should fully spell them out when writing
> your scripts;
>
> It's a worthwile read, even if the man page isn't flagged up that
> often.

  agreed that it's a good read and should be referenced more often.
one thing i don't see there, and it's based on an observation someone
once made (i believe on this list), is that even if there is
absolutely no ambiguity in a command, even if there are no pathspec
arguments, it's still worthwhile to add a trailing "--":

  $ git command options/treeish ... --

since that guarantees that git will waste no time trying to identify
any ambiguity since you're being so precise. is that worth mentioning
in that page?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
