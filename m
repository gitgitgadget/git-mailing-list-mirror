Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FD61FAE2
	for <e@80x24.org>; Sat, 10 Mar 2018 11:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCJLJG (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 06:09:06 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33732 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeCJLJF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 06:09:05 -0500
Received: by mail-wr0-f180.google.com with SMTP id v18so11287208wrv.0
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 03:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNBbjtF+qyBssNu1vjiozFDhpP9WjTt067Q5wVGiC5Q=;
        b=AvrAwmVoRSaBsbUBskL40hxepPJyvOD7udvyupC6EbiHwRYu/qVbzFQIf56ZoAeg4S
         oslNLp3B4xlWf6yxGccGqZD89i+Utbl83ipjihNYBku45qPWqsFXjCxZ8jfXEPYVLrJV
         yzQTuIfN8SRyM8W/f/gXXl2psosPgU+Xc6UK8+zEwUJMN0JbYpCABhzWqF8MdubjJvig
         9lcTUlkEAp3Cm8z0Jg6abT1Pz71PR0MR7EcAJqykLjzWnxQFmXSb8HhKS5ReMzI71whk
         rakv/RYlooICs++TBqx7+eSvTcdY7zFSxunNlVd8W3C7t/ofU2DX9h01Z/EEq7u95QcT
         VtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNBbjtF+qyBssNu1vjiozFDhpP9WjTt067Q5wVGiC5Q=;
        b=WjEiqTIuw7Sc9UWR5PgqpqHFywpcSDChTHgOrFsK7hTZGsnXnuUbWfXjY03jrK4jH9
         sqzlSG1FOAtqihVC3RInpzUMSAq97OJmTu9/gb+++pqc9pHfH0ecl7bAvseOrGu3pp3D
         N+1BxDnYoEjY/BOt7KC63XZnLzg0OdkiZxzXD9B8Nz5yRZyMLJj02X3wBLXcaHN7TmsI
         NoA4CwPK0569BoWbUCidq8/155IfR7VjRG1/p6UP2EK7c+zifuPX9PI+rOUNZlXbDlMO
         6GzRLKVUvhAoK6HSR88FRDu8ZjhL57jrRxp7khViRU+m/ivXZ/3S6t8XgcbPLDJxCx+D
         jmQg==
X-Gm-Message-State: AElRT7FQfrcVRlqtBoug6EbzahNh4uCFs69RD6qp3d2CmDn3PXz+QcE0
        Xlg59SCmY2vffgXM6dhHeFQ=
X-Google-Smtp-Source: AG47ELsm47mhlE1/Irf8hlx6oOZCaKOxL3CvA10NxrB2tEi6b9pDDpfR/Pqcto+BYyB9yhXTTrIQKQ==
X-Received: by 10.223.199.138 with SMTP id l10mr1318159wrg.137.1520680144491;
        Sat, 10 Mar 2018 03:09:04 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x107sm3751219wrb.97.2018.03.10.03.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Mar 2018 03:09:03 -0800 (PST)
Date:   Sat, 10 Mar 2018 11:12:15 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Marc Strapetz <marc.strapetz@syntevo.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git stash push -u always warns "pathspec '...' did not match any
 files"
Message-ID: <20180310111215.GA14732@hank>
References: <349f9369-b799-4f7b-bda1-33bcbd7ea067@syntevo.com>
 <20180303154654.GH2130@hank>
 <08d765ec-b2d7-7087-fca5-2eecefcef9cf@syntevo.com>
 <xmqqwoyk51w4.fsf@gitster-ct.c.googlers.com>
 <d49b1b73-3d16-f29d-4363-a5dba4853842@syntevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49b1b73-3d16-f29d-4363-a5dba4853842@syntevo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10, Marc Strapetz wrote:
> On 09.03.2018 23:18, Junio C Hamano wrote:
> >Marc Strapetz <marc.strapetz@syntevo.com> writes:
> >
> >>Thanks, I can confirm that the misleading warning message is fixed.
> >>
> >>What I've noticed now is that when using -u option, Git won't warn if
> >>the pathspec is actually not matching a file. Also, an empty stash may
> >>be created.
> >
> >Soooo..., does it mean that the patch Thomas posted and you
> >confirmed trades one issue with another issue with a similar
> >graveness?

I've been meaning to follow up on this, but haven't found the time to
do so yet, sorry.

> From my understanding these are two separate problems for which the new one
> was somewhat hidden by the one Thomas has fixed: Thomas has fixed
> post-processing code after the stash has already been saved away. The
> problem I'm referring to is a missing check for invalid paths before the
> stash is saved away.

Yeah, just to demonstrate what the new problem Marc describes is,
currently 'git stash push -u <unknown>' would produce the following
output, and create a new stash:

    $ git stash push -u unknown
    Saved working directory and index state WIP on master: 7e31236f65 Sixth batch for 2.17
    fatal: pathspec 'unknown' did not match any files
    error: unrecognized input
    $

With the patch I posted it would just print 

    $ git stash push -u unknown
    Saved working directory and index state WIP on master: 7e31236f65 Sixth batch for 2.17
    $

and produce a new stash as before.  Both of those end up confusing to
the user, dunno which one is better.  What really should happen is

    $ git stash push -u unknown
    No local changes to save
    $

and not creating a stash.  So these were many words to basically say
that I think my patch is still the right thing to do, but it may or
may not confuse the user more if they are hitting the other bug Marc
noted.  Either way I'll try to address this as soon as I can get some
time to look at it.

> -Marc
