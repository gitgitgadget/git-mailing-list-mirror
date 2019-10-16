Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902601F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 19:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394570AbfJPTtC (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 15:49:02 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:43590 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfJPTtC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 15:49:02 -0400
Received: by mail-pf1-f171.google.com with SMTP id a2so28793pfo.10
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJE5be1YwyD667xBWL+NYccUucV2mb6gkWtE2jynDbg=;
        b=nXb/AuWAbqaYgM91ky1FfMK/BKj8QQw6JUB3bdThx+/pS3tQyHXO0AHEW310n4EjRm
         PFnZp7gxgrbTpeBtRStQZSsEFZMFW0e5ESKphjc8xICnFiOO/HTLZTReDpHWwySOCXj+
         K7rvWQA/iPWPdQn0Ll3PCAaLwfASLghVROTC1CvGrI3n3KzpU859xyShGgWCc1yG0GqZ
         jbOscJX6pL709kaWOqnZGacLR0r0X2+tqnSfBTwgBIcDcKmxWoZwqUQIm6tJwesPKo+r
         PrTBxu9JBDtFXQpKS+kzIhJnrrSGM+YhqZwVjCGpAYhJ3wm762K2YcmdUqU2wWkRNNGV
         /npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJE5be1YwyD667xBWL+NYccUucV2mb6gkWtE2jynDbg=;
        b=odYUmQwlomPQUhDT8l6c1fDLzJRV/OBeyCUHPxCsCdZ1FJv11fe/P470ZTr4rFw4Uk
         FkFs2oLUTwDdsUOeEffPby3ZqIoMmre24nrE3Eu2YNAdWdhRhVT9gAv2VRp1W6Lv4NAI
         uBFR4/BiPdJpAX+uBGuWMJdcbQt+YMi+3Vz+rWM67kbtnBAXM/UAb11RH19Oy9ePzMjF
         VqU+YLIyZKYKlEP9XthOUz4/seTWTSxv9KA4fUoYMHXx3pPbI4u65ktN1VX9QEyqD0b5
         3c8DBXe5s6W3m4vbbyS1CD+WjJd6QV1HwHMllFNfimjuEtuf0gfr2FFVA7hacQRdRlqj
         vE+w==
X-Gm-Message-State: APjAAAUNZEKSMKrjQ5sHdBNYj2bvtaU0JhbM+5Sq+/hbooJjKd8JiGYx
        7uvpI5XR2kiGG2yU+eqVI4I=
X-Google-Smtp-Source: APXvYqyZa6chbzT5zMVs74QXKBIB3uNntyR5N40O9j/zvKi69JqjRJ5QZDtto53CmFuz6uXyCUvDxA==
X-Received: by 2002:a65:500c:: with SMTP id f12mr16912627pgo.233.1571255341577;
        Wed, 16 Oct 2019 12:49:01 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:9:5298:5407:5c62:baf2])
        by smtp.gmail.com with ESMTPSA id z21sm25335930pfa.119.2019.10.16.12.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 12:49:00 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <20191007172951.GC11529@szeder.dev>
 <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
 <20191009013231.GF29845@szeder.dev>
 <04342d12-fffc-afb6-fa4e-c2e2bf88d1b6@gmail.com>
 <xmqqh849a1b4.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <35cd8f8c-de66-819e-0a9f-c0905255721d@gmail.com>
Date:   Wed, 16 Oct 2019 12:48:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqh849a1b4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/19 7:09 PM, Junio C Hamano wrote:
>> At this time there are no other MIDX_* flags and so there's always the option
>> to revisit the best way to handle multiple MIDX_* flags if/when additional
>> flags are added.
> 
> I do not care too deeply either way, but if you wrote it in one way,
> how about completing the series without changing it in the middle,
> and leave the clean-ups to a follow-up series (if needed)?


That plan sounds good to me.  The most recent series (v3) should be ready
to go, I don't believe there is any outstanding feedback to address.

Thanks,
William
