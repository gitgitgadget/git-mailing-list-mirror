Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95263202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdJWW5Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:57:16 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:49780 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJWW5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:57:15 -0400
Received: by mail-it0-f54.google.com with SMTP id y15so7834674ita.4
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzszl1VqQZEnO3DJoCIWkYJQedNjshnuXQDW/6+h0Qw=;
        b=XWiBiReCKCHW8zDg5loxcILvaFTFmGq4gZnO1cTcjAgmsH8dfWmIly8RxvxBGwEkg5
         6ITc34eRwVnw70sbaTUJsGlQeQ8JT9uuGRtfPjPUjJkB3GjKr/u7UwgzcsojPgjTz13d
         QvHFkLJTYPo96mrBLGRulK+UY9gTZnURPfLBmDWXe7V9oDf/EqXZ3q1eu/Lf8OELVt7X
         m6c2ndkR1/U8K2dwDtdq5oGCBVqlQ1lNE7gh8f+0brMMkW32Zfw5Cwm1XuOs2Clp1v/m
         56U0G0N+XgX2oSV45L/BeA5Np8/pZfqZ2gIGA6O4KAn2Qsuvra4kPC7lVDx7A8+/tAHh
         u6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzszl1VqQZEnO3DJoCIWkYJQedNjshnuXQDW/6+h0Qw=;
        b=cm1aPtxzEjGczGcWEGwS6viIUA1/4GKuRLNQ1Repk9nVUfDoFHJzsC/PuzukkxUrH3
         OUPkQmIPLxI6TQt+S6XBKbEw8vuapsRoBDPg8zm34R1V+s01LexeWKWN9RQ1EkMZCMlA
         gVyHPHL2InIUED3x35YpVRCK2blLyibS2HLkjDojTKeL2DqGOojZgJxvJw/q0rvdRLUQ
         QurKrAhhru8IY74011zqJszXD+E2fLNyCpRdXxFytIiViqyUNBUUR33kI3d6yossLZlj
         jBawJ8kIxXw7WMtAv5XQK6qmg7tr+2Z/cD0Lx3XW9mTR3a3/VqJVjl/z63e0iNTRQk6E
         I4eA==
X-Gm-Message-State: AMCzsaVDsH7av1HB0cC6pqUH2Da5qAh3W4gDf1L6xG1Ia4IGgdOgd9s/
        z0yKxFRp7p9VxEueJe6FqyWwjQ==
X-Google-Smtp-Source: ABhQp+QdK03g1sofcNSrSzMvFnRx1Qhb89uEjnnCnJne3BqSw+z/6eCtAuWY4ttI0Yy3Mtp7IKC8rQ==
X-Received: by 10.36.108.81 with SMTP id w78mr11939340itb.140.1508799434545;
        Mon, 23 Oct 2017 15:57:14 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:4d18:32f5:4fe3:81f8])
        by smtp.gmail.com with ESMTPSA id p190sm22384itp.36.2017.10.23.15.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2017 15:57:14 -0700 (PDT)
Date:   Mon, 23 Oct 2017 15:57:13 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-Id: <20171023155713.5055125d7467d8daaee42e32@google.com>
In-Reply-To: <20171023225106.GA73667@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
        <20171023151929.67165aea67353e5c24a15229@google.com>
        <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
        <20171023225106.GA73667@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Oct 2017 15:51:06 -0700
Brandon Williams <bmwill@google.com> wrote:

> On 10/23, Jonathan Nieder wrote:
> > Separately from how to document it, what do you think a good behavior
> > would be?  Should the "auto" configuration trigger command line based
> > detection just like no configuration at all?  Should the "auto" value
> > for configuration be removed and that behavior restricted to the
> > no-configuration case?
> > 
> > I'm tempted to go with the former, which would look like the following.
> > What do you think?
> 
> As a user having some variant as 'auto' doesn't make much sense, i mean
> isn't that exactly what the default behavior is?

So you're suggesting the second option ("that behavior restricted to the
no-configuration case")?

I'm leaning towards supporting "auto", actually. At the very least, it
gives the user a clear way to override an existing config.

> Check if my ssh
> command matches existing variants and go with that.  What you are
> proposing is the make the existing auto detection better (yay!) though I
> don't know if it warrants adding a new variant all together.
> 
> Instead it may be better to stick this new improved detection at the end
> of the existing variant discovery function 'determine_ssh_variant()' as
> a last ditch effort to figure out the variant.  That way we don't have
> an extra variant type that can be configured and eliminates some of the
> additional code in the switch statements to handle that enum value
> (though that isn't really that big of a deal).

This sounds like what is already being done in the code.

> > If this looks good, I can reroll in a moment.

Yes, this looks good.
