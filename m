Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F30E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbeGKQRo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:17:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34026 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKQRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:17:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so18713138wrt.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/WoYoLVzmS9+mnsPUC5IdWMQuuxWRWKw3v5P2JIj4k0=;
        b=NUHw02TKtG8fBM+6WVPHJulX64CYWQc74D6scv/ROjtI0mZ7GpvPZ4drj7tSQSHI6c
         6cqzkSYmFOvi3jbhZYDAdolTZ+R5lbWKhNuuoHolgHrKeW6Q2/g+WchzUqVN5idP5t5m
         27o53Us+4xB/d8NxIn+F+rqnmdISbkIJZkvpWks0oV1313lDD/Vj7yB2Yni9FJjbKkC9
         e5sHslnTND8Y9qe141ljMwQNcv1ohq2r7jsfue14kmlykXs4z7za9nHasNIpCaJDwA1l
         qg7CJpfpFcO/mYztd8fVS3i4OWRoJG6Q+lh8Vs5oGw6fGzrnOVqp5B8ZilqiAXhBTlLi
         iMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/WoYoLVzmS9+mnsPUC5IdWMQuuxWRWKw3v5P2JIj4k0=;
        b=UIbzXX/uLSryzRtXUOzYrjp1MJiUwnnS+DCHrLQdr785Pb3lLWBX/v+UXmXnwnoDZ6
         YtRSGNGmR9mZKIRX283Lwc8zxNQxfdThloP/52OH8dMKvTT7bJ8S8/Oqw9UOnKz9rXPR
         APXexQpAPXW3ID/bKpVnb0BFo5rQQCtFtrQgsC+VW6Ck63XtPYu2Zi/rZUVmx46I6LdN
         kAaHdlnOmCBqeAiIP8M00y6k81Kems4uGm0SazOMHIXAsw2V3N6ygDA15tcQQSiSJvE+
         y/jHlEgoqP8U0LpsEWtbGERvMUsMZui9cRHi3ZkJFwFWUcyWz4+Of2dODsuYWtuIeRdk
         S5jQ==
X-Gm-Message-State: APt69E0ZYyI1SXJEcAmTZICdLbVoo4U2Vmhg4kI26hbuC/xkT94OuWqj
        ZU5iYH02bILhTFDLNtQJF7g=
X-Google-Smtp-Source: AAOMgpcC7pg8d25+2sMnU5yTv0NDsS+V2pKzkHqe7ghOsVXR/wdqY9at9qCqXnANBftyb5WFVZVB4Q==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr22218818wrb.204.1531325560244;
        Wed, 11 Jul 2018 09:12:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h61-v6sm5684692wrh.18.2018.07.11.09.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:12:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
        <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Jul 2018 09:12:38 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 10 Jul 2018 00:08:13 +0200 (DST)")
Message-ID: <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To summarize, there are two commits recorded for that Message-Id, the
> later one not mapped back, and neither is the correct commit that made it
> into `master`.
>
> It would be nice to figure out what went wrong there, and how to fix it
> for the future (and also to fix up the existing mis-mappings in `amlog`).

I think what happened is that I used to have post-rewrite, but
because it did not solve the real issue of multiple commits existing
for the same message ID (either because of amending, or because of
running "am" multiple times while looking for the best base to
contruct a topic branch for the series that contains it) *and* the
one that will eventually used in the final history may not be the
last one (e.g. I may "am" twice to see if an older base I use in my
second attempt is a better one than the base I originally used, and
the patches may even apply cleanly to the older history, but may
turn out to need semantic adjustment, at which point I would discard
that second attempt and use the old commit from the first attempt
that built on a newer base), I stopped using it.

The mid-to-commit, for it to be relialble, needs to keep mapping for
all the commits created from a single message, instead of being the
last-one-survives mapping.  I just didn't have that much interest
back when I decided it was not worth and dropped the post-rewrite, I
think.

