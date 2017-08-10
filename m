Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FEA7208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbdHJRPt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:15:49 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32916 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752953AbdHJRPs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:15:48 -0400
Received: by mail-pf0-f169.google.com with SMTP id h68so5595632pfk.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rYaofm5+gFXbkdz47y+EC28idDX8oQeOWZFI4or8dSA=;
        b=sVyCRgJBuUr8+AeahBWavsrjlowTuDlyfZZTPfNNhYmnPoIMci6GEVjUrx1k3MasxA
         a+6So5dPWheJHwjasbpg95DqJz4x4UDGo+R3PVUJOXLIwvynHW3vl2e4MCuloyWOtCna
         /rM+sjpf5UzjsKmBvrJo+IFBmEfZpyj3uni0/SAHOAbKs2MNWWS6tDviYK2vqnjpxKLE
         BA83JKXW5aJ/FrhNtrqfFMms49byPgwNLHYHVlOpcBP1YTQ/yHpW2EagUQdVgqNnDMtT
         vZSKb7wpOjSJyg6eJgsrLiLiJrY6a7gdS4ST68ZueFPBbWj3hiBNgO7cYLGag81++7N7
         sfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rYaofm5+gFXbkdz47y+EC28idDX8oQeOWZFI4or8dSA=;
        b=VRGhwH6zXpgswax8KCr3N8sgmiyp9oYKm67lta4dJ1EPkQ6epq0+C1geNjmRoaVYrG
         lcu7D5YPGJru3F2RFPqxmvB6777ppZNBWIeiHBBu/6gMTnjXF4pII+o+Ks3CW7J97wFQ
         9O87SS+oJTnGpDZTaLFiJP+eczf1VVx3ZyVoJNlcInrOg6sy0wLGNHS5elDaDA93FQog
         ntsQJN1V9dnOi2VwaUSIzCB/zdmp1epP7yrLJnDynSWzePss/xYs8if6MNeHFCYrng22
         PZqDUEeJKpnIclDLS0irXfd2fp49pfMIZCFcpWBhtyZD0CPiLAhZHaPf+RzNAiEItEMi
         ACfw==
X-Gm-Message-State: AHYfb5ixIhWQFBMHS0TEyhcR1AakioghzcU3JIDJTJ/NeRNjfwIMdPtw
        58UmpCusgue4FsWB
X-Received: by 10.98.104.1 with SMTP id d1mr12880949pfc.197.1502385347748;
        Thu, 10 Aug 2017 10:15:47 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ed9d:9bd9:5ee6:bf0b])
        by smtp.gmail.com with ESMTPSA id l22sm14952608pfj.138.2017.08.10.10.15.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 10:15:46 -0700 (PDT)
Date:   Thu, 10 Aug 2017 10:15:45 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170810171545.GC73298@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
 <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
 <20170808182324.GB73298@google.com>
 <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
 <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
 <alpine.DEB.2.21.1.1708101137190.11175@virtualbox>
 <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk22b5q9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 9 Aug 2017, Stefan Beller wrote:
> >
> >> > I am sure that something even better will be possible: a Continuous
> >> > "Integration" that fixes the coding style automatically by using
> >> > `filter-branch` (avoiding the merge conflicts that would arise if
> >> > `rebase -i` was used).
> >> 
> >> I do not quite follow. Is that to be used by Junio while integrating
> >> branches?
> >
> > I was more thinking about a bot on GitHub. "Code cleanup as a service".
> 
> I vaguely recall that there was a discussion to have SubmitGit wait
> for success from Travis CI; if that is already in place, then I can
> sort of see how it would help individual contributors to have the
> style checker in that pipeline as well.  
> 
> I have a mixed feelings about "fixing" styles automatically, though.
> 

I still think we are far away from a world where we can fix style
automatically.  If we do want to keep pursuing this there are a number
steps we'd want to take first.

1. Settle on a concrete style and document it using a formatter's rules
   (in say a .clang-format file).  This style would most likely need to
   be tuned a little bit, at least the 'Penalty' configuration would
   need to be tuned which (as far as I understand it) is used to
   determine which rule to break first to ensure a line isn't too long.

2. Start getting contributors to use the tool to format their patches.
   This would include having some script or hook that a contributor
   could run to only format the sections of code that they touched.

3. Slowly the code base would begin to have a uniform style.  At
   some point we may want to then reformat the remaining sections of the
   code base.  At this point we could have some automated bot that fixes
   style.

I'm sure I missed a step in there somewhere though.

-- 
Brandon Williams
