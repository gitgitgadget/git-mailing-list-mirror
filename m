Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D035B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbeIHBCo (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 21:02:44 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:41710 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIHBCo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 21:02:44 -0400
Received: by mail-pl1-f170.google.com with SMTP id b12-v6so7055208plr.8
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tjwUDOSEthBrRRH7NMS8gc3QOBZbVV0iaBv3sWuzAuY=;
        b=jM6A4jetjTLt53RCWaS+rlaZ2irH/b7szcQXXGtToDTfjNdoULe9h8CIoq2AxdHSnF
         wWb7ohYsFGrJn63APgoRRQ09dmGTqezoJyknr58rNSeCQ4r3QVphTW4KNpGSBpDb0UpF
         gNsHZt68i9bWf4l3GQMMlHXSeZvVGy88LsngLvGgMcgpNj1h2wfDpQnfXfhwZr76bLEU
         5TDr46obO2tENpPT/CyGRBRhR+eGVxMpXK7fN4oddj8VUaAxqWPeC+w7roGGtRWCBQLt
         troKYGOVLwRWmWIAzvQyptZIl66CiDJx5frTS5EIuzOS/GNCgmUGFFxx+egUQKxmzGcU
         GI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjwUDOSEthBrRRH7NMS8gc3QOBZbVV0iaBv3sWuzAuY=;
        b=tRQ/9iGseJE1ZRB8ncv0Fx/mr8qK6PTHA8Zh+ut+MTeRKT3diJLzpRi8T8OXe79fFH
         zuLVx81v9+0jrk/BEqgPnVhvxdbghJmLoOmrNb79tbJD0gR9itAmB6H1pJ901iEm0V0P
         Rn6pviYsA1Po3NQk7Et4HRjhMUQPIRX0qlLUAzGI1zWPNNe/ucSRr8rMl/LzokkwOVVW
         KoEnmVIVbdBud+NJfokyHf4zFsLoAyGOr8ZNvUAznLbSpn34kOomduyaaxmsSDraw16f
         fHvUuSjAy427pJhzsVkCdHNg+M3ViMePDhpMdS2Gs5gyolhNcv5zYh4yS5DQGhq7EuoZ
         NiJg==
X-Gm-Message-State: APzg51C6m3jcqUBgv4pbw61TCYApa9UeB9NFmlBZHcdlcVPTRF7R57VV
        CufSvhQ9jybSiMIfbF7NaGJ2sGm6
X-Google-Smtp-Source: ANB0VdY97YHnwFDvGdhlAKcIA+AYcAdsBrff/6GomnWupSj0QRFWJc4ta70C10YY7shCrEeoaVa5SA==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr9722962plb.173.1536351610333;
        Fri, 07 Sep 2018 13:20:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s14-v6sm14049184pfj.105.2018.09.07.13.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 13:20:09 -0700 (PDT)
Date:   Fri, 7 Sep 2018 13:20:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     allan.jensen@qt.io, git <git@vger.kernel.org>
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
Message-ID: <20180907202007.GC103699@aiede.svl.corp.google.com>
References: <2659750.rG6xLiZASK@twilight>
 <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Fri, Sep 7, 2018 at 2:53 AM Allan Sandfeld Jensen <allan.jensen@qt.io> wrote:

>>                       A "git submodule update --recursive" command wil fail
>> for each submodule with a line saying "fatal: could not open
>> '<submodule>/.git' for writing> Is a directory.
[...]
> I have the suspicion that e98317508c0 (submodule:
> ensure core.worktree is set after update, 2018-06-18)
> might be the offender.

Oh!  That seems likely.

Allan, output from "strace -f git submodule update --init" would also
be interesting.

Jonathan
