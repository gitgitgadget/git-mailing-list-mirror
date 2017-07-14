Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9164D20357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbdGNPZ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:25:27 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35116 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbdGNPZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:25:26 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so10990835pgc.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HtYFpxlPVqzZfV87uPtjQzLNQyX8igH18htXW/HFCm0=;
        b=o7snAcxiVpDw4454aBcyRz/x7SNOYKK5q0JoIkcgrjZ3+/mUvmvqFQvTobHTxEwRDF
         cy0o86iF2brsHqGAKauOjSOEKPK1r1C0C2oxha2fkINSNgVsbCj5o1SevRARAnRSdJva
         ZbXYygUldNPUwhuaP5FfQlMyjlv2mELoDWBwjQm+ra/Qh4cX4eK9CbVGIS+tVdLUCizC
         Yh+sWYeDQ5oWk3YSbpnTtSsYhF0cRB+hWm5CnPNaQB0Spi+dUGEQeSgf2AwxStSLaBzf
         f431IBvKUyUgM5aYvOxdjilUVfDsk3ABfnyiXZF2MHwdR74p3MgSm7McyxXn9EK0uQL/
         yDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HtYFpxlPVqzZfV87uPtjQzLNQyX8igH18htXW/HFCm0=;
        b=eggmQeeeLu1qw+GhGXOUVeBYk/5LfxzIpI+4ZFTmmaY3sviFS2oCfsWOqFld0WOAiE
         7Zt++pZxusI47hA0pPRTKD0boIr2bh1nMEpWfXFc+LhEuI89/4LSQM17zHlKmFtdYFIK
         hA0M1Bngoz1SVK4qZwgbrkh2gWpXL1zz8wdBLbat/DC1Ju+S49oNZtKpQwN+zvYYKqZJ
         iWYA+MOEfXhZ/P6p2lwhQ/6pmK9KLPnXSFd07wPFwm3B0i27/NNNaK/0PgwFNzgCw45y
         Go6dmWXB8SDFNgYjha+VwBjaxUnsrgBVNUfIammc6XyGlHT/I0SO8mTdsHUv1O7ccGJm
         YknA==
X-Gm-Message-State: AIVw110Aw6Z2BMtrVbiylBDmFJoWy30+a9NeiSqn6bnedtEVPw07q7gH
        RyA2qNh+nBOB5A==
X-Received: by 10.84.215.150 with SMTP id l22mr16967443pli.29.1500045925474;
        Fri, 14 Jul 2017 08:25:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id 204sm18629524pfc.32.2017.07.14.08.25.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 08:25:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
        <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
        <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
        <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
Date:   Fri, 14 Jul 2017 08:25:23 -0700
In-Reply-To: <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain> (Santiago
        Torres's message of "Fri, 14 Jul 2017 10:02:42 -0400")
Message-ID: <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

>> Combined with the unknown-ness of the root cause of the issue, I can
>> only say that the patch may be raising an issue worth addressing,
>> but it is too sketchy to tell if it is a right solution or what the
>> exact problem being solved is.
>
> I'll dig into this. This sounds a way more reasonable approach.

Thanks.  Another thing that may help, if it turns out that we do
want to let agent run when it wants to, may be to study and mimick
the way our webserver tests arrange how the servers are killed at
the end of the test.
