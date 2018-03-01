Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7DF1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161815AbeCAU7r (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:59:47 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35590 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161722AbeCAU7p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:59:45 -0500
Received: by mail-wr0-f194.google.com with SMTP id l43so8033259wrc.2
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jLwiWR5y2zMiuYJSmi7CGgWQ5r2+hQOl+KeTXcmhXHM=;
        b=k8KHeVCSdtk2OgEXnraGu4GhePGjhU6JsSdsoz0+gzgcXaFWxzkqHhomB6e20fDsXq
         QyP+v0BFEER4B9huqM4HrUK9jCiMdwzvuUxccOEwIC9PPOCmRbt5htDS3BX77V3mIrgk
         dlt6RNqw8rTcLmmXy1mpKdopmEo6hZlukQj89DrqqMjGIRXIRdxONz3fROL5p4gyzVt3
         tgrQmf7K2VVy932kzGTJY6rGiSmxXh/abiuZtk4ASBngXJ9CnDE5P9r//Xclww4tOrWY
         Ro+C/cJzED1OmaALntKs9v6Y8gMr3++iIaQjwmJF68XGqvkdXaEkq01EFkNci5va3WLb
         oIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jLwiWR5y2zMiuYJSmi7CGgWQ5r2+hQOl+KeTXcmhXHM=;
        b=rg7IhxfkHEI+8M7pU5fgt4J6eqXcUk7RrR2TMfIlEtVPZ/fWGVhoZWujv/rE+ZvnC/
         MVkbC3wN+BuRP0DHmvyGHg/IdVY3ycnedD+JuOlPOG8GpCnWI8n98xKqq0DejaylQAss
         M2qQxDpGFX/2DOzP+Z2L+y2swzdxo5EDr4UJYEuuBbLfclEJ5Jmldga2kUZo8jMOiLrQ
         9EO6+v7hNoGfYhTYmUetqvp3xk4Q9f4xNeWoH4DkkCTB4+wXhe8D0bH/VnX4O+B6ArMK
         3Bkgt5THKUGBheB7mGIebnyLWkPL1byVZ2mW1T/BjdsfPe9I2AELIIvIShZa6TPlvQE3
         wNJQ==
X-Gm-Message-State: APf1xPCsPKcr+D1QQZQhJYcH774fgGLgl0ODVSYPJdu7k8wuq9NxttjX
        4fp/cDc2QcOLZV08HGKaIFY=
X-Google-Smtp-Source: AG47ELuB23wEY2x6Af/bj4qfOkAqL2/bJzof8KEQ6yV2jU/G+ybIy9NC7bRiJWoZE4VnhT2KHENf6Q==
X-Received: by 10.223.153.23 with SMTP id x23mr2905394wrb.134.1519937984416;
        Thu, 01 Mar 2018 12:59:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c56sm9530300wrc.82.2018.03.01.12.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 12:59:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 00/35] protocol version 2
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <xmqqlgfbhc4t.fsf@gitster-ct.c.googlers.com>
        <20180301191629.GA241240@google.com>
Date:   Thu, 01 Mar 2018 12:59:43 -0800
In-Reply-To: <20180301191629.GA241240@google.com> (Brandon Williams's message
        of "Thu, 1 Mar 2018 11:16:29 -0800")
Message-ID: <xmqqbmg7fr5s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I've tried to keep building on the same base that I started with when
> sending out a new version of series, mostly because I thought it was
> easier to see what was different between rounds.

Yes.  It indeed is easier to see the evolution if the series does
not get rebased needlessly.

> I can, in the future, try to remember to put the commit its based on.
> Do we have any sort of guidance about the best practice here?

I recall we taught a new "--base" option to "format-patch" not too
long ago, so one way to do so may be:

    $ git format-patch --cover-letter --base=v2.16.0-rc0 master..bw/protocol-v2
    $ tail -4 0000-cover*.txt
    base-commit: 1eaabe34fc6f486367a176207420378f587d3b48
    --
    2.16.2-345-g7e31236f65

perhaps?
