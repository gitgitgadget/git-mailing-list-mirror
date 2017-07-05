Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AF30202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 04:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdGEEKk (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 00:10:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35361 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdGEEKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 00:10:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id d193so11287194pgc.2
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6/KgC8XpGFqv9p+bJ9IEgEXG5FnvtzTDWJzPcVh+U1Y=;
        b=f3ZZQw40GE5jN3kgKdWda2hnnosKIy0sPq9HQj+uKAq4DzWE2iYzmWjEA29CCUTG7L
         o7wG6gnCV07Z1lO3HOpeTaRBVdf90r06ultDI/LdnbqJV2xATug6hhwsGEVOvSfrjGwN
         z31kxOe4Ab8B6B8FP39fp58Q/g9OSdj04pd4Tk46F9GacGQvrPpnCKkibwOWB9caZhfw
         25frJcuEse4qsMPbe0cw8tJDanzT/jgeSwNyZiuugW6HhNbc4BO+VKIL72hGB1r9CR2h
         qLQIMuuKyTeLJqWTUGdnWRR8Cf1p9ysacZ1jSW6eBuyjx5uyYg+5h7pYRJu9Wvfy832+
         hwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6/KgC8XpGFqv9p+bJ9IEgEXG5FnvtzTDWJzPcVh+U1Y=;
        b=limn754bLn6PmHVYj1Kc2ethr+rarezp2NTCFqAJgFkx7KXFRhtvEnoRHEt13T+QFK
         bN1rbWZAMdFU6AZa9bFefdZt6tdv1zxC3WOFOBklWk61ZekpsBsWVAOkZeHDrNOkcUMg
         x2EQ4lQA5epiq2VrKqwiGZbB4+sxLI9WtEB6ASVBjGr3M1be6jZ0Mh2G2z2caAo4GAIz
         RxizRSdTDMguR9wIzw56rQUjpZFmJmQSs15tdAowT7/pLf13XKqSRK2XceuE0ZHU5SUu
         Mzm4OH0quAvyM8ijs8xDj8y94o/k8TxSBlXa1ab2apCypPY/JmwoigJDLE1uR7L4HVsZ
         nSDw==
X-Gm-Message-State: AIVw113n4L2VaM8dMzxnAqULMMUJAMRDJC7dPGB8/XjbQHZDJB27kxvt
        hOegdfX/5e5AmlQbawU=
X-Received: by 10.84.132.39 with SMTP id 36mr19666812ple.237.1499227838738;
        Tue, 04 Jul 2017 21:10:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id a125sm23810454pgc.37.2017.07.04.21.10.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 21:10:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/12] object_id part 9
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Date:   Tue, 04 Jul 2017 21:10:35 -0700
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 3 Jul 2017 18:55:21 +0000")
Message-ID: <xmqqeftvjzgk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It is possible there will be some other conflicts with in flight topics,
> as get_sha1 is commonly used in the codebase.  This is unavoidable to
> some extent, but should be kept in mind.  My experience is that usually
> the required changes for conversion are minimal.

Thanks. 

It did have a few conflicts in submodule area and sequencer, but
they were (hopefully) trivial to resolve.  The result is queued at
the tip of 'pu'.  It seems to pass the tests locally and also at
Travis.


