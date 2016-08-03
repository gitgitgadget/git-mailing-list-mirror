Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF821F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbcHCUMB (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:12:01 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:33393 "EHLO
	mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123AbcHCUMA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:12:00 -0400
X-Greylist: delayed 1354 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Aug 2016 16:11:13 EDT
Received: by mail-yb0-f169.google.com with SMTP id e125so324299ybc.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:10:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LS4h0bs5scgH2OnBX1hHJGodnrqZROyUQ+jqE0hDG+E=;
        b=fx4NhJgyGk7bOT3fJYvG1/ySY8GbKqfRuVL7PKhZ3xdjO9YRC9JzcYAYbnrrMCG/Jm
         4Q+hZ8xEFUrQh5DgYiF4iLx2QpplGal0x1Yj1FdYMDctRt5MYB5+l+IIea/cpnIqSP2w
         MFs+0x6wvV+jEaa4rie6R6oDh+j9/matkL7L1KYodd7T0DDEF4Dntx95vJc+s2jLKUaM
         NdwpHrBcnZyGVCNdNly7Ij8wcBvVFH+pJrGyhU34vL1OwGsNVDWOd1Eu7/Um3G25Siws
         CFq4vr2JhKl6zHiw294lWinhP8O8XEFzZj4xxl2TXs5TgbwR+JqAiUeq1RQbazW1stqp
         9rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LS4h0bs5scgH2OnBX1hHJGodnrqZROyUQ+jqE0hDG+E=;
        b=N/tgTCBa9WaBeMqrwMRbonlNX4lKZ27Cp/9pz+Fb+yXlYH216OOEY/BWMIh8Kr9RkZ
         6ko6LagpnVFgLge1NLLAFAKrM0dDy4DbcUQNQXzw7/EiSK0AdWg/5ljvJwwT3YpGdZEt
         FMNG6lADoJktTErNQhX3jJc/XokrxuGsk+tAKhO/3HE3NEJkandxKmIDYSPRma1M8fIS
         jtA2A106HbLghqtQngkJzdxDPRdTcjoSzzj0eCzn5xvAMBKopMJXqiW5qygIfysiZQtx
         Isp0jOR4aNZFSLaf0QYjAT7c7sQb+R0yrKjZRTMKpeAEffcwcpGGRvX6EiDRyZkb3dew
         CzPw==
X-Gm-Message-State: AEkoous0ShFQdLcdKtcwM2CZDYUxdNqifKdz+Oltlm3y9VhtcBMRAHYMTQftzi3XeRve+Jtws7PRIzEoN3mZkQ==
X-Received: by 10.37.78.133 with SMTP id c127mr50644686ybb.41.1470253310423;
 Wed, 03 Aug 2016 12:41:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 3 Aug 2016 12:41:30 -0700 (PDT)
In-Reply-To: <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
References: <579CEF77.9070202@web.de> <20160801164723.mober7em6znt56w4@sigill.intra.peff.net>
 <xmqq8twgi4qp.fsf@gitster.mtv.corp.google.com> <20160801211131.6ernsu74ohod2cin@sigill.intra.peff.net>
 <xmqq60rkglym.fsf@gitster.mtv.corp.google.com> <20160803191334.jflia6cqxqx2uqjx@sigill.intra.peff.net>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 3 Aug 2016 12:41:30 -0700
X-Google-Sender-Auth: hQiaON8gy7onoYIs3T2pgDYpqCs
Message-ID: <CAPc5daVABao1UZdPk0BnJNkTtYYV74Tw_0CZ9-uj9sK92h+x7g@mail.gmail.com>
Subject: Re: [PATCH] pass constants as first argument to st_mult()
To:	Jeff King <peff@peff.net>
Cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 12:13 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 01, 2016 at 03:31:45PM -0700, Junio C Hamano wrote:
>
> I think in my head I rewrite any multiplication like "N of M" as having
> "N" as the smaller number. I.e., it is conceptually simpler to me to
> count five 30's, then 30 five's (even though I do not implement it in my
> head as a sequence of additions, of course; I'd probably do that
> particular case as "half of ten 30's").
>
> I have no idea if that's cultural or not, though.

Now, when you say "count five 30's", which one do you have
in mind? 5x30, or 30x5?

If you meant the former, I think that _is_ cultural. I am pretty
sure that I was taught in school(s) to read 5x30 as adding 5
thirty times.
