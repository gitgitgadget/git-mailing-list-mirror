Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D165B1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754812AbcJTUkU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 16:40:20 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36731 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbcJTUkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 16:40:20 -0400
Received: by mail-qt0-f178.google.com with SMTP id m5so68994183qtb.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zG1ot/9ryZHcam1ak7NIyG6HMan7Xf6DvEtWh1BwDW8=;
        b=1zVxZL8nkyst4khBgSLnnuNjWwvgti0nBGBQUxYC2sfiwzDEzSSaRUNFoc8WngdiuI
         OyCzweovm1Bf6rZj1WAXeivAH+7K9CLUqcSK5zCSECkprqs+AdUKZcdmAYwuW5GkMfss
         jqarZDHYd27O3NN6Cb0plivAH+ndePYd5AiIWcf0SpEeZAG0ECgKvDT73cUVB6M6mJeT
         2RkVVDSsb1yhhLPEo1/3WsOdFG9zbGCLE3TbrqCAcRGnngTX1CMj0igRqWHr+CnuVRAG
         1BW9rw4m5BQb0eGyLap/4rFhfOeakq6TfudDagzmFFLkwDY/h+eMYQPCCiPSrYGUOKeH
         5b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zG1ot/9ryZHcam1ak7NIyG6HMan7Xf6DvEtWh1BwDW8=;
        b=epnOT+O800b3J/7FSWjnqP20vXNMFokU4EXjk+MP6KtphiLbsRWANBIFcD3kPHVx9H
         +ZHbSIT8x26xOc4h2vHOm0uUQA7xxBMpOcRA1FX9izz3EBum2WqGFe2k2mzGgcbGNTn6
         fh2VWhdXhRxguuYLQ6KkJ1d+H04L404GFAn65raRxo4cMI5OduU907wRoaAX4boxeFTz
         J4KBHLhNZSTbHBpL77sB/1FLGXao9yrdDV278xQ3KAyT53Q5rkv5U2HIHx0SZoO0iRu5
         /adhdE9ORLOMhXXW9em1NLhSrg2OlEwzuLpZmxBMXXWXKNkqv7SBvUXnrTX73UKPa285
         2DkA==
X-Gm-Message-State: AA6/9RmtLJ5Pk2HtBWE3qgjIaySREBjpy/+1kxI2ASPLR0z+whjmv3K75vdg4/9EES5q6g==
X-Received: by 10.28.209.142 with SMTP id i136mr7407749wmg.1.1476996019113;
        Thu, 20 Oct 2016 13:40:19 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id yo1sm81419759wjc.16.2016.10.20.13.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Oct 2016 13:40:18 -0700 (PDT)
Message-ID: <1476996017.28685.10.camel@kaarsemaker.net>
Subject: Re: Drastic jump in the time required for the test suite
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 20 Oct 2016 22:40:17 +0200
In-Reply-To: <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
         <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
         <alpine.DEB.2.20.1610201154070.3264@virtualbox>
         <20161020123111.qnbsainul2g54z4z@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2016-10-20 at 08:31 -0400, Jeff King wrote:

> I'm also not entirely convinced that the test suite being a shell script
> is the main culprit for its slowness. We run git a lot of times, and
> that's inherent in testing it. I ran the whole test suite under
> "strace -f -e execve". There are ~335K execs. Here's the breakdown of
> the top ones:

You're measuring execve's, but fork (well, fork emulation. There's no
actual fork) is also expensive on windows iirc, so subshells add a lot
to this cost. That said, strace -eclone says that a 'make test' forks
~408k times, and while this is significantly more than the amount of
execs in your example, this does include cvs and svn tests and it's
still in the same ballpark.

D.
