Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4F720D09
	for <e@80x24.org>; Mon,  5 Jun 2017 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdFEAiS (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 20:38:18 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34303 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdFEAiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 20:38:18 -0400
Received: by mail-pg0-f53.google.com with SMTP id v18so2967852pgb.1
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 17:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Gr2KuUk+AzKbdPMLu4cF/VXl8LC7//1iCRKjpWwgUoU=;
        b=BkdLkPg1ZZNPaQEO8mW+qtTM1ckNpJDiKgVZu1E3hO6VzlEAxAR+QYZ1K7ik2iq5Qh
         VJJysJxEZR9P9x/2vw7LGebbtZe3AbvrZJanjmG20m/kBxuWNug35Xq/N5bIh2+9HELX
         gLTv3adrm18041rx0GgKk5E8HE+fsDnskR4Uxkjs0B1wLL8A8xfc7ef8dDbRo+RNe2f9
         bbFgrTe/0D9Ab0WrR02uZnaxprjR/1qOKae6t74DlzficaOzlkG4LuGaop74AdFXqLDA
         TylE+GjTP2jiqvo+R/xpBacP2jqIsy4NIdqIPuP0QAJNTFnWm2+nNKph6eELMgA5BebH
         RnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Gr2KuUk+AzKbdPMLu4cF/VXl8LC7//1iCRKjpWwgUoU=;
        b=irEYTjajgnMoAy3sYx9Rw+A7Z3qKVyxXgeuURflti5z6CKgNEqQicYpCFF2jAQY+0I
         hqI6ocMcBeN0SBmL5ziYyKKNn16CcTPsSXY7UjoqxdSqya/UqhygUQfjoDOZgumbZbbP
         KOzzgux2IvQzk6sx6VZ5/U8BHdqcBeEwgqEcKWKrqj/a6RDH7Wyuz9W8CGRklIUB77xn
         LMgvYALOfLk3ly5iR6V2o0XNFGyoYJoBsDo80me/1s2Lc8Ldfew21gbpP6WmR+NNaJr9
         or6/JAyMlAPYQz/5VCNLo2eWDjDCalRWlBMeb5uVZewzDTDC26oniFWkJ8sZh8mYCgtg
         0MQQ==
X-Gm-Message-State: AODbwcBuJAoZN6z2mROaOvWgt52X/yckxELd+N2kjo4UqGs8pkG0gRNx
        YS453YRme0zBOQ==
X-Received: by 10.98.43.206 with SMTP id r197mr17404315pfr.202.1496623097379;
        Sun, 04 Jun 2017 17:38:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id r29sm24417963pfg.95.2017.06.04.17.38.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 17:38:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
References: <20170601182056.31142-1-avarab@gmail.com>
        <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706021803460.171564@virtualbox>
        <CACBZZX7yEs0U4LnULYMGM5CoDCACeh8DM=ONV+UmeM4EQsk7Sw@mail.gmail.com>
Date:   Mon, 05 Jun 2017 09:38:15 +0900
In-Reply-To: <CACBZZX7yEs0U4LnULYMGM5CoDCACeh8DM=ONV+UmeM4EQsk7Sw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Jun
 2017 18:45:08
        +0200")
Message-ID: <xmqqshjfuv48.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 2, 2017 at 6:10 PM, Johannes Schindelin
>>
>> Will continue with testing Git for Windows using PCRE2 next week and keep
>> you posted,
>
> Thanks a lot for testing it. Great to hear that it (definitely almost) works!
>
> If the grep tests it's very likely that all of them will pass, the
> only tests I run when developing this series (outside of the full run
> for list submission) are t[0-9]*grep*.sh t[0-9]*log*.sh tests, since
> those are the only ones impacted by it.

'ab/pcre-v2' was marked for 'next' in "What's cookin" a few issues
ago, but I'll keep it in 'pu' to wait for the above---please give me
a go ahead when we all are happy with the topic.  I expect to be
offline in the later part of this week, by the way.

Thanks.
