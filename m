Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07AD1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 22:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeI2Ek6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 00:40:58 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32830 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2Ek6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 00:40:58 -0400
Received: by mail-wr1-f43.google.com with SMTP id f10-v6so7887201wrs.0
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9c3jh9R+4KaRB0CazN6VnTHpMXxz9UaG5wUa3zkzypY=;
        b=gv1b+Y+M5+NwDgaKDK1n1UJBUvzuZyskrMU/T0SyIcAne++0ZafuJjp9PMBFfAdO1K
         JtacJ/kiZjPvUDHVYEJ9uMjqrU1JX18HFfJE1T6crfxIICv6Ho36amE6hkTmZxhyIrKp
         8Dvj6tcihYH4VjvYqJBfrGzDF8IAcZj5NmcmoBymjvcV/QqwxEnCpf9+icuEpFy5m7a1
         2TgwcJxC+UJ7e70dG9z3/Bzg/XdFRMeP7IwA7fYMzefwQSvO1Ep1l3QQpawnJXPqW7Wl
         7lPUv61LybGcJ5pQRrKvcastElgT/aLX7ih8ntqZ/EvYpcQ2JptCD8noUFrZIURJk/nm
         ESow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9c3jh9R+4KaRB0CazN6VnTHpMXxz9UaG5wUa3zkzypY=;
        b=swH8/cXNKSE4+QmpwED0JHRwzmSSCen0UOKsA+yquTBR7IUflZ0GtFWvky/tnbNGo8
         pwqj2I3gB16u7x8qO78GKn5v6bMkkQi2DHBcuEmWcOhILEaWOOhCZzM+xp7xQcQTPNCD
         trrexesP+y1nCsBB4+f+sK8lA+SWBYpX6RBTiTxFNq3hNhr1jyZAvy35r7kRbR1gbb4x
         y4Dz+rs1MhQScSkeIVqaxdXBG/nilDuxBDukx52KH+flzj1Z9btGO791BYKEXUCm9iQv
         5147Bw2glYcN4qgfLLFDX4Amhoe7xbcjwIqUURIAllEJf2F/BSNxODTOx8K9CK+1Cse+
         uARA==
X-Gm-Message-State: ABuFfojHIwviZ/SLHkHkAPMVSjU+1bPudKczDFMzCZm+feXstc1Qu/9f
        2aYrdlbJYC5v8/Hi5Ry1qpk=
X-Google-Smtp-Source: ACcGV633l0DqXIWPuLsLA8Fxn78GFN36M5K6ichjV9MY//D1UIr5ynuvbemQmSnrSHHJ/CmbijKoUw==
X-Received: by 2002:a5d:5210:: with SMTP id j16-v6mr331017wrv.290.1538172909146;
        Fri, 28 Sep 2018 15:15:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2946407wmf.28.2018.09.28.15.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:15:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <peartben@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 4/7] config: add new index.threads config setting
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180926195442.1380-1-benpeart@microsoft.com>
        <20180926195442.1380-5-benpeart@microsoft.com>
        <20180928002627.GO27036@localhost>
        <cbc48a95-62f5-a098-fb70-97b6cf241920@gmail.com>
        <xmqqsh1tczyz.fsf@gitster-ct.c.googlers.com>
        <a58a5cce-b3c2-62a2-598b-6b7dbe1a86fc@gmail.com>
        <bf0c24ac-6e2a-9a3e-835f-f21e763ab2c7@ramsayjones.plus.com>
Date:   Fri, 28 Sep 2018 15:15:07 -0700
In-Reply-To: <bf0c24ac-6e2a-9a3e-835f-f21e763ab2c7@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 28 Sep 2018 21:30:02 +0100")
Message-ID: <xmqqo9ch9slw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>                 if (!nr) {
>>                         ieot_blocks = istate->cache_nr / THREAD_COST;
>> -                       if (ieot_blocks < 1)
>> -                               ieot_blocks = 1;
>>                         cpus = online_cpus();
>>                         if (ieot_blocks > cpus - 1)
>>                                 ieot_blocks = cpus - 1;
>
> So, am I reading this correctly - you need cpus > 2 before an
> IEOT extension block is written out?
>
> OK.

Why should we be even calling online_cpus() in this codepath to
write the index in a single thread to begin with?

The number of cpus that readers would use to read this index file
has nothing to do with the number of cpus available to this
particular writer process.  

