Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD031F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755949AbeASRZ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:25:56 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35562 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755932AbeASRZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:25:54 -0500
Received: by mail-qt0-f169.google.com with SMTP id u10so5613835qtg.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 09:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGhU5hEL+lLfcZ8Jv2xbqPIeZxea2sgiEE6ctop2ssc=;
        b=ocx78GaAFINfIsAIWP+ueuhYE7u8Oi3Lbg2z+B6L3fYjksSEyu/ahVLSxb/T8T9aFC
         OT1Uawu8d9wxv/hwApqlu0YX30AQyOIs5JjhsMJyjWXVFtILPPv6aw0sjDwRYjrzy87m
         C6vvWOhzJuIy3KL4HoLnmPtdy+78RTVbKWFXLgI3sBoIdk1CzZZM0y5ak+NtOYwAwkXf
         j03Yn+1acda/EA4WRWEYUyUQdOHdKT9eVFGLLi0itmq25d0aTZMOuOkXPxuvjxWM159k
         0DkQJGCrc3CaUWGeW66ztfVDW3fvPtcHTw/WF2rDT5NowyYXeWPHd6Ph5pHVvxfKTEJp
         xGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGhU5hEL+lLfcZ8Jv2xbqPIeZxea2sgiEE6ctop2ssc=;
        b=m/Mio6oN9Alhwc87DYj0RTysdoTz2yQTj2Yc2Izn8Nj07ClkwJQghiLrh3QExBSEom
         snasDmaZwUb//WNXYfrXfBguDd3oxGtVOsVlR0wuIG/WkMmGrcY+mV0Km4kKAzZGBPcA
         pUIh9HEMUQByM54hbWHaqEid9p+KiBv7rldtLWJ9AAc2Zi8YjeUWfCRcTUQdozRzm6Hl
         WMRisypqw9y7UZ809Gwx+wqRjJ88HYGbilfVDYELivbxX+5+1nn5SfT2aJ/QTwRc8wGB
         2dNKkPpxlGdpmXEEv0o6UC901v9yS9KMGrMfLyP9TgZy/RTFlZzGJgxbP1/2OQNUpt4f
         OJ/A==
X-Gm-Message-State: AKwxytd4XxTlFp+gTtH9av4p+7VHJ1dwP1b/6ZDxjAglclQaLCzElIoF
        QB6Izprz4Jcz2cJ2WYepTcI=
X-Google-Smtp-Source: AH8x224iljja3bsioAGfHFN9//Yp2CevafsjiCAdHhozJolXTKZX7a2ue9n3lGEiqEOCmIPqFPcvhg==
X-Received: by 10.55.110.193 with SMTP id j184mr2732763qkc.70.1516382753519;
        Fri, 19 Jan 2018 09:25:53 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id n24sm6859420qta.26.2018.01.19.09.25.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Jan 2018 09:25:52 -0800 (PST)
Date:   Fri, 19 Jan 2018 12:25:49 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
Message-ID: <20180119172549.GK1427@zaya.teonanacatl.net>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net>
 <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net>
 <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119074001.GA55929@flurp.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> Nice detective work. This particular manifestation is caught by the
> following test which fails without brian's patch on MacOS (and
> presumably Windows) and succeeds with it. On Linux and BSD, it will of
> course succeed always, so I'm not sure how much practical value it
> has.

The CASE_INSENSITIVE_FS prereq could be used to avoid
running the test on systems where it won't provide much
value, couldn't it?

> --- >8 ---
> hex2oct() {
> 	perl -ne 'printf "\\%03o", hex for /../g'
> }
> 
> test_expect_success 'clone on case-insensitive fs' '
> 	o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
> 	t=$(printf "100644 X\0${o}100644 x\0${o}" |
> 		   git hash-object -w -t tree --stdin) &&
> 	c=$(git commit-tree -m bogus $t) &&
> 	git update-ref refs/heads/bogus $c &&
> 	git clone -b bogus . bogus
> '
> --- >8 ---
> 
> (hex2oct lifted from t1007/t1450)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Money frees you from doing things you dislike. Since I dislike doing
nearly everything, money is handy.
    -- Groucho Marx

