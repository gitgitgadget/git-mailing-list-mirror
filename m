Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS,T_DKIMWL_WL_MED shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DAB200B9
	for <e@80x24.org>; Mon,  7 May 2018 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeEGXkZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 19:40:25 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:39061 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbeEGXkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 19:40:24 -0400
Received: by mail-pf0-f179.google.com with SMTP id a22so8936101pfn.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aCX8DBp9RRQUC/A5UH+0huVMskyePOp6QvxXtbbkwZE=;
        b=Nxwqzv4LwdTFx//nptjpaj0x2H3ZRkWBkX+sAqUtqYdgjTdCqWSDMPgAPaP3ybAh63
         oN/uA0rEFYocmct7NEXyKTY3ZY7uxOuWxFK26mB0pSZzEBbgL+6Y7s/0aCMFyC//RAW0
         bFEOUrfF9N8AFLpDxl+dtdCUleXgrLyYczownrKrYs+ZyYh3lT1YExRv8+EeT9YDJLip
         rv2/756Dv85uIVQSgxRKY3vhsSErjSQkr5jk+IpBMlJfVSRt7VefGQ4ibSCsWEv9K/XQ
         UHbAQ05Lc3e7FSoG+Qya5nd2uOP1hzCIWjjF9uJMD3/D6Af0yPryn9nYVJ1oyRTkF5MS
         ZCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aCX8DBp9RRQUC/A5UH+0huVMskyePOp6QvxXtbbkwZE=;
        b=Mc1V0n7B2au3M4xMqYcuH8KG04qXQI0BG+T1eDXyHSQsN+IHpq/pIWes1d4P/Lxlto
         M59XrBMfOfqXNHJoCeu+opB0W4Jehp5/+Fb/tvwQXJZ7Nuhwy8jCWv/qG2mDibtfx/WZ
         54/3fOwqt9dg01RMGgkHqYk78IkIGxuoMF/rkLJRTSG22YjkUwZFceHUpSJ2XG68sfMU
         3zFYCMpAv15SzLDR74sDPnqdn/M56pROOBRQy8hXyjnyu0EUtfmYA7gpy8+lKsqJwAu/
         QHS32kzoC6dPLF5LBxwCD3S+73xk2zo5j9CBtFvhc6ju0i/MVmiRmFz0/DvqSNsKju1k
         Cr/w==
X-Gm-Message-State: ALQs6tD+aUGLlXS5A0g11esAe+Fu5F6Dle1ht58wkOp+jMLRS7A2YDOP
        ciRZMSpLJB9b4rJl8zbBrfIb9w==
X-Google-Smtp-Source: AB8JxZp08QxBhnJmctiT+dCnm9Tx7InA3NWMASZ6e6ApNDwlmYNIr3v2e9TEMyMAyb+IklUanyAAKg==
X-Received: by 10.98.159.202 with SMTP id v71mr37786350pfk.233.1525736424119;
        Mon, 07 May 2018 16:40:24 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e0dd:ed95:919f:45e6])
        by smtp.gmail.com with ESMTPSA id u68sm7156588pfu.32.2018.05.07.16.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 16:40:23 -0700 (PDT)
Date:   Mon, 7 May 2018 16:40:22 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180507234022.GC77370@syl.local>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
 <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
 <87efioy8f9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efioy8f9.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 06, 2018 at 07:56:42PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Sat, May 05 2018, Taylor Blau wrote:
>
>
> > +	test_expect_success "grep -w $L (with --{line,column}-number)" '
>
> It's now --column in v4 but this still refers to v3 --column-number.

Thanks, I certainly missed this one.


Thanks,
Taylor
