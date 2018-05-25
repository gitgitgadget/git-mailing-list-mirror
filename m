Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1041F1F42D
	for <e@80x24.org>; Fri, 25 May 2018 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEYBzv (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 21:55:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41869 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeEYBzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 21:55:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id u12-v6so6373515wrn.8
        for <git@vger.kernel.org>; Thu, 24 May 2018 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/zIKLT7dDhGEJj5XZN28tINklY4ufnhhPjp4yNatgTQ=;
        b=jVJvIzevtkiYuEoodLqZ+mKF9OUps2RaEhPeL5NvWO7adkmUYHh1j8iAQLkV6SE5jV
         OcYEoqskiREhK6Uvnbntpvfe+Dza6a6paAWeDoO9VlZbfidV9gnNTU0pKqUDPNqTOOUE
         7cuFl12IWKHDr0Ceuo3r+X/bd/L/iYgrOe12AnEVcH41V7Nm96JojfpuN7jxo0yJgHBi
         DSlYOQJh2TI1aLeZzpDIC7e9cpU+0OJGSiNxXQ0xPGJ9gXGb6I5jd8yseDSTFZCufSPC
         12188tK5GenrcyjpAF48Ec2zit/FcTsOL8NdctaY9y7w3/iBLaNZdGBj/UGkUSLy6FNK
         KFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/zIKLT7dDhGEJj5XZN28tINklY4ufnhhPjp4yNatgTQ=;
        b=N1VS+VNJeW1fQAD+MNSu8rKixf1K8te+xahiGrQ0u+hsjBLamDkO3jwieQ8zhIkLzw
         qxlZsPfQh5Eee1P4Z4Sf10z9GshnvNY7q8ZVC//QJyhc3usTyoG28U2Fko07hJtDR6n9
         3ZRwhyKss7dgqn9t42MrFSjFarR+/K3Zi+CVWSKD9UjdiPKaE/GurTNLkT3eI8MBlG30
         mwDtvW8jCdWl3shEDibXkAePP/PuORUKHEC7CouGQIBU/qw2PhlbmXoCJhFGJrceDXZS
         iZZ31XcJnwS/pdA6bfQHPo+Ij10+MF042ohDexK0xQP4jGruHpqb3rPJoB3TKTFUuB2n
         LEgg==
X-Gm-Message-State: ALKqPwcFnVXf/kuxD6B/uzMs8T3C/eaMAVcHSH8V2os/S/pioNCMmEv4
        e+H2fg4O1IpJTaDO//2Ic0I=
X-Google-Smtp-Source: AB8JxZoK3dpMbc/AnAnEfzGHd6h34ETd2J1rDrDlKlQXBVNN17GoYxRYuAfRkU5Wq8zDwIs79i74Qw==
X-Received: by 2002:adf:85dd:: with SMTP id 29-v6mr299383wru.120.1527213347213;
        Thu, 24 May 2018 18:55:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r5-v6sm721989wrp.59.2018.05.24.18.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 18:55:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
Date:   Fri, 25 May 2018 10:55:45 +0900
In-Reply-To: <20180524193105.GB21535@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 May 2018 15:31:05 -0400")
Message-ID: <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm, actually, I suppose the true value of the warning is to help people
> doing "git branch -l foo", and it would still work there. The "more
> extreme" from your suggested patch would only affect "branch -l".

> Still, I think I prefer the gentler version that we get by keeping it as
> a warning even in the latter case.

"git branch -l newbranch [forkpoint]" that warns "We won't be doing
reflog creation with -l" is good, but "git branch -l" that warns "We
won't be doing reflog creation with -l" sounds like a pure noise, as
the user would say "Irrelevant, I am not doing that anyway--I am
listing".

The warning to prepare users for the next step jk/branch-l-1-removal
should say "we won't be accepting '-l' as a silent and unadvertised
synonym soon. Spell it as --list" when "git branch -l" is given, I
would think.

> @@ -700,6 +700,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	if (list)
>  		setup_auto_pager("branch", 1);
>  
> +	if (used_deprecated_reflog_option) {
> +		warning("the '-l' alias for '--create-reflog' is deprecated;");
> +		warning("it will be removed in a future version of Git");
> +	}

So from that point of view, we may need a separate message to warn
users who _do_ want listing with '-l' before jk/branch-l-1-removal
removes it?  

The jk/branch-l-2-resurrection topic later repurposes '-l' for
'--list' but until that happens 'git branch -l' will error not, no?


