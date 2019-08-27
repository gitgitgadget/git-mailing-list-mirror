Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3881F1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 01:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfH0B2D (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 21:28:03 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43256 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0B2D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 21:28:03 -0400
Received: by mail-yw1-f66.google.com with SMTP id n205so7317509ywb.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lUkUiMW0aRY8/5hmaFnX45iG342DrM/SgR7q7mPfb+s=;
        b=KdokRKb77Ol1DowliI54iMTeEsNgy1PuRElKDtNeYliMIO2u6Ps31qDreF3WNPmj8u
         HvEbTJxYmaB7zZbYX06mz7tvXwRCDNv5JjGDKBfYfsSXNJuzj76CCPxGVNyQI3XPMDd5
         m8PEsMkqu6mWXtQ7IoB7ReDFdAe6SMAvQggdqONCmBejH97Qi+m/jQ0Xxd+qhP+Rxjyf
         e2BAdIRzbReqOQudtcxdJi1u+loAWFgrEOmds2ARLP4W3Nm2+Q4t8HcvQ8IFULADilRX
         ksWsJk215BsvomwEqJMCAwNzultvS/kyqa14bs9zUiOXEB+tmrn+QJK7E6VRSD3MYUG+
         Vvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lUkUiMW0aRY8/5hmaFnX45iG342DrM/SgR7q7mPfb+s=;
        b=FZNALtBgh3n0cOMDRZk3hykHBs+C1uUSsFhVRJXSaaddTcpLHK0+jCOGMxaDcthFs+
         5ABO7LxP+ZAPjSuGMGRtB1WZjIVzGVzYfIKJFKUyMJeY0poRSdGZs6SoFaAl8/pSRLtf
         tyWoR+WhszBGgfoazQVtgAK6sSf9NZiF5ibSDRUco9XQyGPDiOtrTc/IR7Rgy2SeLbTa
         3hdKnPdge37fvgSoF6PWxyblH9cZf2pd05XQ4KhyJGd+ELz1BBymnfMVXnQPHVZXmedh
         R1KKyafxxyGZLFTm5MQPfYp7ZzywORjBaTLoF61PZZZEsJeizWdMa6A8BsqopS9ikBMo
         KqBw==
X-Gm-Message-State: APjAAAV0t36arrKoGv7n8OLCfSXzt+JOjEf6GvvDkfHFxpXBK01b5eSJ
        B5IWZHHO/je7GpLIGPX0cts=
X-Google-Smtp-Source: APXvYqzsbE1tqweyzzL/d247IgHWkAUqmDBr7r+CIDWrni7KNHz2rHPSRuRmhe63Jloer8nPzBGptw==
X-Received: by 2002:a81:4c55:: with SMTP id z82mr15079734ywa.439.1566869282264;
        Mon, 26 Aug 2019 18:28:02 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l71sm3288458ywl.39.2019.08.26.18.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 18:28:01 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] git-sh-i18n: work with external scripts
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
 <20190826235226.15386-1-newren@gmail.com>
 <20190826235226.15386-4-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88ee0658-66c2-902b-276a-25ffcd08b954@gmail.com>
Date:   Mon, 26 Aug 2019 21:28:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826235226.15386-4-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2019 7:52 PM, Elijah Newren wrote:
> Scripts external to git could source $(git --exec-path)/git-sh-setup (as
> we document in Documentation/git-sh-setup.txt).  This will in turn
> source git-sh-i18n, which will setup some handy internationalization
> infrastructure.  However, git-sh-i18n hardcodes the TEXTDOMAIN, meaning
> that anyone using this infrastructure will only get translations that
> are shipped with git.  Allow the external scripts to specify their own
> translation domain but otherwise use our infrastructure for accessing
> translations.
> 
> My original plan was to have git-filter-branch be the first testcase
> using this feature, with a goal of minimizing the number of changes that
> needed to be made to it when I moved it out of git.git.  However, I
> realized after creating this patch that no strings in git-filter-branch
> are translated.  However, the generalization could be useful if we move
> other tools from git.git to an external location.

Hm. Maybe extract it from this series for the YAGNI principle?

A noble goal, but in my opinion I'd prefer to see this be exercised
by something immediately.

Thanks,
-Stolee
