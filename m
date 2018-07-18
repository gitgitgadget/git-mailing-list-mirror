Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F201F597
	for <e@80x24.org>; Wed, 18 Jul 2018 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeGRXEc (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:04:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33329 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRXEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:04:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id z6-v6so248390wma.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QHeS0QD4IpW4VQbXdtz0NploUPS9neKgIUqCxmGwV2Y=;
        b=g4KuT6uRO35pn/ZfGtG903CFX1qW/YxK7lBUh/xy748TbDgYWIHOOw0J764hbaFljS
         Jf4T5NDNBOVooMehxgBHGxg6QRcgKQAls7FFwj9Gi3U4Vc+e4XiCjJs45stNWCb9ewVI
         zelinScwjQCYpk6h3HUVM2N26Uwhu8gvE+up3NQTFxvQZwYNIIv0tUas9H2T6DcdQMLp
         ULlSSUXb4kUusz9PatdDd6LpBVWSTbxgNVseW5/JdMzrlnm8UKMSWvXM9KaNQhDL7G6/
         b18Fg0SFFcP1/hi9935FpW7czS6dOQijTyOTmaizdu4yURxCdvXsKsVchIzcFBULvXCb
         JRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QHeS0QD4IpW4VQbXdtz0NploUPS9neKgIUqCxmGwV2Y=;
        b=HEyP5Sw5iaDztlHRoUcPEfXqWpYFaX2RMGGfX4S42GIWKjkBJmllIKDhJ82id1k5p7
         sXBL+yCTRnMrugsgxMGAR411MbtVdWqjCVuYwptPu6MQNbr5EBdiz3k/KigSqw4BifFp
         /WR/q6TvI1Q5fuEcv9utaccP94aP160PKtDRv10qZAVvjp1mf0o3PRFQAPkapYRCGnq1
         pTfe+QHCR6L19E3znso+Cvj3R5PQ0X4Y45Vd598WNt9wERoj+BmgjsiB6V40WrHC82gl
         osG+yUMBZOds7Sq6YWrSjSQ2K+bWcURhje7dgKzmu2l2apbin8or3VhOyjstbtzpG899
         9KcQ==
X-Gm-Message-State: AOUpUlHIX3YHjDCGXswuLV3+p0+/Rd9JFCrNiDna1oE0LwAZzvxLrqGE
        3BPtsezZnzpGJnvnyIAk4SQ=
X-Google-Smtp-Source: AAOMgpep11UMsn56ZPryB6Gzuo5g2mSZlKYzBrs1YJHTKu0KvZ0i3Wf/2CXRElnYPoLz5OD3YQ9QEg==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr2562751wml.45.1531952672104;
        Wed, 18 Jul 2018 15:24:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h7-v6sm2278348wmb.48.2018.07.18.15.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:24:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, stolee@gmail.com
Subject: Re: [PATCH 0/6] Resend of origin/sb/submodule-update-in-c
References: <20180718194853.57994-1-sbeller@google.com>
Date:   Wed, 18 Jul 2018 15:24:30 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 18 Jul 2018 12:48:47 -0700")
Message-ID: <xmqqpnzki3mp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This fixes the compilation issue raised by SZEDER and Stolee,
>
>
> 6:  3c156c79ae7 ! 6:  f82f24e73b6 submodule--helper: introduce new update-module-mode helper
>     @@ -10,7 +10,6 @@
>          for arbitrary repositories.
>      
>          Signed-off-by: Stefan Beller <sbeller@google.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
>      diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>      --- a/builtin/submodule--helper.c
>     @@ -74,7 +73,7 @@
>      +	determine_submodule_update_strategy(the_repository,
>      +					    just_cloned, path, update,
>      +					    &update_strategy);
>     -+	fprintf(stdout, submodule_strategy_to_string(&update_strategy));
>     ++	fputs(submodule_strategy_to_string(&update_strategy), stdout);
>      +
>      +	return 0;
>      +}
>
> Thanks,
> Stefan

Thanks.  

This time not from GGG?  I don't particularly care which direction
patches come from, though ;-)
