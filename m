Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25BFD1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 15:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753640AbdDCPQV (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 11:16:21 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34728 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753617AbdDCPQT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 11:16:19 -0400
Received: by mail-lf0-f51.google.com with SMTP id z15so76759376lfd.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=eKqZzHKxhGxuJPxYsCiq+EdY215eSn86VvU+fpM1jwU=;
        b=tzuP6L/vrY12UmxMS+Wm6ljGp2xgkkP8lFsayOAmYX6vGTgAQ8c16HcEXNyQ69c2P0
         tGL8RaiBsZb80snIccsktE7+JTHhIldGKm/evZBhOVeW266hUxWU6S0heKZRaXo6HAu0
         A1NtEYGarTun1zke3iDT1OjPsdYAAetdI556y58jD7CEXAyuartQZjCELBSrREs+LQyU
         MBjtaFe9OP1GDPu8yoj1yqp1Y2z847+hY87QjMbcYKtmg7kNV9mSRnn1TjauPvpP5W+9
         x8BpoEUtU5qMEmj9juaoAmC9yHSErnJgGKKmdZbIMT1xqvBlwKasMP9Pi5P+F/LOiDdA
         vYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=eKqZzHKxhGxuJPxYsCiq+EdY215eSn86VvU+fpM1jwU=;
        b=cAfRVCmKklhOBx9clHeFwor4w5gjqjtx1M6m823nrJGnenZJoc7OkBumESGGv9Hoxg
         bnL9e+rkbADWuO8z9DS6wYyl93K/pxVWL9wr9thzfEmjnmqHbJlgv29qRoXNV6xgysKK
         vdd6+QBPZMcxAayWKcSBt8zmmzb/wzCO2zj/7mbS9JHc4Sg5wMdQTz9gNTMGkxKCVEEa
         MCIaBBjQUh4podPT5nnKJahcVamIX1RAtsxFg2iGsG5RmKq4e68tTlDbQokn8mhKtPE4
         KJ/fvbX0wSOnbkuKbfg0Lf9giNrLiwCVzXbP8lkB//Kk2dNyVtqFud/6Gh6s0YT00aE0
         dsjA==
X-Gm-Message-State: AFeK/H2kT1EZeUNQpZnRjYYyaYcRxWqAYOtibjmFCFIbH1NooEYm/APSWHeq5jyCi+KEEg==
X-Received: by 10.25.199.65 with SMTP id x62mr5608060lff.122.1491232578315;
        Mon, 03 Apr 2017 08:16:18 -0700 (PDT)
Received: from [192.168.1.26] (dat136.neoplus.adsl.tpnet.pl. [83.23.19.136])
        by smtp.googlemail.com with ESMTPSA id o13sm2594436lfe.42.2017.04.03.08.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 08:16:17 -0700 (PDT)
Subject: Re: Terrible bad performance for it blame --date=iso -C
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
References: <58E1F239020000A100025732@gwsmtp1.uni-regensburg.de>
 <20170403105641.16912-1-szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0ccc5cab-26b7-4b02-b964-452b61e92579@gmail.com>
Date:   Mon, 3 Apr 2017 17:16:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170403105641.16912-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.04.2017 o 12:56, SZEDER Gábor pisze:
> Ulrich Windl wrote:

>> In the other case (for the user bored of waiting seeking for some
>> entertainment ;-)) a "-v (verbose) option could be useful.  Or at the
>> very least: If git is expecting that some operation will take (or
>> already did take) a lot of time, give some message explaining why it
>> is taking a lot of time, and maybe how to avoid that.
> 
> It already does so by default since v2.8.0, see aba37f495 (blame: add
> support for --[no-]progress option, 2015-12-12).
> 
>   $ time git blame sha1_file.c |wc -l
>   4026
>   
>   real    0m1.744s
>   user    0m1.672s
>   sys     0m0.068s
>   $ time git blame -C -C sha1_file.c |wc -l
>   Blaming lines: 100% (4026/4026), done.
>   4026
>   
>   real    0m3.832s
>   user    0m3.716s
>   sys     0m0.112s
> 
> However, after a short peek at that commit, it only displays progress
> by default when stderr is a terminal, which might not be the case when
> invoked from emacs.

Emacs (magit?) should use `git blame --porcelain`, and do its own
progress report, just like 'git gui blame' and incremental blame mode
of gitweb.

Actually... there already is git-blamed - Minor mode for incremental
blame for Git, and mo-git-blame - An interactive, iterative 'git blame'
mode for Emacs, both available on ELPA (Emacs Lisp Package Archive).

HTH
-- 
Jakub Narębski

