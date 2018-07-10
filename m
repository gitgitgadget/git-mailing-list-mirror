Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751141F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeGJK3p (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 06:29:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39461 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeGJK3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 06:29:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id w14-v6so16196613eds.6
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Apby3vdMiThgGBGAbeH/ED1AfEpW63n734Q38xLUd4=;
        b=WIICTU/i65rpNJdSvMrY/TAMFmi7T+IFqVGr7RrosiFr4u33eQj4y18+xH4M4oRrVb
         ZZFZrZkPBCqNqMkBGpenxHJ/WVqnhKujxA8/w/sD8xOlnwJYpSgGi/BoC2Xe3FKewgOF
         77RwPin0ktKF133q7NZpPaoB3fHPUPiRmi3FBxY/1GHBoiMuRoe7xUap7dFtxQao0Bk5
         JgUa8Q/UEM35asF5ctRpUg1Ra6ma5RHYNKdmQC3Yw42QFDneQ/TVwGjBF2OR2umylQih
         CuJzid/+Uaq2LdV1e9yHROlRWYy2u7WQNMnyw2k9rrCDx7hn75/lCW7SzyCDlEmt7UCJ
         jhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Apby3vdMiThgGBGAbeH/ED1AfEpW63n734Q38xLUd4=;
        b=Cg4m/TaLqo4KR+RI9KXI9a+yMawnpk/MgHpMrb+MasLp1QAntGlZ7VEuL9Q7MMLIoo
         Mbqt4N6SipHHaH0sVD6NQP4MkEirS/A8gSRGE47FtpEEN05bz8CxJ5Xc15eXXQ+S49EI
         iUe8uA6UNsk9c0h5ZVoUJHCBTUo/6VfMWcRC15ehIxXlyNmzIgnXY0XtSHjkUgKn4S0O
         qMryg9Wcj29HEx2rKKEwHFYT7ZXtEgDSlW3LX+z4oDNzCn8YZRZTZK/BPu6eJLCMHGe2
         zTrHtw9dt9sxr/Glw2xaE5y8fZVMENlDjo7WQbjQDV2VEBp2QbMs0C7V4Y18oWYCqIAI
         /Llw==
X-Gm-Message-State: APt69E1/pFr3oVszH8nDScr6XTs++pHSGUd0QlouYR+XkdzfdzUZoSFg
        /jStTNbFE2vliyXhTBvA7HM=
X-Google-Smtp-Source: AAOMgpc7jvov+yy1Ft/N3vldfxJXHiRrlQ788cnpWd8liLyrcdtMjuADlkAtQOKgrXYJk26FnVng9w==
X-Received: by 2002:a50:a446:: with SMTP id v6-v6mr25353462edb.237.1531218583289;
        Tue, 10 Jul 2018 03:29:43 -0700 (PDT)
Received: from localhost.localdomain (x4db10d5d.dyn.telefonica.de. [77.177.13.93])
        by smtp.gmail.com with ESMTPSA id d11-v6sm7240933edr.24.2018.07.10.03.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 03:29:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ref-filter: merge get_obj and get_object
Date:   Tue, 10 Jul 2018 12:29:37 +0200
Message-Id: <20180710102937.12499-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <nycvar.QRO.7.76.6.1807101115570.75@tvgsbejvaqbjf.bet>
References: <010201647e19c0f0-68cd728f-c86a-4be2-be6b-fd7e19e930fa-000000@eu-west-1.amazonses.com> <010201647e19c24c-fd353913-225a-4153-aa0f-6ddf41ae6354-000000@eu-west-1.amazonses.com> <nycvar.QRO.7.76.6.1807101115570.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> This causes GCC to complain thusly:
> 
> 
> ```
> 2018-07-10T04:59:38.6368270Z ref-filter.c:1477:6: error: variable 'eaten' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
> 2018-07-10T04:59:38.6468620Z         if (oi->info.contentp) {
> 2018-07-10T04:59:38.6568710Z             ^~~~~~~~~~~~~~~~~
> 2018-07-10T04:59:38.6669970Z ref-filter.c:1489:7: note: uninitialized use occurs here
> 2018-07-10T04:59:38.6774240Z         if (!eaten)
> 2018-07-10T04:59:38.6874860Z              ^~~~~
> 2018-07-10T04:59:38.6976740Z ref-filter.c:1477:2: note: remove the 'if' if its condition is always true
> 2018-07-10T04:59:38.7072330Z         if (oi->info.contentp) {
> 2018-07-10T04:59:38.7172760Z         ^~~~~~~~~~~~~~~~~~~~~~~
> 2018-07-10T04:59:38.7274040Z ref-filter.c:1466:11: note: initialize the variable 'eaten' to silence this warning
> 2018-07-10T04:59:38.7374670Z         int eaten;
> 2018-07-10T04:59:38.7474870Z                  ^
> 2018-07-10T04:59:38.7575690Z                   = 0
> ```
> 
> (See
> https://mseng.visualstudio.com/VSOnline/_build/results?buildId=6640204&view=logs
> for details)
> 
> I think that GCC is correct, and at the same time, it isn't. Because it
> does not matter whether `eaten` is uninitialized here: 

It's undefined behaviour; 'eaten' is int, and an int may have padding
bits and trap representations.

> if it is, then
> `buf` is NULL, and the `free(buf);` call does nothing in particular.

