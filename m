Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A6B1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 16:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeHDS6c (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 14:58:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34833 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeHDS6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 14:58:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so9773088wmc.0
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=imjEGOS+83GY0D8fvJQEeML1nY2CtOirFTymnVXV9U8=;
        b=g1wJ+xEjPp3oawFTBH1NDYVD3m1I836bDZED5pvGbcLx/Tojeq1yq2MvbLT/xofLMl
         sFyz74Xqle07TJCO8hde9Y4EWzsUtLh4c+j0nV5/uEL/T2GYpeyIfAjqTRl4VdU1yb9T
         00edkT+USG7INksVktMFkJlnX3otIUPAvlLpVbR0RYS+upcO15O45Eu9YaGlX/SzhUMF
         Zxj53WWg3sPVbiVwGUbqPVCprzrzWJafvvKWcXe+qt3EaCTPKoUlMyF8TZxhYdZRSsET
         tSN8n1IqXOD27q1n7fhcSgZGjuQSbTU9fTYe5trxDoQu0iwSXjdHbexnosNSLS/pl0LQ
         EGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=imjEGOS+83GY0D8fvJQEeML1nY2CtOirFTymnVXV9U8=;
        b=nxYxGNfynx8IjGwKqmBKaKpcUzyuKYzzQwTv3MyBq0hpxP2t5XNIE8LeEJQu5fHiWu
         K6vYjMD0MQ5CK8T2kD4/nDIA3umfbFozu4z0xxxpNVd+Vvzzob8ON1eLDLb3VLaE2MNW
         1yP6pxxxAQN1kaZZ29EnNH6njqGXNpWt+/1CtSepM8j+5yREMp2MDL6mtvNYPD2VVRBZ
         nIdFQjqlUGSe/eyZQpbFw2bI98Eo7mNd9pCWJtl7wK0s0r0NlzXsq57elsv8SmjRrRDq
         1VeyYrBoaFqjVQ+Yl9mgRULo6hlTOwNw8RV2v++qJur/nftLjrKiK7iKlac/CGJMqJtc
         m+GQ==
X-Gm-Message-State: AOUpUlF8A0AvGcWNr4FzIIqeoppxtj82bMF7Rl3M3l3MCOuxYiyO34/G
        m4F6Ujt5HsnM9JV7/Hpt6io=
X-Google-Smtp-Source: AAOMgpe/IG6GmK1zey35Dc6+wrFE6VVWG7tdiA33hKNJD1zSd0oE/XlZJ0QtOhNwizOh/VU2JUf2yA==
X-Received: by 2002:a1c:700a:: with SMTP id l10-v6mr7774248wmc.90.1533401833490;
        Sat, 04 Aug 2018 09:57:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u7-v6sm3689839wmd.46.2018.08.04.09.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 09:57:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] improve range-diffs coloring and [RFC] move detection
References: <20180804015317.182683-1-sbeller@google.com>
Date:   Sat, 04 Aug 2018 09:57:12 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 3 Aug 2018 18:53:10 -0700")
Message-ID: <xmqqd0uyt6hj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This builds on top of sb/range-diff-colors, which builds on js/range-diff.

As another round of js/range-diff is expected, according to

<nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet>

I will refrain from queuing this right now.  Possible conflict
resolution that won't be reusable when the base one is rerolled and
this and another topic that depend on the current round of
js/range-diff are rebased on top is not something I can spend my
time on this week.
