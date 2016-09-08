Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57AC620705
	for <e@80x24.org>; Thu,  8 Sep 2016 13:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbcIHNM7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 09:12:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33085 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbcIHNM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 09:12:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id b187so3814089wme.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pPgHhMhTHqkz//Y2f4vpGDM+fe05hInY1tKSwmph9KA=;
        b=EsE7a10ulOnL94QNhE4eZLrIZ6/30kZXrbyeMOXAGJI+tcQuMXJALBEvECPKXzPUfI
         5sz+gucVl3JxpSDfDvCIT6PTiklcfSTbInj6JKae7H9AAuTm2OtoH0FkHHsHZN6RuP6G
         I8smOaXtgsCB5cVKINOrC3fEZDlQi1ftOpV64UTn/FEniuNvlo2T70E7qFYWRJzqZetu
         qI4WneDCoMATIDIvdzTCfg7YEJfmrqbGUxmiCM0VfvhY3SBg3pKqPIQMW+yiWrhqdQQK
         h7KPZUTCUzpot9M4cqJU0E7N6cJPH07s4CHMzo/uIe3gR75MjB/Ua6RQ+O/b+glcnss5
         rheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pPgHhMhTHqkz//Y2f4vpGDM+fe05hInY1tKSwmph9KA=;
        b=COjr8kvY71PUO1mplgh9eTjQP7m18auvoUb9sOSKs5Z544CA0SuFfcmj1jxNxK2A07
         upswTrGKAIKhi3dzY4fNybd+BnBQpjYq2ftfDtLhRzqH1gK1kvuiXB5QbaYfwRTmxfsY
         bs/bnT7oasVHYHDhZtP8OfRUbBmYA87pCUWPAQBNJfpHuqylPQzjhxyLR+xjGqJc5a4x
         T5+DOEv0zduw2WeAIdtjF+HXb+RbEEYPlUUt9YPqTrvmjR5uTmUAmTrwtCIhdcisQvmi
         wo3N8pGsja33H2eW871vmWoC+LzXa4KIP41oeY26DjXuF7LnXUN19e0IwH8PhIdbpJ+D
         SWIg==
X-Gm-Message-State: AE9vXwNzA/BFjDF3VZmn4kgoqWKbBF9C71Iz4E3MOVQRWSe5jhYOk+wHKiEwY0t4Woxu8Q==
X-Received: by 10.195.2.42 with SMTP id bl10mr46251205wjd.21.1473340375598;
        Thu, 08 Sep 2016 06:12:55 -0700 (PDT)
Received: from [192.168.1.26] (elw138.neoplus.adsl.tpnet.pl. [83.21.216.138])
        by smtp.googlemail.com with ESMTPSA id bc5sm37605706wjb.37.2016.09.08.06.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 06:12:54 -0700 (PDT)
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     john smith <wempwer@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
 <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e17a88cd-2de7-dc84-2262-743e82d8b047@gmail.com>
Date:   Thu, 8 Sep 2016 15:12:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 06.09.2016 o 23:01, john smith pisze:

> I'd prefer smudge/clean filters instead of `make' scripts etc. to
> convert template dotfiles into something usable and back because
> filters:
> 
> 1. could be run automatically
> 
> 2. do not modify files as shown by `git show HEAD:<file>' and
> therefore no files are reported as modified by git status and also
> there are not conflicts when merging master into work/home branch.
> 
> I have problems because with point 1 because apparently smudge filter
> is not run automatically every time when branch is changed if files
> listed in .gitattributes do not change. As the last resort I could
> force smudge/clean filter to run just to keep advantage specified in
> point 2.

Couldn't you use post-checkout hook plus clean filter instead of
clean/smudge filter pair, if the smudge part depends on the branch?

Or make post-checkout hook invoke smudge filter... though
`git cat-file --filters` is not in any released version, I think...

Best,
-- 
Jakub Narębski

