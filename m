Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B970C2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbdEQCpV (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:45:21 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35995 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdEQCpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:45:20 -0400
Received: by mail-pg0-f50.google.com with SMTP id x64so65863996pgd.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ORWJvZGJWb07hRCO74LzQrp6t4KempPytvJWx55zwXg=;
        b=a4Shm89luNi5cF+GOvfEcR21TJHYVaUEjo9J+84U9iaTWFwbMtQZOSlz6N1rov2HLo
         r0cVWA3TI+NShB5WSeJ1FuJcr6MQTqcaqz/4sjj18lCd7e5RGU3ywB3dtdl7N/wHrtfj
         8tzD/+/VfsL+NBBHvvW/FCG/lhjgqPyczzFTJVZmWKlnXtOuJG9biq8PTuF5dx5kZISM
         8osM9IZmxcvUdnDG6I7K+nYq5ynXKc5aiAD++oixu4fo8zjC5cVgm11tWYIYtAty1B5g
         6Quiu8Oqsu1/2u4JRUWxBp/f7Mx63yR7gfoYl5kWnbFhbC1/VVvFtWaIzZfbppvjkin3
         SEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ORWJvZGJWb07hRCO74LzQrp6t4KempPytvJWx55zwXg=;
        b=mXrxLxjmaOA55UBEKQKuAVUzNmQrLsGyHDEhSUrC4zpoR38IMb4wJxwj7tpnx9vfsI
         aQJ/LkEvPxy41mzb+NDMmHgomsrg6hb6GxiQGxGywYFlHzz3pCOvePLJlssRnqYJPCgx
         PkWGSMgNKFFXnKy7AqshRDvP39grYJDyK+Vz8BpF/BShkldXs/ga/OjHq12L/3D5mhCh
         8dV/QTpuLjAbTgsZaxC0iX9+iacWiJ/gw2qTpVxmnup0wHt1bQMFVtZ9EGSwAIW/Uak2
         46RV9VSDqeuaxWQ9WjjJQmoMmvyEtIUJpS2xOeTG/6hb3entslCktT15vhWbcfLM1+sv
         kANg==
X-Gm-Message-State: AODbwcCJqtgTpfrrZL5f0pDys/X0X1zeFtfoutHLCLNuuAnbq51LPuT5
        hH1j9OU1/kRgwA==
X-Received: by 10.99.167.75 with SMTP id w11mr1286599pgo.148.1494989120117;
        Tue, 16 May 2017 19:45:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id c7sm611849pfk.103.2017.05.16.19.45.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:45:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Joey Hess <id@joeyh.name>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
        <20170516203712.15921-1-avarab@gmail.com>
Date:   Wed, 17 May 2017 11:45:18 +0900
In-Reply-To: <20170516203712.15921-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 May 2017 20:37:12 +0000")
Message-ID: <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add an optional test to test git-annex. It's guarded by a new
> EXTERNAL_TESTS environment variable. Running this test takes me 10
> minutes.

Well, it is one thing to place git-annex under CI to make sure its
latest and greatest works together well with our latest and greatest
(and it may be something we want to see happen), but driving its
tests from our testsuite sounds like a tail wagging the dog, at
least to me.

I do not mind at all to place the simple reproduction recipe Joey
posted as a new test in our test suite, though.  That kind of test
that catches changes to externally visible behaviour surely belongs
to our test suite.
