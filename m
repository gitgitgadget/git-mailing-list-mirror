Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941071F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeB1Sv4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:51:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38603 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbeB1Svz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:51:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id d26so1370530pfn.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yu1UF49M0kAkbAxf3O04jRqbhTp9QXQCgO0bAJ10pK4=;
        b=R8cjJmyUa9eNHB+GZVgX1C7lDxreiWf5JvxoGrraqX0O2SsZqpZh/xSn0VsRuEnZTy
         CH/l1ky2nh2e08F/uGaPPE4NVF8e5Ez9mcK3GgjpXCBpnmQEPWSzlSISsYm1iPB+/dNg
         2dzCXZrBAZxDn+JM+J/dBPBmNgvuNif3T8EQPd1LLdJpxvBMLvpmMJ1fpRS6XZ2tz4NY
         kq13G+hPWHei0cY01sBOI34W8xs9LnG0utTDvPYYEG/MvQ4jzMpiVXCPIXZMRE6m+6Ee
         CM90hYw/56bi3qJuXl7lfTYj2GbbvFdBb+EQJQXJMhhfecOMoEZA4GCmzHqPLDet+CnJ
         gUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yu1UF49M0kAkbAxf3O04jRqbhTp9QXQCgO0bAJ10pK4=;
        b=nDbdoOCHh07XAPO9ayyxe4pnwJNTpk/xglDZk0nTXPOFR9k611FgF/GrKHFMXYE0dZ
         IE9bQpaOsiL/IH9SRhZ886iw9P1qTLPbp9HK+BY3oLnbOXEd52IHvQCUDik3ahC3NxH6
         HfvlMfxc5EI86X7+Cx8p9+/zJzDQPsVdBqO55wjVTovVHr6/XqJLahVp2ZmtKLXm/ya6
         lJFu2b0TESviq4ACbJP9xvwgqBz61JYatkqpk1+PZqLO7yK66Czd3OrHuEKRcM5QHNpx
         Rs5G7A3c8eCPv6m1t8Dv63qbR5mliq/aU2nf0O67RjDNfrfJcC6BKZi5U/gzgkAGeL/y
         lzpA==
X-Gm-Message-State: APf1xPAWN8lf6gCWotDKrfr9+jfxcKWBz+vzLA+gL9ZmMDlJUvD5vmKz
        +fhDMWD8zulkUh5D6hDoLtA=
X-Google-Smtp-Source: AH8x224Iy5ycHK2A31/y7t9xO3oF9NGNTLaJfAON2oSnK/v0Hbr658fRomPJ029hl5IlHyLB6qV1hQ==
X-Received: by 10.98.91.5 with SMTP id p5mr18670348pfb.163.1519843914384;
        Wed, 28 Feb 2018 10:51:54 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 205sm4505172pfy.117.2018.02.28.10.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:51:54 -0800 (PST)
Date:   Wed, 28 Feb 2018 10:51:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'demerphq' <demerphq@gmail.com>, 'Jeff King' <peff@peff.net>,
        'Eric Wong' <e@80x24.org>, 'Git' <git@vger.kernel.org>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180228185152.GE251290@aiede.svl.corp.google.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
 <20180228001616.GJ174036@aiede.svl.corp.google.com>
 <20180228040718.GA9043@whir>
 <20180228050034.GA373@sigill.intra.peff.net>
 <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net>
 <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
 <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com>
 <20180228174402.GC251290@aiede.svl.corp.google.com>
 <005901d3b0c0$f5acd370$e1067a50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005901d3b0c0$f5acd370$e1067a50$@nexbridge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On February 28, 2018 12:44 PM, Jonathan Nieder wrote:
>> Randall S. Becker wrote:

>>> The problem is actually in git code in its test suite that uses perl
>>> inline, not in my test code itself.
[...]
>> Can you elaborate with an example?  My understanding was that
>> test_must_fail is only for running git.
[...]
> Have a look at a recent t1404 as a sample. Line 615 is the one causing the
> platform grief, because it triggers a 'die'. However, the particular test
> case #54, had no difference on platform with test_must_fail or !, which has
> the same underlying EBADF completion after digging and digging.

Sorry to be dense: what I see on that line is

	test_must_fail git update-ref -d $prefix/foo >out 2>err &&

How is perl involved?

Puzzled,
Jonathan
