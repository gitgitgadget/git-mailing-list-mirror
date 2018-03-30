Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD45C1F42D
	for <e@80x24.org>; Fri, 30 Mar 2018 14:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeC3OFO (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 10:05:14 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34641 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3OFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 10:05:13 -0400
Received: by mail-wr0-f179.google.com with SMTP id o8so8159814wra.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T6y49BrTt4DmUApwrdpoh3h35V1T2kFrLaosGU+RSzk=;
        b=ApxuDRI7fx4Yg1HbpaG3Q14pdaZ29pDyjgHnTT1fzS7pstYwRqeOhj3taIDtHQffg2
         n8U6Lm5AwhfmgVmJtbiUBhjBF2BRtv112cK+tRFeoL0+eezgp7kgHyJUtMxA+tiEIKmm
         4NqKhHIWFGf1eoz31WbtpKRMdYDoIpxhVa0v3RSQ6NTIU1HNvW6IVatSIWDC5l3NsxgP
         yXh1LS2fP783UEKnKio0Diy371dbinO+M19my9iiTwFcLvnkd3fq5TylDcyhwpjys5C5
         X7db0kDRZHFzkyWJ9r9vQsUU1JxgfSsud3bh9e1ZBpws+PpSmcvNaXadWKxTjisqfSZr
         2dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6y49BrTt4DmUApwrdpoh3h35V1T2kFrLaosGU+RSzk=;
        b=sbZ1JhwdP01sHCDyewg11I6DsFc9Qaptxic1GOYdeh90F3RPrNiCwjW0PwTrLwa6Ts
         xN6tbqAlt2ZDpRj0V0gokEe0aSgsSiPXl0ESpMDiM667GeJprPCmvQaWBrF7dgACN/Uq
         QUAdPLsSfCi8HtAkSHYHmKPT3mqIkDsVR72jugPmYRjxToqpP/Cigj9J/UNW1wRw6F59
         5wnXNpSQWpgaymGvzIguUDmW4MXCfXpEfPquPgyu0ZmVxBhTB3bQmrFQXiK9C4/OM0UQ
         7jnGCRj1R50g1kH5Gc/q75bH3bqkkOCMSEENSVhlGhJ12w5nBAQN8QedKWsfjje0DMKF
         JuzQ==
X-Gm-Message-State: AElRT7EXtirv+rlMBEbtnR0+PRfxjwOi7fs3ePr8Y+jjwkRgHo604n0p
        T9kWZ6vd/rTOn+J985RwhzK/HK9T
X-Google-Smtp-Source: AIpwx4+ePN04IRB834kAybCoRQ2mKmMDxsUyEQXpfcfeCY5hUVYykMyrb5paAnEKHN79Cv7nFyE6ag==
X-Received: by 10.223.185.76 with SMTP id b12mr10036745wrg.205.1522418712076;
        Fri, 30 Mar 2018 07:05:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l73sm13791048wma.10.2018.03.30.07.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 07:05:11 -0700 (PDT)
Date:   Fri, 30 Mar 2018 15:08:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] worktree: teach "add" to check out existing
 branches
Message-ID: <20180330140839.GD2629@hank>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
 <CAPig+cSS2T-CweGtfO1vm=cskS91hLCHBoOhDuoqHAzg=27WbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSS2T-CweGtfO1vm=cskS91hLCHBoOhDuoqHAzg=27WbA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Eric Sunshine wrote:
> On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Thanks Eric for the review of the previous round and Duy and Junio for
> > additional comments.
> > This round should address all of Eric's comments from the previous round.
> 
> Thanks, it appears to cover my review comments from the previous
> round. I do have some additional comments on this round (which I could
> have raised with the previous round if I had thought of them at the
> time).
> 
> > As explained in more detail in a reply to the review comment directly,
> > I did not add an enum to 'struct add_opts', for 'force_new_branch' and
> > 'checkout_existing_branch', but instead removed 'force_new_branch'
> > from the struct as it's not required.
> 
> Makes sense. In fact, I had thoughts along these lines during your
> previous dwim-ery series. See my comments on patch 3/6.
> 
> > The rest of the updates are mainly in the user facing messages,
> > documentation and one added test.
> > Interdiff below:
> 
> The interdiff looks sane. Unfortunately, due to UI regressions, I'm
> having second thoughts about whether this series is going in the right
> direction. See my comments on patch 2/6.

Thanks for your reviews of this series!  As I mentioned in the reply
there I'm going to see whether or not I can fix those regressions
(hopefully I can :)), and send a re-roll.
