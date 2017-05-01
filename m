Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB5B1F829
	for <e@80x24.org>; Mon,  1 May 2017 01:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947310AbdEABbV (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:31:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35533 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425875AbdEABbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:31:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id c2so3735648pga.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tPaQrBPAAXQ9z1TZd3JpbUQtXgL5fcgV3X45eq0GVts=;
        b=FwA0hXcVzaO601CZd1jf7xYI4aD2/WFs3nDR0qOKwOZUN23oPvjfVDusILrzrvDmlS
         WsGI2HLJG7Bie996uM22wDeS7FsdYkYtgC/IZDnb04uElUdNHtOfc73TMBVlgl3RfJLv
         NG8/4kzdNBrPVFQXMiPemnU0gqSjc6dvGdlHVgSIIexekGC29lBr1cRFU1Cpqk3zFUHd
         FcchV1lOv9w+NPz+fpwx2ZPvB2WkQt8z0jGTM8efNupCGVE/A5/0F/JgodbhP9xn3qsS
         DZB/7+B9Q6mjopzxBEWXB3QgAEPsG8LGhebS/x2Bn8OUSQ08fWiUtCv2Sumztex69sgA
         HNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tPaQrBPAAXQ9z1TZd3JpbUQtXgL5fcgV3X45eq0GVts=;
        b=Kb//qKQGdvHDhuE0F85vAkMpLMIuXlYMD2ZhQ3BCtvzKor8ZhZNJMePh2XZ+OonxP0
         2bHnXffeqHvdGuLKSRew4YiWff+qX2BzOZLMuPgPEEZ75/ZETRjgBYltKYIZODPvpbN+
         dKXxRf8i3Bdy5tdfbAffRguPzJ8uLWaQhwXdtEn3pmCaPM+vufKv31qDyMpbmRf11T3Q
         +EVzQWIWNhvkwx/YE09XdhFsBsmGibuU4ZQdE2ZsT2ksyFnbXagONyUPdX1A8v1VtFlq
         h+rPMw0mlujDa81LViJrTuiwRrvCS6cF5gTozdT/37ve0FbRtHF9+WCurtNDIa91NTLy
         +zIg==
X-Gm-Message-State: AN3rC/4k4mWRWGPvMyUiTPNaXo0/QhoN6qNl2xXao5+WxxDMG9PelrbK
        BEHcfBg9Azp/zw==
X-Received: by 10.84.232.205 with SMTP id x13mr615090plm.7.1493602279442;
        Sun, 30 Apr 2017 18:31:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id t2sm19878730pfl.34.2017.04.30.18.31.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:31:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/5] clone: --no-tags option
References: <20170426231236.27219-1-avarab@gmail.com>
        <CACBZZX7bHai-CTiO1G1vOP41Uit3zeMAn64NKvA73aouoBWMng@mail.gmail.com>
Date:   Sun, 30 Apr 2017 18:31:18 -0700
In-Reply-To: <CACBZZX7bHai-CTiO1G1vOP41Uit3zeMAn64NKvA73aouoBWMng@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 28 Apr
 2017 21:11:20
        +0200")
Message-ID: <xmqqa86xjrbt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Junio, can you please just take patch 1-3 in this series, i.e.:

Given that the old one has been already sitting in 'next' since
April 23rd, I'd have to revert it and requeue them anew.  Which is
possible but cumbersome,...

Let me take a look at these three patches and then decide what to
do.  Thanks.
