Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE871FF34
	for <e@80x24.org>; Fri, 12 May 2017 17:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756046AbdELRjD (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 13:39:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35226 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756524AbdELRjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 13:39:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so7760204pfd.2
        for <git@vger.kernel.org>; Fri, 12 May 2017 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F7a5NKolDVKlKxJb9kJXVaxvCMZuoc7DSJba871VdQ8=;
        b=XePNgMZ4ylRW5/fuUHuEa85ymMsYmkpnWrlf1Jnnar+U5Y7+kDMx+Ya9sIFkm7ceJ3
         DMUrlpWiE7ClbsZj6vxA1y4JJiMoev+rhtTCd0QlysnAIiaes4FMvF7Dp07zvTzFQ4Yn
         dzc6EOYKrkcbNHQ/r1qlx9KaZYVX1Ifnq0bK2nEgYZuxu/sCIcro6+P25vMsHjXNiA6U
         RL2owKHrcFysRCWPvV/iFOecJFFKVOQBHPioVQlyTGUl2zohCpTcIvJytHA+WBOZhrj7
         FFKA2kuCLhY6Q0eeahbAZzp80W9UgC8G4LW6tuDhjYohAMq2zQa6C9N06jMx5I7VnQ/U
         U+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F7a5NKolDVKlKxJb9kJXVaxvCMZuoc7DSJba871VdQ8=;
        b=KfVJVb7KzU6CJ+vzDoN7u/7+j1n1m5E/ocYGAYJTAMi7xv+6ijg6Sbezb+p5vB8/sf
         cTq9oB3mO7YcuaHZvXInlWuVs6LF+mhA2TAkE9A1K12/FDXL9JQkAKqwekXczHvjWzFi
         ncvoyGF2K6L44mTW6VDoDSKAXAz9Inu99HZpbY4Ml8sgSB8GgP0TqziNAlRFGdfvCpgT
         0p7ZXcmrvqntDGeIYDboAw8HIpEdzPNyriEWk1+1oWLlj5dyeY8aRk+rQb/Y+PX8z4Eb
         IwErbWiKNoAW1oI4boGf4vU0NhsYESh+IJ0Rk8omBOSctGRB9EIwO3DDOq+CCQe59JUB
         A3pQ==
X-Gm-Message-State: AODbwcAsD/TUcs6Ndq2T6X220feD1/kzx3GmNuuoU91s0Y3IgIng9YZ0
        rlIOP9zkNPhgoC6RB7o=
X-Received: by 10.99.42.199 with SMTP id q190mr5557191pgq.13.1494610741806;
        Fri, 12 May 2017 10:39:01 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id l7sm9285829pgn.10.2017.05.12.10.39.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 10:39:01 -0700 (PDT)
Date:   Fri, 12 May 2017 10:38:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/
 for good
Message-ID: <20170512173846.GA27400@aiede.svl.corp.google.com>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
 <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
 <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1705121617420.146734@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1705121617420.146734@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Fri, 12 May 2017, Junio C Hamano wrote:

>> And this one is also important.  I do not think we had to touch any
>> code that handles .git/remotes/ or .git/branches when we extended
>> the .git/config based configuration for remotes, simply because the
>> old data source are pretty much frozen read-only places these days.
>
> Okay. But by the same reasoning, I want to hear nothing from you anymore
> about the sort of maintenance burden you talked about in the ssh_variant
> patches. That burden was ridiculously small compared to what you tell me
> you want to keep (and for a single user that may have moved on). Not one
> word.

I don't understand this argument at all.  There are costs and benefits
to removing an existing feature, just like there are costs and benefits
to adding a feature.  If I understand the two examples you're comparing
correctly, then the same principle is at play in both: when it is much
more expensive to remove a feature than to not add it in the first
place, a maintainer has to push back on both addition and removal of
features.

I like patches 3 and 4 because they warn before taking something out
from people's feet.  So I think this series heads in a good direction.

I wonder if in the endgame we'd want git to still recognize the files,
so it can point people to some documentation on how to convert them to
the supported thing.  That way, when people ask "What do I have to do
to work with my very old git repository using current versions of
git?", the answer could still be "Just use current git --- it will
work in an intuitive way and will give advice when it needs your help,
without you needing to proactively do anything special."

Thanks,
Jonathan
