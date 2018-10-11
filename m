Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433B21F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJKJSk (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:18:40 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36199 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJKJSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:18:40 -0400
Received: by mail-wm1-f47.google.com with SMTP id a8-v6so7590492wmf.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UNjp1Yzgg5c/8SBGYSb3i3qNKT8cPxvqvZTP/n0PeRU=;
        b=sLj4JcVrmW2kBNdV6vgjaZhx9emHD/oCoqWY0L2MWsbj6bwx0vMM7v12QeWOxJGeXo
         +DM39hWawopOUDPo58yuH0VtbKASGBIvaKfOAFw4R98J3M5BWEO748Y2ydHyid4dgh++
         WVlPQxA1KQmFq2ZCsua/iGzT3bqcT5KJaVTZJsFWo9F7gnEQULhtQi5VQ3Kuciu1JW3S
         U77wFOcSxK9DsZMK8liYvK+GGD2BiByEc2XXtBrmw9bGOpw56Owoe+PY0IjwJrgx1TCm
         kvP8OOuVWaBevcYE8ZIAEIGoFKU/OWrdzJaUE3hhpcwYPAC7KR4Ku8gVwQ8ICI7eWr3a
         9XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UNjp1Yzgg5c/8SBGYSb3i3qNKT8cPxvqvZTP/n0PeRU=;
        b=mJGlmZgZkoieI4gTkK8Dk/IxtEPlYVaUSuEKfNq7xiayAfRjL8uY0/GhYtlczT2HZR
         RqtxjIls98EDWsoEGKKdeEtThB6+1dvXB7ivUAX8EABQiahjbDKlc1GhjOALJwwsUlHt
         bfOvdaW+AQJn0ejdvQ+tEeAv70Vnjtvfmy5QT07c03pBO2kCcORnk1kmcSfuWPL4NSxA
         +PyDW4giiGC3LGCP69BEtn11zNnsHj/9J78otr1zHvNw3cfURca5VLNyWMW35XqOJIHu
         BbOh6Dw4DeFsDm86XoQGGPHlQl3OilQ05Lv7COhMJU0iGJhqXS9NqcTIqkSkwZnGk9Xk
         XrJw==
X-Gm-Message-State: ABuFfoioySTn6ABTEW1pmJEvcCcRZw+MPFCVzEm7Rgco64Kxa3OPRRcB
        V0mcnpqFx2acHO1+DcnF93s=
X-Google-Smtp-Source: ACcGV63SZwZIaXfGF+WNNJA2CqCluEr7/oPunv+AHDMF/Kkpb1AUrISPN5xBTkzyIJgFAKEJdFtPQw==
X-Received: by 2002:a1c:e717:: with SMTP id e23-v6mr2688393wmh.145.1539222823784;
        Wed, 10 Oct 2018 18:53:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b8-v6sm16105540wme.1.2018.10.10.18.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:53:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <3362a7a4-bb03-66a1-0f3f-929fd4b09195@kdbg.org>
Date:   Thu, 11 Oct 2018 10:53:42 +0900
In-Reply-To: <3362a7a4-bb03-66a1-0f3f-929fd4b09195@kdbg.org> (Johannes Sixt's
        message of "Wed, 10 Oct 2018 23:25:11 +0200")
Message-ID: <xmqqlg75i6zd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 10.10.18 um 07:43 schrieb Junio C Hamano:
>> We haven't seen much complaints and breakages reported against the
>> two big "rewrite in C" topics around "rebase"; perhaps it is a good
>> time to merge them to 'next' soonish to cook them for a few weeks
>> before moving them to 'master'?
>
> Please let me express my sincerest gratitude to Alban, Joel,
> Paul-Sebastian, Pratik, and Dscho. It is such a pleasure to work with
> the builtin rebase and stash commands on Windows now. I am using them
> since a month or two, and they work extremely well for me.
>
> Thank you all for your hard work!

OK.  With another Ack from Dscho, I'd feel safe to merge the
"rebase" topics 'next' and start cooking.  "stash" seems to be
almost there but I think it deserves a chance for a final touch-up
before hitting 'next' (see another thread with Thomas).

Thanks.
