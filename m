Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AB081F404
	for <e@80x24.org>; Fri,  7 Sep 2018 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeIHAgU (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 20:36:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41942 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeIHAgU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 20:36:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so7485529pfk.8
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hWoL4JJpsE2t2qWildiwYKeSQaATpH3/NRr40AWUipI=;
        b=L9fpiMMd0CR32YFqIbivS3kqs2g4D12g1YRz5vPtJUiQRQIRdqDVTqTQ43teU/aN4i
         sWKh7B7HeyNwpa9bdp/gZiqhmRZOSinZTfSQ/DW0wRVS7MD6vp6iMzCwusLZdb7bR2RD
         PkQtuEBrC8Wy5SWmxeNavE7jSFmD7QqTRUttwhTRdok5l/Ar0k/3DOo4+kCLyYdzYhmN
         05/4dEIPsgXVrICeL7q0gxq3chSHh/lnLF0Yifh5huMDC26CJqLRV16jRCrc+Gy40y7f
         xB7NPI/jrsOYAO7MRnZSZp92mWJs7t93JDbjwGkLQHx0008fKLYpv8DHYpse5+OjI1g2
         L/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hWoL4JJpsE2t2qWildiwYKeSQaATpH3/NRr40AWUipI=;
        b=RbnoGrBBCQQDtBCN/2WOd5SBDncfQ7pVYOEEsUhn1ztSFUACARzjGB4APENZ6hwYfN
         vqXclQ8ta43X2Q6Veyq2IC4gqfCIcX+X6Sujpjiut5E8ss22plJFcSSySq3yMsyLEyb0
         0oH+4kkNQ/+9Jec/bKFz47pOuFnMpK6vdIiS34woP3/YMvEUIRgFh5wH0BKts5/FE3GW
         tLN3hxUGOKUtv7QSlML/EAgKzmjQSdqGR2YXPg3fFWNedhUI/e6N8KgtRIhqEcsWAs+J
         rYRBVxP3BMOjlHH8nu1XGQP7QQ8w564WBQXGsCTAVm9KvXy0+XoPCSDtPNTZpd2eStOA
         GSSA==
X-Gm-Message-State: APzg51AJl/xOQga2iNlx8KI5TxroI35tE//bJMnf8tkj80xNtTTN7J70
        7+dO5Wo0lC823r6JAX6cFc0pltKb
X-Google-Smtp-Source: ANB0VdaG7O3Jkxx02K9yV+ky0JBpi5SVkI1XQX5xmB2ZfPutu1Hfu0Zvijryel7FRaPkuoaMglZY4A==
X-Received: by 2002:a63:1245:: with SMTP id 5-v6mr9911762pgs.299.1536350031862;
        Fri, 07 Sep 2018 12:53:51 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e73-v6sm19660937pfb.153.2018.09.07.12.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 12:53:51 -0700 (PDT)
Date:   Fri, 7 Sep 2018 12:53:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule.c: warn about missing submodule git
 directories
Message-ID: <20180907195349.GA103699@aiede.svl.corp.google.com>
References: <20180827221257.149257-1-sbeller@google.com>
 <20180827221257.149257-2-sbeller@google.com>
 <20180905191849.GB120842@aiede.svl.corp.google.com>
 <CAGZ79kb0VEDxe0TAMf66nWk3pYMPxrpb_zFmoU4gezzswM5XSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kb0VEDxe0TAMf66nWk3pYMPxrpb_zFmoU4gezzswM5XSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Wed, Sep 5, 2018 at 12:18 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:

>>> This is the continuation of f2d48994dc1 (submodule.c: submodule_move_head
>>> works with broken submodules, 2017-04-18), which tones down the case of
>>> "broken submodule" in case of a missing git directory of the submodule to
>>> be only a warning.
[...]
>> I don't understand what workflow this is a part of.
>>
>> If the submodule is missing, shouldn't we make it non-missing instead
>> of producing a partial checkout that doesn't build?
>
> No. checkout and friends do not want to touch the network
> (unless we are in a partial clone world; that is the user is fully
> aware that commands can use the network at totally unexpected
> times)
>
> So for that, all we can do is better error messages.

Thanks.  This patch doesn't just improve error messages, though, but
it makes the operation report success instead of failing.

Isn't that likely to produce more confusion when I run additional
commands afterward?  In other words, instead of

	$ git checkout --recurse-submodules -B master origin/new-fancy-branch
	Branch 'master' set up to track remote branch 'new-fancy-branch' from 'origin'.
	Switched to a new branch 'master'
	warning: Submodule 'new-fancy-submodule' is missing
	$ git status
[some unclean state]

I would prefer to experience

	$ git checkout --recurse-submodules -B master origin/new-fancy-branch
	fatal: missing submodule 'new-fancy-submodule'
	hint: run "git fetch --recurse-submodules" to fetch it
	$ git status
[clean state]
	$ git fetch --recurse-submodules
[...]
	$ git checkout --recurse-submodules -B master origin/new-fancy-branch
	Branch 'master' set up to track remote branch 'new-fancy-branch' from 'origin'.
	Switched to a new branch 'master'
	$ git status
[clean state]

Thanks,
Jonathan
