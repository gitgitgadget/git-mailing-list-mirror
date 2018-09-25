Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E672D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 20:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIZCi2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 22:38:28 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:40941 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeIZCi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 22:38:28 -0400
Received: by mail-wm1-f41.google.com with SMTP id o2-v6so8398515wmh.5
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Tyw7hzD82wh6qoYP3gA9yK9SfD7cwvCBXUAzIWzR32U=;
        b=r452Wg6n8csSrL9fws8Pe8NOOmb+XUE+ThOgecndet+mRiNzOUGW+NkgbY5dnWYHTp
         b3GulKo612EI+zLAqjnUKbm1Op/xEo6wcsBFPucGDuubw+17J4dhzT5gU14LHy/cfDMf
         htScsgRJ3QlBoZhW3Ohoi1n60xQ6QqY68wB0ByEmIe5WAa7nh8YfWZxjqjUekJFbeKDE
         xdAiKriyXy8MajpdlncUNOd4JcmKhJ2j4GgA/oS8PSUGnmJx/DJ7NIYGVe8BgW16MXJT
         bXu8U7cyti1LyOSvnsiCfcj2MvkC9psPtdbigqjmEaX0Q6HjhV4j+Dzl5fSf/ms2fEbf
         ABaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Tyw7hzD82wh6qoYP3gA9yK9SfD7cwvCBXUAzIWzR32U=;
        b=qd9jiGF4N3ugFOWGCATGhaO/A59sDqvWCtIEflI3LqIwSPZCtWIXYNb2IzwCIRaT/n
         k5MAXISK6fhiXo6MG1mIEISiCkXBcZZcgGS68qFg49C7WF6S7mUc5Gtm5kQbeGmASCrb
         fG5wTviKtE1ASmc1tmesPm5f0luX7P54lsWfdARP6UwspcZDYPgw2aMs6jMZsG+sIrtR
         Sdy+bK9Av2LbSfjKQ/a73gcoo2A+JwGVmGzxsGsb7E7OR4Yq3H/1oZAJDnjCGB/RwqEj
         MvW98X74OshiVFitqjoQA5o7cUlqzOH4hrPE3H0275l+raRGy7457Rb6nyoz/Ph8iwf9
         RGLw==
X-Gm-Message-State: ABuFfoj0BsGq/jJFHfm6nVFrDYCuN7pex8u6maUyN2CE9b96fe4jtnKF
        5NgCkzkaJibKjgtwXFIKymw=
X-Google-Smtp-Source: ACcGV62XbHxabOu2pGo3j2u8Fw+QYkUCZNm7TowviZElE4kTBDtmBGiE4doad2ISBBqBA72x08DuBQ==
X-Received: by 2002:a1c:c749:: with SMTP id x70-v6mr2133906wmf.90.1537907348328;
        Tue, 25 Sep 2018 13:29:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 75-v6sm5743891wml.21.2018.09.25.13.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:29:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: cleanups in can_all_from_reach...
References: <pull.39.v4.git.gitgitgadget@gmail.com>
        <20180925132741.223513-1-dstolee@microsoft.com>
        <xmqqwor9pi3i.fsf@gitster-ct.c.googlers.com>
        <08b67726-8af6-34f9-6c4f-6a1be7d81b90@gmail.com>
Date:   Tue, 25 Sep 2018 13:29:07 -0700
In-Reply-To: <08b67726-8af6-34f9-6c4f-6a1be7d81b90@gmail.com> (Derrick
        Stolee's message of "Tue, 25 Sep 2018 14:13:16 -0400")
Message-ID: <xmqqh8idpbho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Another commit walk that could be improved by generation numbers? It's
> like my bat-signal!

Ah, nevermind.  The "traversal" done by these helper functions is
the most stupid kind (not the algorthim, but the need).  It's not
like there is an opportunity to optimize by not traversing the
remainder if we choose the order of traversal intelligently, so any
algorithm that does not visit the same node twice and does not do
the most naive recursion would work, and what we currently have
there is just fine.
