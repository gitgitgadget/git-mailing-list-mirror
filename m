Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA4420401
	for <e@80x24.org>; Thu, 15 Jun 2017 23:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdFOXYB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:24:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35880 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFOXX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:23:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so3212125pfd.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RW44A/qGSoM2RlsLTvnqvkROFAuxULalscZ9BFpH46c=;
        b=ii0eT/sqApHbpyyj9SKruheGMfIIOZrKnadMKEHmFHLCwVS19o/shIAAkB62z0c/E+
         itHfz86ftLWcKE53DYEH335Rq19LHO6vfqEp+c1QmS/MImgEi9+HrVeLjN+ZMNh4hsAW
         slColXFLbC/xEJtp9vO1M439McjC7+Y1vuMU1OuoDufQDoe/dPxQnsyi+Wydfak5V7uW
         yyREmFvzLiTRWGqo6FVnCo+cdtAI2iaFEgAwmqLjTvVkFp4pJIPfEwV/UNUKRnIKti+t
         XhvXvsx9EuxjBm9kW+4/P4NGgbp4UohwrMQBQHHYmBoxNxASL/nLpvKxiXUL5YnvWGfZ
         LsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RW44A/qGSoM2RlsLTvnqvkROFAuxULalscZ9BFpH46c=;
        b=YNkHdB4HsAxhiKgIdY25GJ/uhQdYVg7ud8ObhrT7tDDUi7BYonHwViI+skOrYLZW4W
         mzxA+Rx4dCiX2c0PHu7e/qz6X5lkxaRJPWjA80JY9giqgL4MU15MfG82GXwH7KMlUwaO
         xk0eMrukay+qREKKRpVBnxnSjNK6tgSA6UoJPRPsUS+zydF/g6bJBkR5KBTmUcWWRWVK
         DQm0ogKvpMyOjSRuDLNJKsyx5P9VEdBU6RDMSVc+P9vLr4ZCn9oPaWG8dT7pQJr0l4jB
         JIJOjQ/wFhtpO/PdK+ys7jv+7me8vBtG1zILouoAHY3RBA+2pLKGZxsD/UBVmafyKCwC
         2d/Q==
X-Gm-Message-State: AKS2vOxQfHxATWnN3krC2dAOuxlKRpwX02qeBsAqYMFG5vKzHtBZkvGs
        bw0+bBYDO+zcBg==
X-Received: by 10.99.125.9 with SMTP id y9mr4857990pgc.76.1497569038615;
        Thu, 15 Jun 2017 16:23:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id y8sm638445pge.0.2017.06.15.16.23.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 16:23:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170614102427.5220-1-phillip.wood@talktalk.net>
        <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Jun 2017 16:23:57 -0700
In-Reply-To: <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 15 Jun 2017 16:05:42 -0700")
Message-ID: <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood@talktalk.net> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> I've revised the second two tests as Johannes suggested to drop the
>> sed script. The first one is unchanged.
>>
>> Phillip Wood (3):
>>   rebase -i: Add test for reflog message
>>   rebase: Add regression tests for console output
>>   rebase: Add more regression tests for console output
>>
>>  t/t3404-rebase-interactive.sh |   7 +++
>>  t/t3420-rebase-autostash.sh   | 138 ++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 141 insertions(+), 4 deletions(-)
>
> Thanks (and thanks for Dscho for reading it over).
>
> Unfortunately this breaks unless your shell is bash (I didn't have
> time to look further into it), i.e. "make SHELL_PATH=/bin/dash test"

This is the bash-ism that broke it, I think.

    create_expected_success_interactive() {
            cr=$'\r' &&
            cat >expected <<-EOF

