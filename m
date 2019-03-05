Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE3C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCEXst (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:48:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50470 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCEXst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:48:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so4204868wmj.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tw14JouTIN1hc4ssvrvu+7yW3I41SLmDBoOjQrlwfnA=;
        b=tLki8g58Do82XSbxin46Gs/7HL8zN14IjHN3s2Ofbp3p/oSgR57HVaVYyfE1W7+yGm
         YyaKgN9Pe/HUGMgPTAy4zaeZlYVs/Icli9/wX2mKZ6dlvaeZX0uqBh54xTmKYpkDRfM6
         +GGT2olMEq4phne+tJm37cMYEplBMl9MrK1cBFKFIM80kGTtVPNHigwAUZ3FMYGHyrkR
         FqZiTeg6+GbhJuhVOpmXb3jAn4t2AXlQlnZcfK9PRUraWhSK2EhKjgrzo3G5BZDTOnJ8
         tQRJTfFIYUF8PNl9FJUfq6hmCqVqn4AyzI32AoJ8CuAocXOQHOk3IAG1gWZoO96Sh4Js
         7seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tw14JouTIN1hc4ssvrvu+7yW3I41SLmDBoOjQrlwfnA=;
        b=Zl4iIav44cxrJ7zJ4CcsfNxlVfW9LACnQpGnDIhO/g3WdBf2dpM50HEfOUk5CNcvgB
         i8IslhwdWPqz9KcdqMUiiI0cjzovcY8/fSeZzNIc6a2b4FQoyHeSEeyYFCrdjSkDHKG2
         lI5ti0c+lXRjgUia6Nv4qjHv1PKElQ5f1wZ+YPPtZBV3wUpuywd+iInOYg1RmrjCVfu9
         B6vH8plbsCdsUsSX1Cq8wg4YNtgxvQn7bagQIDL6Y7DCEBxUhhkqhUpHxkuabG1VdqSX
         1JPwC1Rq3xvxs0Xg2XLTTob4RCftdPKstrYom1dLlXj1XpZHIy/MBo5N3mEkadjUSoX8
         X70Q==
X-Gm-Message-State: APjAAAX17wBXQEzEfXyISixRxtnpHEbUYZ1BykWieiW6KnoTcoCi5hgt
        906LNWh2RM4RzGc/tKClYKQ=
X-Google-Smtp-Source: APXvYqyd+bsoM1sWQpj9FciZL+W7SOh638NxKJo5Ip3iPOaTC49Nlhtkw+YSaV/I9EGbAQfqZ/en3Q==
X-Received: by 2002:a1c:be01:: with SMTP id o1mr568619wmf.60.1551829727309;
        Tue, 05 Mar 2019 15:48:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a204sm152421wmf.12.2019.03.05.15.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 15:48:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] remote-curl: mark all error messages for translation
References: <pull.157.git.gitgitgadget@gmail.com>
        <xmqqtvggsx6c.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 06 Mar 2019 08:48:46 +0900
In-Reply-To: <xmqqtvggsx6c.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 06 Mar 2019 08:45:15 +0900")
Message-ID: <xmqqmum8sx0h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> As suggested by Jeff King in a nearby thread.
>>
>> Johannes Schindelin (1):
>>   remote-curl: mark all error messages for translation
>
> Does this come on top or below the anonymize patch, or it does not
> matter which goes first?

OK, will pile on top of the anonymization thing.

Thanks.

>
>>
>>  remote-curl.c | 50 +++++++++++++++++++++++++-------------------------
>>  1 file changed, 25 insertions(+), 25 deletions(-)
>>
>>
>> base-commit: c1284b21f2436de24c9559fcc5f4badb04f47773
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-157%2Fdscho%2Fl10n-remote-curl-diag-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-157/dscho/l10n-remote-curl-diag-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/157
