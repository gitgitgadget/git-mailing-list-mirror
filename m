Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF5920248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDIPic (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:38:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38391 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIPib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:38:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so21542285wro.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uhGaouN2BBhU6DUPBHiIcJdwXTFrmtrYjfeNPBTdKSA=;
        b=vG/jMCvjr9CpRkSVfQgiEwHb1oFJNl1w4bqLlQxsEdyZCAHpFpenPCJrbnLXLnteQt
         DaMU1giCLKmDPJV4DNqRDxr6ZqI5cUo6hZy86Tbbj6aNOM0ggY2f1fJNKwgo4B5BdFcg
         Y7fAVarsb+tzrQPVq/v9pgubydlBkFfeg2DW2/OWAWMmFBLmBRDZLt26cjZkkpofXWNm
         MsQuU4oQbXMw5IUMZg1X4jC96Kpch20mUZxy/y4LVp+QA2mQRsTKsqpuwOJYVBbfyOG3
         AmptGpdOnmcF6iJSozsBJs6+odV3vKhjgAHK4fxImO71UetQvtlhh7VP5f3V9L+cjPgR
         WDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uhGaouN2BBhU6DUPBHiIcJdwXTFrmtrYjfeNPBTdKSA=;
        b=tB65AlOCMITpOPQtTGz4rLZ9fe+mT7RZ817d+XyVRCGYj6NnX6SXJoJUELYzq0k7yJ
         o2/7bvFxO20NzBcYFnPHqAEh7G7t9oBzb5Hj1IaSx9vOXEmWls9+MzFlL1zugjuGIrI2
         0Alx0Ds8WDS1lq+4F/4HyUcdYpoTNA7N097g6K/DqXcz2TtJ3iZe5XJqxf1fbmDp8v27
         c1/4EKnL68/BOV5E6q909gKdyZioNJ8T5416gOgf/vOEdTGRzkqzK+pFzUAHM1JIEqaf
         HoojGKUCnkdwBIbFDBSHf4cS/0SjC0UJ1fCL7R14Q0LBgfRiiUkvUrV7Vhpx9MZ486G2
         oCDA==
X-Gm-Message-State: APjAAAXbO/7itZNDxdYcHjTezW/uIvp3LJ00JX+oZL+MuiHrUKggakw4
        Q6E6w1HwsHPzC+Ir1ghwMPNA/rTaX2w=
X-Google-Smtp-Source: APXvYqxFM/9qKes88e0vmofK31dMBHn9toiGgAML3hDN5Qb+wefJFgaw7pLewLC7qKoxMFdoRss53Q==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr14299334wrq.176.1554824309835;
        Tue, 09 Apr 2019 08:38:29 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j22sm101522078wrd.91.2019.04.09.08.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:38:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     Michael Platings <michael@platin.gs>, David Kastrup <dak@gnu.org>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match ignored lines
References: <20190407214635.12984-1-michael@platin.gs>
        <8736mtqy9n.fsf@fencepost.gnu.org>
        <CAJDYR9TXL_9JpWvNv9ahK1aYV4isduHhvzvobCJ16q7LWhPRcA@mail.gmail.com>
        <6752a735-2e7b-7d13-799f-a42e6995498c@google.com>
Date:   Wed, 10 Apr 2019 00:38:28 +0900
In-Reply-To: <6752a735-2e7b-7d13-799f-a42e6995498c@google.com> (Barret
        Rhoden's message of "Mon, 8 Apr 2019 12:03:29 -0400")
Message-ID: <xmqqftqr42a3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> On 4/8/19 5:48 AM, Michael Platings wrote:
>> Hi David,
>> You also get an out-of-memory error with the patch Barret posted at
>> the start of this thread.
>
> I think I see the issue, and will fix it when I repost the patch set.

Thanks.
