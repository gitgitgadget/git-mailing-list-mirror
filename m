Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136391F454
	for <e@80x24.org>; Tue,  6 Nov 2018 01:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeKFLK6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:10:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40357 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeKFLK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:10:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id i17-v6so11641550wre.7
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 17:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x1R9WjiNpesmGpIL4UJUQSpzCQKBGt4U8cY8kfSLCkQ=;
        b=R860oARNpwsc/eOiBQMIbDaCpsAE4zrqShk9FW0nH+cSFT2HRLVaRYN+U2cD1uR9+x
         Fx/oT8rd34hJ9yyH3aC/0suOKNZzJ1RBDdd87CFjOrf0iG2MbYqXSj+z6nrGoDwOqWxD
         8LDCICk4JpMwClCNFHHoKE1IKXH/2SMYhKl8sDg8EtL9vcwfXyak7cOyMxjC+Grnp1ZA
         QyXqWuW6+pnIlDZP9ZknOyiuJgm4Tav52Byf2lLbBrFoZP0oPHLxhw9UJ7s3oqxgvzoz
         YxryuuO64nyHaWdY7J7lVGxy8JfgBjk56UUmqGFqKvzbY0pp5uhcq2z/jBD+EVlCEsY+
         09aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x1R9WjiNpesmGpIL4UJUQSpzCQKBGt4U8cY8kfSLCkQ=;
        b=RkJXCTth6zzrsDQTpTsy0u51keR9hiPrp51cGO914yPjBlaG7dfchqyJp8FOppZmVi
         EvNWjrTICGvoVwowTs+q6m6hSounld3sUK0YB5QphpnRdkee2i/Kkj5PVqP4PENGuTev
         5uUz5VPaS87qB8cZgk8FrsRL7yTYyP3b7bJkCFmfyLJt3pIyO6YDy/pkn6pXD9W6sIRj
         fKJ8Eo6OM9/5tXH8NbFw2sHjQ011Dru5ibI/8RSZX0Ghv7mcpz2GQbAydnM7jF+Cp/Fq
         WXCT1AYOBz0YDnq8UaO0U3muHxiEhgJ/66gFlxbqSdWnBYZPaGNVHMDqmIq7kY7ndhpd
         dDAg==
X-Gm-Message-State: AGRZ1gJt9iDrJ98FZzmf5HmzebZCyH/ccLTvfXHAmttxhCeMVCX+L/uj
        bOBNJ3+gEKytdCXl0A1P9DM=
X-Google-Smtp-Source: AJdET5dQpvs1BYbDATSpzCIZfLVYtE+Aa5+C1nWtdPqdgj7mOdf7lCqzr9SfAqhWTVcKqJp/jtuC8w==
X-Received: by 2002:a5d:4e01:: with SMTP id p1-v6mr22624758wrt.320.1541468894540;
        Mon, 05 Nov 2018 17:48:14 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x197-v6sm349954wme.15.2018.11.05.17.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 17:48:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 5/5] pretty: add support for separator option in %(trailers)
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-6-anders@0x63.nu>
        <xmqqpnvkjmtu.fsf@gitster-ct.c.googlers.com> <871s7zl6xp.fsf@0x63.nu>
Date:   Tue, 06 Nov 2018 10:48:12 +0900
In-Reply-To: <871s7zl6xp.fsf@0x63.nu> (Anders Waldenborg's message of "Mon, 05
        Nov 2018 19:24:14 +0100")
Message-ID: <xmqqmuqngen7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> AFAICU strbuf_expand doesn't suffer from the worst things that printf(3)
> suffers from wrt untrusted format string (i.e no printf style %n which
> can write to memory, and no vaargs on stack which allows leaking random
> stuff).
>
> The separator option is part of the full format string. If a malicious
> user can specify that, they can't really do anything new, as the
> separator only can expand %n and %xNN, which they already can do in the
> full string.
>
> But maybe I'm missing something?

I just wanted to make sure somebody thought it through (and hoped
that that somebody might be you).  I do not offhand see a readily
usable exploit vector myself.
