Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6232202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdGMRdD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:33:03 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35562 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMRdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:33:02 -0400
Received: by mail-pg0-f50.google.com with SMTP id j186so32840518pge.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OMyhpTIku+be4HUZMVlvQ5J7dzjzELoMC5nzcYsuN5Q=;
        b=BAF90mf0TJUK5LKfvzWpclOIS9tUDykXSpK/bjRiTX6hGmADtFdyHdR8qZNcOX8ZoD
         VioqHJ8rgKsNxswCf17qMAArBRRqqYy9MCtprIgnd8Q1LYx+UpNUFapNLtBoysqk69WX
         mZRWoZgG+Z6n/4DQcpzPvf3FtA85jEzEJ+vhbZ/iqFnUL28VCYQ8pIJxBAD/O2jT9nSg
         mSfc6ptDL1Vhz1ckLMOJld47hEwIECU17AE+iUi4vhKgYQmC4dUeYixFfB8ekkScFj5H
         heU6AVl0It9Fn6ZS4pLrMNHOamM6b++tw/PfMyV1YrkryVQ9ckEUAbm+5Vcvdm+9bG9G
         bcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OMyhpTIku+be4HUZMVlvQ5J7dzjzELoMC5nzcYsuN5Q=;
        b=qBdSB063a4aRJps/3t2Z0Uz3PEAtRDx/M1WVp2AAguG7FKG/MbhQMkRscmirWwaUq0
         EutcBYoWuLMLPfXhDpMC8yC2jSHyhfTMYkXB0FDwcdYy9i2A4MUUylN/jb9J+RhP3tAV
         A4NVrjql6FwhUhtEqb+mgfH1u/CROOzePAX3UdfeE0M1VmueGTPflV6WzrPg+qH6zxQ0
         l+8Ae6sgGqj/CfCDqUbMR1nkX63cDXWvwVwBBWnI9qfPemqc5yMEUMD0XMX5qeAoiV/a
         iBpRinz+l6HxwMBr/EFFtiSMwxEeVW2CLJfaYWFMHfHtS+QQ7E+7vevwZQTsI5jQtCtK
         bIOA==
X-Gm-Message-State: AIVw113iqFy426soSo5XU4ZDpqVDpYGYGWQcI+GiUEd1tkNMTKScVJeC
        uLpwnOQPhldpxLGR
X-Received: by 10.84.216.21 with SMTP id m21mr11404975pli.294.1499967182195;
        Thu, 13 Jul 2017 10:33:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1d60:2aee:c595:bad8])
        by smtp.gmail.com with ESMTPSA id a125sm10707135pgc.37.2017.07.13.10.33.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 10:33:00 -0700 (PDT)
Date:   Thu, 13 Jul 2017 10:32:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
Message-ID: <20170713173259.GA30081@google.com>
References: <20170711233827.23486-1-sbeller@google.com>
 <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
 <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
 <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net>
 <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/13, Stefan Beller wrote:
> On Thu, Jul 13, 2017 at 8:59 AM, Jeff King <peff@peff.net> wrote:
> >> This triggers two reactions for me:
> >>
> >> (a) We should totally do that.
> >
> >> (b) It's a rabbit hole to go down.
> >
> > And yes, I had both of those reactions, too. We've had the
> > "project-level .gitconfig" discussion many times over the years. And it
> > generally comes back to "you can ship a snippet of config and then give
> > people a script which adds it to their repo".
> 
> I see this "project-level .gitconfig" via the .gitmodules file.
> See GITMODULES(5), anything except submodule.<name>.path is
> just project-level .gitconfig, so in that sense we already threw out the
> baby with the bathwater. I think we want to be extra careful to not add
> more possible options into the .gitmodules file, now that we established
> a strong stance on not shipping a project-level .gitconfig.

I'm trying to work on cleaning up the submodule-config a bit and as a
result I should be able to make it more difficult to ship more
project-level configurations in .gitmodules

-- 
Brandon Williams
