Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C101F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932946AbeFKQOj (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:14:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43457 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeFKQOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:14:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so21000140wrm.10;
        Mon, 11 Jun 2018 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GzTr8tNWMxtlsaZjtD2P3CPUb1oYROJWf4z4J6oTdaQ=;
        b=qgjoXmMxPWLmAG6fCdW63WfWsbd1v2KVPU3Bjjs+IrcqlYv7wq084mD2G90bV4LGGB
         5L78yfl9EfYKwt5pkn9GdA7ITT4Al+tnWe1w6FjipQFXw4lreeUQdDGnwtgyPTJ6/B75
         MmycbsFAXQ1sDC4ZNoAL9Dzg8fBVtZmCaR1GYeDn0tJBXBwNPlrkeQOyh8dwMgwjIofB
         xQT2EgDnbMXN6/BfrhtWopXkxK51wasna4YHxf8idjeQvctVJGGeErqHYqpi0wkgvI3R
         yZypX/m0eBJAgTKYuoyCGL23iV/BHMfZOj2ORVqP636m2PjJ0WEENec7lrtCcelJdQFt
         j4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GzTr8tNWMxtlsaZjtD2P3CPUb1oYROJWf4z4J6oTdaQ=;
        b=Ik6JxFfCGfBmZOEUQtJa4XW7oaveUAA0MTB4VOQr5GycBw8JDdBEopY4R3T/uABka6
         gzxco/AXZMdyQNtSyQ3oySWLUE99SKSBKgMLpqYHewryZFZk8nEugPUDNlPhCjbtksaH
         IapB4iSfL97tYtOHR+dhAxRBRoEkhO9mNwz4ChsfMEuT7nXPWmuFu6zytWdJLA9q9LDi
         W2+Oy4IBvKdfpjjT9uOS8eTebxt6wLKkd5uXUDUDBe1jNz+3hsX4q/JkzzaWvAj5xyUd
         gTR3zvSKEpa/pWvUaJxuqir4xyUqJ0edMNk0ra78xQtmf0MuZ2XOU+LWpiy4AFVxXShy
         cP7w==
X-Gm-Message-State: APt69E2roGGdb7eno+2ZHyxbAIMO0xLOEYZ1+QjaE+Zea8QB/JqzqQCq
        9levF+ZcAmsRQp+YmV/dfF32H40j
X-Google-Smtp-Source: ADUXVKINjJ6C+5mTKfN+p3uR7MELtRk6jL07NdE8vWIiPWvmJKTRkreRBcSy2ap8PRgePZLO5chu7A==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr12745104wre.268.1528733676793;
        Mon, 11 Jun 2018 09:14:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e13-v6sm55207724wrm.45.2018.06.11.09.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 09:14:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.18.0-rc1
References: <xmqqwove4pzo.fsf@gitster-ct.c.googlers.com>
        <CACsJy8ApqX16VNJ1nJktYVssXHTg+OSi_aZNt=es9BuUw9=1Cg@mail.gmail.com>
Date:   Tue, 12 Jun 2018 01:14:35 +0900
In-Reply-To: <CACsJy8ApqX16VNJ1nJktYVssXHTg+OSi_aZNt=es9BuUw9=1Cg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 6 Jun 2018 20:50:03 +0200")
Message-ID: <xmqqin6p47x0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jun 4, 2018 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * "git pull -recurse-submodules --rebase", when the submodule
>
> One dash is missing in --recurse-submodules

Thanks, will fix.
