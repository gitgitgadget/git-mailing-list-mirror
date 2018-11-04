Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94CCD1F454
	for <e@80x24.org>; Sun,  4 Nov 2018 09:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeKDScR (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 13:32:17 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38709 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbeKDScR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 13:32:17 -0500
Received: by mail-wm1-f51.google.com with SMTP id l2-v6so5248867wmh.3
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=u91+6j8FRhrvVSr/bz6TLJ7uq0CkLBEve41XqfURWpA=;
        b=QEDAlwtgDWo3jEJlF/B8vJUALIZbaDnhyIqxq8HUPQrLTrgAyZXlp/gN4hJ/N1YH/C
         ZH5MlgZF6cmFiuqYDyIilzIiblQZfQOfXN/ei/0uNhY4Zd+kC6g0MZDU9W+TunMyr7HU
         eLugZiZCP3hzs6KsdiDPNP5q7xeQG1ZvhmnZNvx96a+1fj0FdbkHe9IOEClwOiZrhn4w
         xDkYOrekzcloEUusDd8UNb9X+ehXdqyD9f0JCiZKusPBoP+GlZBD4Q99aKRt3iRW5EZE
         P1VkAqJBmEKQ/VVR4B6ywGuj3D0icIFeg5mLmjOkdp9V9Ae9YuDmZCh7WrZlKT3BbG6m
         enHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=u91+6j8FRhrvVSr/bz6TLJ7uq0CkLBEve41XqfURWpA=;
        b=MpV/19b1I7B6mv3pnAewQaKaO+NX+jLflJVglDwi9IGazM0aMWaapLuo5dsht5UTtw
         I1UMWqEqycVjzpPJ6fMC5uFnsV4U0Te9bMinyQh0nH1f3xOeX00tA61+d+ttkreOxIg+
         K+koRMX3bYiTktubAoXiYJBpvlVRViE0rVdF8B4anSuWzHlpLbH1oFu1zF74ggtAajX6
         VOXEMoU40dbHdjSJk0eDoNoY9oE3WD9ggEdrygOfTky1pijtFoFTLz5ZffAswUd+SERG
         wjbV84q3sS4IkwjzZB/LQf+4uaXpC5a1ittO83vTvF8Uj8I11NFBoWEOn9WdXiqR4yza
         JLaA==
X-Gm-Message-State: AGRZ1gKM4PlQlFbTvbSrxZ1leFK/28BST8R1+Ku37Ik9+vFAfjSjuvm5
        enSP7ggRvB4fB4cY7Z6Z+SI=
X-Google-Smtp-Source: AJdET5d95FMw82dld/dga2oldWA6lYfepRoaDwLDx+0HARkIbG8G7azWmsc4P2rHJzofgcBImpq4ow==
X-Received: by 2002:a1c:ee89:: with SMTP id j9-v6mr2738473wmi.58.1541323078846;
        Sun, 04 Nov 2018 01:17:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 82-v6sm47402294wms.17.2018.11.04.01.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 01:17:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (Friday, Nov 2)
References: <784741be-6045-12bb-75b9-0df6f4c612b7@gmail.com>
        <xmqqva5en832.fsf@gitster-ct.c.googlers.com>
        <1541231868.1028.2.camel@gentoo.org>
        <xmqqr2g2mqaq.fsf@gitster-ct.c.googlers.com>
        <1541262152.1028.20.camel@gentoo.org>
Date:   Sun, 04 Nov 2018 18:17:55 +0900
In-Reply-To: <1541262152.1028.20.camel@gentoo.org> (=?utf-8?Q?=22Micha?=
 =?utf-8?Q?=C5=82_G=C3=B3rny=22's?= message
        of "Sat, 03 Nov 2018 17:22:32 +0100")
Message-ID: <xmqqin1dmcak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

> I've just did a little research and came to the following results:

Wonderful.

> 1. modifying the 'C. O. Mitter' key would require changes to 4 tests,
>
> 2. modifying the 'Eris Discordia' key would require changes to 2 tests
>    (both in 7510).
>
> Do you think 2. would be an acceptable option?

Yeah, that sounds like the best way to go.  Thanks for digging.
