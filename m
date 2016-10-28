Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE7E2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 20:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761338AbcJ1UgI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 16:36:08 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34014 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756124AbcJ1UgH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 16:36:07 -0400
Received: by mail-qk0-f177.google.com with SMTP id x11so52887632qka.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CjdVfYGyFIWjD2PLBxQmg+mHW2/Mpd+mfHvRLJeBgko=;
        b=M+q1fykvir1Gb15I0eIpM9Y8qdpTPjGGVmrEhb3WRwj8foGnbZkRxCc3uNat1azbIc
         cwYjL6jL2oGGAv4emJ6S1CGAI/DG+MlBsUF4a6E1DQqYaGmJr5eAv4WmzVQlbysN+XiQ
         YLW8MT8UPTHtWgjk9DZwGRiMaRNWLvBRLGnTWqgNhEMEENY/cUqrBdIifLJIA4UEJCFi
         Oo6LOZhcD7w30WFLz3a1lzrRNpysG4FfmjCTPeNsXuOltSd4nv/6+ox0zdCEI3x3/Hag
         MLnZR13PXlnsBa544kgfRe1Upi6lj5vbxQsycw8bJE6gVfkmiZLbyyEMuWEMiAVo90MH
         mlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CjdVfYGyFIWjD2PLBxQmg+mHW2/Mpd+mfHvRLJeBgko=;
        b=Djy+o2trvrj0ZCFzZKkeXKEwweQ7d1eYw+SRs6d5cRR7cOM4d3MOrv0yCv3kaLjYEM
         4oBCZaNHFtSt7e5gK7Jh4hDcGZUQ5e20+tJwhGh0aXBYj81IeDEi5Y/3eN9FLpgCvC4b
         Q7UNr7aRiVCp0/liTwbQl+WVONFTGSECs77LGJsAZ2QIScMllNzh/QkgMGGstjJ7Ul+N
         j5qlxlHKNCk3PRFEp7jtW8OBNrcFWboivfJJ8n0cO8xzMrdOgBOrVOom9Oq0VtUB53Fa
         83CHJiNXOWC+I5QM2XS2yVh337wEBZciZsqgsTLYQoLcqVcHpRHWMzCcnkxaNvnLycNK
         CoAw==
X-Gm-Message-State: ABUngveUBhF6c5chd5xHcwfoqG+v7q7BzVetisCyvud9x1SMKKwDI3vQL4IADkJM410z8mgw379DaXLcdyD5HisT
X-Received: by 10.55.184.2 with SMTP id i2mr14015283qkf.47.1477686966387; Fri,
 28 Oct 2016 13:36:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.34 with HTTP; Fri, 28 Oct 2016 13:36:05 -0700 (PDT)
In-Reply-To: <xmqqr370z07v.fsf@gitster.mtv.corp.google.com>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
 <alpine.DEB.2.20.1610281356310.3264@virtualbox> <CA+P7+xoyF8EG079eC-dfTSj+YrbxhPWx356-jZ90gDs6SwyppA@mail.gmail.com>
 <38b70094-5550-8512-7735-a6739f435803@kdbg.org> <xmqqr370z07v.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Oct 2016 13:36:05 -0700
Message-ID: <CAGZ79kZVivquVDH9S63K8p3bOis+e=b3cKVVrg13zPe_BrL_Sw@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 1:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Another problem with the proposed patch is that there is no
>> declaration for attr_start() before the call in compat/mingw.c. We
>> would have to move the declaration of attr_start() to cache.h (for
>> example), because #including attr.h in compat/mingw.c is plainly
>> wrong. However, it would not be a major offense to #include attr.h in
>> common-main.c. But when we do that, we can certainly spare the few
>> cycles to call pthread_mutex_init.
>
> That sounds like a good argument to have it in common-main.c.

If we're going that route, I would get rid of PTHREAD_MUTEX_INITILIZER
and call a pthread_mutex_init platform independently.

>
> Would it mean that the code that defines the mutex needs to have
> #ifdef that defines a no-op attr_start() and defines the mutex with
> PTHREAD_MUTEX_INITILIZER with #else that just defines the mutex
> without initializatin, with the real attr_start(), though?
