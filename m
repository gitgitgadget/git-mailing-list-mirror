Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0281F404
	for <e@80x24.org>; Wed, 18 Apr 2018 15:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753073AbeDRPbS (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 11:31:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36864 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeDRPbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 11:31:18 -0400
Received: by mail-qk0-f194.google.com with SMTP id d74so2191987qkg.4
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jn5oJ5uRzVexRT5WPtflFFHT5kGols56ciu8CkyOJ0o=;
        b=f9JM8zN0CaTDXqNxdAkMJnurh25+/Jkfz1MqrxXJw1B3z1UXi37j4sCiD9xZoO3m32
         OCCrljlwC/Z6k6W0t3uNYz9De2WIOUvDvgrnP4QQtxf5+wXWnmrAWC7rZHEBVQbtNJ2b
         SU8QOA9vGBBJQ2IUXnq10Y//a/i6EJ7jF8nOipgwun8EQvRIW8jCxB4xoOTYbCEmXIcg
         nqf2HAbbtUVrJYoPOEELSyML00QbOntOwjqpVe9F2tIoz/FwHhZ0j/tK7rswf+helDNH
         iCvk5qHsGf7sarMY7UWkhwbzQHhY4GZusen8TYritvVQUZpRNdZO/SPe7y9aIEqJlMst
         xUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jn5oJ5uRzVexRT5WPtflFFHT5kGols56ciu8CkyOJ0o=;
        b=YlmLibtpPUbK9/iNKaoFOI4mxcl7AnFBXxTq3Q9tek/oOECoR7Z5M8R7+HmsQ6D032
         S1j7sEJlvwHikt9YidoYRc5d3KWSzXznpQEt6CY1G3Dt9l/PdvmlDWYFnZU3veazy0s4
         fJ+NDoidSahASlQeyUlpA46xJTZZ8/GReIE8FoTmbWfPJmGwKUvThxonDI0Vjt0SHHEE
         fg+ZZqLbuBT4g/BGz8LnUUAj5EjDJ5zIR+NwGdCRTY/EKmlGDIZB2M0rR88STy68SqrB
         49vqaKzILBqHOefd72gC7QmyRVZKBU5XlhQ+RURxfgoj9E7bSW+YMih+N6Pe7xC/nXM1
         OQjQ==
X-Gm-Message-State: ALQs6tA83n/B/KGMCtGm9FsVfyrqjg80spw4CgbLrPaGYl9fsp5AheQR
        cYnEo24PB9tnnpgHw18C4UU=
X-Google-Smtp-Source: AB8JxZpKZ5gDso25hA/Nkx39Mcbn0MKfuXCr9sAtWCGJVjFnwK8K9vtE4IkAJ5Bfb6S/m/TCJsTVUg==
X-Received: by 10.55.148.1 with SMTP id w1mr2426876qkd.354.1524065477147;
        Wed, 18 Apr 2018 08:31:17 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e4sm1038254qkc.66.2018.04.18.08.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 08:31:16 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] fsexcludes: Add programmatic way to exclude files
To:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Cc:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren@gmail.com" <martin.agren@gmail.com>
References: <20180410210408.13788-1-benpeart@microsoft.com>
 <20180413122218.1756-1-benpeart@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0de30972-b0a2-67e8-7cff-c19daf9ece8b@gmail.com>
Date:   Wed, 18 Apr 2018 11:31:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413122218.1756-1-benpeart@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a bug with how this patch series deals with untracked files. 
I'm going to retract this patch until I have time to create a new test 
case to demonstrate the bug and come up with a good fix.

Ben
