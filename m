Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,SUBJ_BUY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364ADC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BD9613AA
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhFEWdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:33:16 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:37539 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEWdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:33:16 -0400
Received: by mail-qk1-f179.google.com with SMTP id i67so13102616qkc.4
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ampliffy-com.20150623.gappssmtp.com; s=20150623;
        h=date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jykGrU5P8idetVgKdzwIrjt7HfIbGzNbdFxsgbxNnx8=;
        b=tvPZbR++Vy4TOAXgF7J4V+uxgTrQIkf4nGzcTCfwgAbMF8JAcxswsaO9oeqkkAZv/N
         JuOrGTnK8q62HXf7kBaT/FYInbeyIXa0/RyQ/gymYUD+5RIAYjEhD/iUKH3Pfb56i9Fo
         EgYI4uxgSv8cULrhDPb3NOKgLTshpw6t+yrMdhSlKIt8wSOZeLHB7XgS1G+rQgQ4a1hX
         fODsP3hqPTZRDQ87QZvNe1/Tc+cY+jguvaQmIGdSEN++zV9uSqAWTPSEnCYYm06LHirK
         Acl90mBMMp8sx/3Qghq6eyxa9+vatOny+ITImD13X13v4Rsi2sEWjvkfha7Hg4tz57v7
         91xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:to:from:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jykGrU5P8idetVgKdzwIrjt7HfIbGzNbdFxsgbxNnx8=;
        b=liSSieNTv9Y2ZG8aJ6bcwGC2TOGbgNzVozsK/Uyok3XV3WA0fydMZ4hqLMJpfzSQZK
         +Juwh6LoO9zKAUVkn5wlfXq9TOOpbpogsxHq4dTm2cr247+G1qpProy34nUXesbVYRsz
         Q+o1barJtMdU2RZLs1mSo+0eLyl0hbQRsT0VhumRd12CHbGft0qlEpTrh4HouLNGXPMy
         /266+BcCFyttp6FAqdk1sLTfiiJthAZOc4fmmanqB50Ez/QwbFOs3ACyJUJU2tZ/ts3h
         nuP7wBhjVx5IFNbk0sx/+rgkUP/l8OKZGVgUIXXWRaHw/8yM2ZCfCVNHQjWJ6HAQ7KwB
         Tv2A==
X-Gm-Message-State: AOAM532YSnC4ZUVIOZGpFCGTSaHJaPN0GRYjacVoaD1xSjuafzmQvD17
        vPT0ts4MjKlBUFS+CKqnCEyPvW0FA3r4gw==
X-Google-Smtp-Source: ABdhPJx+iOxfhqm3JY1HPhe+hr8nfW5skDBRv1sYTDEd3vcwENgBYf1PWs0P9L41buDkmEFHl6Dw3A==
X-Received: by 2002:a37:5847:: with SMTP id m68mr10292384qkb.111.1622932214717;
        Sat, 05 Jun 2021 15:30:14 -0700 (PDT)
Received: from intranet.smilethink.com (ec2-18-207-154-26.compute-1.amazonaws.com. [18.207.154.26])
        by smtp.gmail.com with ESMTPSA id o22sm6038839qtq.89.2021.06.05.15.30.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 15:30:14 -0700 (PDT)
Date:   Sun, 6 Jun 2021 00:29:47 +0200
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Diana_Gonz=C3=A1lez_-_Ampliffy=2Ecom?= 
        <diana@ampliffy.com>
Subject: Buy In-Stream preroll video
Message-ID: <955807b31c32217117d53affd7e49222@intranet.smilethink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello ,

How are you? I hope that very good!

I would be interested in buying preroll video advertising on your site.

Who should I talk to to explain how we work and explore a possible agreement?

Thank you very much for your help,

Diana González
Media Buyer
----------------------------------
Ampliffy
Access to a Young Audience
Barcelona - Madrid - San Francisco
----------------------------------
Email: diana@ampliffy.com
Mobile: +34.611.693.613
Skype: Dianagon90
Site: http://www.ampliffy.com
-----------------------------------

