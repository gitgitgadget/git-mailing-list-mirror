Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ECE51F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeA3Uxx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:53:53 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39954 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeA3Uxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:53:50 -0500
Received: by mail-wr0-f195.google.com with SMTP id i56so12672955wra.7
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7iWblzG5tL7uSczDstb47KbhI8mRdAcSY1miiC8xJGw=;
        b=IwuZgPgnSGez3C4ZQ64BEQpzSubwyCpXHCkEFHp/b61AcPAm5U1MkaY5ANPXppBtvj
         Yo6e+FJu8Vg5hco7pbDI90c4qspTC7x0/og+s830Sk1Nas+DB8guyQzpuSpWqFwce/pQ
         y0HwrpIIkPMibTo6pFKab+hPfVZJu8azIfZGV9u4mGxJ9fTjxZbaeCHkMJKS7ZSyYBLx
         g4Hn+eH+dFjCoo6VY1hDdm2CwlBjWngtXF/SAMf3FyZ+OXihSyb/lcyuPYwn8N+pH9PD
         Y4AeZVzMC+W8+0OSLvBjJUz5K9qkVp9CfAB6gVylSyNlCIISQiua5LhvtbWvss998eCy
         B/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7iWblzG5tL7uSczDstb47KbhI8mRdAcSY1miiC8xJGw=;
        b=GMOFWFd/3nCzRaBzvK6Rwr0zehqCu0+3ApKxYk051mI1EtuTn3ZeCsfuNT30f8pqHX
         c9hvLebn7h4z+yGLARYmaCs3CdkC64gt8Q1k5EJKgZXuzcr7vM+4xoF/hAVLJVCEk0Pc
         Sz5x8MiAIR54QyyhCDvpsBNXhDed8lbtbV4evO8hPDwXCeDwbOiysfLZtQ0KI4K0VYzl
         KmcerXfIEDoOmj+6hdSMcRXeG7XAtmTNGZsZL1S8z+f+23gznodQ6HKLMdl5VGshjeLN
         1Ey4vRwkJx+Kd9+eKj1cUDvmbYowtJCjFaUCx+mtZnfY+lntZuN0KzQQYvP6jVJndifB
         tA6w==
X-Gm-Message-State: AKwxytdk9tWu2xuz3VIG7l2bt+FI5AJj+SxLVrzxuGAMTwtUnQvRTdk3
        94h2F0VwxRccZuCqEQEDWPM=
X-Google-Smtp-Source: AH8x225ARbcPtaWY9n9sSEDSrYynBIWGLRuk3WlzR/jbpqWWPlznbxbcjqgXWoOgxShcVbKwWECHpA==
X-Received: by 10.223.173.239 with SMTP id w102mr16752888wrc.110.1517345629368;
        Tue, 30 Jan 2018 12:53:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j9sm15379061wrc.78.2018.01.30.12.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 12:53:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patryk Obara <patryk.obara@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/1] setup: recognise extensions.objectFormat
References: <cover.1517098675.git.patryk.obara@gmail.com>
        <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
        <20180130013759.GA27694@sigill.intra.peff.net>
        <e3c203f8-7971-40ce-8d9e-2dfe35f51a8a@gmail.com>
        <20180130164148.GA5053@sigill.intra.peff.net>
Date:   Tue, 30 Jan 2018 12:53:47 -0800
In-Reply-To: <20180130164148.GA5053@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Jan 2018 11:41:48 -0500")
Message-ID: <xmqq8tcft6ec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Putting code in master is OK; we can always refactor it. But once we
> add and document a user-facing config option like this, we have to
> support it forever. So that's really the step I was wondering about: are
> we sure this is what the user-facing config is going to look like?

Yup, that is an important distinction.

> But that's sort of my point. It appears to be working, but the
> prior-version safety they think they have is not there. I think we're
> better off erring on the side of caution here, and letting them know
> forcefully that their config is bogus.
>
>> At the same time... there's extension.partialclone in pu and it does not
>> have check on repo format.
>
> IMHO it should (and we should just do it by enforcing it for all
> extensions automatically).

Sounds good.
