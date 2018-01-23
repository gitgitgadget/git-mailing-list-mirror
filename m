Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520761F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeAWAKr (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:10:47 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37869 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbeAWAKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:10:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id v71so20233441wmv.2
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Xhs/9GDfAi/keAWw5XftBzczbOcCP2SqrNWmMAnbCus=;
        b=QWKhtvXPJdWcvKWHloPfBAJHD2kwcTwNB52oGH2xvF2VUXu8TQg4s2+Ols4CLnImgb
         CaLXlOMiU7/q0vWoMSo4tOigTHZLwA9hEvB9ob6ZIRpM8kQBISSJ/Y1WLewy8kOm2g4d
         hsYhZ363/EyEJJvJ89+c2NYQs/kgomLeNC52UUdjeImQKHQ9EWNxn4/W2KzgX9wzeOba
         bQFcoVYo8RZG2ouEJCOTsZynKBPqCGODprtZwLQH0Th4Rh7IkeAq9L2L2wOo1yRT4RkX
         or7btJlaLp9B0CDgyis6egdqlFPcwuM+gCp5/di8yRzUILlsCCctNr8K/9wxduVn6hbo
         814g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Xhs/9GDfAi/keAWw5XftBzczbOcCP2SqrNWmMAnbCus=;
        b=EcEIOo9zNH3WvU/FmEudusoTRIZySnPLS1O82qnbsm+KgrPRfMNeQbV5mdXojpzte6
         ALnOCEErfe9e3RHrroPEH5VJi2Eifgi66fE/1/wBEw1zsK4REUfvzCbeCFBE7MN/kmKC
         rju8NLi88WRv8QyDy4F9TYDfG5L3Xqa/tDQ76jOAWsI8iRBg1aYLuO2PHt5bPwI6bUJD
         4zRe8hwA0huIVeoURNdH49kVP53Hj68CbZRK9Szq74f2/WForLAFVL9E8Hsi+SzjFp44
         fwBLbdJTUN6lRFtWvd6fA2V4g6jE/Fzg41o0GoVxnteOfnQ1yOP3r2lTZFNP7vNxafc4
         cNYg==
X-Gm-Message-State: AKwxytfeQo5ZnjF9ZedcPaAB64YlO2xT5khEEn+906Ghtu6EXjKua8sD
        5w6RWKKzVGvf1FOqS51xKlc=
X-Google-Smtp-Source: AH8x226wf02Kqy6mkWGJDC0fuB47MZmoDOtQ1Q303Pn5d1e0zMezb9lw+/+eahLGfHamdlo6+NNC3g==
X-Received: by 10.80.172.47 with SMTP id v44mr15509514edc.130.1516666245699;
        Mon, 22 Jan 2018 16:10:45 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id q6sm11896946edb.85.2018.01.22.16.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 16:10:44 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] format-patch: set diffstat width to 70 instead of default 80
References: <20180122123154.8301-1-pclouds@gmail.com> <20180122235202.GA26357@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180122235202.GA26357@sigill.intra.peff.net>
Date:   Tue, 23 Jan 2018 01:10:43 +0100
Message-ID: <87po61h1to.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 22 2018, Jeff King jotted:

> On Mon, Jan 22, 2018 at 07:31:54PM +0700, Nguyễn Thái Ngọc Duy wrote:
>> +	opts.diffopt.stat_width = 70;
>>
>>  	diff_setup_done(&opts);
>
> I wondered how this should interact with any config, but I don't think
> you can actually configure the stat-width. You _can_ configure
> diff.statgraphwidth, though, which seems like a funny inconsistency.

Isn't the numeric argument to --stat (this works with/without this
patch):

    $ git format-patch -10 --stdout --stat=30 -- t|grep -m 5 ' | '
     ...submodule-update.sh | 1 +
     ...ule-update.sh | 14 ++++++
     ...-addresses.sh | 27 ---
     t/t9000/test.pl  | 67 ------
     ...send-email.sh | 19 ++++++
    $ git format-patch -10 --stdout --stat=90 -- t|grep -m 5 ' | '
     t/lib-submodule-update.sh | 1 +
     t/lib-submodule-update.sh | 14 ++++++++++++++
     t/t9000-addresses.sh | 27 -------------------------
     t/t9000/test.pl      | 67 --------------------------------------------------------------
     t/t9001-send-email.sh | 19 +++++++++++++++++++
