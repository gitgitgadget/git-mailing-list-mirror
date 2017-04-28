Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120E3207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 19:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642358AbdD1TUa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 15:20:30 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36827 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162653AbdD1TU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 15:20:29 -0400
Received: by mail-qt0-f176.google.com with SMTP id g60so58069605qtd.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVyBm72XxJrW9x0UzFV6VjZLKcNhsG5AC15Cc+tMIxQ=;
        b=IKNwNJNVw8TKJl3lll0q80UYgIlI81sXj/vDxmTPPrXCTYJAc0ie/13Xh5c0NTYlZl
         7R6zlGiw0hcpHGQgSra6VXlzS2W6Ftcs+UKNZrDmXY0LHM2h6GlyjiwjnYIlh9VTghAj
         YivJTxlnL89x7nPYZXn5Pwz9f4DRcGhNG4bIsIa6YK/hBn/+k00csi6NLA6F9VAC/5fP
         f/ck6xA75Y8HFyyMuA+luDTxboR65XAOnKudUEcwJYj1bCpRbYSLFgSbc8TMqQSS2eJJ
         9DGUxQWamTVDskpzI096YY3TmT+n7vRNWL1Ee1yrCyiocsKnFEfz5Xxj2ZKuVd2OSJo2
         9mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVyBm72XxJrW9x0UzFV6VjZLKcNhsG5AC15Cc+tMIxQ=;
        b=IXHysntWSjLYJ4VKBHr3H3ldtZrPioFuf9JEN10Vo6sS+e0afBLJqBMnD5DJXJToMJ
         hx7meqSkMlTPEsZisvWgexG2ogVPFDEnRYqmvSqvkIAvlbiDymrqTs7qxDc9loSMfS/r
         c4PnXS6a5N4Yj4UBQvdBHhTnCLfcKs832+ocVtkOgmtnLiAV5p7nG4n+HRuZLXSJxvUg
         qiJuulb6yWVNMiXE6056F26ko43czjGpMku9hKmJP7NqvKVPfu2hqE5DoejboDrjQ1UP
         j3VXMvNIHqhJcKojer8uGpuTo+myO9Ep/v08e4mTC4tNpxNvmMcXKvhpv5EY75LD4+Uk
         y3+g==
X-Gm-Message-State: AN3rC/6RyEr6FrvIHB2xNoWDdjKSafWv2o4/jGgkfpF7a6ug1wl+5frV
        jbA9ustJUzEaxw==
X-Received: by 10.237.61.174 with SMTP id i43mr11143540qtf.103.1493407228348;
        Fri, 28 Apr 2017 12:20:28 -0700 (PDT)
Received: from mango1 (nat-128-84-124-0-201.cit.cornell.edu. [128.84.124.201])
        by smtp.googlemail.com with ESMTPSA id v64sm4936587qkg.38.2017.04.28.12.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Apr 2017 12:20:27 -0700 (PDT)
Date:   Fri, 28 Apr 2017 15:20:21 -0400
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git v2.13.0-rc0 test failures on cygwin
Message-ID: <20170428192020.GA17052@mango1>
References: <bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com>
 <CA+kUOanMdez0Gu1z=bULMm0vMnFx8p12nt-e7v5LvyAiLu_45Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+kUOanMdez0Gu1z=bULMm0vMnFx8p12nt-e7v5LvyAiLu_45Q@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Test Summary Report
> > -------------------
> > t0301-credential-cache.sh                        (Wstat: 256 Tests: 29 Failed: 6)
> >   Failed tests:  12, 24-28
> >   Non-zero exit status: 1
>
> Confirmed I'm seeing this on v2.13.0-rc1, and this passed in v2.12.2.
> `git bisect` tells me this failure was introduced by commit
> v2.12.0-267-g612c49e94, added by Devin Lehmacher (added to the CC
> list).

Can someone with cygwin check that `test -S` works on cygwin?

The only that tests that failed are those that use `test -S` to check
for the existence of a socket.

I'll also take a look at verbose test output (maybe with a trace too)
for t0301 if someone sends me that.

-Devin
