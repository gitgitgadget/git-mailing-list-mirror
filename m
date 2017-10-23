Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48FE7202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdJWXdU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:33:20 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:47203 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:33:19 -0400
Received: by mail-qk0-f170.google.com with SMTP id m189so24128484qke.4
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=83mlScgFqlvcci2d9BROeX6NHi0UjExJSw1IN7g5gLM=;
        b=vvtMO9vfEBnAheAGkM2aE66HmAUJybHiAvboDWRknAqqOSC8wtRYtpxS6z+Nazssgz
         pdWyFbz3yPR2QyGaP2XxhogXGa4poKUkB+U0sL6B7GXoi00Pmig0c/hWkSsrJzrE5tLa
         XoXsUYW7nfs6fXIeE9um+H3pFfS6uWc7wbJnKWrn2umMMCg5T8j9+nCkVNLP34K/Dj5S
         5it22QyBkyZH+5BB1ibD0+QhyN/Z5+8ubAN7NAhQc3EXuK1Ntiz0zJ5OG/uXIQhkzWqC
         NNtZU8dA2iBGuDAR0tEcA+uXa4GGQC6DXuAaQSz8MgRW2D/mZmHb5igJPb/T3y/Y7RAu
         4efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=83mlScgFqlvcci2d9BROeX6NHi0UjExJSw1IN7g5gLM=;
        b=qqvT1EauoY4l/qa8ww0ryY0JE3ofSyqSGvBulP725mcjxeCAsx7ppSD/I+BR451XBB
         sTziDF3wzVai97jgh5xStQdOwzirHq7n5AruBcmZ2GrkRf8qJKsBUn/z3DsZ3PKh3NDb
         jp3kJ6aTa4Qb9OzKgTSXOFafN2z48RGnXNmtqC/6OHkZId0P5VXSW2LOVYVNUONLvxd0
         Qr0me5qv49L8nw9SRNUqWqjWq4qnzspkPdT/rA1+xOPXyn4IfNxHGTEMGF6o7Z36XRK5
         4or95Yl0CzYn8Jh9a7WziktP6esZ+Ye8VdDf+F+HNed8BeHYsF6UyyoIJ64zF9DLPZSo
         6EnA==
X-Gm-Message-State: AMCzsaWPCPIduZmkmtm2Uq13hsGQVNgFZf4gLCnFvwEvs/RlmBcwbSKU
        2Qg1snfLaKCp90C6hDO2XXET+0OjXy5EG33q99yxk9xs
X-Google-Smtp-Source: ABhQp+T99CATTo/mKMb9Jh5kMoih0s0UcT2htqiFaWXjUxTLUdzVzZLNWeLxT5bbwl9AbsKhndt2wze2TgexKSxbkik=
X-Received: by 10.55.125.196 with SMTP id y187mr22430271qkc.180.1508801598506;
 Mon, 23 Oct 2017 16:33:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 16:33:17 -0700 (PDT)
In-Reply-To: <20171023232713.GA79163@google.com>
References: <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com> <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com> <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
 <20171023231839.2g5wudvmoj3hphua@aiede.mtv.corp.google.com> <20171023232713.GA79163@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 16:33:17 -0700
Message-ID: <CAGZ79kaC1-YR7zoboU4pAk0MHeYJcPv-34CiwpRY1Ng9WBaSLQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and 'simple'
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> This is the main one.  Simplified by making "auto" behave the same as
>> unset.
>
> I still don't see the benefit of allowing a user to explicitly set
> 'auto' then, if setting it to 'auto' is effectively a noop.  But maybe
> there's something I'm not seeing.
>

If /etc/gitconfig says SSH, and you have different configs in your
different repos,
the easiest way out is setting AUTO in ~/.gitconfig.
