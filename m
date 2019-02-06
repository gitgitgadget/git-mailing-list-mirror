Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640F91F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfBFRuC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:50:02 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:55638 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfBFRuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:50:01 -0500
Received: by mail-wm1-f49.google.com with SMTP id y139so3381656wmc.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pR3nK+SuLbBe9qLJzLKQRYJzq8j5qrzfutvyPyux2Zg=;
        b=lIOCDRGLNihjmcjk5y6UT6nZUJPeoLaKAGLiwPk7CiQQch8TEAS4JagAfENBBgU7GY
         fKyADFtLsOb5And934CaGpyub/wBHE2GnGm5MhUalcm60JdFJ0fEx9rR3x/fgAIf3u00
         u9h58/HYQCe+rDH3IYOPM1Iaza079XzUdeJVKnOe1SR04DynnAMXPtNWxbSgsT3OeAEu
         HRF4ASssMUsCtuIU71p7GS3m26ildf3MnQ3E1b5AStp3gcm0t5kWZIQ+WSkaGOeoPd+O
         Q8Z7yanz1wLxvHbFeOfik8Qnx1m+qDzOUdwx0XniPiuwORmm5BEiSTLYvUVKQ9uh9erV
         Q3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pR3nK+SuLbBe9qLJzLKQRYJzq8j5qrzfutvyPyux2Zg=;
        b=lWnivBgWQrxjmF3xzblUhljZsnQk4bgt3pOulWGF6T5wKtP4LqGCXToyx9hANzX1n+
         xKDL0b1EyEP1DqCnrQWD45gPShsvZtS6kPmNm5CPJbTqTYk80iVcET1X7YV6guD2wFS9
         v0ssqtinStqL+8n3OpqQdMUVxcS2c92O6r7uTD1v/atPUqyhfka+Vz8PN1tp2AxuFIHm
         biETPnmMQ/i80yoitjmxX6FtMUxmhObIEwlQqs/45o7PNXb8QQq5hczjMDVeXLpbf9lp
         yXykB1uD9PI+QAeAcQ4LrbgGplDXQLIHYQOXHEyO6jyMrq4n7v7beRG0G/qRqBcNijPH
         5QaA==
X-Gm-Message-State: AHQUAuYn18x09VXz68zaImIqP4S11L1wjXh8l4jmQvaU8KHGMqpkIa2f
        dnFxBCRFHJR5DNOxGziGDd0=
X-Google-Smtp-Source: AHgI3IbrXXN3vNZNYtpJPtEDXY+MvPuUXfhxlqFAtUESuZTnJhd2toUPA7uNFnC5SdZSi68OAG9Qpg==
X-Received: by 2002:a1c:760c:: with SMTP id r12mr3778488wmc.127.1549475399728;
        Wed, 06 Feb 2019 09:49:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h16sm46622263wrb.62.2019.02.06.09.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 09:49:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #01; Tue, 5)
References: <xmqq1s4lst7m.fsf@gitster-ct.c.googlers.com>
        <b24bfabf-3f79-a290-50b7-5246d870ae12@jeffhostetler.com>
Date:   Wed, 06 Feb 2019 09:49:58 -0800
In-Reply-To: <b24bfabf-3f79-a290-50b7-5246d870ae12@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 6 Feb 2019 12:18:35 -0500")
Message-ID: <xmqqk1icrem1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/5/2019 6:37 PM, Junio C Hamano wrote:
>> * jh/trace2 (2019-02-01) 15 commits
>>   - trace2: add for_each macros to clang-format
>>   - trace2: t/helper/test-trace2, t0210.sh, t0211.sh, t0212.sh
>>   - trace2:data: add subverb for rebase
>>   - trace2:data: add subverb to reset command
>>   - trace2:data: add subverb to checkout command
>>   - trace2:data: pack-objects: add trace2 regions
>>   - trace2:data: add trace2 instrumentation to index read/write
>>   - trace2:data: add trace2 hook classification
>>   - trace2:data: add trace2 transport child classification
>>   - trace2:data: add trace2 sub-process classification
>>   - trace2:data: add editor/pager child classification
>>   - trace2:data: add trace2 regions to wt-status
>>   - trace2: collect Windows-specific process information
>>   - trace2: create new combined trace facility
>>   - trace2: Documentation/technical/api-trace2.txt
>>
>>   A more structured way to obtain execution trace has been added.
>>
>>   Still needs some fix-ups.
>>   cf. <d91d1d89-5759-2006-7b38-4211db5988af@jeffhostetler.com>
>
> I just pushed a V6 of this series that addresses the hdr-check warning
> in trace2/tr2_tls.h.

Thanks.
