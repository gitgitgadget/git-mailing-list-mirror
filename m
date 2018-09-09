Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC1BC1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 07:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeIIMQ7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 08:16:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45462 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeIIMQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 08:16:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so18646586wrb.12
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 00:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wAck+qS1y4DCRpdGTSagUOtSuoFnzJLtPBjfSRDkaTo=;
        b=NHwaJ2YsqpIcZWTyoRgWmZf7s4XwWLKUyOqGUGTic3pr0mYS3BMKLSEbI0g9xlRAwW
         T7QsuqQSzMXzka+4zGqQMXPcO7KuZ/S+ETtGVoThlAadHBWtqIBvcTqjQeHjU91Zqhnt
         MkVWfsyySnZHBJch6ywxyx48hkAjOyvgWMbBYzpz9WLbd+3Br0wDahpQ/dRvht7Cj3NC
         Flw00fbB2yZGvDaJsWRvh9ByFcNBKdvgKnWr3zmHasRRNOMm07NgDn77Okh1DCj3h7PK
         h1NpPBzHPErikmroDbBIkn2c/RSXe2EierVZhtOCMsZlIcbsTy/8K1tyYDnmx18BCTOu
         AEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wAck+qS1y4DCRpdGTSagUOtSuoFnzJLtPBjfSRDkaTo=;
        b=qU+hOxcwiZdYmahusFx6KfyGjt3z7cUuv8g0XV9rfCNeeznxa5ooow8PMbu5zgNvDR
         +7uQn26kJwxt0ydWgKVcGJ6wrQk6Hqv/AUlQI0CEOi9duqtO+RDWtdhp8TH8/5WrzJYi
         DB+mZEcoF6cgGq/7f3W7v2Zp5cUCiURwrs1Xv6S0qPnmIoO0b2gyVQ02XJQzEENfmNr8
         woUSNBBrLJQ7IH1UZ4aNKKQ528Qi+KJh9dA6jnxprg8xMU230ZLfOjdDorSmBEknEm8U
         on92WDKuzauJDMynIopDMF1cfOu8vE87AN302hbzUwaw0abu9k3ctOq9m+Zxwnq0kQYD
         Infw==
X-Gm-Message-State: APzg51DTeWEg2kHN/+rculxt/nG+IEEZ2Rg44JJP2n79duLlRtq7GW1H
        rigIYw1e0cfOE8NFFVzGEH4=
X-Google-Smtp-Source: ANB0VdbgvBv63PdvRq/myLP40E1g9IMWWE9j1wVQo4PjSlkewjbUvzA1lJhnxXFKICxn2c1+WnjiPQ==
X-Received: by 2002:adf:dd0e:: with SMTP id a14-v6mr10216538wrm.2.1536478094366;
        Sun, 09 Sep 2018 00:28:14 -0700 (PDT)
Received: from ?IPv6:2a02:8109:8a00:3914:b130:1645:fca0:b2e? ([2a02:8109:8a00:3914:b130:1645:fca0:b2e])
        by smtp.gmail.com with ESMTPSA id i125-v6sm16855690wmd.23.2018.09.09.00.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 00:28:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] t0051: test GIT_TRACE to a windows named pipe
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
References: <pull.35.git.gitgitgadget@gmail.com>
 <03453cb521ae57475d046024f5840991553410d6.1536344387.git.gitgitgadget@gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <3b6960e4-df19-a00e-c8f9-e456ecf43ef7@gmail.com>
Date:   Sun, 9 Sep 2018 09:28:06 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <03453cb521ae57475d046024f5840991553410d6.1536344387.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2018 8:19 PM, Jeff Hostetler via GitGitGadget wrote:

> +test_expect_success MINGW 'o_append write to named pipe' '

Shouldn't this be "test_expect_failure" here, and then be changed to 
"test_expect_success" by your second patch?


-- 
Sebastian Schuberth
