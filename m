Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D9C1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfJ3WMu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:12:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45924 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJ3WMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:12:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id c7so2621370pfo.12
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X/eA3eAOJHqXam/jwc0yw3rAnQdzUl0rzBlmuR4Tyoo=;
        b=QZTFk3b2DyKIydeU0j9l7nwzSsG6pDBLCL0gSim7Z0WgjluvzqiwOVaHS/byj2cGnJ
         mJdE0t9ohUeQUhJMtpCayOYpsEUrLUn83BihtLgB2TBx88KGVbLAMSAtAJf5kWge+VfF
         LdO+5UmiSvGROd4jZBorS3gxPfruFh2NYEdocsbL2hF65YgBZlRnWZTTSiMCDTmzobzL
         C7zIeAVNEe9UzGHiY5f+wxAXPljn1C5F7oMx0FwUytOShPnnS6/WwCH0k69RwPLor+61
         SkY/p9d0uLhf08s2q+LFb2t62Zo0mXin7bvK5m79rZy7ETzv2s2aj6chgpURTSi7Iel5
         yrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X/eA3eAOJHqXam/jwc0yw3rAnQdzUl0rzBlmuR4Tyoo=;
        b=BgdwvL8vYNTnar9PwQuCEJG/MQdPpvTVEW1bc4Y8hiNjD3mcPFm5iXCpIjA+Im79Kb
         /2MdSdS7v4Qy3vtcsGdG1BCPWsvlmxPCPu8SJggNNCoMe7FFBSZV3mHYlleYyrMR4duO
         SPB/L5f+ounnzn7Q7Yr8U2pTCGaksqhUHlIm721co/TqxvsF43LEpQ7HGmUXrVeHA6x/
         YoPv1g6F3TXe4AkcxjnCosuiCLhV7OAz7RM/vnTyJLxg3hDZw5NOZvSLUrTwcLXThqSU
         J0oirjpbccIWfzQWZ3r0PFirPM9GSuh/L7iSxqdL0668fQbd4P03MMUjZCNBUaOEy8Iu
         fM4w==
X-Gm-Message-State: APjAAAX1B5JAxgx9Sx/EFMsFamP7bVyctx847C1RZHUqsHgtMqJ5GDLh
        9NamBZSXNwEQhQefi2cEejQ=
X-Google-Smtp-Source: APXvYqxlUWDmqyjuDtFTKefAK+MNcJqciYl7H4+ZjxgSJQq4cPZRQ8MvTHmqTjjrWiWMI05qDxnqSw==
X-Received: by 2002:a17:90a:a007:: with SMTP id q7mr1998985pjp.114.1572473569224;
        Wed, 30 Oct 2019 15:12:49 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id s2sm817919pgi.47.2019.10.30.15.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 15:12:47 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:12:45 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gg@generichostname
Cc:     phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-diff.txt: document return code of `--no-index`
Message-ID: <20191030221245.GA44961@generichostname>
References: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
 <ed9f16c30a0f3852abaf0053d8c2b4a0ecd12f01.1572367897.git.liu.denton@gmail.com>
 <4548d037-3fc5-b625-b7f9-646392392d0c@gmail.com>
 <nycvar.QRO.7.76.6.1910302302060.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910302302060.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Oct 30, 2019 at 11:02:49PM +0100, Johannes Schindelin wrote:
> > > diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> > > index 72179d993c..56b396ef81 100644
> > > --- a/Documentation/git-diff.txt
> > > +++ b/Documentation/git-diff.txt
> > > @@ -36,7 +36,7 @@ two blob objects, or changes between two files on disk.
> > >    running the command in a working tree controlled by Git and
> > >    at least one of the paths points outside the working tree,
> > >    or when running the command outside a working tree
> > > -	controlled by Git.
> > > +	controlled by Git. This form implies `--no-exit`.
> >
> > s/--no-exit/--exit-code/
> 
> Oh wow. Did I really type `--no-exit` when I meant `--exit-code`? I
> guess I did. What a serious Freudian.

Nah, you're still good. The error is all mine. I wasn't paying attention
when I rerolled the patch so I copied your text wrong. You initial
suggestion was correct.

-Denton

> 
> Thanks for pointing it out.
> 
> Ciao,
> Dscho
