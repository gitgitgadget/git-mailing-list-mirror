Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7051F954
	for <e@80x24.org>; Tue, 21 Aug 2018 00:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeHUDrv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 23:47:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:32810 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeHUDrv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 23:47:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67-v6so2458280ywg.0
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFK7etXy+hIn9zIbzYzqPSpSiktbHdEGrXRL443dRV0=;
        b=v4Bc2I1tpTW0r4VtNW9e12RZRXn8F+YOcOifNQeGzIvczY39k6DcRTd1V1+cnW/UfR
         QKso9o0+JLvBUNI/4Q93nZCG5qNlZhgAOSA/IjJaRDuCga+me+khfZZsO5ph7tf5bK3S
         q3hcR+Q/DXnaGfWb8wAQi9You5gcALw13kuIwBDGB9QeMGDmrNDR8+kfyIUPqm1OUK6W
         Zqqr1Z/gSdM5xjtodHxcizrxhFzwEhsQjnaHyvblAGcHRTZTD3zhVhWyAl7QWU308G3L
         /6sIt4YH1UsuxZkvpwEIfP2pRzP35duwL+1ZUyrq8fle2P/iJbZ0SwEVj3mZaRRxeqQR
         kqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFK7etXy+hIn9zIbzYzqPSpSiktbHdEGrXRL443dRV0=;
        b=Y/hbIYkI9EaUDQSdagQrC3Iw2hJP+hxwCnawXiw6zGOJfSUm+HGWbm83sn9xlpQL5A
         LUrfGElneeAwuyTRlYX3R2/fHcmL62yIdlKoc6iXzdXGYzusPmUP1ExuKJhCMkRFvVEK
         Q5lGg1IgGXmd1NFli4OR/zTzh8TxBv6rU3k1JcOH/QAWU29yQVKUY0bI+G0K4Pj2f70j
         QrDv23hYUCHJz5VxE05m0mn6YFPaVFoWeyjOfVwHfF9iSxtXWJsqG261TKwXBEavf6Av
         RZxRShKRTQ+VICMRjoakk046yGTPSBEZiGfFwJH5WCWhg9wYOoORFsA0JSWnMaO0tkvm
         sEVg==
X-Gm-Message-State: AOUpUlHlwrV4sWK8Ow0jl3aXAwxvMvKH0mDDv4hk8WmVdrz3HVt2odzU
        He9LkOqP0AOIibJw676sFOpwQ3oKQyrvnQVCx6ejv0q2
X-Google-Smtp-Source: AA+uWPwA3b6Wac8C47vy4jWaNFDYsfeGVXZajaA9vNCem9J+gByU9zdWPhENKHE4FXzhhV3TzQY3dtakbyJY4Il6HiY=
X-Received: by 2002:a81:5703:: with SMTP id l3-v6mr25602096ywb.3.1534811401817;
 Mon, 20 Aug 2018 17:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
 <CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com>
 <CAMfpvhK3ouxa5H1ZWy_ZrQBjSq_qwavOtLe98SshaUmjTyBQXw@mail.gmail.com>
 <CAGZ79kb3W6fNkqNemcdziXBB_cDmd3ngBU_0tdS_32rUhAW4dA@mail.gmail.com> <CAMfpvhKPJijO_E2FRh-UtrOthEc2YTaG0=1ToYy3akjzWUZWiw@mail.gmail.com>
In-Reply-To: <CAMfpvhKPJijO_E2FRh-UtrOthEc2YTaG0=1ToYy3akjzWUZWiw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 17:29:50 -0700
Message-ID: <CAGZ79kZfZ2FWfgrvb82YxXP7zHjYDp0J_581ZHgG3un1phHxGg@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     Matthew DeVore <matvore@google.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > heh. Thanks for switching the style; I should have emphasized that
> > (after reflection) I found them equally good, I am used to one
> > over the other more.
> It seems marginally better to me. I also noticed a clean-up patch
> going by that aggressively switched to test_must_be_empty wherever
> possible: https://public-inbox.org/git/20180819215725.29001-1-szeder.dev@gmail.com/
>
> OTOH, if it were up to me I would have just gotten rid of
> test_must_be_empty and used an existing function with the right
> argument, like `test_cmp /dev/null` - but using some form consistently
> is the most important, whatever it is.

/dev/null, eh? It shows you don't use Windows on a day to day basis. ;-)
But yeah consistency is really good to have. :)
