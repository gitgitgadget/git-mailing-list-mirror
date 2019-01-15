Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472F1211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 19:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfAOT6S (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:58:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39755 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfAOT6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:58:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so1684873pgl.6
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fmZJzXnDcZVGeN+I8rj2qj/zzIz0bG4l9KSZtvyOWEg=;
        b=prZ/ABlh+/9btUT5o4GZgWuybGaUdOJVQKplbzMKUPnzLqgE1wIaX/cTM8Q7tYv+gf
         rl2+OEif9YtTstOFeUjxnC2Cp5sIf57zuICDjDaVc30IZdTDQ6+xej+PrqOm9EwsNHQ5
         fzFhxL/1mTcGD9l0YSue8O4AATe4Llra7ITxqDOH5iH0qbntEfabGtErGVhAzkz8ixgz
         c71FQ+OrM8DPqJt+E0rP3nqiAQWN6237at7MnowWEgaVUO15sDdhQUKPR4Ly8UPUbSb6
         lb31M+aQCAeXOmSTfG9/9Yc2s9474hNepT3Diuefhse8MmOThL8+QIagnB7/Y0MhVeYm
         jecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fmZJzXnDcZVGeN+I8rj2qj/zzIz0bG4l9KSZtvyOWEg=;
        b=nenWLA1hmigRs/7844q3B4jpEJmCj10RDsscSeq5ynBKRYMIs/3HMmLIZkmnIU5ok1
         BUnlHP5wHjHu2w4UkNlgUijh4Z49PvnFfNkeguvJ26ve39vH3BwkAIdzfIfOF6FxT6HI
         SozlGqCjP2Bjqqx/4wrZoRHlIesdLa1TEDfb5ZIctXYr11ZsJ+iFb/0ivobbwe0P1qYf
         8LwK2xLcDNmdIngOSU7zpmzMrIUA1/0UZpOZftncAuHF1fXvtRkgpvXXKD4mCzVHXAoI
         zGkmvqL0eQyOFRnPDj0DXB9sUEcEhokBF7lCBKWByxECE/bhlmXCEg6MZ9cZurhzBQKz
         y2Tw==
X-Gm-Message-State: AJcUukcjbrdJayBXVIOtJTPNTzM3GW8oykrKHsAuYc2eHGrHmsxgAM+r
        JqDAvnM8mREkOtzkhqTArqDa5jXWUvqMWg==
X-Google-Smtp-Source: ALg8bN6JigoxpoXP/h/IGMzAylMzonJ/DU+WMt6Z/qZ6XVUOGzbwIdMOsJuKu6v0n/KMqzVGOuxQlw==
X-Received: by 2002:a63:6442:: with SMTP id y63mr5266174pgb.450.1547582296196;
        Tue, 15 Jan 2019 11:58:16 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id u137sm6049133pfc.140.2019.01.15.11.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:58:14 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:58:08 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH v4 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20190115195808.GA35794@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, peff@peff.net
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544729841.git.steadmon@google.com>
 <80b5662f30cb87210385a6bd26e037ce39e46b6d.1544729841.git.steadmon@google.com>
 <20190112105757.GE840@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190112105757.GE840@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.12 11:57, SZEDER Gábor wrote:
> On Thu, Dec 13, 2018 at 11:43:57AM -0800, Josh Steadmon wrote:
> > diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> > index 5fe21db99f..a1b5a75882 100755
> > --- a/t/t5318-commit-graph.sh
> > +++ b/t/t5318-commit-graph.sh
> > @@ -366,21 +366,26 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
> >  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
> >  GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
> >  
> > -# usage: corrupt_graph_and_verify <position> <data> <string>
> > +# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
> >  # Manipulates the commit-graph file at the position
> > -# by inserting the data, then runs 'git commit-graph verify'
> > +# by inserting the data, optionally zeroing the file
> > +# starting at <zero_pos>, then runs 'git commit-graph verify'
> >  # and places the output in the file 'err'. Test 'err' for
> >  # the given string.
> >  corrupt_graph_and_verify() {
> >  	pos=$1
> >  	data="${2:-\0}"
> >  	grepstr=$3
> > +	orig_size=$(wc -c < $objdir/info/commit-graph) &&
> 
> A minor nit: this test script is unusually prudent about which
> directory/repository each test is executed in, as the first thing each
> test does is to 'cd' into the right directory.  (I think this is a
> Good Thing, and other test scripts should follow suit if they use a
> repo other than $TRASH_DIRECTORY.)  Though it doesn't cause any
> immediate issues (the previous test happens to use the same
> repository), the above line violates this, as it accesses the
> '.git/.../commit-graph' file ...
> 
> > +	zero_pos=${4:-${orig_size}} &&
> >  	cd "$TRASH_DIRECTORY/full" &&
> 
> ... before this line could ensure that it's in the right repository.

Thanks for the catch. Fixed in v5.
