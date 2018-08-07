Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B07208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbeHGTf5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:35:57 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:53075 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389148AbeHGTf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 15:35:56 -0400
Received: by mail-wm0-f49.google.com with SMTP id o11-v6so18094264wmh.2
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5TOPHnY4Y38KcUF8fUmsX8qh8X58FFbCU1nW1PFDVCk=;
        b=LeLaoBLSScBMcoQ/xggzWQmvFDUQl5dPDbhtVR2ADGmX4uJ34Bry7A91E57g5b14GV
         XzNa/I9oSRTG+QN6402lH5j1Gq2logdrTSADwYn4JvKH+U9JGAWjTiaTcwS1fSbpTzKp
         RmZwPaVkcinz6SqgWPfrG3EocRKCdTnEK6OV4t0gSKV8G+rnoq7eajZEDgJcYkDFQrDr
         UnVpN1tZxqR96txswFS+gRDHP4pKNfCrd1yfvwp0aXJ8OxQz81nxopmfn0XDI/eHVF5H
         SS0Ac8dDHNtsdnZ3J1rEP7mrwcF+8vqwuoGwxqfXJ1svGB5iv1hD0m16JkvSx+pbTNxk
         L6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5TOPHnY4Y38KcUF8fUmsX8qh8X58FFbCU1nW1PFDVCk=;
        b=ds0CaNCN+bHVmoQoQ5MkSJz3dNzjAz2C31AbMr3tFGXK5DDS6eE++IUY6BLf+r+cHS
         jYHBPYDSJKZReYRNSiJlOE0WKtqYMe8eOo0hxivHJA57Dfe9bNdGQrLm1c73JqG2FhFl
         tRnG0Kup4gpbJyQqR/UasKFL/bazBGAMo6a+KPU2HoWjBoA1u/llXv2AQYjzh9KbDxeE
         5t1xuF8llopDbRzNxDP9eiX8MXeyZhtJ96Eivw51jhpyfG88I0OD+wkVS7Uwbva3t6y6
         Je3dQSx7MRKhpPi+nuSPKvIPVcdgsr1x0pWpDShfvPNM8sbabCZQZokongwMgkL6DiZT
         CZ8g==
X-Gm-Message-State: AOUpUlESahtNJnb7Lofz7g59FTm4cMkriIx6e7M9PTw3AqaQnn0r83ut
        5GyAun42yXbzZIXlGiHOtFp5/CBI
X-Google-Smtp-Source: AA+uWPzwVns2YsFqm3ZRLkOC/ikp+Igzvth2KN2HDpbbJmWGMGACN63PjlxUAPeRTM6WG0h/POYlxQ==
X-Received: by 2002:a1c:1f10:: with SMTP id f16-v6mr2404734wmf.112.1533662436128;
        Tue, 07 Aug 2018 10:20:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x7-v6sm1973572wrr.95.2018.08.07.10.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:20:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
References: <20180731073331.40007-1-sunshine@sunshineco.com>
        <20180802112002.720-1-phillip.wood@talktalk.net>
        <20180802112002.720-3-phillip.wood@talktalk.net>
        <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQaaHfkR8jrXb-+PB4bSZbKLQzRkZNo+DNfz92hKO=04Q@mail.gmail.com>
        <c7b8629d-7b93-2fbf-6793-0d566e86a229@talktalk.net>
        <CAPig+cTyTHxwFvk3ZtOq3L7KEtEjKLKu6-RnLC-_NuL1Xzhqzw@mail.gmail.com>
        <455fafb5-3c92-4348-0c2c-0a4ab62cf2ce@talktalk.net>
Date:   Tue, 07 Aug 2018 10:20:35 -0700
In-Reply-To: <455fafb5-3c92-4348-0c2c-0a4ab62cf2ce@talktalk.net> (Phillip
        Wood's message of "Fri, 3 Aug 2018 15:12:49 +0100")
Message-ID: <xmqqsh3qks9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Yes I think the earlier approach with the more robust detection you
> suggested is probably a good compromise. Junio does that sound good to
> you?

Surely, and thanks.
