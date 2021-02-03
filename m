Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C878C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E597664F6C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 00:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhBCAfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 19:35:01 -0500
Received: from out2.migadu.com ([188.165.223.204]:37937 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232545AbhBCAfA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 19:35:00 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1612312457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nif2cKwBtTr2k6Wphpsti0USefyJHqmomY7C/BsfDgw=;
        b=Igbdurez0Pk1uJLFCqTIQ5OX7PJkq7dRHp4nS4M8py4blbsrZuR1WejU2Q7F97QzRIXRoJ
        jBM3nH5XCmxPIHzz/RveBVuEe024Rsy9+sg8YNoTDFuRe1bznBVzSgaKQ+NrBJXwakojVc
        DnBU/FEVEBaFLXGe6XVRMfuw6jFYVn/E/8Djw/5uEIKWM6XNDPjbRVCBAY7fbqyo+CS7Ev
        d7K9thP4HiEwvKDEBaAjYydTOQy+qZDrtEqfuDb4JM2calSn0AeyIQEQ1dshogWYHB/R58
        kdItiqMH90ZDZ37tm6EUPNZKC8bNnvtaDZkKZRjLQ9R/NCWNi33KGKduPCDdqQ==
From:   Kyle Meyer <kyle@kyleam.com>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
In-Reply-To: <CAGP6POKb4uPFECJ7Ghu-jZ+fe_S2oR_OdPDVQeMwnswp7KX_=g@mail.gmail.com>
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
 <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
 <YBkUJP2u4NcldpOp@coredump.intra.peff.net>
 <CAGP6POKxr6k5KaC0xNaFGt=mBoEMkObNGHhDpUHQdEbsokrHhQ@mail.gmail.com>
 <YBkZZrDzBo0UC+SQ@coredump.intra.peff.net>
 <CAGP6POJStLEGwiU6yobaA6ag1q1ametFoe2AVkOAs6zDQ5bk3A@mail.gmail.com>
 <20210202222339.GA20119@dcvr>
 <CAGP6POKb4uPFECJ7Ghu-jZ+fe_S2oR_OdPDVQeMwnswp7KX_=g@mail.gmail.com>
Date:   Tue, 02 Feb 2021 19:34:16 -0500
Message-ID: <87czxixa47.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyle@kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hongyi Zhao writes:

> On Wed, Feb 3, 2021 at 6:23 AM Eric Wong <e@80x24.org> wrote:
>>
>> You can get all the messages sent to you in gzipped mboxrd
>> format via:
>>
>>   curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m' >mboxrd.gz
>>
>> And public-inbox.org/git still exists for redundancy and dogfooding:
>>
>>   curl -sSf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m' >mboxrd.gz
>
> Thank you for telling me this. But why the content can't be directly
> print on the stdout as shown below:
>
> werner@X10DAi:~$ curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m'
> werner@X10DAi:~$ curl -sSf -d '' 'https://public-inbox.org/git/?q=tc:hongyi&x=m'
> werner@X10DAi:~$
>
> As you can see, nothing is shown to me.

It's gzip compressed.  Try something like this instead:

  $ curl -sSf -d '' 'https://lore.kernel.org/git/?q=tc:hongyi&x=m' | zless
