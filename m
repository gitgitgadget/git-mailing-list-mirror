Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB1720248
	for <e@80x24.org>; Mon,  8 Apr 2019 14:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDHORx (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 10:17:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHORw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 10:17:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so16659459wrp.0
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JSqe7sjV4xjZkas2suJpDE+l8gZ88g7E6zso62/KgDc=;
        b=JrB1DCszgNW22LxqCR176WF06dTk2ywBXASxXRjZofv/HcHg5/xM20hNtbRQN+pK88
         QGVC6jZluQGkyZU+O/UojUVj3c6pe/SeP2NgGzSpAfY/dg4gwg7YxeeNSy03L19ylDan
         /8WYEcE1nI3F5OAdRyEc3pc6UstnQBEuEL906JWQEMpmY/ZXpg4yytUcGH2dtYNf5ZLi
         hi9jXdNuRKfZffU+N3Ph+4r2q5ocuwiHUYrEZdVq9VsJljZmVKLuDOuncjc3cVrXdJWZ
         tL62CaqzzBiT4QedB6ha2M+46qYnGVaKNcnEmUfmFpNu8JYhaC2jQg3x4JyTjI9GnACM
         l0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JSqe7sjV4xjZkas2suJpDE+l8gZ88g7E6zso62/KgDc=;
        b=jlwck/CiLo0EERlyNCcVJRZ5ppmWjZpSBYBke0YnR1gGPu8G/NTNfTyid7JlDdqkuL
         kqC6l2xa4JgDO85Wz50i8Q0MbujK9Y7AxHdz55t6wk+EtyxDNKP8jjAtdfg3Ic63Rtp+
         lVl/771K/0Au5YBkwZ2q/nX4jF4EYpZhK/TL3Zk2qZ5ae8EwBcs0qH/sEz+ofRmNewwq
         TUluAu/mySdvHP4zzbEKfe19GBoohj304CNre0eCWNt618YXeRtsSkt6ONAoWnBzI4OB
         aqwEoZ6g6XTNh9nafyR0Jn1KBHVO/mdlsRX2t63d3+sXuOjJscOq63gkeq1JCIsOTtxu
         fkmw==
X-Gm-Message-State: APjAAAXgT9CHOzKRMgn3be9TqKXWN2n8qRFC1NKpK9i01BlErmh1AvtS
        cSfJtlDpnrC5yYsUdii/AoY=
X-Google-Smtp-Source: APXvYqwwlfEsC0cOfSYaUwdxx32p9T6dWwi+nlFZPz7ZsvgD2dMdS2p2xDlKxL0T8tIquI5CBBJOVw==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr19086720wru.227.1554733070665;
        Mon, 08 Apr 2019 07:17:50 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-29-11.as13285.net. [92.22.29.11])
        by smtp.gmail.com with ESMTPSA id r6sm26119507wrt.38.2019.04.08.07.17.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:17:50 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] fix cherry-pick/revert status after commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
 <20190329163009.493-3-phillip.wood123@gmail.com>
 <xmqqv9zyxgwk.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7f4fe847-8cef-efbf-7b9b-44b2df9fba36@gmail.com>
Date:   Mon, 8 Apr 2019 15:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqv9zyxgwk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/2019 09:34, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the user commits a conflict resolution using 'git commit' during a
>> sequence of picks then 'git status' missed the fact that a
>> cherry-pick/revert is still in progress.
> 
> How well would this play with the previous step?  Didn't the change
> to builtin/commit.c made in [1/2] mean that after 'git commit' that
> concludes the last step, there is nothing 'git status' to notice?

You're right about the final pick in a sequence but the idea here is 
that if the user runs 'git commit' in the middle of a sequence of 
cherry-picks then we want 'git status' to report that a cherry-pick is 
in progress.

Best Wishes

Phillip
