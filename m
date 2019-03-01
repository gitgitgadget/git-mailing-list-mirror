Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F4420248
	for <e@80x24.org>; Fri,  1 Mar 2019 02:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfCACyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 21:54:15 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35085 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfCACyP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 21:54:15 -0500
Received: by mail-wr1-f42.google.com with SMTP id t18so24218094wrx.2
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 18:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=6+oO+2YCtb7F/BhpEMDPxvq8fq6L0A59EQjVMfmHTzA=;
        b=qakOwSYBTdaZd7G5XJZj0qTN3PSmtOg/Tqz/q/apupE+tIoUGIrdzsdBywYhc4/Uon
         /8YoJT1XKOFvrMhw2DIqLaCUzvXubE/1xfuYMjFW1jePelbt8JyHfAOKub2Zmhrln36Q
         un6w4hSKgu3jEVZlaKVLhummLHExAeVPUGjVQvNoxzGzxc9sm2J+j7oHqujWlmffLz/a
         x4BtBn1y0fR/AVFMaJBzAxtVcGNa3/QX0V8BjFUe+JZ/MxSbhPnXoxuowRu0AMviuLCF
         10+65jb3bAaLJY9bnFOdKfqdse2P1H/V2WtE4pajQ0jxCRx/d+bHhM51ejjF0wqB1dQM
         hLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6+oO+2YCtb7F/BhpEMDPxvq8fq6L0A59EQjVMfmHTzA=;
        b=QDgCvFEEMOWH8C6BG8HA7BjINzYPRvmMSFLk8ihI7eRxsAvd94LhPXk2h90QkXmdkp
         IlBRFLGRXhRj2nSUF7Iu64icwFmqgO5QlQmeligWLrStYfKw6d5Uw895pJJ5XZ10Qre7
         s07wUVmnZMDg+vn/rZzgTAMCpMZJWIck+mRLsOpp7a5qNVWml000kCReVy/yMrf3i6XY
         IziRvm1PUzAYpAJZPnNVD9oTtUGE2s6itVr68ZiZo2GUvefjsDheWlO8lOQIa58aTMrb
         GCKuSyfmt78xTZBOiFv+Gmzwm3B96QsMmp0+OHIHewhCG+HGJ81DmXc7SdPWZEVQ1hfg
         2rSA==
X-Gm-Message-State: APjAAAWUhZwXOUSvdJs8fJqzon2E/JQ74I+/pCWooGh3L1EZ7zYIbzbM
        67ywqJZ9HY7Cl5ryj/CeM1A=
X-Google-Smtp-Source: APXvYqzniT7/6s6dVNDuunTGhruy84FxnMwWciRG3ISUXKsbuY6hhFVnwIXSyOj1eTjRAWkdeGSVfw==
X-Received: by 2002:adf:b3d1:: with SMTP id x17mr1681815wrd.15.1551408852727;
        Thu, 28 Feb 2019 18:54:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b18sm12141437wro.80.2019.02.28.18.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 18:54:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ag/sequencer-reduce-rewriting-todo, was Re: What's cooking in git.git (Feb 2019, #04; Sun, 24)
References: <xmqqmumlkq3r.fsf@gitster-ct.c.googlers.com>
        <2308479.hZ6iDFDOiv@andromeda>
Date:   Fri, 01 Mar 2019 11:54:11 +0900
Message-ID: <xmqqimx38fu4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>>  Was still being worked on, but seems to have stalled.
>>  cf. <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>
>>  cf. <97f77aca-bd19-f763-349a-de40c4b94161@talktalk.net>
>
> I’m still working on this.  I sent a v7 shortly after the release of v2.21.0-
> rc0, and I almost finished the v8.

Thanks for an update.  Perhaps then I should wait for v8 and instead
spend our cycles on other topics until then.

Thanks.

[jch: I am still mostly offline til the next week, but I had a
chance to sit in front of my mailbox long enough, so...]
