Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB911F516
	for <e@80x24.org>; Fri, 22 Jun 2018 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeFVVNK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 17:13:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46298 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbeFVVNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 17:13:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so3751889pff.13
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lab9GM/3dAsCUUhYUZGHZEghVpS+nvqQTd9qjygfOpM=;
        b=ZAR8U3v+PT8mtOSKi244xN3UL0z+hz0DBlHgx3+VzVpbitXoMT5ln4IV2Fgt3UpQLl
         jVE8vuGV2o0jH+FiwHDUoZjTISiE7+qR2uFaOsHyMz8285aXLvWxldCS8vG/1Hbl5nES
         J4zN/cNEM2vMxQAN0sSoEoURY9qAU13wnMuVofrs0AFsbTgLuhT1c+d7veSYNQFfkoWw
         JgsvWA857CBTdUtOhZReEA31QuLXVtm4BpDgaq3uEochSFQnnUZtDkAgEzQPjN/ZGInU
         bcB6FBoKl2Nl8u8Ny9zJtUI/62mhByG9OXR6nA8/uKZbfRZO5869FYPY717Io9NyRR0b
         jjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lab9GM/3dAsCUUhYUZGHZEghVpS+nvqQTd9qjygfOpM=;
        b=CSCnw1lpB5AvM0OxePasW8w7QHLELRV6jYtMS0z2GP0kEyTcit883ljuMduGMj9QBA
         DV1u74cbaViJ6Ydx65igEskzBFLG7Rusv3ONnIW2WVRnasAS47TPEV4T3YJ7VbhLIy1W
         SAHlgdeycx2f1t2k0qbwv/TIcwHgO6i3VFdX9XPgDmp6JmkinHKQEtYfv302WfTtyksS
         RKYWLmykKQQOafLKkureV6TdUNc0eedh31wfjDvVjClm6b/cbAyrwXK/wSK/DnI3LHoE
         l+WjOtvd6AYSTTeGRI925y3VHwSRu0Prh04Zss7DZch7N6LEFPZLK8JCpSDQ4vDATLVR
         Y62A==
X-Gm-Message-State: APt69E2qCwndxCtKpUwqN9URiBS9sud2LH0R77HtpvXRW5UWb6cyhRHk
        EKMQb+XihAn4nCVG/yig23aBaQ==
X-Google-Smtp-Source: ADUXVKK++3LbJjaPmLQCZgsWyDA1h7AjOLaqcmE5uCjZwwLCP6XVKadopgRdRtyCxNEMVrSVULTJKA==
X-Received: by 2002:a62:ba13:: with SMTP id k19-v6mr3286373pff.245.1529701985159;
        Fri, 22 Jun 2018 14:13:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k12-v6sm12758094pff.31.2018.06.22.14.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:13:04 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:13:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/7] Restrict the usage of config_from_gitmodules()
Message-ID: <20180622211303.GF244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
 <20180622171310.GE244185@google.com>
 <20180622223139.5fae4cc7d3c33128e28e81d3@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622223139.5fae4cc7d3c33128e28e81d3@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Antonio Ospite wrote:
> On Fri, 22 Jun 2018 10:13:10 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> [...] 
> > Thanks for working on this.  I think its a good approach and the end
> > result makes it much harder for arbitrary config to sneak back in to the
> > .gitmodules file.  And after this series it looks like you should be in
> > a good place to read the .gitmodules file from other places (not just in
> > the worktree).
> >
> 
> :)
> 
> > As you've mentioned here I also agree we could do without the last patch
> > but I'll leave that up to you.  Other than a couple typos I found I
> > think this series looks good!  Thanks again for revisiting this.
> >
> 
> Thanks for the review.
> 
> I understand your compromise solution for patch 7, but I'd say let's
> keep it simple and just drop patch 7 for now.

Yeah that's probably the best approach for the time being.

> 
> I am going to wait a couple of days and then send a v2.

Perfect, thanks again!

-- 
Brandon Williams
