Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13CF1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 13:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeJZVwe (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 17:52:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38235 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeJZVwe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 17:52:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id b14-v6so1409682wmj.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0677Q6puTCmHSdbwvenhY0OBIYLOtyKIl4vGif1Dfas=;
        b=EbMLQbjbrtY/n7aZUWf96g0jCBn41Rh9722oakM8LY+iq6I12OEDOKc8phkF1n9EdJ
         S34FTbu04YBfTBFYQLk040ebdqA2KkYJDqZBjzg5NKiUMcuYlfUCb95mCOGt809/Oe5Q
         CziblT0R9U7HQPKn3qvHyVwm0eFLBz+6mA5NMNIxo0r3AScUApo8zXAeVCXVC/3waUDM
         5IDNL8KlVorMGT+69onG4mosx497GGxI7lxJYLlHTP29GUH6ib1HY+Jx5+vlW8DoxZHW
         6uXm8g0fHwWRFnJOV8NV83h7USeraEMdWE00rompYvGa+NvWLfp8/FuaT8erk5lixx+L
         6hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0677Q6puTCmHSdbwvenhY0OBIYLOtyKIl4vGif1Dfas=;
        b=Hv5Afb3yRtLdr2ZFA8/RmAb0rLSeKVQYm/2jPtPj742bRj06UzsI8v9yL+noKTaeIn
         943AUI7waNh6lPIwbLzv8YsGgD145vxtzEWbMckaHf4O1VbkbjEZ1HReeW5lvwa4uIFT
         wcMn/rgO/yuK0Gq8JWVLMEzghbcabdndP90l4vQlBPG6VkARbHtCx6gtSxdo92OKI87K
         Edfvxhf7deEHdADUscIRhjpO5zdDjEN3ywf+/sh85SM9Lf1R/6y/OyzFRU8YcURQXDY6
         xpxF3QIQFxQugymzgxo/Bu+ruVLPNFsin0RJQvB87+ubunha9Go02DF/a5KwCTsmovdb
         sU5w==
X-Gm-Message-State: AGRZ1gJc7Zyix09jdxtHVMaW2UF7i5TbHnRBTW4dxl0iUkK5LfeDiS9M
        ZWK77EqiXki/Ms3K9googoU=
X-Google-Smtp-Source: AJdET5f80WWhYtpRwzQ/0Z+t1af54ei4+Ruq6L0uWrVkvUjKYHVGRRO3d21ji+h8rcFS9FjJPrbZNg==
X-Received: by 2002:a1c:7404:: with SMTP id p4-v6mr5550411wmc.98.1540559729136;
        Fri, 26 Oct 2018 06:15:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 74-v6sm5666791wmi.23.2018.10.26.06.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 06:15:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com
Subject: Re: [RESEND PATCH v3 0/3] Add --gui to mergetool
References: <cover.1540398076.git.liu.denton@gmail.com>
        <20181026061111.GA7242@archbookpro.localdomain>
Date:   Fri, 26 Oct 2018 22:15:27 +0900
In-Reply-To: <20181026061111.GA7242@archbookpro.localdomain> (Denton Liu's
        message of "Fri, 26 Oct 2018 02:11:11 -0400")
Message-ID: <xmqqk1m4df2o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  

I think this one is identical to what has already been queued and
nerged to 'next'.
k
