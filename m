Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8F71F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeHPVSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:18:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46186 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHPVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:18:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so2297597wrc.13
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WuDju+FTwtAcIRp1DKrOHrSCvPlEYalWCzhkFjcTz7M=;
        b=YX7jTgGLER2HWsHYAkrgpi/aJSypJCrSBKg9MKvFbiuDJHpMzQePoYf1W1ymgMacNx
         e4Ixena5/t3DtcQ/biUgqHreFoOYKE0coJWnHSG015+mCjHEXh7nz/uUPtoMqqopk8NT
         xTPA+gtoWtTodMr5xK9NsZ8GU0xNtuPLfOTw5K30Sg3F4QuoC383vUpwEKQFFVfxgda5
         l4rxtvYPXlxb0NOtSIXmarc82TjL4qF0ihV9hEsXBlIksN3XLWa7XaHjHhSu31h8X/L6
         AoMumglSz9garcONUlApZ7BjtcH0fNaCd1odLQeFtAjScQjQ5/u05hKBnTVs6d8dG43d
         rPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WuDju+FTwtAcIRp1DKrOHrSCvPlEYalWCzhkFjcTz7M=;
        b=KmAJLnAJxLuWB9Cdu3ce/P9F3JfnLr9OhYAYvfD+ZufzlbbFGTd9h8MJ/6yCdVg/Eg
         Iyn6FvVEMPI5Yhcg5dF2tMCuvMzDNrUqpnRXjkcIJVnd3ubc9ut+/VaDoS2dnnDDIgzJ
         0PGS4AoAaaa/wewGaXKL7kN9Js17gPJC8XLoYUD/Ini5wcK7+iu2QMsJ9yTBhgMI18cM
         vJI9Acr7Yk5gYuthUA6VA19VGr5Lqaz1r+X5t6XApOWNm1GNGH6oyfaaYFwr68JQ0MX6
         g6JTJer0PDDAkoka7CGjpk3B3cBcbV6Jk5eUamoXv/5iQ684QX19algkUNZs2rHAaA+a
         TSzA==
X-Gm-Message-State: AOUpUlGYJ+KV5aOXJ9qkFmCYXU4DLfk8b5nNU3/hWnEEP2vO4XPLq9yA
        zQW5qGHIfyn2g4hntwgiLbY=
X-Google-Smtp-Source: AA+uWPzBEZppHoezu4iPsRJtSMWRcrbpSF+7+oN462HKRHm+IGyX29ELtNinTNnyIDBd6ZfEw+rNyg==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr20680749wrs.171.1534443518319;
        Thu, 16 Aug 2018 11:18:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a84-v6sm2688646wmh.27.2018.08.16.11.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:18:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Shani Fridman <Shani.Fridman@visionmap.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: submodules : switching to an older commit/Tag in project with submodules
References: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il>
        <CACBZZX5QXiAMfP8=bBps26JqSOHYSaK722GcnRjfDX-OcKQ=cw@mail.gmail.com>
Date:   Thu, 16 Aug 2018 11:18:37 -0700
In-Reply-To: <CACBZZX5QXiAMfP8=bBps26JqSOHYSaK722GcnRjfDX-OcKQ=cw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 16 Aug
 2018 20:13:51
        +0200")
Message-ID: <xmqqr2iydvk2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Aug 16, 2018 at 12:54 PM, Shani Fridman
> <Shani.Fridman@visionmap.com> wrote:
>>
>> Hi everybody,
>>
>> I've got a question regarding submodules -
>>
>> I'm working on a git project with submodules connected to it, and pulling changes from them every month (more or less).
>> Sometimes I need to checkout older versions of the project (tags or specific commits), that needs the older versions of the submodules as they were when I defined the tag. The problem is, that the checkout only changes the superProject directories, and not the submodules... I have to checkout the relevant submodules commit manually.
>>
>> Have you came across the same problem? Any idea what can I do?
>
> You run "git submodule update".

The problem is, some people consider that I have to do things
"manually" X-<.
