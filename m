Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC2C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 01:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDRBEQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 21:04:16 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35495 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeDRBEP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 21:04:15 -0400
Received: by mail-wr0-f179.google.com with SMTP id w3-v6so179406wrg.2
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 18:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qZ4S0nUrBkCZv1iAeJ3Am8gNsNLCfzKAHFHEN8xFAPM=;
        b=JAp/bW58I4S+GWstrEQcQMWfpK9bsfqP7uWZRloCK+44ABl8TNhJv3FKUJeic//kYK
         vbmKg4FjpU8zcNXLLdrQIdMnPNP2wphRKtc6VDqxb4FeKfJn4nxEJcug97NioiL3yf22
         wqGvg+hx9LlfhQwrXkql95t7NTHURRAd9m+tssISxxpUkB/KYrvIrjI/ff6bUx+KfYyq
         dZsRW153moW0rvu19iNd9aQJUUxJVyPA7VGeWhU7d5oMxhlWCvrjuErsOhZRsjy4G/mi
         GJ2w5wGDVEG5u7jjLYblNOfYY3oJ/RTnrNaR2UME/O2DIJDneb/7sOQG/4LAEkxuxqSH
         T/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qZ4S0nUrBkCZv1iAeJ3Am8gNsNLCfzKAHFHEN8xFAPM=;
        b=Vbi6pUo1ewG++G5R4/po64rj2dM9tFmEHa8nyaArTsdJKK9Z+oKOQeGRSiUouw2TGZ
         G7jMS9Nvd/mQotGizDNA2GB2+xyCbeW0Ogny+RFQaylpdU40MruvRSD6sU3JKv87Bt6x
         X5iWPpQoWJfq2QYysIi2JI2LyPImqd7OJv27CkqnTQMD9zAS2SBRWxnnAXKFs7hjJs2m
         D8gCrY+9Fc5DVoQPTezN+svLz239YjSasFKmpQRTd2EkP6WAubSc0ghjV3CTQXbKTo8F
         pG0WOFZVFIj1fpdpEdVsVye/5YgeymFxlGwRXKIuSwxNAQY5ZntcK6VAn5H2JN3pyIjY
         gFVA==
X-Gm-Message-State: ALQs6tAK3143siyDr21IX7xBbYXqU/E4oA83x0l7NdMaLb5/fyVpn9Zk
        hMVaVyrwAsxmQpgZZfoAciI=
X-Google-Smtp-Source: AIpwx4+VUErxF7FuKW9L47H/n2T+PGPKQhUQBRNyBk27PpuCOHcLGqILseXZKjlnTtsOX6iv/P4/Wg==
X-Received: by 10.28.152.6 with SMTP id a6mr222223wme.119.1524013454321;
        Tue, 17 Apr 2018 18:04:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n8-v6sm17694wrh.51.2018.04.17.18.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 18:04:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
Date:   Wed, 18 Apr 2018 10:04:13 +0900
In-Reply-To: <CAGZ79kb=A6BsdrtH=2F0634+r5ejG9Ce9U0mry65jkNnscu1nA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Apr 2018 11:05:59 -0700")
Message-ID: <xmqqpo2xjpf6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  What's the doneness of this thing?  I didn't recall seeing any
>>  response, especially ones that demonstrated the reviewer carefully
>>  read and thought about the issues surrounding the code.  Not that I
>>  spotted any problems in these patches myself, though.
>
> Stolee and Brandon provided a "quick LGTM" type of review
> https://public-inbox.org/git/20180409232536.GB102627@google.com/
> https://public-inbox.org/git/9ddfee7e-025a-79c9-8d6b-700c65a14067@gmail.com/

Yup.  Giving positive reviews is harder than giving constructive
criticism.  Much harder.  

As readers cannot tell from a "quick LGTM" between "I didn't read it
but it did not smell foul" and "I read it thoroughly, understood how
the solution works, it was presented well, and agree with the design
and implementation---there is nothing to add", the reviewers need to
come up with some way to express that it is the latter case rather
than the former.

I would not claim that I've perfected my technique to do so, but
when responding to such a "good" series, I rephrase the main idea in
the series in my own words to show that I as a reviewer read the
series well enough to be able to do so, perhaps with comparison with
possible alternatives I could think of and dicussion to argue that
the solution presented in the series is better, in an attempt to
demonstrate that I am qualified to say "this one is good" with good
enough understanding of both the issue the series addresses and the
solution in the series.
