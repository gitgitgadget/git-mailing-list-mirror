Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99FD51F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbeASVJa (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:09:30 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43714 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeASVJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:09:29 -0500
Received: by mail-wr0-f175.google.com with SMTP id t16so2702976wrc.10
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 13:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eto3jiQDMf3BoM4FgwSwFNcHnenacOrYiqwOkB/P5WU=;
        b=VRqvnRPQ28YFxKp8D3Sf1EV2CaG+Cwt8sylUKr0G1PBKNZP5fgv/6CxmaaqZMAbLqt
         dWETqNCXXnP/rL9qiPofADHWcHSyYbDWDQI/Zk/FGxrHP9vGC1kjD56tDkxYDykLloee
         +vSjrqESSzGQEMpWzjLI3qJtlK3tUUuQXVTTw1J3xhibJu9FiOaYwcs2q3sF0OfPJvkE
         oK16IjN1hSjmKZikfdU0LDw5KLXOKESFtipgL418V2GevqDSQROmcfuGnBTNkBwL/n9U
         EMzyPRhuppkZBxh8LcGmgn4NdBAAuIoOResDnqMAswdjo9JhHRxmSYY1J5oSYcDxfj4E
         mFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eto3jiQDMf3BoM4FgwSwFNcHnenacOrYiqwOkB/P5WU=;
        b=UIkk5lEHUT85jd+LbnA8krjJNTj4x5spVG6BuwBzzfpoqmIEizsIbYQyDssg0ndiTv
         l8qK4ZvgsgUe1szr9erguB0NOjOMICfSmh3SVjZU9ImqXjz1G5ACyXpW+Ink82fVCmhJ
         6UIFMCdo7wNSx6kPDQXBAcCrMaQbe5PFT0/ZyqVm4/TWXaKH3o35oOx2ROsgfN0gBxqW
         SL2e4T/9wE5f9E8PYN3YpnDxniKugZTnVHOoA/H+KLShf+/VxihiPblhjpIOP7oQHwnX
         2BxmOtljU2TBR3MVPWY+nJJHXXH4DaxND/wihDQ07rm8nT9gih7WPoeJO4WYHbWNMVfW
         UKGA==
X-Gm-Message-State: AKwxyteKvm/eUhY3jvP6m4wcx47LAfKzzUBADgG1ztWPJsoqs/FtmjCy
        4HiXCF+41UQn3H8G/iBJXVA=
X-Google-Smtp-Source: ACJfBoudnmMvkwIbJxOEbcMQjFyQFjrBXE4DE2jYIScr4tsLgMJp3T1IyrnSXiuLW/FEPOlfgWnrNg==
X-Received: by 10.223.170.11 with SMTP id p11mr6854896wrd.26.1516396167748;
        Fri, 19 Jan 2018 13:09:27 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d8sm5970955wrf.88.2018.01.19.13.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jan 2018 13:09:26 -0800 (PST)
Date:   Fri, 19 Jan 2018 21:11:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/3] fixes for split index mode
Message-ID: <20180119211149.GO2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180118215331.GN2641@hank>
 <xmqqbmhpr92m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmhpr92m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/19, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Friendly ping on this series now that 2.16 is out :) Is there anything
> > in this series (up to 3/3, 4/3 can be dropped now that Duy fixed it in
> > a nicer way) that still needs updating?  It fixes a few bugs in split
> > index mode with submodules/worktrees, so it would be nice to get this
> > reviewed/merged.
> 
> I was wondering about the same thing.  Especially it wasn't very
> clear to me what Duy's replacement was meant to replace and how well
> it was supposed to work with the rest of your series.

Sorry about the confusion.  4/3 was replaced by Duy's series, but the
rest of this series is independent of those patches.

> Let's drop 4/3 and queue 1-3/3 for now.

Thanks!
