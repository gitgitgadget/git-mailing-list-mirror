Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45BF1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeILBhE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:37:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35592 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeILBhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:37:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so27427901wre.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=r8dwuHm5h7+CgNNbc33wyeG5l6xk2YCcVFWj8eV48dM=;
        b=lXECqDkbvujNyPEtMkKBpjbq6Z9WznsZqIUdip84IFyu/Eh8jDFhqNZJ3lSn9ToPYJ
         iNTc+OObh2xQjHFQN7ERw1odpsCQr50EYqRBDEhwyfAY+mzRibQa4xyq+vgeVRLoAWM9
         FfWAfp3ukMI2hTMytEfF4bkYjhx8osSmwne+XXpV/WF8B8VfMQZ0RK0Fcw844nJNNUYE
         KMSPQjQVXnAGbOX7II6MqUgIi4+CTH8KOuiL13XwvRvU2js3LCHecV/6nyMptTBW9iDJ
         j/Etvfl3pggBP+NKlLQsuVVmoI+lVfnl+zo1OGvWXGLhr1jFm+sszMwLypLcaaxkFDxY
         O1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=r8dwuHm5h7+CgNNbc33wyeG5l6xk2YCcVFWj8eV48dM=;
        b=ntuVw9PnKSKrPtc6RvxVffMxG4ndnRNf0GMN2TYVYbg29D5qvW8bA08tLC2Fa8DHsD
         QSTTle861T5+fVxtlXjPv4hjowgSbUp5c0dUk+QtJiDUGYDF5MGt1Vkfk40M1+JlkP7d
         LavsngVVlgrxWcCgQ4/d1fyEd0obgxCk1XRRRQe2Ukf26xBeUZZYdirZEMCWwK3lFOFw
         om6N8Nj3Kdh7xkjB03YFzXPgNASAfpWdac0JXgJqR7Jk0bVrBCug7GMEmpN/g4MTwJPv
         szGtX5YLt19g4KfKCntnjvO3ybFId+dju0UiZYUEeuG6Oz7a1TO6Yvc6pZvSkPysuX4G
         Hjsg==
X-Gm-Message-State: APzg51ByT/qovpnbwYUIkP0zFdrF5+BO9ijM+5wNsRX76zq4s6EfBHSo
        FcVKF0HK/F7juV5IjIzHFkI=
X-Google-Smtp-Source: ANB0VdbppE4UVY/Z7eaZfy+FKSBgcNbROKb9yfTEVRz/iFCfAqPsWO8WdmQra4Rbgy+2BhTzRGf80A==
X-Received: by 2002:adf:d4c6:: with SMTP id w6-v6mr19647727wrk.185.1536698162338;
        Tue, 11 Sep 2018 13:36:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h8-v6sm25097981wre.15.2018.09.11.13.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:36:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
        <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
        <87bm97rcih.fsf@evledraar.gmail.com>
        <20180908211436.GA31560@sigill.intra.peff.net>
        <ad56c575-1211-61d2-daed-5b0da61db738@ramsayjones.plus.com>
        <20180909023332.GA14762@sigill.intra.peff.net>
Date:   Tue, 11 Sep 2018 13:36:01 -0700
In-Reply-To: <20180909023332.GA14762@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 8 Sep 2018 22:33:33 -0400")
Message-ID: <xmqqk1nrojpq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that's syntactically invalid. At any rate, there are clearly
> three options for setting a bit:
>
>   1. In the section header (+include, or Ævar's includeIf suggestion).
>
>   2. In another key (which looks pretty clean, but does introduce
>      ordering constraints).
>
>   3. In the key name (maybePath or similar).
>
> I don't have a huge preference between them.

What's the longer term goal for the endgame?  Is it acceptable that
include.path will stay to be "optional include" for compatibility
with users' existing configuration files, and include.requiredpath
or similar gets introduced to allow people who want to get warned?
Or do we want the usual multi-step deprecation dance where the first
phase introduces include.maybepath and include.path starts warning
against missing one, encouraging it to be rewritten to maybepath?

I have mild preference against #2, as I suspect that the ordering
constraints makes it harder to understand to end users.  Between #1
and #3, there wouldn't be much difference, whether the endgame is
"add a stricter variant that is opt in" or "migrate to a stricter
default".


