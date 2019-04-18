Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4894920248
	for <e@80x24.org>; Thu, 18 Apr 2019 01:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfDRB6J (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 21:58:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfDRB6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 21:58:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id o12so825230wrn.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KHyhPFNe+xLy7xVTyOuMYn4Hcwg8PMU2KkH6371jwcA=;
        b=ZiSAGMr5/6jk5dg7TH2GBHMy0UEmQCx25O4rth5HOA2LKs2R7bP4ViOR03ui+9Skan
         xbZKd0hmIM7LI6cKPqw/WEXlqxm6R12v/27D4mm2jPFwJ1+E/F3tJpvN0Xei2DY63uwa
         O9czUp8K+zCm4UAJ1lRMnk5qvEIkLOBPhR0LAecBecV2ezpJu/sz06rrCxyheF98W9b1
         FU9inYpgsdHHihDZCopMqAgIBkdeZ5M3J1Ex6SHy5UDrrxn7FEYJqq8V0o9YwS/JRgdE
         9KnFCsm/OeM9kQ8ezhaa8wrFKAOYTKyZo29K7g0pDEZHFBNdfMnReOfpY0Wr8jwfIdyk
         1CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KHyhPFNe+xLy7xVTyOuMYn4Hcwg8PMU2KkH6371jwcA=;
        b=VPYVt/7sTT2vOYbXChF6evGw4s1jTLxJuKDAtPxorSJrWNL70X9/UGJnJBFSxEIW2i
         T75uRvtqTBieMrFHKdH24W0TBffmpUs3BY3Ri4CsVeGSysv0Z18kQFtAL8JGFM66tYN2
         iuw++BEO5er3b7MIDFCTJP4/8+OJ7NmhD3jh1VOkDT7wq81sUwU/jOO8HAKJVUv7qUxV
         haMsnFHndvDBnW47jnqr/ClLbT1wRYLiuPKConymPfrTjo6LNYWT6gTfNI+5f3SI3FeC
         IS4MmU/N4JQegQPdP92JZFkDZfF8imJONWXz3J/AB5IjT8Q7CLyVJ8S0C2vWB+xm3zFC
         z9cw==
X-Gm-Message-State: APjAAAVD7naH0JmtGirpqoEP85yaHsf4rUmwis/+lDPPNIyZRuBJP8Je
        PT6F6LNxk4rMJhQhGPMEJ8/nPmbe3JA=
X-Google-Smtp-Source: APXvYqwN7c15c/4uAQtvcbesRz4aI3GC7DxMdr0202+J/lxX1gGMWznxtg+lJbuppZoquIoRkEigYQ==
X-Received: by 2002:adf:f390:: with SMTP id m16mr5519764wro.25.1555552687161;
        Wed, 17 Apr 2019 18:58:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o10sm527468wru.54.2019.04.17.18.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 18:58:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] Turn `git serve` into a test helper
References: <pull.168.git.gitgitgadget@gmail.com>
        <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com>
        <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
        <20190417034621.GA19448@sigill.intra.peff.net>
        <xmqq36mhkx3z.fsf@gitster-ct.c.googlers.com>
        <20190417182200.GQ60888@google.com>
Date:   Thu, 18 Apr 2019 10:58:06 +0900
In-Reply-To: <20190417182200.GQ60888@google.com> (Josh Steadmon's message of
        "Wed, 17 Apr 2019 11:22:00 -0700")
Message-ID: <xmqqy348gjm9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2019.04.17 14:40, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>  ...
>> I guess we are more or less on the same page, then.  I'll let others
>> chime in by waiting for a bit more but I won't wait forever ;-).
>> 
>> Thanks.
>
> FWIW I used git-serve a fair amount while working on V2 support for
> archiving, and everything I did with it would have been just as easy
> with a test helper as with a builtin. So I have no objections to this
> change.

Well, let's queue the final step together with the others, than.

Thanks, all.
