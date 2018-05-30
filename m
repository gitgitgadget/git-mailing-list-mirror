Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FAE1F42D
	for <e@80x24.org>; Wed, 30 May 2018 18:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeE3SK4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:10:56 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:47030 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeE3SKz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cJDo7e6ROzIR8UL8AuW+kLObtWECjwMopu5v5Zv1iIU=; b=M6YWL7xr+YDN8UqPhi9r5LQ/8
        KamI1WkO2P62bnuD8njeQNqbtR0YLbVYWkf5FOHXG20lX2TGBSAR0CEFLLHW03XRR+TLuJqBW3MR2
        PsKfMeLTaf/WUOggOxmhM/4mKjMfmT9iXVuIBYJkbYBeNuBKCw5XijdAILWqYNnPQyX7PGM8jheUA
        fYJsm/HvXzxhRSDBiqjtFNrqgr2LX50zLjpNB1twEiHrXRez9yHaLjTR3tpHX7N+5+YgeQ6t3+43t
        QDWLk0LHDBe291p8rV4itZh/K6Yj00oEGgu4/BTXajx6TrL7EKOqDz5JIbUBDsgqtThstekcat3py
        Vsc8LHaEg==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:36476 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fO5Yi-00GG5Z-D4; Wed, 30 May 2018 14:10:53 -0400
Date:   Wed, 30 May 2018 14:08:54 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Stefan Beller <sbeller@google.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: verifying syntax for optional and replaceable content in man
 pages
In-Reply-To: <CAGZ79kbdbV8r6Vr06ECOy9XXnBO_r=F-XcQU3WCCtOuCr0cfiQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805301405200.9810@localhost.localdomain>
References: <alpine.LFD.2.21.1805300733440.10096@localhost.localdomain> <CAGZ79kbdbV8r6Vr06ECOy9XXnBO_r=F-XcQU3WCCtOuCr0cfiQ@mail.gmail.com>
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

On Wed, 30 May 2018, Stefan Beller wrote:

> On Wed, May 30, 2018 at 4:39 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   willing to submit some patches to standardize the syntax of man
> > pages in terms of rendering "optional" and/or "replaceable"
> > content, and it seems like "man git-config" would be a good place
> > to start:
> >
> > SYNOPSIS
> >        git config [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
> >        git config [<file-option>] [type] --add name value
> >        git config [<file-option>] [type] --replace-all name value [value_regex]
> >        ...snip ...
> >
> >   can i assume the proper (uniform) syntax for the above would be
> > (shortening lines):
> >
> >   ... [<type>] [--show-origin] [-z|--null] <name> [<value> [<value_regex>]]
>
> So the difference are the angle brackets around 'name', otherwise no
> change?

  more precisely, angle brackets would represent any "replaceable"
content, regardless of where it occurs.
>
> >   ... [<type>] --add <name> <value>
>
> all the same but angle brackets around name and value,

  same rationale as above, [<...>] would represent both optional *and*
replaceable content. and so on, and so on.

  the only other obvious inconsistency i've seen is, when referring to
an environment variable, i've seen both of:

  `VARIABLE`
  `$VARIABLE`

my personal preference is the one without the $ if just referring to
the variable, without trying to dereference it. but that's just me.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
