Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C63520401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753631AbdF0USD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:18:03 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34003 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdF0UR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:17:57 -0400
Received: by mail-pg0-f49.google.com with SMTP id t186so20872341pgb.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RKs3tY2KmF+0hX6QcRIdx1VAgFrboTA5jdus30RvMhg=;
        b=mV8rwDYd5qY6m0YYvvcb1JnDtM2+CzHRLqAVpacMM4CuvwnTkfKH0nU75Nvvnl+mBG
         mXmh0fydzoPviwvN8uzIb8DxWCIN/ziBIBCLpIi5kci7uxvLiXWi9zk6/FdEawppksPL
         Wex0kYixLwnPEwXiKU6sYdFYIL6HvrjREUfgd7wQ800lq1XRsWxh79SJE3N6I4nnkW6C
         U+OKDXrYyXrid3GcmgOF4dxlCwy/kObEswNbPCBdqV9VXHm1HZoogPJYYOjaXx8gHHcz
         TasBo6r2yeEw9/IKkTaucTcwx+SWac4FVThyMfNtxIwVmLwrTSsOUfBrUdTO6c09uLz2
         ks6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RKs3tY2KmF+0hX6QcRIdx1VAgFrboTA5jdus30RvMhg=;
        b=pgMcwz3NPruTD1jbOoWCbj8SEAE4f12FET8/Sk7nwHLJHaB5JmOEsAHtP3HPHEGknr
         /AjtuQR02t7OuxbqnUwJDQAvX/ISNmjdUdAGbMCOzM4kifjU1V6/Irkdq1pzCGnIH+iQ
         +CHi/EwCEAmBc20LTLs2dk1lU81Kta/eYT2Z4t0OolPCPizOW6YJrY7ehXxdwD2ccR4k
         NFK3yURwIUgEn77rNJfo5jeN8MwTAxUSz1qbosU9svCkPJpqDa6+f4F74iwwjPixlAQi
         s/lsei39SCRH7fdw1I9VgkE51BhcFv6MXXevZyDmzZ6o+BpPFnjVEcvIz4TgwYqSOied
         1Bfw==
X-Gm-Message-State: AKS2vOw9pgKnh9H6LAiUqdU3RO+Bd8bAMna/BbMNW2AWuYoFBGEouSgU
        7ByF5n5G8YgUwg==
X-Received: by 10.98.98.7 with SMTP id w7mr6804378pfb.99.1498594676220;
        Tue, 27 Jun 2017 13:17:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id 28sm190813pfq.125.2017.06.27.13.17.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 13:17:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
        <87zictjoff.fsf@gmail.com>
        <xmqqo9t91eqy.fsf@gitster.mtv.corp.google.com>
        <87vanhjnsn.fsf@gmail.com>
Date:   Tue, 27 Jun 2017 13:17:53 -0700
In-Reply-To: <87vanhjnsn.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Tue, 27 Jun 2017 20:19:52 +0200")
Message-ID: <xmqqtw31yyku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 27 2017, Junio C. Hamano jotted:
>
>> I somehow thought that your throwing a pull request at git.git would
>> automatically trigger a Travis test, without you having to wait for
>> me to do anything?  Am I misinformed?
>
> It's a PR against sha1collisiondetection, not git.git, but yeah, good
> point, so that runs the same tests?
>
> Still, the set of people testing pu > number of things running the
> Travis tests, so it would be good to have it in pu, so we can just make
> 2.13.3 and hopefully not a .4 for the same issue :)

This has happened.

Until the upstream takes it and .gitmodules can point at them, I'd
hesitate to merge it to 'next', but I think your plan is the same as
mine.

Thanks.
