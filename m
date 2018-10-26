Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776B31F453
	for <e@80x24.org>; Fri, 26 Oct 2018 15:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJ0AFb (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 20:05:31 -0400
Received: from outbound1a.ore.mailhop.org ([54.213.22.21]:22812 "EHLO
        outbound1a.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbeJ0AFa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 26 Oct 2018 20:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1540567681; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=rMb2/lWcdPbOBlvRy53zRLzcMEczDW/KW0T+DhxiS9ad4YqVvhsrla+zgd1PMqVe0UhEuRqzQswD5
         e9PnTzgScyQb6AYG1NazQuTb5/GmlknA4ltSRlwqSA8bBkvC5qXDO8BjPSWxPIYmrLBo1OltRaiYV7
         X5tNyqjM27MsDHmDEo2KrHo/opOHeA6h+6Lz4Zm4oEv4U4axclYBZ5FUV0jz3zVgtfBd7qEKWJ0KtS
         JdvfzUprq1hUacM2Xrbnph4kpKFKhVnXPhIioLjaT8o07pD85NOescN047hrBOgDCIImq7lkC+27ql
         m5s3aQQ8ZSdkY4/DmB8OOCVDk6YDERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:dkim-signature:dkim-signature:from;
        bh=IOgkjK4F3gDROPvyspa2w81O0EWCcZjeFiB2sJQmxjA=;
        b=PcH3ZAlFDy3nPv3SNxD6IWO5LO7o/ZjPWEWTItfjo+q15CGpBYQnv93S0OpHJKwd76DndhZNfZPr4
         6FKf6qEyK0LE9zPtbKCEUcieChfJHwRDPYF0UfDMluN8HffX+9AomHHQXby8Zm2Xss2LJFWkYRhiMf
         3GAfF+/6LxBmMygV3ZnYxnoHzwuJ9M+5Ekhe0wWFKCF0ag33u79JDVWIpBbMYfTwsmRHxjV0Pn8Zok
         716CVi8NNyVYOR+L7CTCu6ONgsG6u+rzj3jUE6fs58/hGEcfC2JiKGjUhjkJGi4VunhELBDEaKEM+w
         YAfUZ2pjqctEZEeuXlglDBpd0bfwtww==
ARC-Authentication-Results: i=1; outbound1.ore.mailhop.org;
        spf=softfail smtp.mailfrom=lakedaemon.net smtp.remote-ip=108.39.81.162;
        dkim=permerror header.d=lakedaemon.net header.s=mail header.a=rsa-sha256 header.b=Y3A69CQi;
        dmarc=none header.from=lakedaemon.net;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=IOgkjK4F3gDROPvyspa2w81O0EWCcZjeFiB2sJQmxjA=;
        b=LAg5SyEzx0OQF9Q/Z5y+BCa4SIx08TXzG+NQL7MFsaC06J8QCYKP2SOtK+lT1xIDo7zuD8hSo5ete
         sb1Hobeog82codpUSR5EAqfhyYZwty+XBNYPpkM6hGA9hD3tXcFTpr9KXVcIFTITG908H4N3f5WMOu
         CbiiLmKHJ3e13D2qyoYEN5+RP+lsk06cCTm+k98FvXCS0Axjm5Z69Ba2drCT8PH9mSAxOOwXOELGOb
         DtcvA0YHVh/ckYzho/w0tzqyJgvP05T7AlqqCyjAmhjVkSvn+4JDZICVyQwX8kfS3M2mCJkgW8XfPr
         4nmdrev5anksiXdS7eg/A0ZImFwR+fg==
X-MHO-RoutePath: amFjMjk5NzkyNDU4
X-MHO-User: b63f3e6a-d933-11e8-a93b-310333596487
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 108.39.81.162
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [108.39.81.162])
        by outbound1.ore.mailhop.org (Halon) with ESMTPSA
        id b63f3e6a-d933-11e8-a93b-310333596487;
        Fri, 26 Oct 2018 15:27:58 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 004C080049;
        Fri, 26 Oct 2018 15:27:54 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 004C080049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1540567675;
        bh=IOgkjK4F3gDROPvyspa2w81O0EWCcZjeFiB2sJQmxjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y3A69CQiQhArINw8n1YmgzTm7hh31kbeHKs7Lgx/9W2OhJ1gHRbN6mV48Yf4SZKyM
         SBxIuzvdDfpexHWD8CY+r24wFy7ImaUZhdBlGDY6KROay8nVcBNVGFfbaa0qen4PK2
         eqqVMH4eFgP7gDBKnuXd71zGe8uJZa+VXyshh80GJCYPitA78lrPVFFfICOg9rJcdI
         65a7iOIWkWjNpfbN+vZGnFnXwkjnKPsVVYwXIjiV8DrTZb5Vcs9P7RwaEpJeLGPj/g
         eavM1Min615ruvKRZUBEoYufRnYmhTPkO1PXnicAueRL4NjNiCgU+WYBr64KQsviEC
         cRSAY9iJkYYdg==
Date:   Fri, 26 Oct 2018 15:27:54 +0000
From:   Jason Cooper <git@lakedaemon.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "lhf635@163.com" <lhf635@163.com>, git <git@vger.kernel.org>
Subject: Re: the opposite of .gitignore, whitelist
Message-ID: <20181026152754.GF24185@io.lakedaemon.net>
References: <201810251039388653199@163.com>
 <xmqqh8hak2mh.fsf@gitster-ct.c.googlers.com>
 <c166b421-a228-8349-0815-2ebb9dcab998@lakedaemon.net>
 <20181026093644.GA20876@sigill.intra.peff.net>
 <87tvl8lw5d.fsf@evledraar.gmail.com>
 <20181026133453.GE24185@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181026133453.GE24185@io.lakedaemon.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 01:34:53PM +0000, Jason Cooper wrote:
> On Fri, Oct 26, 2018 at 02:39:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
...
> >     I thought this was a bug:
> > 
> >         (
> >             rm -rf /tmp/git &&
> >             git init /tmp/git &&
> >             cd /tmp/git >/dev/null &&
> >             echo '*' >.gitignore &&
> >             echo '!*.txt' >>.gitignore &&
> >             echo '!.gitignore' >>.gitignore &&
> >             touch foo.png foo.txt &&
> >             mkdir dir &&
> >             touch dir/bar.png dir/bar.txt &&
> >             git add *.txt &&
> >             git add */*.txt;
> >             git status --short
> >         )
> > 
> >     But it's a limitation, gitignore(5) says:
> > 
> >         It is not possible to re-include a file if a parent directory of
> >         that file is excluded. Git doesn’t list excluded directories for
> >         performance reasons, so any patterns on contained files have no
> >         effect, no matter where they are defined.
> 
> Bingo.  This is the exact problem I encountered.

(
    rm -rf /tmp/git &&
    git init /tmp/git &&
    cd /tmp/git >/dev/null &&
    echo '*' >.gitignore &&
    echo '!dir/' >>.gitignore &&
    echo '!*.txt' >>.gitignore &&
    echo '!.gitignore' >>.gitignore &&
    touch foo.png foo.txt &&
    mkdir dir &&
    echo '*' >dir/.gitignore &&
    echo '!*.txt' >>dir/.gitignore &&
    echo '!.gitignore' >>dir/.gitignore &&
    touch dir/bar.png dir/bar.txt &&
    git add *.txt &&
    git add */*.txt;
    git status --short
)

Well, this wfm...

Ugly, but doable.

thx,

Jason.
