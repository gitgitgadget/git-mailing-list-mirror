Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4211F600
	for <e@80x24.org>; Thu, 20 Jul 2017 23:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965697AbdGTXVW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 19:21:22 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35330 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964809AbdGTXVU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 19:21:20 -0400
Received: by mail-pg0-f44.google.com with SMTP id v190so20801826pgv.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 16:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2yTUZDFQxCLNDaRf+MfxAKHJz1yWxKcu1p3Liov7aU=;
        b=V+FwSjlAaosbimcae9iQ3qmmoQNpFw/am2t/8YgjpR+in7kIF3Y1CV+czwjk74wgci
         7vEIHyJ7ltdLb3IYr1HZKg/Jv7FMiL7AuoqytalOM1uo02iDy6DiLUqosw/KpOXpaSnR
         ZrBCZ0iWeDZWSWrkhCAXa5BCupzU3G9RllMAuNFjcH9zYPZohZPsPdWel3oc/RN3ub5y
         BDeDUDifdEy5SsJSteRAlxLu0N+bLwrzOzyOA9awUqp0TGX3O7OMoRQYzNAX5yCWOZwC
         hl0M33wGO3hyhkh2eo9FjjB31+lTMFLLtVmzp7DFAIvaTtH7E+ZHKfiliUHbsJTlW60+
         n9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2yTUZDFQxCLNDaRf+MfxAKHJz1yWxKcu1p3Liov7aU=;
        b=X9YMkiu9QWJNCT5xWQZ5q3DLwUbOdK0rNT3npvJOV3687HvCyso7O+0wR/bnI4vFu4
         N1QxpmEG0AStytD2sKAtVCzYum41Zial0cVjDFl4YchnJ6dcT5QepUMUD5mC3giCCo7X
         6mZ9gmKbr+5FRKUgzlcuJ+nZt/4XTc0RvaZB7wUcmN/vUI33B6o4Ew0V52B9HLnyCc0C
         WIlQUTQmAfK7dVvP0RelWeuCr7AbIAvDfmdnh6UpNq5aTjJqqetsgS4VsO3//2w3dNBI
         eGaLIL4mi9tQ4Jm+dJc8JFiXYjsijS9hvVS5Oos2U5tmezEhcivnINagD0czt7Q/ktRy
         FDHw==
X-Gm-Message-State: AIVw112xggUCmbEkmFYZAKZiQVJ4LmhQmveGg2p2HoBMu3C2eweTckPs
        ewx+lPQ/EfNDXA==
X-Received: by 10.98.71.13 with SMTP id u13mr5431984pfa.240.1500592880155;
        Thu, 20 Jul 2017 16:21:20 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:1531:44e7:de5b:a840])
        by smtp.gmail.com with ESMTPSA id q88sm7408112pfa.10.2017.07.20.16.21.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jul 2017 16:21:18 -0700 (PDT)
Date:   Thu, 20 Jul 2017 16:20:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Dave Walker <dawalker@google.com>
Subject: Re: [PATCH v3 00/30] Create a reference backend for packed refs
Message-ID: <20170720232040.GA159617@aiede.mtv.corp.google.com>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
 <20170705091216.ij4uzp3wgsalb56f@sigill.intra.peff.net>
 <CAGZ79kY=N5H2q1SB9ZEtt1EvuAQg+bqVBZNoXE6nLgtoUd2txA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY=N5H2q1SB9ZEtt1EvuAQg+bqVBZNoXE6nLgtoUd2txA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc: dawalker, who reported the bug
Stefan Beller wrote:

> We have a user that reports:
>
>   The issue is for users who have a mirrored repository, "git pack-refs"
>   now overwrites the .git/packed-refs symlink instead of following it and
>   replacing the file it points to.
>
> I suspect this series to be at fault, as the bug report came in a day after
> we deployed next containing these changes.
>
> Do symlinks and packed-refs ring a bell for this series?

contrib/workdir/git-new-workdir installs packed-refs as a symlink.
The reported scenario was with another tool that does something
similar for similar reasons.

Dave Walker wrote:

> In the meantime, since this is linked to "git gc", it can crop up
> nearly at any time you modify things from a mirror. I'd recommend
> extreme care until this is sorted out, and it's probably safest to
> avoid using the mirror for branch-modifying operations.
[...]
> The change at fault is this one:
> https://github.com/gitster/git/commit/42dfa7ecef22191b004862fb56074b408c94fc97

That's "commit_packed_refs(): use a staging file separate from the
lockfile", 2017-06-23, which would indeed appear to explain the
symptoms.

I'll try to make a reproduction recipe.

Thanks,
Jonathan
